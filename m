Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E45C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 412A620709
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 16:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8Upu9Im"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 412A620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2Gs-0005hf-Bw
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 11:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iv2G2-0003vZ-9o
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iv2G1-000362-9z
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:34 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iv2G1-00035Z-4u
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 11:56:33 -0500
Received: by mail-pf1-x443.google.com with SMTP id q8so1395774pfh.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=WJEd3YfXjo1+GH81ylCClGb6F9dkMQFDTXt8V62PTH0=;
 b=B8Upu9ImBNxuthR0WIU+ChO581OZZ9jYelqOfnmIphEBewFzsneWArREzFHYDFnZBr
 M6ZHQlv03vXxkm9nl3D3BYZ8Dx+aMPm/SppzQCTES3M5ycP2JX+8VxRIQXTvKN3JLHDL
 e1KPCqwKhLqsm8LvjziG65PcImQ5hIZKNny87NZStwcRvP/kVhYf4CrTjLGoKmRN3wOb
 nO6zkdIgX+T7m1YYBUdh0unMsbC4MhcyGecy9eEib0wW2AGq0GsLVXT2FZ0NQU7+bLoV
 fqPRHxzBoESnvcHPExx5f1JYSGOu2Zr12iITNJdErACL4EcY87QcsCShlPhrQJxFn+BM
 aQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=WJEd3YfXjo1+GH81ylCClGb6F9dkMQFDTXt8V62PTH0=;
 b=lvy/OXIOUrWg3bdBpIOAiwkz4SFizrjLEkQER7Dw55DCV50jNru9LhP6cOIhUrRwcL
 5HRl+2C051Neo/qQ4ujaJXaRcUI8Hz06sH4uoQQYRowxynGcdpjy2H7AksV+hZGJFByF
 dGbpltREFIpRt5t5ylXfjHnfrg264Y8Q9E3bY81Id+MWCUwNny1pBHBjDX2oDpq7ZfkA
 zKyaX0lDCsHYPLrQCiXvL8yyktqz/YcbGQc922TmkbzEgOJkq9PCduWJUIj7d2G/rJ6V
 SoWCBIZO0enZhwBZNkRzECGAQouy+GnYry76dmP6qFJDUfzpWvfoRxnSEH155gZu/Vx/
 pOOQ==
X-Gm-Message-State: APjAAAU9hbkhCEZCN/+qbz+qYQU8neTqHRF+GCvyuh1noD+2wwwI4FGq
 OYfgPuqXcVNmuzDR7tInY7SDXVVB30Y=
X-Google-Smtp-Source: APXvYqxeTcgQw+4IQ7Dfd5nDgG24UfbC583HwwRSRca7JnW3qNUENYTKgL/0u76dD8zCzbBvKGS4kA==
X-Received: by 2002:a65:4109:: with SMTP id w9mr4980904pgp.383.1579884991898; 
 Fri, 24 Jan 2020 08:56:31 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id l10sm6969953pjy.5.2020.01.24.08.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:56:31 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] tests/vm: add --boot-console switch
Date: Fri, 24 Jan 2020 11:53:33 -0500
Message-Id: <20200124165335.422-7-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124165335.422-1-robert.foley@linaro.org>
References: <20200124165335.422-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: fam@euphon.net, philmd@redhat.com, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added ability to view console during boot via
--boot-console switch.  This helps debug issues that occur
during the boot sequence.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/basevm.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 08a8989ac0..aa8b39beb7 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -489,6 +489,8 @@ def parse_args(vmcls):
     parser.add_option("--config", "-c", default=None,
                       help="Provide config yaml for configuration. "\
                            "See config_example.yaml for example.")
+    parser.add_option("--boot-console", action="store_true",
+                      help="Show console during boot. ")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
@@ -523,6 +525,10 @@ def main(vmcls, config=None):
         if args.snapshot:
             img += ",snapshot=on"
         vm.boot(img)
+        wait_boot = getattr(vm, "wait_boot", None)
+        if args.boot_console and callable(wait_boot):
+            vm.console_init()
+            wait_boot()
         vm.wait_ssh()
     except Exception as e:
         if isinstance(e, SystemExit) and e.code == 0:
-- 
2.17.1


