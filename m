Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7A62070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlYALKah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7A62070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNeib-0001Yb-Ed
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjD-0008IW-Li
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iNdjB-0007tb-I3
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:36888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iNdjB-0007tE-C7
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 10:04:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e11so17538969wrv.4
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=tKEZ3xBORUH745lD3K4++eyOpvEvcJPLpryLwnDHKcA=;
 b=KlYALKahNrJgFupyMnWGV0LlYr32drx9DnG/SugQq6IuVOVVjRaWxWpEGDO1XbhjFC
 keugCdxBvjG5HmVg6dpx4HKuTfXECz1KuMALAnPl59mELmoLQvumifgoOc/siIAg+idl
 318wjDZbc6QTr+EHdm9JEIMXuvKGNmZS61D1WZETZOTuYc037mHVHAhTaHkIXrSnw5y/
 +5E1HyKTsuRxyVea7ZTJcgDQB0xwE97oHkkiZJeI6+ITBK7hwGz+r0ohzlucDetv11t3
 28QudQkeS7FqssnX9PkhmdoSGOBlnNL7D3SdPLldYLTlCmjwhhdbgs4JXJ43VSpR1uGb
 PI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=tKEZ3xBORUH745lD3K4++eyOpvEvcJPLpryLwnDHKcA=;
 b=O5BdOjO7l5r7HkgbAF0mTCczu91/hd+47wC0R9Z+3NbWBu9NqhacONUXJPcNdO9nWF
 gkE818xdPPcgqGaJs+I968NRPyVaczxXy8y7POAbP+O1YzhZnmd+7hNPzolukoq4jom/
 XyrfeOpIUVPqz3CUAAh0BphNNqGfRh26wh3KAGP7Z1/LSRyJdUUkM+2DymMhpqaUoMBg
 kkuXl/+ve+FpLn+nf0SKzAQuwMh662ca2SHb03mUq+ziXqcdFy2/7/ZMflTQxoLKmLfI
 bk/BkK8tuAwQ8CH1fExwLxbxb7jHhkN5ogC0A68iX1mM56SSVWJpNFQjUP9kX1aK1gEn
 d0Dg==
X-Gm-Message-State: APjAAAXX5YcsziPX0pCYe1YswdbWnqy4LWNjsUD+/gcOybAbNbjW6uzS
 8Lt13wAHsE8quY4Jy0wstbhPcLM5
X-Google-Smtp-Source: APXvYqxnVvBj2e5TpYey+vMYgfaOnlGHnVomlb65E2bZN3wJr/Wsage04i80XZzjZehgmA/Zp1v1xw==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr3904767wrr.108.1571925876167; 
 Thu, 24 Oct 2019 07:04:36 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b7sm10610155wrn.53.2019.10.24.07.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Oct 2019 07:04:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/39] audio: fix missing break
Date: Thu, 24 Oct 2019 16:03:51 +0200
Message-Id: <1571925835-31930-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

Reported by Coverity (CID 1406449).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/paaudio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index df541a7..55a91f8 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -385,6 +385,7 @@ static pa_stream *qpa_simple_new (
         map.map[5] = PA_CHANNEL_POSITION_REAR_RIGHT;
         map.map[6] = PA_CHANNEL_POSITION_SIDE_LEFT;
         map.map[7] = PA_CHANNEL_POSITION_SIDE_RIGHT;
+        break;
 
     default:
         dolog("Internal error: unsupported channel count %d\n", ss->channels);
-- 
1.8.3.1



