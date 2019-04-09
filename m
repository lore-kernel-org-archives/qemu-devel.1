Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79032C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DF852084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MaebiGC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF852084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wavecomp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDnGB-0003Zo-Gg
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:41:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDnEw-0002lT-TN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDnEv-0007nr-MV
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:26 -0400
Received: from mail-eopbgr780109.outbound.protection.outlook.com
	([40.107.78.109]:15296
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hDnEu-0007i1-Oj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=2evM5Mgjau4sxfZa1i6nTfZTsdBN0Vw+Hoj4x3yDTJA=;
	b=MaebiGC322WH8sLe6g9WWgIqBeiQLikMwD95zxX8t5+WBES9ecoMrDJJwiobkXMtgzz6V7+yPZnD/PPdcxLWnjEhTGGXENPu4kozZsMycr4Wqetelcyb5cC+/ZEXkB4uLD3H6flvVaMvef+NThPrD2XJg3QA0GBz0ielWvQjpJ0=
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com (10.174.81.139) by
	BN6PR2201MB1298.namprd22.prod.outlook.com (10.174.80.144) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1771.13; Tue, 9 Apr 2019 09:40:19 +0000
Received: from BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81]) by
	BN6PR2201MB1251.namprd22.prod.outlook.com
	([fe80::3c70:1ca4:2aa:9e81%2]) with mapi id 15.20.1792.009;
	Tue, 9 Apr 2019 09:40:19 +0000
From: Aleksandar Markovic <amarkovic@wavecomp.com>
To: Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
Thread-Topic: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
Thread-Index: AQHU7phafzj+YhuaTEG+PttwAAXDgKYzkHxA
Date: Tue, 9 Apr 2019 09:40:18 +0000
Message-ID:
 <BN6PR2201MB1251E6696D83A98F4A1334F6C62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: ad720bfc-423d-466b-55ff-08d6bccf6102
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
	SRVR:BN6PR2201MB1298; 
x-ms-traffictypediagnostic: BN6PR2201MB1298:
x-microsoft-antispam-prvs: <BN6PR2201MB1298200B4BB82CEF24B465F5C62D0@BN6PR2201MB1298.namprd22.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39840400004)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(4326008)(25786009)(229853002)(478600001)(446003)(81156014)(486006)(55016002)(6246003)(305945005)(74316002)(11346002)(8676002)(14454004)(6436002)(7736002)(476003)(33656002)(81166006)(6506007)(53936002)(3846002)(186003)(76176011)(71200400001)(55236004)(7696005)(9686003)(110136005)(71190400001)(26005)(97736004)(102836004)(54906003)(2906002)(86362001)(316002)(7416002)(5660300002)(106356001)(105586002)(68736007)(52536014)(66066001)(256004)(6116002)(99286004)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:BN6PR2201MB1298;
	H:BN6PR2201MB1251.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6dQKdvbSSP7B/MnIdDJq0UhTLx4IDHAv1Z/+h8QTXM5ULEQcdP/bHXPQWaL9HgWhtzqoAUeq1UnBEZQWvkQvO7q38yV81xm8LepzwsoPCDGU8fYVpX3flUCqJ5iuWcdnPssUrVo9sclXGiSISa3CdVcszXItHvTmH6lA2J3Gi821NyRbI9i+eDEOi1+ueQxi41MvdZUaklKyogpmhXnCBSbFhZCS+UWAY6vQsZTE65p2JzPRPRtJCzvf1m86au4x/hM4r/8L4Ug1v9r+rtAfFDI1oAG414MHDdKLnWC+48Q/qyvcqPx/InkEM7rqaw9LqIeavgT0+yfp3BKVBLzqNCJ34q8Zs/OQnPL0lrwc5zoAcsVocGaN9bw7/lDNetM89nDopjB9lUcbfS8LlIOcGHslU8YqmwQ+TKR1LW4oA7s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wavecomp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad720bfc-423d-466b-55ff-08d6bccf6102
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 09:40:18.9997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR2201MB1298
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.109
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
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>,
	Riku Voipio <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"f4bug@amsat.org" <f4bug@amsat.org>,
	"darren.kenny@oracle.com" <darren.kenny@oracle.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	"edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Aurelien Jarno <aurelien@aurel32.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409094018.z48B9ARkIpTGQC_K8nK70rWMdqK2gCDyDd7zrmqLi-U@z>

Markus wrote:

> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
>=20
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
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D AR=
RAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));

There could be even more:

$ git grep '> ARRAY_SIZE'
hw/display/ssd0323.c:    if (s->cmd_len > ARRAY_SIZE(s->cmd_data)) {
hw/display/vmware_vga.c:                || SVGA_BITMAP_SIZE(x, y) > ARRAY_S=
IZE(cursor.mask)
hw/display/vmware_vga.c:                    > ARRAY_SIZE(cursor.image)) {
hw/dma/xlnx-zdma.c:        len =3D src_size > ARRAY_SIZE(s->buf) ? ARRAY_SI=
ZE(s->buf) : src_size;
hw/net/stellaris_enet.c:    if (s->np > ARRAY_SIZE(s->rx)) {
hw/net/stellaris_enet.c:        if (s->rx[i].len > ARRAY_SIZE(s->rx[i].data=
)) {
hw/net/stellaris_enet.c:    if (s->rx_fifo_offset > ARRAY_SIZE(s->rx[0].dat=
a) - 4) {
hw/net/stellaris_enet.c:    if (s->tx_fifo_len > ARRAY_SIZE(s->tx_fifo)) {
hw/scsi/mptsas.c:    ((s)->name##_head > ARRAY_SIZE((s)->name) ||         \
hw/scsi/mptsas.c:     (s)->name##_tail > ARRAY_SIZE((s)->name))
hw/scsi/mptsas.c:        s->doorbell_cnt > ARRAY_SIZE(s->doorbell_msg) ||
hw/scsi/mptsas.c:        s->doorbell_reply_size > ARRAY_SIZE(s->doorbell_re=
ply) ||
hw/sd/ssi-sd.c:        (!s->stopping && s->arglen > ARRAY_SIZE(s->response)=
))) {
hw/usb/dev-mtp.c:            if (cmd.argc > ARRAY_SIZE(cmd.argv)) {
linux-user/syscall.c:    if (nargs[num] > ARRAY_SIZE(a)) {
target/sh4/translate.c:    if (max_insns > ARRAY_SIZE(insns)) {

CC-ing additional maintainers.

Aleksandar=

