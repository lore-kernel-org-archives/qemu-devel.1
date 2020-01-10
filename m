Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F146C32771
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 03:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFD420721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 03:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFD420721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipkny-0007Tp-Dq
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 22:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ipknI-0006qY-V1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 22:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ipknH-00088p-GD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 22:17:04 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2673 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ipknH-0007Xw-34; Thu, 09 Jan 2020 22:17:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id AFEB6365904B72CFACFA;
 Fri, 10 Jan 2020 11:16:54 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 10 Jan 2020 11:16:48 +0800
From: <pannengyuan@huawei.com>
To: <pbonzini@redhat.com>
Subject: [PATCH] vl: Don't mismatch g_strsplit()/g_free()
Date: Fri, 10 Jan 2020 11:16:18 +0800
Message-ID: <20200110031618.23332-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: qemu-trivial@nongnu.org, Euler Robot <euler.robot@huawei.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

It's a mismatch between g_strsplit and g_free, it will cause a memory lea=
k as follow:

[root@localhost]# ./aarch64-softmmu/qemu-system-aarch64 -accel help
Accelerators supported in QEMU binary:
tcg
kvm
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D1207900=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 8 byte(s) in 2 object(s) allocated from:
    #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31c=
b)
    #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xfffd6ec724d7 in g_strndup (/lib64/libglib-2.0.so.0+0x724d7)
    #3 0xfffd6ec73d3f in g_strsplit (/lib64/libglib-2.0.so.0+0x73d3f)
    #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:35=
17
    #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0=
f53)

Direct leak of 2 byte(s) in 2 object(s) allocated from:
    #0 0xfffd700231cb in __interceptor_malloc (/lib64/libasan.so.4+0xd31c=
b)
    #1 0xfffd6ec57163 in g_malloc (/lib64/libglib-2.0.so.0+0x57163)
    #2 0xfffd6ec7243b in g_strdup (/lib64/libglib-2.0.so.0+0x7243b)
    #3 0xfffd6ec73e6f in g_strsplit (/lib64/libglib-2.0.so.0+0x73e6f)
    #4 0xaaab66be5077 in main /mnt/sdc/qemu-master/qemu-4.2.0-rc0/vl.c:35=
17
    #5 0xfffd6e140b9f in __libc_start_main (/lib64/libc.so.6+0x20b9f)
    #6 0xaaab66bf0f53  (./build/aarch64-softmmu/qemu-system-aarch64+0x8a0=
f53)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 86474a55c9..2fa5cb3b9a 100644
--- a/vl.c
+++ b/vl.c
@@ -3476,7 +3476,7 @@ int main(int argc, char **argv, char **envp)
                             gchar **optname =3D g_strsplit(typename,
                                                          ACCEL_CLASS_SUF=
FIX, 0);
                             printf("%s\n", optname[0]);
-                            g_free(optname);
+                            g_strfreev(optname);
                         }
                         g_free(typename);
                     }
--=20
2.21.0.windows.1



