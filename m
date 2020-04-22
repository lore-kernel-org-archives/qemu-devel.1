Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F124C55186
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B6220735
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 08:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B6220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRAmJ-0004pz-6C
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 04:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAlT-0004OH-N4
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:29:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jRAlR-0002qH-Sz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:29:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:65299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jRAlR-0002g3-Al
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 04:29:49 -0400
IronPort-SDR: zyqpYi/6WQ6pIH4NimmcMfO+dxPlXcK4wC0b3Q9+vxWWKbDzglMxj6qsMYVQDdyc3z04UI7Fm5
 RGCxZBb9KI+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 01:29:41 -0700
IronPort-SDR: qeQaACgcoMP9HqjZ7/Y829fUa/ujlv+jvL4rURORO17eN7tj9fokPyFYoIJd1OcWdUo9uK1AH8
 bbO6lmGKatog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,413,1580803200"; d="scan'208";a="245916724"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2020 01:29:41 -0700
Received: from shsmsx606.ccr.corp.intel.com (10.109.6.216) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Apr 2020 01:29:41 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX606.ccr.corp.intel.com (10.109.6.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 22 Apr 2020 16:29:39 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 22 Apr 2020 16:29:39 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Topic: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
 AioContext
Thread-Index: AQHWDdROWO/1QHY6Ok6COLp0/RhfnqiE5E6A
Date: Wed, 22 Apr 2020 08:29:39 +0000
Message-ID: <5ab3bd6649a44354b087c31bb9fcd5a4@intel.com>
References: <cover.1586370737.git.lukasstraub2@web.de>
 <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
In-Reply-To: <b86f80bb47ac66b73b2afe80218c9913722c606a.1586370737.git.lukasstraub2@web.de>
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
> Subject: [PATCH 1/3] net/colo-compare.c: Create event_bh with the right
> AioContext
>=20
> qemu_bh_new will set the bh to be executed in the main loop. This causes
> problems as colo_compare_handle_event assumes that it has exclusive
> access the queues, which are also accessed in the iothread. It also assum=
es
> that it runs in a different thread than the caller and takes the appropri=
ate
> locks.
>=20
> Create the bh with the AioContext of the iothread to fulfill these
> assumptions.
>=20

Looks good for me, I assume it will increase performance. Do you have relat=
ed data?

Thanks
Zhang Chen

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 10c0239f9d..1de4220fe2 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -890,6 +890,7 @@ static void colo_compare_handle_event(void
> *opaque)
>=20
>  static void colo_compare_iothread(CompareState *s)  {
> +    AioContext *ctx =3D iothread_get_aio_context(s->iothread);
>      object_ref(OBJECT(s->iothread));
>      s->worker_context =3D iothread_get_g_main_context(s->iothread);
>=20
> @@ -906,7 +907,7 @@ static void colo_compare_iothread(CompareState *s)
>      }
>=20
>      colo_compare_timer_init(s);
> -    s->event_bh =3D qemu_bh_new(colo_compare_handle_event, s);
> +    s->event_bh =3D aio_bh_new(ctx, colo_compare_handle_event, s);
>  }
>=20
>  static char *compare_get_pri_indev(Object *obj, Error **errp)
> --
> 2.20.1


