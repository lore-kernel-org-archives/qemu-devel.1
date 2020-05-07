Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB15C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459232083B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459232083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeIC-0005fP-D7
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWeGh-0004qf-4C
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:00:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:13259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWeGe-00005H-QW
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:00:42 -0400
IronPort-SDR: ivvDgyaO1/QTXZjTMTI4LnvsflQkypO0tsYGOcTGJ+tAnwXq+7MICVkln9mAG3f+MF17SFcWlh
 b65YGs/KrHRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 04:00:29 -0700
IronPort-SDR: TTCWn7jgs9sYARqDyAySksLRF45EN4F0vdnrBmxUz3wWGyGN9CYaqRzIq1+i1zenYmirry5cCy
 qEBveyVZVE6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; d="scan'208";a="284954629"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 04:00:29 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 04:00:29 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 19:00:26 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Thu, 7 May 2020 19:00:26 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Topic: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in
 compare_chr_send
Thread-Index: AQHWIf7BDkECWoyP7kGnccHgaQnR+6icRinA
Date: Thu, 7 May 2020 11:00:26 +0000
Message-ID: <c27b4dbdc6834e70b4af738d01f9fae4@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <5536749ec95380f18c01789c472324565c060bcc.1588587700.git.lukasstraub2@web.de>
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
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=chen.zhang@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:00:30
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, May 4, 2020 6:28 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian=20
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-=20
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini=20
> <pbonzini@redhat.com>
> Subject: [PATCH v4 3/6] net/colo-compare.c: Fix deadlock in=20
> compare_chr_send
>=20
> The chr_out chardev is connected to a filter-redirector running in the=20
> main loop. qemu_chr_fe_write_all might block here in compare_chr_send=20
> if the (socket-)buffer is full.
> If another filter-redirector in the main loop want's to send data to=20
> chr_pri_in it might also block if the buffer is full. This leads to a=20
> deadlock because both event loops get blocked.
>=20
> Fix this by converting compare_chr_send to a coroutine and putting the=20
> packets in a send queue.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 187 ++++++++++++++++++++++++++++++++++-------
> ----
>  net/colo.c         |   7 ++
>  net/colo.h         |   1 +
>  3 files changed, 150 insertions(+), 45 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index=20
> 1de4220fe2..2a4e7f7c4e 100644
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
> +80,23 @@ static int event_unhandled_count;
>   *                    |packet  |  |packet  +    |packet  | |packet  +
>   *                    +--------+  +--------+    +--------+ +--------+
>   */
> +
> +typedef struct SendCo {
> +    Coroutine *co;
> +    struct CompareState *s;
> +    CharBackend *chr;
> +    GQueue send_list;
> +    bool notify_remote_frame;
> +    bool done;
> +    int ret;
> +} SendCo;
> +
> +typedef struct SendEntry {
> +    uint32_t size;
> +    uint32_t vnet_hdr_len;
> +    uint8_t *buf;
> +} SendEntry;
> +
>  typedef struct CompareState {
>      Object parent;
>=20
> @@ -91,6 +111,8 @@ typedef struct CompareState {
>      SocketReadState pri_rs;
>      SocketReadState sec_rs;
>      SocketReadState notify_rs;
> +    SendCo out_sendco;
> +    SendCo notify_sendco;
>      bool vnet_hdr;
>      uint32_t compare_timeout;
>      uint32_t expired_scan_cycle;
> @@ -124,10 +146,11 @@ enum {
>=20
>=20
>  static int compare_chr_send(CompareState *s,
> -                            const uint8_t *buf,
> +                            uint8_t *buf,
>                              uint32_t size,
>                              uint32_t vnet_hdr_len,
> -                            bool notify_remote_frame);
> +                            bool notify_remote_frame,
> +                            bool zero_copy);
>=20
>  static bool packet_matches_str(const char *str,
>                                 const uint8_t *buf, @@ -145,7 +168,7=20
> @@ static void notify_remote_frame(CompareState *s)
>      char msg[] =3D "DO_CHECKPOINT";
>      int ret =3D 0;
>=20
> -    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true,=20
> + false);
>      if (ret < 0) {
>          error_report("Notify Xen COLO-frame failed");
>      }
> @@ -272,12 +295,13 @@ static void
> colo_release_primary_pkt(CompareState *s, Packet *pkt)
>                             pkt->data,
>                             pkt->size,
>                             pkt->vnet_hdr_len,
> -                           false);
> +                           false,
> +                           true);
>      if (ret < 0) {
>          error_report("colo send primary packet failed");
>      }
>      trace_colo_compare_main("packet same and release packet");
> -    packet_destroy(pkt, NULL);
> +    packet_destroy_partial(pkt, NULL);
>  }
>=20
>  /*
> @@ -699,65 +723,115 @@ static void colo_compare_connection(void=20
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
> +    SendCo *sendco =3D opaque;
> +    CompareState *s =3D sendco->s;
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
> -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)&len, size=
of(len));
> -    }
> +        ret =3D qemu_chr_fe_write_all(sendco->chr, (uint8_t *)&len,=20
> + sizeof(len));
>=20
> -    if (ret !=3D sizeof(len)) {
> -        goto err;
> -    }
> +        if (ret !=3D sizeof(len)) {
> +            g_free(entry->buf);
> +            g_slice_free(SendEntry, entry);
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
> +        if (!sendco->notify_remote_frame && s->vnet_hdr) {
> +            /*
> +             * We send vnet header len make other module(like filter-red=
irector)
> +             * know how to parse net packet correctly.
> +             */
> +            len =3D htonl(entry->vnet_hdr_len);
>=20
> -        if (!notify_remote_frame) {
> -            ret =3D qemu_chr_fe_write_all(&s->chr_out,
> +            ret =3D qemu_chr_fe_write_all(sendco->chr,
>                                          (uint8_t *)&len,
>                                          sizeof(len));
> +
> +            if (ret !=3D sizeof(len)) {
> +                g_free(entry->buf);
> +                g_slice_free(SendEntry, entry);
> +                goto err;
> +            }
>          }
>=20
> -        if (ret !=3D sizeof(len)) {
> +        ret =3D qemu_chr_fe_write_all(sendco->chr,
> +                                    (uint8_t *)entry->buf,
> +                                    entry->size);
> +
> +        if (ret !=3D entry->size) {
> +            g_free(entry->buf);
> +            g_slice_free(SendEntry, entry);
>              goto err;
>          }
> +
> +        g_free(entry->buf);
> +        g_slice_free(SendEntry, entry);
>      }
>=20
> +    sendco->ret =3D 0;
> +    goto out;
> +
> +err:
> +    while (!g_queue_is_empty(&sendco->send_list)) {
> +        SendEntry *entry =3D g_queue_pop_tail(&sendco->send_list);
> +        g_free(entry->buf);
> +        g_slice_free(SendEntry, entry);
> +    }
> +    sendco->ret =3D ret < 0 ? ret : -EIO;
> +out:
> +    sendco->co =3D NULL;
> +    sendco->done =3D true;
> +    aio_wait_kick();
> +}
> +
> +static int compare_chr_send(CompareState *s,
> +                            uint8_t *buf,
> +                            uint32_t size,
> +                            uint32_t vnet_hdr_len,
> +                            bool notify_remote_frame,
> +                            bool zero_copy) {
> +    SendCo *sendco;
> +    SendEntry *entry;
> +
>      if (notify_remote_frame) {
> -        ret =3D qemu_chr_fe_write_all(&s->chr_notify_dev,
> -                                    (uint8_t *)buf,
> -                                    size);
> +        sendco =3D &s->notify_sendco;
>      } else {
> -        ret =3D qemu_chr_fe_write_all(&s->chr_out, (uint8_t *)buf, size)=
;
> +        sendco =3D &s->out_sendco;
>      }
>=20
> -    if (ret !=3D size) {
> -        goto err;
> +    if (!size) {
> +        return 0;
>      }
>=20
> -    return 0;
> +    entry =3D g_slice_new(SendEntry);
> +    entry->size =3D size;
> +    entry->vnet_hdr_len =3D vnet_hdr_len;
> +    if (zero_copy) {
> +        entry->buf =3D buf;
> +    } else {
> +        entry->buf =3D g_malloc(size);
> +        memcpy(entry->buf, buf, size);
> +    }
> +    g_queue_push_head(&sendco->send_list, entry);
> +
> +    if (sendco->done) {
> +        sendco->co =3D qemu_coroutine_create(_compare_chr_send, sendco);
> +        sendco->done =3D false;
> +        qemu_coroutine_enter(sendco->co);
> +        if (sendco->done) {
> +            /* report early errors */
> +            return sendco->ret;
> +        }
> +    }
>=20
> -err:
> -    return ret < 0 ? ret : -EIO;
> +    /* assume success */
> +    return 0;
>  }
>=20
>  static int compare_chr_can_read(void *opaque) @@ -1063,6 +1137,7 @@=20
> static void compare_pri_rs_finalize(SocketReadState *pri_rs)
>                           pri_rs->buf,
>                           pri_rs->packet_len,
>                           pri_rs->vnet_hdr_len,
> +                         false,
>                           false);
>      } else {
>          /* compare packet in the specified connection */ @@ -1093,7
> +1168,7 @@ static void compare_notify_rs_finalize(SocketReadState
> +*notify_rs)
>      if (packet_matches_str("COLO_USERSPACE_PROXY_INIT",
>                             notify_rs->buf,
>                             notify_rs->packet_len)) {
> -        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true=
);
> +        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0,=20
> + true, false);
>          if (ret < 0) {
>              error_report("Notify Xen COLO-frame INIT failed");
>          }
> @@ -1199,6 +1274,18 @@ static void
> colo_compare_complete(UserCreatable *uc, Error **errp)
>=20
>      QTAILQ_INSERT_TAIL(&net_compares, s, next);
>=20
> +    s->out_sendco.s =3D s;
> +    s->out_sendco.chr =3D &s->chr_out;
> +    s->out_sendco.notify_remote_frame =3D false;
> +    s->out_sendco.done =3D true;
> +    g_queue_init(&s->out_sendco.send_list);
> +
> +    s->notify_sendco.s =3D s;
> +    s->notify_sendco.chr =3D &s->chr_notify_dev;
> +    s->notify_sendco.notify_remote_frame =3D true;
> +    s->notify_sendco.done =3D true;
> +    g_queue_init(&s->notify_sendco.send_list);
> +

No need to init the notify_sendco each time, because the notify dev just an=
 optional parameter.
You can use the if (s->notify_dev) here. Just Xen use the chr_notify_dev.

Overall, make the chr_send job to coroutine is a good idea. It looks good f=
or me.
And your patch inspired me, it looks we can re-use the compare_chr_send cod=
e on filter mirror/redirector too.

Tested-by: Zhang Chen <chen.zhang@intel.com>


>      g_queue_init(&s->conn_list);
>=20
>      qemu_mutex_init(&event_mtx);
> @@ -1225,8 +1312,9 @@ static void colo_flush_packets(void *opaque,=20
> void
> *user_data)
>                           pkt->data,
>                           pkt->size,
>                           pkt->vnet_hdr_len,
> -                         false);
> -        packet_destroy(pkt, NULL);
> +                         false,
> +                         true);
> +        packet_destroy_partial(pkt, NULL);
>      }
>      while (!g_queue_is_empty(&conn->secondary_list)) {
>          pkt =3D g_queue_pop_head(&conn->secondary_list);
> @@ -1301,10 +1389,19 @@ static void colo_compare_finalize(Object *obj)
>          }
>      }
>=20
> +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> +    aio_context_acquire(ctx);
> +    AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> +    AIO_WAIT_WHILE(ctx, !s->notify_sendco.done);

Same as above.

> +    aio_context_release(ctx);
> +
>      /* Release all unhandled packets after compare thead exited */
>      g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    AIO_WAIT_WHILE(NULL, !s->out_sendco.done);
>=20
>      g_queue_clear(&s->conn_list);
> +    g_queue_clear(&s->out_sendco.send_list);
> +    g_queue_clear(&s->notify_sendco.send_list);

Same as above.

>=20
>      if (s->connection_track_table) {
>          g_hash_table_destroy(s->connection_track_table);
> diff --git a/net/colo.c b/net/colo.c
> index 8196b35837..a6c66d829a 100644
> --- a/net/colo.c
> +++ b/net/colo.c
> @@ -185,6 +185,13 @@ void packet_destroy(void *opaque, void *user_data)
>      g_slice_free(Packet, pkt);
>  }
>=20
> +void packet_destroy_partial(void *opaque, void *user_data) {
> +    Packet *pkt =3D opaque;
> +
> +    g_slice_free(Packet, pkt);
> +}
> +
>  /*
>   * Clear hashtable, stop this hash growing really huge
>   */
> diff --git a/net/colo.h b/net/colo.h
> index 679314b1ca..573ab91785 100644
> --- a/net/colo.h
> +++ b/net/colo.h
> @@ -102,5 +102,6 @@ bool connection_has_tracked(GHashTable=20
> *connection_track_table,  void connection_hashtable_reset(GHashTable
> *connection_track_table);  Packet *packet_new(const void *data, int=20
> size, int vnet_hdr_len);  void packet_destroy(void *opaque, void=20
> *user_data);
> +void packet_destroy_partial(void *opaque, void *user_data);
>=20
>  #endif /* NET_COLO_H */
> --
> 2.20.1


