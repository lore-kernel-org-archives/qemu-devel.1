Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1752BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD8F20575
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 11:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCD8F20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48197 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOg7J-0006vm-2d
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 07:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOg6j-0006Rh-Ev
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOg6i-0005Vl-Cf
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 07:21:29 -0400
Received: from charlie.dont.surf ([128.199.63.193]:48378)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOg6f-0005Tx-TE; Wed, 15 Apr 2020 07:21:26 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 941A8BF7AF;
 Wed, 15 Apr 2020 11:21:23 +0000 (UTC)
Date: Wed, 15 Apr 2020 13:21:20 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 11/16] nvme: factor out block backend setup
Message-ID: <20200415112120.xywwownsyzy2o4n2@apples.localdomain>
References: <20200415102445.564803-1-its@irrelevant.dk>
 <20200415102445.564803-12-its@irrelevant.dk>
 <1557e920-2869-4e62-f996-30172ce82e0e@redhat.com>
 <20200415110258.qprpbl6dslgs6w2b@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415110258.qprpbl6dslgs6w2b@apples.localdomain>
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

On Apr 15 13:02, Klaus Birkelund Jensen wrote:
> On Apr 15 12:52, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 4/15/20 12:24 PM, Klaus Jensen wrote:
> > > From: Klaus Jensen <k.jensen@samsung.com>
> > >=20
> > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > > ---
> > >   hw/block/nvme.c | 15 ++++++++++++---
> > >   1 file changed, 12 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > > index e67f578fbf79..f0989cbb4335 100644
> > > --- a/hw/block/nvme.c
> > > +++ b/hw/block/nvme.c
> > > @@ -1348,6 +1348,17 @@ static void nvme_init_state(NvmeCtrl *n)
> > >       n->cq =3D g_new0(NvmeCQueue *, n->params.max_ioqpairs + 1);
> > >   }
> > > +static int nvme_init_blk(NvmeCtrl *n, Error **errp)
> > > +{
> > > +    blkconf_blocksizes(&n->conf);
> > > +    if (!blkconf_apply_backend_options(&n->conf, blk_is_read_only(=
n->conf.blk),
> > > +                                       false, errp)) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    return 0;
> >=20
> > I'm not sure this is a correct usage of the 'propagating errors' API =
(see
> > CODING_STYLE.rst and include/qapi/error.h), I'd expect this function =
to
> > return void, and use a local_error & error_propagate() in nvme_realiz=
e().
> >=20
> > However this works, so:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >=20
>=20
> So, I get that and did use the propagate functionality earlier. But I
> still used the int return. I'm not sure about the style if returning
> void - should I check if errp is now non-NULL? Point is that I need to
> return early since the later calls could fail if previous calls did not
> complete successfully.

Nevermind, I got it. I've changed it to propagate it correctly.

