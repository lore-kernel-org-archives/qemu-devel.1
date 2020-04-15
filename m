Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D9C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:54:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5D8A20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D8A20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfgL-0001XH-0J
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOffe-00012W-Q6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOffd-00067K-MR
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:53:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOffb-00060Z-7y; Wed, 15 Apr 2020 06:53:27 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 514B7BF7AF;
 Wed, 15 Apr 2020 10:53:25 +0000 (UTC)
Date: Wed, 15 Apr 2020 12:53:22 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/16] nvme: factor out namespace setup
Message-ID: <20200415105322.iuirj5sphp7i5whu@apples.localdomain>
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-14-its@irrelevant.dk>
 <1f57886a-8645-eeda-f482-4353b423c80f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f57886a-8645-eeda-f482-4353b423c80f@redhat.com>
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
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Apr 15 12:38, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/15/20 12:24 PM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > ---
> >   hw/block/nvme.c | 47 ++++++++++++++++++++++++++--------------------=
-
> >   1 file changed, 26 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index f0989cbb4335..08f7ae0a48b3 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1359,13 +1359,35 @@ static int nvme_init_blk(NvmeCtrl *n, Error *=
*errp)
> >       return 0;
> >   }
> > +static int nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error=
 **errp)
> > +{
> > +    int64_t bs_size;
> > +    NvmeIdNs *id_ns =3D &ns->id_ns;
> > +
> > +    bs_size =3D blk_getlength(n->conf.blk);
> > +    if (bs_size < 0) {
> > +        error_setg_errno(errp, -bs_size, "could not get backing file=
 size");
> > +        return -1;
> > +    }
> > +
> > +    n->ns_size =3D bs_size;
> > +
> > +    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
> > +    id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(n, ns));
> > +
> > +    /* no thin provisioning */
> > +    id_ns->ncap =3D id_ns->nsze;
> > +    id_ns->nuse =3D id_ns->ncap;
> > +
> > +    return 0;
> > +}
> > +
> >   static void nvme_realize(PCIDevice *pci_dev, Error **errp)
> >   {
> >       NvmeCtrl *n =3D NVME(pci_dev);
> >       NvmeIdCtrl *id =3D &n->id_ctrl;
> >       int i;
> > -    int64_t bs_size;
> >       uint8_t *pci_conf;
> >       if (nvme_check_constraints(n, errp)) {
> > @@ -1374,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, E=
rror **errp)
> >       nvme_init_state(n);
> > -    bs_size =3D blk_getlength(n->conf.blk);
> > -    if (bs_size < 0) {
> > -        error_setg(errp, "could not get backing file size");
> > -        return;
> > -    }
> > -
> >       if (nvme_init_blk(n, errp)) {
> >           return;
> >       }
> > @@ -1390,8 +1406,6 @@ static void nvme_realize(PCIDevice *pci_dev, Er=
ror **errp)
> >       pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS=
);
> >       pcie_endpoint_cap_init(pci_dev, 0x80);
> > -    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>=20
> I'm not sure this line belong to this patch.
>=20
=20
It does. It is already there in the middle of the realize function. It
is moved to nvme_init_namespace as

  n->ns_size =3D bs_size;

since only a single namespace can be configured anyway. I will remove
the for-loop that initializes multiple namespaces as well.

