Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22104C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3362054F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3362054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWga5-0001ob-0A
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWgXd-0007yS-Rq
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:26:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:5759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWgXa-000739-Nl
 for qemu-devel@nongnu.org; Thu, 07 May 2020 09:26:21 -0400
IronPort-SDR: MmtJxjXigyopO+EkN3KCP8c46gWJnDz8vJk70AeTIFy+vlMVFwdhdX6tgj6kVid7LWcJv/zpnc
 7YdRbwKUh12g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 06:26:14 -0700
IronPort-SDR: kYXMerlS8kj5M/s/RTRYlh6Ycb3A+LggxHNqG8wvP9XWMYDoTasNhZcg4To/SM/3yQD13WMZF9
 igxA14YAk3TQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; d="scan'208";a="249283531"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 07 May 2020 06:26:13 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 06:26:13 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 21:26:11 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Thu, 7 May 2020 21:26:11 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Topic: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Thread-Index: AQHWIf7Cka4G08x9BkqXms8e2TNTRKicoIKA
Date: Thu, 7 May 2020 13:26:11 +0000
Message-ID: <83c26ab24d28480d94c45c0a0f49d130@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <ac784f17537184c3ab8c745a1d593b02bde85738.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <ac784f17537184c3ab8c745a1d593b02bde85738.1588587700.git.lukasstraub2@web.de>
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
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=chen.zhang@intel.com; helo=mga18.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 09:26:14
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
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
> and finalize
>=20
> In colo_compare_complete, insert CompareState into net_compares only
> after everything has been initialized.
> In colo_compare_finalize, remove CompareState from net_compares before
> anything is deinitialized.

S/deinitialized/finalized

It looks no dependences on each step on initialization and finalization.
Do you means we just need add/remove each colo-compare module at last in lo=
gic?
Or current code have some issue?

Thanks
Zhang Chen

>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> c7572d75e9..6f80bcece6 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1283,15 +1283,6 @@ static void
> colo_compare_complete(UserCreatable *uc, Error **errp)
>                             s->vnet_hdr);
>      }
>=20
> -    qemu_mutex_lock(&colo_compare_mutex);
> -    if (!colo_compare_active) {
> -        qemu_mutex_init(&event_mtx);
> -        qemu_cond_init(&event_complete_cond);
> -        colo_compare_active =3D true;
> -    }
> -    QTAILQ_INSERT_TAIL(&net_compares, s, next);
> -    qemu_mutex_unlock(&colo_compare_mutex);
> -
>      s->out_sendco.s =3D s;
>      s->out_sendco.chr =3D &s->chr_out;
>      s->out_sendco.notify_remote_frame =3D false; @@ -1312,6 +1303,16 @@
> static void colo_compare_complete(UserCreatable *uc, Error **errp)
>                                                        connection_destroy=
);
>=20
>      colo_compare_iothread(s);
> +
> +    qemu_mutex_lock(&colo_compare_mutex);
> +    if (!colo_compare_active) {
> +        qemu_mutex_init(&event_mtx);
> +        qemu_cond_init(&event_complete_cond);
> +        colo_compare_active =3D true;
> +    }
> +    QTAILQ_INSERT_TAIL(&net_compares, s, next);
> +    qemu_mutex_unlock(&colo_compare_mutex);
> +
>      return;
>  }
>=20
> @@ -1384,19 +1385,6 @@ static void colo_compare_finalize(Object *obj)
>      CompareState *s =3D COLO_COMPARE(obj);
>      CompareState *tmp =3D NULL;
>=20
> -    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> -    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> -    qemu_chr_fe_deinit(&s->chr_out, false);
> -    if (s->notify_dev) {
> -        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> -    }
> -
> -    if (s->iothread) {
> -        colo_compare_timer_del(s);
> -    }
> -
> -    qemu_bh_delete(s->event_bh);
> -
>      qemu_mutex_lock(&colo_compare_mutex);
>      QTAILQ_FOREACH(tmp, &net_compares, next) {
>          if (tmp =3D=3D s) {
> @@ -1411,6 +1399,19 @@ static void colo_compare_finalize(Object *obj)
>      }
>      qemu_mutex_unlock(&colo_compare_mutex);
>=20
> +    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> +    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> +    qemu_chr_fe_deinit(&s->chr_out, false);
> +    if (s->notify_dev) {
> +        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> +    }
> +
> +    if (s->iothread) {
> +        colo_compare_timer_del(s);
> +    }
> +
> +    qemu_bh_delete(s->event_bh);
> +
>      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
>      aio_context_acquire(ctx);
>      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> --
> 2.20.1

