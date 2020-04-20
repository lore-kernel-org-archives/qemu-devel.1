Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD11C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC7720A8B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 08:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7720A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQS7F-0000br-1i
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 04:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59440 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1jQS6a-00008N-UQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:48:41 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1jQS6Z-0006pc-MW
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:48:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:36742 helo=huawei.com)
 by eggs1p.gnu.org with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1jQS6Y-0006Vy-VJ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 04:48:39 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 4F43D98CD49B88267A31;
 Mon, 20 Apr 2020 16:48:24 +0800 (CST)
Received: from dggeme708-chm.china.huawei.com (10.1.199.104) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 20 Apr 2020 16:48:23 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme708-chm.china.huawei.com (10.1.199.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 20 Apr 2020 16:48:23 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Mon, 20 Apr 2020 16:48:23 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
Thread-Topic: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
Thread-Index: AQHWFu5Lx3oLB8QvGEyC5OL8XOq+3KiBsuqA
Date: Mon, 20 Apr 2020 08:48:23 +0000
Message-ID: <fd2df283d2824bb28278f2d057b1b0e7@huawei.com>
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-12-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-12-armbru@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.214.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 04:48:25
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: Zhang Chen <chen.zhang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> -----Original Message-----
> From: Markus Armbruster [mailto:armbru@redhat.com]
> Sent: Monday, April 20, 2020 4:33 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang Chen <chen.zhang@intel.com>; Zhanghailiang
> <zhang.zhanghailiang@huawei.com>
> Subject: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
> error handling
>=20
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>=20
> qmp_xen_colo_do_checkpoint() passes @errp first to
> replication_do_checkpoint_all(), and then to
> colo_notify_filters_event().  If both fail, this will trip the
> assertion in error_setv().
>=20
> Similar code in secondary_vm_do_failover() calls
> colo_notify_filters_event() only after replication_do_checkpoint_all()
> succeeded.  Do the same here.
>=20
> Fixes: 0e8818f023616677416840d6ddc880db8de3c967
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/colo.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c
> index a54ac84f41..1b3493729b 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -263,7 +263,13 @@ ReplicationStatus
> *qmp_query_xen_replication_status(Error **errp)
>=20
>  void qmp_xen_colo_do_checkpoint(Error **errp)
>  {
> -    replication_do_checkpoint_all(errp);
> +    Error *err =3D NULL;
> +
> +    replication_do_checkpoint_all(&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      /* Notify all filters of all NIC to do checkpoint */
>      colo_notify_filters_event(COLO_EVENT_CHECKPOINT, errp);
>  }
> --
> 2.21.1


