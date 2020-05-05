Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C355C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F13206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 21:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AmxIEtqb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="e7qT5By1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F13206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW5Hv-0007Fl-7S
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 17:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1jW5H9-0006mb-BE
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:38:51 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:15826)
 by eggs.gnu.org with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1jW5H5-0003ff-GK
 for qemu-devel@nongnu.org; Tue, 05 May 2020 17:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1588714727; x=1620250727;
 h=from:to:subject:date:message-id:mime-version;
 bh=VZZXEnd6TDMoAgYD4sw92vfklcuIRsLiI5hCDOMPqL8=;
 b=AmxIEtqbsxL6PMezWmaARyqUpxDbo/yoCZB9pBExg6Lbcv5V9zUBUdXl
 F5MjPeKvbfvMXH7SQsOVwcEJd1MGjHp9jhySou5o3TRz9z0lZW7qs/uZF
 /FjtvlB113PqviPvjTBEp8gXRcII0MR566RuQ2VZUd6KfgPMRRV4JQMjW c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 05 May 2020 14:38:44 -0700
Received: from nasanexm01c.na.qualcomm.com ([10.85.0.83])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 05 May 2020 14:38:44 -0700
Received: from nasanexm03d.na.qualcomm.com (10.85.0.91) by
 NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 May 2020 14:38:43 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Tue, 5 May 2020 14:38:43 -0700
Received: from BYAPR02MB5509.namprd02.prod.outlook.com (2603:10b6:a03:9e::31)
 by BYAPR02MB5477.namprd02.prod.outlook.com (2603:10b6:a03:95::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 21:38:42 +0000
Received: from BYAPR02MB5509.namprd02.prod.outlook.com
 ([fe80::fc11:c428:7057:1152]) by BYAPR02MB5509.namprd02.prod.outlook.com
 ([fe80::fc11:c428:7057:1152%6]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 21:38:42 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: linux-user - time64 question
Thread-Topic: linux-user - time64 question
Thread-Index: AdYjIth2hlNzOf24Tf+fzAKlcfmaBA==
Date: Tue, 5 May 2020 21:38:42 +0000
Message-ID: <BYAPR02MB55094915935E2B24286CB519BEA70@BYAPR02MB5509.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=quicinc.com;
x-originating-ip: [199.106.103.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8395030-0eb6-49e7-f612-08d7f13cae8d
x-ms-traffictypediagnostic: BYAPR02MB5477:
x-microsoft-antispam-prvs: <BYAPR02MB5477954B09C63CD0117C7B88BEA70@BYAPR02MB5477.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOt0ZnzEBWoS9WkwLQZqnwzcwgifLmfXY4pZa0wU4sDpVDOqdOZrVhGo/I24FzK4S6VhBXjqaZJioqO+ceivOv8KKYRdEsUVAMVxuPZ+AM23Fe09jOZVvQWesLVFqp7gmnJ3ejaGOnsAnvgwEsOeLlLCn6dU2imxSZdK2vpl2RD5XnGlAHC3bnHuN2tyRBagAhJULE+i07Fb2KCTe51hnFQxh0hbuLJZAztxyIwUHb3jfDmoTBTYqEb1tqlEt/ney6VLYDTLFdPDoHShMZfVVpDIkLFvg64D0R4h1SGniVRRlM/4Sts9LeutmuGmBxVruetVqdsRI8YXqqbS7ZlG0MAvKw4Hs7f3K+xDfWF7WBAoDUA+Mdllwo/uJgfsLnCtMejoUCVvPT9l/3vYFBKVa2vFPIYwF/tpAkrBEaOWlotNTz/VkYmMDF32LCxK1y92rzzql/e9tfV/ZKZreI9DC8mhvwYhNCbfX3NkoD//pNH2jZDN56Ej5v9phWCewLi7MzgaeVoAZmchOXqSej1e4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5509.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(346002)(39860400002)(376002)(396003)(366004)(33430700001)(5660300002)(52536014)(9686003)(86362001)(55016002)(71200400001)(26005)(6506007)(4744005)(186003)(6916009)(33656002)(76116006)(2906002)(7696005)(66446008)(8676002)(66556008)(316002)(64756008)(66946007)(66476007)(8936002)(478600001)(19627405001)(33440700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dKwqN4/Ob87BgKpRJpLXyc3t2OeeAo1/xjKuvwaEPkNI5EX4rbov+pOCT8fIA4JqSag1u4snkVbeBDUGBjBOfxN9/agvbUkJg7Ty+9fhLVIsfw1/rGRFbopONQwxWzu6xxt1A+WlWxPW7nZc341DPf+y/LV6CLw1FTEx6ydXnNUhpt9uHl/xeitfBgvxFqKOHVYxGQ/oNb+APjFgTPixaY010njSenBVtqq0xB5Ab1Y9f0X1MRjkyVdifIGvM16E/LcxNOMEAJm/MLih1I1F6AHCpnECSAUo5uDCs+LowzY4mcQ3IZ3qVuMhNp4b7n6Ut03+K++eiB+FHeKF/0VAl0k69VNwNNzqT8ge0f7UiK8H5hJQMqPKYgDbxqnUazp+cqjHV/0OnHsMz00+ADRN6UVI/MCVGhUj0ygjRit80RHYMHzlUS0VTwMSq7xz/x6ZmasVI6jG8jnPT0gvIcrrfMw+R70cKkIHkwvNvyZDbt7bS8G4YgQIYtLN/pZk05Qilbv1qBl8oPKtVg3MOvVhjcGpit/gBzkW5MF4nCCNGq45AUrgSOZ8KJPuqok5IZbDtm9nvVxKp2lFrxQKawfHyFrAnuV9fVaqEa/1uZi+MOPWzCwWHHABCsBJdTJJ5UMkLw8VXnxbcjc/xz4THzUuBanrnCj6aph4b0xPYtBNYlv67GMXp0XViWo92r9BbwEFyufBnryyjDNJYIX1D8DZrGmNs/TKjlX/MWhedT/ZAH0MaK80ntFPALkspELLuyao6W9GmhpuNaDKb8TgZVjCalAgrOpoMAHIYt9MxMwZln4=
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4zuFuCnt6/YaSAIdt9ytzE+p6R+f/j0HkfUfHI1q9BWTicR6yHYL6o/RUozoz08pt3+qVfWew+8gl+U4Ur1S7x+jQqOw87AGAzm1TSnekXFiNaq4rAbqKgCZYF5AA0EaRlZFgyw3UJUMX6owSajC/x+QGULtUtK+B5KoevTsZysDEB/fG/ltHpRUccTK5OkBP67rS2YD9Ny+UDGrSkgcOYknPQrmYWuQI9nw5RiMfqr0BaF5BOLhz4MaZgzFgN9wCYJamI5qLDQxaqqNSBcSi5FAb1WVV3/l11MTfpy6lM++oa7AzSVOHwJ3YQaJSUmZFNAtLseB4F9p4t4ue/hZQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZgtcvrTYbQnMe2bLVmqVW8XJr5RqE8bsfn4gE49bN4=;
 b=ld8ZbDVbAQzaxx0Z/6zDPib70NIB6QUgwEtbEXA5flGN+83zBqBTTU5WasPRjQYLEW7bjrAohBz5o7JZy6tQYgg1+gygmGkBRfK8TjZZbWS/DVXOsuT/BMw/vhImfibCoWMmYByrfidd4KPoSsQWW76cFRq4qH5OHjDKWTA3DXUb3asz855tdfFA/pxPD3sQ2GkgnB+ucBbGOYrifj842Ey4AUutEQSsD53TTcaqNGbTc3bRIJf3Uhu4i+cDyL8c0kXevPex3T+KhvI2VWfAj8WNtgbP2dvKySfTaHyl4FgEPRRWjIWrLw+29bwfIMcUx8qomYEZQZSn81W1qsjzeQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZgtcvrTYbQnMe2bLVmqVW8XJr5RqE8bsfn4gE49bN4=;
 b=e7qT5By1qole6XPEOWKSDOZyh6GqM5aU8+zGakOwqwZO3BvQ4V2AOfav99c5zZwvJ6K0k5511BhCn7jjfqLVKboFW65mfV+Asjlpg5miY582oXrzy68ie6GwizpZqS9d3DslRLP8/d09VwJYa6W8OWF0O9PCbGuEuNY7IHgUX+I=
x-ms-exchange-crosstenant-network-message-id: d8395030-0eb6-49e7-f612-08d7f13cae8d
x-ms-exchange-crosstenant-originalarrivaltime: 05 May 2020 21:38:42.3406 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 1iO9u7g+KOMF6yaLbirxJiG3AvAEjjFWXI6k2suGoeAOJsAmQ7SkCzqCQFwTXUjiFzRBooaihfhWrR6PpaE6DA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5477
x-originatororg: quicinc.com
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB55094915935E2B24286CB519BEA70BYAPR02MB5509namp_"
MIME-Version: 1.0
Received-SPF: pass client-ip=199.106.114.39; envelope-from=sidneym@quicinc.com;
 helo=alexa-out-sd-02.qualcomm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 17:38:44
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

--_000_BYAPR02MB55094915935E2B24286CB519BEA70BYAPR02MB5509namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

I=92m looking at a testcase failure when my target uses 64bit time in msg.h=
 (struct msqid_ds).  I=92ve been able to get around this but changing targe=
t_msqid_ds like so:

@@ -3900,18 +3901,9 @@ static inline abi_long do_semop(int semid, abi_long =
ptr,
unsigned nsops)
 struct target_msqid_ds
 {
     struct target_ipc_perm msg_perm;
-    abi_ulong msg_stime;
-#if TARGET_ABI_BITS =3D=3D 32
-    abi_ulong __unused1;
-#endif
-    abi_ulong msg_rtime;
-#if TARGET_ABI_BITS =3D=3D 32
-    abi_ulong __unused2;
-#endif
-    abi_ulong msg_ctime;
-#if TARGET_ABI_BITS =3D=3D 32
-    abi_ulong __unused3;
-#endif
+    abi_ullong msg_stime;
+    abi_ullong msg_rtime;
+    abi_ullong msg_ctime;
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
     abi_ulong msg_qbytes;

It seems like either should have worked but I get garbage back in some of t=
he elements below msg_time fields without the change.

If time_t is 64bits then it seems like stime/rtime/ctime should be abi_ullo=
ng.

My target is Hexagon and the TARGET_ABI_BITS is 32.

Thanks,

--_000_BYAPR02MB55094915935E2B24286CB519BEA70BYAPR02MB5509namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"WordSection1"></div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt; =
font-family: Calibri, sans-serif;">
I=92m looking at a testcase failure when my target uses 64bit time in <span=
 class=3D"SpellE">
msg.h</span> (struct <span class=3D"SpellE">msqid_ds</span>).<span style=3D=
"">&nbsp; </span>
I=92ve been able to get around this but changing <span class=3D"SpellE">tar=
get_msqid_ds</span> like so:</p>
<p class=3D"MsoNormal" style=3D"margin: 0in 0in 0.0001pt; font-size: 11pt; =
font-family: Calibri, sans-serif;">
<br>
</p>
<div class=3D"MsoNormal" style=3D"margin: 0px 0in 0.000133333px; font-size:=
 11pt; font-family: Calibri, sans-serif;">
<span>@@ -3900,18 &#43;3901,9 @@ static inline abi_long do_semop(int semid,=
 abi_long ptr,
<br>
</span>
<div>unsigned nsops)<br>
</div>
<div>&nbsp;struct target_msqid_ds<br>
</div>
<div>&nbsp;{<br>
</div>
<div>&nbsp; &nbsp; &nbsp;struct target_ipc_perm msg_perm;<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong msg_stime;<br>
</div>
<div>-#if TARGET_ABI_BITS =3D=3D 32<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong __unused1;<br>
</div>
<div>-#endif<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong msg_rtime;<br>
</div>
<div>-#if TARGET_ABI_BITS =3D=3D 32<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong __unused2;<br>
</div>
<div>-#endif<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong msg_ctime;<br>
</div>
<div>-#if TARGET_ABI_BITS =3D=3D 32<br>
</div>
<div>- &nbsp; &nbsp;abi_ulong __unused3;<br>
</div>
<div>-#endif<br>
</div>
<div>&#43; &nbsp; &nbsp;abi_ullong msg_stime;<br>
</div>
<div>&#43; &nbsp; &nbsp;abi_ullong msg_rtime;<br>
</div>
<div>&#43; &nbsp; &nbsp;abi_ullong msg_ctime;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;abi_ulong __msg_cbytes;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;abi_ulong msg_qnum;<br>
</div>
<div>&nbsp; &nbsp; &nbsp;abi_ulong msg_qbytes;<br>
</div>
<div><br>
</div>
<div>It seems like either should have worked but I get garbage back in some=
 of the elements below msg_time fields without the change.</div>
<div><br>
</div>
<div>If time_t is 64bits then it seems like stime/rtime/ctime should be abi=
_ullong.</div>
<div><br>
</div>
<div>My target is Hexagon and the TARGET_ABI_BITS is 32.</div>
<div><br>
</div>
<div>Thanks,</div>
<span></span></div>
</div>
</body>
</html>

--_000_BYAPR02MB55094915935E2B24286CB519BEA70BYAPR02MB5509namp_--

