Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CA0C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F44620674
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 22:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aS8KobTu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ZCeVdx/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F44620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iykZG-000056-F7
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 17:51:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45468)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iykYR-00087q-Jx
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iykYL-00048r-8O
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:50:53 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:63691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iykYK-0003yX-Cd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 17:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1580770248; x=1612306248;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AxxBSsF92jj+Bwas0tBW3Y+OKmmz+fllyByNhC85/Tc=;
 b=aS8KobTuXrAhdq3541KmwvM4g4/kOX0GQM761hSxauLBOc/SjQrxSCb7
 5w5ntVEK+AMQfJC9co08McJW1VHWw9F/16QpbCFAGYW5H0WYsfFj8r5s1
 bbcIL/R0V1LAPVknkWSHU73KEQw9LxfZ49AiMcs05IVgpyDAfUuTNfA59 E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Feb 2020 14:50:44 -0800
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 03 Feb 2020 14:50:44 -0800
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 3 Feb 2020 14:50:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Mon, 3 Feb 2020 14:50:43 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4326.namprd02.prod.outlook.com (52.135.237.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 22:50:42 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::bde4:83e4:96ad:fe62%6]) with mapi id 15.20.2686.030; Mon, 3 Feb 2020
 22:50:42 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/4] linux-user: fix use of SIGRTMIN
Thread-Topic: [PATCH 0/4] linux-user: fix use of SIGRTMIN
Thread-Index: AQHV2PsOQ5OGpSzrB0qHpMHFVDfcjagKFgww
Date: Mon, 3 Feb 2020 22:50:42 +0000
Message-ID: <BYAPR02MB48864D9855037D87FF647E00DE000@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <20200201122746.1478003-1-laurent@vivier.eu>
In-Reply-To: <20200201122746.1478003-1-laurent@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f19174ce-fd66-4634-2d16-08d7a8fb7f75
x-ms-traffictypediagnostic: BYAPR02MB4326:
x-microsoft-antispam-prvs: <BYAPR02MB43269EC5824F47A1FD678A05DE000@BYAPR02MB4326.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(189003)(199004)(6506007)(53546011)(55016002)(9686003)(316002)(8676002)(26005)(186003)(4326008)(478600001)(7696005)(33656002)(2906002)(8936002)(81156014)(52536014)(110136005)(54906003)(86362001)(66946007)(76116006)(71200400001)(66556008)(66476007)(66446008)(64756008)(5660300002)(81166006);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4326;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mO62GnJ9PtpoO4zptVLsCyQfKpc/k9E7aoxi1a1P52fBNMfl0RLLnaMBrQNXACTgfk00UnHLk8a2rXiYfInHIVzv8Eqs+3moYDPuBA/iuYBTZpPZ6yST1xbsNygxC2X8KmJUV9iB5R+qRUo0L/cPvBuuVXiTm33i10nnaINnMFxhHnBUNXLGexb00Xqajf4SnABmId7Z9Kb5qvN4HxXX7GBjMq6dWU7wOMDRIhtVICLLDFAQdzax6TX/WfJ271xH4aiSK9VSmIzaVuP7MAMKR4+slv4CBZHo4GlifwFeGg80e2s1ckPqVP92jwRIlkMnhBL4uBYqtsJl6+aXd2GUc58llm3h3uNdLhS8y0Nl2abGT4dCRBMO6I+b2FrpVyt3AHp/Gx7hFV3ipS41qaw8KNY9965BvidtFqA6rbqR6LpCIPbfO4PpGmkw3GlV4/qM
x-ms-exchange-antispam-messagedata: /VIXPCOmxy0U6JlOimd+PR+PqgjfwuX5lV43cvFQvplKbnN0UO0CegGvtQEGOeDjwXzxBZv0dV8WhSNKIPQHaLe6JRXWKwwXTz8I0vl0wwFMhn27jR3xvxOOuQMS9H63HJsBqH5KkhnzWyC759oBPg==
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv4hsdhS0d4LoQ+CyNQ04W1MUFRRrJjylJcRNU+q8eWJ31SnZU8rXsCV9u25pr9+jWNp1Jicgyhy/ftjctc+N5UcC/Kt8ZaWSCU2vl+cFAFNrRl68bqhvJf1vZ08QhZIc1eQ4HQEjdlWU/+bsk1K8Hwg/ep+5IITMX4Hej58D/Mkj0FmWvrkO2tTSt7N6ZEbP//wElkM3KzpdrpVwJCS9RPcVVSI///ZNohs2vWdM7sxyXcJ1v7GKoRUvcLMJL7mbg6TgG2ht26912M8hkdUOThJl100CjrhRP6MB5MVGtbMU1QG4l/+arRmqORzU6JGJOfkYP6NojP2cYn/p6d9Nw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15TSrGMm6yEP4SCsj0uL01GrZOWoaFqGUX8mjAE5CKI=;
 b=mFU67xi512dHJ1TwazJzNFSO11PSoj1c3XNAnoHADOdCVdXEuhvamO7RE7zq+AA9wtV+mWRCXklvq8fK0ADGdWW7d9GPKOUBHZI4zlVbfITG+e79Z5Grtw+m7PPopAVvx1dYzP9OYBg87Y8h3XnDtJtt0gwn8YWjUp8tdSsG+ZWSAI0LwUtunT1Z39NMuQxYQuqg86MDfaFQGF5LfQp+p6/XLJb+rOvgG8d+Yl8Z6N7+WdlAdJHbnIeKl8xCdaSKtXk0yMDj63JgDDwE00605aqU9C7XMJ0nzZU2Lt3pL+vHYzjT1XPqRI5fcWHrXqsLN6My2bKagnlIvERNmkWthQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15TSrGMm6yEP4SCsj0uL01GrZOWoaFqGUX8mjAE5CKI=;
 b=ZCeVdx/Bhu7uzH9k7lXVEEx2V/r6fEJbil4/CmkZN+avNkkmiv3quLMyUwqUjbS6L7HBgt6rkX2aP/YA5bEH84MLJ+Q/berZoXXMAiRWXIcl9gueStAiSIu5pmAwoKu74KVAYWe7Jk5ptOx2+kZxmpSsIyqBX8CjRf5iesViDOw=
x-ms-exchange-crosstenant-network-message-id: f19174ce-fd66-4634-2d16-08d7a8fb7f75
x-ms-exchange-crosstenant-originalarrivaltime: 03 Feb 2020 22:50:42.2928 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 0vzMN/NBNsllNxS/ftv1WT9ucyXxn+RACsLgp6tinzGLQLv7ZZprx7KCUqWbarSdscMux20lgU8fTSsbZ4Gzhg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4326
x-originatororg: quicinc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

FWIW, this removes the need for the target-specific code for Hexagon in sig=
nal.c.

Thanks,
Taylor

PS  Stay tuned for a Hexagon target patch series once this is merged.

> -----Original Message-----
> From: Laurent Vivier <laurent@vivier.eu>
> Sent: Saturday, February 1, 2020 6:28 AM
> To: qemu-devel@nongnu.org
> Cc: Josh Kunz <jkz@google.com>; milos.stojanovic@rt-rk.com; Matus Kysel
> <mkysel@tachyum.com>; Aleksandar Markovic <aleksandar.markovic@rt-
> rk.com>; Marlies Ruck <marlies.ruck@gmail.com>; Laurent Vivier
> <laurent@vivier.eu>; Peter Maydell <peter.maydell@linaro.org>; Taylor
> Simpson <tsimpson@quicinc.com>; Riku Voipio <riku.voipio@iki.fi>
> Subject: [PATCH 0/4] linux-user: fix use of SIGRTMIN
>
> This series fixes the problem of the first real-time signals already in u=
se by
> the glibc that are not available for the target glibc.
>
> Instead of reverting the first and last real-time signals we rely on the =
value
> provided by the glibc (SIGRTMIN) to know the first available signal and w=
e
> map all the signals from this value to SIGRTMAX on top of
> TARGET_SIGRTMIN. So the consequence is we have less available signals in
> the target (generally 2) but all seems fine as at least 30 signals are st=
ill
> available.
>
> This has been tested with Go (golang 1.10.1 linux/arm64, bionic) on x86_6=
4
> fedora 31. We can avoid the failure in this case allowing the unsupported
> signals when we don't provide the "act" parameters to sigaction, only the
> "oldact" one. I have also run the LTP suite with several target and debia=
n
> based distros.
>
> Laurent Vivier (4):
>   linux-user: add missing TARGET_SIGRTMIN for hppa
>   linux-user: cleanup signal.c
>   linux-user: fix TARGET_NSIG and _NSIG uses
>   linux-user: fix use of SIGRTMIN
>
>  linux-user/hppa/target_signal.h |   1 +
>  linux-user/signal.c             | 110 +++++++++++++++++++++++---------
>  linux-user/trace-events         |   3 +
>  3 files changed, 85 insertions(+), 29 deletions(-)
>
> --
> 2.24.1
>


