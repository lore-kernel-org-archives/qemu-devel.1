Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1711C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E06520759
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3njXVqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E06520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtHJ-0006tq-CS
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4m-0001Dv-I0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4k-0002sS-Ib
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sA8HBLAd+5/ZjYUElQKsQkBPTjMwphQifvUOAKUKqLY=;
 b=X3njXVqW+YAzRQNbw7neZT1PCtov0jXkTQS0+Z+rm9PLbf8QhbKkXQ/dqMwL8auKP7Z6XD
 FrTbGPeSGWEmg5MHcXjR5YqmlmU2HQbHELz27qum7zdYBsEIlivyw1uAQok7WF52rCBSr8
 WMp9ivMJikjGr/jDbHuvwehZowodNxI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-msNteCO4Mbuv_Fp9Gf2CRw-1; Mon, 28 Sep 2020 09:20:16 -0400
X-MC-Unique: msNteCO4Mbuv_Fp9Gf2CRw-1
Received: by mail-wr1-f70.google.com with SMTP id d13so389920wrr.23
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sA8HBLAd+5/ZjYUElQKsQkBPTjMwphQifvUOAKUKqLY=;
 b=jxKVnkhzuH7BunHiRSlqskpowxUVRoE67O9x789K8RHvve8lGkUcDj3+pJnmhYVlhx
 PDhh3wngBXkV2JxVy1V5k9Jacs5+mfxGwBNm9VA00YSv7QLERCYdjr3DzW7O2cs9ob2w
 2ZK7VcBXLigNKOwKOVPuOepKVrMHBE2iIjvSVDAfbDqe62BVO4AF9bvB/xayYGCoJAif
 xxO56N1fdEOZTcyJ+d80czhKPD3MEL6qej8NFhZTNRYVnpiyTdftwMy1QZfLIgT595Li
 EwV3F8x6XA9fp7ZYyEidBd7CTtOkkvTC9FZ8rLRHJKDsZmqgoexrdAoc0uItJac6n1ai
 t+9g==
X-Gm-Message-State: AOAM530xOoqDEsojXw9chvZjpNTNIqpnj+zTxeQn7zyXp9YqvfqhJRDX
 bv0riTWlgdE8PIeONFi3nf05LBsPT2977Ty31XkBMus5yg0wUa5DcqJWvaxj0R2N+SMmnHSyV9x
 ABeZ8E20jA1pnLOw=
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr1583644wmf.119.1601299214473; 
 Mon, 28 Sep 2020 06:20:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEekBAVGlab3ArbOg3zRXJpzuwxev55ZyX+AzjMJADRVtos1SnupBe8YxhFGjJqQ5N1hG0Pw==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr1583620wmf.119.1601299214237; 
 Mon, 28 Sep 2020 06:20:14 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id n66sm1263253wmb.35.2020.09.28.06.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:20:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 7/8] qemu/bswap: Use compiler __builtin_bswap() on NetBSD
Date: Mon, 28 Sep 2020 15:19:33 +0200
Message-Id: <20200928131934.739451-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200928131934.739451-1-philmd@redhat.com>
References: <20200928131934.739451-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit efc6c070aca ("configure: Add a test for the minimum
compiler version") the minimum compiler version required for GCC
is 4.8, which supports __builtin_bswap().
Remove the NetBSD specific ifdef'ry.

This reverts commit 1360677cfe3ca8f945fa1de77823df21a77e4500
("makes NetBSD use the native bswap functions").

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure            | 15 ---------------
 include/qemu/bswap.h |  5 -----
 2 files changed, 20 deletions(-)

diff --git a/configure b/configure
index bff787daea7..1b0a02a0af8 100755
--- a/configure
+++ b/configure
@@ -4886,18 +4886,6 @@ if test "$docs" != "no" ; then
   fi
 fi
 
-# Search for bswap32 function
-bswap_h=no
-cat > $TMPC << EOF
-#include <sys/endian.h>
-#include <sys/types.h>
-#include <machine/bswap.h>
-int main(void) { return bswap32(0); }
-EOF
-if compile_prog "" "" ; then
-  bswap_h=yes
-fi
-
 ##########################################
 # Do we have libiscsi >= 1.9.0
 if test "$libiscsi" != "no" ; then
@@ -6779,9 +6767,6 @@ fi
 if test "$st_atim" = "yes" ; then
   echo "HAVE_STRUCT_STAT_ST_ATIM=y" >> $config_host_mak
 fi
-if test "$bswap_h" = "yes" ; then
-  echo "CONFIG_MACHINE_BSWAP_H=y" >> $config_host_mak
-fi
 if test "$curl" = "yes" ; then
   echo "CONFIG_CURL=y" >> $config_host_mak
   echo "CURL_CFLAGS=$curl_cflags" >> $config_host_mak
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 1a297bfec22..7e586531c09 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -3,17 +3,12 @@
 
 #include "fpu/softfloat-types.h"
 
-#ifdef CONFIG_MACHINE_BSWAP_H
-# include <sys/endian.h>
-# include <machine/bswap.h>
-#else
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
 #undef  bswap32
 #define bswap32(_x) __builtin_bswap32(_x)
 #undef  bswap64
 #define bswap64(_x) __builtin_bswap64(_x)
-#endif /* ! CONFIG_MACHINE_BSWAP_H */
 
 static inline void bswap16s(uint16_t *s)
 {
-- 
2.26.2


