Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26B0C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF27A21D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="I5td2nQ/";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="JEnPQCas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF27A21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSVkS-0006XQ-Pn
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 21:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSViz-0005dF-2a
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 21:37:05 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:49429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kSVit-00031R-Ay
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 21:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1989; q=dns/txt; s=iport;
 t=1602639419; x=1603849019;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a0DKTM4+vQNWTOZG68odK/b2FnhkT7Nf8FORnvELKsg=;
 b=I5td2nQ/xVyGltjZuDxRcb5GghFcKCDXZmCaikZMZgjCHqYIB6jQ4UHJ
 yquVL0uji0cg9EJcOw0pzVkJscJs6wnfe3mlssCAc0EmMT1rWXX7wJryO
 WG3BpAFERXQPuFyH9fF8Vecxs3vDcPMgT84b3uuc9/qGuJxGRlGu7MT2w c=;
IronPort-PHdr: =?us-ascii?q?9a23=3A1VxDNRH/r38/QFs2UxDac51GYnJ96bzpIg4Y7I?=
 =?us-ascii?q?YmgLtSc6Oluo7vJ1Hb+e401QObVIDA4u4CjPDZ4OjsWm0FtJCGtn1KMJlBTA?=
 =?us-ascii?q?QMhshemQs8SNWEBkv2IL+PDWQ6Ec1OWUUj8yS9Nk5YS8/7fFTO5Hqo4m1aFh?=
 =?us-ascii?q?D2LwEgIOPzF8bbhNi20Obn/ZrVbk1IiTOxbKk0Ig+xqFDat9Idhs1pLaNixw?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ASCgBZVYZf/5FdJa1ggQmDIVEHcFk?=
 =?us-ascii?q?vLIgDA41QihGOaoJTA1ULAQEBDQEBGAsKAgQBAYRKAoICAiU4EwIDAQELAQE?=
 =?us-ascii?q?FAQEBAgEGBG2FXAyFcgEBAQQBES4BATcBDwIBCBEEAQEvIQcKHQgCBAENBQg?=
 =?us-ascii?q?agwWCSwMuAQ6dQAKBOYhhdIE0gwEBAQWBMwEDAoNYDQuCEAMGgTiCcopEG4I?=
 =?us-ascii?q?AgVSCGAcuPoIaQgECAoFcAjCDGIItkxABiQCKQpBCUgqCaYkCiw+BToUtgxW?=
 =?us-ascii?q?KCJQgkyaKcYJskkkCBAIEBQIOAQEFgWsjgVdwFYMkUBcCDZIQhRSFQnQCNQI?=
 =?us-ascii?q?GAQkBAQMJfI1MAQE?=
X-IronPort-AV: E=Sophos;i="5.77,373,1596499200"; d="scan'208";a="581795303"
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
 by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 14 Oct 2020 01:36:56 +0000
Received: from XCH-ALN-002.cisco.com (xch-aln-002.cisco.com [173.36.7.12])
 by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 09E1auGY031071
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
 Wed, 14 Oct 2020 01:36:56 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-ALN-002.cisco.com
 (173.36.7.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 20:36:56 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Tue, 13 Oct 2020 20:36:55 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 13 Oct 2020 20:36:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kaeijh1EPJpZGMpFX1URkIXjzfFJKGsx3VywoCZIgAPsehMpOQtlEhgodqlUBXam8+26m0g4yQ7rPIuLBZKRcZu9a7eHKh8L/ljUkOxCm1zP8y9TuanAB20N6aqxQB3FCNpOueOZ5CNF3114gkvcLTb62rVjJrqIiCOVMjUBfiZJVX6bXBtgHiQX07EsehrvT+mTrTw5eLB3wtB0bEmrD0iL3qVMuDXNbxLieeH97o+ot6/2KqVV5LiexfcU0iDCGO8h4M/wZcTUTYrsHMhBxZw55n8+mgZaBipUPSFwGiXDUKndltviBZz3ap0t9pvvuJLy37++kX4oT4gA5XKoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4irEe33It2gpe0Ue8hQ4j9tBCVWhy36Ryr7/DWbTQg=;
 b=W5Gx4vnLPq/5yW0Np1/lfRS8iVDpWdEGgj1pqgQVrkqlL+3DjzBGuqs0effiiZkGjCBdKwRY5rzhOXEASFWcE2VUCiBgte4kRW0hzY8iDGy1+K5E/29Oi2wN2LTPh7BfpbYrHv3geTuowDGTF8j+OE2jDI+PSJh29kJtYLo2KStN2L8KK/SozL3V19Vg1LK3WUxshtZNZO74oJNI9L/foDhbdeHTN90O6L2yiEiH6/KopTMNKjN7L0xhJ+ISwSjG/HN8eq9tFDTJD/YGUgr6Q9oCBcOzSaDbnGbXuJJdTlLrua8ZRlMhU9wmm6mU33Dg+JmKIBIpcr2oILa4VAaBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com; 
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4irEe33It2gpe0Ue8hQ4j9tBCVWhy36Ryr7/DWbTQg=;
 b=JEnPQCasBfZ/n2Ro6Q3nnoX+wyoZNh2Qr3JDSOkPpbdT1+cPewFrmBZN9tV/KPIvdbjQulnhoqeHXOOBeFG2lVJg8dFuCW66XMqXaNsOWC2rX6QWEIgNaWOc+WtdX76kWTz/hEJ0MYRWMPLnSyDiR2qf6D8muCzUHfDTs88z1NQ=
Received: from BYAPR11MB3047.namprd11.prod.outlook.com (2603:10b6:a03:8b::32)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 14 Oct
 2020 01:36:54 +0000
Received: from BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca]) by BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca%3]) with mapi id 15.20.3455.029; Wed, 14 Oct 2020
 01:36:54 +0000
From: "Victor Kamensky (kamensky)" <kamensky@cisco.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Khem Raj <raj.khem@gmail.com>, Richard Henderson <rth@twiddle.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Aleksandar Markovic
 <aleksandar.qemu.devel@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Purdie
 <richard.purdie@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
Thread-Topic: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
Thread-Index: AQHWoWRm6e3gfSLGnk2rivp8VwQya6mWJVfp
Date: Wed, 14 Oct 2020 01:36:54 +0000
Message-ID: <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
In-Reply-To: <20201013132535.3599453-1-f4bug@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1003::a4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9819b9ee-cfaf-4ff9-93f1-08d86fe1a1d7
x-ms-traffictypediagnostic: SJ0PR11MB4783:
x-microsoft-antispam-prvs: <SJ0PR11MB47836AA662BC4344EC057553CD050@SJ0PR11MB4783.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRBx+YFIaFecw9bXkujEBB/kn6ghztpR+1vYcblyPEuiSmniWDf7xHPIYrvdwJvZcK+qJU9xips0YHW4ovbb5WRUbscFh/2wL6nKCnxyfsGyM/hUjyGbC6n0c3lSLHG+MOEzvTH0JUMwurmKW5sbZehAZHqbhIHNMovmFJ1uFOloxslKgsnGV1s3JIQPM+Q11rMp45rlx4tjRXpI41LhoocCKDfvkAjKdZzQpvSFovCKOTHQQdLKljTcPhuUQJ9UPEnpMpuSlhC8l2hnYvLG0KL/u4wPHz06th2hMBWMpIWqtThDd+ViIP7i8Ag4jTHRPTOnpjpU20sWYMGsjXwOCg8cStV1Dc1Ms5WNVkfbukSVzFvr3Jk1PR4jyeQc0cMLg0yI0+TbfvqqyvSmCaYbvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3047.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(86362001)(4326008)(110136005)(83080400001)(9686003)(33656002)(8676002)(8936002)(2906002)(83380400001)(5660300002)(55016002)(478600001)(966005)(316002)(53546011)(7696005)(52536014)(76116006)(6506007)(66556008)(186003)(66476007)(66446008)(66946007)(54906003)(64756008)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Z+fNxlIuX+rFcmKnjXNwZlkFrhoi0gvowzQ9YatDyddcDtGsKBLY5m/eIZxqJ63ERHLMLhFfM1pnnZ1jmKan9FvPdEiiGycSFSZOaQupDaibP1pbO1eDLQhO9Fe0S4SHN5lDm+SdDRBAZkUjX0qGdjdGA8U0Tl0ePBJbB+sG7y2c9PrT0/NZ9hSUqJqU4yoi5l1dKy1wx1cFQU2AD4BGRNXKP2Lys9zdfaX9xKAhMDVEwv1tYKfziocYM5ATdjKiZeuaQgC0n05tKmx9tkJ0ShLFPCrbEMxdSUvUdtfnwrFb3vJtaRGFCXWdXULRtz7tPstFB0xBnLPXgVJaKFFEQUC5PlSCJ4eRu5aKYlw7AHzRv451jxpMuxpL/a3WSU5BJI+alCDABj7LCVfDyhKAtskaEtXHhG1G7+AJvkTWVm+DgLxpfsuk7YHnTUsBQar+4SChZWTkp1V0Huuq1xfRxyMdflVUlq4On4vMpDWtsgB0ovA9jXeTPBRYBVIxLmbuKNnY8QTGNJsM7RP0PJy+DBzK8AXgkTjBfrCC6oL+WbndrYgpxqs4ZsZlr+6cy4F9eewPgQDuLiZt7q6e7eATZBoyArsOK/vN8SJvmryLumLKc+zGGjgqpRBIZlqNgZAEOBKjUKqT0UbywGGYH16vN+eFqWlKygCZMYtNmWSObaQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9819b9ee-cfaf-4ff9-93f1-08d86fe1a1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 01:36:54.5480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUMl9kloaTB2rVcyLjBmuKPutCqr2AVydDFLOvD8li2hvx/IRy6kg197J+gmKBAfRhfc0UPqLyTeenQucbzUVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.12, xch-aln-002.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com
Received-SPF: pass client-ip=173.37.142.89; envelope-from=kamensky@cisco.com;
 helo=alln-iport-2.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 21:36:57
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,=0A=
=0A=
Thank you very much for looking at this. I gave a spin to=0A=
your 3 patch series in original setup, and as expected with=0A=
'-cpu 34Kf,tlb-entries=3D64' option it works great.=0A=
=0A=
If nobody objects, and your patches could be merged, we=0A=
would greatly appreciate it.=0A=
=0A=
Thanks,=0A=
Victor=0A=
=0A=
________________________________________=0A=
From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on behalf=
 of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=0A=
Sent: Tuesday, October 13, 2020 6:25 AM=0A=
To: qemu-devel@nongnu.org; Victor Kamensky (kamensky)=0A=
Cc: Khem Raj; Richard Henderson; Aleksandar Rikalo; Aleksandar Markovic; Ji=
axun Yang; Aurelien Jarno; Richard Purdie; Philippe Mathieu-Daud=E9=0A=
Subject: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU =
property=0A=
=0A=
Yocto developers have expressed interest in running MIPS32=0A=
=0A=
CPU with custom number of TLB:=0A=
=0A=
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg03428.html=0A=
=0A=
=0A=
=0A=
Help them by making the number of TLB entries a CPU property,=0A=
=0A=
keeping our set of CPU definitions in sync with real hardware.=0A=
=0A=
=0A=
=0A=
Please test/review,=0A=
=0A=
=0A=
=0A=
Phil.=0A=
=0A=
=0A=
=0A=
Philippe Mathieu-Daud=E9 (3):=0A=
=0A=
  target/mips: Make cpu_mips_realize_env() propagate Error=0A=
=0A=
  target/mips: Store number of TLB entries in CPUMIPSState=0A=
=0A=
  target/mips: Make the number of TLB entries a CPU property=0A=
=0A=
=0A=
=0A=
 target/mips/cpu.h                |  1 +=0A=
=0A=
 target/mips/internal.h           | 10 +++++++++-=0A=
=0A=
 target/mips/cpu.c                | 12 ++++++++++--=0A=
=0A=
 target/mips/translate.c          | 16 ++++++++++++++--=0A=
=0A=
 target/mips/translate_init.c.inc |  2 +-=0A=
=0A=
 5 files changed, 35 insertions(+), 6 deletions(-)=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
2.26.2=0A=
=0A=
=0A=
=0A=

