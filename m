Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA076C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E00207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C5x2X0Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E00207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK0v2-0004Vs-6T
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Tianyu.Lan@microsoft.com>) id 1iK0Pa-0005so-Jp
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Tianyu.Lan@microsoft.com>) id 1iK0PW-0001F1-MT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:29:21 -0400
Received: from mail-eopbgr1320108.outbound.protection.outlook.com
 ([40.107.132.108]:50176 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Tianyu.Lan@microsoft.com>)
 id 1iK0PV-0001AO-TR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 09:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOaWR3F1h6D2wEd+2dwU/6aZppLSXouhzc+rsDmTb9IVihi2H3e9OG6B2PVZwUhNkfR3RzINPVBvBgilyYlQuZ+FsJb7SGG9CT8XTvvoOCE5mfMsqckgCh4o9WneaI1cNBMqnZt5y2i1iAYUKY1Wj3kynfRpINaQaUgRzEts32ElLj1hSM6sY0oxQ4hbJWZ9UFjhsDe7cHAzpwf8dXyen7HDHdBzmG84MBX4VOZNwlhaAcsc/6l8ZzbeRDSSe3DczgzTw1dI7RzjocLa2Mz/zSgS3uf8qNXb2UBe4BbPjQAckOoJ1nHDdYCfUnq6VWEdvVqLrDqoneay9+eqOEzGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05+SnYVVU0nSCZy3JxqfNvifL/Eu7nHLKANkoHsPS5Q=;
 b=VbYcq8gmEMMlsYWIYLMYLrEiyXcD8Wdnqi33HFpB7ce9dfrMgS0pa7z/whRgYSaX8AGh+AtNac0bjx51puyUWGvVGxYEJMHPxdh885q/Xnxn+y8sTLUYTkGcPJNhfK4V0Zt0kbLgq06zeVhjCk/LuDVj5gRS7cdgI7zbZsdikwWbbIJQrG38MYz5qoHffQRZT3XllWdhkcYquQUm7enzlLUaO9loHXii+H8nG79QOmTcDudf5P8+kVFlaH834mIgXDPmjdIrjvfOWJx4t8snKe//cg03AMwViaPlwwhgcqzvZf2MCVNoMTm9UT3MWa9H35JpTLMnJxNx5OzmfgdKuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05+SnYVVU0nSCZy3JxqfNvifL/Eu7nHLKANkoHsPS5Q=;
 b=C5x2X0Mq39LUXibB22bsGZFUq4RK+2LCycQHlGEM52YrUIrVAnA92gCzexyFAPB3uE5kfaCQt+w4sH/XeV6EJvyIdBGn/axjj/CamcEQoRnSi0rD3560JzF+updLLjwfOjfE2F8daU4Hyr0egRjkWRGbE4Grg8DWaTBmb9zohOc=
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM (52.132.240.14) by
 KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM (10.170.168.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.8; Mon, 14 Oct 2019 13:29:12 +0000
Received: from KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318]) by KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM
 ([fe80::d4ef:dc1e:e10:7318%6]) with mapi id 15.20.2367.014; Mon, 14 Oct 2019
 13:29:12 +0000
From: Tianyu Lan <Tianyu.Lan@microsoft.com>
To: vkuznets <vkuznets@redhat.com>, "lantianyu1986@gmail.com"
 <lantianyu1986@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, Roman
 Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Topic: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
Thread-Index: AQHVgK8HkSJ/Ajtt/E6pHX3BH3x3w6dYROIAgAHM/1I=
Date: Mon, 14 Oct 2019 13:29:12 +0000
Message-ID: <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>,
 <87r23h58th.fsf@vitty.brq.redhat.com>
In-Reply-To: <87r23h58th.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=tiala@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-14T13:29:07.5151561Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d1021c07-9beb-48bf-b35f-fc4394246b41;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tianyu.Lan@microsoft.com; 
x-originating-ip: [167.220.255.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e90b478-3f70-4112-33e9-08d750aa8085
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: KL1P15301MB0054:|KL1P15301MB0054:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <KL1P15301MB0054D287458B2383468D1AB492900@KL1P15301MB0054.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 01901B3451
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(189003)(199004)(64756008)(476003)(316002)(66556008)(54906003)(110136005)(66476007)(66446008)(14454004)(478600001)(10290500003)(486006)(8990500004)(76116006)(66946007)(86362001)(5660300002)(2501003)(52536014)(7416002)(22452003)(74316002)(7736002)(4326008)(10090500001)(3846002)(790700001)(6116002)(33656002)(71200400001)(71190400001)(14444005)(256004)(66066001)(2906002)(6436002)(7696005)(446003)(11346002)(229853002)(99286004)(55016002)(25786009)(9686003)(54896002)(6306002)(26005)(81166006)(186003)(53546011)(6506007)(8676002)(81156014)(6246003)(102836004)(8936002)(76176011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:KL1P15301MB0054;
 H:KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0rHXwT52/poxwToXFmLm2+rcQu8pPizDRdOxF8tmaS7pDXVt/0bn11WkqELk6qlAKtT1FZUQO+gwFhnFPHiq39LVjb31iSMZ9B0ZXuwQtZ4beBbGfMIj4JQ4PZtj6fUy43AIPFrq4YhVPJ8ZH9mkTCLm+hYVhkMUAfyYEeqR0OwY+bZiCOWenwMRzSYHtMydznrYhH1HIThbp5OXoxA+gKidHOmbnUhNmHUZTmI2sTvuY05I8V1kWwOPCtUPmumurQHyAs/10ovOZWU5+PFsB6OPm7PeUx7mO3mloyoaP6EyFGmeug6/v8QVTe8LTK7lSzyZbNTFGnmsOJkJpzkuu0xEObDl/qG8vd86RaRF23MjA/XfLh9PqcvQBGXBdgND2JP5aufCcsXbm2Q8AQ6AquEkjfGEziUdZ09beV+4j4=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_KL1P15301MB02611D1F7C54C4A599766B8D92900KL1P15301MB0261_"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e90b478-3f70-4112-33e9-08d750aa8085
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2019 13:29:12.2822 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkmU84jaZq2Vpqh55nL09hpkyJCeWJ2fiqv7EgHqrygn8lpvIgkiBgqSsFCdMfJbcVb15BhFSJe9eO3dYlJuDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0054
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.132.108
X-Mailman-Approved-At: Mon, 14 Oct 2019 09:59:18 -0400
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

--_000_KL1P15301MB02611D1F7C54C4A599766B8D92900KL1P15301MB0261_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Vitaly:
                Thanks a lot for your review.
On Sun, Oct 13, 2019 at 4:49 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrot=
e:
>
> lantianyu1986@gmail.com writes:
>
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> >
>
> (Please also Cc: Roman on you Hyper-V related submissions to QEMU who's
> known to be a great reviewer)

Good suggestion!
>
> > Hyper-V direct tlb flush targets KVM on Hyper-V guest.
> > Enable direct TLB flush for its guests meaning that TLB
> > flush hypercalls are handled by Level 0 hypervisor (Hyper-V)
> > bypassing KVM in Level 1. Due to the different ABI for hypercall
> > parameters between Hyper-V and KVM, KVM capabilities should be
> > hidden when enable Hyper-V direct tlb flush otherwise KVM
> > hypercalls may be intercepted by Hyper-V. Add new parameter
> > "hv-direct-tlbflush". Check expose_kvm and Hyper-V tlb flush
> > capability status before enabling the feature.
> >
> > Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > ---
> >  docs/hyperv.txt           | 12 ++++++++++++
> >  linux-headers/linux/kvm.h |  1 +
> >  target/i386/cpu.c         |  2 ++
> >  target/i386/cpu.h         |  1 +
> >  target/i386/kvm.c         | 21 +++++++++++++++++++++
> >  5 files changed, 37 insertions(+)
> >
> > diff --git a/docs/hyperv.txt b/docs/hyperv.txt
> > index 8fdf25c829..ceab8c21fe 100644
> > --- a/docs/hyperv.txt
> > +++ b/docs/hyperv.txt
> > @@ -184,6 +184,18 @@ enabled.
> >
> >  Requires: hv-vpindex, hv-synic, hv-time, hv-stimer
> >
> > +3.18. hv-direct-tlbflush
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +The enlightenment targets KVM on Hyper-V guest. Enable direct TLB flus=
h for
> > +its guests meaning that TLB flush hypercalls are handled by Level 0 hy=
pervisor
> > +(Hyper-V) bypassing KVM in Level 1. Due to the different ABI for hyper=
call
> > +parameters between Hyper-V and KVM, enabling this capability effective=
ly
> > +disables all hypercall handling by KVM (as some KVM hypercall may be m=
istakenly
> > +treated as TLB flush hypercalls by Hyper-V). So kvm capability should =
not show
> > +to guest when enable this capability. If not, user will fail to enable=
 this
> > +capability.
> > +
> > +Requires: hv-tlbflush, -kvm
> >
> >  4. Development features
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 18892d6541..923fb33a01 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_ARM_SVE 170
> >  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
> >  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
> > +#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174
>
> I was once told that scripts/update-linux-headers.sh script is supposed
> to be used instead of cherry-picking stuff you need (adn this would be a
> separate patch - update linux headers to smth).
>

Thanks for suggestion. I just try the update-linux-headers.sh and there are=
 a lot
of changes which are not related with my patch. I also include these
changes in my patch, right?

> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 44f1bbdcac..7bc7fee512 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6156,6 +6156,8 @@ static Property x86_cpu_properties[] =3D {
> >                        HYPERV_FEAT_IPI, 0),
> >      DEFINE_PROP_BIT64("hv-stimer-direct", X86CPU, hyperv_features,
> >                        HYPERV_FEAT_STIMER_DIRECT, 0),
> > +    DEFINE_PROP_BIT64("hv-direct-tlbflush", X86CPU, hyperv_features,
> > +                      HYPERV_FEAT_DIRECT_TLBFLUSH, 0),
> >      DEFINE_PROP_BOOL("hv-passthrough", X86CPU, hyperv_passthrough, fal=
se),
> >
> >      DEFINE_PROP_BOOL("check", X86CPU, check_cpuid, true),
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index eaa5395aa5..3cb105f7d6 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -907,6 +907,7 @@ typedef uint64_t FeatureWordArray[FEATURE_WORDS];
> >  #define HYPERV_FEAT_EVMCS               12
> >  #define HYPERV_FEAT_IPI                 13
> >  #define HYPERV_FEAT_STIMER_DIRECT       14
> > +#define HYPERV_FEAT_DIRECT_TLBFLUSH     15
> >
> >  #ifndef HYPERV_SPINLOCK_NEVER_RETRY
> >  #define HYPERV_SPINLOCK_NEVER_RETRY             0xFFFFFFFF
> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> > index 11b9c854b5..8e999dbcf1 100644
> > --- a/target/i386/kvm.c
> > +++ b/target/i386/kvm.c
> > @@ -1235,6 +1235,27 @@ static int hyperv_handle_properties(CPUState *cs=
,
> >          r |=3D 1;
> >      }
> >
> > +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH)) {
> > +        if (!kvm_check_extension(cs->kvm_state,
> > +            KVM_CAP_HYPERV_DIRECT_TLBFLUSH)) {
> > +            fprintf(stderr,
> > +                    "Kernel doesn't support Hyper-V direct tlbflush.\n=
");
> > +            r =3D -ENOSYS;
> > +            goto free;
> > +        }
> > +
> > +        if (cpu->expose_kvm ||
> > +            !hyperv_feat_enabled(cpu, HYPERV_FEAT_TLBFLUSH)) {
> > +            fprintf(stderr, "Hyper-V direct tlbflush requires Hyper-V =
%s"
> > +                    " and not expose KVM.\n",
> > +                    kvm_hyperv_properties[HYPERV_FEAT_TLBFLUSH].desc);
> > +            r =3D -ENOSYS;
> > +            goto free;
> > +        }
> > +
> > +        kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, 0);
> > +    }
>
> We also have hv-passthrough mode where all Hyper-V enlightenments are
> supposed to be enabled; I'd suggest you do the same we currently do with
> HYPERV_FEAT_EVMCS:
>
>     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH) ||
>         cpu->hyperv_passthrough) {
>
>         r =3D kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_DIRECT_TLBFLUSH, 0, =
0);
>
>         if (hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) && r) {
>             fprintf(stderr, "Hyper-V %s is not supported by kernel\n",
>                     kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].de=
sc);
>             return -ENOSYS;
>         }
>
> No need to check for a capability if you're going to enable it right
> away (and btw - this can fail).
>

Nice catch.  I ignored passthrough mode and will update in the new version.

> You also need to use kvm_hyperv_properties to track dependencies between
> features and not do it manually here (like you required
> HYPERV_FEAT_TLBFLUSH). This is going to be the first feature without its
> own CPUID bits assigned so some tweaks to kvm_hyperv_properties handling
> may be required. Or we can use HYPERV_FEAT_TLBFLUSH bits, I'm not sure
> here.
>

Yes,  I found kvm_hyperv_properties didn't support no CPUID case and so gav=
e up
to use it. I will have a try in the next version. Thanks.
--
Best regards
Tianyu Lan

--_000_KL1P15301MB02611D1F7C54C4A599766B8D92900KL1P15301MB0261_
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
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@DengXian";
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
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Times New Roman",serif;
	color:black;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p class=3D"MsoNormal">Hi Vitaly:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thanks a lot for your review.<o:p></=
o:p></p>
<p class=3D"MsoNormal">On Sun, Oct 13, 2019 at 4:49 PM Vitaly Kuznetsov &lt=
;vkuznets@redhat.com&gt; wrote:<br>
&gt;<br>
&gt; lantianyu1986@gmail.com writes:<br>
&gt;<br>
&gt; &gt; From: Tianyu Lan &lt;Tianyu.Lan@microsoft.com&gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt; (Please also Cc: Roman on you Hyper-V related submissions to QEMU who'=
s<br>
&gt; known to be a great reviewer)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Good suggestion! <br>
&gt;<br>
&gt; &gt; Hyper-V direct tlb flush targets KVM on Hyper-V guest.<br>
&gt; &gt; Enable direct TLB flush for its guests meaning that TLB<br>
&gt; &gt; flush hypercalls are handled by Level 0 hypervisor (Hyper-V)<br>
&gt; &gt; bypassing KVM in Level 1. Due to the different ABI for hypercall<=
br>
&gt; &gt; parameters between Hyper-V and KVM, KVM capabilities should be<br=
>
&gt; &gt; hidden when enable Hyper-V direct tlb flush otherwise KVM<br>
&gt; &gt; hypercalls may be intercepted by Hyper-V. Add new parameter<br>
&gt; &gt; &quot;hv-direct-tlbflush&quot;. Check expose_kvm and Hyper-V tlb =
flush<br>
&gt; &gt; capability status before enabling the feature.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Tianyu Lan &lt;Tianyu.Lan@microsoft.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt; &nbsp;docs/hyperv.txt &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 12 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt; &nbsp;linux-headers/linux/kvm.h | &nbsp;1 &#43;<br>
&gt; &gt; &nbsp;target/i386/cpu.c &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;2 &#4=
3;&#43;<br>
&gt; &gt; &nbsp;target/i386/cpu.h &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp;1 &#4=
3;<br>
&gt; &gt; &nbsp;target/i386/kvm.c &nbsp; &nbsp; &nbsp; &nbsp; | 21 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&gt; &gt; &nbsp;5 files changed, 37 insertions(&#43;)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/docs/hyperv.txt b/docs/hyperv.txt<br>
&gt; &gt; index 8fdf25c829..ceab8c21fe 100644<br>
&gt; &gt; --- a/docs/hyperv.txt<br>
&gt; &gt; &#43;&#43;&#43; b/docs/hyperv.txt<br>
&gt; &gt; @@ -184,6 &#43;184,18 @@ enabled.<br>
&gt; &gt; <br>
&gt; &gt; &nbsp;Requires: hv-vpindex, hv-synic, hv-time, hv-stimer<br>
&gt; &gt; <br>
&gt; &gt; &#43;3.18. hv-direct-tlbflush<br>
&gt; &gt; &#43;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
&gt; &gt; &#43;The enlightenment targets KVM on Hyper-V guest. Enable direc=
t TLB flush for<br>
&gt; &gt; &#43;its guests meaning that TLB flush hypercalls are handled by =
Level 0 hypervisor<br>
&gt; &gt; &#43;(Hyper-V) bypassing KVM in Level 1. Due to the different ABI=
 for hypercall<br>
&gt; &gt; &#43;parameters between Hyper-V and KVM, enabling this capability=
 effectively<br>
&gt; &gt; &#43;disables all hypercall handling by KVM (as some KVM hypercal=
l may be mistakenly<br>
&gt; &gt; &#43;treated as TLB flush hypercalls by Hyper-V). So kvm capabili=
ty should not show<br>
&gt; &gt; &#43;to guest when enable this capability. If not, user will fail=
 to enable this<br>
&gt; &gt; &#43;capability.<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;Requires: hv-tlbflush, -kvm<br>
&gt; &gt; <br>
&gt; &gt; &nbsp;4. Development features<br>
&gt; &gt; &nbsp;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
&gt; &gt; diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.=
h<br>
&gt; &gt; index 18892d6541..923fb33a01 100644<br>
&gt; &gt; --- a/linux-headers/linux/kvm.h<br>
&gt; &gt; &#43;&#43;&#43; b/linux-headers/linux/kvm.h<br>
&gt; &gt; @@ -995,6 &#43;995,7 @@ struct kvm_ppc_resize_hpt {<br>
&gt; &gt; &nbsp;#define KVM_CAP_ARM_SVE 170<br>
&gt; &gt; &nbsp;#define KVM_CAP_ARM_PTRAUTH_ADDRESS 171<br>
&gt; &gt; &nbsp;#define KVM_CAP_ARM_PTRAUTH_GENERIC 172<br>
&gt; &gt; &#43;#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174<br>
&gt;<br>
&gt; I was once told that scripts/update-linux-headers.sh script is suppose=
d<br>
&gt; to be used instead of cherry-picking stuff you need (adn this would be=
 a<br>
&gt; separate patch - update linux headers to smth).<br>
&gt;<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks for suggestion. I just try the update-linux-h=
eaders.sh and there are a lot<o:p></o:p></p>
<p class=3D"MsoNormal">of changes which are not related with my patch. I al=
so include these<o:p></o:p></p>
<p class=3D"MsoNormal">changes in my patch, right?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt; &gt; <br>
&gt; &gt; &nbsp;#ifdef KVM_CAP_IRQ_ROUTING<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt; &gt; index 44f1bbdcac..7bc7fee512 100644<br>
&gt; &gt; --- a/target/i386/cpu.c<br>
&gt; &gt; &#43;&#43;&#43; b/target/i386/cpu.c<br>
&gt; &gt; @@ -6156,6 &#43;6156,8 @@ static Property x86_cpu_properties[] =
=3D {<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;HYPERV_FEAT_IPI, 0),<br>
&gt; &gt; &nbsp; &nbsp; &nbsp;DEFINE_PROP_BIT64(&quot;hv-stimer-direct&quot=
;, X86CPU, hyperv_features,<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;HYPERV_FEAT_STIMER_DIRECT, 0),<br>
&gt; &gt; &#43; &nbsp; &nbsp;DEFINE_PROP_BIT64(&quot;hv-direct-tlbflush&quo=
t;, X86CPU, hyperv_features,<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp;HYPERV_FEAT_DIRECT_TLBFLUSH, 0),<br>
&gt; &gt; &nbsp; &nbsp; &nbsp;DEFINE_PROP_BOOL(&quot;hv-passthrough&quot;, =
X86CPU, hyperv_passthrough, false),<br>
&gt; &gt; <br>
&gt; &gt; &nbsp; &nbsp; &nbsp;DEFINE_PROP_BOOL(&quot;check&quot;, X86CPU, c=
heck_cpuid, true),<br>
&gt; &gt; diff --git a/target/i386/cpu.h b/target/i386/cpu.h<br>
&gt; &gt; index eaa5395aa5..3cb105f7d6 100644<br>
&gt; &gt; --- a/target/i386/cpu.h<br>
&gt; &gt; &#43;&#43;&#43; b/target/i386/cpu.h<br>
&gt; &gt; @@ -907,6 &#43;907,7 @@ typedef uint64_t FeatureWordArray[FEATURE=
_WORDS];<br>
&gt; &gt; &nbsp;#define HYPERV_FEAT_EVMCS &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; 12<br>
&gt; &gt; &nbsp;#define HYPERV_FEAT_IPI &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; 13<br>
&gt; &gt; &nbsp;#define HYPERV_FEAT_STIMER_DIRECT &nbsp; &nbsp; &nbsp; 14<b=
r>
&gt; &gt; &#43;#define HYPERV_FEAT_DIRECT_TLBFLUSH &nbsp; &nbsp; 15<br>
&gt; &gt; <br>
&gt; &gt; &nbsp;#ifndef HYPERV_SPINLOCK_NEVER_RETRY<br>
&gt; &gt; &nbsp;#define HYPERV_SPINLOCK_NEVER_RETRY &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; 0xFFFFFFFF<br>
&gt; &gt; diff --git a/target/i386/kvm.c b/target/i386/kvm.c<br>
&gt; &gt; index 11b9c854b5..8e999dbcf1 100644<br>
&gt; &gt; --- a/target/i386/kvm.c<br>
&gt; &gt; &#43;&#43;&#43; b/target/i386/kvm.c<br>
&gt; &gt; @@ -1235,6 &#43;1235,27 @@ static int hyperv_handle_properties(CP=
UState *cs,<br>
&gt; &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r |=3D 1;<br>
&gt; &gt; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; <br>
&gt; &gt; &#43; &nbsp; &nbsp;if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIREC=
T_TLBFLUSH)) {<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;if (!kvm_check_extension(cs-&gt;=
kvm_state,<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;KVM_CAP_HYPERV_DIR=
ECT_TLBFLUSH)) {<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(stderr,<br=
>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;&quot;Kernel doesn't support Hyper-V direct tlbflush.\n&quot;);<b=
r>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r =3D -ENOSYS;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto free;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;if (cpu-&gt;expose_kvm ||<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;!hyperv_feat_enabl=
ed(cpu, HYPERV_FEAT_TLBFLUSH)) {<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fprintf(stderr, &q=
uot;Hyper-V direct tlbflush requires Hyper-V %s&quot;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;&quot; and not expose KVM.\n&quot;,<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;kvm_hyperv_properties[HYPERV_FEAT_TLBFLUSH].desc);<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;r =3D -ENOSYS;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;goto free;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43; &nbsp; &nbsp; &nbsp; &nbsp;kvm_vcpu_enable_cap(cs, KVM_CAP_=
HYPERV_DIRECT_TLBFLUSH, 0, 0);<br>
&gt; &gt; &#43; &nbsp; &nbsp;}<br>
&gt;<br>
&gt; We also have hv-passthrough mode where all Hyper-V enlightenments are<=
br>
&gt; supposed to be enabled; I'd suggest you do the same we currently do wi=
th<br>
&gt; HYPERV_FEAT_EVMCS:<br>
&gt;<br>
&gt; &nbsp; &nbsp; if (hyperv_feat_enabled(cpu, HYPERV_FEAT_DIRECT_TLBFLUSH=
) ||<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; cpu-&gt;hyperv_passthrough) {<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; r =3D kvm_vcpu_enable_cap(cs, KVM_CAP_HYPE=
RV_DIRECT_TLBFLUSH, 0, 0);<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (hyperv_feat_enabled(cpu, HYPERV_FEAT_E=
VMCS) &amp;&amp; r) {<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; fprintf(stderr, &quot;Hyper-=
V %s is not supported by kernel\n&quot;,<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
kvm_hyperv_properties[HYPERV_FEAT_DIRECT_TLBFLUSH].desc);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -ENOSYS;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt;<br>
&gt; No need to check for a capability if you're going to enable it right<b=
r>
&gt; away (and btw - this can fail).<o:p></o:p></p>
<p class=3D"MsoNormal">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Nice catch. &nbsp;I ignored passthrough mode and wil=
l update in the new version.
<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
&gt; You also need to use kvm_hyperv_properties to track dependencies betwe=
en<br>
&gt; features and not do it manually here (like you required<br>
&gt; HYPERV_FEAT_TLBFLUSH). This is going to be the first feature without i=
ts<br>
&gt; own CPUID bits assigned so some tweaks to kvm_hyperv_properties handli=
ng<br>
&gt; may be required. Or we can use HYPERV_FEAT_TLBFLUSH bits, I'm not sure=
<br>
&gt; here.<br>
&gt;<br>
<br>
<o:p></o:p></p>
<p class=3D"MsoNormal">Yes, &nbsp;I found kvm_hyperv_properties didn&#8217;=
t support no CPUID case and so gave up<o:p></o:p></p>
<p class=3D"MsoNormal">to use it. I will have a try in the next version. Th=
anks.<br>
-- <br>
Best regards<br>
Tianyu Lan<o:p></o:p></p>
</div>
</body>
</html>

--_000_KL1P15301MB02611D1F7C54C4A599766B8D92900KL1P15301MB0261_--

