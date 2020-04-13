Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A7CC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69732072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecSuo+Np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69732072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNx1f-0004Dd-TP
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNx0W-0002P5-GU
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNx0V-0000SJ-3F
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNx0U-0000S1-VJ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586776322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hngf1T4xIdGtDUWQBKvLGu7Vp96xshofitGMfLmzyhs=;
 b=ecSuo+Npn26+hVjgPWj9BwlxsFNKoi4ifRp639Avrw916ml5fJdtVn4KImX727/1Gj83P6
 kKXizmkW+2wAGd66k+cVasW8tjuPO2j94r2V1fmIOTngUMsky+zMXDL4kVt9fAUkyruIA7
 8+dlt3hcv1yGEQSJqD1Dl+542LNirPQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215--UlO8VCTN_uc5tA7jtAbkw-1; Mon, 13 Apr 2020 07:09:16 -0400
X-MC-Unique: -UlO8VCTN_uc5tA7jtAbkw-1
Received: by mail-wm1-f70.google.com with SMTP id o5so2542005wmo.6
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 04:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=b47iFwMVN9QYq3a/PDcTMzVV7TwuVWttbtbEsjdpn3s=;
 b=jPeWiVDigDliFfpLj4EBsyn+ciD9s1NnDQR2ezfwNK7WZUNHodl9ENPexdpsmNVprd
 35qpdMzumLKdIavVANPJcM6YolZYkJ7Aps847jcH+ykNRMryvEcoAE7PnpB0vvoWovrE
 Jwwywpo18i4wNiUWez8Yq2sxQWVMSmwukPN5M9J/pRJaKv13CYD0aK8EXLmZRtqU9vO4
 RLpgU5RAk1vSed5f10mtK72aZa/UzzFDDAnCvITpKF3uwDLCF1PNWjGF9hN5+wSuFogq
 U3zt2Fgfbb9/154lU6E7Bnqg5TuxQMys7rWe/NZ607lbG4UZvf510mFiiK/kSp6oDuUh
 nihA==
X-Gm-Message-State: AGi0PuZ/xTa3FmviKZMxv88zfpgNjGS6JxV7fhMtvS8abYcbetdAW3f2
 4n1CT0gHpprX2KGKd71MZyCWP1JV4msnG5aHnpJHamJ/w2M0XkSuvoknVSesQMrA3X561BOQq/I
 GbvHKs8YmOk1jtT4=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr17855158wmi.152.1586776155097; 
 Mon, 13 Apr 2020 04:09:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNKQcsJndV9iBW/kyN6EB4g11EndmI5RNXV9yF8WAcQkkjAjqLwmWbDO8eLpjLV+XckcJXwQ==
X-Received: by 2002:a7b:c401:: with SMTP id k1mr17855132wmi.152.1586776154800; 
 Mon, 13 Apr 2020 04:09:14 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id h2sm14512643wmf.34.2020.04.13.04.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 04:09:14 -0700 (PDT)
Date: Mon, 13 Apr 2020 07:09:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] exec: Fix for qemu_ram_resize() callback
Message-ID: <20200413110838.151374-5-mst@redhat.com>
References: <20200413110838.151374-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200413110838.151374-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Summarizing the issue:
1. Memory regions contain ram blocks with a different size,  if the
   size is  not properly aligned. While memory regions can have an
   unaligned size, ram blocks can't. This is true when creating
   resizable memory region with  an unaligned size.
2. When resizing a ram block/memory region, the size of the memory
   region  is set to the aligned size. The callback is called with
   the aligned size. The unaligned piece is lost.

Because of the above, if ACPI blob length modifications happens
after the initial virt_acpi_build() call, and the changed blob
length is within the PAGE size boundary, then the revised size
is not seen by the firmware on Guest reboot.

Hence make sure callback is called if memory region size is changed,
irrespective of aligned or not.

Signed-off-by: David Hildenbrand <david@redhat.com>
[Shameer: added commit log]
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200403101827.30664-4-shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 exec.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/exec.c b/exec.c
index de9d949902..2874bb5088 100644
--- a/exec.c
+++ b/exec.c
@@ -2074,11 +2074,23 @@ static int memory_try_enable_merging(void *addr, si=
ze_t len)
  */
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp)
 {
+    const ram_addr_t unaligned_size =3D newsize;
+
     assert(block);
=20
     newsize =3D HOST_PAGE_ALIGN(newsize);
=20
     if (block->used_length =3D=3D newsize) {
+        /*
+         * We don't have to resize the ram block (which only knows aligned
+         * sizes), however, we have to notify if the unaligned size change=
d.
+         */
+        if (unaligned_size !=3D memory_region_size(block->mr)) {
+            memory_region_set_size(block->mr, unaligned_size);
+            if (block->resized) {
+                block->resized(block->idstr, unaligned_size, block->host);
+            }
+        }
         return 0;
     }
=20
@@ -2102,9 +2114,9 @@ int qemu_ram_resize(RAMBlock *block, ram_addr_t newsi=
ze, Error **errp)
     block->used_length =3D newsize;
     cpu_physical_memory_set_dirty_range(block->offset, block->used_length,
                                         DIRTY_CLIENTS_ALL);
-    memory_region_set_size(block->mr, newsize);
+    memory_region_set_size(block->mr, unaligned_size);
     if (block->resized) {
-        block->resized(block->idstr, newsize, block->host);
+        block->resized(block->idstr, unaligned_size, block->host);
     }
     return 0;
 }
--=20
MST


