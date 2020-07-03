Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD2CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25D9220870
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5TWfZLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D9220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHhO-0001xR-BP
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc7-0007AH-Eu
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHc5-0004Py-Nr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rJ+ftu7sRo4+D1GoB2r1H/Xv24+UlICQh28kpGHM9w0=;
 b=b5TWfZLpKK+M2seSXbm8a1peCuUSVBFWHkBcDlqjqeLYqtcArCe01hRuZ4CHuJwbAZD4FY
 KtmUX77NPSpSRjIYzUth5iaAAbkR3QOqA0ws7bHr1nC6Ilj46pCt+pbvaltLXUe56JYdIq
 eUjRLdw83T+7WTYjDc7DNjDqLwC8Psg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-By23FoaXMGmtU0AnyMML1w-1; Fri, 03 Jul 2020 05:04:01 -0400
X-MC-Unique: By23FoaXMGmtU0AnyMML1w-1
Received: by mail-wm1-f69.google.com with SMTP id o13so34540893wmh.9
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rJ+ftu7sRo4+D1GoB2r1H/Xv24+UlICQh28kpGHM9w0=;
 b=iOFam0qrKDu2qQXNIQACxp2JqgfSfcYpnAg+d3vmgDKTEzOqj9U4Mqtcou2vp60vYJ
 JqmAGjxaBzBp1jnHiueZmQ5FGbYCskJCv+cIVPl+D78e66/y3UrqwgDuObdUt8luR5/F
 RuDXXwfBo2sbqOGLH0S4PQhaK/wm5ldVKvb/DtFzgZYO+aqbOcDrqcOeY+doeWS94P+c
 v3zF4Vl0qZ3wtwBWG8owUFuZK96fwwrpFN9H9y4YW7nN/+a1IOYPk/eCdjdfqLXr9N7j
 emn6lTK8gTci5XNKVv1sBYytK/iKYCnfBtDZZEOPYWVHhEh32seL8Ce4hVMwFaTkMpyW
 okZQ==
X-Gm-Message-State: AOAM530rcr3QbJHcHRnP03+FTrI9hzIJQ8V2+bU7Drs2/7C3pdRrE0lK
 GXwASa8OkwX2nOuwXbR5otDkJXwtST06KsY9ROB+8/O3BkdF6rqWMR54mk3YzdSqmOSGwH6K0P0
 2fcMA/sXl4G7bGME=
X-Received: by 2002:adf:8501:: with SMTP id 1mr39287481wrh.153.1593767039336; 
 Fri, 03 Jul 2020 02:03:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYqzI2lS1iFqxyE6OANc6HkegOhXR4P4a8ODviE/ZORnUP/WPyr8tUGKr55WuL++m5AZNR3A==
X-Received: by 2002:adf:8501:: with SMTP id 1mr39287463wrh.153.1593767039131; 
 Fri, 03 Jul 2020 02:03:59 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 q7sm1404083wra.56.2020.07.03.02.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:03:58 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:03:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] target/i386: sev: Use ram_block_discard_disable()
Message-ID: <20200703090252.368694-11-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

AMD SEV will pin all guest memory, mark discarding of RAM broken. At the
time this is called, we cannot have anyone active that relies on discards
to work properly - let's still implement error handling.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-8-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 target/i386/sev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d273174ad3..f100a53231 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -680,6 +680,12 @@ sev_guest_init(const char *id)
     uint32_t host_cbitpos;
     struct sev_user_data_status status = {};
 
+    ret = ram_block_discard_disable(true);
+    if (ret) {
+        error_report("%s: cannot disable RAM discard", __func__);
+        return NULL;
+    }
+
     sev = lookup_sev_guest_info(id);
     if (!sev) {
         error_report("%s: '%s' is not a valid '%s' object",
@@ -751,6 +757,7 @@ sev_guest_init(const char *id)
     return sev;
 err:
     sev_guest = NULL;
+    ram_block_discard_disable(false);
     return NULL;
 }
 
-- 
MST


