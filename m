Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E51C83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2624C206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bChIX4gS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2624C206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThB2-0007C7-7k
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1x-0007tn-7i
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTh1g-0003wp-T3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTh1f-0003vR-TS
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588144858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Nr3g64N1ZbytavTEHUIn3pBRY3200wKKl65xH32qj8=;
 b=bChIX4gSpg57Nax+9+Uaie5KVxTnJF8qjT4vkkDnfUz4cs/oJFxjNVlmdCLuGfurVXugWF
 6mHe3rBDrQ5SbmPzizcn7FZ8nr+CHF6cMVTQYpn7LXbteMOSqf3AIzu1dFIHhx7qcqKBYn
 YcRmP3B1QIlMw3c2yzeJFq/KkTLk1UA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-njkdIEKSNHuXjEG2PHpVDQ-1; Wed, 29 Apr 2020 03:20:56 -0400
X-MC-Unique: njkdIEKSNHuXjEG2PHpVDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203771009445;
 Wed, 29 Apr 2020 07:20:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E40AD60BF4;
 Wed, 29 Apr 2020 07:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E4F711358DD; Wed, 29 Apr 2020 09:20:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] qemu-option: pass NULL rather than 0 to the id of
 qemu_opts_set()
Date: Wed, 29 Apr 2020 09:20:48 +0200
Message-Id: <20200429072048.29963-33-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-1-armbru@redhat.com>
References: <20200429072048.29963-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Masahiro Yamada <masahiroy@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Masahiro Yamada <masahiroy@kernel.org>

The second argument 'id' is a pointer. Pass NULL rather than 0.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Message-Id: <20200427005704.2475782-1-masahiroy@kernel.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 softmmu/vl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 32c0047889..afd2615fb3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3059,19 +3059,19 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_kernel:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "kernel", opta=
rg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "kernel", o=
ptarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_initrd:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "initrd", opta=
rg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "initrd", o=
ptarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_append:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "append", opta=
rg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "append", o=
ptarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_dtb:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "dtb", optarg,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "dtb", opta=
rg,
                               &error_abort);
                 break;
             case QEMU_OPTION_cdrom:
@@ -3182,7 +3182,7 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_bios:
-                qemu_opts_set(qemu_find_opts("machine"), 0, "firmware", op=
targ,
+                qemu_opts_set(qemu_find_opts("machine"), NULL, "firmware",=
 optarg,
                               &error_abort);
                 break;
             case QEMU_OPTION_singlestep:
--=20
2.21.1


