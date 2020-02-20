Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40084C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBBE218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBBE218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6UZP-0002KR-59
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39467)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j6UYf-0001tT-Om
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j6UYd-0002Zd-G3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:23:08 -0500
Received: from [192.146.154.243] (port=30916 helo=mcp01.nutanix.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <raphael.norwitz@nutanix.com>) id 1j6UYd-0002XD-8O
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:23:07 -0500
Received: from localhost.localdomain (unknown [10.40.36.165])
 by mcp01.nutanix.com (Postfix) with ESMTP id A5B7A1008443;
 Tue, 25 Feb 2020 07:23:03 +0000 (UTC)
Date: Thu, 20 Feb 2020 02:03:08 -0500
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 3/3] Lift max memory slots limit imposed by vhost-user
Message-ID: <20200220070308.GA2215@localhost.localdomain>
References: <1579143426-18305-1-git-send-email-raphael.norwitz@nutanix.com>
 <1579143426-18305-4-git-send-email-raphael.norwitz@nutanix.com>
 <20200206032332-mutt-send-email-mst@kernel.org>
 <20200209174335.GA15050@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200209174335.GA15050@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.146.154.243
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping

On Sun, Feb 09, 2020 at 12:43:35PM -0500, Raphael Norwitz wrote:
>=20
> On Thu, Feb 06, 2020 at 03:32:38AM -0500, Michael S. Tsirkin wrote:
> >=20
> > On Wed, Jan 15, 2020 at 09:57:06PM -0500, Raphael Norwitz wrote:
> > > The current vhost-user implementation in Qemu imposes a limit on th=
e
> > > maximum number of memory slots exposed to a VM using a vhost-user
> > > device. This change provides a new protocol feature
> > > VHOST_USER_F_CONFIGURE_SLOTS which, when enabled, lifts this limit =
and
> > > allows a VM with a vhost-user device to expose a configurable numbe=
r of
> > > memory slots, up to the ACPI defined maximum. Existing backends whi=
ch
> > > do not support this protocol feature are unaffected.
> >=20
> > Hmm ACPI maximum seems to be up to 512 - is this too much to fit in a
> > single message?  So can't we just increase the number (after negotiat=
ing
> > with remote) and be done with it, instead of add/remove?  Or is there
> > another reason to prefer add/remove?
> >
>=20
> As mentioned in my cover letter, we experimented with simply increasing=
 the
> message size and it didn=E2=80=99t work on our setup. We debugged down =
to the socket
> layer and found that on the receiving end the messages were truncated a=
t
> around 512 bytes, or around 16 memory regions.=C2=A0To support 512 memo=
ry regions
> we would need a message size of around=C2=A0=C2=A032 <bytes per region>=
 * 512 <regions>
> + 8 <bytes for padding and region count> ~=3D 16k packet size. That wou=
ld be 64
> times larger than the next largest message size. We thought it would be=
 cleaner
> and more in line with the rest of the protocol to keep the message size=
s
> smaller. In particular, we thought memory regions should be treated lik=
e the
> rings, which are sent over one message at a time instead of in one larg=
e message.
> Whether or not such a large message size can be made to work in our cas=
e,
> separate messages will always work on Linux, and most likely all other =
UNIX
> platforms QEMU is used on.
>=20

> > >=20
> > > This feature works by using three new messages,
> > > VHOST_USER_GET_MAX_MEM_SLOTS, VHOST_USER_ADD_MEM_REG and
> > > VHOST_USER_REM_MEM_REG. VHOST_USER_GET_MAX_MEM_SLOTS gets the
> > > number of memory slots the backend is willing to accept when the
> > > backend is initialized. Then, when the memory tables are set or upd=
ated,
> > > a series of VHOST_USER_ADD_MEM_REG and VHOST_USER_REM_MEM_REG messa=
ges
> > > are sent to transmit the regions to map and/or unmap instead of try=
ing
> > > to send all the regions in one fixed size VHOST_USER_SET_MEM_TABLE
> > > message.
> > >=20
> > > The vhost_user struct maintains a shadow state of the VM=E2=80=99s =
memory
> > > regions. When the memory tables are modified, the
> > > vhost_user_set_mem_table() function compares the new device memory =
state
> > > to the shadow state and only sends regions which need to be unmappe=
d or
> > > mapped in. The regions which must be unmapped are sent first, follo=
wed
> > > by the new regions to be mapped in. After all the messages have bee=
n
> > > sent, the shadow state is set to the current virtual device state.
> > >=20
> > > The current feature implementation does not work with postcopy migr=
ation
> > > and cannot be enabled if the VHOST_USER_PROTOCOL_F_REPLY_ACK featur=
e has
> > > also been negotiated.
> >=20
> > Hmm what would it take to lift the restrictions?
> > conflicting features like this makes is very hard for users to make
> > an informed choice what to support.
> >
>=20
> We would need a setup with a backend which supports these features (REP=
LY_ACK
> and postcopy migration). At first glance it looks like DPDK could work =
but
> I'm not sure how easy it will be to test postcopy migration with the re=
sources
> we have.
> =20

> > > Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> > > Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
> > > Suggested-by: Mike Cui <cui@nutanix.com>
> > > ---
> > > diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > index af83fdd..fed6d02 100644
> > > --- a/hw/virtio/vhost-user.c
> > > +++ b/hw/virtio/vhost-user.c
> > > @@ -35,11 +35,29 @@
> > >  #include <linux/userfaultfd.h>
> > >  #endif
> > > =20
> > > -#define VHOST_MEMORY_MAX_NREGIONS    8
> > > +#define VHOST_MEMORY_LEGACY_NREGIONS    8
> >=20
> > Hardly legacy when this is intended to always be used e.g. with
> > postcopy, right?
> >
>=20
> How about 'BASELINE'?

> > > +    msg->hdr.size =3D sizeof(msg->payload.mem_reg.padding);
> > > +    msg->hdr.size +=3D sizeof(VhostUserMemoryRegion);
> > > +
> > > +    /*
> > > +     * Send VHOST_USER_REM_MEM_REG for memory regions in our shado=
w state
> > > +     * which are not found not in the device's memory state.
> >=20
> > double negation - could not parse this.
> >
>=20
> Apologies - typo here. It should say =E2=80=9CSend VHOST_USER_REM_MEM_R=
EG for memory
> regions in our shadow state which are not found in the device's memory =
state.=E2=80=9D=20
> i.e. send messages to remove regions in the shadow state but not in the=
 updated
> device state.=20
> =20
> > > +     */
> > > +    for (i =3D 0; i < u->num_shadow_regions; ++i) {
> > > +        reg =3D dev->mem->regions;
> > > +
> > > +        for (j =3D 0; j < dev->mem->nregions; j++) {
> > > +            reg =3D dev->mem->regions + j;
> > > +
> > > +            assert((uintptr_t)reg->userspace_addr =3D=3D reg->user=
space_addr);
> > > +            mr =3D memory_region_from_host((void *)(uintptr_t)reg-=
>userspace_addr,
> > > +                                         &offset);
> > > +            fd =3D memory_region_get_fd(mr);
> > > +
> > > +            if (reg_equal(&u->shadow_regions[i], reg)) {
> > > +                matching =3D true;
> > > +                found[j] =3D true;
> > > +                break;
> > > +            }
> > > +        }
> > > +
> > > +        if (fd > 0 && !matching) {
> > > +            msg->hdr.request =3D VHOST_USER_REM_MEM_REG;
> > > +            msg->payload.mem_reg.region.userspace_addr =3D reg->us=
erspace_addr;
> > > +            msg->payload.mem_reg.region.memory_size =3D reg->memor=
y_size;
> > > +            msg->payload.mem_reg.region.guest_phys_addr =3D
> > > +                reg->guest_phys_addr;
> > > +            msg->payload.mem_reg.region.mmap_offset =3D offset;
> > > +
> > > +            if (vhost_user_write(dev, msg, &fd, 1) < 0) {
> > > +                return -1;
> > > +            }
> > > +        }
> > > +    }
> > > +

