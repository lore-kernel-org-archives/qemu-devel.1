Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B8021D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPKvAlii"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B8021D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWEt-0008P3-Nk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itWE6-0007qA-Lr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:32:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itWE1-0008QY-MW
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:32:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itWE1-0008Pw-Eh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579523532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFOl4H63bGrDSw2PUNUObgyLW1MD1+AiFA9k7Z2JXhs=;
 b=VPKvAliiCiYg812ib5BoQXFI2uYEGrGU5iaP2i/ybYZ/vwDOrZhVBPNlvk2ffcvZdTCHHN
 +UJADVPxvAnWbqJh9+JVLp7H+9W3fBcX43f8B5K7G3F3k8u0P3tbWHjAxwGCQtA+M23hrt
 tO43gW7RLQ7eGCHRdU7lTVL1PLuTF0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-qpDGUCWnOpuiH5QIn3OIpg-1; Mon, 20 Jan 2020 07:32:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B035800D48;
 Mon, 20 Jan 2020 12:32:10 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9DDE858BE;
 Mon, 20 Jan 2020 12:32:06 +0000 (UTC)
Date: Mon, 20 Jan 2020 12:32:04 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH 026/104] virtiofsd: Fast path for virtio read
Message-ID: <20200120123204.GL2827@work-vm>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-27-dgilbert@redhat.com>
 <20200117185412.5hmvojeqzg7vgpko@gabell>
MIME-Version: 1.0
In-Reply-To: <20200117185412.5hmvojeqzg7vgpko@gabell>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qpDGUCWnOpuiH5QIn3OIpg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Masayoshi Mizuma (msys.mizuma@gmail.com) wrote:
> On Thu, Dec 12, 2019 at 04:37:46PM +0000, Dr. David Alan Gilbert (git) wr=
ote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >=20
> > Readv the data straight into the guests buffer.
> >=20
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > With fix by:
> > Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> > ---
> >  tools/virtiofsd/fuse_lowlevel.c |   5 +
> >  tools/virtiofsd/fuse_virtio.c   | 159 ++++++++++++++++++++++++++++++++
> >  tools/virtiofsd/fuse_virtio.h   |   4 +
> >  3 files changed, 168 insertions(+)
> >=20
> > diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_low=
level.c
> > index c2b114cf5b..5f80625652 100644
> > --- a/tools/virtiofsd/fuse_lowlevel.c
> > +++ b/tools/virtiofsd/fuse_lowlevel.c
> > @@ -475,6 +475,11 @@ static int fuse_send_data_iov_fallback(struct fuse=
_session *se,
> >          return fuse_send_msg(se, ch, iov, iov_count);
> >      }
> > =20
> > +    if (fuse_lowlevel_is_virtio(se) && buf->count =3D=3D 1 &&
> > +        buf->buf[0].flags =3D=3D (FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK)) =
{
> > +        return virtio_send_data_iov(se, ch, iov, iov_count, buf, len);
> > +    }
> > +
> >      abort(); /* Will have taken vhost path */
> >      return 0;
> >  }
> > diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virti=
o.c
> > index c33e0f7e8c..146cd3f702 100644
> > --- a/tools/virtiofsd/fuse_virtio.c
> > +++ b/tools/virtiofsd/fuse_virtio.c
> > @@ -230,6 +230,165 @@ err:
> >      return ret;
> >  }
> > =20
> > +/*
> > + * Callback from fuse_send_data_iov_* when it's virtio and the buffer
> > + * is a single FD with FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK
> > + * We need send the iov and then the buffer.
> > + * Return 0 on success
> > + */
> > +int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch=
,
> > +                         struct iovec *iov, int count, struct fuse_buf=
vec *buf,
> > +                         size_t len)
> > +{
> > +    int ret =3D 0;
> > +    VuVirtqElement *elem;
> > +    VuVirtq *q;
> > +
> > +    assert(count >=3D 1);
> > +    assert(iov[0].iov_len >=3D sizeof(struct fuse_out_header));
> > +
> > +    struct fuse_out_header *out =3D iov[0].iov_base;
> > +    /* TODO: Endianness! */
> > +
> > +    size_t iov_len =3D iov_size(iov, count);
> > +    size_t tosend_len =3D iov_len + len;
> > +
> > +    out->len =3D tosend_len;
> > +
> > +    fuse_log(FUSE_LOG_DEBUG, "%s: count=3D%d len=3D%zd iov_len=3D%zd\n=
", __func__,
> > +             count, len, iov_len);
> > +
> > +    /* unique =3D=3D 0 is notification which we don't support */
> > +    assert(out->unique);
> > +
> > +    /* For virtio we always have ch */
> > +    assert(ch);
> > +    assert(!ch->qi->reply_sent);
> > +    elem =3D ch->qi->qe;
> > +    q =3D &ch->qi->virtio_dev->dev.vq[ch->qi->qidx];
> > +
> > +    /* The 'in' part of the elem is to qemu */
> > +    unsigned int in_num =3D elem->in_num;
> > +    struct iovec *in_sg =3D elem->in_sg;
> > +    size_t in_len =3D iov_size(in_sg, in_num);
> > +    fuse_log(FUSE_LOG_DEBUG, "%s: elem %d: with %d in desc of length %=
zd\n",
> > +             __func__, elem->index, in_num, in_len);
> > +
> > +    /*
> > +     * The elem should have room for a 'fuse_out_header' (out from fus=
e)
> > +     * plus the data based on the len in the header.
> > +     */
> > +    if (in_len < sizeof(struct fuse_out_header)) {
> > +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too short for out_header\n=
",
> > +                 __func__, elem->index);
>=20
> > +        ret =3D -E2BIG;
>=20
> The ret should be positive value, right?
>=20
>            ret =3D E2BIG;

Yes, I think so.

> > +        goto err;
> > +    }
> > +    if (in_len < tosend_len) {
> > +        fuse_log(FUSE_LOG_ERR, "%s: elem %d too small for data len %zd=
\n",
> > +                 __func__, elem->index, tosend_len);
>=20
> > +        ret =3D -E2BIG;
>=20
>            ret =3D E2BIG;
>=20
> > +        goto err;
> > +    }
> > +
> > +    /* TODO: Limit to 'len' */
> > +
> > +    /* First copy the header data from iov->in_sg */
> > +    copy_iov(iov, count, in_sg, in_num, iov_len);
> > +
> > +    /*
> > +     * Build a copy of the the in_sg iov so we can skip bits in it,
> > +     * including changing the offsets
> > +     */
>=20
> > +    struct iovec *in_sg_cpy =3D calloc(sizeof(struct iovec), in_num);
>=20
>        assert(in_sg_cpy) should be here? in case calloc() fails...

Thanks, added.

> > +    memcpy(in_sg_cpy, in_sg, sizeof(struct iovec) * in_num);
> > +    /* These get updated as we skip */
> > +    struct iovec *in_sg_ptr =3D in_sg_cpy;
> > +    int in_sg_cpy_count =3D in_num;
> > +
> > +    /* skip over parts of in_sg that contained the header iov */
> > +    size_t skip_size =3D iov_len;
> > +
> > +    size_t in_sg_left =3D 0;
> > +    do {
> > +        while (skip_size !=3D 0 && in_sg_cpy_count) {
> > +            if (skip_size >=3D in_sg_ptr[0].iov_len) {
> > +                skip_size -=3D in_sg_ptr[0].iov_len;
> > +                in_sg_ptr++;
> > +                in_sg_cpy_count--;
> > +            } else {
> > +                in_sg_ptr[0].iov_len -=3D skip_size;
> > +                in_sg_ptr[0].iov_base +=3D skip_size;
> > +                break;
> > +            }
> > +        }
> > +
> > +        int i;
> > +        for (i =3D 0, in_sg_left =3D 0; i < in_sg_cpy_count; i++) {
> > +            in_sg_left +=3D in_sg_ptr[i].iov_len;
> > +        }
> > +        fuse_log(FUSE_LOG_DEBUG,
> > +                 "%s: after skip skip_size=3D%zd in_sg_cpy_count=3D%d =
"
> > +                 "in_sg_left=3D%zd\n",
> > +                 __func__, skip_size, in_sg_cpy_count, in_sg_left);
> > +        ret =3D preadv(buf->buf[0].fd, in_sg_ptr, in_sg_cpy_count,
> > +                     buf->buf[0].pos);
> > +
>=20
> > +        fuse_log(FUSE_LOG_DEBUG, "%s: preadv_res=3D%d(%m) len=3D%zd\n"=
,
> > +                 __func__, ret, len);
>=20
> "%m" should be removed? because it may show the previous errno even if pr=
eadv()
> is succsess. Like as:
>=20
> [ID: 00000079] virtio_send_data_iov: after skip skip_size=3D0 in_sg_cpy_c=
ount=3D1 in_sg_left=3D65536
> [ID: 00000079] virtio_send_data_iov: preadv_res=3D16000(No such file or d=
irectory) len=3D65536

I think there's another problem; that fuse_log might corrupt errno, so
we return a bad errno below it.
So I'll split it into two separate fuse_log's - one inside the (ret =3D=3D
-1_ block with the %m and one after without it.

> Otherwise, looks good to me:
>=20
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks

>=20
> Thanks,
> Masa
>=20
> > +        if (ret =3D=3D -1) {
> > +            ret =3D errno;
> > +            free(in_sg_cpy);
> > +            goto err;
> > +        }
> > +        if (ret < len && ret) {
> > +            fuse_log(FUSE_LOG_DEBUG, "%s: ret < len\n", __func__);
> > +            /* Skip over this much next time around */
> > +            skip_size =3D ret;
> > +            buf->buf[0].pos +=3D ret;
> > +            len -=3D ret;
> > +
> > +            /* Lets do another read */
> > +            continue;
> > +        }
> > +        if (!ret) {
> > +            /* EOF case? */
> > +            fuse_log(FUSE_LOG_DEBUG, "%s: !ret in_sg_left=3D%zd\n", __=
func__,
> > +                     in_sg_left);
> > +            break;
> > +        }
> > +        if (ret !=3D len) {
> > +            fuse_log(FUSE_LOG_DEBUG, "%s: ret!=3Dlen\n", __func__);
> > +            ret =3D EIO;
> > +            free(in_sg_cpy);
> > +            goto err;
> > +        }
> > +        in_sg_left -=3D ret;
> > +        len -=3D ret;
> > +    } while (in_sg_left);
> > +    free(in_sg_cpy);
> > +
> > +    /* Need to fix out->len on EOF */
> > +    if (len) {
> > +        struct fuse_out_header *out_sg =3D in_sg[0].iov_base;
> > +
> > +        tosend_len -=3D len;
> > +        out_sg->len =3D tosend_len;
> > +    }
> > +
> > +    ret =3D 0;
> > +
> > +    vu_queue_push(&se->virtio_dev->dev, q, elem, tosend_len);
> > +    vu_queue_notify(&se->virtio_dev->dev, q);
> > +
> > +err:
> > +    if (ret =3D=3D 0) {
> > +        ch->qi->reply_sent =3D true;
> > +    }
> > +
> > +    return ret;
> > +}
> > +
> >  /* Thread function for individual queues, created when a queue is 'sta=
rted' */
> >  static void *fv_queue_thread(void *opaque)
> >  {
> > diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virti=
o.h
> > index 135a14875a..cc676b9193 100644
> > --- a/tools/virtiofsd/fuse_virtio.h
> > +++ b/tools/virtiofsd/fuse_virtio.h
> > @@ -26,4 +26,8 @@ int virtio_loop(struct fuse_session *se);
> >  int virtio_send_msg(struct fuse_session *se, struct fuse_chan *ch,
> >                      struct iovec *iov, int count);
> > =20
> > +int virtio_send_data_iov(struct fuse_session *se, struct fuse_chan *ch=
,
> > +                         struct iovec *iov, int count,
> > +                         struct fuse_bufvec *buf, size_t len);
> > +
> >  #endif
> > --=20
> > 2.23.0
> >=20
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


