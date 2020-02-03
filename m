Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D252C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2B720674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gMotUJ/Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="e0dB+92i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2B720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykhl-0003gM-3Z
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 18:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iykgm-0003Dd-CW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iykgl-0008V8-0J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:59:32 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iykgk-0008NN-Es
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580770770; x=1612306770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qJp8LRvoAD0tRuPw0h9rAs+z/T/tCzSbZtSfWmE52jg=;
 b=gMotUJ/QwQiTl6lGi7XyId3a9MDHlqrwPtmizwgsJBmEr6WS2AEVDr5U
 HGVTBCD13f6H33z/wgwVeWmAlMBk+p9A6KlC8nOPkln2iFM8uL4rlG22u
 vOICWwgfuqm5lRnAPrdhO5l6JSKQ2Ag8YlCWt8Qf0lrh2MK7ysRvkU31J I=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2020 14:59:29 -0800
Received: from nasanexm01b.na.qualcomm.com ([10.85.0.82])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 03 Feb 2020 14:59:29 -0800
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01B.na.qualcomm.com (10.85.0.82) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 14:59:28 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 14:58:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Mon, 3 Feb 2020 14:58:20 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4326.namprd02.prod.outlook.com (52.135.237.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 22:58:18 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 22:58:18 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/4] linux-user: cleanup signal.c
Thread-Topic: [PATCH 2/4] linux-user: cleanup signal.c
Thread-Index: AQHV2PsSZL6C8gt6702WEKNlngEmYagKFwcg
Date: Mon, 3 Feb 2020 22:58:18 +0000
Message-ID: <BYAPR02MB48863971CD9E073FB98B130CDE000@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <20200201122746.1478003-3-laurent@vivier.eu>
In-Reply-To: <20200201122746.1478003-3-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bdbcfd9-27ee-46eb-be35-08d7a8fc8f59
x-ms-traffictypediagnostic: BYAPR02MB4326:
x-microsoft-antispam-prvs: <BYAPR02MB4326FA0B2C564F9CA16DA38CDE000@BYAPR02MB4326.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(71200400001)(66946007)(76116006)(66556008)(66476007)(66446008)(110136005)(81156014)(52536014)(8936002)(54906003)(86362001)(81166006)(64756008)(5660300002)(8676002)(186003)(26005)(53546011)(55016002)(9686003)(6506007)(316002)(7696005)(33656002)(2906002)(4326008)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4326;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4spwHcixnXBgxiNzHWoCaDrvyVGd91JuLDb3+eiZVmdkNhw/Ew8HJAl3jpP0uVYnzwtcXVobJ7qufZJ6+W6oJzbNBUbXAFlWs6E3IpWYT3AA1zcncKsgxoSqQOYUWhDgoeX4TDw3h2GZ7vLu5aL2qrnK5qG+MPozzT5nzLRMDRc4bBLu9NzKeeU+wcczshqIJlUzcinLrIlIYShx4eXN+VacKuQT/W0Goiw7iG6hRUfB7cn3iyPMxKCOWf8LIPNQ+bvY59JzIApI+8S6gtWofU1BCO6eGFv/FpDdwaSEftlyLGetLC/lHvzFuXU1DtMdCfCG1OhhBjqx6MBPE7+XJx2lb4+NkSAEHdgfS5fQ6q7/zZnLsx4VZzVBC0MrO6SvrHclRG04+s9rB0i8ML6JHU+d4wldPdZCOMYT/PMQVXYsdgZfw/g3K8xcIU6aZZh
x-ms-exchange-antispam-messagedata: xgRF1Q1qx7+Gd6Gr6Nfytm4Le+q+HPQSRjxQp8kMTla8wCkLddUNLGrZmh6aPziTu6V4hN/fq1Zu0Zdm272J+N/Bp+uYKRUSKkJ9BE2GWF9EmXAkpHpoRcqTAXnImKndSYQW8Ez4chYhO/x/X3x/Pg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvGRVbxhVLuAriIjq0IaKKLUSkGtXYhtaoOkxZ71zA5j3RVbPI98lNL62kD/RPkEcRofFj97rdVPIOzJsEnTZVTPHZ+ImkU7nG+4SL7J0u9iaF9OvF1FNN64hDQpWyuMWdwJroicQW6v3c+kallxckyDyPC0wmVN4mcY/VsXZuNciiXMHyqpmDh+lAtIdsOKop1NhQ5n7JN5JBV6ZKq2DCuGx89e3Y9m46R6krykvKvvbCg4ElvK5lV5xSXC5/30l8IUcMjFGCAKUq98L2AR5ljyuunxzrUMiQBW7nyd86WL88+yBVwMNqWHgK0ZgRXI3qxRP83TRJZ5yKd+eon4eg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPEJTI2UievOa2v1O9PCdVl8UNdzz+ZvfAZjncTtlM=;
 b=AdBEOUtc2LVpShhZZ3b9ptgxs/Kqkh7jv08u/zZmG5ZYCJ2mptCrVcFIkJ2sYYNen+F73kbZ60M5qXTV882LQhIr+hwhRPKxJps2/n9sFUQiaZujnJPkjBHr0jJqQg2rpWSKBSxKkEsNQ2yyPxykFJ78wzJ7DiXpRoiXmjbDitOdYk/CEcJ2bna8yPubiJG4kPASjA/kfH0KP4WlSY0YnUupcHwhWuJ9apwELnCI3SFHNtfewWHPLwfAmTYTPm+M8c8aejEN7bA8PcQ78wIEBO2RTiHMpXNGhH+AnYpBSRy8vPNwEjqYjuiwLXUNwK3EarfVpRNGRF5AKUVQbBuDFA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMPEJTI2UievOa2v1O9PCdVl8UNdzz+ZvfAZjncTtlM=;
 b=e0dB+92imWVxZtM+DTvwHb+9CLhJpKKmnK9RFHi7tBXYxFW+WAo9K+hz+RjniSWr0Z93qcN5ZfwD55U3wTBq2eT6UexhgjNc4w3ounnZOpn804nIEZlmv0BSv33YpxtzFKXG45vIyeCH3FU6tOUH7/8jqTdOweFaLxsFYCNCq1o=
x-ms-exchange-crosstenant-network-message-id: 7bdbcfd9-27ee-46eb-be35-08d7a8fc8f59
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2020 22:58:18.5723 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: r9Ya4MjScyZznKr1uPXB5ByW7S+6z5kzT2v8Lyl5FCsYx6Egqq29NqP1BBNYz4+8rX65cRnSnWV0fc442SWd2w==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4326
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marlies Ruck <marlies.ruck@gmail.com>, Riku
 Voipio <riku.voipio@iki.fi>, Aleksandar
 Markovic <aleksandar.markovic@rt-rk.com>, Josh Kunz <jkz@google.com>,
 Matus Kysel <mkysel@tachyum.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Saturday, February 1, 2020 6:28 AM
> To: qemu-devel@nongnu.org
> Cc: Josh Kunz <jkz@google.com>; milos.stojanovic@rt-rk.com; Matus Kysel
> <mkysel@tachyum.com>; Aleksandar Markovic <aleksandar.markovic@rt-
> rk.com>; Marlies Ruck <marlies.ruck@gmail.com>; Laurent Vivier
> <laurent@vivier.eu>; Peter Maydell <peter.maydell@linaro.org>; Taylor
> Simpson <tsimpson@quicinc.com>; Riku Voipio <riku.voipio@iki.fi>
> Subject: [PATCH 2/4] linux-user: cleanup signal.c
>
> -------------------------------------------------------------------------
> CAUTION: This email originated from outside of the organization.
> -------------------------------------------------------------------------
>
> No functionnal changes. Prepare the field for future fixes.


Spelling error

>
> Remove memset(.., 0, ...) that is useless on a static array
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c index
> 5ca6d62b15d3..f42a2e1a82a5 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -66,12 +66,6 @@ static uint8_t host_to_target_signal_table[_NSIG] =3D =
{
>      [SIGPWR] =3D TARGET_SIGPWR,
>      [SIGSYS] =3D TARGET_SIGSYS,
>      /* next signals stay the same */
> -    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> -       host libpthread signals.  This assumes no one actually uses SIGRT=
MAX :-/
> -       To fix this properly we need to do manual signal delivery multipl=
exed
> -       over a single host signal.  */
> -    [__SIGRTMIN] =3D __SIGRTMAX,
> -    [__SIGRTMAX] =3D __SIGRTMIN,
>  };
>  static uint8_t target_to_host_signal_table[_NSIG];
>
> @@ -480,13 +474,18 @@ static int core_dump_signal(int sig)
>      }
>  }
>
> -void signal_init(void)
> +static void signal_table_init(void)
>  {
> -    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> -    struct sigaction act;
> -    struct sigaction oact;
>      int i, j;
> -    int host_sig;
> +
> +    /*
> +     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> +     * host libpthread signals.  This assumes no one actually uses SIGRT=
MAX :-
> /
> +     * To fix this properly we need to do manual signal delivery multipl=
exed
> +     * over a single host signal.
> +     */
> +    host_to_target_signal_table[__SIGRTMIN] =3D __SIGRTMAX;
> +    host_to_target_signal_table[__SIGRTMAX] =3D __SIGRTMIN;
>
>      /* generate signal conversion tables */
>      for(i =3D 1; i < _NSIG; i++) {
> @@ -497,14 +496,22 @@ void signal_init(void)
>          j =3D host_to_target_signal_table[i];

Since you are cleaning up this code, let's give this a more descriptive nam=
e - target_sig would be consistent with host_sig used elsewhere.

>          target_to_host_signal_table[j] =3D i;
>      }
> +}
> +
> +void signal_init(void)
> +{
> +    TaskState *ts =3D (TaskState *)thread_cpu->opaque;
> +    struct sigaction act;
> +    struct sigaction oact;
> +    int i;
> +    int host_sig;
> +
> +    /* initialize signal conversion tables */
> +    signal_table_init();
>
>      /* Set the signal mask from the host mask. */
>      sigprocmask(0, 0, &ts->signal_mask);
>
> -    /* set all host signal handlers. ALL signals are blocked during
> -       the handlers to serialize them. */
> -    memset(sigact_table, 0, sizeof(sigact_table));
> -
>      sigfillset(&act.sa_mask);
>      act.sa_flags =3D SA_SIGINFO;
>      act.sa_sigaction =3D host_signal_handler;
> --
> 2.24.1
>


