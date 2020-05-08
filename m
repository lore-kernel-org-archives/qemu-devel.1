Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF597C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD080208D6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD080208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwWN-0004h6-Rg
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWwVE-0003YM-FV
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:28:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:24464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWwVC-0001ir-9W
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:28:55 -0400
IronPort-SDR: X4EQoar2R/LA/fSpDeBa/gwAR4oHSBrr2muNyPzkQO5Sk28n7s3pumEBQ7mp0byV/kHWLLxrsf
 fVN+GB1shFyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 23:28:49 -0700
IronPort-SDR: EFiAeM/bWwB0K99cE3enR/NSojPn0xycftREAG4YVkAR9Mfmyd1UV7sn+ixeEdu+A99wH65AJV
 rfqfSLCxs7/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; d="scan'208";a="260776109"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga003.jf.intel.com with ESMTP; 07 May 2020 23:28:49 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 23:28:48 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX605.ccr.corp.intel.com (10.109.6.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 8 May 2020 14:28:45 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Fri, 8 May 2020 14:28:45 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: RE: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Topic: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Index: AQHWIf7BDkECWoyP7kGnccHgaQnR+6icRinA///+YYCAATRuMP//uwAAgACLbgA=
Date: Fri, 8 May 2020 06:28:45 +0000
Message-ID: <274606df46bb49a4bf9d6fa58b1f9689@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
 <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>	<20200507175107.45d5d497@luklap>
 <0636ae8fb8a640a0bae59712ca9447dd@intel.com> <20200508080804.6677e210@luklap>
In-Reply-To: <20200508080804.6677e210@luklap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.31; envelope-from=chen.zhang@intel.com;
 helo=mga06.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:28:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Friday, May 8, 2020 2:08 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: Re: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
> compare_chr_send
>=20
> On Fri, 8 May 2020 02:19:00 +0000
> "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > > > No need to init the notify_sendco each time, because the notify
> > > > dev just
> > > an optional parameter.
> > > > You can use the if (s->notify_dev) here. Just Xen use the
> chr_notify_dev.
> > >
> > > Ok, I will change that and the code below in the next version.
> > >
> > > > Overall, make the chr_send job to coroutine is a good idea. It
> > > > looks good
> > > for me.
> > > > And your patch inspired me, it looks we can re-use the
> > > > compare_chr_send
> > > code on filter mirror/redirector too.
> > >
> > > I already have patch for that, but I don't think it is a good idea,
> > > because the guest then can send packets faster than colo-compare can
> > > process. This leads bufferbloat and the performance drops in my tests=
:
> > > Client-to-server tcp:
> > > without patch: ~66 Mbit/s
> > > with patch: ~59 Mbit/s
> > > Server-to-client tcp:
> > > without patch: ~702 Kbit/s
> > > with patch: ~328 Kbit/s
> >
> > Oh, a big performance drop, is that caused by memcpy/zero_copy parts ?
> >
> > Thanks
> > Zhang Chen
>=20
> No, there is no memcpy overhead with this patch, see below.

I means for the filter mirror/redirector parts why coroutine will lead huge=
 performance drop?

Thanks
Zhang Chen

>=20
> Regards,
> Lukas Straub
>=20
> ---
>  net/filter-mirror.c | 142 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 106 insertions(+), 36 deletions(-)
>=20
> diff --git a/net/filter-mirror.c b/net/filter-mirror.c index
> d83e815545..6bcd317502 100644
> --- a/net/filter-mirror.c
> +++ b/net/filter-mirror.c
> @@ -20,6 +20,8 @@
>  #include "chardev/char-fe.h"
>  #include "qemu/iov.h"
>  #include "qemu/sockets.h"
> +#include "block/aio-wait.h"
> +#include "qemu/coroutine.h"
>=20
>  #define FILTER_MIRROR(obj) \
>      OBJECT_CHECK(MirrorState, (obj), TYPE_FILTER_MIRROR) @@ -31,6
> +33,18 @@  #define TYPE_FILTER_REDIRECTOR "filter-redirector"
>  #define REDIRECTOR_MAX_LEN NET_BUFSIZE
>=20
> +typedef struct SendCo {
> +    Coroutine *co;
> +    GQueue send_list;
> +    bool done;
> +    int ret;
> +} SendCo;
> +
> +typedef struct SendEntry {
> +    ssize_t size;
> +    uint8_t buf[];
> +} SendEntry;
> +
>  typedef struct MirrorState {
>      NetFilterState parent_obj;
>      char *indev;
> @@ -38,59 +52,101 @@ typedef struct MirrorState {
>      CharBackend chr_in;
>      CharBackend chr_out;
>      SocketReadState rs;
> +    SendCo sendco;
>      bool vnet_hdr;
>  } MirrorState;
>=20
> -static int filter_send(MirrorState *s,
> -                       const struct iovec *iov,
> -                       int iovcnt)
> +static void coroutine_fn _filter_send(void *opaque)
>  {
> +    MirrorState *s =3D opaque;
> +    SendCo *sendco =3D &s->sendco;
>      NetFilterState *nf =3D NETFILTER(s);
>      int ret =3D 0;
> -    ssize_t size =3D 0;
> -    uint32_t len =3D 0;
> -    char *buf;
> -
> -    size =3D iov_size(iov, iovcnt);
> -    if (!size) {
> -        return 0;
> -    }
>=20
> -    len =3D htonl(size);
> -    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, sizeof(l=
en));
> -    if (ret !=3D sizeof(len)) {
> -        goto err;
> -    }
> +    while (!g_queue_is_empty(&sendco->send_list)) {
> +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> +        uint32_t len =3D htonl(entry->size);
>=20
> -    if (s->vnet_hdr) {
> -        /*
> -         * If vnet_hdr =3D on, we send vnet header len to make other
> -         * module(like colo-compare) know how to parse net
> -         * packet correctly.
> -         */
> -        ssize_t vnet_hdr_len;
> +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> +                                    (uint8_t *)&len,
> +                                    sizeof(len));
> +        if (ret !=3D sizeof(len)) {
> +            g_free(entry);
> +            goto err;
> +        }
>=20
> -        vnet_hdr_len =3D nf->netdev->vnet_hdr_len;
> +        if (s->vnet_hdr) {
> +            /*
> +             * If vnet_hdr =3D on, we send vnet header len to make other
> +             * module(like colo-compare) know how to parse net
> +             * packet correctly.
> +             */
> +
> +            len =3D htonl(nf->netdev->vnet_hdr_len);
> +            ret =3D qemu_chr_fe_write_all(&s->chr_out,
> +                                        (uint8_t *)&len,
> +                                        sizeof(len));
> +            if (ret !=3D sizeof(len)) {
> +                g_free(entry);
> +                goto err;
> +            }
> +        }
>=20
> -        len =3D htonl(vnet_hdr_len);
> -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, size=
of(len));
> -        if (ret !=3D sizeof(len)) {
> +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> +                                    (uint8_t *)entry->buf,
> +                                    entry->size);
> +        if (ret !=3D entry->size) {
> +            g_free(entry);
>              goto err;
>          }
> -    }
>=20
> -    buf =3D g_malloc(size);
> -    iov_to_buf(iov, iovcnt, 0, buf, size);
> -    ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size);
> -    g_free(buf);
> -    if (ret !=3D size) {
> -        goto err;
> +        g_free(entry);
>      }
>=20
> -    return 0;
> +    sendco->ret =3D 0;
> +    goto out;
>=20
>  err:
> -    return ret < 0 ? ret : -EIO;
> +    while (!g_queue_is_empty(&sendco->send_list)) {
> +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> +        g_free(entry);
> +    }
> +    sendco->ret =3D ret < 0 ? ret : -EIO;
> +out:
> +    sendco->co =3D NULL;
> +    sendco->done =3D true;
> +    aio_wait_kick();
> +}
> +
> +static int filter_send(MirrorState *s,
> +                       const struct iovec *iov,
> +                       int iovcnt)
> +{
> +    SendCo *sendco =3D &s->sendco;
> +    SendEntry *entry;
> +
> +    ssize_t size =3D iov_size(iov, iovcnt);
> +    if (!size) {
> +        return 0;
> +    }
> +
> +    entry =3D g_malloc(sizeof(SendEntry) + size);
> +    entry->size =3D size;
> +    iov_to_buf(iov, iovcnt, 0, entry->buf, size);
> +    g_queue_push_head(&sendco->send_list, entry);
> +
> +    if (sendco->done) {
> +        sendco->co =3D qemu_coroutine_create(_filter_send, s);
> +        sendco->done =3D false;
> +        qemu_coroutine_enter(sendco->co);
> +        if (sendco->done) {
> +            /* report early errors */
> +            return sendco->ret;
> +        }
> +    }
> +
> +    /* assume success */
> +    return 0;
>  }
>=20
>  static void redirector_to_filter(NetFilterState *nf, @@ -194,6 +250,10 @=
@
> static void filter_mirror_cleanup(NetFilterState *nf)  {
>      MirrorState *s =3D FILTER_MIRROR(nf);
>=20
> +    AIO_WAIT_WHILE(NULL, !s->sendco.done);
> +
> +    g_queue_clear(&s->sendco.send_list);
> +
>      qemu_chr_fe_deinit(&s->chr_out, false);  }
>=20
> @@ -201,6 +261,10 @@ static void filter_redirector_cleanup(NetFilterState
> *nf)  {
>      MirrorState *s =3D FILTER_REDIRECTOR(nf);
>=20
> +    AIO_WAIT_WHILE(NULL, !s->sendco.done);
> +
> +    g_queue_clear(&s->sendco.send_list);
> +
>      qemu_chr_fe_deinit(&s->chr_in, false);
>      qemu_chr_fe_deinit(&s->chr_out, false);  } @@ -224,6 +288,9 @@ stati=
c
> void filter_mirror_setup(NetFilterState *nf, Error **errp)
>      }
>=20
>      qemu_chr_fe_init(&s->chr_out, chr, errp);
> +
> +    s->sendco.done =3D true;
> +    g_queue_init(&s->sendco.send_list);
>  }
>=20
>  static void redirector_rs_finalize(SocketReadState *rs) @@ -281,6 +348,9
> @@ static void filter_redirector_setup(NetFilterState *nf, Error **errp)
>              return;
>          }
>      }
> +
> +    s->sendco.done =3D true;
> +    g_queue_init(&s->sendco.send_list);
>  }
>=20
>  static void filter_mirror_class_init(ObjectClass *oc, void *data)
> --
> 2.20.1


