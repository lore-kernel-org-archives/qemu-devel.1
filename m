Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA0BC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2282820768
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 07:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2282820768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOclP-0002Ni-7j
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 03:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <its@irrelevant.dk>) id 1jOckd-0001ih-Gt
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:46:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <its@irrelevant.dk>) id 1jOckc-0006Ov-HZ
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 03:46:27 -0400
Received: from charlie.dont.surf ([128.199.63.193]:47830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <its@irrelevant.dk>)
 id 1jOcka-0006OA-ET; Wed, 15 Apr 2020 03:46:24 -0400
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net
 [80.167.98.190])
 by charlie.dont.surf (Postfix) with ESMTPSA id 66845BF603;
 Wed, 15 Apr 2020 07:46:22 +0000 (UTC)
Date: Wed, 15 Apr 2020 09:46:19 +0200
From: Klaus Birkelund Jensen <its@irrelevant.dk>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v7 06/48] nvme: refactor nvme_addr_read
Message-ID: <20200415074619.4ggqdelx3zgaos5v@apples.localdomain>
References: <20200415055140.466900-1-its@irrelevant.dk>
 <20200415055140.466900-7-its@irrelevant.dk>
 <08ae8e87-1bfc-85a2-edac-f704fed4fb3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08ae8e87-1bfc-85a2-edac-f704fed4fb3b@redhat.com>
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

On Apr 15 09:03, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/15/20 7:50 AM, Klaus Jensen wrote:
> > From: Klaus Jensen <k.jensen@samsung.com>
> >=20
> > Pull the controller memory buffer check to its own function. The chec=
k
> > will be used on its own in later patches.
> >=20
> > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> > Acked-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   hw/block/nvme.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 622103c42d0a..02d3dde90842 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -52,14 +52,22 @@
> >   static void nvme_process_sq(void *opaque);
> > +static inline bool nvme_addr_is_cmb(NvmeCtrl *n, hwaddr addr)
>=20
> 'inline' not really necessary here.
>=20

Fixed.


