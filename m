Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBBFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5607020838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjW/tyAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5607020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHYQ-0003OT-FE
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHXX-0002Es-P6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHXW-0007dQ-QC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHXW-0007d4-MX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFKw99eybEBSOFz3dUXtZpLQZvMzVUyCJ6arSOjZUVc=;
 b=LjW/tyATsSQvYtB5ay7dPkhq9lb2gKhzeK4qkpfSiQ6wlpEbXofwt9ooJSfQFsOd+S+q7T
 eZxZLJsoGjF8FuQAFZHBzwGxBkJlyLo84Th1mMK1JzlkxzLzdykAY6JfbtQhD6CcU8OSg2
 fh/++nIgzBoPtt3F2RJDK9Zp801KZYk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-KaR1cyJkO2STxyv_39RG4g-1; Tue, 31 Mar 2020 10:06:48 -0400
X-MC-Unique: KaR1cyJkO2STxyv_39RG4g-1
Received: by mail-wm1-f69.google.com with SMTP id e16so505526wmh.5
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YhmapbcU5a1HoNpuFF+HAiAFJ1ozuO4gZZnYbW0h/jM=;
 b=mKmUql0XJ935suHOX5xc3lUX8Yml/EhuDC4QOzbcPS5atnneKHqTI4mOYqkUVX7FbW
 rc3LqPxf+Vlw/VbMB7ZZL1IKMHtiLWb0rRw5UZwMNRnVm4t0bX0l/CyNcLXf5/exrpQ3
 eUsSXlPk6TXUiC5PI2WwiXqxQvp6BJi++AX4cZ09S2YNnxMGPgeyIJ3qC7reR0y/SbC6
 aSjrlDf5dPqzARS3iMfSB4kVUCq4b6IBDS8Zb45ZIcC5d06SewnFqgLtkHsWL7pCkkMY
 9de2EtEOKqyZkyZqSbfoAnsTkNCxE72UlPIwmWRp58zGwjkPXMi4vnmw72NeZnNRiXUR
 bMjg==
X-Gm-Message-State: ANhLgQ0izMVzAyewU+jZJjW6hxVrSroQEmskoiCTMUaXwfcgg9oXkei3
 SEHGR5anwulOva7GTe1mDcnuo09NU/bPwlhePbTw7hUUHtcASZhLTFOfhEuEg53HXGMm3UeoHQW
 Y0+aw5KgxdeGiMF0=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr3818977wmj.65.1585663607329; 
 Tue, 31 Mar 2020 07:06:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vviFCLsHP+ZYvcT+aQatfMvktmNgf8A/W71hBKHbnQ0zXh2PQ15vZ5fQmWC4vHPjp5yn5EleA==
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr3818965wmj.65.1585663607134; 
 Tue, 31 Mar 2020 07:06:47 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u128sm4025190wmu.31.2020.03.31.07.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:06:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 1/4] Revert "prevent crash when executing
 guest-file-read with large count"
Date: Tue, 31 Mar 2020 16:06:35 +0200
Message-Id: <20200331140638.16464-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331140638.16464-1-philmd@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using g_try_malloc() instead of g_malloc() the qemu-guest-agent
Denial-of-Service attack referred in commit 807e2b6fce is reduced,
but still triggerable:

  - bisect file size S until g_try_malloc(S) fails,
  - use S - 1:
    g_try_malloc(S - 1) succeeds, but g_new0() few lines later will
    fail.

 346     buf =3D g_try_malloc0(count + 1);
 347     if (!buf) {
 348         error_setg(errp,
 349                    "failed to allocate sufficient memory "
 350                    "to complete the requested service");
 351         return NULL;
 352     }
 353     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
 354     if (!is_ok) {
 355         error_setg_win32(errp, GetLastError(), "failed to read file");
 356         slog("guest-file-read failed, handle %" PRId64, handle);
 357     } else {
 358         buf[read_count] =3D 0;
 359         read_data =3D g_new0(GuestFileRead, 1);
                         ^^^^^^

Instead we are going to put a low hard limit on 'count' in the next
commits.
This reverts commit 807e2b6fce022707418bc8f61c069d91c613b3d2.

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-win32.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b49920e201..46cea7d1d9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -343,13 +343,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, boo=
l has_count,
     }
=20
     fh =3D gfh->fh;
-    buf =3D g_try_malloc0(count + 1);
-    if (!buf) {
-        error_setg(errp,
-                   "failed to allocate sufficient memory "
-                   "to complete the requested service");
-        return NULL;
-    }
+    buf =3D g_malloc0(count + 1);
     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
--=20
2.21.1


