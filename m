Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010BC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA9D2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOdFXJbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA9D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL1hp-0007ey-51
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bs-0008IZ-9d
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22220
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL1bq-0001Lb-3W
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600855364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iC4V1PEXAFDMxJmiZikknRbb4O4GLLtG0+6GroPagmU=;
 b=FOdFXJbqF0Ddync/tk66cSYAR85g97darBJ/dE+806i197+vZ63BtSqIhqTA4LidWIK9Bj
 W7tXRNt1MR2VSz0wGo++ssaSODGPocCMGhIRVpJ2qzc78l01Vf3r77EZfHz6Zfh0tfl2eV
 wms5u539f1PvtC0HYMLsKguH1lzBAnM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-aaMKGIxzMpK25O8ef3zEfA-1; Wed, 23 Sep 2020 06:02:43 -0400
X-MC-Unique: aaMKGIxzMpK25O8ef3zEfA-1
Received: by mail-wr1-f69.google.com with SMTP id d13so2209517wrr.23
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iC4V1PEXAFDMxJmiZikknRbb4O4GLLtG0+6GroPagmU=;
 b=ZhJKFyvPfaX66yZNWCRkTngbSJqimia93oCeKBChX4C/jyS83v+Lrse5dAT1Hqby1V
 5gCmq9xTDTsR5oUyHiHaWNX7cjtYDxqZ9JStMwMstQgxEl0JHflUZdzpJVDU1OYk/rWw
 xBRmH9OJxmcEgxYigpdfXQnGlQ4PX7dQRWtviUKqfLI9OpzaandDioVPK/qwAnzcXXMj
 L+ryMKvTehJphhptiSEWHeE57wZgPSBxTKso7rYoJ2X5z3Lo3m0g+lLKEelwT8jhqjcF
 uLZlY63FFQlZglsiEs/iy5mu7Le5dbftYnHvMXppXuBdz2FlDI6gh5AEFAQCoFgFfc36
 uU1Q==
X-Gm-Message-State: AOAM532IeOhWwqKZT6y93UG8m/oYV+gcF5N3tKSN+C0/QK096sqTPY+t
 +zeXVlUPgWF3j46T6MFH4bANe6JUfgViwHokmVyin5xnpUTwFf2uj+nSQ0JVctPROokdtmsySbh
 6jgFEquT58bSOKv4=
X-Received: by 2002:adf:f190:: with SMTP id h16mr10400887wro.202.1600855361848; 
 Wed, 23 Sep 2020 03:02:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUIwPj6O+U3sHYM/lPBsqJT2haHD47XIhumTZJ21A6kuR3lVIPUaxsGQGtiVtqI625zQGZqQ==
X-Received: by 2002:adf:f190:: with SMTP id h16mr10400869wro.202.1600855361707; 
 Wed, 23 Sep 2020 03:02:41 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d5sm31892640wrb.28.2020.09.23.03.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 03:02:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
Date: Wed, 23 Sep 2020 12:02:20 +0200
Message-Id: <20200923100220.674903-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200923100220.674903-1-philmd@redhat.com>
References: <20200923100220.674903-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All our supported compilers provide the __builtin_bswap()
functions. Drop the <byteswap.h> dependency.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
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
index 6875e48d617..c192a6ad3e7 100644
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
 # define bswap16(_x) __builtin_bswap16(_x)
 # define bswap32(_x) __builtin_bswap32(_x)
-- 
2.26.2


