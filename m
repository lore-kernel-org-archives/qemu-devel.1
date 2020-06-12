Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4EBC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9758206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxlE1exB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9758206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfVu-0003Fq-3K
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTN-00066y-9B
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51785
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfTL-00075R-N1
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ivyv44xux+7XXoWqIGIFlp2J/zNwQnYxF0RJgaexm5s=;
 b=QxlE1exBbi3UXCL/peQ9FpQ87b4HhP5Tnfi5yLRNeW/0QYujX6xbKNc0v/gxAPRV8fuKqT
 V7FpGWZZ1c2NP8BjAskYXttblB3ZWvrPtdLCxadTwUtIVn6INWPM6/cApJatEGBCRp9s+I
 gUaRVLDyvED0HXfx9ZKTzyLv7zVaDDM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-snoDi3QrOqS8XAUIdZvv-Q-1; Fri, 12 Jun 2020 04:55:32 -0400
X-MC-Unique: snoDi3QrOqS8XAUIdZvv-Q-1
Received: by mail-wr1-f69.google.com with SMTP id m14so3643282wrj.12
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ivyv44xux+7XXoWqIGIFlp2J/zNwQnYxF0RJgaexm5s=;
 b=ePIORhNKAoKwzqS50jVmM1X6x71OjTI6OvGjgIzGtp8nr8AIk3SYQpjp0LYrK6CKLv
 7dxE7njaPfAzcc1HwRHrbTEh7EMNqCPe9kR25pzVM+P+FdOybnWZNDHnZr1WHkksBFOz
 tLQBuyXYt4zUsrvyoQQ+3niByHtuELHh3RKA/Qec/C0GywIzEaQWdekl11MCqU88fBS2
 MtW//Wnz3V+26pZSD4cv/RbQOd4ruQ8rIed3haniCsVXyn6e6eRBLzcW33SEirzhxwCy
 fY81RqQLepJoVFQwqU0f7VY4SX+uG1OOeiKmsJHzNTTAA9foBHOc3iY4htDaUGbFlUfh
 aErg==
X-Gm-Message-State: AOAM530QFx8XaG3Bb3mSS6B3OX4UbqEu3GM2zllQ4k9AweKGM4EncXyI
 a6ps3eqw6KQp9bIIUANH4jypq/ATWJo5oEWXeMnpzECCd98HTZNjDLi8qk9P5YFGT7WRWaDEQob
 TbusqXQw+TD27EbU=
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr13808627wrp.230.1591952130949; 
 Fri, 12 Jun 2020 01:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/1j0Bdv+A/TBhB2J0XdCQJgpvvavymbtOLMXW8kG62ErUOnyusHhs9y/pOUKVjBRcpwunrw==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr13808601wrp.230.1591952130723; 
 Fri, 12 Jun 2020 01:55:30 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b81sm8394553wmc.5.2020.06.12.01.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:55:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/12] hw/tpm: Make TRACE_TPM_UTIL_SHOW_BUFFER check local
 to tpm_util.c
Date: Fri, 12 Jun 2020 10:54:40 +0200
Message-Id: <20200612085444.8362-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:55:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The trace_event_get_state_backends() call is useful to avoid
making extensive calls (usually preparing arguments passed to
the tracing framework. In this case, the extensive work is
done in tpm_util_show_buffer(), and the arguments used to
call it don't involve extra processing. Simplify by moving
the TRACE_TPM_UTIL_SHOW_BUFFER check to tpm_util_show_buffer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/tpm/tpm_tis_common.c | 8 ++------
 hw/tpm/tpm_util.c       | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 94704870f6..1779b4fc1e 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -78,9 +78,7 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
-        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
-    }
+    tpm_util_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
 
     /*
      * rw_offset serves as length indicator for length of data;
@@ -246,9 +244,7 @@ void tpm_tis_request_completed(TPMState *s, int ret)
     s->loc[locty].state = TPM_TIS_STATE_COMPLETION;
     s->rw_offset = 0;
 
-    if (trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
-        tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
-    }
+    tpm_util_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
 
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s);
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index c0a0f3d71f..12f19465c5 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -357,6 +357,9 @@ void tpm_util_show_buffer(const unsigned char *buffer,
     size_t len, i;
     char *line_buffer, *p;
 
+    if (!trace_event_get_state_backends(TRACE_TPM_UTIL_SHOW_BUFFER)) {
+        return;
+    }
     len = MIN(tpm_cmd_get_size(buffer), buffer_size);
 
     /*
-- 
2.21.3


