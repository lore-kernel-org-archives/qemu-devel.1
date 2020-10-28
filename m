Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8271DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD582247B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StHkXomd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD582247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmzg-0002yq-De
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXmyT-0002AP-5c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXmyR-0004Fv-1H
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsHoFwCYMhqfouYd4VKOLPz33HrcuF0yHYd+KDlL1Ag=;
 b=StHkXomdvKKAP7DIgkOVWzTYjKtoEtBZPoPDL0KXiQOye6X0DnK3uVci14usQYBcpu+/Al
 KeWy7fKaqikLfQe11j0DHZ+E355XTu+WSqa+2Tkqtt5Z47i4mMxuW8W8nl9o4yudbn6KyW
 gg/8pMehc/IXMCTON7y7Zw1crcnfhdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ncZ-9MAoOOCVNFOluJTtaA-1; Wed, 28 Oct 2020 11:02:45 -0400
X-MC-Unique: ncZ-9MAoOOCVNFOluJTtaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A15E18B9F2C;
 Wed, 28 Oct 2020 15:02:11 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD6BA610F3;
 Wed, 28 Oct 2020 15:02:10 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:02:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 08/25] block/nvme: Simplify device reset
Message-ID: <20201028150209.GD231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-9-philmd@redhat.com>
 <20201027145831.GC1942271@dhcp-10-100-145-180.wdc.com>
 <1bb84312-1c78-7e1a-058b-4ff6330076b1@redhat.com>
 <20201027165534.GA1942297@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
In-Reply-To: <20201027165534.GA1942297@dhcp-10-100-145-180.wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 09:55:34AM -0700, Keith Busch wrote:
> On Tue, Oct 27, 2020 at 04:53:31PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > On 10/27/20 3:58 PM, Keith Busch wrote:
> > > On Tue, Oct 27, 2020 at 02:55:30PM +0100, Philippe Mathieu-Daud=E9 wr=
ote:
> > >> Avoid multiple endianess conversion by using device endianess.
> > >>
> > >> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > >> ---
> > >>  block/nvme.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/block/nvme.c b/block/nvme.c
> > >> index e95d59d3126..be14350f959 100644
> > >> --- a/block/nvme.c
> > >> +++ b/block/nvme.c
> > >> @@ -755,7 +755,7 @@ static int nvme_init(BlockDriverState *bs, const=
 char *device, int namespace,
> > >>      timeout_ms =3D MIN(500 * NVME_CAP_TO(cap), 30000);
> > >> =20
> > >>      /* Reset device to get a clean state. */
> > >> -    regs->cc =3D cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
> > >> +    regs->cc &=3D const_le32(0xFE);
> > >=20
> > > This doesn't look right. The 'regs' is an MMIO address, correct? Memo=
ry
> > > mappings use the CPU native access.
> >=20
> > cc is little-endian uint32_t.
>=20
> Well, yes and no. PCI is defined as a little endian transport, so all
> CPUs have to automatically convert from their native format when
> accessing memory mapped addresses over that transport, so you always use
> the arch native format from the host software.
>=20
> This isn't just for CC. This includes all memory mapped registers, so
> this driver's CSTS, AQA, doorbells, etc... shouldn't have any endian
> swapping.
>=20
> See also: every other nvme driver. :)

I don't see the opposite in Linux. The Linux NVMe drivers use byteswap
instructions because readl()/writel() and friends perform little-endian
memory accesses, not native endian memory accesses:

  static int nvme_pci_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
  {
  =09writel(val, to_nvme_dev(ctrl)->bar + off);
  =09return 0;
  }

arch/arm/include/asm/io.h:

  #define writel(v,c)     ({ __iowmb(); writel_relaxed(v,c); })

where the byteswap happens here:

  #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)

The CPU is using explicit byteswaps, which matches what the QEMU driver
is doing. Am I missing something?

Stefan

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Zh/EACgkQnKSrs4Gr
c8iKXgf9FA2PAdMUEC887tycwK4iALRUJazf93MboyUIz3C1/tNeNPpOemcjDSbK
S9JpUF9TpT4QkyziQw52w9iv7TxWckNFu53hEoubmn6S+EVdpjB9eFSlXheFd9Q+
byQGn2AFXd44t3mVGOIaWgNKht1nK3DVGWL11HlD4UI4mjre3zBf9MAfm7dRVaRC
EHjLW2WDRf4OOHLuSZBeSS3f+zFWqFOySy2cdevGUCnhn2sknk1HkiitgHehqWbW
XRdQ1R4Bm7iAQavlVjCohMGLjLM3CY37sWcURTQnaxSCo0/ezZMsaFGKytPGo18l
UX8qlhwcj/Fk81b6StyRWpNyKS6B9Q==
=ZmTO
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--


