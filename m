Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E4DC54FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5C52082E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 00:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5C52082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQgjH-0006pE-JQ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 20:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jQgiN-0005eV-Lx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chen.zhang@intel.com>) id 1jQgiM-0003DC-Ef
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:24:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:38154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jQgiJ-00037K-2I
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 20:24:36 -0400
IronPort-SDR: T6MJNpFoe2ER0L3NR4fCu56Q7XpjzHUdaVPzo0++UslfmrhrFAKsdVVHlBXqUidgIVSjg0sliz
 BvdsYRawgKmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2020 17:24:20 -0700
IronPort-SDR: 2LhoQLHoxPaVUkFhX6AkCKG2DlAZwihF/Oq1CwTTAmJ2ntxe1S/cP5BcMlnXYDYVCgFKdETmj4
 4/uGrQ4oHamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; d="scan'208";a="456568996"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by fmsmga006.fm.intel.com with ESMTP; 20 Apr 2020 17:24:20 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 17:24:19 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 Apr 2020 08:24:17 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Tue, 21 Apr 2020 08:24:17 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
Thread-Topic: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
 error handling
Thread-Index: AQHWFu5GgFJpcwjdbk6MmDAIPN81IKiCt3Bw
Date: Tue, 21 Apr 2020 00:24:17 +0000
Message-ID: <b723c142f1ac4661bcc1593ed4eb4c32@intel.com>
References: <20200420083236.19309-1-armbru@redhat.com>
 <20200420083236.19309-12-armbru@redhat.com>
In-Reply-To: <20200420083236.19309-12-armbru@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mga09.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/20 20:24:21
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.24
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Monday, April 20, 2020 4:33 PM
> To: qemu-devel@nongnu.org
> Cc: Zhang, Chen <chen.zhang@intel.com>; zhanghailiang
> <zhang.zhanghailiang@huawei.com>
> Subject: [PATCH 11/11] migration/colo: Fix qmp_xen_colo_do_checkpoint()
> error handling
>=20
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the latter=
 kind
> twice without clearing it in between is wrong: if the first call sets an =
error, it
> no longer points to NULL for the second call.
>=20
> qmp_xen_colo_do_checkpoint() passes @errp first to
> replication_do_checkpoint_all(), and then to colo_notify_filters_event().=
  If
> both fail, this will trip the assertion in error_setv().
>=20
> Similar code in secondary_vm_do_failover() calls
> colo_notify_filters_event() only after replication_do_checkpoint_all()
> succeeded.  Do the same here.
>=20
> Fixes: 0e8818f023616677416840d6ddc880db8de3c967
> Cc: Zhang Chen <chen.zhang@intel.com>
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Looks good for me.

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  migration/colo.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index a54ac84f41..1b3493=
729b
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -263,7 +263,13 @@ ReplicationStatus
> *qmp_query_xen_replication_status(Error **errp)
>=20
>  void qmp_xen_colo_do_checkpoint(Error **errp)  {
> -    replication_do_checkpoint_all(errp);
> +    Error *err =3D NULL;
> +
> +    replication_do_checkpoint_all(&err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      /* Notify all filters of all NIC to do checkpoint */
>      colo_notify_filters_event(COLO_EVENT_CHECKPOINT, errp);  }
> --
> 2.21.1


