Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CFBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF29206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ILhYsBqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF29206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqis-00067F-5G
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVT-0006ja-Tb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:36 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVS-0006pJ-8t
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:35 -0400
Received: by mail-wr1-x441.google.com with SMTP id z1so4249287wrt.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2fo9KhPCNYW+F0sc33/RwPCGaMMzyxHJl2mjQCHcWVQ=;
 b=ILhYsBqm/G3LakPho1BoLo9PHmXUYJUJBYE5V0pHW3b7W/Rb56wkyFLqjKsLF2GjJt
 oE/UFSqvdVbwCuDhSDzdWidtPWR+CZOY84TAM+js+LOItPPgIvw/SWU8KRnGsjyc8px9
 uhYgtAn6ObsG5SQl960Yssa9cCUKGG42N1ejJHXubtErLhCUsEf0ivvkBYbvjuX8rZ5l
 Wklg8xRVkGql/x8gQPPBBQC6oDH9kWYFI4S5uwLLHRcbNxzbkkl+bnmAtPKM1HlLLDBo
 Ra7yTo5QuYKRINhYR+yh/etqUG0TXURd2clU6PSbYwT5BIRbg9K5BH2366Kb7Bm2ie1q
 /RGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2fo9KhPCNYW+F0sc33/RwPCGaMMzyxHJl2mjQCHcWVQ=;
 b=iKm8xa3S/9yupv2sudNQKuUoITEgLtSBTlEmfHRrOOx39JMEyqu6ZOpNSwqADr3qx4
 A/WEqCSMnl51ATArBUjuL+r1JSztqlb+7dSkCcgt+OwvR/rV60bK3j8LqhLWQbSBOJ6T
 /MK3A0n0hoKzPOXirSOfD14nWh0CLFF3UC0nffWGbJ1R+cwngGfw8AF65PurAI5/MUpo
 q+M6mMRvBXZxnCOsWAeuMziZCtKXwrJ0xOGDFDFStB6ZmS0sbrPmE/QRQN/l+FIskF/j
 b6GFNWVxYzyEmBWY4bct9SCwn4JF02EbC+eJT9bG38t5iXwKUCkVZnCY24p+G+rCqNMU
 YBYQ==
X-Gm-Message-State: AOAM532+KqoXoERtvyZESylS0AskmSAffhyMcvj83ksJIKBpTnvJJcxX
 nb7Mfuk1dOiwjVTT/BWSWHhH9CDl+rSV3nV6
X-Google-Smtp-Source: ABdhPJymVcifPlwdaXncrMZQk3zFji1MGfBUxOHM34fO6zeF+X0bGouwxhS9Adgq2+0ThsGhzsJjiA==
X-Received: by 2002:adf:e304:: with SMTP id b4mr5155282wrj.141.1601051012628; 
 Fri, 25 Sep 2020 09:23:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 12/21] tests/qapi-schema: Convert doc-good.json to
 rST-style strong/emphasis
Date: Fri, 25 Sep 2020 17:23:07 +0100
Message-Id: <20200925162316.21205-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

doc-good.json currently uses the old *strong* and _emphasis_ markup.
As part of the conversion to rST this needs to switch to **strong**
and *emphasis*, because rST uses underscores as part of its markup
of hyperlinks and will otherwise warn about the syntax error.

In commit a660eed482063b we fixed up the in-tree uses of the
old markup:
 1) _this_ was replaced with *this*
 2) the only in-tree use of *this* was left alone (turning
    a 'strong' into an 'emphasis')
(and so currently in-tree nothing is using either new-style
**strong** or old-style _emphasis_).

Update doc-good.json in a similar way:
 1) replace _this_ with *this*
 2) remove the usage of old-style *this*

(This slightly reduces the coverage for the old Texinfo generator,
which is about to go away, but is fine for the new rST generator
because that does not need to handle strong/emphasis itself because
it is simply passing the entire text as raw rST to Sphinx.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qapi-schema/doc-good.json | 2 +-
 tests/qapi-schema/doc-good.out  | 2 +-
 tests/qapi-schema/doc-good.texi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index c6822145c49..e9af0857db7 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -10,7 +10,7 @@
 #
 # == Subsection
 #
-# *strong* _with emphasis_
+# *with emphasis*
 # @var {in braces}
 #
 # * List item one
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index b7e3f4313da..419284dae29 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -73,7 +73,7 @@ doc freeform
     body=
 == Subsection
 
-*strong* _with emphasis_
+*with emphasis*
 @var {in braces}
 
 * List item one
diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
index 12808989ffb..29abef33e98 100644
--- a/tests/qapi-schema/doc-good.texi
+++ b/tests/qapi-schema/doc-good.texi
@@ -4,7 +4,7 @@
 
 @subsection Subsection
 
-@strong{strong} @emph{with emphasis}
+@strong{with emphasis}
 @code{var} @{in braces@}
 
 @itemize @bullet
-- 
2.20.1


