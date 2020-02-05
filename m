Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CC3C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C19492072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cf8tA09l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C19492072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izSJz-0006ug-TW
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 16:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1izSIy-0005BD-Qr
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1izSIx-00066K-Jo
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:52 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436]:34654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1izSIx-00065w-EO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 16:33:51 -0500
Received: by mail-pf1-x436.google.com with SMTP id i6so1890292pfc.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 13:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CXBScSagi44Obo0j+z38gP3z1ZronJ0NsG9MHnQZm+M=;
 b=Cf8tA09l2c451f/RF9zFVviarRZy1Sm+Vpp+d26keIGoXlKIjdI3eXq0liF7xw/8vz
 nCr50EuhqB4sOqGDMrg8RitWfuYwWRIVKHNqht++R78vHSe6q/9m92MuHHQ7Mop3RVV/
 PLDoI0ZJiIvqLD2/QhozPrxt+5rBLibRqv3iK8nV4I6yoJOEbcJyom4UjE+bc0tMTzOD
 q++IWOKy0NFrxjDBTDBdpNjFrmcrQ6by3eMHreKCxN1UxcjrdWqKvHOUgFfK4xIKGFmK
 CUpwagAuJ30S5jEy9vk7DUIf6DYjtpEEWo5aSSrVsq2rVb/Di2ANZY/Aer8qDJ6C0f/C
 KEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CXBScSagi44Obo0j+z38gP3z1ZronJ0NsG9MHnQZm+M=;
 b=b1R9OKO0VJzfy4CZpkkJd0DQikOSsQTayOEOWNZ7BZgCTydLDNpNsMMrWQc4JlwmV9
 R0pOfx6kmFnnSbPvxqtC2S7iEeTplD+uHq1/vDUqno96jlgRwvtzqcK/XOS9Z0aQUWGc
 a/976V3j2iQcWZxHdj3ovpBeu9Fj55J+0aTmXTIosNcMPqunk6tYu1tvHOpR5yyvAnE2
 oMtmCzIXRhXk/JhpcYlhRuVz6IJ66spLwzbVwYVsql3S8uuXys3r3foE6zpdW+8mBY+Q
 8SoQ20gzYP0VI7nYRDdJUWaYVcP7iZONfaEgDwbosK+715tcxKffp+FvmLIVbi1n1n+N
 Z9xA==
X-Gm-Message-State: APjAAAUTAAgnWPWEVPxdCzm8J9Agwfs0+1VIp9xGdEEVAxxSWtQs5AeY
 PVJff4QCg997Wa0UwaPzYsLTELcA5NM=
X-Google-Smtp-Source: APXvYqwWqA7oNOr0UvQG1YTvs56mKt/a256oIhq4gU9453z6TpIbxEqpKvpYeknUO1ZLD2FZ1GATdw==
X-Received: by 2002:a62:14e:: with SMTP id 75mr13743pfb.54.1580938430139;
 Wed, 05 Feb 2020 13:33:50 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id p4sm724576pgh.14.2020.02.05.13.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 13:33:49 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 03/14] tests/vm: increased max timeout for vm boot.
Date: Wed,  5 Feb 2020 16:29:09 -0500
Message-Id: <20200205212920.467-4-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205212920.467-1-robert.foley@linaro.org>
References: <20200205212920.467-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::436
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

Add change to increase timeout waiting for VM to boot.
Needed for some emulation cases where it can take longer
than 5 minutes to boot.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 tests/vm/basevm.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 991115e44b..4de358ae22 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -59,6 +59,10 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # Scale up some timeouts under TCG.
+    # 4 is arbitrary, but greater than 2,
+    # since we found we need to wait more than twice as long.
+    tcg_ssh_timeout_multiplier = 4
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -311,6 +315,9 @@ class BaseVM(object):
         sys.stderr.write("### %s ...\n" % text)
 
     def wait_ssh(self, seconds=300):
+        # Allow more time for VM to boot under TCG.
+        if not kvm_available(self.arch):
+            seconds *= self.tcg_ssh_timeout_multiplier
         starttime = datetime.datetime.now()
         endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-- 
2.17.1


