Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 04:32:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD3E2071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 04:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="P1EWR/GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3E2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA49p-0001Fn-Eo
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 00:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kA49D-0000QC-0r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 00:31:55 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:39385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wanghonghao@bytedance.com>)
 id 1kA498-00032w-8e
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 00:31:52 -0400
Received: by mail-pj1-x1033.google.com with SMTP id j13so3536233pjd.4
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 21:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ymbq0fI8IdEu2KgMabrZZCPF3UyfAuYJCEFO8Pn1QI=;
 b=P1EWR/GVn4zuAEda2XQRdnsoVEi2u3In8gLFz4UaYdc0hLEpEqOEfHMQUJ1Nlcl76g
 gXP228t0qKGH6Ey7dtBMIssCAyohJOETS1V8OCEcR3RFGB2jx2gDmVpTKyFjp5kkaWpx
 gubXAbfFvV7NQDgMIMpugbL8OTVNwsBN0URUFalhZFSGWywiIBbXrT/HaJvCz1chT2WW
 4pzsyu242qVn/2JW3RwAomTjOhYV+q5qAnvLLDkbqhObODJQA+o/1NqG9DhNelqrp4H+
 kZizIkGiXsix5DN8ZpvkagFAh5vtAwiUX1nHzWcyD4ND6aEr1FpEoz+rXNQ6w+aaxHGX
 n3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Ymbq0fI8IdEu2KgMabrZZCPF3UyfAuYJCEFO8Pn1QI=;
 b=YsJFCyPlVC7a1Z9vdZLKXwjc5DAh/g1nyIMJtqOzQdmyzy7tORaIMmt12Pi+kpRUCH
 8XlM3PaAuynhrjYVjzgq9XH5aDJWPO+I6YsXTL/74JHR6u1A3PGMG5dpAdQLcT3T6lgN
 BsgJ72yig7R0KFtwGxGjd4lje7BspxEd6hUqHy5XeujzzSF7ILVAC7KqNlL63k9J3384
 hvsvOYAyMMg5FslZiuc1W4V3vQdGiAelRtzxvpPIjIAoytWPMZci183PEsFBkkiwrLxm
 Xp6UjYU43hjHRD4hkhQeX/6AlmqzUS28kOf7hyG70amkSnsV9Uq/vAykTnCfZYEv08Qk
 ErAg==
X-Gm-Message-State: AOAM533vMufacoT+qcu8d+Rd4D218oBIKT2B9Z5lPoanGBqmjl9xbCSH
 YXRB52IBAMR47YOqcC47K1FDhN+7eMV7TWWKIDo=
X-Google-Smtp-Source: ABdhPJxJ0gfyYbj7L6DKQXPTDW1C3zfn9Knl4ralfdDYbB32XQmhJ1zTCnkETLzCdtDhZbaDMIbfNw==
X-Received: by 2002:a17:90b:c97:: with SMTP id
 o23mr3285301pjz.216.1598243507345; 
 Sun, 23 Aug 2020 21:31:47 -0700 (PDT)
Received: from MacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id d124sm1623237pfa.40.2020.08.23.21.31.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Aug 2020 21:31:46 -0700 (PDT)
From: wanghonghao <wanghonghao@bytedance.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] QSLIST: add atomic replace operation
Date: Mon, 24 Aug 2020 12:31:20 +0800
Message-Id: <20200824043121.13421-1-wanghonghao@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=wanghonghao@bytedance.com; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 wanghonghao <wanghonghao@bytedance.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace a queue with another atomicly. It's useful when we need to transfer
queues between threads.

Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
---
 include/qemu/queue.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 456a5b01ee..a3ff544193 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -226,6 +226,10 @@ struct {                                                                \
         (dest)->slh_first = atomic_xchg(&(src)->slh_first, NULL);        \
 } while (/*CONSTCOND*/0)
 
+#define QSLIST_REPLACE_ATOMIC(dest, src) do {                                 \
+        (src)->slh_first = atomic_xchg(&(dest)->slh_first, (src)->slh_first); \
+} while (/*CONSTCOND*/0)
+
 #define QSLIST_REMOVE_HEAD(head, field) do {                             \
         typeof((head)->slh_first) elm = (head)->slh_first;               \
         (head)->slh_first = elm->field.sle_next;                         \
-- 
2.24.3 (Apple Git-128)


