Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A65C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320F5206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLnR9ETf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320F5206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLL3-0003Ml-C7
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHw-0007b3-Ct
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41751)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kOLHt-0005Rz-Mj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601645990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvVXKSfjWkoZJFhCHk1dGuX00kfrmBZkcI+Ka1f3ccA=;
 b=WLnR9ETfDS4r/AKBNje6d4yfmzyiqvTwaUreLh30eQ6pSwV7xqInImU0HYuHJ6YTXF3kMc
 S3kGoKovKhN2PMSpSJ2RtMuEXJja6ki5bjjaKx0hfMDqDbTsyXpBx4VZdsKb75uPqd5H92
 gbs29dFhDH749aiGKcl1vJKdg1qwXnI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-ugbAX-LnMgyvnbXpHotCQA-1; Fri, 02 Oct 2020 09:39:49 -0400
X-MC-Unique: ugbAX-LnMgyvnbXpHotCQA-1
Received: by mail-wm1-f72.google.com with SMTP id d197so539756wmd.4
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tvVXKSfjWkoZJFhCHk1dGuX00kfrmBZkcI+Ka1f3ccA=;
 b=nKQvD9jdFMKIlP7nfIYmPAc44kve7koeipaICmv+6F3DWa9dtbqoXW8mX9R/I2kVsn
 jQWUgyJsGpYi48O+D0AZ6gYJc1ags+9L240opU8LbwgHk1KihWLByH+tf9/CtBEJqicq
 7aWijprNmaC6qZR/h7j4saL18/+LsCB37GFsJazpMe8gMyqGr4bNdsdf1LKucjQWMjwI
 lSGgGrPQH+EOhSP+R4n+MCgJT/I0ee4DpdPBr10bzm5OlIsbRHTjjwkZkI98Wc+Vx4vt
 2rmSHcyF3f9K6O1nufCpC+nPMkqhAHatjXsmZFP2s7csX/oFGffoD3ctljoKigc1zpsG
 e4+A==
X-Gm-Message-State: AOAM533SlJT+/CQn2IP/SA/rF5nMpmgmCEbaXyNQ05pLDyzhFXKfHj6/
 Z02n8T2JTfHrT6xFwT6MPUd8mT9qtAxJ+rpFPonQz0aPwPwXI6lUCr2WrE4CAf99XLuVDzuAzlG
 VIyAv292C/hT0HEU=
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr3075495wrc.93.1601645987717; 
 Fri, 02 Oct 2020 06:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXZ0DUtM8ag+Gzw12Jr6+YpFZwVTHU0tycGVTY/5KbE5Wb3wWL4PNJqnB0Xi/zQrZCrmxEzA==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr3075463wrc.93.1601645987503; 
 Fri, 02 Oct 2020 06:39:47 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id d18sm1779795wrm.10.2020.10.02.06.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:39:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] qapi: Restrict 'query-kvm' command to machine code
Date: Fri,  2 Oct 2020 15:39:22 +0200
Message-Id: <20201002133923.1716645-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201002133923.1716645-1-philmd@redhat.com>
References: <20201002133923.1716645-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Paul Durrant <paul@xen.org>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Restricting query-kvm to machine.json pulls slightly
less QAPI-generated code into user-mode and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine.json | 30 ++++++++++++++++++++++++++++++
 qapi/misc.json    | 30 ------------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 5a3bbcae01..7c9a263778 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -561,6 +561,36 @@
 ##
 { 'command': 'inject-nmi' }
 
+##
+# @KvmInfo:
+#
+# Information about support for KVM acceleration
+#
+# @enabled: true if KVM acceleration is active
+#
+# @present: true if KVM acceleration is built into this executable
+#
+# Since: 0.14.0
+##
+{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-kvm:
+#
+# Returns information about KVM acceleration
+#
+# Returns: @KvmInfo
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-kvm" }
+# <- { "return": { "enabled": true, "present": true } }
+#
+##
+{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
+
 ##
 # @NumaOptionsType:
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 2a5d03a69e..9813893269 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -68,36 +68,6 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
-##
-# @KvmInfo:
-#
-# Information about support for KVM acceleration
-#
-# @enabled: true if KVM acceleration is active
-#
-# @present: true if KVM acceleration is built into this executable
-#
-# Since: 0.14.0
-##
-{ 'struct': 'KvmInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
-
-##
-# @query-kvm:
-#
-# Returns information about KVM acceleration
-#
-# Returns: @KvmInfo
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-kvm" }
-# <- { "return": { "enabled": true, "present": true } }
-#
-##
-{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
-
 ##
 # @IOThreadInfo:
 #
-- 
2.26.2


