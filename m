Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FE5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC2AC2076A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nGWOvkea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC2AC2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtVDO-0007cl-0Q
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtVCj-0006yV-US
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:59:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:52115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentong.wu@intel.com>)
 id 1jtVCg-00070h-6l
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:59:05 -0400
IronPort-SDR: JvKp8o+Gndq1x704LAzH+O5dUAWqhWX1bRXuAi0pngACEqvstfPIXaFV6JXH/nuamUouAqiU9N
 20hq4tCN3idA==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="147053175"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
 d="scan'208,217";a="147053175"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 04:58:58 -0700
IronPort-SDR: JpK/bsrBxu598Dl/aQ1vdtYijPuRI4ADilXSq3T4bNfDzxMabZvjvnJJSTUvUXpxrVKQfVF8gs
 JwRpN6BGnbjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
 d="scan'208,217";a="483771930"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
 by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2020 04:58:58 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 04:58:57 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 04:58:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jul 2020 04:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkGDYYjJpuGy5yd2oWHyhCLVYFGuTV+sZUvLiqIKN9cxz2vWTXy+vNTQaKM9KLGCHxk+3NWnrSpDDfJhBrtNVrvMevBwiGPuXKC08+QM5Ac7Tfsww8+SJ1kI8ZNd5mzRUMZDv9Kx2YP4M8zGZx40hjH9ZKQq5O0nMxwxztgTZ8QLawqB1HryQuaH4OBr9XfKvdDuCbySGW4XPijelYIh0Wt76/OGwYlTejHeZqvyUpKefvjYtBbiy7jpNI1POhf6CSo+mUr+sH28SNH5ay4ge6dbxXjhicz9100OcLB/6Hv6Pz6jE+aZoP8IzgbXDKSJc2oznogLigXfd0rfb2UK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st28xLMaEsVBsZB0BQOMCT9Daf94p6/t/sUhqZ91Gb4=;
 b=BzEx59seEcB4q2QzCZDPTib9rxB+ZQwZ3IluP9CyV+A6oFHxcDUIinAjHZK8TA7QjH39x2nmjqWCD9TB+zlg8zWplbIdZM8UjBAbeaMKEkGvy6eHBMTCwqsQztVbPttFQmE3XKy3qNmcUGLoHD+0kiEGRaimPYwIosAt92XhmFrK5BfulD+LztN5eA6vBC/62wXPPloM7GfM34BGx+uZQAsYeXbEZZz146NJxb2a1J+Je378hC3QQ/V8udT2FoTug/OlyMa128fPyGW/PkaWEj/jfwv+tYjYCVYfTk0n+1Ygttz8Zw/73nBO8ESHav5w+CQ0P7WM44uTkhdrd5Fz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=st28xLMaEsVBsZB0BQOMCT9Daf94p6/t/sUhqZ91Gb4=;
 b=nGWOvkead4pFnJrWMO4kMx4cKXELCQXlZ9VQVXL4f+/Oyq8jcunF7HMGbLMcpXpPhNaZoDS4YVHsqstfNMr4NukzuxosimbRD7552Qfw9O3qJzaTnCXNHkr+UyspbS5f97fFIydXKcTYp8eRZUWj721juqxLMmPPGZ86LtvsIoY=
Received: from DM5PR11MB1833.namprd11.prod.outlook.com (2603:10b6:3:110::12)
 by DM6PR11MB3611.namprd11.prod.outlook.com (2603:10b6:5:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 9 Jul
 2020 11:58:50 +0000
Received: from DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74]) by DM5PR11MB1833.namprd11.prod.outlook.com
 ([fe80::4ce3:6680:7257:7c74%6]) with mapi id 15.20.3174.022; Thu, 9 Jul 2020
 11:58:50 +0000
From: "Wu, Wentong" <wentong.wu@intel.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Topic: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
Thread-Index: AdZV57YyCmjMa3CJTmue4m0xMIO+TA==
Date: Thu, 9 Jul 2020 11:58:50 +0000
Message-ID: <DM5PR11MB183353FCF7BB294AAB2B99CF8D640@DM5PR11MB1833.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 398f7475-44ac-413d-3830-08d823ff71fe
x-ms-traffictypediagnostic: DM6PR11MB3611:
x-microsoft-antispam-prvs: <DM6PR11MB3611DA4995C98450CD4618BA8D640@DM6PR11MB3611.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yC56OvoXxnbJYmVB3ba6rfu6HPAVTyHqDVN3E6h0MGSTIAuPLpVLQkt0ooe8zQHHtXadlvntGzvoDanO/HsA6UwNoYn2Ak1I4EV4DE/ayHSHuYtLey9rfkC00JBQpGQZFisIvZK1BY/Gik+bWgGaSQYCanYl7HXE6akoAzeW4om209h8uRKeuN/jwYM/b17jiqly61yc3bhY5/Ahl82EEjYKBxfs0jjzEGcix1g9ISQoToNWffYseCvRKEIjVw4CLA4mOBTKx2ljjtjKTzCDMrhu3GMMESvuiD2ugj+6AAtuVn+v1tXKztepqJLUfhvYy9So6KynW+xXePXDUdsUA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1833.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8936002)(8676002)(5660300002)(9686003)(71200400001)(66446008)(33656002)(64756008)(66556008)(66946007)(316002)(76116006)(66476007)(55016002)(86362001)(4326008)(6916009)(478600001)(26005)(52536014)(83380400001)(6506007)(186003)(2906002)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: MQ0M6AWQV+sz0vY5WprSxm1CurTocvOp40QntwSpA0FNrNoJmbPxDqyX5X9P2VYNdXjlut2BfB4wRq/QxuiZ17yAiWdCnQPo6KQzvE2qbt076QHO0U7+Q48TGF5lCe1jNp9c0/CI5LGnqlZDppfQDDNTq+XjWKlE9ETWxBaLF4ihP/6J7fZjyvcbg50vO8eOSxV8rQoX+WznPvVMvex4CaKC9PFl1EV9eN4NEMnPE0M22iAovMCTnaB143n/ZuPP4wbwh7LU9Sib2U42wF1fnR7hp5RWbPliiNMZUet7OEI0fFbYQRq1jIWWIsZx5BRwGF19zkA+39bdk9hcw8hKhgejNlmMrOvVoceO4vmmKclWTg++m51KR4kwlmOUXeECKB4FSe6mMW2QVINYGr5/aqe/A4ySUoQsCyTRJgmE2iEhLW1xN/BVoHqUmAzRlFouCcCNRV+njNTEpqJiaYchYcusjcoPJGt66DRML1dIZuuT+CGFCAYQXprvJs38Py/P
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM5PR11MB183353FCF7BB294AAB2B99CF8D640DM5PR11MB1833namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1833.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398f7475-44ac-413d-3830-08d823ff71fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2020 11:58:50.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEVV+59cANrEARFXygU3R1idR+4+kIt0DlGHTURl0RDi5dSoTu7YKEc/nnknXid47jTMXvJJEZKFZpHEdH/IgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3611
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=wentong.wu@intel.com;
 helo=mga14.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 07:58:58
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM5PR11MB183353FCF7BB294AAB2B99CF8D640DM5PR11MB1833namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> >On Mon, 29 Jun 2020 at 09:17, Wentong Wu <wentong.wu@intel.com> wrote:
> >
> > wrctl instruction on nios2 target will cause checking cpu
> > interrupt but tcg_handle_interrupt() will call cpu_abort()
> > if the CPU gets an interrupt while it's not in 'can do IO'
> > state, so add gen_io_start around wrctl instruction. Also
> > at the same time, end the onging TB with DISAS_UPDATE.
> >
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > ---
> >  target/nios2/translate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/target/nios2/translate.c b/target/nios2/translate.c
> > index 83c10eb2..51347ada 100644
> > --- a/target/nios2/translate.c
> > +++ b/target/nios2/translate.c
> > @@ -32,6 +32,7 @@
> >  #include "exec/cpu_ldst.h"
> >  #include "exec/translator.h"
> >  #include "qemu/qemu-print.h"
> > +#include "exec/gen-icount.h"
> >
> >  /* is_jmp field values */
> >  #define DISAS_JUMP    DISAS_TARGET_0 /* only pc was modified dynamical=
ly */
> > @@ -518,7 +519,11 @@ static void wrctl(DisasContext *dc, uint32_t code,
> > uint32_t flags)
> >      /* If interrupts were enabled using WRCTL, trigger them. */
> >  #if !defined(CONFIG_USER_ONLY)
> >      if ((instr.imm5 + CR_BASE) =3D=3D CR_STATUS) {
> > +        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
> > +            gen_io_start();
> > +        }
> >          gen_helper_check_interrupts(dc->cpu_env);
> > +        dc->is_jmp =3D DISAS_UPDATE;
> >      }
> >  #endif
> >  }
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Hi Peter,

Will this be merged? If not, I would like to follow any suggestions, thanks

Thanks

>
> though as Richard notes ideally the interrupt handling code here should
> be rewritten because the check_interrupts helper is a very weird way
> to implement things.
>
> thanks
> -- PMM


--_000_DM5PR11MB183353FCF7BB294AAB2B99CF8D640DM5PR11MB1833namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
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
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;On Mon, 29 Jun 2020 at 09:17, Wentong=
 Wu &lt;wentong.wu@intel.com&gt; wrote:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> wrctl instruction on nios2 target=
 will cause checking cpu</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> interrupt but tcg_handle_interrup=
t() will call cpu_abort()</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> if the CPU gets an interrupt whil=
e it's not in 'can do IO'</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> state, so add gen_io_start around=
 wrctl instruction. Also</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> at the same time, end the onging =
TB with DISAS_UPDATE.</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> Signed-off-by: Wentong Wu &lt;wen=
tong.wu@intel.com&gt;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> ---</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; target/nios2/translate.c | =
5 &#43;&#43;&#43;&#43;&#43;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; 1 file changed, 5 insertion=
s(&#43;)</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> diff --git a/target/nios2/transla=
te.c b/target/nios2/translate.c</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> index 83c10eb2..51347ada 100644</=
i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> --- a/target/nios2/translate.c</i=
><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;&#43;&#43; b/target/nios2/tr=
anslate.c</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> @@ -32,6 &#43;32,7 @@</i><o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #include &quot;exec/cpu_lds=
t.h&quot;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #include &quot;exec/transla=
tor.h&quot;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #include &quot;qemu/qemu-pr=
int.h&quot;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;#include &quot;exec/gen-icou=
nt.h&quot;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; /* is_jmp field values */</=
i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #define DISAS_JUMP&nbsp;&nb=
sp;&nbsp; DISAS_TARGET_0 /* only pc was modified dynamically */</i><o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> @@ -518,7 &#43;519,11 @@ static v=
oid wrctl(DisasContext *dc, uint32_t code,
</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> uint32_t flags)</i><o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
If interrupts were enabled using WRCTL, trigger them. */</i><o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #if !defined(CONFIG_USER_ON=
LY)</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((instr.imm5 &#43; CR_BASE) =3D=3D CR_STATUS) {</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (tb_cflags(dc-&gt;tb) &amp; CF_USE_ICOUNT) {</i><o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gen_io_start();</i><o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; &nbsp;gen_helper_check_interrupts(dc-&gt;cpu_env);</i><o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i> &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dc-&gt;is_jmp =3D DISAS_UPDATE;</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</=
i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; #endif</i><o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; &gt;<i>&nbsp; }</i><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; Reviewed-by: Peter Maydell &lt;peter.mayd=
ell@linaro.org&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">Hi Peter,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">Will this be merged? If not, I would like to f=
ollow any suggestions, thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; though as Richard notes ideally the inter=
rupt handling code here should<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; be rewritten because the check_interrupts=
 helper is a very weird way<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; to implement things.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&gt; -- PMM<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM5PR11MB183353FCF7BB294AAB2B99CF8D640DM5PR11MB1833namp_--

