Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC7BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C827C20578
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/3POFqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C827C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aqH-0007vv-16
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apM-0006dL-2x
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apI-0005GQ-44
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apH-0005GC-UM
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:44 -0500
Received: by mail-wm1-x32d.google.com with SMTP id a9so3276393wmj.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vZTPlHR8mq3OwOYR6l43zxathKAQyqG0FYbXCshk6J4=;
 b=Z/3POFqVqkDwutjXFMDFZqtO2SQ1a7fSQtn0yyQSw2WKpkEataB9QeJymxVIre3FqU
 JSufsQZefWgUSWT975NRzrZ9PbfPSglgBV9eiFe08yZ57Hi3axmktvWZSTAFiaAhLl6U
 vnrBsJTtkY9jyx5HQB9enFRiaSSG/4F3LSmDv9Toe1jmJD6Sph0kYdAzFf0AVmEUEbKH
 ZXOn/86inFEGgf9O2D5+Nn470ewwtrMIcBTcl6g36gaBaVkB/8iwwbdj86suxCL5p2Dm
 EMRu98W6E36WdJeFwCXbyoO9XM3uF/WP9oVNJWTpXyZzqa6iraxIxkW1A4UT0G8qw5Tf
 ZLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vZTPlHR8mq3OwOYR6l43zxathKAQyqG0FYbXCshk6J4=;
 b=FJApJeXv9ISDcZY5q+GbeJvcv0dVNn8YW0m06TAA5X360xu5wiwkBMoCUFr+pP8ESM
 2471jR4OcWnSeIks/OjrxBu0A+qGymLuolW5Bv6HA93rjE/GGfvNbQ0VUmokDn8c8QiL
 HR7lRBAqzjZyhrtEarTU165Dvq7+7jBDI9xc73AdISV31P4gCxVY7HCtkXHFVeQ5bQQM
 x1TL8U0m1ievDG6to2QO3YCqvDO41d6DDnI9sWa0FB7PZGB7hQN6KkGNG/NQjcoEMoLi
 dOBPRgtstHQFPugRNqplnNav9DgeTleUMVQ67smfNF48foOobL1/UVPvBECsDCaZ6It1
 zcUA==
X-Gm-Message-State: APjAAAXX36UaPS7qLHrAzZzvRk71FmC21HA0ZNw7ftV/jYNulIkEHROp
 z84Yowt7x9Oyvo9yM2Oj4XObx/f+w8rsfA==
X-Google-Smtp-Source: APXvYqysEvs3G457ycrw59VlVrisMA8rb1Lkd0E0xAk/BT9yn7egokJoaT44iZjwx834IQ5zHNIpaw==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr5558615wmj.33.1582639482655; 
 Tue, 25 Feb 2020 06:04:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
Date: Tue, 25 Feb 2020 14:04:26 +0000
Message-Id: <20200225140437.20609-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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


