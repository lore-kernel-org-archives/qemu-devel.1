Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C50C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD736206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 03:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD736206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSuaY-0002AD-Tf
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 23:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSuZu-0001Zs-J4
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jSuZs-0003Ra-TK
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:37:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:47505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jSuZs-0003Ql-Cq
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 23:37:04 -0400
IronPort-SDR: CtIpRgedIL068syXRWaIAJf4Db/YRXuFUXza7EcN+T2aqTXrOU/A5kkp0OyujvcGZHpVoDGkFs
 jS4bGNgcKGcw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2020 20:37:00 -0700
IronPort-SDR: EdwSfXhxSwYgcnt3NjqOjv2pZJCT5xFSsWW1cSzjGecb/KOIKXsXiJdoVxcxD3jYtsf6yLy8qY
 +x+UEH5zfciQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,321,1583222400"; d="scan'208";a="292300777"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga002.fm.intel.com with ESMTP; 26 Apr 2020 20:37:00 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 26 Apr 2020 20:37:00 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 27 Apr 2020 11:36:57 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Mon, 27 Apr 2020 11:36:57 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Topic: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Index: AQHWHBBRepTFtQYUOkeYy9mgo+bZHqiMUT3w
Date: Mon, 27 Apr 2020 03:36:57 +0000
Message-ID: <d93e8eb03493417190e9e1cbc2beed7e@intel.com>
References: <cover.1587935686.git.lukasstraub2@web.de>
 <6f3906393aaaf0adf21d45a5bf7a41536c7de205.1587935686.git.lukasstraub2@web.de>
In-Reply-To: <6f3906393aaaf0adf21d45a5bf7a41536c7de205.1587935686.git.lukasstraub2@web.de>
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
Received-SPF: pass client-ip=134.134.136.65; envelope-from=chen.zhang@intel.com;
 helo=mga03.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:37:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.65
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
> Sent: Monday, April 27, 2020 5:19 AM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH v3 3/6] net/colo-compare.c: Fix deadlock in
> compare_chr_send
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
> Fix this by converting compare_chr_send to a coroutine and putting the
> packets in a send queue. Also create a new function notify_chr_send, sinc=
e
> that should be independend.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 173 ++++++++++++++++++++++++++++++++++-------
> ----
>  1 file changed, 130 insertions(+), 43 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 1de4220fe2..ff6a740284 100644
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
> +80,20 @@ static int event_unhandled_count;
>   *                    |packet  |  |packet  +    |packet  | |packet  +
>   *                    +--------+  +--------+    +--------+ +--------+
>   */
> +
> +typedef struct SendCo {
> +    Coroutine *co;
> +    GQueue send_list;
> +    bool done;
> +    int ret;
> +} SendCo;
> +
> +typedef struct SendEntry {
> +    uint32_t size;
> +    uint32_t vnet_hdr_len;
> +    uint8_t buf[];
> +} SendEntry;
> +
>  typedef struct CompareState {
>      Object parent;
>=20
> @@ -91,6 +108,7 @@ typedef struct CompareState {
>      SocketReadState pri_rs;
>      SocketReadState sec_rs;
>      SocketReadState notify_rs;
> +    SendCo sendco;
>      bool vnet_hdr;
>      uint32_t compare_timeout;
>      uint32_t expired_scan_cycle;
> @@ -126,8 +144,11 @@ enum {
>  static int compare_chr_send(CompareState *s,
>                              const uint8_t *buf,
>                              uint32_t size,
> -                            uint32_t vnet_hdr_len,
> -                            bool notify_remote_frame);
> +                            uint32_t vnet_hdr_len);
> +
> +static int notify_chr_send(CompareState *s,
> +                           const uint8_t *buf,
> +                           uint32_t size);
>=20
>  static bool packet_matches_str(const char *str,
>                                 const uint8_t *buf, @@ -145,7 +166,7 @@ s=
tatic void
> notify_remote_frame(CompareState *s)
>      char msg[] =3D "DO_CHECKPOINT";
>      int ret =3D 0;
>=20
> -    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +    ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
>      if (ret < 0) {
>          error_report("Notify Xen COLO-frame failed");
>      }
> @@ -271,8 +292,7 @@ static void colo_release_primary_pkt(CompareState
> *s, Packet *pkt)
>      ret =3D compare_chr_send(s,
>                             pkt->data,
>                             pkt->size,
> -                           pkt->vnet_hdr_len,
> -                           false);
> +                           pkt->vnet_hdr_len);
>      if (ret < 0) {
>          error_report("colo send primary packet failed");
>      }
> @@ -699,63 +719,123 @@ static void colo_compare_connection(void
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
>      int ret =3D 0;
> -    uint32_t len =3D htonl(size);
>=20
> -    if (!size) {
> -        return 0;
> -    }
> +    while (!g_queue_is_empty(&sendco->send_list)) {
> +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> +        uint32_t len =3D htonl(entry->size);
>=20
> -    if (notify_remote_frame) {
> -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> -                                    (uint8_t *)&len,
> -                                    sizeof(len));
> -    } else {
>          ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, size=
of(len));
> -    }
>=20
> -    if (ret !=3D sizeof(len)) {
> -        goto err;
> -    }
> +        if (ret !=3D sizeof(len)) {
> +            g_free(entry);
> +            goto err;
> +        }
>=20
> -    if (s->vnet_hdr) {
> -        /*
> -         * We send vnet header len make other module(like filter-redirec=
tor)
> -         * know how to parse net packet correctly.
> -         */
> -        len =3D htonl(vnet_hdr_len);
> +        if (s->vnet_hdr) {
> +            /*
> +             * We send vnet header len make other module(like filter-red=
irector)
> +             * know how to parse net packet correctly.
> +             */
> +            len =3D htonl(entry->vnet_hdr_len);
>=20
> -        if (!notify_remote_frame) {
>              ret =3D qemu_chr_fe_write_all(&s->chr_out,
>                                          (uint8_t *)&len,
>                                          sizeof(len));
> +
> +            if (ret !=3D sizeof(len)) {
> +                g_free(entry);
> +                goto err;
> +            }
>          }
>=20
> -        if (ret !=3D sizeof(len)) {
> +        ret =3D qemu_chr_fe_write_all(&s->chr_out,
> +                                    (uint8_t *)entry->buf,
> +                                    entry->size);
> +
> +        if (ret !=3D entry->size) {
> +            g_free(entry);
>              goto err;
>          }
> +
> +        g_free(entry);
>      }
>=20
> -    if (notify_remote_frame) {
> -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> -                                    (uint8_t *)buf,
> -                                    size);
> -    } else {
> -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size)=
;
> +    sendco->ret =3D 0;
> +    goto out;
> +
> +err:
> +    while (!g_queue_is_empty(&sendco->send_list)) {
> +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> +        g_free(entry);
>      }
> +    sendco->ret =3D ret < 0 ? ret : -EIO;
> +out:
> +    sendco->co =3D NULL;
> +    sendco->done =3D true;
> +    aio_wait_kick();
> +}
> +
> +static int compare_chr_send(CompareState *s,
> +                            const uint8_t *buf,
> +                            uint32_t size,
> +                            uint32_t vnet_hdr_len) {
> +    SendCo *sendco =3D &s->sendco;
> +    SendEntry *entry;
> +
> +    if (!size) {
> +        return 0;
> +    }
> +
> +    entry =3D g_malloc(sizeof(SendEntry) + size);
> +    entry->size =3D size;
> +    entry->vnet_hdr_len =3D vnet_hdr_len;
> +    memcpy(entry->buf, buf, size);
> +    g_queue_push_head(&sendco->send_list, entry);
> +
> +    if (sendco->done) {
> +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, s);
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
> +}
> +

Why not make notify_chr_send same as compare_chr_send?

Thanks
Zhang Chen

> +static int notify_chr_send(CompareState *s,
> +                           const uint8_t *buf,
> +                           uint32_t size) {
> +    int ret =3D 0;
> +    uint32_t len =3D htonl(size);
> +
> +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> +                            (uint8_t *)&len,
> +                            sizeof(len));
> +
> +    if (ret !=3D sizeof(len)) {
> +        goto err;
> +    }
> +
> +    ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> +                                (uint8_t *)buf,
> +                                size);
>=20
>      if (ret !=3D size) {
>          goto err;
>      }
>=20
>      return 0;
> -
>  err:
>      return ret < 0 ? ret : -EIO;
>  }
> @@ -1062,8 +1142,7 @@ static void
> compare_pri_rs_finalize(SocketReadState *pri_rs)
>          compare_chr_send(s,
>                           pri_rs->buf,
>                           pri_rs->packet_len,
> -                         pri_rs->vnet_hdr_len,
> -                         false);
> +                         pri_rs->vnet_hdr_len);
>      } else {
>          /* compare packet in the specified connection */
>          colo_compare_connection(conn, s); @@ -1093,7 +1172,7 @@ static v=
oid
> compare_notify_rs_finalize(SocketReadState *notify_rs)
>      if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
>                             notify_rs->buf,
>                             notify_rs->packet_len)) {
> -        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true=
);
> +        ret =3D notify_chr_send(s, (uint8_t *)msg, strlen(msg));
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> @@ -1199,6 +1278,9 @@ static void colo_compare_complete(UserCreatable
> *uc, Error **errp)
>=20
>      QTAILQ_INSERT_TAIL(&net_compares, s, next);
>=20
> +    s->sendco.done =3D true;
> +    g_queue_init(&s->sendco.send_list);
> +
>      g_queue_init(&s->conn_list);
>=20
>      qemu_mutex_init(&event_mtx);
> @@ -1224,8 +1306,7 @@ static void colo_flush_packets(void *opaque, void
> *user_data)
>          compare_chr_send(s,
>                           pkt->data,
>                           pkt->size,
> -                         pkt->vnet_hdr_len,
> -                         false);
> +                         pkt->vnet_hdr_len);
>          packet_destroy(pkt, NULL);
>      }
>      while (!g_queue_is_empty(&conn->secondary_list)) { @@ -1281,6
> +1362,11 @@ static void colo_compare_finalize(Object *obj)
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
>      qemu_chr_fe_deinit(&s->chr_out, false); @@ -1305,6 +1391,7 @@ static
> void colo_compare_finalize(Object *obj)
>      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
>=20
>      g_queue_clear(&s->conn_list);
> +    g_queue_clear(&s->sendco.send_list);
>=20
>      if (s->connection_track_table) {
>          g_hash_table_destroy(s->connection_track_table);
> --
> 2.20.1


