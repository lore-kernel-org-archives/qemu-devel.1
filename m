Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41C6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AA4221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bV9QYbnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AA4221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtLK-0001lZ-77
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4Y-0000ja-4b
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kMt4W-0002oP-D8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:20:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQxJXzhc1czKuYkocMWwWEQUckk+RWA2innt4R1BD+0=;
 b=bV9QYbnWdfIbSI8+lKsblDtkZLOlSivKSwr8FqaeO3CxvFohfWHjyZuPZRxm21N8r6wrhg
 iABrQRWRiAnirlQvKEUOj+v8JHalPNxk3D1CRPXNvwl3SNHTRiLCCzhMrm1cQ1an9KaM+S
 Xe11iB79UHwyzQZTZwMd0MEJ3X5QQrI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-x2rfnPbvM6KLpdrrQQ9ETw-1; Mon, 28 Sep 2020 09:19:59 -0400
X-MC-Unique: x2rfnPbvM6KLpdrrQQ9ETw-1
Received: by mail-wr1-f72.google.com with SMTP id 33so400922wrk.12
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IQxJXzhc1czKuYkocMWwWEQUckk+RWA2innt4R1BD+0=;
 b=ASPS2V9u/6LNDlZ/bt92/j9jeORrcwQ2H+0cHveZjPuSWjdhXQV9I4Fl2LBMz1AsvP
 xNcmZig5/aHBP+Y/LD/RaOyWsFtfq8h7cujr/aGWQ3Ur5A1ipuiA8pHBDolS5LWEWZfs
 mliAKWhd/zNuR/BNBXg5f09it3CSJgNf0ZPV1BcJaFyYHc5xqwrUFtCgZj/DfluxX/Ec
 Gh283sOugC2hY+yxYou1gsaviq3mzLiTez5Ug4+fDTyeKPOy8cH5kcSWsvYMC+f7tQ52
 spQYqk7kh8kAJQTBPswJreV5AW9FDM8dW7cr8m8+HwQDY568YbCV6mU5zxJGoINzt/xb
 3hfA==
X-Gm-Message-State: AOAM530tVzTKkcbM4262j/S6NNJgzaQOFMnc9K47grpV6eVAQzI29J7K
 /K9hl9OJ5K42YWF4TfMvkz1q/ig/lpNcx/L+a1DAosb+Ssegoh4QfEQybTg3KzqQC3ifUw+PKT8
 oHHMuag1SO9LKp7M=
X-Received: by 2002:a5d:522d:: with SMTP id i13mr1818020wra.296.1601299198479; 
 Mon, 28 Sep 2020 06:19:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzblxRHV4qk9P2hlAVjSPw3Wp0Nhe/xUUzTvRLnKirvlK6osBca2K+2+wIrV8HZYIs84O6bSA==
X-Received: by 2002:a5d:522d:: with SMTP id i13mr1818005wra.296.1601299198312; 
 Mon, 28 Sep 2020 06:19:58 -0700 (PDT)
Received: from localhost.localdomain (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id k6sm1201517wmi.1.2020.09.28.06.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 06:19:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/8] qemu/bswap: Remove <byteswap.h> dependency
Date: Mon, 28 Sep 2020 15:19:30 +0200
Message-Id: <20200928131934.739451-5-philmd@redhat.com>
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
Drop the <byteswap.h> dependency.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure            | 13 -------------
 include/qemu/bswap.h | 17 -----------------
 2 files changed, 30 deletions(-)

diff --git a/configure b/configure
index e8e8e984f24..bff787daea7 100755
--- a/configure
+++ b/configure
@@ -4886,16 +4886,6 @@ if test "$docs" != "no" ; then
   fi
 fi
 
-# Search for bswap_32 function
-byteswap_h=no
-cat > $TMPC << EOF
-#include <byteswap.h>
-int main(void) { return bswap_32(0); }
-EOF
-if compile_prog "" "" ; then
-  byteswap_h=yes
-fi
-
 # Search for bswap32 function
 bswap_h=no
 cat > $TMPC << EOF
@@ -6789,9 +6779,6 @@ fi
 if test "$st_atim" = "yes" ; then
   echo "HAVE_STRUCT_STAT_ST_ATIM=y" >> $config_host_mak
 fi
-if test "$byteswap_h" = "yes" ; then
-  echo "CONFIG_BYTESWAP_H=y" >> $config_host_mak
-fi
 if test "$bswap_h" = "yes" ; then
   echo "CONFIG_MACHINE_BSWAP_H=y" >> $config_host_mak
 fi
diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index fed96dddd7a..55916670d39 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -10,23 +10,6 @@
 # include <sys/endian.h>
 #elif defined(__HAIKU__)
 # include <endian.h>
-#elif defined(CONFIG_BYTESWAP_H)
-# include <byteswap.h>
-
-static inline uint16_t bswap16(uint16_t x)
-{
-    return bswap_16(x);
-}
-
-static inline uint32_t bswap32(uint32_t x)
-{
-    return bswap_32(x);
-}
-
-static inline uint64_t bswap64(uint64_t x)
-{
-    return bswap_64(x);
-}
 #else
 #undef  bswap16
 #define bswap16(_x) __builtin_bswap16(_x)
-- 
2.26.2


