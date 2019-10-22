Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B349921783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUoT70SC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B349921783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrPj-0001bu-QV
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMrOn-0000Pn-0V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMrOl-00051J-If
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37649
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMrOl-000516-EM
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571740098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eyQEI26sexboWNDcL7MxvxQObzUF1F1HQz4KVUg4ioQ=;
 b=HUoT70SCQlmcZX1r4pjA8uLX3U/UGK+epAj9JFZ80WaOw7BqKNwzY0JjjhzTbDeKhotINV
 3YwgGjV8pe5w6QJ7hrpzTbxSC5oETL3+lWHYIHCBJFXWtU1esdABvKBr7WVSFX6bl5xIrJ
 KFEwXaKOzMNn3a7qwstFtX5Z8e9xCqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-eNTCoFB-OPCRjbYcKszhtQ-1; Tue, 22 Oct 2019 06:28:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B8E1801E52;
 Tue, 22 Oct 2019 10:28:14 +0000 (UTC)
Received: from work-vm (ovpn-117-248.ams2.redhat.com [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87667608A5;
 Tue, 22 Oct 2019 10:28:07 +0000 (UTC)
Date: Tue, 22 Oct 2019 11:28:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH 21/30] virtiofsd: Start reading commands from queue
Message-ID: <20191022102805.GE2815@work-vm>
References: <20191021105832.36574-1-dgilbert@redhat.com>
 <20191021105832.36574-22-dgilbert@redhat.com>
 <CAJ+F1CJ+P2Um+SGFu4dMoxcgWXTq3ZXqeTBjW01hgaJS3V2s-g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ+P2Um+SGFu4dMoxcgWXTq3ZXqeTBjW01hgaJS3V2s-g@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: eNTCoFB-OPCRjbYcKszhtQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 piaojun@huawei.com, Stefan Hajnoczi <stefanha@redhat.com>,
 eguan@linux.alibaba.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> On Mon, Oct 21, 2019 at 1:09 PM Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > Pop queue elements off queues, copy the data from them and
> > pass that to fuse.
> >
> >   Note: 'out' in a VuVirtqElement is from QEMU
> >         'in' in libfuse is into the daemon
> >
> >   So we read from the out iov's to get a fuse_in_header
> >
> > When we get a kick we've got to read all the elements until the queue
> > is empty.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  contrib/virtiofsd/fuse_i.h      |  2 +
> >  contrib/virtiofsd/fuse_virtio.c | 99 ++++++++++++++++++++++++++++++++-
> >  2 files changed, 98 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
> > index ea55f618a5..5b6ef09df5 100644
> > --- a/contrib/virtiofsd/fuse_i.h
> > +++ b/contrib/virtiofsd/fuse_i.h
> > @@ -14,6 +14,7 @@
> >  #include "fuse_lowlevel.h"
> >
> >  struct fv_VuDev;
> > +struct fv_QueueInfo;
> >
> >  struct fuse_req {
> >         struct fuse_session *se;
> > @@ -75,6 +76,7 @@ struct fuse_chan {
> >         pthread_mutex_t lock;
> >         int ctr;
> >         int fd;
> > +       struct fv_QueueInfo *qi;
> >  };
> >
> >  /**
> > diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_v=
irtio.c
> > index 0513531c13..e189511729 100644
> > --- a/contrib/virtiofsd/fuse_virtio.c
> > +++ b/contrib/virtiofsd/fuse_virtio.c
> > @@ -32,6 +32,7 @@
> >
> >  #include "contrib/libvhost-user/libvhost-user.h"
> >
> > +struct fv_VuDev;
> >  struct fv_QueueInfo {
> >      pthread_t thread;
> >      struct fv_VuDev *virtio_dev;
> > @@ -101,10 +102,42 @@ static void fv_panic(VuDev *dev, const char *err)
> >      exit(EXIT_FAILURE);
> >  }
> >
> > +/*
> > + * Copy from an iovec into a fuse_buf (memory only)
> > + * Caller must ensure there is space
> > + */
> > +static void copy_from_iov(struct fuse_buf *buf, size_t out_num,
> > +                          const struct iovec *out_sg)
> > +{
> > +    void *dest =3D buf->mem;
> > +
> > +    while (out_num) {
> > +        size_t onelen =3D out_sg->iov_len;
> > +        memcpy(dest, out_sg->iov_base, onelen);
> > +        dest +=3D onelen;
> > +        out_sg++;
> > +        out_num--;
> > +    }
> > +}
>=20
> Or iov_to_buf()

Is there a variant there that will copy the whole of an iovec?
I just tried swapping the copy_from_iov out, but it's messier to use
because it wants the bytes length; where in most cases I'm taking a
single element from the iovec, or the 'rest of the iovec' by element
count.

Dave

> Just found out that vhost-user-blk.c should probably link too with
> util/iov.o, instead of copying the code.
>=20
> > +
> >  /* Thread function for individual queues, created when a queue is 'sta=
rted' */
> >  static void *fv_queue_thread(void *opaque)
> >  {
> >      struct fv_QueueInfo *qi =3D opaque;
> > +    struct VuDev *dev =3D &qi->virtio_dev->dev;
> > +    struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
> > +    struct fuse_session *se =3D qi->virtio_dev->se;
> > +    struct fuse_chan ch;
> > +    struct fuse_buf fbuf;
> > +
> > +    fbuf.mem =3D NULL;
> > +    fbuf.flags =3D 0;
> > +
> > +    fuse_mutex_init(&ch.lock);
> > +    ch.fd =3D (int)0xdaff0d111;
> > +    ch.ctr =3D 1;
> > +    ch.qi =3D qi;
> > +
> >      fuse_log(FUSE_LOG_INFO, "%s: Start for queue %d kick_fd %d\n", __f=
unc__,
> >               qi->qidx, qi->kick_fd);
> >      while (1) {
> > @@ -141,11 +174,71 @@ static void *fv_queue_thread(void *opaque)
> >              fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
> >              break;
> >          }
> > -        if (qi->virtio_dev->se->debug) {
> > -            fprintf(stderr, "%s: Queue %d gave evalue: %zx\n", __func_=
_,
> > -                    qi->qidx, (size_t)evalue);
> > +        /* out is from guest, in is too guest */
> > +        unsigned int in_bytes, out_bytes;
> > +        vu_queue_get_avail_bytes(dev, q, &in_bytes, &out_bytes, ~0, ~0=
);
> > +
> > +        fuse_log(FUSE_LOG_DEBUG,
> > +                 "%s: Queue %d gave evalue: %zx available: in: %u out:=
 %u\n",
> > +                 __func__, qi->qidx, (size_t)evalue, in_bytes, out_byt=
es);
> > +
> > +        while (1) {
> > +            /*
> > +             * An element contains one request and the space to send o=
ur
> > +             * response They're spread over multiple descriptors in a
> > +             * scatter/gather set and we can't trust the guest to keep=
 them
> > +             * still; so copy in/out.
> > +             */
> > +            VuVirtqElement *elem =3D vu_queue_pop(dev, q, sizeof(VuVir=
tqElement));
> > +            if (!elem) {
> > +                break;
> > +            }
> > +
> > +            if (!fbuf.mem) {
> > +                fbuf.mem =3D malloc(se->bufsize);
> > +                assert(fbuf.mem);
> > +                assert(se->bufsize > sizeof(struct fuse_in_header));
> > +            }
> > +            /* The 'out' part of the elem is from qemu */
> > +            unsigned int out_num =3D elem->out_num;
> > +            struct iovec *out_sg =3D elem->out_sg;
> > +            size_t out_len =3D iov_length(out_sg, out_num);
> > +            fuse_log(FUSE_LOG_DEBUG,
> > +                     "%s: elem %d: with %d out desc of length %zd\n", =
__func__,
> > +                     elem->index, out_num, out_len);
> > +
> > +            /*
> > +             * The elem should contain a 'fuse_in_header' (in to fuse)
> > +             * plus the data based on the len in the header.
> > +             */
> > +            if (out_len < sizeof(struct fuse_in_header)) {
> > +                fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for in_h=
eader\n",
> > +                         __func__, elem->index);
> > +                assert(0); /* TODO */
> > +            }
> > +            if (out_len > se->bufsize) {
> > +                fuse_log(FUSE_LOG_ERR, "%s: elem %d too large for buff=
er\n",
> > +                         __func__, elem->index);
> > +                assert(0); /* TODO */
> > +            }
> > +            copy_from_iov(&fbuf, out_num, out_sg);
> > +            fbuf.size =3D out_len;
> > +
> > +            /* TODO! Endianness of header */
> > +
> > +            /* TODO: Fixup fuse_send_msg */
> > +            /* TODO: Add checks for fuse_session_exited */
> > +            fuse_session_process_buf_int(se, &fbuf, &ch);
> > +
> > +            /* TODO: vu_queue_push(dev, q, elem, qi->write_count); */
> > +            vu_queue_notify(dev, q);
> > +
> > +            free(elem);
> > +            elem =3D NULL;
> >          }
> >      }
> > +    pthread_mutex_destroy(&ch.lock);
> > +    free(fbuf.mem);
> >
> >      return NULL;
> >  }
> > --
> > 2.23.0
> >
> >
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


