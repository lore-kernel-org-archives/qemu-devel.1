Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F18C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:23:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C12AE20757
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hp.com header.i=@hp.com header.b="df3jjyuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C12AE20757
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxoO-00037G-MZ
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kMxmy-0002cL-8p
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:22:16 -0400
Received: from us-smtp-delivery-162.mimecast.com ([216.205.24.162]:33200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kMxmn-00081o-S4
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:22:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1601317322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PKB6b9wxcRgU8jOt3OHlukGzllJi8tu+ElDhye69qug=;
 b=df3jjyuytmt9z4UQzNTqlVi9UnFpnKGv8lcKV6KTjiw5zeImSerT4QsVgdLRu3mjzTitQI
 P1rp2C8i5D18YYi0diDA8JJpq+vTvXJJJJnlh1ytw8vj0a12E14wxI9q3hsRCLkp6yqTl8
 Ou6+jSj1E6e5XgA7F2IM2urBvyRdYcQ=
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-UriaGBnbPrG6MG4fbsq8iA-1; Mon, 28 Sep 2020 14:22:00 -0400
X-MC-Unique: UriaGBnbPrG6MG4fbsq8iA-1
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::9) by CS1PR8401MB0806.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 18:21:58 +0000
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c]) by CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c%12]) with mapi id 15.20.3412.029; Mon, 28 Sep
 2020 18:21:58 +0000
To: Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dgilbert@redhat.com" <dgilbert@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "kraxel@redhat.com"
 <kraxel@redhat.com>
Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine
 configuration option
Thread-Topic: [PATCH v5] hw/i386/pc: add max combined fw size as machine
 configuration option
Thread-Index: AQHWku0OoWna5JUJm06gLz/BlWUPe6l47SIAgACq8vCABMeBgIAAAnQy
Date: Mon, 28 Sep 2020 18:21:58 +0000
Message-ID: <CS1PR8401MB032797F2CC0B524DB60A1087F3350@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200925033623.3968-1-erich.mcmillan@hp.com>
 <8818a3ae-cab6-5de4-adbd-19198d26b6e7@redhat.com>
 <CS1PR8401MB0327982D7F9414360E440656F3360@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>,
 <a5050849-2b66-3d90-3e89-70be07a53c0d@redhat.com>
In-Reply-To: <a5050849-2b66-3d90-3e89-70be07a53c0d@redhat.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.199.17.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ed0ebf-9bb8-4bd6-7c4b-08d863db632d
x-ms-traffictypediagnostic: CS1PR8401MB0806:
x-microsoft-antispam-prvs: <CS1PR8401MB08065FC3E464B7CE5256A4AEF3350@CS1PR8401MB0806.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4502
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 3lJZqgFMkt2H/qahLbiqLHUvh1STzPCAw2ohavkA7bJLwEa7zr1iP0Ournc60NDfxPP/JcqH0lSHousn/9Kg/5AZeU3njOCRdkOX0mu+yltfb/bquWLVG12Fak4KiYIeTHk0FZX9VX+BQlHVZifMSnZBOn15EZsukKUKbSr4celE+nCeXY8rut6snOLi0BwPDROrpOqfsTrPAz/ZcxVeCEzbH2LdVWwlPq3VI6MD8JUEIWhlcaJLQpSTF1Qcw17RFbMc25sKzwRIcbP+5SW9KKjKBPOkP8ZpbQ85zLAmNN3WLX9GBVPLYkVS7rf0BcQbFrVVFBnABM06RYXwyYFEn5pSjN6aCoi753SYD87lZBmN+8N40qYFZOE3gbAr+OH4pfvyuBgCiIpB51EFPRTyKoSQx2cP43oWImIdUP+XistyTNCm9MvlHLOLW8ds+P9fCUuLNLKdTcvxomM95LPDAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(66446008)(5660300002)(66556008)(66476007)(86362001)(71200400001)(8936002)(64756008)(8676002)(33656002)(166002)(76116006)(83380400001)(2906002)(966005)(26005)(6506007)(53546011)(186003)(54906003)(110136005)(7696005)(316002)(66946007)(52536014)(478600001)(19627405001)(55016002)(9686003)(4326008);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata: 5aTuQkafEgIdREehFg21aYfQguCOO9tYqf4YCMk7HVso60Od/7e9rnKeXfcSFgMBcWnjgZsYB8oudMRm20c5Rkqd2hn1IAUFlz6RParCC7zxoAS5W5zY9RhqaCIu3slC/LWpe/Dzka0JiFa/Md2kEaAM9pxh1EFuEusWEYsvLSRrOU8mv59ujpzZu31vEhE3nrIo4tuzxq9AeT6pm/IwuFuumV9cVVFRAU40TPk5X4k2gZdxvJeosprzXYLRprF/NSHlueagloVrn+Es8yHBHg7pU4AzUf6M+WSZdhKLeNlLOhq0ZputA3HWJn8rWye78GKjW0U4I0oAbSkCRI8+3ZLIdldIhUROQ1OwxuTRpj3uxeMBC1WooB+UPLjFo8Ptd7D3kab8/8IyrPCptuKhXWHEV7lBXzUNwKUoIcsw51aLIHQppk8fhICdyKjTZNNIif9pi9ZHBqhO794dpD8HlqKA8lpmHp+1M+Eo+QR0YBC1RXARcgVtYSE3XkcPypftUd3bh4K135Pxyiv3sFYJygmYozCIdJoXra2s2rY6W9tMgTayQu3LekBFgFUffzSo0TUcVD0sc6Zin03NX6aK212l29uhPILTmQ+d2IBQjJcsHzqDieQhNXyXdm1xuSRi3obJ4jsy8NmtWc19Q+z9mw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ed0ebf-9bb8-4bd6-7c4b-08d863db632d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 18:21:58.4628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YNb+F+1Wsvi/gqA9i93XD+iP770jxJfACPC0JF7vfZ7d9qR/g3NvlTyrMmgDzbpmMrID4MUfKc9QgY2i5YqRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0806
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_CS1PR8401MB032797F2CC0B524DB60A1087F3350CS1PR8401MB0327_"
Received-SPF: pass client-ip=216.205.24.162;
 envelope-from=erich.mcmillan@hp.com; helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 14:22:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.614,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to: "McMillan, Erich" <erich.mcmillan@hp.com>
From: "McMillan, Erich" via <qemu-devel@nongnu.org>

--_000_CS1PR8401MB032797F2CC0B524DB60A1087F3350CS1PR8401MB0327_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Laszlo,

Thanks double checking the archives. I did end up finding them the next day=
.

With regards to PATCH v6, I missed removing the squash commit message, so t=
hat will need to be fixed in v7 apologies for that.

-Erich
________________________________
From: Laszlo Ersek <lersek@redhat.com>
Sent: Monday, September 28, 2020 1:10 PM
To: McMillan, Erich <erich.mcmillan@hp.com>; qemu-devel@nongnu.org <qemu-de=
vel@nongnu.org>
Cc: dgilbert@redhat.com <dgilbert@redhat.com>; mst@redhat.com <mst@redhat.c=
om>; marcel.apfelbaum@gmail.com <marcel.apfelbaum@gmail.com>; imammedo@redh=
at.com <imammedo@redhat.com>; kraxel@redhat.com <kraxel@redhat.com>
Subject: Re: [PATCH v5] hw/i386/pc: add max combined fw size as machine con=
figuration option

On 09/25/20 19:14, McMillan, Erich wrote:

> On an unrelated note, it seems that my patches are no longer appearing in=
 https://lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html<https:=
//lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html> is this beca=
use I need to cc qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> rather=
 than =96to?

Cc: and To: are equally fine. I can see both your v5 and v6 postings there:

https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09212.html<http=
s://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09212.html>
https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09577.html<http=
s://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09577.html>

The qemu-devel list is very busy, plus <https://lists.nongnu.org/<https://l=
ists.nongnu.org>> hosts
a very large number of other lists -- so updates to the WebUI are done
in batches (I think once every 30 minutes, but I could be out of date on
that). A fresh posting almost never shows up immediately on the WebUI.
(I believe it may be delivered to subscribers via actual email more
quickly.)

Thanks
Laszlo

--_000_CS1PR8401MB032797F2CC0B524DB60A1087F3350CS1PR8401MB0327_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Laszlo,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Thanks double checking the archives. I did end up finding them the next day=
.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
With regards to PATCH v6, I missed removing the squash commit message, so t=
hat will need to be fixed in v7 apologies for that.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
-Erich<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Laszlo Ersek &lt;lers=
ek@redhat.com&gt;<br>
<b>Sent:</b> Monday, September 28, 2020 1:10 PM<br>
<b>To:</b> McMillan, Erich &lt;erich.mcmillan@hp.com&gt;; qemu-devel@nongnu=
.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> dgilbert@redhat.com &lt;dgilbert@redhat.com&gt;; mst@redhat.com =
&lt;mst@redhat.com&gt;; marcel.apfelbaum@gmail.com &lt;marcel.apfelbaum@gma=
il.com&gt;; imammedo@redhat.com &lt;imammedo@redhat.com&gt;; kraxel@redhat.=
com &lt;kraxel@redhat.com&gt;<br>
<b>Subject:</b> Re: [PATCH v5] hw/i386/pc: add max combined fw size as mach=
ine configuration option</font>
<div>&nbsp;</div>
</div>
<div>On 09/25/20 19:14, McMillan, Erich wrote:<br>
<br>
&gt; On an unrelated note, it seems that my patches are no longer appearing=
 in <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-09/ind=
ex.html">
https://lists.nongnu.org/archive/html/qemu-devel/2020-09/index.html</a> is =
this because I need to cc qemu-devel@nongnu.org&lt;mailto:qemu-devel@nongnu=
.org&gt; rather than =96to?<br>
<br>
Cc: and To: are equally fine. I can see both your v5 and v6 postings there:=
<br>
<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg0921=
2.html">https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09212.h=
tml</a><br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg0957=
7.html">https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg09577.h=
tml</a><br>
<br>
The qemu-devel list is very busy, plus &lt;<a href=3D"https://lists.nongnu.=
org">https://lists.nongnu.org/</a>&gt; hosts<br>
a very large number of other lists -- so updates to the WebUI are done<br>
in batches (I think once every 30 minutes, but I could be out of date on<br=
>
that). A fresh posting almost never shows up immediately on the WebUI.<br>
(I believe it may be delivered to subscribers via actual email more<br>
quickly.)<br>
<br>
Thanks<br>
Laszlo<br>
</div>
</body>
</html>

--_000_CS1PR8401MB032797F2CC0B524DB60A1087F3350CS1PR8401MB0327_--


