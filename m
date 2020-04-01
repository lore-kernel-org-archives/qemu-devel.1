Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA3FC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A6420714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sLmq76o1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A6420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJeIK-0007Z6-RM
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 10:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1jJeHg-00078c-29
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1jJeHd-0003em-O2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:23:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:20609)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1jJeHd-0003XW-Bs
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 10:23:57 -0400
IronPort-SDR: gT/WuHrS4uPnXgEdP/kPobojNEHLh8lU8EG1MuGBuuMf0flTwS2X3GKUcn3axdIyWGSHYQ5hF8
 zIh9xsF2qDnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 07:23:53 -0700
IronPort-SDR: yXm7RAyKwy3BK16CUPmOGRSbLjOs8dUzX8G36NEdjy4tkJYti5GYVAy0NuWt1tSIvp+rRgKmYt
 jZIuMGxJCgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; 
 d="scan'208,217";a="242244954"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2020 07:23:52 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 07:23:52 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 07:23:51 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 07:23:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 1 Apr 2020 07:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzoMaGNciTlhXMqMtjLEwXF0Mxr7Aknwh/GgiWQbhZPjz0RB1mTRX1h9iSH0b8Ug8BM4d+tePTK/xyEV4Rysb35OGo7nsaEWhHUwM7mXJs3vMngUXlHGFDMUHuZxa8Ec+RoEBfzslIlfaEN0YyPI47wHOFggsGIIYQGomRaHTNPgY37M8ELTmrABSsTjNua6V1XpsWhcUYi8yaSb+YuCYUhdzIToN9X+6qulWwtgZFezaOzjWC/FjpUliOhmnb/jQm+7Mf5W55Jd6PNJBsz7QEEZlHXYjKbgmU4TWKZgvteY5plVxOa0c5PVzsVDL4XOB6TK8cSH03w60tX9ppMbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQPD4oGhmQvUF4aBXTTWS5puB2CCaG4T2+bV4uUm6cI=;
 b=IRrsTNOgo1rwBdSWm/As+jjaRvmEXA8rOSTzvu4PVg422xTWvNH+fIeThBC9Y0T+ZN0/dzY9i8GLt93sTCe8NWpDZnbkDRH6I8XyEXiV+h0yrz5920DSm6mZzIQIFr9XwdHkTcXWZfymWdOfuoA+sZB7xOTDbxZjj4aFwooUz2qSYx7H3cl6pExYt4aiES3jDcAoxFNxCDgmpSfErDYCNYGb+HyHk+Yx6mO9b/D0OdHkawVd4oscEfnfIIllXgw5u+iGXqvhbhHZD5H+L7O5xeeF7bg/gzXaCV6ahS5yg1xZTrXsTp07fiPERMA05jypyAxw6D2Ivk/ww2+0BO97GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQPD4oGhmQvUF4aBXTTWS5puB2CCaG4T2+bV4uUm6cI=;
 b=sLmq76o1o9fPK2nYDjg7Od2gghLglLPdlOQZ+0SR8XvyfTYb9JHHaJAYbncDDzUeUwYvqoOqQLcDHO9VUHJjEPxHe7OqXExwWY4Ecoi2gEvq0HWoMXiqUrzqL9qD1aiS4CvBo4NKQ6Kdu11hrAlysKpFCidUH1rHOnVnkfO0Loc=
Received: from BY5PR11MB3960.namprd11.prod.outlook.com (2603:10b6:a03:185::30)
 by BY5PR11MB4165.namprd11.prod.outlook.com (2603:10b6:a03:18c::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Wed, 1 Apr
 2020 14:23:45 +0000
Received: from BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7]) by BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7%5]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 14:23:44 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Topic: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Index: AQHWB3m8r1FB2qyA5Umhq8e1klXMS6hi5RMAgAAGPUWAAO2sgIAAdZ2T
Date: Wed, 1 Apr 2020 14:23:44 +0000
Message-ID: <BY5PR11MB39607C77082407729CFEBA399AC90@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
 <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>,
 <877dyz1y9g.fsf@vitty.brq.redhat.com>
In-Reply-To: <877dyz1y9g.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94f63476-3a84-400e-24df-08d7d6484928
x-ms-traffictypediagnostic: BY5PR11MB4165:
x-microsoft-antispam-prvs: <BY5PR11MB4165504B763B14B1B16FA2FD9AC90@BY5PR11MB4165.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:569;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3960.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(136003)(6506007)(478600001)(26005)(4744005)(186003)(2906002)(76116006)(316002)(4326008)(64756008)(81166006)(66556008)(66476007)(53546011)(52536014)(8936002)(9686003)(66446008)(8676002)(81156014)(55016002)(6916009)(33656002)(86362001)(54906003)(71200400001)(7696005)(66946007)(5660300002)(19627405001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y85ps6BmqrVo2hXMXUq/4bI8kkfjMffrbkeN+NrkPMBt7IHSG8rR/ZL2Q8VdZmWr0k+OF313iqSR+Q/riWUJWitm6RJhe9qVIfekJBNUFCxdm18hBFs5vzCIj8BeHrCK9yxMuVzTVEGUvMW8t+dHWi06kYcyok7hP3AnHZxStsREM/mNaPUZJJMX5F//4NzgfPbCvXtXefgxQUCB8TD8WDLrYwcJlob8y3RsuXiYp/BX+RahW0NuwPWENx5insJTYiefF1LDcNo2vFwoxVEsxgucWSqiahbibbxyrvofdo/mIyfM3v8zTr9TE4yyjpTqxl9aUjrNOz43OdtJoDWPzmV5M7zSIGzPHeVYuzUdR/+A+Gvzmk1zna3Pw9CC7vvt7RIZMHNP4W/Lr+KpfHrl5/QEXKR2SiYzfu+QGr4ODfuUWgXPQaenlUvNGh0SnpJb
x-ms-exchange-antispam-messagedata: J2U5I2vriSw0+/jnR838d4v1PSqAN+U14ZDAOm8xkou0ESEF5/+RrYa50UDPhvu0aURf5HdOVPW0hGgQ/NdRX9weaN1SixB8euRhd6Sy/cZd7d7vuTwmhrGVYhdsGtMrgyrOvncMoDHDMivYDaWV/w==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR11MB39607C77082407729CFEBA399AC90BY5PR11MB3960namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f63476-3a84-400e-24df-08d7d6484928
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 14:23:44.7882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2wrWUw25QoEnBvgLlw3Y4z7jWG351If2S2r/uf7lBSTZvtvRycUIBqTcFdG82dFTf0RPMYduc4SVO4kIYN0u8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4165
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR11MB39607C77082407729CFEBA399AC90BY5PR11MB3960namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Does you kernel have 95c5c7c77c ("KVM: nVMX: list VMX MSRs in
> KVM_GET_MSR_INDEX_LIST")?

I was using linux 5.0.0, now I have 5.3.0 and it's working, thanks for fixi=
ng this

________________________________
From: Vitaly Kuznetsov <vkuznets@redhat.com>
Sent: Wednesday, April 1, 2020 1:05 AM
To: Montes, Julio <julio.montes@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>; Eduardo Habkost <ehabkost@redhat=
.com>; Dr . David Alan Gilbert <dgilbert@redhat.com>; Richard Henderson <rt=
h@twiddle.net>; Paolo Bonzini <pbonzini@redhat.com>; qemu-devel@nongnu.org =
<qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary exec=
ution controls

"Montes, Julio" <julio.montes@intel.com> writes:

> Hi Vitaly
>
> thanks for raising this, unfortunately this patch didn't work for me, I s=
till get the same error:
>
>

Does you kernel have 95c5c7c77c ("KVM: nVMX: list VMX MSRs in
KVM_GET_MSR_INDEX_LIST")?

--
Vitaly

--_000_BY5PR11MB39607C77082407729CFEBA399AC90BY5PR11MB3960namp_
Content-Type: text/html; charset="iso-8859-1"
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
&gt; Does you kernel have 95c5c7c77c (&quot;KVM: nVMX: list VMX MSRs in<br>
&gt; KVM_GET_MSR_INDEX_LIST&quot;)?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I was using linux 5.0.0, now I have 5.3.0 and it's working, thanks for fixi=
ng this<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" data=
-ogsc=3D"" face=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Vita=
ly Kuznetsov &lt;vkuznets@redhat.com&gt;<br>
<b>Sent:</b> Wednesday, April 1, 2020 1:05 AM<br>
<b>To:</b> Montes, Julio &lt;julio.montes@intel.com&gt;<br>
<b>Cc:</b> Marcelo Tosatti &lt;mtosatti@redhat.com&gt;; Eduardo Habkost &lt=
;ehabkost@redhat.com&gt;; Dr . David Alan Gilbert &lt;dgilbert@redhat.com&g=
t;; Richard Henderson &lt;rth@twiddle.net&gt;; Paolo Bonzini &lt;pbonzini@r=
edhat.com&gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Subject:</b> Re: [PATCH] target/i386: do not set unsupported VMX seconda=
ry execution controls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&quot;Montes, Julio&quot; &lt;julio.montes@intel.c=
om&gt; writes:<br>
<br>
&gt; Hi Vitaly<br>
&gt;<br>
&gt; thanks for raising this, unfortunately this patch didn't work for me, =
I still get the same error:<br>
&gt;<br>
&gt;<br>
<br>
Does you kernel have 95c5c7c77c (&quot;KVM: nVMX: list VMX MSRs in<br>
KVM_GET_MSR_INDEX_LIST&quot;)?<br>
<br>
-- <br>
Vitaly<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR11MB39607C77082407729CFEBA399AC90BY5PR11MB3960namp_--

