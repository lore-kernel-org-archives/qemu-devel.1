Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F37C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C546207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIsD6Cci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C546207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzhN-0003Wk-AC
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSJ-0007sN-SW
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kWzSF-00080d-97
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603707016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/dIZ7gfHCDJ7wj9EUyK3nvk2G4/IOzcq/t671w4bkc=;
 b=fIsD6Cci93DJ2LDvnSbAJ0LkxSQgranEnF8hKAHWw8acri0+rWT08astF3hU3Vhs5BpQdr
 6Zo4ll+PsWMU2U4x3/qFTF/6PSwhcSK/dT6hMRIX1lMJQaOK16tH8yEKcMN1OcbpzVF0p9
 +shC3T6Ecwvq0WFvQYzk43OxYYnbg2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-yAh7R8bMM7yt7OG8QDAPbg-1; Mon, 26 Oct 2020 06:10:12 -0400
X-MC-Unique: yAh7R8bMM7yt7OG8QDAPbg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9962561239;
 Mon, 26 Oct 2020 10:10:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DE431043269;
 Mon, 26 Oct 2020 10:10:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C10FA1138461; Mon, 26 Oct 2020 11:10:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] char/stdio: Fix QMP default for 'signal'
Date: Mon, 26 Oct 2020 11:10:02 +0100
Message-Id: <20201026101005.2940615-2-armbru@redhat.com>
In-Reply-To: <20201026101005.2940615-1-armbru@redhat.com>
References: <20201026101005.2940615-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, marcandre.lureau@redhat.com, qemu-block@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Commit 02c4bdf1 tried to make signal=on the default for stdio chardevs
except for '-serial mon:stdio', but it forgot about QMP and accidentally
switched the QMP default from true (except for -nographic) to false
(always). The QMP documentation was kept unchanged and still describes
the opposite of the old behaviour (which is an even older documentation
bug).

Fix all of this by making signal=true the default in ChardevStdio and
documenting it as such.

Fixes: 02c4bdf1d2ca8c02a9bae16398f260b5c08d08bf
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20201023161312.460406-2-kwolf@redhat.com>
---
 qapi/char.json       | 3 +--
 chardev/char-stdio.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/qapi/char.json b/qapi/char.json
index b4d66ec90b..43486d1daa 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -321,8 +321,7 @@
 # Configuration info for stdio chardevs.
 #
 # @signal: Allow signals (such as SIGINT triggered by ^C)
-#          be delivered to qemu.  Default: true in -nographic mode,
-#          false otherwise.
+#          be delivered to qemu.  Default: true.
 #
 # Since: 1.5
 ##
diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 82eaebc1db..403da308c9 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -112,9 +112,7 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     qemu_chr_open_fd(chr, 0, 1);
 
-    if (opts->has_signal) {
-        stdio_allow_signal = opts->signal;
-    }
+    stdio_allow_signal = !opts->has_signal || opts->signal;
     qemu_chr_set_echo_stdio(chr, false);
 }
 #endif
-- 
2.26.2


