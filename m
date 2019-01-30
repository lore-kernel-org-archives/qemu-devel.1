Received: from eggs.gnu.org ([209.51.188.92]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gokQi-0006hv-Ny
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:37:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gokQh-0008Gi-Uq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:37:04 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87y378n5iy.fsf@dusky.pond.sub.org>
	<CAFEAcA9b+7m1hL9atdm2_0fq66HPGWDhpAfZCRfPbegr2hKyGg@mail.gmail.com>
	<20190128124027.776wwcqrckalvr7x@sirius.home.kraxel.org>
	<CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
Date: Wed, 30 Jan 2019 08:36:47 +0100
In-Reply-To: <CAFEAcA-jwBhBXQb-SHT=b_Vy5Sq+M2iaMP2XtVn_2HQvzaEoVQ@mail.gmail.com>
	(Peter Maydell's message of "Mon, 28 Jan 2019 13:06:34 +0000")
Message-ID: <87wommmwa8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

Peter Maydell <peter.maydell@linaro.org> writes:

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

No argument.

> (Migration compat is left as an exercise for the reader :-))

It's not just migration compatibility, it's also guest ABI: "the guest
can tell the difference".  So, old machine types continue to get two
flash devices, and new machine types get one.  In other words, we're
stuck maintaining (a) even if we decide to switch to (b).

By itself, not an argument against doing the right thing for new machine
types.  It's an argument for trying harder doing the right thing from
the start next time.

I'm not sure whether doing the right thing now is worthwhile from a
practical point of view.

I figure the need for a region-capable flash device model may well come
up again in contexts other than PC firmware.  Perhaps we should discount
the cost of creating it when weighing the tradeoff for PC.
