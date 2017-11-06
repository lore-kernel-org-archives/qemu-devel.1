Received: from eggs.gnu.org ([2001:4830:134:3::10]:59439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eBkcW-0001iK-Ta
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eBkcU-0000bw-BQ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eBkcU-0000as-19
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 11:51:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C43FC04B924
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 16:51:28 +0000 (UTC)
Date: Mon, 6 Nov 2017 18:51:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171106184056-mutt-send-email-mst@kernel.org>
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
	<1509693637.31823.7.camel@redhat.com>
	<CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
	<20171103170426-mutt-send-email-mst@kernel.org>
	<CABdb734DG_itxuUjCiANz_ps+j5EdJj287HXrd8Xa_akyGAsaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABdb734DG_itxuUjCiANz_ps+j5EdJj287HXrd8Xa_akyGAsaA@mail.gmail.com>
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
To: Ladi Prosek <lprosek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Vadim Rozenfeld <vrozenfe@redhat.com>

On Mon, Nov 06, 2017 at 10:02:54AM +0100, Ladi Prosek wrote:
> On Fri, Nov 3, 2017 at 4:11 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Fri, Nov 03, 2017 at 09:23:07AM +0100, Ladi Prosek wrote:
> >> On Fri, Nov 3, 2017 at 8:20 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >> >
> >> >> > > Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> >> >> >
> >> >> > I wonder whether it's a problem that legacy devices ignore
> >> >> > the subsystem ID (that's part of spec).
> >> >>
> >> >> I don't understand this comment. I don't see anything in the spec
> >> >> related to ignoring the subsystem ID.
> >> >
> >> > Well, the subsystem *device* id is defined to be the virtio device id,
> >> > so it is certainly not ignored.  The subsystem *vendor* id is not used
> >> > as far I know (or ignored in the sense that it doesn't change driver
> >> > behavior), allowing to set that makes sense to me.
> >>
> >> Yes, thanks, I'm assuming that Michael meant the subsystem device ID.
> >> The PCI spec seems to be using "subsystem ID" for the name of this
> >> field.
> >
> > Exactly.
> >
> >> I understand that this ID must not change in legacy devices.
> >
> > Interestingly the device ID is ignored except it must be within
> > a specific range of values.
> >
> >> Interestingly, Windows appears to allow matching drivers only on the
> >> full subsystem device ID + subsystem vendor ID 32-bit value, not on
> >> only one of the two.
> >>
> >> PCI\VEN_v(4)&DEV_d(4)&SUBSYS_s(4)n(4)&REV_r(2)
> >>
> >> This might be a potential problem for a legacy driver that wants to
> >> stay vendor-agnostic but I'm pretty sure there would be a reasonable
> >> way of working around it. Actually, the device must use a designated
> >> device ID (like 0x1000) in addition to the subsystem device ID so this
> >> should be a non-issue altogether.
> >
> > The original virtio spec wasn't really workable for windows. It requires
> > ignoring everything except the vendor ID, *range* of device IDs
> > (specific ID is ignored) and subsystem ID.
> 
> The original spec has been superseded though, no? The current spec
> prescribes fixed device IDs for transitional devices (4.1.2.1 Device
> Requirements: PCI Device Discovery).

I agree, it's reasonable to ignore this part in the old spec.


> > So in my humble opinion the right thing for people to do is simply to
> > avoid legacy devices. Is something preventing that?
> 
> The same reasons why the concept of transitional devices exists at all?

It's there to support old drivers. If you are changing vendor id
that is supposedly so you can ship new drivers.

> Anyway, I'm not quite sure why we're spending so much time discussing
> this. The spec says "subsystem vendor MAY change". QEMU has this
> unfortunate statement which makes it not as straightforward as it
> should be. Removing the statement has zero impact on QEMU behavior. So
> we either remove it now or whoever actually needs to change the
> subsystem vendor ID will do it.

I am fine with your patch as such, but I just realized that anyone
tweaking subsystem vendor id in the past will get a different value now.

Worth worrying about or do we need to make it depend on
a machine type?


> >> > Possibly not only for virtio devices, most pci devices have 1af4:1100
> >> > as subsystem id, other vendors might want set it too for consistency.
> >> >
> >> > cheers,
> >> >   Gerd
