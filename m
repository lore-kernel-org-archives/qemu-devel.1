Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05524C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7EB20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0GYZGnv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7EB20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Iug-0007vN-TL
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijc-0000Ts-OY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjX-0002WZ-5j
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:08 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:46094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjW-0002S5-U2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:03 -0500
Received: by mail-wr1-x434.google.com with SMTP id z7so7788648wrl.13
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A2//xF4cU9fngBLXdXyIv9i7RvZaILvkPN4bDJz6pxM=;
 b=U0GYZGnvwGmx7JLznGm9hVOateVotVkRb9aUaYbBA5NcAQkNIOOWh5EqQmTiK68wxg
 ThlZriYAnFjDSKhgfxFkAaBJ+EqveSwfT7vCiRxHTXVGYf+vCy6Ed1jKuL3W89sEebRu
 QQrUonxFWB3EimGddl7tTD3yA664xWNFdDu+yadN9rvzLkFAfh7KgYFsrAM1Qq1tk5b+
 Rbzz8FRmJs+znx6Tefvwl9HXzvvMrcCd/6ZovqgkIerbtWg+IfqnSsZBRV1GEGJl6SY4
 y12s3Z6cTWj9NFDPLBXTtdOCiocJa1bRlTtx36Dq6xMjeDBqTVbOfpv6uVet8zmW0rR+
 9Cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A2//xF4cU9fngBLXdXyIv9i7RvZaILvkPN4bDJz6pxM=;
 b=A6RUa8drE9assr7KttEGck4i27yo5l3cE7XG4B4MTuxEbYe7RfnxeS+4IZGqCv0Ns9
 9JkwJs1MqfvLOol2yZeIdzbkJJsxW3g8flzRIms48BgA/woxT9hhnT0emlO1IkiQWIw+
 6ilmQvvbpIjLYSAG61X3tGjABJgOCndEOEYxqOe5sSFCxoQCsbpieCqtW+OayWkJ7xC9
 4dospJDldTp+5MKOqtQg5XGS1t1ncQ2lMr5EJuFhR5mQik/VhxwOGBYbLPgv8/y6TZPK
 kB/fLThoPrazmNlCSOeFJYDZU2FeXuGjiz0VmODxyHSiDhdr/IAC33omPq0gsUlq7ky+
 EXog==
X-Gm-Message-State: APjAAAWNm6ZI6qlE3THN4pq9UFt9TpyoGN6oWbEty8e0p4QZMy+jWvC/
 V0EaNnThbhYrAFD277nbUeJ8MHKlHIs=
X-Google-Smtp-Source: APXvYqys9A4r9ErZKxx8Rn4o2ZOhb0vNkWQum/hj0nT62+o5d4X13K1rag/WuTmePnVeYN1xbBdZGw==
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr21788863wrw.289.1581616618568; 
 Thu, 13 Feb 2020 09:56:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/30] qga/qapi-schema.json: minor format fixups for rST
Date: Thu, 13 Feb 2020 17:56:23 +0000
Message-Id: <20200213175647.17628-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

rST format requires a blank line before the start of a bulleted
or enumerated list. Two places in qapi-schema.json were missing
this blank line.

Some places were using an indented line as a sort of single-item
bulleted list, which in the texinfo output comes out all run
onto a single line; use a real bulleted list instead.

Some places unnecessarily indented lists, which confuses rST.

guest-fstrim:minimum's documentation was indented the
right amount to share a line with @minimum, but wasn't
actually doing so.

The indent on the bulleted list in the guest-set-vcpus
Returns section meant rST misindented it.

Changes to the generated texinfo are very minor (the new
bulleted lists, and a few extra blank lines).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/qapi-schema.json | 94 ++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 43 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7661b2b3b45..f6fcb59f34b 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -510,8 +510,7 @@
 #
 # Discard (or "trim") blocks which are not in use by the filesystem.
 #
-# @minimum:
-#           Minimum contiguous free range to discard, in bytes. Free ranges
+# @minimum: Minimum contiguous free range to discard, in bytes. Free ranges
 #           smaller than this may be ignored (this is a hint and the guest
 #           may not respect it).  By increasing this value, the fstrim
 #           operation will complete more quickly for filesystems with badly
@@ -546,7 +545,8 @@
 # (or set its status to "shutdown") due to other reasons.
 #
 # The following errors may be returned:
-#          If suspend to disk is not supported, Unsupported
+#
+# - If suspend to disk is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -575,12 +575,14 @@
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-#   1. Wait for the SUSPEND QMP event from QEMU
-#   2. Issue the query-status QMP command to confirm the VM status is
-#      "suspended"
+#
+# 1. Wait for the SUSPEND QMP event from QEMU
+# 2. Issue the query-status QMP command to confirm the VM status is
+#    "suspended"
 #
 # The following errors may be returned:
-#          If suspend to ram is not supported, Unsupported
+#
+# - If suspend to ram is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -607,12 +609,14 @@
 #
 # This command does NOT return a response on success. There are two options
 # to check for success:
-#   1. Wait for the SUSPEND QMP event from QEMU
-#   2. Issue the query-status QMP command to confirm the VM status is
-#      "suspended"
+#
+# 1. Wait for the SUSPEND QMP event from QEMU
+# 2. Issue the query-status QMP command to confirm the VM status is
+#    "suspended"
 #
 # The following errors may be returned:
-#          If hybrid suspend is not supported, Unsupported
+#
+# - If hybrid suspend is not supported, Unsupported
 #
 # Notes: It's strongly recommended to issue the guest-sync command before
 #        sending commands when the guest resumes
@@ -767,18 +771,22 @@
 # Returns: The length of the initial sublist that has been successfully
 #          processed. The guest agent maximizes this value. Possible cases:
 #
-#          - 0:              if the @vcpus list was empty on input. Guest state
-#                            has not been changed. Otherwise,
-#          - Error:          processing the first node of @vcpus failed for the
-#                            reason returned. Guest state has not been changed.
-#                            Otherwise,
-#          - < length(@vcpus): more than zero initial nodes have been processed,
-#                            but not the entire @vcpus list. Guest state has
-#                            changed accordingly. To retrieve the error
-#                            (assuming it persists), repeat the call with the
-#                            successfully processed initial sublist removed.
-#                            Otherwise,
-#          - length(@vcpus): call successful.
+#          - 0:
+#            if the @vcpus list was empty on input. Guest state
+#            has not been changed. Otherwise,
+#          - Error:
+#            processing the first node of @vcpus failed for the
+#            reason returned. Guest state has not been changed.
+#            Otherwise,
+#          - < length(@vcpus):
+#            more than zero initial nodes have been processed,
+#            but not the entire @vcpus list. Guest state has
+#            changed accordingly. To retrieve the error
+#            (assuming it persists), repeat the call with the
+#            successfully processed initial sublist removed.
+#            Otherwise,
+#          - length(@vcpus):
+#            call successful.
 #
 # Since: 1.5
 ##
@@ -1182,35 +1190,35 @@
 # @GuestOSInfo:
 #
 # @kernel-release:
-#     * POSIX: release field returned by uname(2)
-#     * Windows: build number of the OS
+# * POSIX: release field returned by uname(2)
+# * Windows: build number of the OS
 # @kernel-version:
-#     * POSIX: version field returned by uname(2)
-#     * Windows: version number of the OS
+# * POSIX: version field returned by uname(2)
+# * Windows: version number of the OS
 # @machine:
-#     * POSIX: machine field returned by uname(2)
-#     * Windows: one of x86, x86_64, arm, ia64
+# * POSIX: machine field returned by uname(2)
+# * Windows: one of x86, x86_64, arm, ia64
 # @id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "mswindows"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "mswindows"
 # @name:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "Microsoft Windows"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "Microsoft Windows"
 # @pretty-name:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
+# * POSIX: as defined by os-release(5)
+# * Windows: product name, e.g. "Microsoft Windows 10 Enterprise"
 # @version:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: long version string, e.g. "Microsoft Windows Server 2008"
+# * POSIX: as defined by os-release(5)
+# * Windows: long version string, e.g. "Microsoft Windows Server 2008"
 # @version-id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: short version identifier, e.g. "7" or "20012r2"
+# * POSIX: as defined by os-release(5)
+# * Windows: short version identifier, e.g. "7" or "20012r2"
 # @variant:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "server" or "client"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "server" or "client"
 # @variant-id:
-#     * POSIX: as defined by os-release(5)
-#     * Windows: contains string "server" or "client"
+# * POSIX: as defined by os-release(5)
+# * Windows: contains string "server" or "client"
 #
 # Notes:
 #
-- 
2.20.1


