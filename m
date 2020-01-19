Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B4C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1623E20679
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQJ5+DcO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iszdh-0005UY-30
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 20:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iszd0-00053f-HM
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 20:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iszcz-00023a-DI
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 20:43:50 -0500
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iszcz-00022r-8z
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 20:43:49 -0500
Received: by mail-il1-x141.google.com with SMTP id v15so24523664iln.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=zIaSPLmdzuuhDSd0Woflh28eBID3LaclEz0rr9Jlegk=;
 b=BQJ5+DcOwcfkkgd8otQqDQoLovTvoGSh5pVN874LG0/H4X+UgMKp6wo0SLErCXhBdi
 cah2ZXGSHz7STxKc07eAY0y4jnj1wIYi9YmfhSHh9f/kPGl4WSb73dC8R8RhJ49bbEzI
 Z638AEO2b1bPdUieX7U3cyNA5u7N5Od+KXx7GZZU9m8h2iUGJydViwLmEYeaSFi8g6ru
 sfdWFIsC2jjOA0kYW1dIuMO0Zrjpg8SSqostRpd9PEVBryM3xur8iU29NJ2xiaCAEfCq
 ovqRQ+OZ/AQ1FlverpDlkpRbIoCX54eh1rX+OLDn2i6jVFjfung7vIloKPmgDkeBoWkg
 W8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=zIaSPLmdzuuhDSd0Woflh28eBID3LaclEz0rr9Jlegk=;
 b=FxYxiT4YEeV67GkVWqgR6ZrrrOgQIWYSe/WAY7hxfTF9Q1BxdxUXEgmASrS65y9f6J
 ssdWUKgky3koyziJQ9x+8IBRIbXAlNxvHrcht9ggKR0vGVpMBHJXJWxazB++nFPL2x4m
 jQkFaUwghns7x1a0AxFCXEd2L0QIAKWqJWhRWIu+DqCTGyD86UVgzxqtCmYv1KeN69yZ
 IvTtkr2Ep0ZITz9eTgERlHgzG+eawFysJvAlii7vc9Dl0UQgexr5/5PljLRHZFgcn+Gp
 buFiNENJH88ZxAojm02/gI7MnuO6i5JPq46QVWqrGiF0R6GWu4EJXzxmS5x7raktYLfW
 aRrw==
X-Gm-Message-State: APjAAAX4bDgDMUO9bCCE3ifF32FRRrA17BzNTchims3ginSK7CUlG8w7
 gwB99F/gz2zaVsUgSt2VJS+Qh5tUihKMIblMmBjQn2hIwzY=
X-Google-Smtp-Source: APXvYqxAu2Lyg3raNDhItn5x8Xywv+vl4SDUDS5V1p0rqxwvWO3tHdt7ixMkLx/HN6h9fGAedxUx8TaobMqv6wdSNJY=
X-Received: by 2002:a92:2804:: with SMTP id l4mr5125905ilf.136.1579398227101; 
 Sat, 18 Jan 2020 17:43:47 -0800 (PST)
MIME-Version: 1.0
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Sun, 19 Jan 2020 09:43:36 +0800
Message-ID: <CAMAD20k6RJH9S_zjuxq-yopmgs129=JbT3WNKWckZEfy8orSKw@mail.gmail.com>
Subject: [PATCH] riscv: Fix defination of csr operations
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000490ec4059c744e6a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000490ec4059c744e6a
Content-Type: text/plain; charset="UTF-8"

There is a mistake in defining CSR operations for pmpcfg registers.
This patch fixes the bug.

Signed-off-by: Ian Jiang <ianjiang.ict@gmail.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index da02f9f0b1..e07b5267be 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -948,7 +948,7 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SATP] =                { smode, read_satp,        write_satp
   },

     /* Physical Memory Protection */
-    [CSR_PMPCFG0  ... CSR_PMPADDR9] =  { pmp,   read_pmpcfg,  write_pmpcfg
  },
+    [CSR_PMPCFG0  ... CSR_PMPCFG3] =  { pmp,   read_pmpcfg,  write_pmpcfg
  },
     [CSR_PMPADDR0 ... CSR_PMPADDR15] = { pmp,   read_pmpaddr,
write_pmpaddr  },

     /* Performance Counters */
-- 
2.17.1

--000000000000490ec4059c744e6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There is a mistake in defining CSR operations for pmpcfg r=
egisters.<br>This patch fixes the bug.<br><br>Signed-off-by: Ian Jiang &lt;=
<a href=3D"mailto:ianjiang.ict@gmail.com">ianjiang.ict@gmail.com</a>&gt;<br=
>---<br>=C2=A0target/riscv/csr.c | 2 +-<br>=C2=A01 file changed, 1 insertio=
n(+), 1 deletion(-)<br><br>diff --git a/target/riscv/csr.c b/target/riscv/c=
sr.c<br>index da02f9f0b1..e07b5267be 100644<br>--- a/target/riscv/csr.c<br>=
+++ b/target/riscv/csr.c<br>@@ -948,7 +948,7 @@ static riscv_csr_operations=
 csr_ops[CSR_TABLE_SIZE] =3D {<br>=C2=A0 =C2=A0 =C2=A0[CSR_SATP] =3D =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ smode, read_satp, =C2=A0=
 =C2=A0 =C2=A0 =C2=A0write_satp =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>=C2=A0<br>=
=C2=A0 =C2=A0 =C2=A0/* Physical Memory Protection */<br>- =C2=A0 =C2=A0[CSR=
_PMPCFG0 =C2=A0... CSR_PMPADDR9] =3D =C2=A0{ pmp, =C2=A0 read_pmpcfg, =C2=
=A0write_pmpcfg =C2=A0 },<br>+ =C2=A0 =C2=A0[CSR_PMPCFG0 =C2=A0... CSR_PMPC=
FG3] =3D =C2=A0{ pmp, =C2=A0 read_pmpcfg, =C2=A0write_pmpcfg =C2=A0 },<br>=
=C2=A0 =C2=A0 =C2=A0[CSR_PMPADDR0 ... CSR_PMPADDR15] =3D { pmp, =C2=A0 read=
_pmpaddr, write_pmpaddr =C2=A0},<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0/* Perfor=
mance Counters */<br>-- <br>2.17.1<br><div><div dir=3D"ltr" class=3D"gmail_=
signature" data-smartmail=3D"gmail_signature"><br></div></div></div>

--000000000000490ec4059c744e6a--

