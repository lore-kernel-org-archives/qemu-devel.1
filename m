Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10CCC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:52:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD892070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeSDbpC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD892070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itZLw-0008Ir-Nx
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itZKR-0007ER-D6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itZKL-0002xI-Iv
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:51:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46191
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itZKL-0002xE-Eh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579535457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejPQtz/UW624Tv+8quf3JJdZo9SF044qhzOWJzL2E7Y=;
 b=UeSDbpC3LmqKrSSzAux/Jc1DnhAq7GiaX1/5ORoOcrVTgvK9G4BHcPZt37p1CxRgrwKIbV
 FgPyhKmM6B6fBosqufZB8cdvuIAmeWDjvTEDzgVKgLECmGam/ukYWR2pAok0BYkscMUNGq
 HlP5EBZSm7SyhVxn7Sj8qYr1Xz78A/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-vNWcxG_aNXGFugAdwlvLNg-1; Mon, 20 Jan 2020 10:50:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE91A10054E3;
 Mon, 20 Jan 2020 15:50:47 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48E4A8BE11;
 Mon, 20 Jan 2020 15:50:44 +0000 (UTC)
Date: Mon, 20 Jan 2020 15:50:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 091/104] libvhost-user: Fix some memtable remap cases
Message-ID: <20200120155041.GO2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-92-dgilbert@redhat.com>
 <CAJ+F1CKRGS_bzm=HXQrswE2nVvP-Nfur80YZK790nO-xkCNxcg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKRGS_bzm=HXQrswE2nVvP-Nfur80YZK790nO-xkCNxcg@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vNWcxG_aNXGFugAdwlvLNg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Dec 12, 2019 at 10:05 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > If a new setmemtable command comes in once the vhost threads are
> > running, it will remap the guests address space and the threads
> > will now be looking in the wrong place.
> >
> > Fortunately we're running this command under lock, so we can
> > update the queue mappings so that threads will look in the new-right
> > place.
> >
> > Note: This doesn't fix things that the threads might be doing
> > without a lock (e.g. a readv/writev!)  That's for another time.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/libvhost-user/libvhost-user.c | 33 ++++++++++++++++++++-------
> >  contrib/libvhost-user/libvhost-user.h |  3 +++
> >  2 files changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-u=
ser/libvhost-user.c
> > index 63e41062a4..b89bf18501 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -564,6 +564,21 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vms=
g)
> >      return false;
> >  }
> >
> > +static bool
> > +map_ring(VuDev *dev, VuVirtq *vq)
> > +{
> > +    vq->vring.desc =3D qva_to_va(dev, vq->vra.desc_user_addr);
> > +    vq->vring.used =3D qva_to_va(dev, vq->vra.used_user_addr);
> > +    vq->vring.avail =3D qva_to_va(dev, vq->vra.avail_user_addr);
> > +
> > +    DPRINT("Setting virtq addresses:\n");
> > +    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> > +    DPRINT("    vring_used  at %p\n", vq->vring.used);
> > +    DPRINT("    vring_avail at %p\n", vq->vring.avail);
> > +
> > +    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
> > +}
> > +
> >  static bool
> >  vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
> >  {
> > @@ -767,6 +782,14 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vm=
sg)
> >          close(vmsg->fds[i]);
> >      }
> >
> > +    for (i =3D 0; i < dev->max_queues; i++) {
> > +        if (dev->vq[i].vring.desc) {
>=20
> The code usually checks for all (vq->vring.desc && vq->vring.used &&
> vq->vring.avail).
>=20
> Perhaps we should introduce a VQ_RING_IS_SET() macro?

I'd like to understand why? and what to do in the case only one was set?
In this case I'm intending to make sure that there's no old mapping left
in any of the 3.

> > +            if (map_ring(dev, &dev->vq[i])) {
> > +                vu_panic(dev, "remaping queue %d during setmemtable", =
i);
> > +            }
> > +        }
> > +    }
> > +
> >      return false;
> >  }
> >
> > @@ -853,18 +876,12 @@ vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *=
vmsg)
> >      DPRINT("    avail_user_addr:  0x%016" PRIx64 "\n", vra->avail_user=
_addr);
> >      DPRINT("    log_guest_addr:   0x%016" PRIx64 "\n", vra->log_guest_=
addr);
> >
> > +    vq->vra =3D *vra;
> >      vq->vring.flags =3D vra->flags;
> > -    vq->vring.desc =3D qva_to_va(dev, vra->desc_user_addr);
> > -    vq->vring.used =3D qva_to_va(dev, vra->used_user_addr);
> > -    vq->vring.avail =3D qva_to_va(dev, vra->avail_user_addr);
> >      vq->vring.log_guest_addr =3D vra->log_guest_addr;
> >
> > -    DPRINT("Setting virtq addresses:\n");
> > -    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
> > -    DPRINT("    vring_used  at %p\n", vq->vring.used);
> > -    DPRINT("    vring_avail at %p\n", vq->vring.avail);
> >
> > -    if (!(vq->vring.desc && vq->vring.used && vq->vring.avail)) {
> > +    if (map_ring(dev, vq)) {
> >          vu_panic(dev, "Invalid vring_addr message");
> >          return false;
> >      }
> > diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-u=
ser/libvhost-user.h
> > index 1844b6f8d4..5cb7708559 100644
> > --- a/contrib/libvhost-user/libvhost-user.h
> > +++ b/contrib/libvhost-user/libvhost-user.h
> > @@ -327,6 +327,9 @@ typedef struct VuVirtq {
> >      int err_fd;
> >      unsigned int enable;
> >      bool started;
> > +
> > +    /* Guest addresses of our ring */
> > +    struct vhost_vring_addr vra;
> >  } VuVirtq;
> >
> >  enum VuWatchCondtion {
> > --
> > 2.23.0
> >
> >
>=20
> Looks reasonable otherwise (assuming all running threads were flushed
> somehow by other means)

Yeh, well, that's a separate question - which I think there's room for
more caution over; but that is why there's a 'some' in the subject line.

Dave

> --=20
> Marc-Andr=E9 Lureau
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


