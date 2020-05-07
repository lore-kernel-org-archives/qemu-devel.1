Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D345C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F912073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 10:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRpAFKxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F912073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWdPJ-0007kq-DA
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 06:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWdOW-00078l-KP
 for qemu-devel@nongnu.org; Thu, 07 May 2020 06:04:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jWdOU-0000dt-UC
 for qemu-devel@nongnu.org; Thu, 07 May 2020 06:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588845881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AH4Cq3ucUXBU0NvfNdv7US8ZgTmbTPXmaTdPNESvwmw=;
 b=aRpAFKxcDvqZNDj6avAyFhCdjmmGKhxzZRXcn5W8wzBqtGJS4WIhkxsEdMtw5Eb9mrnFsk
 iU3IJbRSr5B4bCRmfM7Ev94pNy/QDdw817eyfcS9ci4cEfazgU2GVZt3e1+JshF2a/CbVb
 cYu529QpD+z4l4t/0zGbqIaIiFJ0dIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235--X0SOShpNIyl8oBmUn_hhw-1; Thu, 07 May 2020 06:04:38 -0400
X-MC-Unique: -X0SOShpNIyl8oBmUn_hhw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6CBA80183C;
 Thu,  7 May 2020 10:04:36 +0000 (UTC)
Received: from localhost (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A15B2E045;
 Thu,  7 May 2020 10:04:36 +0000 (UTC)
Date: Thu, 7 May 2020 11:04:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH 6/6] hw/block/nvme: Make device target agnostic
Message-ID: <20200507100435.GG34079@stefanha-x1.localdomain>
References: <20200504094641.4963-1-philmd@redhat.com>
 <20200504094641.4963-7-philmd@redhat.com>
 <9a46b1b4-bfbf-21bd-cc66-5904e784150c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9a46b1b4-bfbf-21bd-cc66-5904e784150c@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 00:55:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 05:36:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> +Keith new email
>=20
> On 5/4/20 11:46 AM, Philippe Mathieu-Daud=E9 wrote:
> > The NVMe device should not use target specific API.
> > Use memory_region_do_writeback() (which was introduced
> > in commit 61c490e25e0, after the NVMe emulated device
> > was added) to replace qemu_ram_writeback().
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > ---
> > RFC because I have no clue how dirty_log_mask works.
> >=20
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >   hw/block/nvme.c        | 4 +---
> >   hw/block/Makefile.objs | 2 +-
> >   2 files changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 9b453423cf..9b0ac0ea2a 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -46,7 +46,6 @@
> >   #include "qapi/visitor.h"
> >   #include "sysemu/hostmem.h"
> >   #include "sysemu/block-backend.h"
> > -#include "exec/ram_addr.h"
> >   #include "qemu/log.h"
> >   #include "qemu/module.h"
> > @@ -1207,8 +1206,7 @@ static uint64_t nvme_mmio_read(void *opaque, hwad=
dr addr, unsigned size)
> >            */
> >           if (addr =3D=3D 0xE08 &&
> >               (NVME_PMRCAP_PMRWBM(n->bar.pmrcap) & 0x02)) {
> > -            qemu_ram_writeback(n->pmrdev->mr.ram_block,
> > -                               0, n->pmrdev->size);
> > +            memory_region_do_writeback(&n->pmrdev->mr, 0, n->pmrdev->s=
ize);

qemu_ram_write() is being called because we need to msync or persist
pmem here.

The memory_region_do_writeback() API is not equivalent, its purpose is
for dirty write logging (which we don't care about here because the
writes themselves will already have been logged when the guest performed
them).

I think qemu_ram_writeback() should just be made common so that this
code isn't target-specific. Maybe it should be renamed to
qemu_ram_msync() to avoid confusion with dirty write APIs.

Stefan

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6z3TIACgkQnKSrs4Gr
c8gsUAgAmZJidN1CrvDcZlFx4kA8iLAPmpWwblrdJuAs/tp7LNRs/zmmw8U6rojj
aj61orNP4isE+k55hsa2xw+CYFbx4kROAFE9pTzPKlT4bVNZ5awIESba0l8oo6Kq
emExhKbDGnP2hmmRfBOtS3Jl5jAYbdV4yL5zVmKvOOCjyRzVLOz5gFbPReGYBqpH
UyaM8BCUnb1ndDwQnW6ioytxhPXofCOmUAsXShoEd7e/BE1c9u7gJ+/0Ni8X6SAv
fXy/JwL6HKlvBMNv79f4erpSq3AIXDxeoJr//ibPKikz8aHD0CdaY2pyA8C43jIK
exinCf2Z+H+AFeGWTEe0KQKE2LpGuQ==
=L9ib
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--


