Received: from eggs.gnu.org ([2001:4830:134:3::10]:44600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eAXFw-0003A5-0b
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eAXFs-0007BJ-TJ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:23:12 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:51081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eAXFs-00079s-Oi
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:23:08 -0400
Received: by mail-vk0-f48.google.com with SMTP id h142so1264873vkf.7
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509693637.31823.7.camel@redhat.com>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
	<1509693637.31823.7.camel@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Fri, 3 Nov 2017 09:23:07 +0100
Message-ID: <CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>

On Fri, Nov 3, 2017 at 8:20 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>> > > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> >
>> > I wonder whether it's a problem that legacy devices ignore
>> > the subsystem ID (that's part of spec).
>>
>> I don't understand this comment. I don't see anything in the spec
>> related to ignoring the subsystem ID.
>
> Well, the subsystem *device* id is defined to be the virtio device id,
> so it is certainly not ignored.  The subsystem *vendor* id is not used
> as far I know (or ignored in the sense that it doesn't change driver
> behavior), allowing to set that makes sense to me.

Yes, thanks, I'm assuming that Michael meant the subsystem device ID.
The PCI spec seems to be using "subsystem ID" for the name of this
field. I understand that this ID must not change in legacy devices.

Interestingly, Windows appears to allow matching drivers only on the
full subsystem device ID + subsystem vendor ID 32-bit value, not on
only one of the two.

PCI\VEN_v(4)&DEV_d(4)&SUBSYS_s(4)n(4)&REV_r(2)

This might be a potential problem for a legacy driver that wants to
stay vendor-agnostic but I'm pretty sure there would be a reasonable
way of working around it. Actually, the device must use a designated
device ID (like 0x1000) in addition to the subsystem device ID so this
should be a non-issue altogether.

> Possibly not only for virtio devices, most pci devices have 1af4:1100
> as subsystem id, other vendors might want set it too for consistency.
>
> cheers,
>   Gerd
