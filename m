Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466DDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 142822074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bshl83C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142822074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR89-0006gj-5t
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0S-00032V-0p
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR0Q-0006vz-Qx
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYPUmQb4YdG6fVvlkNEcNWtgTrI955nKbvTxVdHF9pE=;
 b=bshl83C/7Rd4/EGppnliWsORBjZq3h/J/Zq/5aVZos9R7CE6yzPyvvkk21ZFh47nYhxyqW
 YMvzzZqKsWVhA3z8tPtqsReWtc+VPpxJRZaGv4CNPoUTF/LvVztsTrUaxpIANiVsAODU05
 Cv23t9rJW79+YiL99TCyNpfxNMicCbA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-8i0FtZ3EOaiPwxJz33IjHw-1; Sun, 31 May 2020 12:40:12 -0400
X-MC-Unique: 8i0FtZ3EOaiPwxJz33IjHw-1
Received: by mail-wr1-f69.google.com with SMTP id l18so3650587wrm.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZYPUmQb4YdG6fVvlkNEcNWtgTrI955nKbvTxVdHF9pE=;
 b=c5yWa+5JUlXc/IRSZsv43GxvXIKVLMYpind+8IXcbsvujtXKIDXd9rOghcu4vbHzFa
 znNtpNom152ILMtC0EhZsPME6uQ3fUwI82826f9X87Qpc2gE1oh5tOSfXXcUlDkqEy6R
 jGa3GxsfF3Agym/ljqGbQm+o24fKEiK53dNdtmIHYUFqsavBew6ol+uozAwBeIFkUlg7
 7mVPC3fmu0AtdJxxhjSurkN5El7zMZG6T61tftnzO7SpyIDfcCa+lEtFSCZHVoLU2V7j
 5FdWn92goieUX0m12ngWfC6Ooa/eA2AnxUhhFFgSjvGJFRfndMDGUGe3gk8dqVxQ8B36
 e8PA==
X-Gm-Message-State: AOAM531sGIyDT9NyZ3IDtoJZb+mieBwIXhp43tATFny0wkUBAzZT9c5/
 SnYetAwsGUn76NFCnCO67rCp8fLFb507Rby1cg5YYJrRaGaMwILCIQpuU17Q3pvAT9wuvL0PACr
 //K8GFUFUavgOLPM=
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr17895544wrx.11.1590943211355; 
 Sun, 31 May 2020 09:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRd7yv6wPdWcd+XCZmDkbf6iSWHFTnRixvYzZNCu7K1dThRp4MzloCWxTm7st5mmh8HR0q3Q==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr17895523wrx.11.1590943211151; 
 Sun, 31 May 2020 09:40:11 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id s72sm8428958wme.35.2020.05.31.09.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/25] python/qemu/qmp: assert sockfile is not None
Date: Sun, 31 May 2020 18:38:37 +0200
Message-Id: <20200531163846.25363-17-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:38:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

In truth, if you don't do this, you'll just get a TypeError
exception. Now, you'll get an AssertionError.

Is this tangibly better? No.
Does mypy complain less? Yes.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200514055403.18902-21-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index a634c4e26c..e64b6b5faa 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -94,6 +94,7 @@ def __negotiate_capabilities(self):
         raise QMPCapabilitiesError
 
     def __json_read(self, only_event=False):
+        assert self.__sockfile is not None
         while True:
             data = self.__sockfile.readline()
             if not data:
-- 
2.21.3


