Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB8C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661E0206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 12:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdP17KFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661E0206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipAXq-0005SQ-4S
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 07:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWE-0003ZT-Ha
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ipAWD-0004Cu-Fc
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:54053)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ipAWD-0004CT-A5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 07:33:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id m24so2289955wmc.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 04:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UqcGASlTCMJvprrArRFDwqMRetNCkLLbCVZeMkPWPJg=;
 b=RdP17KFj2BiPki7Bf5fmZctgh+lPGAjGZEPJvapioRSAPV6h28o/7eSDbSqXDoTJq/
 ftKdNYpL5FXE9XFQ5TTVAAdu2WRedc0mmGkoPYS/eKX8FbOiX3vNs81yJ0SBKHpGV57K
 7LPIaUtyCVih9nv4t9r6M79EWWCGmhLObIoVSciECgprZxjzUB5NZSzT59n9YXtYZraL
 ONVOMj2d6GUOAP7DCnnuHdCNrQpRzPS1tRj5H5GL+EgKPrgf5bcWffCFBU61dg0CddJ+
 wGoXBl3TLCtAcVXJxuW+kQpaWazo04AspqqblzeKGlVvDuePxC+6TsbZds0c0naVe+VM
 YqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UqcGASlTCMJvprrArRFDwqMRetNCkLLbCVZeMkPWPJg=;
 b=fBck4D3UkEDOW+QCDNx9KmXs3dimwml5y8HTMJjSGCfqvnNCaqeaSGVWl+IRONIT61
 EqPp7VBCbb7H9YblG2mC8yLnsTYQqS/O3jeN/Q9Ru7VNcadfHK2ctoICoqvfbzCSGHUY
 riRDib7Fr3QodbMNX69SROqSdsHb0bEOSeOTdr+UdLGjg2Ge28l+QLvQQDUAQu5lnoHK
 M2SJW8lsb3Cda+nsNLUhJtvF4fos9OqDJ4Rzs8zzRgBmU/EcCl0kaj7j/Li2BcmGcX+K
 Y4XLAZ4zjg+Tv0wpT+mcPaAehQSMFuVTd8IU1VNC0KZ4+kx+XLf+lJ0SbgYkZH3jOxt/
 JAJQ==
X-Gm-Message-State: APjAAAWRZDZGbkPQ27aOw9w3/6CY0PZuPgc5NS9yqh07uY3f/+AC29Ou
 52e3wSUBKoeJtJs2upLGJQpSljAr
X-Google-Smtp-Source: APXvYqxmicQnUXWkSI7oXTTYVPD73FLc7DvpqSJtd9QpksqCGH5Mew0avrk3DwUrRj+s16tw1KLYRA==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr3522271wmc.74.1578486780149; 
 Wed, 08 Jan 2020 04:33:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id o4sm4037750wrw.97.2020.01.08.04.32.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jan 2020 04:32:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/38] hw: fix using 4.2 compat in 5.0 machine types for
 i440fx/q35
Date: Wed,  8 Jan 2020 13:32:20 +0100
Message-Id: <1578486775-52247-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
References: <1578486775-52247-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

5.0 machine type uses 4.2 compats. This seems to be incorrect, since
the latests machine type by now is 5.0 and it should use its own
compat or shouldn't use any relying on the defaults.
Seems, like this appeared because of some problems on merge/rebase.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20191223072856.5369-1-dplotnikov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 1 -
 hw/i386/pc_q35.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 721c7aa..fa12203 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -425,7 +425,6 @@ static void pc_i440fx_5_0_machine_options(MachineClass *m)
     m->alias = "pc";
     m->is_default = 1;
     pcmc->default_cpu_version = 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 52f4573..84cf925 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -354,7 +354,6 @@ static void pc_q35_5_0_machine_options(MachineClass *m)
     pc_q35_machine_options(m);
     m->alias = "q35";
     pcmc->default_cpu_version = 1;
-    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
 
 DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-- 
1.8.3.1



