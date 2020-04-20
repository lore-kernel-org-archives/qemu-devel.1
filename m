Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C98C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A698A205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8GKDiAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A698A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQagz-0007sW-Kt
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 13:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36658 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabf-0007Nh-Jp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:20 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jQabe-0004tG-4u
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44841
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jQabd-0004oJ-KH
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 13:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587405196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3P+njxzp3Lmcfu/1uJRc/Eo2AmUeLCf+wLUBObG0sX0=;
 b=K8GKDiAhI6klzhUNU6OgJk9tQ7NF8AK2WAn6OGwAC7egk/p1HTcuNd/O4IKOkPntr6w7g5
 zTXVRS6aljqs8LgCfZ0kVKMLtzpAFc/97B0qxSzzmlyoen46YcpLs1FNvTnBkfjmtAnEuC
 tXgybS2BdnYcFqfUJ9Bzk3SYd7bgpGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-fGWRDdDzPG2fthAgax_6Kw-1; Mon, 20 Apr 2020 13:53:14 -0400
X-MC-Unique: fGWRDdDzPG2fthAgax_6Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8905C800D5C;
 Mon, 20 Apr 2020 17:53:13 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16803A103F;
 Mon, 20 Apr 2020 17:53:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hax: Fix setting of FD_CLOEXEC
Date: Mon, 20 Apr 2020 12:53:07 -0500
Message-Id: <20200420175309.75894-2-eblake@redhat.com>
In-Reply-To: <20200420175309.75894-1-eblake@redhat.com>
References: <20200420175309.75894-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-trivial@nongnu.org, "open list:X86 HAXM CPUs" <haxm-team@intel.com>,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Blindly setting FD_CLOEXEC without a read-modify-write will
inadvertently clear any other intentionally-set bits, such as a
proposed new bit for designating a fd that must behave in 32-bit mode.
Use our wrapper function instead of an incorrect hand-rolled version.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 target/i386/hax-posix.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/hax-posix.c b/target/i386/hax-posix.c
index 3bad89f13337..5f9d1b803dec 100644
--- a/target/i386/hax-posix.c
+++ b/target/i386/hax-posix.c
@@ -23,7 +23,7 @@ hax_fd hax_mod_open(void)
         fprintf(stderr, "Failed to open the hax module\n");
     }

-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);

     return fd;
 }
@@ -147,7 +147,7 @@ hax_fd hax_host_open_vm(struct hax_state *hax, int vm_i=
d)
     fd =3D open(vm_name, O_RDWR);
     g_free(vm_name);

-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);

     return fd;
 }
@@ -200,7 +200,7 @@ hax_fd hax_host_open_vcpu(int vmid, int vcpuid)
     if (fd < 0) {
         fprintf(stderr, "Failed to open the vcpu devfs\n");
     }
-    fcntl(fd, F_SETFD, FD_CLOEXEC);
+    qemu_set_cloexec(fd);
     return fd;
 }

--=20
2.26.1


