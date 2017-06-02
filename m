Received: from eggs.gnu.org ([2001:4830:134:3::10]:57304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvFB-0001v7-0O
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:40:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGvF7-0007q9-RW
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:40:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGvF7-0007og-I7
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 18:40:29 -0400
References: <20170601112241.2580-1-ard.biesheuvel@linaro.org>
	<ccc0e728-0348-e386-6f71-0c1c69eaa01d@redhat.com>
	<e3a61707-2356-7ad3-0efc-e7d0c4115eea@redhat.com>
	<1496415382.16895.4.camel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <eb98217b-5559-51a0-0e42-559b85b5fba7@redhat.com>
Date: Sat, 3 Jun 2017 00:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <1496415382.16895.4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] OvmfPkg/AcpiPlatformDxe: lift 4 GB
 alloc limit for modern ACPI systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, edk2-devel@lists.01.org
Cc: leif.lindholm@linaro.org, jordan.l.justen@intel.com, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>, Drew Jones <drjones@redhat.com>

On 06/02/17 16:56, Gerd Hoffmann wrote:
>   Hi,
> 
>>  The reason is that old firmware is allowed to fail on new QEMU
>> (regardless of machine type). Example: the WRITE_POINTER command,
>> originally introduced for VMGENID. If you run a SeaBIOS binary
>> without
>> WRITE_POINTER support, in a QEMU VM with "-device vmgenid", the
>> device
>> will not work.
> 
> Old seabios will work just fine on new qemu as long as you don't use
> the vmgenid device.
> 
> Only when using new features (which require firmware support) new
> seabios is needed, and usually we update seabios for that reason.  We
> want the new features be usable of course.  But in general there are no
> lockstep updates for qemu and seabios (any more).
> 
>> And this patch is actually that case, because the new fw would
>> allocate
>> blobs with such 8-byte addresses that might not fit into 32-bit blob
>> fields.
> 
> I think ovmf simply checking whenever the pointer fields are 32bit or
> 64bit, then doing allocations accordingly (as Igor suggested) would be
> the best.  Why ask qemu for a hint when ovmf can figure on its own?
> That adds a new interface and new config knobs for IMO no good reason.

There is a good reason: the reason is that OVMF should not be forced to
reverse-engineer such information with a third, separate pass over the
linker/loader script, adding yet more complexity.

The linker/loader interface was designed for SeaBIOS, without any regard
to OVMF / ArmVirtQemu. For example, SeaBIOS gets hints like HIGH vs.
FSEG (which distinction is irrelevant for OVMF / ArmVirtQemu) despite
the fact that SeaBIOS could also figure that out one way or another if
it really wanted to. OVMF / ArmVirtQemu need different kinds of hints,
and I think they should get them at this point.

Even now, OVMF deduces the starts of individual ACPI tables in the blobs
by using somewhat messy heuristics. (OVMF *must* know where the tables
start.) The heuristics incur no false negatives, but a chance exists for
false positives, unless QEMU takes extra precautions. But Igor happens
to hate those precautions, and the TCPA and NVDIMM authors have
completely missed them. So we should have fewer of these heuristics and
workarounds, not more.

And, as I replied to Igor earlier, the other blob allocation hint (the
"no ACPI content" hint that allows QEMU to drop precisely the above
obscure precautions, i.e. the "ACPI SDT header probe suppressor"),
necessitates extending the ALLOCATE command anyway.

Would it help if I made these extensions dependent on 2.10+ machine
types? (Obviously existing generators like TCPA, NVDIMM and VMGENID
would not be modified then, because the old stuff would have to be
preserved for old machine types anyway.)

Thanks
Laszlo
