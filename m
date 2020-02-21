Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90933C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6D224650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzjINIJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6D224650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BJN-0000Iv-I9
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5BFI-0002fq-EP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:33:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5BFG-0000n0-JW
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:33:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36772
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5BFG-0000me-FD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582302821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXH6buGbOPhKCWB/KVR+J3wk1Wee9B4Tm+VBngLJ41E=;
 b=XzjINIJ8X081FZZOIB7NKnAnD8XQ5SyAYV3KvlNz33KQ5XA/Hk57E4OKr5IiJs3MpUwDoH
 Zlwv5uqottpjbPCfXPWHkI2RLVLqAtbfoRCNk1ehiIxd7xpfcwetiQV4xdutA4svaAaOgv
 O0x+JTnDWbp0RWJLxWUhSpoqqbv8N3w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-CqC4uns-MMq6H-EHp8E9tA-1; Fri, 21 Feb 2020 11:33:40 -0500
X-MC-Unique: CqC4uns-MMq6H-EHp8E9tA-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1234619wrm.18
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:33:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+wtlMqiYMfAtECyCFeq4h5JvYyRA49l8lzkwzoiW88E=;
 b=mavpUFO44IhyXSAm2+Hz+Qx5MnxhEZJlpSfVDSh4Uoc5QvHQBZh8vX44JeNXIWId2P
 w1KUjtLzZ4KBidwfDLhZ1xoWXbV4VZeBceU8qKJpSepLTSjTFGqypnPb+VJmvv1TjQ9V
 nWg9ZV4MEZauy//r/4PHQtfKMlaiWF9I/qG4590ESzLesqb6GgyNRBYElPrQBYUi7Hnh
 7T9MOUIQQtXE0VGFsRRVyl9/KZSQQ6ZIaxbu+l1/ime/A4mQ1Vi0DwghfeGZQuKvDZNL
 f2L1ELbJYiYQAbX9uGeasoRge0OzzKAdmSxMSG8kqMc/8hJAQ5J6Wmkcrhe0QqJ5D1em
 GIiQ==
X-Gm-Message-State: APjAAAUVH/CWUAjE9hvIGItP/3rGoqdbpfiNbYBvh2oBn6nGCq7mrgn2
 RHfLyw6PsIwbSpSRUmOqI4+laLDGtVswq5tSc6ciMo/55a0YAUOG08bahsqY1+reH7eC3Jw1Bjy
 +5lx4M+t4DWzoxHA=
X-Received: by 2002:a5d:6411:: with SMTP id z17mr52257866wru.57.1582302818494; 
 Fri, 21 Feb 2020 08:33:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/P0AiFwTiT7z/wiXEONKmFEX/+8KKpJaNr4hGDqfwDZfa9AgZLuHo195clbdhIrrAhDaBiQ==
X-Received: by 2002:a5d:6411:: with SMTP id z17mr52257842wru.57.1582302818224; 
 Fri, 21 Feb 2020 08:33:38 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c15sm4522493wrt.1.2020.02.21.08.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 08:33:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] accel/kvm: Check ioctl(KVM_SET_USER_MEMORY_REGION) return
 value
Date: Fri, 21 Feb 2020 17:33:36 +0100
Message-Id: <20200221163336.2362-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
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
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

kvm_vm_ioctl() can fail, check its return value, and log an error
when it failed. This fixes Coverity CID 1412229:

  Unchecked return value (CHECKED_RETURN)

  check_return: Calling kvm_vm_ioctl without checking return value

Reported-by: Coverity (CID 1412229)
Fixes: 235e8982ad3 ("support using KVM_MEM_READONLY flag for regions")
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 accel/kvm/kvm-all.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index c111312dfd..6df3a4d030 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -308,13 +308,23 @@ static int kvm_set_user_memory_region(KVMMemoryListen=
er *kml, KVMSlot *slot, boo
         /* Set the slot size to 0 before setting the slot to the desired
          * value. This is needed based on KVM commit 75d61fbc. */
         mem.memory_size =3D 0;
-        kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        ret =3D kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
+        if (ret < 0) {
+            goto err;
+        }
     }
     mem.memory_size =3D slot->memory_size;
     ret =3D kvm_vm_ioctl(s, KVM_SET_USER_MEMORY_REGION, &mem);
     slot->old_flags =3D mem.flags;
+err:
     trace_kvm_set_user_memory(mem.slot, mem.flags, mem.guest_phys_addr,
                               mem.memory_size, mem.userspace_addr, ret);
+    if (ret < 0) {
+        error_report("%s: KVM_SET_USER_MEMORY_REGION failed, slot=3D%d,"
+                     " start=3D0x%" PRIx64 ", size=3D0x%" PRIx64 ": %s",
+                     __func__, mem.slot, slot->start_addr,
+                     (uint64_t)mem.memory_size, strerror(errno));
+    }
     return ret;
 }
=20
--=20
2.21.1


