Received: from eggs.gnu.org ([2001:4830:134:3::10]:48767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dXN2v-0004Fs-JB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1dXN2s-00073K-F4
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:35:53 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:57242
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1dXN2s-0006X5-6d
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:35:50 -0400
References: <1497462353-3432-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-iWRqhNhrJsrvODRunkwMGTUsTMfhdHZw3aCjoc3p1Mg@mail.gmail.com>
	<CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <bb8781a1-602b-d77d-a103-6f8d23d7ff5f@adacore.com>
Date: Tue, 18 Jul 2017 09:34:23 +0200
MIME-Version: 1.0
In-Reply-To: <CAJy5ezpvpohU5x48WrKz57k9+s39hkSCUm+f_u2qf7E0Zin7Mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v1 0/7] MMIO Exec pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>



On 07/17/2017 07:27 PM, Edgar E. Iglesias wrote:
> On Mon, Jul 17, 2017 at 11:33 PM, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> 
>> On 14 June 2017 at 18:45, Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> wrote:
>>> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>>> Paolo suggested offline that we send a pull request for this series.
>>> Here it is, I've run it through my testsuite + tested the LQSPI testcase
>>> on Zynq.
>>
>>> ----------------------------------------------------------------
>>> mmio-exec.for-upstream
>>>
>>> ----------------------------------------------------------------
>>> KONRAD Frederic (7):
>>>        cputlb: cleanup get_page_addr_code to use VICTIM_TLB_HIT
>>>        cputlb: move get_page_addr_code
>>>        cputlb: fix the way get_page_addr_code fills the tlb
>>>        qdev: add MemoryRegion property
>>>        introduce mmio_interface
>>>        exec: allow to get a pointer for some mmio memory region
>>>        xilinx_spips: allow mmio execution
>>
>> Hi Edgar -- can you or Fred explain how this code interacts with
>> VM migration? The mmio-interface device creates a RAM memory
>> region with memory_region_init_ram_ptr(), but it doesn't call
>> vmstate_register_ram(). On the other hand the core migration code
>> will try to migrate the contents of the RAMBlock anyway, just
>> without a name.
>>
>> It's not clear to me how this works, and it would be nice to
>> get it clear so that we can make any necessary fixes before the
>> 2.10 release hits and we lose the opportunity to make any
>> migration-compatibility-breaking changes.
>>
>> thanks
>> -- PMM
>>
> 
> Hi Peter,
> 
> These temporary regions should be read-only and treated as temporary caches
> AFAIU things.
> I would say that they don't need to be migrated. After migration, the new
> VM will recreate the ram areas from device backing.
> 
> Is there a way we can prevent migration of the RAMBlock?
> 
> Cheers,
> Edgar
> 

Hi All,

Yes Edgar is right, they don't need to be migrated (as the old
Xilinx SPI cache).
And it will be the case for all the other stuff using this as
well.

Maybe we can simply drop the region before the migration?

Fred
