Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20F2C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCCA20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yV3O4T38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCCA20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKcD-0005Im-VK
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40284)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZi-0001mb-3q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZg-0001L0-Af
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZg-0001Kf-3r
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id m9so2818157wro.12
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vZTPlHR8mq3OwOYR6l43zxathKAQyqG0FYbXCshk6J4=;
 b=yV3O4T38GJ296jT2XsShcbCdHk899fUEXMWo7FekklplR/ot3/eE5vvlZYnIEueKlF
 wlZ0xwzOXlUKJPPyMpJoFtVMjru1KU8ZsglbnhpOeeJN6fg5mlBQGVY1X9H7F+eZOS2h
 hqF85/bGL4lYz4NAyEE00R1x5lHtAo85WC9rbULY1oVCR8liy67Q6xPqj9Vn0Vmez0BV
 dZpv31XXdMl4g8ylnf9r3MTIgD+pYAemW+GYXIDYOD48fGk6vH44C8ueLyDqScvtxAag
 eSAMAVu/BQIgdWl40LMkWCl8eNhOvfxDfE9tNwoszyFt0Hf/uA93iYGcliT8bl8ECdVq
 WAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vZTPlHR8mq3OwOYR6l43zxathKAQyqG0FYbXCshk6J4=;
 b=CqdTG7uMcNQySydkWhOv3x0zroYNPfPwVjE/4Tv2R6MA/K+Yu/4Rxl+Lvr0hjQjyk+
 aKwQqkUWCXAgIA63fdg05efMCB3vAm+z4/aMRAHL0xZOvb4UFqqYM/ENmlWniSSK7cUP
 A2h2Ae2+MBQQJ8reDycpU4OZ62T67g801auDoolIy4I3D4nT5uCY9fCmjM2FFRNcfYdB
 UsEWgAOTmdANkWHQKGYgJPovqUfmhIHoVCPTh9tnAMNQScI+5EOD6sMa4yGK9KAUqaI1
 eX3cfYot6UtFwT4/X1P35M8ZzzXCim1YzUj0Tm4xd/nj0ekWiCzxsrvynevelt4bhAVl
 dJsg==
X-Gm-Message-State: ANhLgQ3hOiHnHciv+uqCyHj8TiecqLAK1x33blHjFP2frJog+vVn8Me3
 aeiYZGhauMK+e5SU6YxupWNAynNuio653A==
X-Google-Smtp-Source: ADFU+vs+VjQHFDewRRTG/ppdbFhr7bwujgyvlvI/Np0Mph7oCfEEhb3ZWnQ7xYhiBr1Inff3RSC6JA==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr7287227wru.204.1583768650824; 
 Mon, 09 Mar 2020 08:44:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/18] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
Date: Mon,  9 Mar 2020 15:43:49 +0000
Message-Id: <20200309154405.13548-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
index fe980ce4370..ff5aea59451 100644
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


