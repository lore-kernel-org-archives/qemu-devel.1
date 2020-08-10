Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:16:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FE652080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ar5eFRu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE652080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DHz-0006EN-Qx
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DH8-0005Yv-0W
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:16:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5DH5-0001Gc-0x
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597086957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Qo9eE2JEpZ/NnQGDf84ZAL8KPl1+iUae6Ys4nerXOA=;
 b=ar5eFRu89NHj9D9lJLzhPNLB1btXaM7/jZcSiy6614ta5FJ2YvyR54SXaYDXZTSuVfMPdh
 YZgHEzhpRQQi8IvEBgTCPtjJcyebVYecTT7VpMl0dgy0tgKMQThC/GDaaqfzFCL8Q34MKn
 BjD1vvwTbz4FSXXp44G3KlUiq/K+7eU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-knVr86YaMD6k5R-fm9R5DA-1; Mon, 10 Aug 2020 15:15:54 -0400
X-MC-Unique: knVr86YaMD6k5R-fm9R5DA-1
Received: by mail-wm1-f70.google.com with SMTP id a5so141161wmj.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Qo9eE2JEpZ/NnQGDf84ZAL8KPl1+iUae6Ys4nerXOA=;
 b=aWQfpGKYUR+J+khESin11IXQyVpEiGi42nSe6bA78ClkkSViXooNshoGIt6JT8vh29
 RH6vk52Sl99gy+PzVOnipLjAXAcLaUR+kOZzP/g0pkmPP++6g5Dx05Guo16ENvusE8ze
 MawxNcYiocV0DWa9g0P5lnDGfhjbl6iiCOmJSZuVANf+gGSXznOVvHM+VhKT02ABHZTL
 aYffdAUxcW72posf4ackrFhCC+fxEgAawZwJyJx176UaatzO/dhBEEZhqsbotwDRBA7o
 hOlIYbG57OZWnyHlVAcFuxd5gpBTR8sfYTkxFgakf2fqPUrEuS2gwIZR170gx0Iw90RJ
 19ZA==
X-Gm-Message-State: AOAM533gUaaUHCvdvyTFZOgAPgFnGZe9Mn2m313L7oaxMbvfGQBEROUH
 BvGsOxqpa5TRdWCRPWfOP2BZ5+tvdVng41t/Tr/Zx1/cxHioJJj8B2T2oCcjROd6EnEH1XQN1Sl
 PK+xYLGTgfp/FMek=
X-Received: by 2002:a5d:4401:: with SMTP id z1mr25336318wrq.305.1597086953257; 
 Mon, 10 Aug 2020 12:15:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYn3qPOh3OgJd86SPRXxlzIB/CiuQYkaBCZfk83+meu34Z+5mGZHEwffI1AGEqTbF5kpRe5A==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr25336288wrq.305.1597086953024; 
 Mon, 10 Aug 2020 12:15:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103?
 ([2001:b07:6468:f312:5d6c:f50:4462:5103])
 by smtp.gmail.com with ESMTPSA id v11sm22402525wrr.10.2020.08.10.12.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 12:15:52 -0700 (PDT)
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Peter Maydell <peter.maydell@linaro.org>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ed10ac0-8b94-f3e3-dd49-af7e79d7517e@redhat.com>
Date: Mon, 10 Aug 2020 21:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/08/20 20:20, Peter Maydell wrote:
> 
> In file included from ../../contrib/vhost-user-scsi/vhost-user-scsi.c:15:0:
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> ‘scsi_set_uint16’ declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> ‘scsi_set_uint32’ declared but never defined [-Werror]
>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
> ‘scsi_get_uint16’ declared but never defined [-Werror]
>  inline uint16_t scsi_get_uint16(const unsigned char *c);
>                  ^
> /usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
> ‘scsi_get_uint32’ declared but never defined [-Werror]
>  inline uint32_t scsi_get_uint32(const unsigned char *c);
>                  ^
> /usr/include/iscsi/scsi-lowlevel.h:810:13: error: inline function
> ‘scsi_set_uint16’ declared but never defined [-Werror]
>  inline void scsi_set_uint16(unsigned char *c, uint16_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:809:13: error: inline function
> ‘scsi_set_uint32’ declared but never defined [-Werror]
>  inline void scsi_set_uint32(unsigned char *c, uint32_t val);
>              ^
> /usr/include/iscsi/scsi-lowlevel.h:808:17: error: inline function
> ‘scsi_get_uint16’ declared but never defined [-Werror]
>  inline uint16_t scsi_get_uint16(const unsigned char *c);
>                  ^
> /usr/include/iscsi/scsi-lowlevel.h:807:17: error: inline function
> ‘scsi_get_uint32’ declared but never defined [-Werror]
>  inline uint32_t scsi_get_uint32(const unsigned char *c);
>                  ^
> cc1: all warnings being treated as errors
> 
> (Looks like an error in the version of the system header
> file on this system, which, unlike my x86 box, defines
> the prototypes with "inline" (a change that came in upstream
> in commit
> https://github.com/sahlberg/libiscsi/commit/7692027d6c11c58948ec3c493abea808af00fdd0
> ).

This is pre-existing.  Because I found some bitrot (like this...), a few 
more executables are now built by default.  We are already working 
around it in block/iscsi.c, I'll add the same in vhost-user-scsi.c.

--------- 8< ---------
From 805320beafec25f3eadf9a7c58178427480f915d Mon Sep 17 00:00:00 2001
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 10 Aug 2020 21:15:19 +0200
Subject: [PATCH] vhost-user-scsi: add compatibility for libiscsi 1.9.0

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
index 7a1db16..3c91238 100644
--- a/contrib/vhost-user-scsi/vhost-user-scsi.c
+++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
@@ -12,7 +12,9 @@
 
 #include "qemu/osdep.h"
 #include <iscsi/iscsi.h>
+#define inline __attribute__((gnu_inline))  /* required for libiscsi v1.9.0 */
 #include <iscsi/scsi-lowlevel.h>
+#undef inline
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "standard-headers/linux/virtio_scsi.h"
 

Paolo


