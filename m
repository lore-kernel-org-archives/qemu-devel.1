Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2DBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DDE20771
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SM7GKmeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DDE20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y2Z-0003qR-FN
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53332)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Y1q-0003PQ-77
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5Y1n-0007ZC-Rn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lMYFuP2DoLKenv7WmM6wd7f3soJSo2LoPgWpQg7qTfE=;
 b=SM7GKmeRNWxhoEKFi1vZ8LnIQRYzLQBi/h1Iyocdv9KDEpWrm0CR01C6vC8380Q/gno014
 Qy0DMJzCYz7h/bGYOvbVdSopfDAaXAO0CZkXRmdDPLRNXAIBnc+RoeqMdxLc7sygQvHX5p
 UkpRBHryubsSCQg3OU26PXlxPm8Vqkw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-2H0o6ka_O2Wwby-bSBjfBQ-1; Tue, 11 Aug 2020 13:25:26 -0400
X-MC-Unique: 2H0o6ka_O2Wwby-bSBjfBQ-1
Received: by mail-wm1-f72.google.com with SMTP id p184so1215875wmp.7
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lMYFuP2DoLKenv7WmM6wd7f3soJSo2LoPgWpQg7qTfE=;
 b=imhpHHYGscjpB9mp0UGE8vpopQt5IPJ8CCmxSrhBe41+jve7EV2zUvldRnNnvl8VLI
 HQbIwZKxge/frEyOHHuZlrQb3QG+ljkNfOvtna3q+utH+vjcG16jyf2icuKUDVA9VKLI
 1Q3xCexEptRSm4w6hw6S8zyCodIEKZIGb2T+zSqXLNigA1rIjIYXQNkUF4tBB7uFopOS
 BEm0AcDcfF64M+X1SVEsWUHjOhyimNpJQIKDGoYakzrYuCI9CnOu69BgPGmyB6Pk+k3B
 G+Okay/p0SD3AlSI7JM952JGkBTwKGNah9oAHJit83aBoGi5CCE+NEIziy6gIoAt2Qxe
 e2wA==
X-Gm-Message-State: AOAM530oPO675WdJ83hmRRpY8MnpomLns+5QJIEUAPC0xGdNTLfNvvjn
 E1O0riufenBcYPbPsM4D2on5qb2luuvHhj3ES3BqXt3IL8WVFPvE68thVBXUS2g6znVuxRyqWwK
 0pTGdJZV+G2A7dQQ=
X-Received: by 2002:adf:ee06:: with SMTP id y6mr30214401wrn.225.1597166725721; 
 Tue, 11 Aug 2020 10:25:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxs4NK++TyoTFqTB4QApTjqEUD9L3deSLmCeFr7s3/jLG/Rxs4f8Zm95KphbA7na/m0DeFVA==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr30214388wrn.225.1597166725460; 
 Tue, 11 Aug 2020 10:25:25 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.12.249])
 by smtp.gmail.com with ESMTPSA id c14sm27742985wrw.85.2020.08.11.10.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2020 10:25:24 -0700 (PDT)
Subject: Re: [PATCH 139/147] meson: replace create-config with meson
 configure_file
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-140-git-send-email-pbonzini@redhat.com>
 <21cc800d-c8bf-b737-1059-b83044ad9271@redhat.com>
 <3fa2ac37-b2c1-cc90-28b0-e8361472b331@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8e57a0d-fc5d-1b59-993c-28b87f89b147@redhat.com>
Date: Tue, 11 Aug 2020 19:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3fa2ac37-b2c1-cc90-28b0-e8361472b331@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:49:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/08/20 18:25, Philippe Mathieu-Daudé wrote:
> Alexander reported [*] a problem when ARRAY_SIZE(whitelist_rw) == 0 you
> access an undefined address:

But that's not accessing an undefined address, it's taking the address past
the last item---which should be okay.  And I cannot reproduce it with:

	#include <stdio.h>
	const char *x[] = {};
	int main()
	{
	        printf("%p %p\n", x, &x[0]);
	}

and -fsanitize=undefined, using either GCC 10 or clang 10 (it breaks horribly
with &x[1] so the testcase makes sense).

This should fix it, it should also be unnecessary but I guess I'm not going
to nitpick:

diff --git a/block.c b/block.c
index 67ca5433d5..2ba76b2c36 100644
--- a/block.c
+++ b/block.c
@@ -433,9 +433,11 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
 {
     static const char *whitelist_rw[] = {
         CONFIG_BDRV_RW_WHITELIST
+        NULL
     };
     static const char *whitelist_ro[] = {
         CONFIG_BDRV_RO_WHITELIST
+        NULL
     };
     const char **p;
 
@@ -443,13 +445,13 @@ static int bdrv_format_is_whitelisted(const char *format_name, bool read_only)
         return 1;               /* no whitelist, anything goes */
     }
 
-    for (p = whitelist_rw; p < &whitelist_rw[ARRAY_SIZE(whitelist_rw)]; p++) {
+    for (p = whitelist_rw; *p; p++) {
         if (!strcmp(format_name, *p)) {
             return 1;
         }
     }
     if (read_only) {
-        for (p = whitelist_ro; p < &whitelist_ro[ARRAY_SIZE(whitelist_ro)]; p++) {
+        for (p = whitelist_ro; *p; p++) {
             if (!strcmp(format_name, *p)) {
                 return 1;
             }

> The question is why CONFIG_BDRV_RW_WHITELIST & CONFIG_BDRV_RO_WHITELIST
> aren't generated by meson.build...

What do you mean?  If you mean why they are in config-host.mak, it's because I have
only done a very minimal conversion from config-host.mak to Meson options.

Paolo


