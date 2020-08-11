Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED3820774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VWRDYSIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED3820774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OS7-0006PK-Iw
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SUQyXwMKCpoM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1k5OQC-00050C-IR
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:08 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:53014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SUQyXwMKCpoM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com>)
 id 1k5OQ7-0000l9-HL
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:08 -0400
Received: by mail-yb1-xb49.google.com with SMTP id x10so15513318ybj.19
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kIYHcj8O3Sfi4MxJmcqz8ARBjlQe767Toz5vJcOBiIo=;
 b=VWRDYSIM5vTXIVcgrPYgfGx8la+AIP1rMuns3KBfJ5/F75+tNJgZcqQUOZNrAxwve5
 LgeLjYaXSUg5d7bBwlFT1kUPKojAzoSSZhjiMyrQU4XKu4DEWDjh5r4Iy2L0LpiO/E/H
 7EV7ACmZ7uDO7fHkRCLudmvgvYmqu4je8v8odXRATcuq77dLvOcKxb1Z/AdoMfIWyEck
 gQfTG0bvASOoC6GqMRcdR7G9Za76QirK+lglZ94P+AjdyeJh6Sh0x7cIY9+badPDBFhG
 n3Na6AQem5CCL6bREiX9I2GaIHef1lt03/BWKRWLjw3Y5WVh7DH9ZFwThc3NeGaQcv8z
 wGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kIYHcj8O3Sfi4MxJmcqz8ARBjlQe767Toz5vJcOBiIo=;
 b=SY03JdHcRm0g4f+jBz6m3lGG5Ee1I8D+AssImcv8hpq7jcyex9KLfqy5RZQOENJykN
 88CarY9VeudsRzN2oLsiBl/k56nQy4sOmieWQweisOiRPMDFTj8X/CyXblxVRniQ6WN1
 5EOwE1BV/oaQ4/It0F0RNoO5G3EmBxYojnJXooFds1fnNLu0VhAWDTJtRMlKqGZs6emL
 Ul6+GnPic07VCTAMv854htaFypP1VQWFmksCvpLObLcVxucwiulBVy7VwqXxc+Ry+D6t
 qDlwpWHr/AtcSpFaxHej0ot1/YkrwXEhKYuMI32zWw6sGMvpHm0DFMfcLzaY0CiSIc2w
 bCfQ==
X-Gm-Message-State: AOAM531e/QWucRtIRVN1/01O2BC4RuNYRx30IxpJ6OvgQpXBMKSbajnv
 Mhu/z6HlfGrwMXwknut8m9OWMeUv9wzEBJFrEt/X1H/65H38XF0KCrmzbcCajrV7SCVsfogYoYO
 I7HB3cwzUgezRwvsfaJFUEbka0VER6pChr61E1oBena+ioLAuxfsA
X-Google-Smtp-Source: ABdhPJwQnWeGsbzG9OmLZJ/f7NJFcGXqIIFQdcH7aJyscPo22k+tzzqS6Mb4R9/BogOnpKohJx/wcZA=
X-Received: by 2002:a25:aaf3:: with SMTP id t106mr42481925ybi.56.1597129801240; 
 Tue, 11 Aug 2020 00:10:01 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:44 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <7d61f792c22de8df3c6a9438eacc3906620e7c54.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 4/8] linux-user: Add IPv6 options to do_print_sockopt()
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3SUQyXwMKCpoM6QAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--scw.bounces.google.com;
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

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v1 -> v2:
  New: Add all IPV6 options to do_print_sockopt(), including the newly supported
  IPV6_ADDR_PREFERENCES.

 linux-user/strace.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 854b54a2ad..089fb3968e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -6,6 +6,7 @@
 #include <sys/select.h>
 #include <sys/mount.h>
 #include <arpa/inet.h>
+#include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
 #include <linux/if_packet.h>
@@ -2307,6 +2308,113 @@ print_optint:
             break;
         }
         break;
+    case SOL_IPV6:
+        qemu_log("SOL_IPV6,");
+        switch (optname) {
+        case IPV6_MTU_DISCOVER:
+            qemu_log("IPV6_MTU_DISCOVER,");
+            goto print_optint;
+        case IPV6_MTU:
+            qemu_log("IPV6_MTU,");
+            goto print_optint;
+        case IPV6_V6ONLY:
+            qemu_log("IPV6_V6ONLY,");
+            goto print_optint;
+        case IPV6_RECVPKTINFO:
+            qemu_log("IPV6_RECVPKTINFO,");
+            goto print_optint;
+        case IPV6_UNICAST_HOPS:
+            qemu_log("IPV6_UNICAST_HOPS,");
+            goto print_optint;
+        case IPV6_MULTICAST_HOPS:
+            qemu_log("IPV6_MULTICAST_HOPS,");
+            goto print_optint;
+        case IPV6_MULTICAST_LOOP:
+            qemu_log("IPV6_MULTICAST_LOOP,");
+            goto print_optint;
+        case IPV6_RECVERR:
+            qemu_log("IPV6_RECVERR,");
+            goto print_optint;
+        case IPV6_RECVHOPLIMIT:
+            qemu_log("IPV6_RECVHOPLIMIT,");
+            goto print_optint;
+        case IPV6_2292HOPLIMIT:
+            qemu_log("IPV6_2292HOPLIMIT,");
+            goto print_optint;
+        case IPV6_CHECKSUM:
+            qemu_log("IPV6_CHECKSUM,");
+            goto print_optint;
+        case IPV6_ADDRFORM:
+            qemu_log("IPV6_ADDRFORM,");
+            goto print_optint;
+        case IPV6_2292PKTINFO:
+            qemu_log("IPV6_2292PKTINFO,");
+            goto print_optint;
+        case IPV6_RECVTCLASS:
+            qemu_log("IPV6_RECVTCLASS,");
+            goto print_optint;
+        case IPV6_RECVRTHDR:
+            qemu_log("IPV6_RECVRTHDR,");
+            goto print_optint;
+        case IPV6_2292RTHDR:
+            qemu_log("IPV6_2292RTHDR,");
+            goto print_optint;
+        case IPV6_RECVHOPOPTS:
+            qemu_log("IPV6_RECVHOPOPTS,");
+            goto print_optint;
+        case IPV6_2292HOPOPTS:
+            qemu_log("IPV6_2292HOPOPTS,");
+            goto print_optint;
+        case IPV6_RECVDSTOPTS:
+            qemu_log("IPV6_RECVDSTOPTS,");
+            goto print_optint;
+        case IPV6_2292DSTOPTS:
+            qemu_log("IPV6_2292DSTOPTS,");
+            goto print_optint;
+        case IPV6_TCLASS:
+            qemu_log("IPV6_TCLASS,");
+            goto print_optint;
+        case IPV6_ADDR_PREFERENCES:
+            qemu_log("IPV6_ADDR_PREFERENCES,");
+            goto print_optint;
+#ifdef IPV6_RECVPATHMTU
+        case IPV6_RECVPATHMTU:
+            qemu_log("IPV6_RECVPATHMTU,");
+            goto print_optint;
+#endif
+#ifdef IPV6_TRANSPARENT
+        case IPV6_TRANSPARENT:
+            qemu_log("IPV6_TRANSPARENT,");
+            goto print_optint;
+#endif
+#ifdef IPV6_FREEBIND
+        case IPV6_FREEBIND:
+            qemu_log("IPV6_FREEBIND,");
+            goto print_optint;
+#endif
+#ifdef IPV6_RECVORIGDSTADDR
+        case IPV6_RECVORIGDSTADDR:
+            qemu_log("IPV6_RECVORIGDSTADDR,");
+            goto print_optint;
+#endif
+        case IPV6_PKTINFO:
+            qemu_log("IPV6_PKTINFO,");
+            print_pointer(optval, 0);
+            break;
+        case IPV6_ADD_MEMBERSHIP:
+            qemu_log("IPV6_ADD_MEMBERSHIP,");
+            print_pointer(optval, 0);
+            break;
+        case IPV6_DROP_MEMBERSHIP:
+            qemu_log("IPV6_DROP_MEMBERSHIP,");
+            print_pointer(optval, 0);
+            break;
+        default:
+            print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
+            print_pointer(optval, 0);
+            break;
+        }
+        break;
     default:
         print_raw_param(TARGET_ABI_FMT_ld, level, 0);
         print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
-- 
2.28.0.220.ged08abb693-goog


