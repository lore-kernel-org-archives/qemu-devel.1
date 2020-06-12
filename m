Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD4C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A32206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XLDpqQAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A32206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjfTn-0006bh-Kg
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 04:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfSn-0005AU-Mp
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25883
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjfSl-0006xL-HG
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 04:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591952097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5GHBSuF7Q+CJBw+7dBn2iaHmKbWBMMH0+Nvg3ibl58s=;
 b=XLDpqQACgyWj3bRZ/pb60cCqOSzBh4gOH9ObohtK+iaIRdE/gBUPaQCItnRDO1GfrHZLTF
 WSKp5caPa5H8BYSvbaBXbZw9j+ylFvd90L9VeacfGebejFK9offHpRhhknBCd6SPRmIuWC
 V05uZMzx47Q3fX5+2T6zHMZOdxQDiqA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-KMTnKCFdNBG-YQmWoPjcKQ-1; Fri, 12 Jun 2020 04:54:55 -0400
X-MC-Unique: KMTnKCFdNBG-YQmWoPjcKQ-1
Received: by mail-wr1-f71.google.com with SMTP id l1so3642490wrc.8
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 01:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5GHBSuF7Q+CJBw+7dBn2iaHmKbWBMMH0+Nvg3ibl58s=;
 b=sPBHTzd4t+7N0EOty46vHtxj2RcIow42n1UQOYJKyVk4FJtlpBPxaTySXpqIL1Xsa8
 jLw7QBewFaeIb+orV8zNdy/aRDzSy72Ydn+n4+x+Amdt69QuR4+JoRWQmS2H2Z0KIdov
 XX2HjGhAvXP0TjktqYXX5IPBMzseaINdobZYzRzSFjcM7SHhINOEAYOBA4rwzI4yUQS0
 h27DXlFD1eDdSdq0I2hYSdkAUXtbbRFZeO+pwxm6gDDsg0wQZcnOmmxp+7t+Bw/GK+t/
 L04+WqfoICxVnuCdoYKZfSFOB7Az85bVb8f+GFaY0+6KnIWNje0aCfm+O+Pp6lzZ7V19
 y75w==
X-Gm-Message-State: AOAM530joDbM9IqI3L2gugoqn8uaP9ESeocg6gGcL1xZj1yZ6su1r+C+
 Q8h83QBnE/p0ympU7BQxF7nauOcp11MbDywxF0jI05cl/xq0gfIHpmM85gU7VJslsecbGcNDSr2
 NmZ8Yz/Hxao6Gf9c=
X-Received: by 2002:a1c:f301:: with SMTP id q1mr12301048wmq.110.1591952093726; 
 Fri, 12 Jun 2020 01:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqhDCdRl68UmaQpiMZNriLEsGk3nedDOWqe1PJXCPTSPMtCieXNzuYPRry+6IWQ1jp5a4rxA==
X-Received: by 2002:a1c:f301:: with SMTP id q1mr12301031wmq.110.1591952093518; 
 Fri, 12 Jun 2020 01:54:53 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c70sm7470421wme.32.2020.06.12.01.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 01:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/12] docs/specs/tpm: Correct header path name
Date: Fri, 12 Jun 2020 10:54:33 +0200
Message-Id: <20200612085444.8362-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200612085444.8362-1-philmd@redhat.com>
References: <20200612085444.8362-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 04:54:57
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

Commit 8dc6701722 introduce the documentation but an
incorrect path name was used. Fix that.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/specs/tpm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index 5e61238bc5..9e48e3b981 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -199,8 +199,8 @@ to be used with the passthrough backend or the swtpm backend.
 
 QEMU files related to TPM backends:
  - ``backends/tpm.c``
+ - ``include/sysemu/tpm.h``
  - ``include/sysemu/tpm_backend.h``
- - ``include/sysemu/tpm_backend_int.h``
 
 The QEMU TPM passthrough device
 -------------------------------
-- 
2.21.3


