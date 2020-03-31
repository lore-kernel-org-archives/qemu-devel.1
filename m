Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C9A206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FsA8z/YS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C9A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKCM-0005uw-4c
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <julio.montes@intel.com>) id 1jJKBb-00059a-SS
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <julio.montes@intel.com>) id 1jJKBY-0004Yd-89
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:56:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:25459)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <julio.montes@intel.com>)
 id 1jJKBX-0004XG-M7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:56:20 -0400
IronPort-SDR: lxrpZHsxK/2amnSD/rxvk1NOSYZIWwkZUF/LPML2AHkron2gQPq/7ydZfGLFKlHtu8bRI1vIoU
 owSdygBI9yFg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 09:56:14 -0700
IronPort-SDR: Qtj6LU4FGBcIFaPp4P7feIgBVJ0Jqv2xB9VeBSRubDvk+he8IAJzdZuEK7ZTpE5w7X2ZsZFJ4b
 PpEtgvlM4XEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
 d="scan'208,217";a="267346782"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
 by orsmga002.jf.intel.com with ESMTP; 31 Mar 2020 09:56:14 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:56:13 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 31 Mar 2020 09:56:13 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 31 Mar 2020 09:56:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.58) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 31 Mar 2020 09:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuhL85Dce/vCe8o0+nhHYuiF7MjzlUK2maCUISDBVHWSLjD7vCIuzk3H61vdPMUpVqaQE/UP0IlcD7n3AN15os8OpNKJoHClEq4EXXmoIm8LEs08SfCPw3WAMq/GXTxdtS/fEBXjASsaBSYYQGL+U5ag3EajqmctFUt4RgLaj6SMdplhto5sjnb+ylY+fIojBKx+FdJVnErw8n7BfsFdHe9dpu26W1bmwaF8CeR7R/DW9PZariKdLKfRA99SU6oWx4kr38HAB3ykPIw7D1GrtBiHeAJHJmvElJm8xpLykt7N/TYMciVhF/eIxBZuywCFH9UYvz+I3FVprjC5V+8hEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYoErzjLHKEFTvHaJA1HWLZtE+G51qTSYXrXfBLbJkY=;
 b=SUhmpPEZuipWtl9UzDxSP/qaOlMIiJ4HVEl2jKbd6ioVe1+XB/yVJSk/otKtt9w9AUde3/4Tnn39Ob1q8RntKBsvHlzrIxxyqHvxGm0U22yZ2gbuih73NIH6okUcPFbxyJ9DjF80SsW4NVG7AQRfldHPz2Zp4ckLJO74Ji8aXasRxcciFy9kbbgdDcoA4zDQ4sp8WoO1erKIHdbYE0lrDpmVgAWOUGHDxptUpFsIx6LR9hVlziQbAiR4Vv7LQDRxnX8Wnma7KCLLOIP2402WsOq+2424bmR/M5cmyFK5TLnFwDJMgY1f2dMMcMhGOBdlFy798KwL1I/B96ml7ogAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYoErzjLHKEFTvHaJA1HWLZtE+G51qTSYXrXfBLbJkY=;
 b=FsA8z/YSQuhpTvAx6+QYZkMvtcyd7W1JFE5GKolsUxv7mHKvZXwrBbgPe6LIkm/q7jroInyirWnclTYdMZ0tXhEFc2k8bcWKYOVeCU+b2yngek6715oEEBK9a1+xn5drPSU63U+38UX4j1SiLw9ApGuQJCayI9P/49qdTVdJOUU=
Received: from BY5PR11MB3960.namprd11.prod.outlook.com (2603:10b6:a03:185::30)
 by BY5PR11MB3927.namprd11.prod.outlook.com (2603:10b6:a03:186::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 16:56:10 +0000
Received: from BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7]) by BY5PR11MB3960.namprd11.prod.outlook.com
 ([fe80::f80d:8a9b:8bf3:47a7%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 16:56:09 +0000
From: "Montes, Julio" <julio.montes@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Topic: [PATCH] target/i386: do not set unsupported VMX secondary
 execution controls
Thread-Index: AQHWB3m8r1FB2qyA5Umhq8e1klXMS6hi5RMAgAAGPUU=
Date: Tue, 31 Mar 2020 16:56:09 +0000
Message-ID: <BY5PR11MB396059E9E1FFE4B93EDE38E89AC80@BY5PR11MB3960.namprd11.prod.outlook.com>
References: <20200331162752.1209928-1-vkuznets@redhat.com>,
 <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
In-Reply-To: <f976c1b0-2f50-d9f6-0921-2fc8e25ddb80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=julio.montes@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 144c06cb-b294-4d00-59a2-08d7d594699b
x-ms-traffictypediagnostic: BY5PR11MB3927:
x-microsoft-antispam-prvs: <BY5PR11MB392730897C9E9B91E6F33F909AC80@BY5PR11MB3927.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:125;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3960.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(366004)(55016002)(2906002)(54906003)(9686003)(8676002)(110136005)(52536014)(81166006)(53546011)(81156014)(498600001)(6506007)(86362001)(4326008)(8936002)(7696005)(66476007)(19627405001)(26005)(71200400001)(76116006)(66946007)(64756008)(33656002)(66556008)(5660300002)(66446008)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gvKgIP4BMEiN0hlDGAPz7M2+76rFdcpbxrbP9eyZbursyYLxMIgQ1a4DTCTr4tBj/ZUOp+7oKIKb8j3XdKKLBE05alWrUnn8/kxOFVn3nxQSC3fevtQ0BUr56amxwBGVUTqlzhiwYT4JhF37MkUWK9E9NOvgbrR+/UaCUydKM08Q1NWU46C8wFpZgHGZtfnE5Ox2DiBglr9DaVGL0d0JkSmYTJl3kVr3qfW8LBC0ujTtf3jnZhBoIwrksKlf2Sil5odTO0Z/FpoFpTjBbFHOTZSAWYpr93UO+ToqMXN6vleMol5tId0epvW0TYBs7ENJmhPqDFptqad0yl1nAQac+UZFMRkHhHdZ4FKh+xUm+T6j8RpyJSD2qktt4Z1uAjfotRdE2FR3yckp6Y7a9FhJjJ+eB+Phu3j2DpJUqLZcNyhco6+1Ff5Fh7ZG7xzjOrzy
x-ms-exchange-antispam-messagedata: n79BNiU0BGSoJyKCNAp+uOeg6oPh//Ws+qAqV48adpzGeaVjd9NB1dzF1i4tI2Aiehc/Sq1Hu+2O15VSif3w5p5ZO/XzuwNM9NWj445KtNkSITcZAgMEA5RO6qwE8eV4aAlUNd6lBBgoFeYW5IPtFg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_BY5PR11MB396059E9E1FFE4B93EDE38E89AC80BY5PR11MB3960namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 144c06cb-b294-4d00-59a2-08d7d594699b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:56:09.7850 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVxfUWubcwyfO1P75nwfbPWDUfC/frI/8d1Fw/pLt+EsZ2elecyMw5FNliLfOw4LrMueCmn88OBS9eJPc0TNmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3927
X-OriginatorOrg: intel.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.115
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
Cc: Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_BY5PR11MB396059E9E1FFE4B93EDE38E89AC80BY5PR11MB3960namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Vitaly

thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:


my qemu command line:

________________________________
From: Qemu-devel <qemu-devel-bounces+julio.montes=3Dintel.com@nongnu.org> o=
n behalf of Paolo Bonzini <pbonzini@redhat.com>
Sent: Tuesday, March 31, 2020 10:32 AM
To: Vitaly Kuznetsov <vkuznets@redhat.com>; qemu-devel@nongnu.org <qemu-dev=
el@nongnu.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>; Eduardo Habkost <ehabkost@redhat=
.com>; Dr . David Alan Gilbert <dgilbert@redhat.com>; Richard Henderson <rt=
h@twiddle.net>
Subject: Re: [PATCH] target/i386: do not set unsupported VMX secondary exec=
ution controls

On 31/03/20 18:27, Vitaly Kuznetsov wrote:
> Commit 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for
> secondary execution controls") added a workaround for KVM pre-dating
> commit 6defc591846d ("KVM: nVMX: include conditional controls in /dev/kvm
> KVM_GET_MSRS") which wasn't setting certain available controls. The
> workaround uses generic CPUID feature bits to set missing VMX controls.
>
> It was found that in some cases it is possible to observe hosts which
> have certain CPUID features but lack the corresponding VMX control.
>
> In particular, it was reported that Azure VMs have RDSEED but lack
> VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature
> bit result in QEMU abort.
>
> Resolve the issue but not applying the workaround when we don't have
> to. As there is no good way to find out if KVM has the fix itself, use
> 95c5c7c77c ("KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST") instead
> as these [are supposed to] come together.
>
> Fixes: 048c95163b4 ("target/i386: work around KVM_GET_MSRS bug for second=
ary execution controls")
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Queued, thanks.

Paolo

> ---
>  target/i386/kvm.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 69eb43d796e6..4901c6dd747d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -106,6 +106,7 @@ static bool has_msr_arch_capabs;
>  static bool has_msr_core_capabs;
>  static bool has_msr_vmx_vmfunc;
>  static bool has_msr_ucode_rev;
> +static bool has_msr_vmx_procbased_ctls2;
>
>  static uint32_t has_architectural_pmu_version;
>  static uint32_t num_architectural_pmu_gp_counters;
> @@ -490,21 +491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(KVMStat=
e *s, uint32_t index)
>      value =3D msr_data.entries[0].data;
>      switch (index) {
>      case MSR_IA32_VMX_PROCBASED_CTLS2:
> -        /* KVM forgot to add these bits for some time, do this ourselves=
.  */
> -        if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) & CPUID_XSAVE=
_XSAVES) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) & CPUID_EXT_RDR=
AND) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX=
_INVPCID) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) & CPUID_7_0_EBX=
_RDSEED) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32=
;
> -        }
> -        if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) & CPUI=
D_EXT2_RDTSCP) {
> -            value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +        if (!has_msr_vmx_procbased_ctls2) {
> +            /* KVM forgot to add these bits for some time, do this ourse=
lves. */
> +            if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
> +                CPUID_XSAVE_XSAVES) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
> +                CPUID_EXT_RDRAND) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_INVPCID) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
> +                CPUID_7_0_EBX_RDSEED) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING <=
< 32;
> +            }
> +            if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &
> +                CPUID_EXT2_RDTSCP) {
> +                value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
> +            }
>          }
>          /* fall through */
>      case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
> @@ -2060,6 +2068,9 @@ static int kvm_get_supported_msrs(KVMState *s)
>              case MSR_IA32_UCODE_REV:
>                  has_msr_ucode_rev =3D true;
>                  break;
> +            case MSR_IA32_VMX_PROCBASED_CTLS2:
> +                has_msr_vmx_procbased_ctls2 =3D true;
> +                break;
>              }
>          }
>      }
>



--_000_BY5PR11MB396059E9E1FFE4B93EDE38E89AC80BY5PR11MB3960namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
Hi Vitaly</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
thanks for raising this, unfortunately this patch didn't work for me, I sti=
ll get the same error:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
my qemu command line:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Qemu-devel &lt;qemu-d=
evel-bounces&#43;julio.montes=3Dintel.com@nongnu.org&gt; on behalf of Paolo=
 Bonzini &lt;pbonzini@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, March 31, 2020 10:32 AM<br>
<b>To:</b> Vitaly Kuznetsov &lt;vkuznets@redhat.com&gt;; qemu-devel@nongnu.=
org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> Marcelo Tosatti &lt;mtosatti@redhat.com&gt;; Eduardo Habkost &lt=
;ehabkost@redhat.com&gt;; Dr . David Alan Gilbert &lt;dgilbert@redhat.com&g=
t;; Richard Henderson &lt;rth@twiddle.net&gt;<br>
<b>Subject:</b> Re: [PATCH] target/i386: do not set unsupported VMX seconda=
ry execution controls</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 31/03/20 18:27, Vitaly Kuznetsov wrote:<br>
&gt; Commit 048c95163b4 (&quot;target/i386: work around KVM_GET_MSRS bug fo=
r<br>
&gt; secondary execution controls&quot;) added a workaround for KVM pre-dat=
ing<br>
&gt; commit 6defc591846d (&quot;KVM: nVMX: include conditional controls in =
/dev/kvm<br>
&gt; KVM_GET_MSRS&quot;) which wasn't setting certain available controls. T=
he<br>
&gt; workaround uses generic CPUID feature bits to set missing VMX controls=
.<br>
&gt; <br>
&gt; It was found that in some cases it is possible to observe hosts which<=
br>
&gt; have certain CPUID features but lack the corresponding VMX control.<br=
>
&gt; <br>
&gt; In particular, it was reported that Azure VMs have RDSEED but lack<br>
&gt; VMX_SECONDARY_EXEC_RDSEED_EXITING; attempts to enable this feature<br>
&gt; bit result in QEMU abort.<br>
&gt; <br>
&gt; Resolve the issue but not applying the workaround when we don't have<b=
r>
&gt; to. As there is no good way to find out if KVM has the fix itself, use=
<br>
&gt; 95c5c7c77c (&quot;KVM: nVMX: list VMX MSRs in KVM_GET_MSR_INDEX_LIST&q=
uot;) instead<br>
&gt; as these [are supposed to] come together.<br>
&gt; <br>
&gt; Fixes: 048c95163b4 (&quot;target/i386: work around KVM_GET_MSRS bug fo=
r secondary execution controls&quot;)<br>
&gt; Suggested-by: Paolo Bonzini &lt;pbonzini@redhat.com&gt;<br>
&gt; Signed-off-by: Vitaly Kuznetsov &lt;vkuznets@redhat.com&gt;<br>
<br>
Queued, thanks.<br>
<br>
Paolo<br>
<br>
&gt; ---<br>
&gt;&nbsp; target/i386/kvm.c | 41 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;---------------<br>
&gt;&nbsp; 1 file changed, 26 insertions(&#43;), 15 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/kvm.c b/target/i386/kvm.c<br>
&gt; index 69eb43d796e6..4901c6dd747d 100644<br>
&gt; --- a/target/i386/kvm.c<br>
&gt; &#43;&#43;&#43; b/target/i386/kvm.c<br>
&gt; @@ -106,6 &#43;106,7 @@ static bool has_msr_arch_capabs;<br>
&gt;&nbsp; static bool has_msr_core_capabs;<br>
&gt;&nbsp; static bool has_msr_vmx_vmfunc;<br>
&gt;&nbsp; static bool has_msr_ucode_rev;<br>
&gt; &#43;static bool has_msr_vmx_procbased_ctls2;<br>
&gt;&nbsp; <br>
&gt;&nbsp; static uint32_t has_architectural_pmu_version;<br>
&gt;&nbsp; static uint32_t num_architectural_pmu_gp_counters;<br>
&gt; @@ -490,21 &#43;491,28 @@ uint64_t kvm_arch_get_supported_msr_feature(=
KVMState *s, uint32_t index)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =3D msr_data.entries[0].data;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (index) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_PROCBASED_CTLS2:<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* KVM forgot to add these=
 bits for some time, do this ourselves.&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 0xD, 1, R_ECX) &amp; CPUID_XSAVE_XSAVES) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 1, 0, R_ECX) &amp; CPUID_EXT_RDRAND) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 7, 0, R_EBX) &amp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING &lt;&lt; 32;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kvm_arch_get_supported=
_cpuid(s, 0x80000001, 0, R_EDX) &amp; CPUID_EXT2_RDTSCP) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; va=
lue |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!has_msr_vmx_procb=
ased_ctls2) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* KVM forgot to add these bits for some time, do this ourselves. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_XSAVE_XSAVES) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_XSAVES &l=
t;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT_RDRAND) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EX=
ITING &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_INVPCID) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_ENABLE_IN=
VPCID &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_7_0_EBX_RDSEED) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EX=
ITING &lt;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &amp;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; CPUID_EXT2_RDTSCP) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; value |=3D (uint64_t)VMX_SECONDARY_EXEC_RDTSCP &l=
t;&lt; 32;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fall through =
*/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case MSR_IA32_VMX_TRUE_PINBASED_CTLS:<br=
>
&gt; @@ -2060,6 &#43;2068,9 @@ static int kvm_get_supported_msrs(KVMState *=
s)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case MSR_IA32_UCODE_REV:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_ucode_rev =3D true;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; case MSR_IA32_VMX_PROCBASED_CTLS2:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; has_msr_vmx_procbased_ctls2 =3D true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BY5PR11MB396059E9E1FFE4B93EDE38E89AC80BY5PR11MB3960namp_--

