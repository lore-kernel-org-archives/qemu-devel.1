Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E057C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EE57206B9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EE57206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAx4-0001LG-En
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAwD-0000uc-Ml
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAwB-0006w0-To
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:40:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:1406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRAwB-0006d7-AE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:40:55 -0400
IronPort-SDR: jPQWLMTitcwHLG3eNQ2+2XXxjwN+6isBwBBG2Kyeam+UMFmjzBVsFKgO1dUDgsh0qYIX1Xq+Ou
 iJt2JoFmdOAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 01:40:49 -0700
IronPort-SDR: 6Cq3owy30Djpho4/h4A0xqB1Ev0ky1etZ8/1kyq8beC4ViZbB4tzjt9YFf69Bba/rIPwa+tc9S
 pQJZ9EwiGSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,413,1580803200"; d="scan'208";a="255567348"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 01:40:49 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 01:40:43 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Apr 2020 16:40:41 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 22 Apr 2020 16:40:41 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/3] net/colo-compare.c: Fix deadlock
Thread-Topic: [PATCH 3/3] net/colo-compare.c: Fix deadlock
Thread-Index: AQHWDdRPpJe1JU6JkUms+S6o6peNRqiE52lA
Date: Wed, 22 Apr 2020 08:40:40 +0000
Message-ID: <43db66be4b41426e97cf086b0a5d4784@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <87c2f42b46f93fb89867f82e45aa2689eff98432.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <87c2f42b46f93fb89867f82e45aa2689eff98432.1586370737.git.lukasstraub2@web.de>
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
Received-SPF: pass client-ip=192.55.52.136; envelope-from=chen.zhang@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 04:29:42
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.136
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
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Thursday, April 9, 2020 2:34 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH 3/3] net/colo-compare.c: Fix deadlock
>=20
> The chr_out chardev is connected to a filter-redirector running in the ma=
in
> loop. qemu_chr_fe_write_all might block here in compare_chr_send if the
> (socket-)buffer is full.
> If another filter-redirector in the main loop want's to send data to chr_=
pri_in
> it might also block if the buffer is full. This leads to a deadlock becau=
se both
> event loops get blocked.
>=20
> Fix this by converting compare_chr_send to a coroutine and return error i=
f it
> is in use.
>=20

I have tested this series, running fine currently.
Can you share performance data after this patch?

Thanks
Zhang Chen

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 82
> +++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 11 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 1de4220fe2..82787d3055 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -32,6 +32,9 @@
>  #include "migration/migration.h"
>  #include "util.h"
>=20
> +#include "block/aio-wait.h"
> +#include "qemu/coroutine.h"
> +
>  #define TYPE_COLO_COMPARE "colo-compare"
>  #define COLO_COMPARE(obj) \
>      OBJECT_CHECK(CompareState, (obj), TYPE_COLO_COMPARE) @@ -77,6
> +80,17 @@ static int event_unhandled_count;
>   *                    |packet  |  |packet  +    |packet  | |packet  +
>   *                    +--------+  +--------+    +--------+ +--------+
>   */
> +
> +typedef struct SendCo {
> +    Coroutine *co;
> +    uint8_t *buf;
> +    uint32_t size;
> +    uint32_t vnet_hdr_len;
> +    bool notify_remote_frame;
> +    bool done;
> +    int ret;
> +} SendCo;
> +
>  typedef struct CompareState {
>      Object parent;
>=20
> @@ -91,6 +105,7 @@ typedef struct CompareState {
>      SocketReadState pri_rs;
>      SocketReadState sec_rs;
>      SocketReadState notify_rs;
> +    SendCo sendco;
>      bool vnet_hdr;
>      uint32_t compare_timeout;
>      uint32_t expired_scan_cycle;
> @@ -699,19 +714,17 @@ static void colo_compare_connection(void
> *opaque, void *user_data)
>      }
>  }
>=20
> -static int compare_chr_send(CompareState *s,
> -                            const uint8_t *buf,
> -                            uint32_t size,
> -                            uint32_t vnet_hdr_len,
> -                            bool notify_remote_frame)
> +static void coroutine_fn _compare_chr_send(void *opaque)
>  {
> +    CompareState *s =3D opaque;
> +    SendCo *sendco =3D &s->sendco;
> +    const uint8_t *buf =3D sendco->buf;
> +    uint32_t size =3D sendco->size;
> +    uint32_t vnet_hdr_len =3D sendco->vnet_hdr_len;
> +    bool notify_remote_frame =3D sendco->notify_remote_frame;
>      int ret =3D 0;
>      uint32_t len =3D htonl(size);
>=20
> -    if (!size) {
> -        return 0;
> -    }
> -
>      if (notify_remote_frame) {
>          ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
>                                      (uint8_t *)&len, @@ -754,10 +767,50 =
@@ static int
> compare_chr_send(CompareState *s,
>          goto err;
>      }
>=20
> -    return 0;
> +    sendco->ret =3D 0;
> +    goto out;
>=20
>  err:
> -    return ret < 0 ? ret : -EIO;
> +    sendco->ret =3D ret < 0 ? ret : -EIO;
> +out:
> +    sendco->co =3D NULL;
> +    g_free(sendco->buf);
> +    sendco->buf =3D NULL;
> +    sendco->done =3D true;
> +    aio_wait_kick();
> +}
> +
> +static int compare_chr_send(CompareState *s,
> +                            const uint8_t *buf,
> +                            uint32_t size,
> +                            uint32_t vnet_hdr_len,
> +                            bool notify_remote_frame) {
> +    SendCo *sendco =3D &s->sendco;
> +
> +    if (!size) {
> +        return 0;
> +    }
> +
> +    if (sendco->done) {
> +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
> +        sendco->buf =3D g_malloc(size);
> +        sendco->size =3D size;
> +        sendco->vnet_hdr_len =3D vnet_hdr_len;
> +        sendco->notify_remote_frame =3D notify_remote_frame;
> +        sendco->done =3D false;
> +        memcpy(sendco->buf, buf, size);
> +        qemu_coroutine_enter(sendco->co);
> +        if (sendco->done) {
> +            /* report early errors */
> +            return sendco->ret;
> +        } else {
> +            /* else assume success */
> +            return 0;
> +        }
> +    }
> +
> +    return -ENOBUFS;
>  }
>=20
>  static int compare_chr_can_read(void *opaque) @@ -1146,6 +1199,8 @@
> static void colo_compare_complete(UserCreatable *uc, Error **errp)
>      CompareState *s =3D COLO_COMPARE(uc);
>      Chardev *chr;
>=20
> +    s->sendco.done =3D true;
> +
>      if (!s->pri_indev || !s->sec_indev || !s->outdev || !s->iothread) {
>          error_setg(errp, "colo compare needs 'primary_in' ,"
>                     "'secondary_in','outdev','iothread' property set"); @=
@ -1281,6
> +1336,11 @@ static void colo_compare_finalize(Object *obj)
>      CompareState *s =3D COLO_COMPARE(obj);
>      CompareState *tmp =3D NULL;
>=20
> +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> +    aio_context_acquire(ctx);
> +    AIO_WAIT_WHILE(ctx, !s->sendco.done);
> +    aio_context_release(ctx);
> +
>      qemu_chr_fe_deinit(&s->chr_pri_in, false);
>      qemu_chr_fe_deinit(&s->chr_sec_in, false);
>      qemu_chr_fe_deinit(&s->chr_out, false);
> --
> 2.20.1

