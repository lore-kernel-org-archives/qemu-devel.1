Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9038C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:34:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C192072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 22:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k0+KRpzW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="l1ys6n31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C192072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izTFA-000301-GU
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 17:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1izTE9-00021n-R5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:32:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1izTE7-0005Qc-0Q
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:32:57 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35825)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1izTE6-0005Jk-3o
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 17:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580941974; x=1612477974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wEf/5NkHCbC1azbhi5gfc+wq2OWKO1bpq1IsF4UdmRo=;
 b=k0+KRpzWNheDqAxHgHZaeagNuqUiVBKOvII8mKiFmbRt+EZ3hA5ai53C
 vWR4sBpKZ39ZNL9onY+ftGnZj81IAZvMW5xCI+fZQWecAiaZ+0ZMQLacn
 u/UBs/8IxAeDdjSpZmVAjbv0hca3BJTDBVh/AW8WGRHK3dQ1MHBAg20Im g=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Feb 2020 14:32:50 -0800
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 05 Feb 2020 14:32:50 -0800
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 5 Feb 2020 14:32:49 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 5 Feb 2020 14:32:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 5 Feb 2020 14:32:47 -0800
Received: from SN6PR02MB4895.namprd02.prod.outlook.com (52.135.113.208) by
 SN6PR02MB4046.namprd02.prod.outlook.com (52.135.71.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 22:32:46 +0000
Received: from SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::4d4:4ae5:df44:3251]) by SN6PR02MB4895.namprd02.prod.outlook.com
 ([fe80::4d4:4ae5:df44:3251%4]) with mapi id 15.20.2686.035; Wed, 5 Feb 2020
 22:32:46 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
Thread-Topic: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
Thread-Index: AQHV234sPf5/KbVOnU6JGv7G5BvFiqgNMSjA
Date: Wed, 5 Feb 2020 22:32:46 +0000
Message-ID: <SN6PR02MB4895DCA5CF60647F105F37A1DE020@SN6PR02MB4895.namprd02.prod.outlook.com>
References: <20200204171053.1718013-1-laurent@vivier.eu>
 <20200204171053.1718013-5-laurent@vivier.eu>
In-Reply-To: <20200204171053.1718013-5-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40a40dab-b154-4917-de73-08d7aa8b531a
x-ms-traffictypediagnostic: SN6PR02MB4046:
x-microsoft-antispam-prvs: <SN6PR02MB4046F567EB0B9C600820AC2BDE020@SN6PR02MB4046.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(478600001)(2906002)(186003)(316002)(4326008)(53546011)(26005)(6506007)(33656002)(55016002)(9686003)(71200400001)(66946007)(66446008)(64756008)(66556008)(5660300002)(66476007)(8936002)(76116006)(110136005)(54906003)(7696005)(52536014)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN6PR02MB4046;
 H:SN6PR02MB4895.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsGlAkCMAkHb26wXAHf+fqVw3buw+w2v1PIpU1yfg5kbKkWoG8Adwir5ZiJc4i8DSJUeCFacIJVx2o8fKWTFvXARjwFEI1YWCar8Ja6MnmAL0z7iUcKCxiqi7Z+cPVMQmUTjeRfVmH093oAc3SrbCOYtBEaGCY51jfLVWY+MJm/SqGcF0p3xcKcjbzqR0RZ6PjiJIM8zHvR8RoU34Gtcn7JeQ6eau/SXigOUhqVjH3drjuIEjel8Xk8dDPu/hfaW7lvWldwHd+cAK/LdGBADCVp/gy9SFytaQIjJlJk3D8yRJ2yyQXS7HRxMwdm3HSYM8S40QaUu6dcdVRFxTZCCs091CH2we9NoDj39mXMJ/2qWCT740swZp4Txvh7b8va/MQNPZ6tWt6d1xczfWgbfyWPIvgHSgCLUSa/QFNF3yoOMvq47wnBRXoi9t679sO9z
x-ms-exchange-antispam-messagedata: 7+uA4GgxWyemvPzrS+fe1viW19niFpKpCSVksTHPuGkGXnhTwQjSRKUDMm8FxYCojF/9YMC6ZBiUaor7fWIWMXXhorki/xoy++0vJCZcZjTi3Ar7tG6hNISy4vaUzVWsDOFAV8EltUQQl1abX5nurg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSGsRzL1i1wlcLJY89QoFn4/Fy66zpvJNbG9gETDpicYgMysLjBZVNZwRZ7bSxaxmlnN0uWRUNU2SV7YHvcjGRCViHI1IuT9oQrqGYzSHFvfYklgFvgPNHXUhWSf6QbnFz+rxI1R7VXkLX29yWpyYryJ0u0aZO5tfHWbGx/wkPvhmHv0wdYT2H2oV2QU9Hps/YYL/VgOPkQxCjQfJIHCdKqRUatYn5HvZ29yzRjpmUAgA6eqMQWlVY/KkLCLqjdNGPjCRq7T3GBPONgyOtI/v5Y+iCiaEuCJMqUJntkkFWELiPJEenhA5yhUlu1CCTsA7//M+1b3L0iGTqscwwcxvg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PXv4fMGMiUFSzbcro5hihXt7qRkrW5LWTnybZ494D8=;
 b=PAD6ZJV88bGMZBex855XUF3Fpvilw5aNmA/X2HaDs3NHJDhDCsjb6HJ+jgxesxWIEGwdhgcHvomc3a/q/1ee1/If9eWZNPYRVY4NBzTuV5/XIkA3i4jwd4S8Gl/zgTplNvzMfHQA120R5XrzhJ/NJyrkd01jFNzb8YS2KanAxrBo5ovx/RbGYIzJd+4z054agVJ5mD8z0tuiBuqP7EEcEgzdD8uKXge5VQjUdKInGAIwtgwFmqnlEfPF6OM+R5GLAHL7ilqZvPmL/sxY/YHs4WlIEuNeRiNMA+vfoSkdqgG2zWNADMoDhyVtOMbnijCxltx2IkMv6XL8lLw8KmEt+Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PXv4fMGMiUFSzbcro5hihXt7qRkrW5LWTnybZ494D8=;
 b=l1ys6n31dS+6iCEYYAAWvqOAuUMPY4AOUTHg1O4r4d7E9LTJB25cC6/Sf5jUMWZhJ16cdGsn814Bq3ZJO75qmXyhvF0++8eSjG1YkaTP2q9M2IQcKqKHOq1bBOdqhkG/Y3JQqqNh0jM4QOx/axfHgHn/8DGw/cj7bfw0GDoXLO4=
x-ms-exchange-crosstenant-network-message-id: 40a40dab-b154-4917-de73-08d7aa8b531a
x-ms-exchange-crosstenant-originalarrivaltime: 05 Feb 2020 22:32:46.5841 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: DbTk+1+s7BUCRxovJozcNUX3sxmSuUMSHzRN8xqPHea1OVoGIQnGN+p64eil7mp+bmzZ4GEtYLXZYWug2Yfo0g==
x-ms-exchange-transport-crosstenantheadersstamped: SN6PR02MB4046
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
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
 Marlies Ruck <marlies.ruck@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Josh Kunz <jkz@google.com>, Matus Kysel <mkysel@tachyum.com>,
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Taylor Simson <tsimpson@quicinc.com>

> -----Original Message-----
> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Tuesday, February 4, 2020 11:11 AM
> To: qemu-devel@nongnu.org
> Cc: Peter Maydell <peter.maydell@linaro.org>; Josh Kunz
> <jkz@google.com>; Laurent Vivier <laurent@vivier.eu>; Aleksandar
> Markovic <aleksandar.markovic@rt-rk.com>; Matus Kysel
> <mkysel@tachyum.com>; Riku Voipio <riku.voipio@iki.fi>; Taylor Simpson
> <tsimpson@quicinc.com>; milos.stojanovic@rt-rk.com; Marlies Ruck
> <marlies.ruck@gmail.com>
> Subject: [PATCH v2 4/4] linux-user: fix use of SIGRTMIN
>
> -------------------------------------------------------------------------
> CAUTION: This email originated from outside of the organization.
> -------------------------------------------------------------------------
>
> Some RT signals can be in use by glibc,
> it's why SIGRTMIN (34) is generally greater than __SIGRTMIN (32).
>
> So SIGRTMIN cannot be mapped to TARGET_SIGRTMIN.
>
> Instead of swapping only SIGRTMIN and SIGRTMAX, map all the
> range [TARGET_SIGRTMIN ... TARGET_SIGRTMAX - X] to
>       [__SIGRTMIN + X ... SIGRTMAX ]
> (SIGRTMIN is __SIGRTMIN + X).
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>
> Notes:
>     v2: ignore error when target sig <=3D TARGET_NSIG but host sig > SIGR=
TMAX
>         replace i, j by target_sig, host_sig
>         update signal_table_init() trace message
>
>  linux-user/signal.c     | 37 ++++++++++++++++++++++++++++++-------
>  linux-user/trace-events |  3 +++
>  2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index c1e664f97a7c..e7e5581a016f 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -498,18 +498,23 @@ static int core_dump_signal(int sig)
>
>  static void signal_table_init(void)
>  {
> -    int host_sig, target_sig;
> +    int host_sig, target_sig, count;
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
> +    for (host_sig =3D SIGRTMIN; host_sig <=3D SIGRTMAX; host_sig++) {
> +        target_sig =3D host_sig - SIGRTMIN + TARGET_SIGRTMIN;
> +        if (target_sig <=3D TARGET_NSIG) {
> +            host_to_target_signal_table[host_sig] =3D target_sig;
> +        }
> +    }
>
>      /* generate signal conversion tables */
> +    for (target_sig =3D 1; target_sig <=3D TARGET_NSIG; target_sig++) {
> +        target_to_host_signal_table[target_sig] =3D _NSIG; /* poison */
> +    }
>      for (host_sig =3D 1; host_sig < _NSIG; host_sig++) {
>          if (host_to_target_signal_table[host_sig] =3D=3D 0) {
>              host_to_target_signal_table[host_sig] =3D host_sig;
> @@ -519,6 +524,15 @@ static void signal_table_init(void)
>              target_to_host_signal_table[target_sig] =3D host_sig;
>          }
>      }
> +
> +    if (TRACE_SIGNAL_TABLE_INIT_BACKEND_DSTATE()) {
> +        for (target_sig =3D 1, count =3D 0; target_sig <=3D TARGET_NSIG;=
 target_sig++)
> {
> +            if (target_to_host_signal_table[target_sig] =3D=3D _NSIG) {
> +                count++;
> +            }
> +        }
> +        trace_signal_table_init(count);
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
> +
>      if (sig < 1 || sig > TARGET_NSIG || sig =3D=3D TARGET_SIGKILL || sig=
 =3D=3D
> TARGET_SIGSTOP) {
>          return -TARGET_EINVAL;
>      }
> @@ -847,6 +863,13 @@ int do_sigaction(int sig, const struct target_sigact=
ion
> *act,
>
>          /* we update the host linux signal state */
>          host_sig =3D target_to_host_signal(sig);
> +        trace_signal_do_sigaction_host(host_sig, TARGET_NSIG);
> +        if (host_sig > SIGRTMAX) {
> +            /* we don't have enough host signals to map all target signa=
ls */
> +            qemu_log_mask(LOG_UNIMP, "Unsupported target signal #%d,
> ignored\n",
> +                          sig);
> +            return 0;
> +        }
>          if (host_sig !=3D SIGSEGV && host_sig !=3D SIGBUS) {
>              sigfillset(&act1.sa_mask);
>              act1.sa_flags =3D SA_SIGINFO;
> diff --git a/linux-user/trace-events b/linux-user/trace-events
> index f6de1b8befc0..0296133daeb6 100644
> --- a/linux-user/trace-events
> +++ b/linux-user/trace-events
> @@ -1,6 +1,9 @@
>  # See docs/devel/tracing.txt for syntax documentation.
>
>  # signal.c
> +signal_table_init(int i) "number of unavailable signals: %d"
> +signal_do_sigaction_guest(int sig, int max) "target signal %d (MAX %d)"
> +signal_do_sigaction_host(int sig, int max) "host signal %d (MAX %d)"
>  # */signal.c
>  user_setup_frame(void *env, uint64_t frame_addr) "env=3D%p
> frame_addr=3D0x%"PRIx64
>  user_setup_rt_frame(void *env, uint64_t frame_addr) "env=3D%p
> frame_addr=3D0x%"PRIx64
> --
> 2.24.1
>


