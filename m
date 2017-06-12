Received: from eggs.gnu.org ([2001:4830:134:3::10]:51363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKRqB-0004r8-Rm
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dKRq8-0000il-8o
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dKRq8-0000iO-00
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:05:16 -0400
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<2ff62b03-d71b-93c4-79bf-10682b229758@redhat.com>
	<20170605185815-mutt-send-email-mst@kernel.org>
	<e3c4defa-69ff-45db-dc7a-427dbb521c18@redhat.com>
	<20170608204207-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad8ca556-a650-499e-2e72-35e2350abf6c@redhat.com>
Date: Mon, 12 Jun 2017 18:05:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170608204207-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] allocation zone extensions for the firmware
 linker/loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: SeaBIOS devel list <SeaBIOS@seabios.org>, qemu devel list <qemu-devel@nongnu.org>, edk2-devel-ml01 <edk2-devel@ml01.01.org>, Kevin O'Connor <kevin@koconnor.net>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, "Jordan Justen (Intel address)" <jordan.l.justen@intel.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 08/06/2017 19:44, Michael S. Tsirkin wrote:
> On Tue, Jun 06, 2017 at 08:10:17PM +0200, Laszlo Ersek wrote:
>> On 06/05/17 18:02, Michael S. Tsirkin wrote:
>>> On Sat, Jun 03, 2017 at 09:36:23AM +0200, Laszlo Ersek wrote:
>>>> On 06/02/17 17:45, Laszlo Ersek wrote:
>>>>
>>>>> The patches can cause linker/loader breakage when old firmware is booted
>>>>> on new QEMU. However, that's no problem (it's nothing new), the next
>>>>> release of QEMU should bundle the new firmware binaries as always.
>>>>
>>>> Dave made a good point (which I should have realized myself, really!),
>>>> namely if you launch old fw on old qemu, then migrate the guest to a new
>>>> qemu and then reboot the guest on the target host, within the migrated
>>>> VM, things will break.
>>>>
>>>> So that makes this approach dead in the water.
>>>>
>>>> Possible mitigations I could think of:
>>>> - Make it machine type dependent. Complicated (we don't usually bind
>>>> ACPI generation to machine types) and wouldn't help existing devices.
>>>> - Let the firmware negotiate these extensions. Very complicated (new
>>>> fw-cfg files are needed for negotiation) and wouldn't help existing devices.
>>>
>>> This last option *shouldn't* be complicated. If it is something's wrong.
>>>
>>> Maybe we made a mistake when we added etc/smi/*features*.
>>>
>>> It's not too late to move these to etc/*features* for new
>>> machine types if we want to and if you can do the firmware
>>> work. Then you'd just take out a bit and be done with it.
>>>
>>> I don't insist on doing the ACPI thing now but I do think
>>> infrastructure for negotiating extensions should be there.
>>
>> Different drivers in the firmware would need to negotiate different
>> questions / features with QEMU independently of each other. The "thing"
>> in OVMF that negotiates (and uses) the SMI broadcast is very-very
>> different and separate from the "thing" in OVMF that handles the ACPI
>> linker/loader script.
> 
> They both could call a common library.
> 
> Also, we don't need separate fw cfg files - we could
> reserve ranges of bits in a single file.
> E.g. bits 0-31 - smi, 32-63 - tseg, etc.

TSEG size is an integer, not a boolean...

Paolo
