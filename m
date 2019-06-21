Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A45C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 067FF2089E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 06:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 067FF2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55088 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDNA-0001S0-Uq
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 02:50:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chen.zhang@intel.com>) id 1heDKY-00084e-NK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chen.zhang@intel.com>) id 1heD8f-0000lI-Gv
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 02:35:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:12437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chen.zhang@intel.com>)
 id 1heD8b-0000iy-Hx; Fri, 21 Jun 2019 02:35:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Jun 2019 23:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; d="scan'208";a="162589934"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2019 23:35:04 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Jun 2019 23:35:04 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Jun 2019 23:35:04 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.33]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.236]) with mapi id 14.03.0439.000;
 Fri, 21 Jun 2019 14:35:02 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Xie Changlong <xiechanglong.d@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-dev
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH V2] block/replication.c: Fix crash issue after failover
Thread-Index: AQHVJ/Yhc4bDu8Fa3kC2VE1u3MqwPaalpqJQ
Date: Fri, 21 Jun 2019 06:35:01 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780618ACFD@shsmsx102.ccr.corp.intel.com>
References: <20190621055202.28270-1-chen.zhang@intel.com>
In-Reply-To: <20190621055202.28270-1-chen.zhang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTBmNGY2ZTQtYzdhNS00M2ZlLThmZGYtMGJjOTE1OTJlMWY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicW9rckpwN1FcL3Rpemthb2NUTlhpSGZmSWRac2FRcG1iWEZQOGxOanVcLzhEYWhiMW50QUYwdlRabThxcWo1VStuIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: Re: [Qemu-devel] [PATCH V2] block/replication.c: Fix crash issue
 after failover
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
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Please redirect to the V2 RESEND patch, this one not rebased on upstream co=
de.

Thanks
Zhang Chen


> -----Original Message-----
> From: Zhang, Chen
> Sent: Friday, June 21, 2019 1:52 PM
> To: Xie Changlong <xiechanglong.d@gmail.com>; Kevin Wolf
> <kwolf@redhat.com>; Max Reitz <mreitz@redhat.com>; qemu-block <qemu-
> block@nongnu.org>; qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH V2] block/replication.c: Fix crash issue after failover
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> If we try to close replication after failover, it will crash here.
> So we need check the block job on active disk before cancel the job.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  block/replication.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/replication.c b/block/replication.c index
> 3d4dedddfc..845f796dd4 100644
> --- a/block/replication.c
> +++ b/block/replication.c
> @@ -146,7 +146,9 @@ static void replication_close(BlockDriverState *bs)
>          replication_stop(s->rs, false, NULL);
>      }
>      if (s->stage =3D=3D BLOCK_REPLICATION_FAILOVER) {
> -        job_cancel_sync(&s->active_disk->bs->job->job);
> +        if (s->active_disk->bs->job) {
> +            job_cancel_sync(&s->active_disk->bs->job->job);
> +        }
>      }
>=20
>      if (s->mode =3D=3D REPLICATION_MODE_SECONDARY) {
> --
> 2.17.GIT


