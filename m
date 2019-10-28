Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C020CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C9620862
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTL6V3mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP8kL-0007qE-MB
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iP7e6-0004tm-EB
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iP7e4-0000lh-I2
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:13:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iP7e3-0000kA-GM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 12:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572279205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cFQsNYzEETSQ4BodlxpIS4fiwhz6RtRomILuB6zbP4=;
 b=JTL6V3mtEP8g9D1k5allLwJhO2zmhRkbunxH8F3frppsknpIZ8OegqsMLHnfXe4ZyR2ghq
 zgCuvW/bQHCf0ZNoUDq65cMHarUh2PcbcEaLO2jO7G58VOirQ40Ee0LTLp+X8VutdcHH8Y
 E0Nxf16EeR2cEZh3wg0j76a22yAnYmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-p5rZ0SJ7OKy88rwlx0f9FA-1; Mon, 28 Oct 2019 12:13:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05F7D1005509
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 16:13:19 +0000 (UTC)
Received: from work-vm (ovpn-116-216.ams2.redhat.com [10.36.116.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCF7C5D6C5;
 Mon, 28 Oct 2019 16:13:04 +0000 (UTC)
Date: Mon, 28 Oct 2019 16:13:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virito: Use auto rcu_read macros
Message-ID: <20191028161300.GD2961@work-vm>
References: <20191014175440.152609-1-dgilbert@redhat.com>
 <20191025075225-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20191025075225-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: p5rZ0SJ7OKy88rwlx0f9FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Mon, Oct 14, 2019 at 06:54:40PM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
> > to replace the manual rcu_read_(un)lock calls.
> >=20
> > I think the only change is virtio_load which was missing unlocks
> > in error paths; those end up being fatal errors so it's not
> > that important anyway.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> Can you rebase on top of packed ring support please?
> They are in my queue now.

Sent; fixed up in about the same way but not tested much.

Dave

>=20
> > ---
> >  hw/virtio/virtio.c | 46 ++++++++++++++++------------------------------
> >  1 file changed, 16 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 527df03bfd..15ae9da60b 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -337,7 +337,7 @@ void virtio_queue_set_notification(VirtQueue *vq, i=
nt enable)
> >          return;
> >      }
> > =20
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      if (virtio_vdev_has_feature(vq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> >          vring_set_avail_event(vq, vring_avail_idx(vq));
> >      } else if (enable) {
> > @@ -349,7 +349,6 @@ void virtio_queue_set_notification(VirtQueue *vq, i=
nt enable)
> >          /* Expose avail event/used flags before caller checks the avai=
l idx. */
> >          smp_mb();
> >      }
> > -    rcu_read_unlock();
> >  }
> > =20
> >  int virtio_queue_ready(VirtQueue *vq)
> > @@ -393,9 +392,8 @@ int virtio_queue_empty(VirtQueue *vq)
> >          return 0;
> >      }
> > =20
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      empty =3D vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
> > -    rcu_read_unlock();
> >      return empty;
> >  }
> > =20
> > @@ -530,10 +528,9 @@ void virtqueue_flush(VirtQueue *vq, unsigned int c=
ount)
> >  void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
> >                      unsigned int len)
> >  {
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      virtqueue_fill(vq, elem, len, 0);
> >      virtqueue_flush(vq, 1);
> > -    rcu_read_unlock();
> >  }
> > =20
> >  /* Called within rcu_read_lock().  */
> > @@ -624,7 +621,7 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsig=
ned int *in_bytes,
> >          return;
> >      }
> > =20
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      idx =3D vq->last_avail_idx;
> >      total_bufs =3D in_total =3D out_total =3D 0;
> > =20
> > @@ -719,7 +716,6 @@ done:
> >      if (out_bytes) {
> >          *out_bytes =3D out_total;
> >      }
> > -    rcu_read_unlock();
> >      return;
> > =20
> >  err:
> > @@ -869,7 +865,7 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >      if (unlikely(vdev->broken)) {
> >          return NULL;
> >      }
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      if (virtio_queue_empty_rcu(vq)) {
> >          goto done;
> >      }
> > @@ -977,7 +973,6 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
> >      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
> >  done:
> >      address_space_cache_destroy(&indirect_desc_cache);
> > -    rcu_read_unlock();
> > =20
> >      return elem;
> > =20
> > @@ -1680,13 +1675,10 @@ static bool virtio_should_notify(VirtIODevice *=
vdev, VirtQueue *vq)
> > =20
> >  void virtio_notify_irqfd(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> > -    bool should_notify;
> > -    rcu_read_lock();
> > -    should_notify =3D virtio_should_notify(vdev, vq);
> > -    rcu_read_unlock();
> > -
> > -    if (!should_notify) {
> > -        return;
> > +    WITH_RCU_READ_LOCK_GUARD() {
> > +        if (!virtio_should_notify(vdev, vq)) {
> > +            return;
> > +        }
> >      }
> > =20
> >      trace_virtio_notify_irqfd(vdev, vq);
> > @@ -1718,13 +1710,10 @@ static void virtio_irq(VirtQueue *vq)
> > =20
> >  void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> > -    bool should_notify;
> > -    rcu_read_lock();
> > -    should_notify =3D virtio_should_notify(vdev, vq);
> > -    rcu_read_unlock();
> > -
> > -    if (!should_notify) {
> > -        return;
> > +    WITH_RCU_READ_LOCK_GUARD() {
> > +        if (!virtio_should_notify(vdev, vq)) {
> > +            return;
> > +        }
> >      }
> > =20
> >      trace_virtio_notify(vdev, vq);
> > @@ -2241,7 +2230,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, =
int version_id)
> >          vdev->start_on_kick =3D true;
> >      }
> > =20
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      for (i =3D 0; i < num; i++) {
> >          if (vdev->vq[i].vring.desc) {
> >              uint16_t nheads;
> > @@ -2289,7 +2278,6 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, =
int version_id)
> >              }
> >          }
> >      }
> > -    rcu_read_unlock();
> > =20
> >      return 0;
> >  }
> > @@ -2422,21 +2410,19 @@ void virtio_queue_set_last_avail_idx(VirtIODevi=
ce *vdev, int n, uint16_t idx)
> > =20
> >  void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
> >  {
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].last_avail_idx =3D vring_used_idx(&vdev->vq[n]);
> >          vdev->vq[n].shadow_avail_idx =3D vdev->vq[n].last_avail_idx;
> >      }
> > -    rcu_read_unlock();
> >  }
> > =20
> >  void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
> >  {
> > -    rcu_read_lock();
> > +    RCU_READ_LOCK_GUARD();
> >      if (vdev->vq[n].vring.desc) {
> >          vdev->vq[n].used_idx =3D vring_used_idx(&vdev->vq[n]);
> >      }
> > -    rcu_read_unlock();
> >  }
> > =20
> >  void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
> > --=20
> > 2.23.0
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


