Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9879C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766C520721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C6PGDngS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Zfljjb+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766C520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykxL-0000EW-LQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 18:16:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iykw8-0007uz-8J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iykw6-0007a9-FP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:15:24 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iykw6-0007So-1E
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580771722; x=1612307722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IFl/NAB0ZWJTh7EHnNbzwLMgqK2bHNniiO/TjlW3b4A=;
 b=C6PGDngS15GtiDbgerAXH09gYHChms58b5MVp4w3Llyc7b7UONPhQjp5
 8CzXkv3SNBluSY/IpoY2vzZ56licKOVTn8idE15G4ZAaJiWgCT8cUo02U
 0yqxdtJC1C9XYKkIPseZNybKHSZmUxyNAv9WznUnGh6RnJ4wjj/FA4/6h M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2020 15:15:20 -0800
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 03 Feb 2020 15:15:20 -0800
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 15:15:19 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 15:15:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Mon, 3 Feb 2020 15:15:17 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5688.namprd02.prod.outlook.com (20.178.1.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 23:15:16 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 23:15:15 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 4/4] linux-user: fix use of SIGRTMIN
Thread-Topic: [PATCH 4/4] linux-user: fix use of SIGRTMIN
Thread-Index: AQHV2PsS+TUPFcT/1kGo3Hk7Vg9fq6gKG0eg
Date: Mon, 3 Feb 2020 23:15:15 +0000
Message-ID: <BYAPR02MB4886C76B91E2A07B47F819A9DE000@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <20200201122746.1478003-5-laurent@vivier.eu>
In-Reply-To: <20200201122746.1478003-5-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d0d3b3-e12d-471f-d2a7-08d7a8feeda1
x-ms-traffictypediagnostic: BYAPR02MB5688:
x-microsoft-antispam-prvs: <BYAPR02MB5688C531E1AA7A8D17A40915DE000@BYAPR02MB5688.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(33656002)(86362001)(2906002)(7696005)(71200400001)(4326008)(26005)(81166006)(81156014)(8676002)(186003)(66446008)(316002)(8936002)(110136005)(54906003)(6506007)(478600001)(52536014)(5660300002)(66946007)(76116006)(53546011)(66556008)(66476007)(64756008)(9686003)(55016002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5688;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBeN/ppEU0oc+4Rz3GGRD/aVlj2tJ7vMof08bRLhlB8ucGpDpKmrsS+stTcs85+sxHXZK5mTDDVTLz8jpyj0PbNYA9565qYkclPIIiFXZ3fmiWoRuxMfqZMkbC5f1qab27uQwGVAIYbxn2azuf+3ay58vjKowKnp1aU2mTcKcsC89Pj1RREam2gs53J8xl12maFisEaeAOq2RjZdeadaPP0LpfCsMfok9I2Bs33Xu3f4WzvQn2sXbQ/EE8dbKkmjIGfJTdiZLZnlJry0eqmJu96W24Lu74ZbLTph+UP0lE90pMO9Nie5s2UH/UGSRAPxAIG3tjEewNfUFgHoQcKVcPfauNkVP1P/XHhA6WedlZ40XJarWnC6JOHkc2yAHp33nLccGV2lfoVfu88gxcCaJVutI9jp9PpZDK0v/7qxaE4Xw2JX+HAsk7fu+KUP45m3
x-ms-exchange-antispam-messagedata: OcUfbRdQZA8i9FLutGDhHngU8HCkFpWxlJnNdyCkruTvUF3GRHc5BzFle8X7sMo3vm3CYyw1A9k7qcyo7nA2xHVfxT9tnZatYMF3W60nA4PB4uanwg+9tPL1YkAUjei5nPFlM3aTqD5oqOrgY2R21A==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBpocxfk06oMFuXNTUR0/Cu0dqwCoUb2SPp1ere+XiM4udDC+gLuWtoDiywqtFInf7e7NXknLxYzMW2CcBCuEJjoLHxSnak8vE8Gjn+fS6DwbMCKG7sdxUEbXRke8IFVLKUwHN7NVENRRT7l+d/rapdfdVVMRaKlCFsrpRRSRB2310onqm/81gYiO4CzJLtnYSHfkIOZcM0HHQrXKVHpNrXrCHrd4ycb+UaVfecJHL2CQV7J0u03f6VHnNvGh3PZJkU943m/R9pTcYoKD0uzZeoH8U0Dxwcrb0OC6VORGBN6rwZPb0Y8swrLm63b6qc+Z6goGiL8XuJlKqmR6zAzUQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVfd2hPNat58mR0yHalh37Qr6zGFIqGduYw2QOxU5A8=;
 b=jZwkjmBBymC82IaE6uFdkhjIc1Ol8Jzu1UBUmAT9eyLJNr11cMIIXdI+g6ghHhclPafIDUaKuQ+C4R5eBBcirtvaLIe6t4QJ3bgrKmYviBF7s6dwZmnuZdwtN8x6Tovxq1Q2DgXovDWoNVJxK+3sY2EkXjxCiFWu4e4C2/y3nt4B/wPJigGZZ4rJNas/VtoZYAekjPZldYCXtfggWPzqZh6m5FO2hETZi33Akx+CDmBMgk9m5K0zDshF+UmNhcwzMFqW9Z5iQWo2oslwpVnchIRZRf4uqFjfzK17LU4loJf9eZi386Ay2M9ret0wz6y5kACZg8TGrRdKk9/+4zEsfQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVfd2hPNat58mR0yHalh37Qr6zGFIqGduYw2QOxU5A8=;
 b=Zfljjb+1jNnTGcrJP8mFY8wnh1utQeuzjT7PEIvPcvmZnIGkhtH1HUCsHIFJuv0lL0jv9EZ0j1oOkBcZk7wmjRPOwrPULy1ySHIqPVpXw4QKA6iIMEdrmucpLsS4aVMaIj9gl+ByUAJDUedweD5SH8MVVST/YDBrJB9xw/wXb4c=
x-ms-exchange-crosstenant-network-message-id: 99d0d3b3-e12d-471f-d2a7-08d7a8feeda1
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2020 23:15:15.6880 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: lujVthVB0H6G6pjqs0MjK3iApD60Qk4asBKlnPi3TUWu6ef7s84BDebEgL/fkfHTH1L2SAydV/X2l74yTExHMg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5688
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
> Subject: [PATCH 4/4] linux-user: fix use of SIGRTMIN
>
> Some RT signals can be in use by glibc,
> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>
> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>
> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the range
> [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>       [__SIGRTMIN + X ... SIGRTMAX ]
> (SIGRTMIN is __SIGRTMIN + X).
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c     | 34 ++++++++++++++++++++++++++++------
>  linux-user/trace-events |  3 +++
>  2 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c index
> 3491f0a7ecb1..c4abacde49a0 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -501,15 +501,20 @@ static void signal_table_init(void)
>      int i, j;
>
>      /*
> -     * Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
> -     * host libpthread signals.  This assumes no one actually uses SIGRT=
MAX :-/
> -     * To fix this properly we need to do manual signal delivery multipl=
exed
> -     * over a single host signal.
> +     * some RT signals can be in use by glibc,
> +     * it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32)
>       */
> -    host_to_target_signal_table[__SIGRTMIN] =3D __SIGRTMAX;
> -    host_to_target_signal_table[__SIGRTMAX] =3D __SIGRTMIN;
> +    for (i =3D SIGRTMIN; i <=3D SIGRTMAX; i++) {
> +        j =3D i - SIGRTMIN + TARGET_SIGRTMIN;
> +        if (j <=3D TARGET_NSIG) {
> +            host_to_target_signal_table[i] =3D j;
> +        }
> +    }
>
>      /* generate signal conversion tables */
> +    for (i =3D 1; i <=3D TARGET_NSIG; i++) {
> +        target_to_host_signal_table[i] =3D _NSIG; /* poison */
> +    }
>      for (i =3D 1; i < _NSIG; i++) {
>          if (host_to_target_signal_table[i] =3D=3D 0) {
>              host_to_target_signal_table[i] =3D i; @@ -519,6 +524,15 @@ s=
tatic void
> signal_table_init(void)
>              target_to_host_signal_table[j] =3D i;
>          }
>      }
> +
> +    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
> +        for (i =3D 1, j =3D 0; i <=3D TARGET_NSIG; i++) {
> +            if (target_to_host_signal_table[i] =3D=3D _NSIG) {
> +                j++;
> +            }
> +        }
> +        trace_signal_table_init(j);

It looks like j will have a count of the number of poison entries, but the =
message in trace_signal_table_init is "missing signal number".  Is that wha=
t you intend?

> +    }
>  }
>
>  void signal_init(void)
> @@ -817,6 +831,8 @@ int do_sigaction(int sig, const struct target_sigacti=
on
> *act,
>      int host_sig;
>      int ret =3D 0;
>
> +    trace_signal_do_sigaction_guest(sig, TARGET_NSIG);

Shouldn't this be _NSIG, not TARGET_NSIG?

> +
>      if (sig < 1 || sig > TARGET_NSIG || sig =3D=3D TARGET_SIGKILL || sig=
 =3D=3D
> TARGET_SIGSTOP) {
>          return -TARGET_EINVAL;
>      }
> @@ -847,6 +863,12 @@ int do_sigaction(int sig, const struct target_sigact=
ion
> *act,
>
>          /* we update the host linux signal state */
>          host_sig =3D target_to_host_signal(sig);
> +        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
> +        if (host_sig > SIGRTMAX) {
> +            /* we don't have enough host signals to map all target signa=
ls */
> +            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d\n",
> sig);
> +            return -TARGET_EINVAL;
> +        }
>          if (host_sig !=3D SIGSEGV && host_sig !=3D SIGBUS) {
>              sigfillset(&act1.sa_mask);
>              act1.sa_flags =3D SA_SIGINFO; diff --git a/linux-user/trace-=
events
> b/linux-user/trace-events index f6de1b8befc0..eb4b7701c400 100644
> --- a/linux-user/trace-events
> +++ b/linux-user/trace-events
> @@ -1,6 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
>  # signal.c
> +signal_table_init(int i) "missing signal number: %d"
> +signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
> +signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
>  # */signal.c
>  user_setup_frame(void *env, uint64_t frame_addr) "env=3D%p
> frame_addr=3D0x%"PRIx64  user_setup_rt_frame(void *env, uint64_t
> frame_addr) "env=3D%p frame_addr=3D0x%"PRIx64
> --
> 2.24.1
>


