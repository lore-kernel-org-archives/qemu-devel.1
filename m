Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E626C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A4C20890
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tuta.io header.i=@tuta.io header.b="sbfPxdIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A4C20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tuta.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9n1P-0003Jt-2e
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36401)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <diodesign@tuta.io>) id 1i9mzk-0001wV-06
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <diodesign@tuta.io>) id 1i9mzi-0000T5-7n
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:08:27 -0400
Received: from w4.tutanota.de ([81.3.6.165]:50038)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <diodesign@tuta.io>)
 id 1i9mzh-0000S7-I6; Mon, 16 Sep 2019 05:08:26 -0400
Received: from w2.tutanota.de (unknown [192.168.1.163])
 by w4.tutanota.de (Postfix) with ESMTP id 2C8E310601EF;
 Mon, 16 Sep 2019 09:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1568624903; 
 s=s1; d=tuta.io;
 h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=7JWpvMXnZewMxf5Vz8XxSkXYIp99BfTkq6W8838Sal4=;
 b=sbfPxdIcSuKS06DqcRlVljiZm9iBJiPOBANJ2sRK0ZkSFw0jzfWK5etuySGw4hHG
 U/Xqiu3YWRYyi06FsIfbTUauJWJFMBmQn8/26GFkIiqk+WysCeoFHqvEKHG7UXr5xdo
 nzs7v3ZtReFo5Wj+P/G0OTtugt43/7ZRurKn4PqVEamHCiGJMlViWqixR1w+qn3WOQX
 0SRp6BqGhOOS0tLT20XDWJzuE/8is2C5/L1idBtCoPJkp5ik/+Dvr+2vX0jStX/xXad
 TvX81HnS/FcwdBq2wo19VCznXVCmMaYKxvS7qUnjyeUqiTjdSTRKxDz4ZAe33WoG7C2
 emWTP/SetQ==
Date: Mon, 16 Sep 2019 11:08:23 +0200 (CEST)
From: Chris Williams <diodesign@tuta.io>
To: Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <LotC_Mg--3-1@tuta.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 81.3.6.165
Subject: [Qemu-devel] [PATCH v1 1/1] riscv: pmp: Allow valid instruction
 fetches at the start of a PMP range
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow Qemu guest code to execute from the very start of a PMP range without=
 faulting.

When an instruction is fetched from the first word of a PMP range,=C2=A0pmp=
_hart_has_privs()
is called with a size of zero. This causes pmp_is_in_range() to be called w=
ith an address
lower than addr, when obtaining a value for e, and a fault is incorrectly g=
enerated.

This fault was observed by creating a PMP range with RWX access, filling th=
e range with
valid code from its base address, and then jumping to the first instruction=
 at the base address.
Qemu generates an instruction access fault: the correct behavior is to allo=
w the instruction fetch.

This patch checks a size is non-zero before applying a calculation operatio=
n that would bring it
below addr, and thus erroneously raise a fault.

Signed-off-by: Chris Williams <diodesign@tuta.io <mailto:diodesign@tuta.io>=
>
---
target/riscv/pmp.c | 6 ++++--
1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 958c7502a0..06f2cd52f0 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -242,10 +242,12 @@ bool pmp_hart_has_privs(CPURISCVState *env, target_ul=
ong addr,
=C2=A0=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0=C2=A0 /* 1.10 draft priv spec states there is an implici=
t order
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from low to high */
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from low to high. Also, c=
atch attempts to check a request
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size of zero, and ensure =
it does not accidentally fail by
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checking for an address *=
below* addr */
=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < MAX_RISCV_PMPS; i++) {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D pmp_is_in_range(env,=
 i, addr);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e =3D pmp_is_in_range(env, i, a=
ddr + size - 1);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e =3D pmp_is_in_range(env, i, (=
size =3D=3D 0) ? addr : addr + size - 1);

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* partially inside */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((s + e) =3D=3D 1) {
--
2.20.1


