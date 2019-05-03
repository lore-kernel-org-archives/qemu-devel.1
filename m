Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61895C43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3741520651
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 17:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3741520651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbgu-0002IZ-9v
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 13:09:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfR-0001M6-UQ
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfQ-00035m-QD
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46286 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMbfQ-00034o-JT
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 57E6C1A1E19;
	Fri,  3 May 2019 19:07:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
	[10.10.13.43])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 3456D1A2206;
	Fri,  3 May 2019 19:07:17 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 19:06:49 +0200
Message-Id: <1556903209-6036-6-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v3 5/5] linux-user: Sanitize interp_info and,
 for mips only, init field fp_abi
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
Cc: lvivier@redhat.com, thuth@redhat.com, jcmvbkbc@gmail.com,
	arikalo@wavecomp.com, daniel.santos@pobox.com,
	amarkovic@wavecomp.com, nchen@wavecomp.com, philmd@redhat.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503170649.GxcizIcirfdtAFy-LEbB1GzYuRf15oksa1JeE9dZN9U@z>

From: Daniel Santos <daniel.santos@pobox.com>

Sanitize interp_info structure in load_elf_binary() and, for MIPS only,
init its field fp_abi to MIPS_ABI_FP_UNKNOWN. This fixes appearances of
"Unexpected FPU mode" message in some MIPS use cases. Currently, this
bug is a complete stopper for some MIPS binaries.

In load_elf_binary(), struct image_info interp_info is used without
being properly initialized. One result is that when the ELF's program
header doesn't contain an entry for the ABI flags, then the value of
the struct image_info's fp_abi field is set to whatever happened to
be in stack memory at the time.

Backporting to 4.0 and, if possible, to 3.1 is recommended.

Fixes: https://bugs.launchpad.net/qemu/+bug/1825002

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 linux-user/elfload.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index c1a2602..7f09d57 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2698,6 +2698,11 @@ int load_elf_binary(struct linux_binprm *bprm, str=
uct image_info *info)
     char *elf_interpreter =3D NULL;
     char *scratch;
=20
+    memset(&interp_info, 0, sizeof(interp_info));
+#ifdef TARGET_MIPS
+    interp_info.fp_abi =3D MIPS_ABI_FP_UNKNOWN;
+#endif
+
     info->start_mmap =3D (abi_ulong)ELF_START_MMAP;
=20
     load_elf_image(bprm->filename, bprm->fd, info,
--=20
2.7.4


