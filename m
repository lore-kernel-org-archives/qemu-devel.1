Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3499CC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CA820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bk170GMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CA820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlAY-0007Xx-5F
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl07-0006om-7H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl05-0006oQ-Ap
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl03-0006Ok-DN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id g1so875613wmh.4
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GQ9AbUdIDLadhdpxHBQc+3BZwH1J8H9FJUw/8rdNkPs=;
 b=Bk170GMuSYlv35NSWPLEMgRLEvUmRHa6JdLzzOElNDAAejvOmCeDkhUL3Esh0UzSpM
 +hgy/ymKb+PYUSeKkg0fZOxb28yYrtTLK4ecDj33BqLDWN4CGmPVFuZqu+h5wgSXkkNw
 fkDWmS+1EvYh2JjwBWs93hPB5mVn7GCVqUr5O56CToxytiNZgNUZbGD7kg5TZG2bLKHf
 71USd3Arx71gKHjv0xow8PpP5n8tpmuIiP2dXd2/S0LxWK73rm+xVwitG8U4jcx4gnqC
 1ttbWqHCCs6grO6sw09n9CV/sVSAXuNQZJblD60dWaj/HstvGv6kbgifzgi6zVocUN81
 9yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GQ9AbUdIDLadhdpxHBQc+3BZwH1J8H9FJUw/8rdNkPs=;
 b=rU5OXLazu7Y6CTAZtq+Bx1j76BAAGV8C4ImGxzVRizSKB5S93ID7/MtNxReJEu5NQa
 nBCdZnj8StJSZIFMqfCrvgW9Ykjm3qDOpC2jRkdlieGMriJg5jm4prs95nQk+blm9u1L
 eApFP+i6t4ZNLlF3l8L66fozzTwWOFMgfKIREFXYLpW/DNVtWy5cYOXpeFQYxSDhkPCz
 0qhjQkJKkCuUOu5qlWYboLN0ZQY5NW2JYAV1civy2xBSQmROLkNiLk/1LZU3ABg09Mbf
 Fgtv7JOcmm/zxhW8u5HQUB2TrYV2SID1n2bPA2KZbpS4GnfyC1ziCGfja21HU6/VniFM
 HMlA==
X-Gm-Message-State: APjAAAUlvRcdjMT0LnQmZDxxqRlKMhVHqMmgMoDLlBV0yu7IJwaMF/jy
 4RKp/pM41b1yA07UCEnS1YpNo2PbgBE=
X-Google-Smtp-Source: APXvYqzIkTfW5ADy4tvL32jtSYXzuvzMlcMp6PP2FIhslvWcdevCdzd9mmcfT6QZzpVoSVxS9mmrqg==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr5693077wmi.21.1581010289242; 
 Thu, 06 Feb 2020 09:31:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/29] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
Date: Thu,  6 Feb 2020 17:30:30 +0000
Message-Id: <20200206173040.17337-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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


