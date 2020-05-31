Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E43C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905362074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cE15pxvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905362074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR2i-0006fV-NY
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQza-000197-I3
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzU-0006gk-NW
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMv0WAWso8oUAufIgFUwjed/SkQYQOJci7UGvUEGULg=;
 b=cE15pxvRiqkc/NU4pvs3nnWDZKb6HIQdJ7y78MjgIRTMu9dD4O1kkQA2pTp9Qx5BOFT2BA
 8oBz1gFPJJYx5aCy4+25mCvcDZ54Avc/FzsD2oPPA8rpzd2stzMzbmZWTtb2ecsJOPneoj
 UL/ru94byQsQlrmS4twdQTeGSYc/60g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-uNXenVtOMGK0ECoTk_yG2w-1; Sun, 31 May 2020 12:39:11 -0400
X-MC-Unique: uNXenVtOMGK0ECoTk_yG2w-1
Received: by mail-wr1-f72.google.com with SMTP id s17so3598612wrt.7
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sMv0WAWso8oUAufIgFUwjed/SkQYQOJci7UGvUEGULg=;
 b=UeQKivVy2pV0x3xbNCHftVqlmQv7ftcvTIYQCKXiBIrK66F7seqM1p/w/p6gk5U3va
 ChHmca5raYuMRxO/iBkUEdqEoG5eKVGH8Lost3wO52Qn0oNihozvJ70EKVKpcxb2QU6w
 gnaZZEcCL8enyFejctpEoJ9PYKeGITxLx/e095CK3e6+VU1qbQ05IleamnZU9CvQPp2o
 +4zENlOXBt9i/0JBtb4E0fym8hC8J9l/390nlL4zzXG4u8EbmqHsem33bDAD+T6KEeU/
 mD8fDTqjayEe20KqEIAu4zkA8bs3eWUEok8yxKHbNj5NO+2kL6wIS0SZ66lnHlVAzIx8
 pprw==
X-Gm-Message-State: AOAM532mU7n45IAIIMA0oGnpAxem3KaeOb6+djlwLNRbEX4L55i0nrQH
 9PgZ0eAa7FFVxY96zJjpQInyi5BnQz7EYIBGgerAveDDNtBi9aYwOzujGEEBl0g7KIU59FCFKCD
 BIDlQyu6cfwVeFOA=
X-Received: by 2002:a5d:514f:: with SMTP id u15mr19116180wrt.132.1590943150626; 
 Sun, 31 May 2020 09:39:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG/iDkpGxrVd4v54lbHxHsAujyHTlU/e7fh0d4gw7L74BATUg8tOFaSEYyfJzJ1sFZwdHjKQ==
X-Received: by 2002:a5d:514f:: with SMTP id u15mr19116175wrt.132.1590943150481; 
 Sun, 31 May 2020 09:39:10 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id v7sm8920858wme.46.2020.05.31.09.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/25] scripts/kvm/vmxcap: Use Python 3 interpreter and add
 pseudo-main()
Date: Sun, 31 May 2020 18:38:25 +0200
Message-Id: <20200531163846.25363-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200512103238.7078-5-philmd@redhat.com>
---
 scripts/kvm/vmxcap | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index 971ed0e721..6fe66d5f57 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # tool for querying VMX capabilities
 #
@@ -275,5 +275,6 @@ controls = [
         ),
     ]
 
-for c in controls:
-    c.show()
+if __name__ == '__main__':
+    for c in controls:
+        c.show()
-- 
2.21.3


