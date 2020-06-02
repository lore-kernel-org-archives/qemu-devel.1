Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5580CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 06:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22879206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 06:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22879206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg0Iv-0003up-8T
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 02:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jg0IO-0003R5-IJ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 02:21:08 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:60262 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jg0IM-0000Ur-P3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 02:21:08 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 3F112334F8A6BB116CEF;
 Tue,  2 Jun 2020 14:20:58 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 2 Jun 2020 14:20:28 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 2 Jun 2020 14:20:28 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Tue, 2 Jun 2020 14:20:28 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Zhang Chen <chen.zhang@intel.com>, "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-dev
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH  2/3] migration/colo: Update checkpoint time lately
Thread-Topic: [PATCH  2/3] migration/colo: Update checkpoint time lately
Thread-Index: AQHWKnK/6o+OSvRiAEChbcm5SSdl0KjE9cHw
Date: Tue, 2 Jun 2020 06:20:28 +0000
Message-ID: <3baa00e889b840e096a65389fad0e763@huawei.com>
References: <20200515042818.17908-1-chen.zhang@intel.com>
 <20200515042818.17908-3-chen.zhang@intel.com>
In-Reply-To: <20200515042818.17908-3-chen.zhang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 02:20:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Hmm, How much time it spends on preparing before COLO process ?

> -----Original Message-----
> From: Zhang Chen [mailto:chen.zhang@intel.com]
> Sent: Friday, May 15, 2020 12:28 PM
> To: Dr . David Alan Gilbert <dgilbert@redhat.com>; Juan Quintela
> <quintela@redhat.com>; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
> qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Jason Wang
> <jasowang@redhat.com>; Zhang Chen <chen.zhang@intel.com>
> Subject: [PATCH 2/3] migration/colo: Update checkpoint time lately
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Previous operation(like vm_start and replication_start_all) will consume
> extra time for first forced synchronization, so reduce it in this patch.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index
> 5ef69b885d..d5bced22cb 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -531,7 +531,6 @@ static void colo_process_checkpoint(MigrationState
> *s)  {
>      QIOChannelBuffer *bioc;
>      QEMUFile *fb =3D NULL;
> -    int64_t current_time =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>      Error *local_err =3D NULL;
>      int ret;
>=20
> @@ -580,8 +579,8 @@ static void colo_process_checkpoint(MigrationState
> *s)
>      qemu_mutex_unlock_iothread();
>      trace_colo_vm_state_change("stop", "run");
>=20
> -    timer_mod(s->colo_delay_timer,
> -            current_time + s->parameters.x_checkpoint_delay);
> +    timer_mod(s->colo_delay_timer,
> qemu_clock_get_ms(QEMU_CLOCK_HOST) +
> +              s->parameters.x_checkpoint_delay);
>=20
>      while (s->state =3D=3D MIGRATION_STATUS_COLO) {
>          if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
> --
> 2.17.1


