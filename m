Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B9C2D0EC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12BC206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa7zJ2Fi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BC206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMkZA-0003D9-E8
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 23:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMkYE-0001dD-1Y
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMkYD-0007w0-04
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:53 -0400
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:35059)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMkYC-0007vn-S3
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 23:41:52 -0400
Received: by mail-qv1-xf42.google.com with SMTP id q73so444197qvq.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=F6qfRA9Zsk5PQPX5NBdmVChOrunOXGYYK7OugFpAebY=;
 b=aa7zJ2Fi2mXZEEyWeiG4y/CMjIJpfclxqnDw7qWm39zDwF/tTHNWb9Fm4/otfsrc9c
 uxOvomv4FK7udCvyXkSgOkrV5HLko1JnScSTPmb72EGXf0NIkpRSbxedBGlpkjPvV9Jk
 tWAssqihOWAgUyFKSxxmXOCRJgPoWlRpFZUiIHT0oAeQz8XEeKedcze57KwGyDPvI0kU
 LB+EdD81vCDF15WHQwzaSsneWXSIS71F1vWx9ldyN/K42NNFRAMVceFXX5aAsLOyyd5R
 5qal+auYiFvNr5gs2+QbT146DX2TD0uyF2TGHKUs3BJhKjV3/0KxKnkgSSjQwbSQkDoi
 8ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=F6qfRA9Zsk5PQPX5NBdmVChOrunOXGYYK7OugFpAebY=;
 b=Uv2LCyOYMtzOEys4G/aJLRtTSbgkwqOm9FHaMF9V2Js7sDPFQF+eIm+8ZmvcEy3Bc2
 fu+WXz1a7EV9mKzow1iIxwcUU7mdWPw+EMpjgJt0SK0omd1wqUxhEeeUt1E0VoYZoHhI
 lSmj/7c5OUsBubu/Lxh/b8q+Z9m+bCQEum5od0Ps/4eOzGLq7e7M4+GP2PndVafDmioa
 ll0XFsds4XB8Ftb3iZXQsT5sYGys7HxEce7Ny+GaMybuXifjyzNJfldd9PGLrgOs42rW
 RXVTY/zecTgGnxOP90NQNASPQghI8sDdfvTC6xFSW+KDn+EHn3n+4GPa2HEGyYEb0LeG
 d78g==
X-Gm-Message-State: AGi0PubG72/H29GvTGWRkZZblR0CXP1Ke0//s06jTgMQtBjQ//UaIzYq
 ByQIIVRxOiCo9dOyP96pPSVoqh9NEzg=
X-Google-Smtp-Source: APiQypJDNebDsH2LEr2FtkHUpVTrN3oiMCRvfOsIv4OdflsPtWQdM3kt64IWOp2jn4uTUTL7/rnQ1w==
X-Received: by 2002:a0c:f4ca:: with SMTP id o10mr3310777qvm.18.1586490112178; 
 Thu, 09 Apr 2020 20:41:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id l9sm725784qth.60.2020.04.09.20.41.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Apr 2020 20:41:51 -0700 (PDT)
Subject: [PATCH v19 QEMU 4/4] memory: Do not allow direct write access to
 rom_device regions
From: Alexander Duyck <alexander.duyck@gmail.com>
To: pbonzini@redhat.com, david@redhat.com, mst@redhat.com
Date: Thu, 09 Apr 2020 20:41:50 -0700
Message-ID: <20200410034150.24738.98143.stgit@localhost.localdomain>
In-Reply-To: <20200410033729.24738.22879.stgit@localhost.localdomain>
References: <20200410033729.24738.22879.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

According to the documentation in memory.h a ROM memory region will be
backed by RAM for reads, but is supposed to go through a callback for
writes. Currently we were not checking for the existence of the rom_device
flag when determining if we could perform a direct write or not.

To correct that add a check to memory_region_is_direct so that if the
memory region has the rom_device flag set we will return false for all
checks where is_write is set.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 include/exec/memory.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1614d9a02c0c..e000bd2f97b2 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2351,8 +2351,8 @@ void address_space_write_cached_slow(MemoryRegionCache *cache,
 static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write)
 {
     if (is_write) {
-        return memory_region_is_ram(mr) &&
-               !mr->readonly && !memory_region_is_ram_device(mr);
+        return memory_region_is_ram(mr) && !mr->readonly &&
+               !mr->rom_device && !memory_region_is_ram_device(mr);
     } else {
         return (memory_region_is_ram(mr) && !memory_region_is_ram_device(mr)) ||
                memory_region_is_romd(mr);


