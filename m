Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42462C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4C12075A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 07:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="Rm6Cb/lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4C12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGdQo-0003Nu-CJ
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 03:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGY9U-00030S-1V
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 21:47:00 -0400
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:46558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGY9R-0002wu-Ne
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 21:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1599788816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=Hs3ydqFsagqFJ+7NUNfymMc/6ohNVUuwi4/7FnB5yNQ=;
 b=Rm6Cb/lYt8ZHVn6opEOd7LbAO4znqqadhVm9PK+vBsEF2Eou+N4eBPjVgEDwuxDCesJA/x
 Q5R2JM8I5abLUAGU2eMEdfNAwyCQtoNrtZ6ucCv8XnxzhNjs4HNtKKkAyRXskLZ3+2V/Pk
 hQsaa3hdN7QEulqIssk3BefZnSyzF3k=
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-7eMTf-niPCK6kEd4ZWCgGw-1; Thu, 10 Sep 2020 21:45:38 -0400
X-MC-Unique: 7eMTf-niPCK6kEd4ZWCgGw-1
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::9) by CS1PR8401MB0485.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 01:45:36 +0000
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c]) by CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c%12]) with mapi id 15.20.3370.016; Fri, 11 Sep
 2020 01:45:36 +0000
From: "McMillan, Erich" <erich.mcmillan@hp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: PATCH: Increase System Firmware Max Size
Thread-Topic: PATCH: Increase System Firmware Max Size
Thread-Index: AQHWh9wbvH3PA15ju0WtYVYwRPIQ7g==
Date: Fri, 11 Sep 2020 01:45:36 +0000
Message-ID: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.199.17.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbf460bd-9506-4529-ba02-08d855f4615f
x-ms-traffictypediagnostic: CS1PR8401MB0485:
x-microsoft-antispam-prvs: <CS1PR8401MB0485C75A63C7B2FA32344F40F3240@CS1PR8401MB0485.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5BSQ1FPwbjTkw1E/ol4rskbcOon4GoHT+r1FkggJNvZNxzd0s4ObC9YvSK24fO9IjEN2rQIpvrz7b1VseHM3BVEhCNz1newNt3GULqGOVJN7S15L6GUgsaVXZ3F1qARcDQXl6sZ3zWVPHtf9fFmaeF9zldVizdXUv6JOxTXwYFQSNA2pUBThYDYjRWqVtYPv7A8Gio9GquGDQ+uaq/yP8I/FsOOByyZWTgsSArk8RUqYa2CxS7wjbDiLaCNBq1IwflDK9bJLE8/znRT/atrcoozaZVMD9g5PBBQuuoMhPtaVpisb+nvGxSRHeqBTKcCT6XqpYFt7DBVyy+tKQF91g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(19627405001)(52536014)(8676002)(26005)(8936002)(86362001)(83380400001)(5660300002)(91956017)(76116006)(66946007)(4744005)(71200400001)(66446008)(4326008)(66556008)(64756008)(66476007)(316002)(6916009)(54906003)(2906002)(33656002)(478600001)(6506007)(186003)(9686003)(7696005)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 7yJuiamxNlvZ7Vh/ItH0SSjVEA727k7LZiDgn6KpJxpkgLsV/eTH5+iuhbTws/zifUylB3yWGNjLBRIb4rowKj6WXR7gSfUepbB+87ghwJhPwLEE5aGVLr5tzWllO4Dr/osdOtk1edjur0zPBbg5z1of7qG2B4yQKvhBLRLb5OujzOj4WD1Jte8TM+q3USmXzGeweO/uTHptir8utJu+qFn5CMC7pgpo5OkoX33A9U8fKM3PHAOZgN/NcA/TUQ4rEBf8oF/q0B4FTValYSJjG5pKu2KSW36quQrDidPRr5yABdqfFeuch6JLhCDLGu9tmpK6LGTDbg2yDTFUQ4prz9ooVLQeW8gkKzeONlUUKZIrmgvyumWLKO5jvPVtsxY/UUEGqrzx7fYHCHohJAQZywA8J1vCiJ+Eo9uA7HwI/t/eVKUhhkxkdDyYm609bidARPSffADRW6HCq8LY8xjzzBt0Lvm8a8wVutqxFa+Fs7gpM0vbtNRJn6GVjR2AMddDHWOvJJKQRZA1omklvM+JiXyYbTBlvZd2bIMlp9fUSCNj93KSyqT5Cy6vp6U5Fwprs3q5ElTfH/T6ZUf7YqU04ku7kInaR9BG5tLc0YXS0M6z2yqqkMyuVRp7g6yucDawJP68seu5oG+sFzzNIZOFew==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf460bd-9506-4529-ba02-08d855f4615f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 01:45:36.5420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OYz5GAIYKtniDtHU7An89J1srOzd70jTlbj9uenLEe0xfO2VaZZ8z/9xRsD07LZl1D+I/pJmCK0QVL4ssRHRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0485
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: hp.com
Content-Type: multipart/alternative;
 boundary="_000_CS1PR8401MB0327EF9D532330BA44257AFCF3240CS1PR8401MB0327_"
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.162; envelope-from=erich.mcmillan@hp.com;
 helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 21:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 11 Sep 2020 03:24:38 -0400
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

--_000_CS1PR8401MB0327EF9D532330BA44257AFCF3240CS1PR8401MB0327_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hi all,

(this is my first Qemu patch submission, please let me know if my formattin=
g/content needs to be fixed).
We have a need for increased firmware size, currently we are building Qemu =
with the following change to test our Uefi Firmware and it works well for u=
s. Hope that this change can be made to open source. Thank you.
-------
Increase allowed system firmware size to 16M per comment suggesting up to 1=
8M is permissible.

 Signed-off-by: Erich McMillan <erich.mcmillan@hp.com>

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355fbd19f=
fdcdb71ea75ca 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -46,7 +46,7 @@
  * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB=
 in
  * size.
  */
-#define FLASH_SIZE_LIMIT (8 * MiB)
+#define FLASH_SIZE_LIMIT (16 * MiB)

 #define FLASH_SECTOR_SIZE 4096
-------


--_000_CS1PR8401MB0327EF9D532330BA44257AFCF3240CS1PR8401MB0327_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi all,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
(this is my first Qemu patch submission, please let me know if my formattin=
g/content needs to be fixed).<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
We have a need for increased firmware size, currently we are building Qemu =
with the following change to test our Uefi Firmware and it works well for u=
s. Hope that this change can be made to open source. Thank you.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
-------<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Increase allowed system firmware size to 16M per comment suggesting up to 1=
8M is permissible.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
&nbsp;Signed-off-by: Erich McMillan &lt;erich.mcmillan@hp.com&gt;<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
<div>index b8d8ef59eb17c6ace8194fc69c3d27809becfbc0..f6f7cd744d0690cee0355f=
bd19ffdcdb71ea75ca 100644</div>
<div>--- a/hw/i386/pc_sysfw.c</div>
<div>+++ b/hw/i386/pc_sysfw.c</div>
<div>@@ -46,7 +46,7 @@</div>
<div>&nbsp; * only 18MB-4KB below 4G. For now, restrict the cumulative mapp=
ing to 8MB in</div>
<div>&nbsp; * size.</div>
<div>&nbsp; */</div>
<div>-#define FLASH_SIZE_LIMIT (8 * MiB)</div>
<div>+#define FLASH_SIZE_LIMIT (16 * MiB)</div>
<div>&nbsp;</div>
<div>&nbsp;#define FLASH_SECTOR_SIZE 4096</div>
<div>-------<br>
</div>
&nbsp;<br>
</div>
</body>
</html>

--_000_CS1PR8401MB0327EF9D532330BA44257AFCF3240CS1PR8401MB0327_--


