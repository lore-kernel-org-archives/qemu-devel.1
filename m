Received: from eggs.gnu.org ([209.51.188.92]:51492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go8XD-0008LV-PG
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 10:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1go8KX-0003yN-8B
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:56:10 -0500
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
	<CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5daf9f5e-cbda-8642-f4f6-46939fe223d1@redhat.com>
Date: Mon, 28 Jan 2019 15:55:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] Configuring pflash devices for OVMF
 firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Libvirt <libvir-list@redhat.com>, Peter Krempa <pkrempa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 01/28/19 14:06, Peter Maydell wrote:
> On Mon, 28 Jan 2019 at 12:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> The tricky part is the access control here.  On physical hardware you
>> typically have one flash rom, say 16M below 4G (on x86).
>>
>> Our pflash device doesn't allow to define multiple regions, so we use
>> multiple pflash devices instead, each with different access permissions
>> (code vs. vars).  Because of that they are more dynamic than they are on
>> phyiscal hardware, x86 sizes them according to the size of the firmware
>> images (arm is easier here, we have fixed size and location no matter
>> how big the firmware images are).
>>
>> So I think the options we have are:
>>   (a) leave pflash as-is, which pretty much implies physaddr and size
>>       must be user-configurable.
>>   (b) add support for multiple regions to pflash, so one can attach
>>       multiple blockdev at different offsets to a single pflash device.
> 
> The latter makes more sense to me -- we should model what the
> hardware actually has, because the guest can tell the difference.

Regarding OVMF, I kept the flash driver intentionally in the dark about
split vs. unified pflash, so OVMF will not care, as long as the same
GPAs behave the same as before.

Regarding ArmVirtQemu, I'm not so sure. It think it already depends on
two separate pflash chips, through the DTB that QEMU exposes. So
unifying the chips (albeit with multiple regions) might actually confuse
the firmware. I'm CC'ing Ard, he's done some work on the ARM NOR flash
driver recently, incl. updates to its usage in ArmVirtQemu:

* https://github.com/tianocore/edk2/commit/5e27deed438b

  [edk2] [PATCH v2 3/4]
  ArmVirtPkg/NorFlashQemuLib: disregard our primary FV

* https://github.com/tianocore/edk2/commit/51bb05c79595

  [edk2] [PATCH v2 4/4]
  ArmVirtPkg/QemuVirtMemInfoLib: trim the MMIO region mapping

Thanks
Laszlo

> (Migration compat is left as an exercise for the reader :-))
> 
> thanks
> -- PMM
> 
