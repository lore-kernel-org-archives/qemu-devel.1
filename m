Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276BC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E50020706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdXvDE0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E50020706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRzxy-00026O-Gm
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jRzxC-0001Rf-Mv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jRzxB-0005bW-IR
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:09:22 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1jRzx9-0005Nh-26; Fri, 24 Apr 2020 11:09:20 -0400
Received: by mail-il1-x141.google.com with SMTP id q10so9576576ile.0;
 Fri, 24 Apr 2020 08:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=uSkPVDChwZc8xxyCwwHERfg3imtvy6OvSKH/C59zyPg=;
 b=QdXvDE0PdpQa0Ug6WIDVv3I44GCMxubGTJNph4O9Y6sQMMC6QA1vNJUiIALgkY/nnt
 iC6NQFPOkK58H71MYs8rORCJ+oVjlQz0A5lYQHmvQZWqopPKdBqiIltRP1+TKT9PsSGL
 /IV4J1RwD/+jQo4B5anZJ+mzhH6p3Xa3zOc20QG/7E5ohr5h2if2zhvAuY2vAlFyWvdB
 6zYjb3IArmiNe0ah4SOEIHjoYmbt0Vz9tT+Nsno+SPBkCkXkbsjgGGXlQ0OoU8plUZZa
 rwLJ6F1CSVGoc7FXTZtmC7eNBPO2sZPSlCCTstxVX8G4k18s4vm7LKvlwM2hTihsZD4b
 5CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=uSkPVDChwZc8xxyCwwHERfg3imtvy6OvSKH/C59zyPg=;
 b=lvRgOG6/iZkedOkKsxoRmbnqbqpE9BI9N0962QVzbgYFvusKpCDwkYHQvLeDaznLu9
 MH8q2j7misOKtoYuXJ3WqyION+d1dmkjMH7XFQjjnF9lBmUAfPJilanPYGMQtozB1LEs
 CEMjHCPX5PfSjSkjePZDIunXdDPfby8uTwBvExY2SVjZ7HGObRDfba4DpMQe31LZnrxj
 xNcVAuI4ldKQcT57+HJSpvLP+RlmZRKdvum143JCp/EOJm4B74TI2J37Ut6B3xTP8Cm6
 MEJTeW1e2h75TxkqkGtzlqRoYbFUZ+zJg5cz3owiJyWc6wQsF9bhcph1lXI+OzhJrHkO
 v0Vg==
X-Gm-Message-State: AGi0PuY6FmDaTY6q9O7erXsyf/a5UHhqqhjeikuwEMy1Szoj35jkN6Nm
 /3NQTGpIw6w5+c5bpXpQBb+X+zvKEKxg+iRuiW4DdMHHdvw=
X-Google-Smtp-Source: APiQypLdIGRc1Yep6wQI72lRKBR/RorX+6dMSvKQJDFIUvCm24ZEyYrci3TcPwUfqJpwFi+jTOs3Esx2G68f5BA+OeI=
X-Received: by 2002:a92:985d:: with SMTP id l90mr9346296ili.108.1587740956159; 
 Fri, 24 Apr 2020 08:09:16 -0700 (PDT)
MIME-Version: 1.0
From: Jose Martins <josemartins90@gmail.com>
Date: Fri, 24 Apr 2020 16:09:04 +0100
Message-ID: <CAC41xo2LfTQZnor5haAgBg=h34qv50xf8Bs1bgSeGESfr-E2ng@mail.gmail.com>
Subject: [PATCH] target/riscv: fix check of guest pa top bits
To: qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=josemartins90@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The spec states that on sv39x4 guest physical  "address bits 63:41
must all be zeros, or else a guest-page-fault exception occurs.".
However, the check performed for these top bits of the virtual address
on the second stage is the same as the one performed for virtual
addresses on the first stage except with the 2-bit extension,
effectively creating the same kind of "hole" in the guest's physical
address space. I believe the following patch fixes this issue:

Signed-off-by: Jose Martins <josemartins90@gmail.com>
---
 target/riscv/cpu_helper.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..da879f5656 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -421,15 +421,21 @@ static int get_physical_address(CPURISCVState
*env, hwaddr *physical,
     int va_bits = PGSHIFT + levels * ptidxbits + widened;
     target_ulong mask, masked_msbs;

-    if (TARGET_LONG_BITS > (va_bits - 1)) {
-        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+    if(!first_stage){
+        if ((addr >> va_bits) != 0) {
+            return TRANSLATE_FAIL;
+        }
     } else {
-        mask = 0;
-    }
-    masked_msbs = (addr >> (va_bits - 1)) & mask;
+        if (TARGET_LONG_BITS > (va_bits - 1)) {
+            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+        } else {
+            mask = 0;
+        }
+        masked_msbs = (addr >> (va_bits - 1)) & mask;

-    if (masked_msbs != 0 && masked_msbs != mask) {
-        return TRANSLATE_FAIL;
+        if (masked_msbs != 0 && masked_msbs != mask) {
+            return TRANSLATE_FAIL;
+        }
     }

     int ptshift = (levels - 1) * ptidxbits;
-- 
2.17.1

Jose

