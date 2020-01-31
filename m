Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0398C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA48206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF8FXDhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA48206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYlw-0001e6-R3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXzL-0006Ri-3e
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXzK-0007Ov-36
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXzJ-0007ND-VO
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/XtG1ha/5a0DcyG08BuWmwD18wK55W/zwwn8rUnIsDA=;
 b=dF8FXDhKWSp+t5t1CBeaLbl6Es6lSmaOHzRlsuNeyw6X7sXmbPIS4ohzpXPd/XstpT4I+6
 GjtKFl+a0EEPDAK95TUDRg++t5c9qnwnLHMYf2Ir3D6AviK2AlwMrfvekjY9qKD7nYrkyx
 LwQu5HHh3bECM872MBJDL92yae4LnDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-xfKhTj8qPRai9Ro3fazBdQ-1; Fri, 31 Jan 2020 10:13:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4DF6107ACC4;
 Fri, 31 Jan 2020 15:13:36 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD0B086C4B;
 Fri, 31 Jan 2020 15:13:35 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 76/80] make mem_path local variable
Date: Fri, 31 Jan 2020 16:09:46 +0100
Message-Id: <1580483390-131164-77-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: xfKhTj8qPRai9Ro3fazBdQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: jitendra.kolhe@hpe.com, pbonzini@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's no longer used anywhere beside main(),
so make it local variable that is used for CLI compat
purposes to keep -mem-path option working.

Under hood QEMU will use it to create
  memory-backend-file,mem-path=3D...
backend and use its MemoryRegion as main RAM.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: pbonzini@redhat.com
CC: jitendra.kolhe@hpe.com
CC: ehabkost@redhat.com
---
 include/sysemu/sysemu.h | 1 -
 vl.c                    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 80c57fd..8de9065 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -53,7 +53,6 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
-extern const char *mem_path;
 extern int mem_prealloc;
=20
 #define MAX_OPTION_ROMS 16
diff --git a/vl.c b/vl.c
index 4ce0799..7f12666 100644
--- a/vl.c
+++ b/vl.c
@@ -140,7 +140,6 @@ enum vga_retrace_method vga_retrace_method =3D VGA_RETR=
ACE_DUMB;
 int display_opengl;
 const char* keyboard_layout =3D NULL;
 ram_addr_t ram_size;
-const char *mem_path =3D NULL;
 int mem_prealloc =3D 0; /* force preallocation of physical target memory *=
/
 bool enable_mlock =3D false;
 bool enable_cpu_pm =3D false;
@@ -2917,6 +2916,7 @@ int main(int argc, char **argv, char **envp)
     Error *err =3D NULL;
     bool list_data_dirs =3D false;
     char *dir, **dirs;
+    const char *mem_path =3D NULL;
     BlockdevOptionsQueue bdo_queue =3D QSIMPLEQ_HEAD_INITIALIZER(bdo_queue=
);
     QemuPluginList plugin_list =3D QTAILQ_HEAD_INITIALIZER(plugin_list);
=20
--=20
2.7.4


