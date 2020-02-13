Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E94C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFF8206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNwgKhRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFF8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Isb-0005BV-Jf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijq-0000jK-9b
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijo-00030L-0D
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:22 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:37908)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijn-0002wC-Ne
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:19 -0500
Received: by mail-wr1-x42c.google.com with SMTP id y17so7808681wrh.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GQ9AbUdIDLadhdpxHBQc+3BZwH1J8H9FJUw/8rdNkPs=;
 b=jNwgKhRqyCA3zE80oMKZTPOsJ37c/lWiGko1dSItkeShzU46B5ZDYvlKdKet0QZkXn
 YcwC8sKJvWWajE2aN6780XUrmVxcSwgEAGcAfGa6hW1R/G69hpVpA4AA9gYUM0lYEy+W
 qZMXzKxJgBEBFhm1PawPDaRv/RyxVffES+bf4qpwvC1Ieu8ik0PrY1GXf4sW3Oi4vRfs
 VG9q8uziKfS4VnlBIbrYt4jbhnHIfGwPSISt0uH9wTlgeQP70CmffknoRphKMfepqHbt
 uc9/4NtDCkpfxtsAwjSZfJZm1CSCxrW57EoTdsR2tvL5Vmee18kgzZNlVklPnM3xWr7A
 pxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GQ9AbUdIDLadhdpxHBQc+3BZwH1J8H9FJUw/8rdNkPs=;
 b=qLIQ/Sv0ClRI12mHA/5a/TgiJ88G9CRxnimeSdfTRRQChMNHcpdp2gW6jkjF9ZHGyj
 4UbQ4qs876I+r0GJfG39CWKjhzyxazdeiW+ekPLHJUwtNPqQPSd52Hbsojdoptb+s/Eo
 lE47wK8TEFR2+M9qCNW8v+Eis7wU46w3ur4hP0ve9ehLyhoDZ53XETdOplJzggROpWaX
 41R6vsrmxm69GYsL3d8pbm/ALI5TT9dppQpiYJJetXwboX4XF+2bEEAbQ4zswDXll8MR
 HMjJD+PgzZ1C6AtF4H8avkTJ1k2OXzBzn6RJTz1bxyetyISKOjZZe1snynxE/hrttQlU
 26VQ==
X-Gm-Message-State: APjAAAUPRZqbrL9xsykhUsG4thQREbQFKGgiJ3N2C2d4vY4wVgl5ZSGj
 5cpCH53nLGAU/Uug/l3mlW1YBPXHpbA=
X-Google-Smtp-Source: APXvYqy5TOuk0xFAv2U8doIHdlfLceZJ6+rAT71ldzia1zDzHrhT96jydTH6js58pPujcTli0+il7g==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr22423373wrq.125.1581616637009; 
 Thu, 13 Feb 2020 09:57:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/30] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
Date: Thu, 13 Feb 2020 17:56:36 +0000
Message-Id: <20200213175647.17628-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Our current QAPI doc-comment markup allows section headers
(introduced with a leading '=' or '==') anywhere in any documentation
comment.  This works for texinfo because the texi generator simply
prints a texinfo heading directive at that point in the output
stream.  For rST generation, since we're assembling a tree of
docutils nodes, this is awkward because a new section implies
starting a new section node at the top level of the tree and
generating text into there.

New section headings in the middle of the documentation of a command
or event would be pretty nonsensical, and in fact we only ever output
new headings using 'freeform' doc comment blocks whose only content
is the single line of the heading, with two exceptions, which are in
the introductory freeform-doc-block at the top of
qapi/qapi-schema.json.

Split that doc-comment up so that the heading lines are in their own
doc-comment.  This will allow us to tighten the specification to
insist that heading lines are always standalone, rather than
requiring the rST document generator to look at every line in a doc
comment block and handle headings in odd places.

This change makes no difference to the generated texi.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/qapi-schema.json | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 9751b11f8f1..f7ba60a5d0b 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -1,7 +1,9 @@
 # -*- Mode: Python -*-
 ##
 # = Introduction
-#
+##
+
+##
 # This document describes all commands currently supported by QMP.
 #
 # Most of the time their usage is exactly the same as in the user Monitor, this
@@ -25,9 +27,13 @@
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
-#
+##
+
+##
 # = Stability Considerations
-#
+##
+
+##
 # The current QMP command set (described in this file) may be useful for a
 # number of use cases, however it's limited and several commands have bad
 # defined semantics, specially with regard to command completion.
-- 
2.20.1


