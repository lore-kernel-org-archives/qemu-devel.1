Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:28:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9B12071A
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 00:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O14NoHKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9B12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyP5s-0002c3-Ni
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 20:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3X9kYXwMKCnQkUoYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--scw.bounces.google.com>)
 id 1jyP4t-0001jK-6Q
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:15 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:54448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3X9kYXwMKCnQkUoYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--scw.bounces.google.com>)
 id 1jyP4r-00035c-8t
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 20:27:14 -0400
Received: by mail-yb1-xb49.google.com with SMTP id p22so4475554ybg.21
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 17:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=I4PnbRt4YsoZkPIh8NPwRmvs8OJi++5TzHmGoc+l+rk=;
 b=O14NoHKM7RNc8GRET8tQBYDYwjgt9kzNdN9VpymlTFGYJ4AcYplcSwEX7O+G6ZfceE
 hSAwYJGhRBl0DrARa4Fr6F3Hqpin58AfDcuKxpyKJRRzfHyf5D++rO0H+/WM2Qo/vSMN
 T5EjwYLBulpfo9jQE+U5j2fBYNVKsBRC5p9nNmey53Tp1dPQ2kcVL+2GHx+bB7pobVFG
 mq7eWrCZe/jOc00grAkQmyL+vmWL7rlP07YXSgztjOSvC6iRiiHXW6oEg1lCfYZ/Enp7
 34S+wveu6njLQ3N6fJ1qwrnqv3zVRL8SA3yM6aPU7ZDpmjekhweCQk41U/Ih2vzKfgiJ
 1iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=I4PnbRt4YsoZkPIh8NPwRmvs8OJi++5TzHmGoc+l+rk=;
 b=QCbpqPe5QsfcZeptgSRAWmraCyRPhAL5HWh84S0n4qd9nPclKCcpqCfkuF+/un7zxw
 C7xrYuKjPLRDEEP/jbPQFy8DdU27kdZDQeSzjapMDCt75Crnq5Kedv3zREUWsV4+84aW
 7bMCXy+uXD6hEJCaPV7OBWRAoYJUia8fnQyFIgfX+0kt0hGbDoe005yT8tq//qB+aY0w
 jUqbQZBqhERMAbOYMrwONewZHApKv1GMNK/f6AlJpr60grgEfOThJnQhH+TdQc3twSHL
 +cKIrEYmMDAp8wmRVZHWWjOmxCY4CHzhGHz9PznTfALop6xaHNC/vjPdAYq3o2RdUnIo
 hqVw==
X-Gm-Message-State: AOAM530THmyG0VUmUgMtbPLlYux9reb96zeH3TYgFOaOoiLh1Q/j2IRq
 nUBI08eRTr6NuoOgdc9bxru82dc=
X-Google-Smtp-Source: ABdhPJyVg5i641YrhniPoZ4h9L2oBrGQFJGWdne6EoH2hZx2YPA3aH1WHLFkYmCfAmSJC26hZVNvJPg=
X-Received: by 2002:a25:3789:: with SMTP id e131mr3048610yba.417.1595464031758; 
 Wed, 22 Jul 2020 17:27:11 -0700 (PDT)
Date: Wed, 22 Jul 2020 17:27:05 -0700
In-Reply-To: <cover.1595463707.git.scw@google.com>
Message-Id: <d9d6f2845c430ff95089717b304823c10d8114f0.1595463707.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1595463707.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/2] configure: atomic64/128 detection for clang
From: Shu-Chun Weng <scw@google.com>
To: rth@twiddle.net
Cc: Shu-Chun Weng <scw@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3X9kYXwMKCnQkUoYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The public interface for __atomic_* and __sync_* do not contain the
explicit *_{number} versions:
  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html
  https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html

They appear to be GCC's internal symbols which happen to work. However,
clang does not recognize them. Replace the existing usages with the `_n`
versions (or no suffix) which are the documented API.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 configure | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/configure b/configure
index d9ce3aa5db..0613a049e9 100755
--- a/configure
+++ b/configure
@@ -5894,9 +5894,9 @@ if test "$int128" = "yes"; then
 int main(void)
 {
   unsigned __int128 x = 0, y = 0;
-  y = __atomic_load_16(&x, 0);
-  __atomic_store_16(&x, y, 0);
-  __atomic_compare_exchange_16(&x, &y, x, 0, 0, 0);
+  y = __atomic_load_n(&x, 0);
+  __atomic_store_n(&x, y, 0);
+  __atomic_compare_exchange_n(&x, &y, x, 0, 0, 0);
   return 0;
 }
 EOF
@@ -5911,7 +5911,7 @@ if test "$int128" = yes && test "$atomic128" = no; then
 int main(void)
 {
   unsigned __int128 x = 0, y = 0;
-  __sync_val_compare_and_swap_16(&x, y, x);
+  __sync_val_compare_and_swap(&x, y, x);
   return 0;
 }
 EOF
@@ -5931,11 +5931,11 @@ int main(void)
 {
   uint64_t x = 0, y = 0;
 #ifdef __ATOMIC_RELAXED
-  y = __atomic_load_8(&x, 0);
-  __atomic_store_8(&x, y, 0);
-  __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
-  __atomic_exchange_8(&x, y, 0);
-  __atomic_fetch_add_8(&x, y, 0);
+  y = __atomic_load_n(&x, 0);
+  __atomic_store_n(&x, y, 0);
+  __atomic_compare_exchange_n(&x, &y, x, 0, 0, 0);
+  __atomic_exchange_n(&x, y, 0);
+  __atomic_fetch_add(&x, y, 0);
 #else
   typedef char is_host64[sizeof(void *) >= sizeof(uint64_t) ? 1 : -1];
   __sync_lock_test_and_set(&x, y);
-- 
2.28.0.rc0.105.gf9edc3c819-goog


