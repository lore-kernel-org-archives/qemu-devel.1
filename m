Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7A3C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:43:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C972075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 21:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="vASWqXPC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="ebDQT7mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C972075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je3pS-0003p5-BQ
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 17:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1je3oM-0003MZ-Q7
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:42:06 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57198)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1je3oI-0004k0-RS
 for qemu-devel@nongnu.org; Wed, 27 May 2020 17:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590615722; x=1622151722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5Vfvp53uzoRKk+BNjVJdYBRJpjNl7iQIooD9fuP4fQ0=;
 b=vASWqXPCpyr2YyEK1SNLeVGp0eLkKffReOkcTbjpjzIMej1a5zI1oJYq
 Y6CjL3kKx0fed3OjoJKw97hM/WaRYDoW7V16DDQeQ4G4PoHYQjrmmwDSo
 mA5ewMHp347OsHfLaEZfRJd2dzROQ7KXaYa15CdJhlIgeIol/PduGQrw8 M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 27 May 2020 14:41:59 -0700
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 27 May 2020 14:41:59 -0700
Received: from eusanexr01b.eu.qualcomm.com (10.85.0.99) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 14:41:59 -0700
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 eusanexr01b.eu.qualcomm.com (10.85.0.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 May 2020 14:41:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 27 May 2020 14:41:56 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB4454.namprd02.prod.outlook.com (2603:10b6:a03:5f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 21:41:55 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e%6]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 21:41:55 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, casmac
 <1482995675@qq.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: GDB get wrong debug infos on TI DSP architecture extension
Thread-Topic: GDB get wrong debug infos on TI DSP architecture extension
Thread-Index: AQHWM/MU+bq357d/D0q6Pp60ylYupqi7hneAgADj35A=
Date: Wed, 27 May 2020 21:41:55 +0000
Message-ID: <BYAPR02MB4886DAC33FB41B53887E029DDEB10@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
 <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
In-Reply-To: <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0239993f-e3df-4f6d-1ab4-08d80286c6cd
x-ms-traffictypediagnostic: BYAPR02MB4454:
x-microsoft-antispam-prvs: <BYAPR02MB4454509E47498DBE6FA82B4BDEB10@BYAPR02MB4454.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Iuajegtfjkjpy5QW5xp1LX+1StA+frllpIi2FnmXxWj1vFpTLWzILy5ikHGsuAZX0oRli2AmeKQa28vl7jglZcpmYZBjvBeKF9IpFRcUad6GckDmFN2vDfK9vsEquv54ULfRToK5Nc1aadFexW2y+9LwNASfsgW6gn7iMCoE/S9PNXpKwu36ZGySzz/ofQvoqZf9OIyYmRtTnK7so7v6mAoKc44WoO61eb/tNN5V1IyOIRGPFDXPJkx5CC3dzjLJ9xLY/8KC4LANmf1YOeWxEbsxLeqUW9lalYiUEdPahsXagE/qhEwAoRpRlhse96uWNe/+EtlBKm6iRgC7YTPahrT+YZ/FVP1JxsrEBNCLsYZbF+5EwL2oJ1dPBqjKa1dgvgJfmeAhb0KwLd3lq3jdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(39860400002)(346002)(366004)(376002)(136003)(66446008)(64756008)(86362001)(52536014)(6506007)(5660300002)(7696005)(26005)(66574014)(33656002)(186003)(53546011)(83380400001)(9686003)(8676002)(8936002)(76116006)(66556008)(966005)(71200400001)(2906002)(4326008)(55016002)(478600001)(66476007)(54906003)(66946007)(316002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9QnY4Ov052wLhYM9KJ/w7p6smyfAdkIYQj8XgdoX7uDhw9eeGAIBGErtdIYJSkOws55R96pSTueNUhJen5jpdC1XjEmmcBHnpElYvPnAFnXnOiF/fNi4sxv4dPF16fuA5ktn32kyNS74UrJnkYrfOzQRCSiyJWF2McxCMRMNVMD19brhYXjrTIxuYrpte0plHp3uMo1RRRl+mnzMOr17st777hv0QgvwGS3EZwQsr2rNHuCzYv2KvYXFO/A7nhIfWVkKD/gOuChPUw+hurE+fUtmlBU1Mv6w/g4kBsmo+QdlAVQm2fTjHHk5U//HQOjhFMozl7Z3qE1otQJEEZtrNEK3DYroVkUxVYgzUyNT+hPV5cskhit9cBmDosAfQFsL9ZvUkeenfbksAqrmjrwY0fW3Eu+abHdK1ZJJl3dH8eVjeKOMWcoTEiWKPzguzkQaM3fUAS+DtPaDkRqKOIZALgD2XYKBIrrGap1PMapgtH8=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPeT+N1Uyl8O1JCulAUhXzD/utKMtITCet4nIkSqZ6hHG8W65BKqXXov791FsmorJ74QSx6duqUtItc05f/7XSHVg4lSwRI6uJuvXQrX2N/eZBsN/LXGQ1CdkpialiBv/bNFvPr9wB17v9h5eaU1P7tuTvIFvgXaZ++TF5o+K0ibdJzumL7YlXvbnWCr6TwBzTdyuWqqZCr9li6gxZA8Kpf9oAhPBEDvY0QHZ/TVtKfW4pKJdBF1gaeAgMhaVPQ0TfaBH6Lp630SYnXDo/r4cqccd45eFloThZLRiAzQzh/5CSqXTeWa5UTyxD4gkq33uUu5ey5WBpxwvtb0/uOP6w==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JzJWle50Z3tRWHRmECEIJQsi45RA6lsaJbSR5QTg3c=;
 b=lSRNHcz6WW3H1K2ZRIsyEI5PwI1Redmr8JvP60p2nhnD7B7W1wfrAm0Ag74PXkGG6+1HWNhQoFTY2iidDhByhYspJvIfc1rdZUnDJO9pTtat6jkBuadnBecmqcJA3Nv5FKKn26D288oHo5bBul0Wd1Hp6sT/UxMrcJDSv1rlGszZnFuxWNfkO4A275sP5iMJ8PItXmQCbqWNaSS+FJp4Absq5uI3NXFigrCRyHxxPTxr+aKKOzQJlT3r1gcCbdaHsV2x/QJ6F0cpVnHJII9rMXhh+VkqwJihHdcnCzQBIn87g9gD3HLrtcXdKoGXCQ6q0tmjIKsrz5bhpfb8ujVBjA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JzJWle50Z3tRWHRmECEIJQsi45RA6lsaJbSR5QTg3c=;
 b=ebDQT7mHzBt20WJUMv22G0WZC51g4Oy5ktW6LfPBQYvOfh5r3GeWUf0WGbH1WdDX4VPJwRaMOpcZMAenwK7RCR5PabZ+5aW2zHhBVSBQ8YXbwZQQMhShi41vzc7oTMUWi7CJkNxBRzyJas/WjRwsNae10zh2hrTrci/kgRfQMh4=
x-ms-exchange-crosstenant-network-message-id: 0239993f-e3df-4f6d-1ab4-08d80286c6cd
x-ms-exchange-crosstenant-originalarrivaltime: 27 May 2020 21:41:55.6099 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Zbwmkehlgkt1kDaLSSNPT8acXUNOfOhpSNsbpGpcJxEQzEeuNsM5p6r7LMzsgh2HUaVb7mE2469ch5cDdvTOvg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4454
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 16:16:02
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Hexagon, we have LLDB, not GDB.  I tinkered with getting LLDB to talk t=
o qemu but never got if fully functional.  I'm planning to get back to it a=
t some point.

With that caveat, I'll try to answer Xiaolei's questions
- The xml file is returned from qemu to gdb in response to the Xfer:feature=
s:read command.  Providing it should be optional unless your debugger requi=
res the target to support that command.  If the target doesn't support this=
 command, the debugger will generally use the qRegisterInfo command.
- I don't think get_phys_page_debug is used for gdb debugging.  Which mode =
are you implementing?  In linux-user mode, it's not needed.  In softmmu mod=
e, it is used when you use "-d in_asm" to find the memory to disassemble.  =
If you have an MMU, you need to map the virtual address passed in to the ph=
ysical address or return -1 if there is no mapping.  If there isn't a MMU, =
return the virtual address.
- The error you are getting from gdb sounds like a mismatch between the ver=
sion of the processor that qemu is emulating and gdb thinks it is debugging=
.  In other words, qemu thinks there is a register that gdb know about.  To=
 see what's going on, try adding "-d trace:gdbstub_io_command,trace:gdbstub=
_io_reply" to your qemu command line.  This will show you the commands from=
 gdb and qemu's response.  Look for the commands I described above and see =
if qemu is giving a register that doesn't exist.

HTH,
Taylor


> -----Original Message-----
> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com> On
> Behalf Of Philippe Mathieu-Daud=E9
> Sent: Wednesday, May 27, 2020 2:20 AM
> To: casmac <1482995675@qq.com>; qemu-devel <qemu-
> devel@nongnu.org>
> Cc: Luc Michel <luc.michel@greensocs.com>; Alex Benn=E9e
> <alex.bennee@linaro.org>; Taylor Simpson <tsimpson@quicinc.com>
> Subject: Re: GDB get wrong debug infos on TI DSP architecture extension
>
>
> Hi Xiaolei,
>
> Cc'ing more developers who might answer you.
>
> On 5/27/20 8:48 AM, casmac wrote:
> > Hi all,
> >    I am working on a TI DSP architecture extension for QEMU.
>
> FYI you can find the TI TMS320C6x target implemented here:
> https://github.com/philmd/qemu/releases/tag/target-c6x-2.4
>
> I started rebasing it to QEMU 4.2 but then got distracted.
>
> > Now, we are
> > adding GDB debugging features.
> >    We have done the following, but not sure we are on the right track :
> >    - add a xml description file in gdb-xml, without understanding the
> > purpose of the file, why some architectures don't provide such xml file=
?
> >    - add ***_cpu_gdb_read_register(), ***_cpu_gdb_write_register();
> >    - added  dsp_cpu_get_phys_page_attrs_debug(), but uncertain about
> > what to return
> >      dsp_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
> > MemTxAttrs *attrs)
> >      {
> >         return addr & TARGET_PAGE_MASK;
> >      }
> >
> >    We run QEMU with the these arguments
> >    qemu-system-dsp ... -kernel filename.out -S -s
> >
> >    It turns out that gdb reads incorrect register values, and complains
> > : "warning: Target-supplied registers are not supported by the current
> > architecture".
> >
> >    Something is missing here, or we do it in a wrong way.  Any advise
> > would be helpful to us.
> >
> >    Thanks.
> >
> > xiaolei
> >
> >    ----- ti_dsp.xml  -----
> >
> >    <?xml version=3D"1.0"?>
> > <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> > <feature name=3D"org.gnu.gdb.tic3x.core">
> >     <reg name=3D"r0"  bitsize=3D"32"></reg>
> >  <reg name=3D"r1"  bitsize=3D"32"/>
> >  <reg name=3D"r2"  bitsize=3D"32"></reg>
> >  <reg name=3D"r3"  bitsize=3D"32"/>
> >  <reg name=3D"r4"  bitsize=3D"32"/>
> >  <reg name=3D"r5"  bitsize=3D"32"/>
> >  <reg name=3D"r6"  bitsize=3D"32"/>
> >  <reg name=3D"r7"  bitsize=3D"32"/>
> >  <reg name=3D"ar0" bitsize=3D"32"/>
> >  <reg name=3D"ar1" bitsize=3D"32"/>
> >  <reg name=3D"ar2" bitsize=3D"32"/>
> >  <reg name=3D"ar3" bitsize=3D"32"/>
> >  <reg name=3D"ar4" bitsize=3D"32"/>
> >  <reg name=3D"ar5" bitsize=3D"32"/>
> >  <reg name=3D"ar6" bitsize=3D"32"/>
> >  <reg name=3D"ar7" bitsize=3D"32"/>
> >  <reg name=3D"dp"  bitsize=3D"32"/>
> >  <reg name=3D"ir0" bitsize=3D"32"/>
> >  <reg name=3D"ir1" bitsize=3D"32"/>
> >  <reg name=3D"bk"  bitsize=3D"32"/>
> >  <reg name=3D"sp"  bitsize=3D"32" type=3D"data_ptr"/>
> >  <reg name=3D"st"  bitsize=3D"32"></reg>
> >  <reg name=3D"ie"  bitsize=3D"32"/>
> >  <reg name=3D"if"  bitsize=3D"32"/>
> >  <reg name=3D"iof" bitsize=3D"32"/>
> >  <reg name=3D"rs"  bitsize=3D"32"/>
> >  <reg name=3D"re"  bitsize=3D"32"/>
> >  <reg name=3D"rc"  bitsize=3D"32"/>
> >  <reg name=3D"pc"  bitsize=3D"32" type=3D"data_ptr"/>
> >  <reg name=3D"clk"  bitsize=3D"32"/>
> > </feature>
> >
>


