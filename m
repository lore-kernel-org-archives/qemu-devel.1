Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SHORT_URL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57875C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F3C21D79
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 17:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hp.com header.i=@hp.com header.b="MjBlJXKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F3C21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGnEe-0002w9-HT
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 13:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGnDM-0002Gn-Sp
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:52:00 -0400
Received: from us-smtp-delivery-162.mimecast.com ([63.128.21.162]:41425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <erich.mcmillan@hp.com>)
 id 1kGnDK-0003vk-FY
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 13:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com;
 s=mimecast20180716; t=1599846716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qY4D8TRgPilKBvXRnhutWTgcnnejT8c8k23WO5hdEb8=;
 b=MjBlJXKddpCgt+B8CBdtF1aqYBjnXUy6q4LOBhNEjNLoR8cmfd7Qurg7WbZvDjIOC84RMe
 64T2p58quDcTSoDDd1/0Wxse63d7z6zvCxVTutZdZmssDf2lNg/MNlC78LzG6Zvu7WgsPV
 5bOM5YS6y43yL4O2VkAhYSqEWNKmSv8=
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-mp42v6xYOimTC9EcvG_yLA-1; Fri, 11 Sep 2020 13:51:54 -0400
X-MC-Unique: mp42v6xYOimTC9EcvG_yLA-1
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7507::9) by CS1PR8401MB0917.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 17:51:52 +0000
Received: from CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c]) by CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::40df:1118:3bef:736c%12]) with mapi id 15.20.3370.017; Fri, 11 Sep
 2020 17:51:52 +0000
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laszlo Ersek
 <lersek@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Markus Armbruster
 <armbru@redhat.com>, =?Windows-1252?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Thread-Topic: PATCH: Increase System Firmware Max Size
Thread-Index: AQHWh9wbvH3PA15ju0WtYVYwRPIQ7qljEg0AgAAK3ACAAGnfAIAAA6AAgAAOfICAAAb6gIAACG8AgAABrQCAAA6ZUA==
Date: Fri, 11 Sep 2020 17:51:52 +0000
Message-ID: <CS1PR8401MB0327EE59259BF8E4059FA30CF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <20c5210f-8199-a9e7-9297-0bea06c4d9ae@redhat.com>
 <20200911083408.GA3310@work-vm>
 <ae2d820e-78c6-da92-2fa6-73c1a7d10333@redhat.com>
 <20200911150602.GH3310@work-vm>
 <8e2d0bf7-a206-124c-15b0-0f0071ef5a11@redhat.com>
 <20200911162251.GA3311@work-vm>
 <171b8941-abb6-bb21-4080-c5c3eb0e59ae@redhat.com>,
 <20200911165902.GB3311@work-vm>
In-Reply-To: <20200911165902.GB3311@work-vm>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2600:1700:4c60:2770:689d:91ac:2781:8bf0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94605b29-be22-4579-79e6-08d8567b5dae
x-ms-traffictypediagnostic: CS1PR8401MB0917:
x-microsoft-antispam-prvs: <CS1PR8401MB0917856DD9A4514453BDEEB0F3240@CS1PR8401MB0917.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BkxFHSgpD/MaJfx/z5byMbDN/41lIJa5XJ0/iZ23yS/aXttXQdvkm4RI7H9JlAiftcb2aYFPU+45V04znBY+3kbLZQ/dUhCFop5Vd92lnbHik9+PlXImnHb46WWIc+RWToCMcEUKHJAsLH1sElSyaJcbRyWhKPwUUHkAyvmF3rCkvtleSzGHz3q0QcXyCjAx2MlwDlJXCpXXttAZLAXt3nZOxjSXO6ju7jCVWRDz+FIHR27I1xVsWD8T4juLsvNAt7gcEvhTPMiLSuLGhmCxmRvmYwOGjCOsn32jCfi7gs+t8Qt4IECxsiGr6uBzXdgtbbyAGeLDG9wpUVvJSX4KxiIRARrqwcdUL6G7cNyKK/h8lveNXXirMM18jA5WLCkkacKhL8y2iGjBeWdXX2WK0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(136003)(396003)(366004)(39860400002)(346002)(376002)(7696005)(76116006)(66476007)(83380400001)(66556008)(8936002)(166002)(91956017)(66946007)(5660300002)(71200400001)(33656002)(186003)(316002)(8676002)(45080400002)(2906002)(86362001)(53546011)(64756008)(9686003)(478600001)(55016002)(4326008)(52536014)(110136005)(54906003)(66446008)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: rVBqapSvyBgi7zXvpY0Hie2VTsQLn0g35HZXKL789XrQx1iSNzIXMOBsJ/e817ZNzWyfelCCWT56ICjSQvbx0FFGiu6iADJ3ZzWBOvbFVh1p7uVF/LwkEHBhazEexjaLZguhvPQHlF/ZZCVov1LItOuvDY42oChBbOeMi6n8lD8TomYux4MsjrkYlDkkBLuYSAKJmJz+7txqR8gnZ8m3Qty2+bI5+tOYgYhaDbCp2UYc+E5lVG1i/xgT6XQTUfYDUVYXw7nbzfAzjmI7imTAln3e1fem/KoHVhVxMwE/eMCNEjA/4z5tSU0qeDH6YJxEHmbPUhswFz9qPy5NLulkMKPnq0Lps2HRzcbkkYYT5y/lrRsHaXewlyBouY6qXjf7Uz1S0AgMdD5yQsvEB2ThqfZPQlfKoL/8HB+XISysSF9rQjG4e5fq1mi+5jWB1lib9cKwvgu6AQ9GuiEoWJ5g3Q8NdA97zzhchret4S6mBfBZh85FbLlccBupv6LkL0f/gtJFNP1rtHd194i9Qco4Hb0eMqJlP9YfLBCVhmuv9b7zl7u8OnaOOPqhjZAw7hFUGIqz3Koz+jwqrV3gvkryCDUAkdN85pmjWScPijrPY9JdtSXR7cgE0G3+hg91qSiChkbby9e/Ak/5odxPj6BopuEdoGAuh3HwsphmLNs+hi1NkUR49kn/6ZmCGcaNgh0ZFgLeQD3HpLgz8qiel8Gh+g==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 94605b29-be22-4579-79e6-08d8567b5dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 17:51:52.3907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ca7981a2-785a-463d-b82a-3db87dfc3ce6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYNLbhhGmFTxpKF5YG6wkW79N2n47nYekqMSYU7d5ZvHAafM8dfbASbVzaVRq6QT6sIc8rBvOUOILx9vnDwQ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0917
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA62A171 smtp.mailfrom=erich.mcmillan@hp.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: hp.com
Content-Type: multipart/alternative;
 boundary="_000_CS1PR8401MB0327EE59259BF8E4059FA30CF3240CS1PR8401MB0327_"
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.162; envelope-from=erich.mcmillan@hp.com;
 helo=us-smtp-delivery-162.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 13:51:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SHORT_URL=1.123, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_CS1PR8401MB0327EE59259BF8E4059FA30CF3240CS1PR8401MB0327_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

I=92d be happy to rewrite as a property.

Erich

Get Outlook for iOS<https://aka.ms/o0ukef>
________________________________
From: Dr. David Alan Gilbert <dgilbert@redhat.com>
Sent: Friday, September 11, 2020 11:59 AM
To: Laszlo Ersek
Cc: McMillan, Erich; qemu-devel@nongnu.org; mst@redhat.com; marcel.apfelbau=
m@gmail.com; qemu-trivial@nongnu.org; Markus Armbruster; Philippe Mathieu-D=
aud=E9
Subject: Re: PATCH: Increase System Firmware Max Size

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 09/11/20 18:22, Dr. David Alan Gilbert wrote:
>
> > We have lots of complex hideous changes that I'm never going to use but
> > seem reasonable;  this is a tiny change that seems perfectly reasonable
> > both for open and closed firmware.
> > I realise herding OVMF developers is tricky, but that's not a reason
> > to nack a reasonable almost trivial change in QEMU.
>
> OK.

I'm OK with pushing it towards being a property though; that's much
prettier; so:

Erich: Can you redo this as a property as suggested in another part
of this thread, making it default to the current value?

Dave

> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


--_000_CS1PR8401MB0327EE59259BF8E4059FA30CF3240CS1PR8401MB0327_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body>
<div dir=3D"ltr">
<div></div>
<div>
<div>I=92d be happy to rewrite as a property.</div>
<div dir=3D"ltr"><br>
</div>
<div dir=3D"ltr">Erich</div>
<div><br>
</div>
<div class=3D"ms-outlook-ios-signature" id=3D"ms-outlook-mobile-signature">=
Get <a href=3D"https://aka.ms/o0ukef">
Outlook for iOS</a></div>
</div>
<div id=3D"id-133b9f5e-0287-4fda-953a-8acedae8eacf" class=3D"ms-outlook-mob=
ile-reference-message">
<hr style=3D"display: inline-block; width: 98%; font-family: -webkit-standa=
rd; font-size: 12.72pt; color: rgb(0, 0, 0);" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif"><b=
>From:</b> Dr. David Alan Gilbert &lt;dgilbert@redhat.com&gt;<br>
<b>Sent:</b> Friday, September 11, 2020 11:59 AM<br>
<b>To:</b> Laszlo Ersek<br>
<b>Cc:</b> McMillan, Erich; qemu-devel@nongnu.org; mst@redhat.com; marcel.a=
pfelbaum@gmail.com; qemu-trivial@nongnu.org; Markus Armbruster; Philippe Ma=
thieu-Daud=E9<br>
<b>Subject:</b> Re: PATCH: Increase System Firmware Max Size
<div>&nbsp;</div>
</font></div>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style><font size=3D"=
2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">* Laszlo Ersek (lersek@redhat.com) wrote:<br>
&gt; On 09/11/20 18:22, Dr. David Alan Gilbert wrote:<br>
&gt; <br>
&gt; &gt; We have lots of complex hideous changes that I'm never going to u=
se but<br>
&gt; &gt; seem reasonable;&nbsp; this is a tiny change that seems perfectly=
 reasonable<br>
&gt; &gt; both for open and closed firmware.<br>
&gt; &gt; I realise herding OVMF developers is tricky, but that's not a rea=
son<br>
&gt; &gt; to nack a reasonable almost trivial change in QEMU.<br>
&gt; <br>
&gt; OK.<br>
<br>
I'm OK with pushing it towards being a property though; that's much<br>
prettier; so:<br>
<br>
Erich: Can you redo this as a property as suggested in another part<br>
of this thread, making it default to the current value?<br>
<br>
Dave<br>
<br>
&gt; Laszlo<br>
-- <br>
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CS1PR8401MB0327EE59259BF8E4059FA30CF3240CS1PR8401MB0327_--


