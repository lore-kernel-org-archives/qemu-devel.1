Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF24C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F02207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 11:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJ1TRdDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F02207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYSt1-0007Un-R9
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 07:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYSrj-0006x0-Oy
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYSrd-0004qH-10
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 07:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604058395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5OI3821fEgkdaY6fcjb5AgC+SPI+lQhFQ77dmiiO88=;
 b=IJ1TRdDnZo9UsuxDETr6/4+e+3EYAYiIpVpMy14JSA9XAXTaHn9xVsUTlXoH/nCYiXfUfp
 MIqtIJ/9iovIw+cakWYSO8qVKS0mESi8MU0KSdQcclzKpd3cEqUtsg8xgc5s1cpeYAw9Yx
 rXGLvvgZMZOKxK/W1TSuw6zaFnHtPXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-LVe0h5_rO0maADrX_5cJ5g-1; Fri, 30 Oct 2020 07:46:33 -0400
X-MC-Unique: LVe0h5_rO0maADrX_5cJ5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80F1F56C8F;
 Fri, 30 Oct 2020 11:46:31 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7706EF62;
 Fri, 30 Oct 2020 11:46:27 +0000 (UTC)
Date: Fri, 30 Oct 2020 11:46:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
Message-ID: <20201030114626.GH307361@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
 <20201028151633.GH231368@stefanha-x1.localdomain>
 <d2e9983d-066d-e721-55ca-5d7cdbf35dbc@redhat.com>
 <43f09633-dfc6-289a-f138-32e32afd69de@redhat.com>
MIME-Version: 1.0
In-Reply-To: <43f09633-dfc6-289a-f138-32e32afd69de@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 02:24:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cW+P/jduATWpL925
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 10:02:37AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 10/28/20 7:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 10/28/20 4:16 PM, Stefan Hajnoczi wrote:
> >> On Tue, Oct 27, 2020 at 02:55:35PM +0100, Philippe Mathieu-Daud=C3=A9 =
wrote:
> >>> Rename Submission Queue flags with 'Sq' and introduce
> >>> Completion Queue flag definitions.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> ---
> >>>  include/block/nvme.h | 17 +++++++++++------
> >>>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/include/block/nvme.h b/include/block/nvme.h
> >>> index 65e68a82c89..079f884a2d3 100644
> >>> --- a/include/block/nvme.h
> >>> +++ b/include/block/nvme.h
> >>> @@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
> >>>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
> >>>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
> >>> =20
> >>> +enum NvmeFlagsCq {
> >>> +    NVME_CQ_PC          =3D 1,
> >>> +    NVME_CQ_IEN         =3D 2,
> >>> +};
> >>> +
> >>>  typedef struct QEMU_PACKED NvmeCreateSq {
> >>>      uint8_t     opcode;
> >>>      uint8_t     flags;
> >>> @@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
> >>>  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
> >>>  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
> >>> =20
> >>> -enum NvmeQueueFlags {
> >>> -    NVME_Q_PC           =3D 1,
> >>> -    NVME_Q_PRIO_URGENT  =3D 0,
> >>> -    NVME_Q_PRIO_HIGH    =3D 1,
> >>> -    NVME_Q_PRIO_NORMAL  =3D 2,
> >>> -    NVME_Q_PRIO_LOW     =3D 3,
> >>> +enum NvmeFlagsSq {
> >>> +    NVME_SQ_PC          =3D 1,
> >>> +    NVME_SQ_PRIO_URGENT =3D 0,
> >>> +    NVME_SQ_PRIO_HIGH   =3D 1,
> >>> +    NVME_SQ_PRIO_NORMAL =3D 2,
> >>> +    NVME_SQ_PRIO_LOW    =3D 3,
> >>>  };
> >>
> >> There is also:
> >>
> >>   #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
> >>   #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
> >>
> >> These macros should use the new constants.
>=20
> SQ_PC is bit#0, NVME_SQ_PC is "bit SQ_PC set (PC enabled)",
> SQ_PRIO are bits #1-2 (shift by 1, mask 2 bits),
> NVME_SQ_PRIO_xxx is the enum of these 2 bits.
>=20
> The NVME_SQ_FLAGS_X() macros extract the flags.
>=20
> So the macros can not use the new constants.

I'm not sure I understand. Does this mean the header only defines the
flag values but not the bit shift constants?

It seems like hw/block/nvme.c and block/nvme.c are expressing flags in
slightly different approaches. Can they be unified instead of
introducing hw/block/nvme.c- and block/nvme.c-only constants in the
shared header file?

Stefan

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+b/RIACgkQnKSrs4Gr
c8hF/QgAnGXwkCrxV6azUsay1Cl6jv+iGSPevhzSuitnIpqFYBvDcLKx2zL9qpol
ZFu41pjUeD/LoWMLLtG1snOW3f1kY8t4wMbEO6ROPSjDXGF9rAmFr9wESmch8U/c
qLleCGkvRgI2z3E/fRbYhheBwZvFdZPZ57Vy67mIWcIqRgQynWQnTUQB4tW6gmpK
EWfuU6nLhGNtJBuNK1SuecAvlbKXRwH6GHbSJgfKSoN2BKHANRzfYJNq9zeEPEVd
+LO+kxTaRjWC9FGADLHDnZeIs1bhAaxHpor6I774WYPa21reFq1PHwygFSiPGlGu
s2Sdr5uu8gF5rkhfc8kkQrfjk7Mexw==
=7nHx
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--


