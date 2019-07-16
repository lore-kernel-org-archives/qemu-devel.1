Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE18C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48B421721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtI3N8Wm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48B421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46183 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIac-0008CB-Gg
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYd-0008GS-Lq
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYc-0003GM-CX
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36696)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYc-0003Fb-68
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:30 -0400
Received: by mail-wr1-x429.google.com with SMTP id n4so19888599wrs.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UxGATMBNQig2wIfjWLxzWQxLyakGvI3IHTSyhIIbcuE=;
 b=ZtI3N8WmcsSjB326JXV4NX2p6ACeFbGi0divP59eJUfFp1+xOSyhpD5cakMdPq4SqM
 al/7nxnUbcLrD5jbEn1P55QHkIOmVPiPcN5AaSmevXhCjWiZCvlvaT52Ydfcregl1uee
 OYfD8dCq+UjjkKP8mEJJx5IMW6eAZEMGzQlqzqwIoOK391+6Fb0k14kRg9mcewsmAVJu
 qQBzDQttLPWnfBqhYLiJn5sKf3QR8nxHSakYFT9GNC1oxTlotAS5DXJEPsrpYsDVvNiJ
 rFFrxOURjwfAmrYhkiIgYORGAPpWvAetzDuGO2M0MH7oQ8PEWPuFgKoxvBKgD+dpMOZ8
 GD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=UxGATMBNQig2wIfjWLxzWQxLyakGvI3IHTSyhIIbcuE=;
 b=PUqP5JzuDSQCbvKynnqmMhJP6fGGXoq959HYQOmsosBZWJ89K4+TEpT0+BIftIe7oH
 Hdhk3GGrMyqPaxV8Xu86ijods+dxb3wLg+thY+nuIxpev2w+mASMMdj4EMDr8vEOjBsS
 G2A7yeOoI9QIdK80gNdbYUKmZw/uWk0hZaEnDrmdKhuWGBjAyVc82xVZgijS6igeF0wl
 DPccY3ukLh5lV4TQ2zEoW0nQsJqV/R9oS3i4bX4mTpX9O1uzDzjpIHzplGskSgryMLe9
 Q7Fsu0muJ2jpFsB6JhcxWkyokTZzvs05/jPz51BEcZZeHjqh8hlGzE6/3GjKcsbKuYb8
 5mRQ==
X-Gm-Message-State: APjAAAXqbxBzkYyaUSD49DSrjiRzrkgeSkvQxdKUQGQMj8CdmuEokveT
 6J31p+Vf0SSF+x3BhrP0QICKicWSEc8=
X-Google-Smtp-Source: APXvYqyTYIdM/xOg9NHClSKz7NNh9HpbCGsybjuvAR7Zi5HR94sIeJUx7WuxfUK4sgvQEQtF4DbXQg==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr35592887wrs.93.1563264688886; 
 Tue, 16 Jul 2019 01:11:28 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:07 +0200
Message-Id: <1563264677-39718-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 09/19] memory: unref the memory region in
 simplify flatview
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
Cc: King Wang <king.wang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: King Wang <king.wang@huawei.com>

The memory region reference is increased when insert a range
into flatview range array, then decreased by destroy flatview.
If some flat range merged by flatview_simplify, the memory region
reference can not be decreased by destroy flatview any more.

In this case, start virtual machine by the command line:
qemu-system-x86_64
-name guest=ubuntu,debug-threads=on
-machine pc,accel=kvm,usb=off,dump-guest-core=off
-cpu host
-m 16384
-realtime mlock=off
-smp 8,sockets=2,cores=4,threads=1
-object memory-backend-file,id=ram-node0,prealloc=yes,mem-path=/dev/hugepages,share=yes,size=8589934592
-numa node,nodeid=0,cpus=0-3,memdev=ram-node0
-object memory-backend-file,id=ram-node1,prealloc=yes,mem-path=/dev/hugepages,share=yes,size=8589934592
-numa node,nodeid=1,cpus=4-7,memdev=ram-node1
-no-user-config
-nodefaults
-rtc base=utc
-no-shutdown
-boot strict=on
-device piix3-usb-uhci,id=usb,bus=pci.0,addr=0x1.0x2
-device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x2
-device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x3
-drive file=ubuntu.qcow2,format=qcow2,if=none,id=drive-virtio-disk0,cache=none,aio=native
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1
-chardev pty,id=charserial0
-device isa-serial,chardev=charserial0,id=serial0
-device usb-tablet,id=input0,bus=usb.0,port=1
-vnc 0.0.0.0:0
-device VGA,id=video0,vgamem_mb=16,bus=pci.0,addr=0x5
-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x6
-msg timestamp=on

And run the script in guest OS:
while true
do
    setpci -s 00:06.0 04.b=03
	setpci -s 00:06.0 04.b=07
done

I found the reference of node0 HostMemoryBackendFile is a big one.
(gdb) p numa_info[0]->node_memdev->parent.ref
$6 = 1636278
(gdb)

Signed-off-by: King Wang<king.wang@huawei.com>
Message-Id: <20190712065241.11784-1-king.wang@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 480f3d9..d8d42bd 100644
--- a/memory.c
+++ b/memory.c
@@ -321,7 +321,7 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
 /* Attempt to simplify a view by merging adjacent ranges */
 static void flatview_simplify(FlatView *view)
 {
-    unsigned i, j;
+    unsigned i, j, k;
 
     i = 0;
     while (i < view->nr) {
@@ -332,6 +332,9 @@ static void flatview_simplify(FlatView *view)
             ++j;
         }
         ++i;
+        for (k = i; k < j; k++) {
+            memory_region_unref(view->ranges[k].mr);
+        }
         memmove(&view->ranges[i], &view->ranges[j],
                 (view->nr - j) * sizeof(view->ranges[j]));
         view->nr -= j - i;
-- 
1.8.3.1



