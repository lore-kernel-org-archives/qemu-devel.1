Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B12C55ABD
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EF1206ED
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb+da5hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EF1206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrgx-0003P2-K9
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbG-0004lY-3V
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbD-0000W2-FL
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yakfnEsHk6Ij0rP4RLzjNfGHB0Gt59W8s1haMGr98pU=;
 b=Zb+da5hSidDQNY+ONhU4UAIN6YkpF7/RQB46rY50dYeVrJ9PPJ3Lo9XjjNsAgPH6FmNett
 dwIYcrp2OrW+Iad7cA0umDvDbqgSooNaP9EoyVjsfyp/yZsEa6ABY+5eAdxTcozpJd+YCb
 tzMl7y/hUciWmgXtdPsQCunlbw9w0Z4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-qB4L3TDRP6CWolhhgSs7Dw-1; Sun, 08 Nov 2020 15:47:41 -0500
X-MC-Unique: qB4L3TDRP6CWolhhgSs7Dw-1
Received: by mail-wr1-f70.google.com with SMTP id j15so3382295wrd.16
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yakfnEsHk6Ij0rP4RLzjNfGHB0Gt59W8s1haMGr98pU=;
 b=SQXIiIn8gIced/Cbpbyr3HHx+cKE71ykjsS+6OnMuJ1Q0CAtQJK6OyIsLaEF4+L8qR
 hUUGOAXPbBM0x/H7dHoF2LbQ+ZJOT3koFQmC3D1/P0QINvpCUPTKtmUiHzUYNyRVH8GM
 +PZWShcV1Wenn8AVvMAGu1PDn9y5oVIx72xfauUEWfEyGgbH/p6ER/Z3uqmFsEvlyjk9
 +BqEEO+OZO/wuTGYMgeaYeEwia8hJFDwoAakfN+iEgUaCMtoaNxuQYO/bqR6gXCwJYDa
 3MOILhV93fCYAV+xsNEeNNlpN1fwdTWi9erC+XQ5GUWv9FrsE7/BK7HuUM6RtpjN9LHw
 dXrw==
X-Gm-Message-State: AOAM5314tJmVXOZDQROanXhFmT1Pr5XXviq84eqq4I6hLqvJZs5r4QD4
 vnkeSt5l+iBMTv3ncOeeoMF/RdwLUG0+2e+xxF4WTOVXX6w5Be/98jthex3AviIuD1ubcFrPKdc
 x75uhzeR/Z51Udrc=
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr14057134wrw.120.1604868458582; 
 Sun, 08 Nov 2020 12:47:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwc6D9nzixZgf5IT3HIK2w/iaCgr7Qin3ZRUgDJZa2AR8PQJ0V1C2J/eu9Y+rMQNniG4SsU1w==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr14057111wrw.120.1604868458405; 
 Sun, 08 Nov 2020 12:47:38 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id k22sm10365890wmi.34.2020.11.08.12.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 08/17] gitlab-ci: Move linux-user debug-tcg test
 across to gitlab
Date: Sun,  8 Nov 2020 21:45:26 +0100
Message-Id: <20201108204535.2319870-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the linux-user (debug-tcg)
test to GitLab.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
 .gitlab-ci.yml | 7 +++++++
 .travis.yml    | 9 ---------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3fc3d0568c6..80082a602b8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -304,6 +304,13 @@ build-user:
     CONFIGURE_ARGS: --disable-tools --disable-system
     MAKE_CHECK_ARGS: check-tcg
 
+build-user-debug:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: debian-all-test-cross
+    CONFIGURE_ARGS: --disable-tools --disable-system --enable-debug-tcg
+    MAKE_CHECK_ARGS: check-tcg
+
 # Run check-tcg against linux-user (with plugins)
 # we skip sparc64-linux-user until it has been fixed somewhat
 # we skip cris-linux-user as it doesn't use the common run loop
diff --git a/.travis.yml b/.travis.yml
index 15d92291358..bee6197290d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -293,15 +293,6 @@ jobs:
         - ${SRC_DIR}/configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread" || { cat config.log meson-logs/meson-log.txt && exit 1; }
 
 
-    # Run check-tcg against linux-user
-    - name: "GCC check-tcg (user)"
-      env:
-        - CONFIG="--disable-system --enable-debug-tcg"
-        - TEST_BUILD_CMD="make build-tcg"
-        - TEST_CMD="make check-tcg"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
-
-
     # Run check-tcg against softmmu targets
     - name: "GCC check-tcg (some-softmmu)"
       env:
-- 
2.26.2


