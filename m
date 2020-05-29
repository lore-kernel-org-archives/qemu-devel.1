Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84449C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA2B206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="y/ihMJqT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="PPbulv0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA2B206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegoX-0000sK-BB
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jegnH-0008U3-3e
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:19:35 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:54034)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1jegnD-0001A8-Ba
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:19:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1590765571; x=1622301571;
 h=from:to:subject:date:message-id:references:in-reply-to:
 mime-version; bh=1A/0z4a4WJDJVbSZ60O9dX9N52brl6b/gjqI6YQWQDg=;
 b=y/ihMJqTQMjOoSol321Qt2V474roWWDnPJrE+ZDu6faRTfMWwCrsDJ6Q
 ipgh3chpeYJdow/OKwEkT+RpflYa56jU6wQroWZs8yaE//VsEj+EsALh1
 DQd3VOHi+eKFRxHu2CzZEWCC1l/aEm6xBqcqTdbg1lkOMGjZE6wxmFhPy 8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 29 May 2020 08:19:27 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 29 May 2020 08:19:26 -0700
Received: from apsanexr02b.ap.qualcomm.com (10.85.0.27) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 08:19:26 -0700
Received: from nasanexm03c.na.qualcomm.com (10.85.0.106) by
 apsanexr02b.ap.qualcomm.com (10.85.0.27) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 08:19:24 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03c.na.qualcomm.com (10.85.0.106) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 29 May 2020 08:19:24 -0700
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (2603:10b6:a03:46::32)
 by BYAPR02MB6439.namprd02.prod.outlook.com (2603:10b6:a03:126::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Fri, 29 May
 2020 15:19:22 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::3594:3599:aab9:8b8e%6]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 15:19:22 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: casmac <1482995675@qq.com>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: Re:RE: GDB get wrong debug infos on TI DSP architecture extension
Thread-Topic: Re:RE: GDB get wrong debug infos on TI DSP architecture extension
Thread-Index: AQHWM/MU+bq357d/D0q6Pp60ylYupqi7hneAgADj35CAAkMDAIAAg1hg
Date: Fri, 29 May 2020 15:19:22 +0000
Message-ID: <BYAPR02MB48863C93225012FAEC17C30EDE8F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <tencent_86D9DB902C46CBAC4F3A6FD5B4CDA93B7506@qq.com>
 <8b83e11b-e593-b7db-48b6-252e23c599da@amsat.org>
 <BYAPR02MB4886DAC33FB41B53887E029DDEB10@BYAPR02MB4886.namprd02.prod.outlook.com>
 <tencent_1836AC05D30788B7689AE834829AE0AD4F05@qq.com>
In-Reply-To: <tencent_1836AC05D30788B7689AE834829AE0AD4F05@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: qq.com; dkim=none (message not signed)
 header.d=none;qq.com; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [2605:6000:ee9b:a300:9875:9184:ab68:f020]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9126d579-3ba0-460d-00c1-08d803e3aa48
x-ms-traffictypediagnostic: BYAPR02MB6439:
x-microsoft-antispam-prvs: <BYAPR02MB643968DF605C4212FA53D57ADE8F0@BYAPR02MB6439.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZtQBXNT/jfn8QTkCOZmbszFI3aN9SwXURpbax6/iozw9awCPaAqzFI5tkruGNfYCBDFLsoOn3rVaveSc/pDWxaNWgZ3x8X4Endw1UdTp9J0qHlNBQ6nm1ePnYEvkduC8SHSKR5qYYE0k5c/sA98/2Kpl8IHB9liBhJ8teYAlOuwzQi5kfv0OrXIxjB0qf4nJpNZ/sUi9deXsITmqyQ5HUybGh9jcwNI3ycRYD/VkA8bE/KBPs3q2P0aP4RbB9Gm91zwbZ7+PQl/Sr0clvj30SUvE8o6KPg0Ce0y7Y1fHHPk8btDRbJ3wVOur15jC51lKrWcNUQ0wOcs4Yq59MGuX3bNIQpdcHOdVZBc3HYNxf6W3oh2GxtzjgIiT7g0LWdC0WyZ3h9Gkj7VVjUecs0//w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4886.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(33656002)(21490400003)(52536014)(53546011)(64756008)(66556008)(186003)(66946007)(7696005)(66446008)(66476007)(71200400001)(6506007)(8936002)(110136005)(76116006)(86362001)(478600001)(8676002)(83380400001)(2906002)(166002)(55016002)(9686003)(5660300002)(66574014)(316002)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: heDTVnIONfnYt+5bmmGRejmAFa1pKfDsKPycTtvRHZ9d+cPe8f3abJx3RWS3s+6tD4t5gvxT0utu81Hab1QOZ9F1wmdo/ehAUc5hV238jwhkayqdGT5u+YfPUUtviv7JGgTglqIMAdseEgY8Y0lBttBKAMLj6CAe8+CEDog6CjBVAreL5VUi8AwoJCFBaV73M2KFqYWnRrdKqlXiLWabPMNnX672y9R6JRh8OErSS0YXm+csZsgTsPHadCYLZY9CBbYe6kQZjXO0/t40b5CuXs8hf6ox8UokKARNjbu/O+5NirNwYQef3hA7AfctC3A5P0+jHxrAMoSuwD1aaFEHJkPCn1BERIgrGynYse7rBMLE6umc1ZOUIRtvOivUNiXDOTqR97xVrvJEtTwKR4dbza9LubX5tCkFZtg8j076vcIs6eCm2cpGUsOLVFwOaWXsvJ/2uDkmseJUsgd6/+EnH55LcqEhhQp6FdT3g6KoW5NanLkVXu8aUKP9GNO6veE3wgsofMMwiFPFhUZfUs0fDQUw2QjiiMl85H9j/CmfgnAEf8aw3EbT9DFpyt9BZpv4
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5INNSAiG8PmJD331mrW7EsRlZ6d5QZfLnJENtyCl7i1F5NAK2E2FqomhXO7nJo2wT9Akl36a3ayXWyyySe8tTKmqiXvf2rPnS8vka4jDV5uEaarUM1E0VVoxTCRBFJwiC4ywxXyt36aZChlXTalJDrgoHwlawQYcQzAIb3Yq+kOnJpHA4anmvATDsJaASHjaZT3zBVzey0O7ZHKiHju1HxTo79ksC69+7NCSaTOw32MwHcn1JEuu5EEEqPErS3HtUe7Er/DXwqNG4zG0eXcmJkFRBVvyv+w0Sc+I1NsVxuelnzrEP85BPqaeeOzluD/sfsyfjbStdqwXx68OcrJZQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpWY99VlbNO9wU/jugb8oNnFEZbh3elI50N9lcYKAek=;
 b=hfrErAMGtdV7di6Ayw0rFiUtzH52U2omqND4nZgG5OiXoLtcpwcSFKHpSfEBWcQqt5xUu3plNQtyAnzczXs7BlfCxWnG0Q2W7oYrJXGqaIT+xLdSYkqyeZqBbAPA4kZgAh0RBAwaLJ+ZW1eE5x2tWwNJzx/U+Z1g14B2oxnm3Vn3sp/7+Kz9J0v8BnqNZYJRXfUU+SEovy22eEzeTS5a1aUwwTc2F1Ys8wvSRx7M4J0gXVH9+UoixIGU53sF/DZloPuLg8wp+w/HWjVZ/ylcO+5gU7z8quRT7WoQ4mid7KafqBqKwY+qEfnu4inGLa/Xhc2qRQ789iBaPakhKhkCSg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpWY99VlbNO9wU/jugb8oNnFEZbh3elI50N9lcYKAek=;
 b=PPbulv0VAZfP4ku2ncWcnrmoC7J0bJw4hZYrTLiLVcsnHpXqXsXsyDYNABDTyxVWFt7wde4iHJI94ocNknht5lnUv14PaxFgvyT2wRuLJZKwO1nq4CTFYkE8e9Runl3W5V7Zqid7I/fxxJ/JN2dKki9F4ymjtkiskfvPdH2V1B8=
x-ms-exchange-crosstenant-network-message-id: 9126d579-3ba0-460d-00c1-08d803e3aa48
x-ms-exchange-crosstenant-originalarrivaltime: 29 May 2020 15:19:22.0581 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: kPZRnrnL16YpoSh/Kodl9m8b4fKH1jEpZaGHZUVE6eURjpUE0eR4/Okxj0od6xvPUTch7FQ7tPWdzgiG6WFW9w==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB6439
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB48863C93225012FAEC17C30EDE8F0BYAPR02MB4886namp_"
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
Received-SPF: pass client-ip=199.106.114.39; envelope-from=tsimpson@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 11:19:27
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BYAPR02MB48863C93225012FAEC17C30EDE8F0BYAPR02MB4886namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

To figure out which register gdb is complaining about, you could step throu=
gh the code in gdb or selectively remove parts of the xml file until the er=
ror goes away.

The unaligned start address sounds like a problem with the executable you a=
re trying to debug, not qemu or gdb.

Taylor



From: casmac <1482995675@qq.com>
Sent: Friday, May 29, 2020 2:28 AM
To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel <qemu-devel@nongnu.or=
g>
Subject: Re:RE: GDB get wrong debug infos on TI DSP architecture extension

Hi,
   Thanks for the hints!! I put "-d trace:gdbstub_io_command,trace:gdbstub_=
io_reply" to command line, get the following from QEMU at the beginning whe=
n gdb starts, is there anything went wrong?

6792@1590734139.390330:gdbstub_io_command<mailto:6792@1590734139.390330:gdb=
stub_io_command> Received: qSupported:xmlRegisters=3Dtivc33;QNonStop;qReloc=
Insn+
6792@1590734139.391330:gdbstub_io_reply<mailto:6792@1590734139.391330:gdbst=
ub_io_reply> Sent: PacketSize=3D1000;qXfer:features:read+;multiprocess+
6792@1590734139.391330:gdbstub_io_command<mailto:6792@1590734139.391330:gdb=
stub_io_command> Received: Hg0
6792@1590734139.392331:gdbstub_io_reply<mailto:6792@1590734139.392331:gdbst=
ub_io_reply> Sent: OK
6792@1590734139.392331:gdbstub_io_command<mailto:6792@1590734139.392331:gdb=
stub_io_command> Received: qXfer:features:read:target.xml:0,ffb
6792@1590734139.393331:gdbstub_io_command<mailto:6792@1590734139.393331:gdb=
stub_io_command> Received: qXfer:features:read:dsp-vc33-core.xml:0,ffb
6792@1590734139.399331:gdbstub_io_command<mailto:6792@1590734139.399331:gdb=
stub_io_command> Received: ?
6792@1590734139.399331:gdbstub_io_reply<mailto:6792@1590734139.399331:gdbst=
ub_io_reply> Sent: T05thread:01;
6792@1590734139.401331:gdbstub_io_command<mailto:6792@1590734139.401331:gdb=
stub_io_command> Received: Hc-1
 6792@1590734139.402331:gdbstub_io_command<mailto:6792@1590734139.402331:gd=
bstub_io_command> Received: qC
6792@1590734139.402331:gdbstub_io_reply<mailto:6792@1590734139.402331:gdbst=
ub_io_reply> Sent: QC01
6792@1590734139.402331:gdbstub_io_command<mailto:6792@1590734139.402331:gdb=
stub_io_command> Received: qAttached
6792@1590734139.403331:gdbstub_io_reply<mailto:6792@1590734139.403331:gdbst=
ub_io_reply> Sent: 1
6792@1590734139.403331:gdbstub_io_command<mailto:6792@1590734139.403331:gdb=
stub_io_command> Received: qOffsets
....

 It looks like the .xml file is working , the "info reg" command returns th=
e registers defined for TI DSP processor:
(szdb) info reg
r0             0xc000000000     -274877906944
r1             0x0      0
r2             0x2200000000     146028888064
r3             0x0      0
r4             0x0      0
r5             0x4100000000     279172874240
r6             0x0      0
r7             0x6800000000     446676598784
ar0            0x0      0
ar1            0x0      0
ar2            0x0      0
ar3            0x0      0
ar4            0x0      0
ar5            0x0      0
ar6            0x0      0
ar7            0x0      0
dp             0x0      0
ir0            0x0      0
ir1            0x0      0
bk             0x0      0
sp             0x0      0
st             0x54     84
ie             0x0      0
if             0x0      0
iof            0x0      0
rs             0x0      0
re             0x0      0
rc             0x0      0
pc             0xf      15
clk            0x0      0

    But GDB still complains  "warning: Target-supplied registers are not su=
pported by the current architecture" and an unkown symbol:
atexit (
    fun=3D<error reading variable: Unknown argument list address for `fun'.=
>)
    at exit.c:44
44      exit.c: No such file or directory.
     Another problem is that DSP processor addresses memory by word(4 bytes=
), the starting entry address from the executable is 0xF, which will fail t=
he 4-byte alignment assertion, so the instruction retrieved does not look r=
ight. We are going to fix it.
   thanks .
xiaolei
------------------ Origina,l ------------------
From: "Taylor Simpson"<tsimpson@quicinc.com<mailto:tsimpson@quicinc.com>>;
Date: Thu, May 28, 2020 05:41 AM
To: "Philippe Mathieu-Daud "<f4bug@amsat.org<mailto:f4bug@amsat.org>>;"casm=
ac"<1482995675@qq.com<mailto:1482995675@qq.com>>;"qemu-devel"<qemu-devel@no=
ngnu.org<mailto:qemu-devel@nongnu.org>>;
Cc: "Alex Benn e"<alex.bennee@linaro.org<mailto:alex.bennee@linaro.org>>;"L=
uc Michel"<luc.michel@greensocs.com<mailto:luc.michel@greensocs.com>>;
Subject: RE: GDB get wrong debug infos on TI DSP architecture extension

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
> From: Philippe Mathieu-Daud=E9 <philippe.mathieu.daude@gmail.com<mailto:p=
hilippe.mathieu.daude@gmail.com>> On
> Behalf Of Philippe Mathieu-Daud=E9
> Sent: Wednesday, May 27, 2020 2:20 AM
> To: casmac <1482995675@qq.com<mailto:1482995675@qq.com>>; qemu-devel <qem=
u-
> devel@nongnu.org<mailto:devel@nongnu.org>>
> Cc: Luc Michel <luc.michel@greensocs.com<mailto:luc.michel@greensocs.com>=
>; Alex Benn=E9e
> <alex.bennee@linaro.org<mailto:alex.bennee@linaro.org>>; Taylor Simpson <=
tsimpson@quicinc.com<mailto:tsimpson@quicinc.com>>
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


--_000_BYAPR02MB48863C93225012FAEC17C30EDE8F0BYAPR02MB4886namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Arial Narrow";
	panose-1:2 11 6 6 2 2 2 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">To figure out which register gdb is complaining abou=
t, you could step through the code in gdb or selectively remove parts of th=
e xml file until the error goes away.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The unaligned start address sounds like a problem wi=
th the executable you are trying to debug, not qemu or gdb.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Taylor<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> casmac &lt;1482995675@qq.com&gt; <br>
<b>Sent:</b> Friday, May 29, 2020 2:28 AM<br>
<b>To:</b> Taylor Simpson &lt;tsimpson@quicinc.com&gt;; qemu-devel &lt;qemu=
-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re:RE: GDB get wrong debug infos on TI DSP architecture ext=
ension<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Hi,&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp;Thanks for the hints!! I put &quot;-d t=
race:gdbstub_io_command,trace:gdbstub_io_reply&quot; to command line, get t=
he following from QEMU at the beginning when gdb starts, is there anything =
went wrong?<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.390330:gdbstub_io_=
command">6792@1590734139.390330:gdbstub_io_command</a> Received: qSupported=
:xmlRegisters=3Dtivc33;QNonStop;qRelocInsn&#43;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.391330:gdbstub_io_=
reply">6792@1590734139.391330:gdbstub_io_reply</a> Sent: PacketSize=3D1000;=
qXfer:features:read&#43;;multiprocess&#43;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.391330:gdbstub_io_=
command">6792@1590734139.391330:gdbstub_io_command</a> Received: Hg0<o:p></=
o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.392331:gdbstub_io_=
reply">6792@1590734139.392331:gdbstub_io_reply</a> Sent: OK<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.392331:gdbstub_io_=
command">6792@1590734139.392331:gdbstub_io_command</a> Received: qXfer:feat=
ures:read:target.xml:0,ffb<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.393331:gdbstub_io_=
command">6792@1590734139.393331:gdbstub_io_command</a> Received: qXfer:feat=
ures:read:dsp-vc33-core.xml:0,ffb<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.399331:gdbstub_io_=
command">6792@1590734139.399331:gdbstub_io_command</a> Received: ?<o:p></o:=
p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.399331:gdbstub_io_=
reply">6792@1590734139.399331:gdbstub_io_reply</a> Sent: T05thread:01;<o:p>=
</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.401331:gdbstub_io_=
command">6792@1590734139.401331:gdbstub_io_command</a> Received: Hc-1<o:p><=
/o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<a href=3D"mailto:6792@1590734139.402331:gdbst=
ub_io_command">6792@1590734139.402331:gdbstub_io_command</a> Received: qC<o=
:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.402331:gdbstub_io_=
reply">6792@1590734139.402331:gdbstub_io_reply</a> Sent: QC01<o:p></o:p></p=
>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.402331:gdbstub_io_=
command">6792@1590734139.402331:gdbstub_io_command</a> Received: qAttached<=
o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.403331:gdbstub_io_=
reply">6792@1590734139.403331:gdbstub_io_reply</a> Sent: 1<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"mailto:6792@1590734139.403331:gdbstub_io_=
command">6792@1590734139.403331:gdbstub_io_command</a> Received: qOffsets<o=
:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">....<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;It looks like the .xml file is working , the &=
quot;info reg&quot; command returns the registers defined for TI DSP proces=
sor:<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">(szdb) info reg<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
c000000000&nbsp; &nbsp; &nbsp;-274877906944<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r2&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
2200000000&nbsp; &nbsp; &nbsp;146028888064<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r3&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r4&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r5&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
4100000000&nbsp; &nbsp; &nbsp;279172874240<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r6&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">r7&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
6800000000&nbsp; &nbsp; &nbsp;446676598784<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar2&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar3&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar4&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar5&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar6&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ar7&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">dp&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ir0&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ir1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">bk&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">sp&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">st&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
54&nbsp; &nbsp; &nbsp;84<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">ie&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">if&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">iof&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">rs&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">re&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">rc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
0&nbsp; &nbsp; &nbsp; 0<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">pc&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x=
f&nbsp; &nbsp; &nbsp; 15<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">clk&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0&nbs=
p; &nbsp; &nbsp; 0&nbsp;&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp; But GDB still complains&nbsp; &quot;wa=
rning: Target-supplied registers are not supported by the current architect=
ure&quot; and an unkown symbol:&nbsp;<o:p></o:p></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">atexit (<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp; fun=3D&lt;error reading variable: Unkn=
own argument list address for `fun'.&gt;)<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp; at exit.c:44<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">44&nbsp; &nbsp; &nbsp; exit.c: No such file or direc=
tory.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp; &nbsp;Another problem is that DSP proc=
essor addresses memory by word(4 bytes), the starting entry address from th=
e executable is 0xF, which will fail the 4-byte alignment assertion, so the=
 instruction retrieved does not look right. We are
 going to fix it.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp; &nbsp;thanks .<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">xiaolei&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Ari=
al Narrow&quot;,sans-serif">------------------&nbsp;Origina,l&nbsp;--------=
----------<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:#EFEFEF"><b><span style=3D"font-=
size:9.0pt;color:black">From:</span></b><span style=3D"font-size:9.0pt;colo=
r:black">&nbsp;&quot;Taylor Simpson&quot;&lt;<a href=3D"mailto:tsimpson@qui=
cinc.com">tsimpson@quicinc.com</a>&gt;;</span><span style=3D"font-size:9.0p=
t"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:#EFEFEF"><b><span style=3D"font-=
size:9.0pt;color:black">Date:</span></b><span style=3D"font-size:9.0pt;colo=
r:black">&nbsp;Thu, May 28, 2020 05:41 AM</span><span style=3D"font-size:9.=
0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:#EFEFEF"><b><span style=3D"font-=
size:9.0pt;color:black">To:</span></b><span style=3D"font-size:9.0pt;color:=
black">&nbsp;&quot;Philippe Mathieu-Daud &quot;&lt;<a href=3D"mailto:f4bug@=
amsat.org">f4bug@amsat.org</a>&gt;;&quot;casmac&quot;&lt;<a href=3D"mailto:=
1482995675@qq.com">1482995675@qq.com</a>&gt;;&quot;qemu-devel&quot;&lt;<a h=
ref=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;;</span><=
span style=3D"font-size:9.0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:#EFEFEF"><b><span style=3D"font-=
size:9.0pt;color:black">Cc:</span></b><span style=3D"font-size:9.0pt;color:=
black">&nbsp;&quot;Alex Benn e&quot;&lt;<a href=3D"mailto:alex.bennee@linar=
o.org">alex.bennee@linaro.org</a>&gt;;&quot;Luc Michel&quot;&lt;<a href=3D"=
mailto:luc.michel@greensocs.com">luc.michel@greensocs.com</a>&gt;;</span><s=
pan style=3D"font-size:9.0pt"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:#EFEFEF"><b><span style=3D"font-=
size:9.0pt;color:black">Subject:</span></b><span style=3D"font-size:9.0pt;c=
olor:black">&nbsp;RE: GDB get wrong debug infos on TI DSP architecture exte=
nsion</span><span style=3D"font-size:9.0pt"><o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">For Hexagon, we have =
LLDB, not GDB.&nbsp; I tinkered with getting LLDB to talk to qemu but never=
 got if fully functional.&nbsp; I'm planning to get back to it at some poin=
t.<br>
<br>
With that caveat, I'll try to answer Xiaolei's questions<br>
- The xml file is returned from qemu to gdb in response to the Xfer:feature=
s:read command.&nbsp; Providing it should be optional unless your debugger =
requires the target to support that command.&nbsp; If the target doesn't su=
pport this command, the debugger will generally
 use the qRegisterInfo command.<br>
- I don't think get_phys_page_debug is used for gdb debugging.&nbsp; Which =
mode are you implementing?&nbsp; In linux-user mode, it's not needed.&nbsp;=
 In softmmu mode, it is used when you use &quot;-d in_asm&quot; to find the=
 memory to disassemble.&nbsp; If you have an MMU, you need to
 map the virtual address passed in to the physical address or return -1 if =
there is no mapping.&nbsp; If there isn't a MMU, return the virtual address=
.<br>
- The error you are getting from gdb sounds like a mismatch between the ver=
sion of the processor that qemu is emulating and gdb thinks it is debugging=
.&nbsp; In other words, qemu thinks there is a register that gdb know about=
.&nbsp; To see what's going on, try adding
 &quot;-d trace:gdbstub_io_command,trace:gdbstub_io_reply&quot; to your qem=
u command line.&nbsp; This will show you the commands from gdb and qemu's r=
esponse.&nbsp; Look for the commands I described above and see if qemu is g=
iving a register that doesn't exist.<br>
<br>
HTH,<br>
Taylor<br>
<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Philippe Mathieu-Daud=E9 &lt;<a href=3D"mailto:philippe.mathieu.=
daude@gmail.com">philippe.mathieu.daude@gmail.com</a>&gt; On<br>
&gt; Behalf Of Philippe Mathieu-Daud=E9<br>
&gt; Sent: Wednesday, May 27, 2020 2:20 AM<br>
&gt; To: casmac &lt;<a href=3D"mailto:1482995675@qq.com">1482995675@qq.com<=
/a>&gt;; qemu-devel &lt;qemu-<br>
&gt; <a href=3D"mailto:devel@nongnu.org">devel@nongnu.org</a>&gt;<br>
&gt; Cc: Luc Michel &lt;<a href=3D"mailto:luc.michel@greensocs.com">luc.mic=
hel@greensocs.com</a>&gt;; Alex Benn=E9e<br>
&gt; &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</=
a>&gt;; Taylor Simpson &lt;<a href=3D"mailto:tsimpson@quicinc.com">tsimpson=
@quicinc.com</a>&gt;<br>
&gt; Subject: Re: GDB get wrong debug infos on TI DSP architecture extensio=
n<br>
&gt;<br>
&gt;<br>
&gt; Hi Xiaolei,<br>
&gt;<br>
&gt; Cc'ing more developers who might answer you.<br>
&gt;<br>
&gt; On 5/27/20 8:48 AM, casmac wrote:<br>
&gt; &gt; Hi all,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; I am working on a TI DSP architecture extension=
 for QEMU.<br>
&gt;<br>
&gt; FYI you can find the TI TMS320C6x target implemented here:<br>
&gt; <a href=3D"https://github.com/philmd/qemu/releases/tag/target-c6x-2.4"=
>https://github.com/philmd/qemu/releases/tag/target-c6x-2.4</a><br>
&gt;<br>
&gt; I started rebasing it to QEMU 4.2 but then got distracted.<br>
&gt;<br>
&gt; &gt; Now, we are<br>
&gt; &gt; adding GDB debugging features.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; We have done the following, but not sure we are=
 on the right track :<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; - add a xml description file in gdb-xml, withou=
t understanding the<br>
&gt; &gt; purpose of the file, why some architectures don't provide such xm=
l file?<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; - add ***_cpu_gdb_read_register(), ***_cpu_gdb_=
write_register();<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; - added&nbsp; dsp_cpu_get_phys_page_attrs_debug=
(), but uncertain about<br>
&gt; &gt; what to return<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dsp_cpu_get_phys_page_attrs_debug(C=
PUState *cs, vaddr addr,<br>
&gt; &gt; MemTxAttrs *attrs)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return addr &amp;=
 TARGET_PAGE_MASK;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; We run QEMU with the these arguments<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; qemu-system-dsp ... -kernel filename.out -S -s<=
br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; It turns out that gdb reads incorrect register =
values, and complains<br>
&gt; &gt; : &quot;warning: Target-supplied registers are not supported by t=
he current<br>
&gt; &gt; architecture&quot;.<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; Something is missing here, or we do it in a wro=
ng way.&nbsp; Any advise<br>
&gt; &gt; would be helpful to us.<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; Thanks.<br>
&gt; &gt;<br>
&gt; &gt; xiaolei<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; ----- ti_dsp.xml&nbsp; -----<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; &lt;?xml version=3D&quot;1.0&quot;?&gt;<br>
&gt; &gt; &lt;!DOCTYPE feature SYSTEM &quot;gdb-target.dtd&quot;&gt;<br>
&gt; &gt; &lt;feature name=3D&quot;org.gnu.gdb.tic3x.core&quot;&gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; &lt;reg name=3D&quot;r0&quot;&nbsp; bitsi=
ze=3D&quot;32&quot;&gt;&lt;/reg&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r1&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r2&quot;&nbsp; bitsize=3D&quot;32&quot=
;&gt;&lt;/reg&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r3&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r4&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r5&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r6&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;r7&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar0&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar1&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar2&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar3&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar4&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar5&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar6&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ar7&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;dp&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ir0&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ir1&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;bk&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;sp&quot;&nbsp; bitsize=3D&quot;32&quot=
; type=3D&quot;data_ptr&quot;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;st&quot;&nbsp; bitsize=3D&quot;32&quot=
;&gt;&lt;/reg&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;ie&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;if&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;iof&quot; bitsize=3D&quot;32&quot;/&gt=
;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;rs&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;re&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;rc&quot;&nbsp; bitsize=3D&quot;32&quot=
;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;pc&quot;&nbsp; bitsize=3D&quot;32&quot=
; type=3D&quot;data_ptr&quot;/&gt;<br>
&gt; &gt;&nbsp; &lt;reg name=3D&quot;clk&quot;&nbsp; bitsize=3D&quot;32&quo=
t;/&gt;<br>
&gt; &gt; &lt;/feature&gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_BYAPR02MB48863C93225012FAEC17C30EDE8F0BYAPR02MB4886namp_--

