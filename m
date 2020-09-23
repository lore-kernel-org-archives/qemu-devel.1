Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483D0C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1904238D7
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 01:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1904238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKtai-00012T-HI
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 21:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtZV-0000HV-VM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:27:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:28492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1kKtZR-0004ez-CT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 21:27:49 -0400
IronPort-SDR: y7M7zsADwO0g5x724lH0m0H73eMaAGWJ2vqJ/zOsaSekWsIcKC63CUQdE0xM2q81h9bBXiB/ea
 RtlqlHDabxkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="160037962"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="160037962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2020 18:27:42 -0700
IronPort-SDR: ervF+5BiXJQw40NYRePaBOS2FbnBqN1h8+n/l5D7Q5URslrWfSz6Lbe6URpUdpcBrqpIcnpkH+
 USkDGpgQ68LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; d="scan'208";a="338483546"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by orsmga008.jf.intel.com with ESMTP; 22 Sep 2020 18:27:41 -0700
Received: from shsmsx603.ccr.corp.intel.com (10.109.6.143) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Sep 2020 18:27:41 -0700
Received: from shsmsx605.ccr.corp.intel.com (10.109.6.215) by
 SHSMSX603.ccr.corp.intel.com (10.109.6.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Sep 2020 09:27:39 +0800
Received: from shsmsx605.ccr.corp.intel.com ([10.109.6.215]) by
 SHSMSX605.ccr.corp.intel.com ([10.109.6.215]) with mapi id 15.01.1713.004;
 Wed, 23 Sep 2020 09:27:39 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: "Rao, Lei" <lei.rao@intel.com>, "lizhijian@cn.fujitsu.com"
 <lizhijian@cn.fujitsu.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com"
 <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH v2 3/3] Fix the qemu crash when guest shutdown in COLO mode
Thread-Topic: [PATCH v2 3/3] Fix the qemu crash when guest shutdown in COLO
 mode
Thread-Index: AQHWkMSvnOgx5KBWF0+rLFDYHiz2Lql1b9iA
Date: Wed, 23 Sep 2020 01:27:39 +0000
Message-ID: <393c0cc991294715a432d682cf4b2234@intel.com>
References: <1600766690-94980-1-git-send-email-lei.rao@intel.com>
 <1600766690-94980-4-git-send-email-lei.rao@intel.com>
In-Reply-To: <1600766690-94980-4-git-send-email-lei.rao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.115; envelope-from=chen.zhang@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 21:27:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Rao, Lei <lei.rao@intel.com>
> Sent: Tuesday, September 22, 2020 5:25 PM
> To: Zhang, Chen <chen.zhang@intel.com>; lizhijian@cn.fujitsu.com;
> jasowang@redhat.com; quintela@redhat.com; dgilbert@redhat.com;
> pbonzini@redhat.com
> Cc: qemu-devel@nongnu.org; Rao, Lei <lei.rao@intel.com>
> Subject: [PATCH v2 3/3] Fix the qemu crash when guest shutdown in COLO
> mode
>=20
> In COLO mode, if the startup parameters of QEMU include "no-shutdown",
> QEMU will crash when the guest shutdown. The root cause is when the guest
> shutdown, the state of VM will switch COLO to SHUTDOWN. When do
> checkpoint again, the state will be changed to COLO. But the state switch=
 is
> undefined in runstate_transitions_def, we should add it.
> This patch fixes the following:
> qemu-system-x86_64: invalid runstate transition: 'shutdown' -> 'colo'
> Aborted
>=20
> Signed-off-by: leirao <lei.rao@intel.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Zhang Chen

> ---
>  softmmu/vl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/softmmu/vl.c b/softmmu/vl.c index f7b1034..c21606c 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -631,6 +631,7 @@ static const RunStateTransition
> runstate_transitions_def[] =3D {
>      { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
>      { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
>      { RUN_STATE_SHUTDOWN, RUN_STATE_PRELAUNCH },
> +    { RUN_STATE_SHUTDOWN, RUN_STATE_COLO },
>=20
>      { RUN_STATE_DEBUG, RUN_STATE_SUSPENDED },
>      { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
> --
> 1.8.3.1


