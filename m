Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6462BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3062B206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC7KKUSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3062B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcxi-00052h-E6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwe-0003Sr-92
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jlcwc-00088y-HW
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592419074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kILCUNjBUGkUCoYF9x7Iny35fM8scC9GMSxJAtT6j80=;
 b=EC7KKUSi9nk50jnS68eH0ZBqE7al+C95oSks+oGoutAwl08cMtRgITTSDhvSAbIlI/iEze
 d/O1zuPsfbIlCthibdaCkweI2ebvJv6MIifpUv2mCLd7sh4rdOYKSHEJ311hVxrFX5vJ9O
 7rIId5dBBye182NhhN5prtTi11onp4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-z5oUbk8UOs6o-An8K-bYhw-1; Wed, 17 Jun 2020 14:37:46 -0400
X-MC-Unique: z5oUbk8UOs6o-An8K-bYhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1F1C1800D42;
 Wed, 17 Jun 2020 18:37:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-115-47.ams2.redhat.com
 [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C1B25EE0E;
 Wed, 17 Jun 2020 18:37:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, david@redhat.com, lvivier@redhat.com,
 maozhongyi@cmss.chinamobile.com, mreitz@redhat.com, pannengyuan@huawei.com
Subject: [PULL 01/12] virtiofsd: Whitelist fchmod
Date: Wed, 17 Jun 2020 19:37:22 +0100
Message-Id: <20200617183733.186168-2-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
References: <20200617183733.186168-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 01:42:04
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
Cc: stefanha@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

lo_setattr() invokes fchmod() in a rarely used code path, so it should
be whitelisted or virtiofsd will crash with EBADSYS.

Said code path can be triggered for example as follows:

On the host, in the shared directory, create a file with the sticky bit
set and a security.capability xattr:
(1) # touch foo
(2) # chmod u+s foo
(3) # setcap '' foo

Then in the guest let some process truncate that file after it has
dropped all of its capabilities (at least CAP_FSETID):

int main(int argc, char *argv[])
{
    capng_setpid(getpid());
    capng_clear(CAPNG_SELECT_BOTH);
    capng_updatev(CAPNG_ADD, CAPNG_PERMITTED | CAPNG_EFFECTIVE, 0);
    capng_apply(CAPNG_SELECT_BOTH);

    ftruncate(open(argv[1], O_RDWR), 0);
}

This will cause the guest kernel to drop the sticky bit (i.e. perform a
mode change) as part of the truncate (where FATTR_FH is set), and that
will cause virtiofsd to invoke fchmod() instead of fchmodat().

(A similar configuration exists further below with futimens() vs.
utimensat(), but the former is not a syscall but just a wrapper for the
latter, so no further whitelisting is required.)

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1842667
Reported-by: Qian Cai <caiqian@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200608093111.14942-1-mreitz@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/seccomp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
index bd9e7b083c..3b1522acdd 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/seccomp.c
@@ -42,6 +42,7 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(exit_group),
     SCMP_SYS(fallocate),
     SCMP_SYS(fchdir),
+    SCMP_SYS(fchmod),
     SCMP_SYS(fchmodat),
     SCMP_SYS(fchownat),
     SCMP_SYS(fcntl),
-- 
2.26.2


