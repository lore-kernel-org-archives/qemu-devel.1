Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF23C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EA5206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AcUMQMiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EA5206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoIN-0002UH-92
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE6-0005J1-Jl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1igoE5-0003gW-CQ
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:46 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45013)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1igoE5-0003e0-6F
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:07:45 -0500
Received: by mail-wr1-x430.google.com with SMTP id q10so6687366wrm.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ybsWYSpCOntXJQJZl/BPtqoIiu86PvdtWCPXeyNm4bw=;
 b=AcUMQMiM9zDozYHCxs/HE75Soojxee47f/suAk+sd3nyugj9ZPV50wUgOKZKB8Uvpb
 LFbIViTvt5qB3v1+dnVzw696KJ6sOH4seXsjyfk4cnPnQUQ5sV6qSPdop2mMMWA65Dni
 BTiNP86NYKKvaNolW0WIa8ULNbXJiFYBUJNjbG54opQvBaTf5An1ZbSKLKNxLk2JyY7j
 vr5DBOfAERwcqZlcNFzqkMdWdy/qq8nZPYCrfMSBpjMQd/VQezR3xmCXat8qfIS6lVnv
 XU2gUie0bxfWrWqLttC+Q9sUS9IModAIr2YpY70nA/6mFOScgEZmB2U73wIM8RjQrTdH
 8a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ybsWYSpCOntXJQJZl/BPtqoIiu86PvdtWCPXeyNm4bw=;
 b=JGHBmdSRNKUhi0M/cr0WmBX+JPncml1Sg1QexcuLfEbKA5YArg7qBFeMGqhcCbhFVl
 Y2k6nxVip+8vtuNUkxPLobh8zs2sc2y4PC6q900Oa+X18IqPNNVuGq5jv5tLfh8n7Q7w
 ETuTV+H/tKKPZPgU9aowKTl66FaUmDbXfouuqwbMQmo9PR6Sb5OinfwiyeU+WfaJAipJ
 eF1JXddvwvHo4+QTgRv7tbjLpRhWjaB7RzHqz1o4wmcNLgYKazAf8wABRJR92lnq6n6U
 1LKDQ/g9UOfOwzjbmqw3RTdSQtSp2azxKeV1josMccnv+cO8Cx5NSNEYhfQCLh4EJp0Y
 C3Ug==
X-Gm-Message-State: APjAAAU1wVpbiH67n1uWFvHWpL1QdioFEjkNRJyLuBF43M7na6v0U4RC
 vAnRBGm1u1ZUgxfhp9sLBSrsBA==
X-Google-Smtp-Source: APXvYqxBqS/crhpGubV+br8ysSApmvXoef9GdwvEt4k9TSVAabRnc8dU1Nw2uXuXw8/yK23NwVqCyg==
X-Received: by 2002:adf:f88c:: with SMTP id u12mr30985909wrp.323.1576494463031; 
 Mon, 16 Dec 2019 03:07:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s3sm20094326wmh.25.2019.12.16.03.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:07:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AFDE41FF93;
 Mon, 16 Dec 2019 11:07:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 06/16] iotests: Skip test 079 if it is not possible to
 create large files
Date: Mon, 16 Dec 2019 11:07:22 +0000
Message-Id: <20191216110732.24027-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110732.24027-1-alex.bennee@linaro.org>
References: <20191216110732.24027-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Test 079 fails in the arm64, s390x and ppc64le LXD containers on Travis
(which we will hopefully enable in our CI soon). These containers
apparently do not allow large files to be created. Test 079 tries to
create a 4G sparse file, which is apparently already too big for these
containers, so check first whether we can really create such files before
executing the test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191204154618.23560-4-thuth@redhat.com>
---
 tests/qemu-iotests/079 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
index 81f0c21f530..78536d3bbfa 100755
--- a/tests/qemu-iotests/079
+++ b/tests/qemu-iotests/079
@@ -39,6 +39,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file nfs
 
+# Some containers (e.g. non-x86 on Travis) do not allow large files
+_require_large_file 4G
+
 echo "=== Check option preallocation and cluster_size ==="
 echo
 cluster_sizes="16384 32768 65536 131072 262144 524288 1048576 2097152 4194304"
-- 
2.20.1


