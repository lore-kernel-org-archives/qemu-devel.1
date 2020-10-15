Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79362C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EE11218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Tb21Qtfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="EcgS/TUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE11218AC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8Rr-0005nS-EH
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kT8QG-00059k-9G
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:56:20 -0400
Received: from alln-iport-8.cisco.com ([173.37.142.95]:36429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kamensky@cisco.com>)
 id 1kT8Q7-0000U2-6Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=6364; q=dns/txt; s=iport;
 t=1602788170; x=1603997770;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zpX4F6CCkxy7AJLLjySG6+HULIzmtao23c7SwhRCcJw=;
 b=Tb21Qtfe2pHJ5UG9Ky1asspGX2lOvjx1DU39JreTBdPAs5MAL0Xwawjb
 fpWd6TAVhijCHGRH0DGFIBIk+oncAL1/x8Fat/GbRUIzLSmc5ZSrsX+nE
 VoIduOwKVSmF8tCO9jTPYAJU1tZQICRRfTDuXSTk/mkmgUjwiwNE5Yd/5 g=;
IronPort-PHdr: =?us-ascii?q?9a23=3A61bRShMrEkKnZljQ+Pkl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEvKwx3lbMRozHrfVehLmev6PhXDkG5pCM+DAHfYdXXh?=
 =?us-ascii?q?AIwcMRg0Q7AcGDBEG6SZyibyEzEMlYElMw+Xa9PBtcHd33exvVuHLhpTIXEw?=
 =?us-ascii?q?/0YAxyIOm9E4XOjsOxgua1/ZCbYwhBiDenJ71oKxDjpgTKvc5Qioxneas=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CQBQChmohf/5BdJa1gHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgU+BUlEHcFkvLIgDA41QgQKJD45qglMDVQsBAQENAQElCAI?=
 =?us-ascii?q?EAQGESgKCCAIlOBMCAwEBCwEBBQEBAQIBBgRthVwMhXIBAQEBAQEBEi4BATc?=
 =?us-ascii?q?BBAsCAQgRBAEBAS4hER0IAgQBDQUIEQmDBYJLAw4gAQ6hdQKBOYhhdIE0gwE?=
 =?us-ascii?q?BAQWBMwETQYMGDQuCEAMGgTiCcopEG4IAgRFDghgHLj6CGkICAYFeAoNIgi2?=
 =?us-ascii?q?QG4J3AYdxi1+QRVQKgmqJBIZchREIaoUtgxaKCJQskyyKc4Jskk4CBAIEBQI?=
 =?us-ascii?q?OAQEFgWsjgVdwFYMkUBcCDY4fg3GKVnQCATUCBgEJAQEDCXyNTAEB?=
X-IronPort-AV: E=Sophos;i="5.77,380,1596499200"; d="scan'208";a="581115710"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
 by alln-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA;
 15 Oct 2020 18:56:07 +0000
Received: from XCH-ALN-002.cisco.com (xch-aln-002.cisco.com [173.36.7.12])
 by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 09FIu7pm001382
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:56:07 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-ALN-002.cisco.com
 (173.36.7.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 15 Oct 2020 13:56:07 -0500
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 15 Oct 2020 13:56:07 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server
 (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 15 Oct 2020 13:56:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8dx7O4xT5/4E5rAdNAqtZq6jVc+tBX3EIeEPDCru+dUC97tYzOIok9QAcyjeoe8BbZnxU5kqZIlArIlcI8ITfYCuTGdDNiwaD+/XAHPU9/rA32Rj1iX12G2B83rLFp54PvBrjYT0hK7LCuhzIlj2oAXxy7TEeal21FR/Nu9dp5IW9omvTCpu+0kOHuxxp7eOefB2csKahUpJlgb0/n4zzT1xeknqEWX6Skw5KTkDqwFJ+4k+Ys6JEvjI27Vpx8QYqrfFUYgTmSoSG9mzp6WwFGFXyimRHqjDCE7KjWqrLlJKegnEl3loLBI4REC4Zx6rmuoFlfe2sR4vWp/97fuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDPkwFF+HVZFRm7Oxw6ag7TRqpjjZF4ePoyrmxWDA3E=;
 b=ez3Kmvki2ecoLMRZJvt7dGxd1Hygj2wT55gtb5hJ0ytDj1nd3UDWxYfxo32H1opVIZYQVuDqXUISJo9om1DgJ/R71PlWNyJS/u4lrn+jXW2MWSKIKdbTTKe21gF6rw0ZwxXbM5f6XX/lHrBeOGaaR0WoK6dy70IbTBjV77T8YQDgNGht116aohuXRZtmWqvkcXyFL9t8cxx1I4FDSFgAXeNvyHJnu9jTVgMfIwELaSehpSjckof3xWRmsEsD5/nPT2GymMeM6zTyXhgymXGJVsVvaXYrok8a2gjVlgG80ukkwY9sBs65xaIIBnjdHq2ik5xMNql+t/jIsCV0+OAvLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com; 
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDPkwFF+HVZFRm7Oxw6ag7TRqpjjZF4ePoyrmxWDA3E=;
 b=EcgS/TUJpzMYLcg9n/OtD8bSIqE4cjp4SPXpflQYHBUBMDEPTxYjsEgWqy2tJBXauTl+1G3eMhPwEOKBplbYaJZ8VsjY6mZmR2W5BJ24LPIR/BBWiwLgbqQKmVCvPbxcFuy5CaYQS8l+xyfeaRpuGFjdLZqywBfN9Zt3GwiZXQM=
Received: from BYAPR11MB3047.namprd11.prod.outlook.com (2603:10b6:a03:8b::32)
 by BYAPR11MB2583.namprd11.prod.outlook.com (2603:10b6:a02:c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Thu, 15 Oct
 2020 18:56:06 +0000
Received: from BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca]) by BYAPR11MB3047.namprd11.prod.outlook.com
 ([fe80::9c2c:6af1:34cd:2eca%3]) with mapi id 15.20.3455.029; Thu, 15 Oct 2020
 18:56:06 +0000
To: =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, "Richard
 Henderson" <rth@twiddle.net>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>, Khem Raj
 <raj.khem@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Aleksandar Markovic
 <aleksandar.qemu.devel@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a CPU
 property
Thread-Topic: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a
 CPU property
Thread-Index: AQHWoWRm6e3gfSLGnk2rivp8VwQya6mWJVfpgACLHgCAAIBJgIAAMsjKgAAxxwCAAW5GwA==
Date: Thu, 15 Oct 2020 18:56:05 +0000
Message-ID: <BYAPR11MB30471A05FF44CF5F7C4C9A29CD020@BYAPR11MB3047.namprd11.prod.outlook.com>
References: <20201013132535.3599453-1-f4bug@amsat.org>
 <BYAPR11MB30479E5264D94EF903E9FD92CD040@BYAPR11MB3047.namprd11.prod.outlook.com>
 <515ec755fd8d7219040283f0c27346d762ee3c29.camel@linuxfoundation.org>
 <ea0ed6c7-1e3a-f7ee-a962-b471555e362d@amsat.org>
 <BYAPR11MB30471BC8B9D3B5F3E678F547CD050@BYAPR11MB3047.namprd11.prod.outlook.com>,
 <CAMKF1sokbfu1ox+nnZe0nJLid5_GnzZUeQEfWDmqmS4LY-RqNg@mail.gmail.com>
In-Reply-To: <CAMKF1sokbfu1ox+nnZe0nJLid5_GnzZUeQEfWDmqmS4LY-RqNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1003::654]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de786bca-0773-440b-8f4a-08d8713bf892
x-ms-traffictypediagnostic: BYAPR11MB2583:
x-microsoft-antispam-prvs: <BYAPR11MB2583E43BE102DC5007F5B8CBCD020@BYAPR11MB2583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZlEUxlzf7YPJaxHqiHDx+o4Mea+e+I4epqPpv+dv6Dmq8LCHbGY7i901ESN2si0iU2afMDDjgucfVMibH56U4j6J2mWPzep3Qm7x77bBl8SQFRAox1qPCwpw5iOhA8aGFU5mniqrZ5PujnfS7Zp3fBuJphhq1YmKMdHJ9WZhrWYhnNgI6k3Ixi1oxVikEv+xqXIiDDe9/6433KwW62xIQGVsetL00owg7UTvPBnYY/+x2YAn4m+mPAmdBozOg2c+oisNkNBelGaNGqZvgPpZLIXa3PJbCs6iLBYfEx8p1yDSqsnBF9qFfQOWJy5QSubwqBi4WJKCZYdgHXcV9U2QI5k1ISH9CXcXRM5YfUslLV+dPlex2n1gFl/+cwteWJPP8d80LSBZJHHi27hUc89I1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3047.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(376002)(346002)(39860400002)(396003)(366004)(8676002)(316002)(54906003)(186003)(66446008)(4001150100001)(8936002)(110136005)(55016002)(9686003)(64756008)(5660300002)(6506007)(53546011)(52536014)(86362001)(66476007)(2906002)(4326008)(478600001)(966005)(71200400001)(7696005)(83380400001)(76116006)(33656002)(66556008)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UOXl+vODiw957RyQbzlDDW+QyKvt+PzKxvZAyBWZ9ZOOJ/Pk03hdqaNoqVO03TxKg3DoOYQ38csAMdS/+EDqJ+wWgyFb45F9VBGfNDdrOtiYAuLCU4j264HVSzxHWYCY9xMnPm4bxf0CnjSzhvCZ5YbZlYpiHg8r2V1Ryi0ja/8wVLmgD1gZIo9axAanpii54pgVa7ToogeS9RxdDWc8fWjSjb5B+KaXlfFYNXRLWC6na8MxT72rFRhMQopIvX1rLbaPIYR9Arj1FJQ8mYk7sdiZdCMVc63ELKECgSYoZ2f6B8H/3uw95eM/IsqiKXD6iEGEYWx5RgBDZZ9IVeptgJutykDzI1w/628hgM9yLE1amclnOJjscHjpdm00abnPumAXVbSZwrkfVeAQoEB5Q7JgxhGKnBRZvZYdq2KsCv5U1It7FJQWPaNFp3Cw9Dltr10FbStTM12MLMvMOC5+BD6Eg7Gt/JXLueG8ZDPzVy/x3wbf1zmiN+/Nv7vZsVQRhEm3PLw1MnkboLkXVYvdy/AayZVlhwT3ftG4V+PoCaaW4KLlvC1T2LYgSZyorH1tubc04hs4Xaft/y7pYmxdw9aMkLqpM9KIkmEnELsxGJqlv2j2MlG03VCcmfZpHIGO86biPuOIQgsXwKuB6rHW8MXbhmQAjGQFiAfIHapwPTc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de786bca-0773-440b-8f4a-08d8713bf892
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 18:56:05.8689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AnraMZz5qsOsXlVqWQrt7D4J6wVhwI2QAz8mvXnE5esanhxq0Oq5mmBQnAv/0Djq1ct11WGJysWnqkgomdsHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2583
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.12, xch-aln-002.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
Received-SPF: pass client-ip=173.37.142.95; envelope-from=kamensky@cisco.com;
 helo=alln-iport-8.cisco.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 14:56:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -118
X-Spam_score: -11.9
X-Spam_bar: -----------
X-Spam_report: (-11.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Reply-to: "Victor Kamensky (kamensky)" <kamensky@cisco.com>
From: "Victor Kamensky (kamensky)" via <qemu-devel@nongnu.org>

Hi Guys,=0A=
=0A=
I looked at issue with P5600 machine under gdb=0A=
of kernel. arch_check_elf from arch/mips/kernel/elf.c=0A=
rejects our sysroot binaries with -ENOEXEC code,=0A=
since our binaries do not have EF_MIPS_NAN2008 ELF=0A=
header flag set and this CPU model does not have=0A=
cpu_has_nan_legacy, i.e mips_use_nan_legacy=3Dfalse.=0A=
So at least we would need to have to change our=0A=
user-land ABI compilation flags to cleanly match=0A=
EF_MIPS_NAN2008 requirements. I am not sure whether=0A=
it is an option, and how it would impact older=0A=
CPUs.=0A=
=0A=
For experiment sake I added ieee754=3Drelaxed kernel=0A=
option to override mips_use_nan_legacy setting =0A=
and system gets some sings of life after that but=0A=
then it hangs further down the road. I briefly=0A=
tried to look at this, but it is not clear what=0A=
is going on. On first look it seems that system=0A=
is trashing on nested do_page_fault calls. It might=0A=
be that something missing in our kernel config, or=0A=
we hitting some kernel bug, or bug in P5600 qemu=0A=
model. It is hard to tell right now.=0A=
=0A=
Is it fair to say that we put enough effort=0A=
exploring P5600 route and it seems does not=0A=
work for us without additional substantial=0A=
work.=0A=
=0A=
Is possible to come back to 34Kf route, doing=0A=
very small localized very well defined change=0A=
of bumping TLBs number for model that we know=0A=
works well for us?=0A=
=0A=
Since we figured out that 34Kf spec allows 16,=0A=
32, or 64 TLBs my first personal preference=0A=
would be to use Phil's patch series with=0A=
addressing review comments. And additionally=0A=
it would be great to set number of 34KF TLB to 64=0A=
by default. If anyone out there (IMO unlikely)=0A=
depends that before model had only 16 TLBs,=0A=
he/she can use cpu parameters to put it back=0A=
to 16. My second alternative choice is to=0A=
accept 34Kf-64tlb model, after I rephrase=0A=
commit message.=0A=
=0A=
Thanks,=0A=
Victor=0A=
=0A=
________________________________________=0A=
From: Khem Raj <raj.khem@gmail.com>=0A=
Sent: Wednesday, October 14, 2020 1:53 PM=0A=
To: Victor Kamensky (kamensky)=0A=
Cc: Philippe Mathieu-Daud=E9; Richard Purdie; qemu-devel@nongnu.org; Aleksa=
ndar Rikalo; Aleksandar Markovic; Aurelien Jarno; Richard Henderson=0A=
Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries a =
CPU property=0A=
=0A=
On Wed, Oct 14, 2020 at 1:20 PM Victor Kamensky (kamensky)=0A=
<kamensky@cisco.com> wrote:=0A=
>=0A=
> In order just to keep on the same thread, here is piece of information=0A=
> I found:=0A=
>=0A=
> I looked at "MIPS32=AE 34Kf=99 Processor Core Datasheet" [1]=0A=
>=0A=
> Page 8 in "Joint TLB (JTLB)" section says:=0A=
>=0A=
> "The JTLB is a fully associative TLB cache containing 16, 32,=0A=
> or 64-dual-entries mapping up to 128 virtual pages to their=0A=
> corresponding physical addresses."=0A=
>=0A=
> So "34Kf-64tlb" cpu model I proposed turns out not to be "fictitious"=0A=
> after all. Having 64 TLBs is all within this CPU spec. It is not clear=0A=
> why original 34Kf model choose worst case scenario wrt=0A=
> TLB numbers. Commit log where 34Kf was introduced does not=0A=
> have much details.=0A=
=0A=
thanks for digging this information from CPU specs. It seems using 64=0A=
TLB as default might be a good option for 34Kf then=0A=
=0A=
>=0A=
> So IMO on 34Kf route we have the following choices:=0A=
>=0A=
> 1) I can rephrase commit message and resubmit commit for=0A=
> "34Kf-64tlb" cpu model, if it could be merged=0A=
>=0A=
> 2) We can bump up number of TLBs to 64 in existing 34Kf model=0A=
> since it is within the spec.=0A=
=0A=
this looks a good option since it is with in specs and is backward compatib=
le.=0A=
=0A=
>=0A=
> 3) Use Phil's series and tlb-entries cpu parameter would cover all=0A=
=0A=
I agree.=0A=
=0A=
> 3 variants of 16,32,64 TLBs allowed by 34Kf data sheet spec.=0A=
>=0A=
> Please see inline wrt asked '-cpu P5600' testing. Look for 'victor2>'=0A=
>=0A=
> [1] https://s3-eu-west-1.amazonaws.com/downloads-mips/documents/MD00419-2=
B-34Kf-DTS-01.20.pdf=0A=
>=0A=
> ________________________________________=0A=
> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> on beha=
lf of Philippe Mathieu-Daud=E9 <f4bug@amsat.org>=0A=
> Sent: Wednesday, October 14, 2020 7:53 AM=0A=
> To: Richard Purdie; Victor Kamensky (kamensky); qemu-devel@nongnu.org=0A=
> Cc: Aleksandar Rikalo; Khem Raj; Aleksandar Markovic; Aurelien Jarno; Ric=
hard Henderson=0A=
> Subject: Re: [RFC PATCH 0/3] target/mips: Make the number of TLB entries =
a CPU property=0A=
>=0A=
> On 10/14/20 9:14 AM, Richard Purdie wrote:=0A=
> > On Wed, 2020-10-14 at 01:36 +0000, Victor Kamensky (kamensky) wrote:=0A=
> >> Thank you very much for looking at this. I gave a spin to=0A=
> >> your 3 patch series in original setup, and as expected with=0A=
> >> '-cpu 34Kf,tlb-entries=3D64' option it works great.=0A=
> >>=0A=
> >> If nobody objects, and your patches could be merged, we=0A=
> >> would greatly appreciate it.=0A=
> >=0A=
> > Speaking as one of the Yocto Project maintainers, this is really=0A=
> > helpful for us, thanks!=0A=
> >=0A=
> > qemumips is one of our slowest platforms for automated testing so this=
=0A=
> > performance improvement helps a lot.=0A=
>=0A=
> Could you try Richard's suggestion? Using '-cpu P5600' instead?=0A=
> It is available in Linux since v5.8.=0A=
>=0A=
> victor2> I've tried exact image that works on 34Kf and 34Kf-64tlb models=
=0A=
> victor2> image with '-cpu P5600'. it does not boot: it dies in init (syst=
emd).=0A=
> victor2> I can look under gdb with qemu -s -S options, what is going on t=
here=0A=
> victor2> but it will take time.=0A=
> victor2> If someone have some clues what might cause it please let=0A=
> victor2> me know. Here is high level information about setup:=0A=
> victor2>    - qemu version is 5.1.0=0A=
> victor2>    - kernel base version is 5.8.9=0A=
> victor2>    - systemd version is 1_246.6=0A=
> victor2>    - user land CPU related build options "-meb -meb -mabi=3D32 -=
mhard-float -march=3Dmips32r2 -mllsc -mips32r2"=0A=
>=0A=
> Thanks,=0A=
> Victor=0A=
>=0A=
> >=0A=
> > Cheers,=0A=
> >=0A=
> > Richard=0A=
> >=0A=
> >=0A=

