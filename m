Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08502C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C95DC206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEIaM7A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C95DC206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPlH-0004aZ-WF
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPfn-0005fZ-Vl
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jjPfm-0000bm-1L
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591891400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/GQD4lAJJ5ICleMlXPowioaefks84ty8lBKrWWjqKg=;
 b=XEIaM7A/pik45Sl0c/3nuYiFXSnOFI/v3PcfPjBJoaVix5hXmI5v+yaZvoePfFoieJYM7v
 w2mi6XbQBBMycleoN9OD9aTHauj7GL0kCxL++eMU6MhSqbY3JCJZQwAAMibFay0oGCsTKv
 leaxYLWwl4npNc4ct9BDiYpn5xSUR50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-cltclGvoMqiY6FDjH6MUiQ-1; Thu, 11 Jun 2020 12:03:15 -0400
X-MC-Unique: cltclGvoMqiY6FDjH6MUiQ-1
Received: by mail-wr1-f69.google.com with SMTP id s7so2726927wrm.16
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/GQD4lAJJ5ICleMlXPowioaefks84ty8lBKrWWjqKg=;
 b=r2pj+Y+vYtiNLE9TE5kGa6iK4AONxaMAYdTBjVV+JTk7E2AwS13nYFr0cDXkDLRdQi
 4PVsFZ2Q8wv3HtSK0oq9jFcD+DAVFlTZ33/vP4iADBcaahFDIzqGPPfHHAxCjZd7Y1jL
 oxnmqpFc1+nCuZf8i3L1X+Fa7IjgCaud8ejjtDGewhdlB0+Ba3bfgk1momLkQbTrsOHh
 KzMzhpth5EvzS8iDDULGJemMoxDxUo9ooIonfdd5QgTFeUIX7cnp8nncnfapxHD/tjvV
 D9NUWgcwIrs2rkEEVpvSf2wUGPpu8eAB6nVfQxl+k8ZZcYc9K3HngVWaEE2a4lCaPPQS
 oq1g==
X-Gm-Message-State: AOAM5317E2TAbDmLyrHRnvHofOiNNq8CehaH8CpAMWOZZnUqOO9Y5F0b
 daYePHXJP7kweQzGMPRKgDbIByn0xU7tWs8n/wH8dU6gyUDErVtKEmRURDwmA8byrV6J42/bII5
 SynrPQmAXPyAIhFo=
X-Received: by 2002:a5d:608d:: with SMTP id w13mr10156003wrt.298.1591891394546; 
 Thu, 11 Jun 2020 09:03:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRu5pl3GVx/86EtkVzXlDKEuxJFHnM2YWAM5CuzPHINFI1FOpnMM3w0N+qnaIKGGHjaEI+fw==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr10155992wrt.298.1591891394384; 
 Thu, 11 Jun 2020 09:03:14 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id z2sm5396064wrs.87.2020.06.11.09.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 09:03:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/11] docs/specs/tpm: Correct header path name
Date: Thu, 11 Jun 2020 18:02:56 +0200
Message-Id: <20200611160306.2751-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200611160306.2751-1-philmd@redhat.com>
References: <20200611160306.2751-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 8dc6701722 introduce the documentation but an
incorrect path name was used. Fix that.

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


