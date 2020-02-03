Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D13C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC9320674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 23:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U3JxclCJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="MQKrW7S1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC9320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykj1-0004oJ-OO
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 18:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iyki5-0004DP-2O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iyki3-0004Iz-JP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:00:53 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:41109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iyki3-0004EO-9G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 18:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580770851; x=1612306851;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+vic7zT5+Mx0cUIgKKgfXBn8UhFa73+gAfYDfl0FRy0=;
 b=U3JxclCJqNHMjhxHWDenmFTmoYcQxQGNDhJSJvP6FOuBbWGBZ6YDD1j5
 tSHl8AjkMHazYj/aKpqtBN45AkaAt296kJykLhc5QzPgmyamMVHzayWfG
 o1aIraEd453Q2bETRgd7fgHpYoKeQsaktsxPsr7e8OtDOs71nveY8Tfg2 s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Feb 2020 15:00:49 -0800
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 03 Feb 2020 15:00:49 -0800
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 15:00:48 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Mon, 3 Feb 2020 15:00:48 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4054.namprd02.prod.outlook.com (20.176.250.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Mon, 3 Feb 2020 23:00:47 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 23:00:47 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
Thread-Topic: [PATCH 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
Thread-Index: AQHV2PsSbsrvTs0bI0G7Jt8ShCdK5qgKGOfw
Date: Mon, 3 Feb 2020 23:00:47 +0000
Message-ID: <BYAPR02MB488667BE768D5270F9F6B9C9DE000@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200201122746.1478003-1-laurent@vivier.eu>
 <20200201122746.1478003-4-laurent@vivier.eu>
In-Reply-To: <20200201122746.1478003-4-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9eb93fd8-7526-40d2-f454-08d7a8fce849
x-ms-traffictypediagnostic: BYAPR02MB4054:
x-microsoft-antispam-prvs: <BYAPR02MB4054CD3690E14C48EFB60F07DE000@BYAPR02MB4054.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(53546011)(6506007)(110136005)(86362001)(2906002)(52536014)(8936002)(8676002)(316002)(478600001)(64756008)(66476007)(66556008)(26005)(76116006)(66946007)(66446008)(81166006)(81156014)(33656002)(54906003)(4326008)(71200400001)(5660300002)(9686003)(55016002)(7696005)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4054;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dU9pfhkd/K0wg3znmZVT12sBwFVFfIlw8J8iStO1vwndKz3uwuG4Sa+hbClclVzoQ+Irf669q7jsZhiCMANtaLpJ91xQJpmTIHfZ7nScHUwSSOP6woOqKsTGGSk8F7BuijwZjHvKwny5tkE0toaY2KMUjccFR3EtRZHUyppVeu2ySUJMlnTej54hOsBKB8yuBuCs7G7exvOQNNbTkvhAh8g3xwvUzPQDZYGMyoK/LjTb7liV8soR9WcmhB/dfL7ENpQYxc8zGYvyblrY87cHbwrZUIwKtbt6rQKgy608iILrtoFOdSpszjm3nnU+apK+O/RNcD+QvFfmxoAFYeei6L2hwRKxAX87REZcPVf4LzY9h9/Qm2txzT1wVALi0sBeOs4XFHEtQhAjcO/b9D4d8dP/QFAMJiiD11AMcqJsJ7Ev8JqqWFyiXg30NhgSv1o5
x-ms-exchange-antispam-messagedata: 6jjQPhouS5H09AAhzONYnNyJg0R4EeqlC1HzF8U3Fs2VNBvlofSi0z3fFAUP1naIIESH005eDYtPwPfFM/Wv454bhBSIfy0yM1sYvXdbpdlAuwcH0UTrs2QfHRl7NQTo+BAO+19l5zafqkd7hkfKog==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i99Nzxib2PA+mQMtV9GG6SsDoOJbZJKm+TSt7vGToYV9Mbw9YdWK2p//zbTb6lkx1CwNl7eSTd/SjE1oFmw1bCObZkz/YDaAPnZOMR/MiQc/OvYVUi39ze7Z7K9cnBBGp/9yuveWwkCnao5nRNethZls1pMYmOOpaMO1ALJvKdQpXv/mVJJMtUJ8fPlU3UYe7YtNVflS8eGgvwN0w97VWKbW6aX2RCsGQB8VE7Vj6keRAXCjqHBji4C175zWGkF6n6/lwtrJHWJ7tW/ovuY+JGiOcxCf9FkWv0xpYe57Ex78nJU+5fAxDTxoFa6V1aH4TbONt68kgfvtdyA+wZX0mA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CI97VRJvMkdZCuMEisDwxceTUneR1rAbBfU8XEhFp8=;
 b=FFbUIWUzz+PYjnAwPC1wp1ROeng/WfVk9NzWybSJ3BuzBPprm/GsNxP6VUK+zJ/mUMwiS5rEzrOhzEfAaSlsYZXzou5Q25rFDk+BoRkpzqnuEWXKHxYR3yxnir8yxS7p6m1itRh4t9l7JJ5evopKqRl1vlnBhuKS/dBYJ22RuwjIbZs4+JMP7Lz5WDCWhjfgYVHDPKSh5fArIfVSW0s4PE3poynB/1ghBTLVfAoDQhoyV1Lq22PJP6v2BkmJ3MHLHR7N/HZtNtqvodYOUgy9Z7BmMCCUzo0yak0k0EIvpW04SvdP1t+jcxz8p8XEJjf2XQrXDEQisXzJcn7W5Yfmfg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CI97VRJvMkdZCuMEisDwxceTUneR1rAbBfU8XEhFp8=;
 b=MQKrW7S12FG/eTW5GKbaLKsDHBzbqjGxoODNipoSVXuG8qiJWmJwrlLjJHXfv96c3kbovFNEsu6MkA20pumbHydtxdGtMvIMbV3f0rUxunqbl8+jWsNFqAON0AbDdVb5GjbPvibtfsAAqc27lTDymQmZMhPSG+kJPzHHnvob1RA=
x-ms-exchange-crosstenant-network-message-id: 9eb93fd8-7526-40d2-f454-08d7a8fce849
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2020 23:00:47.7370 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: DqpqHFaFx4F35Hogj6jkg/f4RcrRzkzFDLokUBipRtKcgsoiLP6szRKK8/TZ+ODLLA9Yup/LfjTm3nn60iqGzw==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4054
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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
> Subject: [PATCH 3/4] linux-user: fix TARGET_NSIG and _NSIG uses
>
> Valid signal numbers are between 1 (SIGHUP) and SIGRTMAX.
>
> System includes define _NSIG to SIGRTMAX + 1, but QEMU (like kernel)
> defines TARGET_NSIG to TARGET_SIGRTMAX.
>
> Fix all the checks involving the signal range.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 51 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 14 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c index
> f42a2e1a82a5..3491f0a7ecb1 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -30,6 +30,15 @@ static struct target_sigaction
> sigact_table[TARGET_NSIG];  static void host_signal_handler(int
> host_signum, siginfo_t *info,
>                                  void *puc);
>
> +
> +/*
> + * System includes define _NSIG as SIGRTMAX + 1,
> + * but qemu (like the kernel) defines TARGET_NSIG as TARGET_SIGRTMAX
> + * and the first signal is SIGHUP defined as 1
> + * Signal number 0 is reserved for use as kill(pid, 0), to test whether
> + * a process exists without sending it a signal.
> + */
> +QEMU_BUILD_BUG_ON(__SIGRTMAX + 1 !=3D _NSIG);
>  static uint8_t host_to_target_signal_table[_NSIG] =3D {
>      [SIGHUP] =3D TARGET_SIGHUP,
>      [SIGINT] =3D TARGET_SIGINT,
> @@ -67,19 +76,24 @@ static uint8_t host_to_target_signal_table[_NSIG] =3D=
 {
>      [SIGSYS] =3D TARGET_SIGSYS,
>      /* next signals stay the same */
>  };
> -static uint8_t target_to_host_signal_table[_NSIG];
>
> +static uint8_t target_to_host_signal_table[TARGET_NSIG + 1];
> +
> +/* valid sig is between 1 and _NSIG - 1 */
>  int host_to_target_signal(int sig)
>  {
> -    if (sig < 0 || sig >=3D _NSIG)
> +    if (sig < 1 || sig >=3D _NSIG) {
>          return sig;
> +    }
>      return host_to_target_signal_table[sig];  }
>
> +/* valid sig is between 1 and TARGET_NSIG */
>  int target_to_host_signal(int sig)
>  {
> -    if (sig < 0 || sig >=3D _NSIG)
> +    if (sig < 1 || sig > TARGET_NSIG) {
>          return sig;
> +    }
>      return target_to_host_signal_table[sig];  }
>
> @@ -100,11 +114,15 @@ static inline int target_sigismember(const
> target_sigset_t *set, int signum)  void
> host_to_target_sigset_internal(target_sigset_t *d,
>                                      const sigset_t *s)  {
> -    int i;
> +    int i, j;
>      target_sigemptyset(d);
> -    for (i =3D 1; i <=3D TARGET_NSIG; i++) {
> +    for (i =3D 1; i < _NSIG; i++) {
> +        j =3D host_to_target_signal(i);

More descriptive name - target_sig

> +        if (j < 1 || j > TARGET_NSIG) {
> +            continue;
> +        }
>          if (sigismember(s, i)) {
> -            target_sigaddset(d, host_to_target_signal(i));
> +            target_sigaddset(d, j);
>          }
>      }
>  }
> @@ -122,11 +140,15 @@ void host_to_target_sigset(target_sigset_t *d,
> const sigset_t *s)  void target_to_host_sigset_internal(sigset_t *d,
>                                      const target_sigset_t *s)  {
> -    int i;
> +    int i, j;
>      sigemptyset(d);
>      for (i =3D 1; i <=3D TARGET_NSIG; i++) {
> +        j =3D target_to_host_signal(i);

More descriptive name - host_sig

> +        if (j < 1 || j >=3D _NSIG) {
> +            continue;
> +        }
>          if (target_sigismember(s, i)) {
> -            sigaddset(d, target_to_host_signal(i));
> +            sigaddset(d, j);
>          }
>      }
>  }
> @@ -488,13 +510,14 @@ static void signal_table_init(void)
>      host_to_target_signal_table[__SIGRTMAX] =3D __SIGRTMIN;
>
>      /* generate signal conversion tables */
> -    for(i =3D 1; i < _NSIG; i++) {
> -        if (host_to_target_signal_table[i] =3D=3D 0)
> +    for (i =3D 1; i < _NSIG; i++) {
> +        if (host_to_target_signal_table[i] =3D=3D 0) {
>              host_to_target_signal_table[i] =3D i;
> -    }
> -    for(i =3D 1; i < _NSIG; i++) {
> +        }
>          j =3D host_to_target_signal_table[i];

More descriptive name - target_sig

> -        target_to_host_signal_table[j] =3D i;
> +        if (j <=3D TARGET_NSIG) {
> +            target_to_host_signal_table[j] =3D i;
> +        }
>      }
>  }
>
> @@ -517,7 +540,7 @@ void signal_init(void)
>      act.sa_sigaction =3D host_signal_handler;
>      for(i =3D 1; i <=3D TARGET_NSIG; i++) {  #ifdef TARGET_GPROF
> -        if (i =3D=3D SIGPROF) {
> +        if (i =3D=3D TARGET_SIGPROF) {
>              continue;
>          }
>  #endif
> --
> 2.24.1
>


