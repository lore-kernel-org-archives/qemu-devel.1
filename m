Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0B0C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3265520880
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="Y0lGFjtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3265520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37801 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDmcm-0001vX-H8
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:01:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDmbH-0000u6-L2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDmbG-0006SR-7t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:27 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
	([40.107.79.111]:39119
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hDmbF-0006QH-Pj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=U/PX8oisIFHHadB1JOalBKH1rYFSJgLwckL2sZ/3SYo=;
	b=Y0lGFjtVO1O0TRdFzBvSrBr9554jy1KvH9DaIbbChfU7gnYL99AYnijN0tpitv9XRLX9NxC+7/Wwna9n0diPJHLbZRr2PuenUxCoGlNJJbP2eEi+39r8e4/UHhNYqMn7ArGCqcc7NSD+rIVCU79v5EsvEymlWXS4vUlGUoBeS1w=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1635.namprd22.prod.outlook.com (10.174.85.164) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.16; Tue, 9 Apr 2019 08:59:21 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1792.009;
	Tue, 9 Apr 2019 08:59:20 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
Thread-Topic: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
Thread-Index: AQHU7phafzj+YhuaTEG+PttwAAXDgKYzhii7
Date: Tue, 9 Apr 2019 08:59:20 +0000
Message-ID:
 <BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>,
	<87mukziv48.fsf@dusky.pond.sub.org>
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=amarkovic@wavecomp.com; 
x-originating-ip: [82.117.201.26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebfd0876-fda6-4eaf-9c86-08d6bcc9a7cb
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1635; 
x-ms-traffictypediagnostic: BN6PR2201MB1635:
x-microsoft-antispam-prvs: <BN6PR2201MB1635EC3100DD22E507E88917C62D0@BN6PR2201MB1635.namprd22.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39850400004)(396003)(136003)(346002)(376002)(366004)(189003)(199004)(4326008)(106356001)(8676002)(81156014)(6246003)(97736004)(68736007)(446003)(8936002)(316002)(186003)(5660300002)(71190400001)(81166006)(11346002)(14444005)(256004)(53936002)(26005)(486006)(71200400001)(478600001)(14454004)(33656002)(25786009)(476003)(86362001)(6506007)(53546011)(7416002)(55016002)(6436002)(76176011)(54906003)(55236004)(74316002)(9686003)(102836004)(66066001)(7736002)(305945005)(110136005)(105586002)(2906002)(6116002)(7696005)(229853002)(99286004)(52536014)(3846002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1635;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w7Us468akpckG0HUiLy+4XWi8MpbGhxP5qDHEOsRSJ+9xqMoroVXVSmjDRKsvQKczy8IvRT7fwZhy1NSg9BFB28QZwNQh6zDkSBenkURiT4xE9l/Lk7vQvrbaAEqSKyJ/WPN2mnJlmLLkgdZsxFxsUhE9lKuwCr1Dgwf9ApykfS3toBcJxqXnMxqExNtQXsVnbyGQOPsasnXvwMeBuCyB/pn4rm75osCzYFrtHevkazThMQ91OKOedu4KfTDF03oV6TpG7UDYA1BfmY/LbHH/AvUimcNmCcdGVGygDBsMXa/ZgoZ8teDPkat1hB97cQi5nRLQQJaB5fKLfmwopcNApUfAXWSz+V3H9wFqiTCn6xlkMylS5eNwErpj3FsNji1Teq7/sC/Efu05qgrbgcLSCUz6slXrJAePSlIadNM4p4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfd0876-fda6-4eaf-9c86-08d6bcc9a7cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 08:59:20.7189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1635
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.111
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"f4bug@amsat.org" <f4bug@amsat.org>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409085920.1R_qQ08zKErGRPI7ZgW2uScUzpOc1-rkpxcER0By058@z>

>
> Lidong Chen <lidong.chen@oracle.com> writes:
>
> > Due to an off-by-one error, the assert statements allow an
> > out-of-bounds array access.
> >
> > Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> > ---
> >  hw/sd/sd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index aaab15f..818f86c 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates =
state)
> >      if (state =3D=3D sd_inactive_state) {
> >          return "inactive";
> >      }
> > -    assert(state <=3D ARRAY_SIZE(state_name));
> > +    assert(state < ARRAY_SIZE(state_name));
> >      return state_name[state];
> >  }
> >
> > @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t r=
sp)
> >      if (rsp =3D=3D sd_r1b) {
> >          rsp =3D sd_r1;
> >      }
> > -    assert(rsp <=3D ARRAY_SIZE(response_name));
> > +    assert(rsp < ARRAY_SIZE(response_name));
> >      return response_name[rsp];
> >  }
>
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
>
> $ git-grep '<=3D ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0=
]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0=
]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(s-=
>tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo);
> hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));

> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {

The last four items are OK as they are. The variable multiple_regs is, in f=
act,
an array of 9 int constants:

static const int multiple_regs[] =3D { 16, 17, 18, 19, 20, 21, 22, 23, 30 }=
;

ARRAY_SIZE (multiple_regs) will always be equal to 9.

The variable base_reglist (that is checked to be > 0 and <=3D9) is used
in succeeding lines like this:

        for (i =3D 0; i < base_reglist; i++) {
            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
                  GETPC());
            addr +=3D 4;
        }

Therefore, the array multiple_regs will always be accessed within its bound=
s.

> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D AR=
RAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));
>
> Lidong Chen, would you like to have a look at these?
>
> Cc'ing maintainers to help with further investigation.
>

Thank you for bringing this to our attention, Markus. And thanks to Lidong =
too.

Aleksandar

P. S. Shouldn't perhaps our macro ARRAY_SIZE() be renamed to
NUMBER_OF_ELEMENTS()?

________________________________________
From: Markus Armbruster <armbru@redhat.com>
Sent: Tuesday, April 9, 2019 7:51:51 AM
To: Lidong Chen
Cc: qemu-devel@nongnu.org; darren.kenny@oracle.com; f4bug@amsat.org; Peter =
Maydell; Jason Wang; Andrzej Zaborowski; Gerd Hoffmann; Aurelien Jarno; Ale=
ksandar Markovic; Aleksandar Rikalo; David Gibson; Richard Henderson; Paolo=
 Bonzini
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions

Lidong Chen <lidong.chen@oracle.com> writes:

> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates st=
ate)
>      if (state =3D=3D sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <=3D ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
>      if (rsp =3D=3D sd_r1b) {
>          rsp =3D sd_r1;
>      }
> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }

This is the second fix for this bug pattern in a fortnight.  Where's
one, there are more:

$ git-grep '<=3D ARRAY_SIZE'
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0])=
);
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0])=
);
hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(s->t=
x_fifo)) {
hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo);
hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D ARRA=
Y_SIZE(dbg->arch.bp));
tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));

Lidong Chen, would you like to have a look at these?

Cc'ing maintainers to help with further investigation.

