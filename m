Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB14C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4449E21744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uRMQR5OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4449E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Zzo-0002TE-DA
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0S-0003wt-Ug
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Z0R-0003fX-Uo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:08 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Z0R-0003ew-Mi
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:08:07 -0500
Received: by mail-wm1-x336.google.com with SMTP id i10so970032wmd.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QL74FXwo5fD2SXPQVC1GZn7aE6A8HimpNFP2yM67+qI=;
 b=uRMQR5OCpXk3GNJ+wX6EzmWT5zBEOJwJc7ntvhgfhjOpxm+zYTGRCT48BnsUMA2los
 S6CSswxa7U3PVrdYwFsmBfeLelAewrANgNhQhnNyDEpxZDXkIhYOobazHZL2NiFiQWw6
 DkGxoDFSDCnLg93GiovPKHbZOFqiiI/vJTFFu5/Nyhb5lxCYoUFYi/wcz3FDw8WGrHo5
 /8qpLABr4XJCeogP6o+gyQEyL2BOTy4L2UiPWuqNriQ/dQymlSiRqT+R//pA7fMDF/oE
 KPQfYaiTDc4DMq4wHI5YgYUUDpJ317S4o6ghgHCVEABUm2CGXRjsA2Ib9x6rKalSeXRv
 tXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=QL74FXwo5fD2SXPQVC1GZn7aE6A8HimpNFP2yM67+qI=;
 b=X8Q3XmJDjYUCXtRre6OA73fnTDCjtRF/KFMdMhCcj4gT0THdKhFLScstB8AU4xONmi
 4HiEdq4mjDb2Ul8S/wXV9NiGlWJxy6Z+D60UjKl3SCRSsooqveOR8BQXvd7cOhGFffbR
 hY6iG/fotOCZpwaPsJ017jst2Uzu7GQQIQ3Co8eYPcAfb9X6v0KhysFMnR90NeWrcBHo
 kOMgHYb1qsjX4XrRp0Dba8HIyKzQox0AYiw+vV9JIdRAXRC8ykZgKwYXE3L1qpb8/5Jb
 GJd/DkJk9CEPhK5/GrTJhwGfAnWpECXiqGfqpeUtJvnBjTGUNzmL53fu25p1kuqw/77V
 du1g==
X-Gm-Message-State: APjAAAVVE0JlRKTrkLKq5LKtoKTIWP+2Tm0Bf3aM9LS3NJThzxLfCSPO
 2NDANC7wP9Fq1E8jc5Y+0yPXCg6e
X-Google-Smtp-Source: APXvYqzH31Mdwsf8F3Fh4FVc+PROgAJgP9ejtaLptQ9UsyJTrZVsnVElKEVmqR680q3E7LxmwCPTOA==
X-Received: by 2002:a7b:c218:: with SMTP id x24mr4769596wmi.149.1582632486380; 
 Tue, 25 Feb 2020 04:08:06 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id h13sm22709423wrw.54.2020.02.25.04.08.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 04:08:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 133/136] qdev-monitor: Forbid repeated device_del
Date: Tue, 25 Feb 2020 13:07:31 +0100
Message-Id: <1582632454-16491-31-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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
Cc: Julia Suvorova <jusual@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Julia Suvorova <jusual@redhat.com>

Device unplug can be done asynchronously. Thus, sending the second
device_del before the previous unplug is complete may lead to
unexpected results. On PCIe devices, this cancels the hot-unplug
process.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20200220165556.39388-1-jusual@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qdev-monitor.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 8ce71a2..8a2a953 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -887,6 +887,12 @@ void qmp_device_del(const char *id, Error **errp)
 {
     DeviceState *dev = find_device_state(id, errp);
     if (dev != NULL) {
+        if (dev->pending_deleted_event) {
+            error_setg(errp, "Device %s is already in the "
+                             "process of unplug", id);
+            return;
+        }
+
         qdev_unplug(dev, errp);
     }
 }
-- 
1.8.3.1



