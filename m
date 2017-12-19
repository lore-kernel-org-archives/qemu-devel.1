Received: from eggs.gnu.org ([2001:4830:134:3::10]:43867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eRDiz-0002Ob-9n
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eRDiv-0000XQ-Bw
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:58:09 -0500
Received: from mail-am5eur02hn0249.outbound.protection.outlook.com
	([104.47.4.249]:54117
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eRDiu-0000W5-JH
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:58:05 -0500
Date: Tue, 19 Dec 2017 11:57:46 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171219085746.GA18391@rkaganb.sw.ru>
References: <1513350170-20168-1-git-send-email-den@openvz.org>
	<1513350170-20168-3-git-send-email-den@openvz.org>
	<20171218133812.GD16653@stefanha-x1.localdomain>
	<2B67BF1C-6489-4A9B-BEE5-08DE9B904C07@intel.com>
	<5E82066E-45E4-4627-8EB5-F995FFCB1ADF@nutanix.com>
	<674cef25-a411-354e-aaa5-83f382f42189@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <674cef25-a411-354e-aaa5-83f382f42189@openvz.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: fix IO request length in
 virtio SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>
Cc: Felipe Franciosi <felipe@nutanix.com>, "Harris, James R" <james.r.harris@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Liu,	Changpeng" <changpeng.liu@intel.com>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 18, 2017 at 10:42:35PM +0300, Denis V. Lunev wrote:
> On 12/18/2017 10:35 PM, Felipe Franciosi wrote:
> >> On 18 Dec 2017, at 16:16, Harris, James R <james.r.harris@intel.com> w=
rote:
> >>> On Dec 18, 2017, at 6:38 AM, Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
> >>> On Fri, Dec 15, 2017 at 06:02:50PM +0300, Denis V. Lunev wrote:
> >>>> diff --git a/include/hw/compat.h b/include/hw/compat.h
> >>>> index 026fee9..b9be5d7 100644
> >>>> --- a/include/hw/compat.h
> >>>> +++ b/include/hw/compat.h
> >>>> @@ -2,6 +2,23 @@
> >>>> #define HW_COMPAT_H
> >>>>
> >>>> #define HW_COMPAT_2_11 \
> >>>> +    {\
> >>>> +        .driver   =3D "virtio-blk-device",\
> >>>> +        .property =3D "max_segments",\
> >>>> +        .value    =3D "126",\
> >>>> +    },{\
> >>>> +        .driver   =3D "vhost-scsi",\
> >>>> +        .property =3D "max_segments",\
> >>>> +        .value    =3D "126",\
> >>>> +    },{\
> >>>> +        .driver   =3D "vhost-user-scsi",\
> >>>> +        .property =3D "max_segments",\
> >>>> +        .value    =3D "126",\
> >>> Existing vhost-user-scsi slave programs might not expect up to 1022
> >>> segments.  Hopefully we can get away with this change since there are
> >>> relatively few vhost-user-scsi slave programs.
> >>>
> >>> CCed Felipe (Nutanix) and Jim (SPDK) in case they have comments.
> >> SPDK vhost-user targets only expect max 128 segments.  They also pre-a=
llocate I/O task structures when QEMU connects to the vhost-user device.
> >>
> >> Supporting up to 1022 segments would result in significantly higher me=
mory usage, reduction in I/O queue depth processed by the vhost-user target=
, or having to dynamically allocate I/O task structures - none of which are=
 ideal.
> >>
> >> What if this was just bumped from 126 to 128?  I guess I=E2=80=99m try=
ing to understand the level of guest and host I/O performance that is gaine=
d with this patch.  One I/O per 512KB vs. one I/O per 4MB - we are still on=
ly talking about a few hundred IO/s difference.
> > SeaBIOS also makes the assumption that the queue size is not bigger tha=
n 128 elements.
> > https://review.coreboot.org/cgit/seabios.git/tree/src/hw/virtio-ring.h#=
n23
> >
> > Perhaps a better approach is to make the value configurable (ie. add th=
e "max_segments" property), but set the default to 128-2. In addition to wh=
at Jim pointed out, I think there may be other legacy front end drivers whi=
ch can assume the ring will be at most 128 entries in size.
> >
> > With that, hypervisors can choose to bump the value higher if it's know=
n to be safe for their host+guest configuration.
>=20
> This should not be a problem at all IMHO. The guest is not obliged
> to use the message of entire possible size. The guest initiates
> request with 128 elements. Fine. QEMU is ready to this.

QEMU is, but vhost-user slaves may not be.  And there seems to be no
vhost-user protocol message type that would allow to negotiate this
value between the master and the slave.

So apparently the default for vhost-user-scsi has to stay the same in
order not to break existing slaves.  I guess having it tunable via a
property may still turn out useful.

Roman.
