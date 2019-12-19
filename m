Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB5C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:49:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 183FA2465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 183FA2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzvq-0001tT-OU
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1ihzZ2-0007gI-Hc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1ihzZ1-0000pm-8u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:26:16 -0500
Received: from charlie.dont.surf ([128.199.63.193]:60802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1ihzYy-0000Yj-KM; Thu, 19 Dec 2019 12:26:12 -0500
Received: from apples.localdomain (ip-5-186-120-84.cgn.fibianet.dk
 [5.186.120.84])
 by charlie.dont.surf (Postfix) with ESMTPSA id 4E662BF506;
 Thu, 19 Dec 2019 17:26:11 +0000 (UTC)
Date: Thu, 19 Dec 2019 18:26:07 +0100
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Michal =?utf-8?B?UHLDrXZvem7DrWs=?= <mprivozn@redhat.com>
Subject: Re: [PATCH v4 21/24] nvme: support multiple namespaces
Message-ID: <20191219172607.635mzytr6syum5ii@apples.localdomain>
References: <20191219130921.309264-1-k.jensen@samsung.com>
 <CGME20191219130948eucas1p2cfed0da65071fd76446daecbb217e86e@eucas1p2.samsung.com>
 <20191219130921.309264-22-k.jensen@samsung.com>
 <6f2fe19f-c832-032a-e898-cbe385f709ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6f2fe19f-c832-032a-e898-cbe385f709ac@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 128.199.63.193
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dec 19 16:11, Michal Pr=EDvozn=EDk wrote:
> On 12/19/19 2:09 PM, Klaus Jensen wrote:
> > This adds support for multiple namespaces by introducing a new 'nvme-=
ns'
> > device model. The nvme device creates a bus named from the device nam=
e
> > ('id'). The nvme-ns devices then connect to this and registers
> > themselves with the nvme device.
> >=20
> > This changes how an nvme device is created. Example with two namespac=
es:
> >=20
> >   -drive file=3Dnvme0n1.img,if=3Dnone,id=3Ddisk1
> >   -drive file=3Dnvme0n2.img,if=3Dnone,id=3Ddisk2
> >   -device nvme,serial=3Ddeadbeef,id=3Dnvme0
> >   -device nvme-ns,drive=3Ddisk1,bus=3Dnvme0,nsid=3D1
> >   -device nvme-ns,drive=3Ddisk2,bus=3Dnvme0,nsid=3D2
> >=20
> > The drive property is kept on the nvme device to keep the change
> > backward compatible, but the property is now optional. Specifying a
> > drive for the nvme device will always create the namespace with nsid =
1.
> >=20
> > Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>=20
> Klaus, just to make sure I understand correctly, this implements
> multiple namespaces for *emulated* NVMe, right? I'm asking because I
> just merged libvirt patches to support:
>=20
> -drive
> file.driver=3Dnvme,file.device=3D0000:01:00.0,file.namespace=3D1,format=
=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
> -device
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-virtio-d=
isk0,id=3Dvirtio-disk0,bootindex=3D1
>=20
> and seeing these patches made me doubt my design. But if your patches
> touch emulated NVMe only, then libvirt's fine because it doesn't expose
> that just yet.
>=20
> Michal
>=20

Hi Michal,

Yes, this is only for the emulated nvme controller.

