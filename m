Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8782C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8917F21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpUMntLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8917F21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufYH-0006Ag-MY
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iucst-0007Pu-VM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucss-0006YL-BT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:50:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40508
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iucss-0006Y2-8o
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14n6VRBWOZlDVw4rFY3ZJnLF6pQMjiehTsdclrZxErI=;
 b=WpUMntLozKj18dNbK2hLHeawbiRwDZVDc8VjpUS3UZjiB4zu1CRgWWwelCpeKFqK3FtMgl
 i8vU5EYYaEfVILwUj3NzaRhj5JMHGQ0NTXhivLzcHD4HUdSD3sYsjjD3PZtSCSYQD0lvtI
 v3ppckxKJOuiBfWj6vkEGxmvq+HGROY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-xW7f7jF0OKehRdiXLQZJ7g-1; Thu, 23 Jan 2020 08:50:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4489B18C43C3;
 Thu, 23 Jan 2020 13:50:54 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E311585787;
 Thu, 23 Jan 2020 13:50:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/59] cpu: Introduce cpu_class_set_parent_reset()
Date: Thu, 23 Jan 2020 14:49:51 +0100
Message-Id: <1579787449-27599-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: xW7f7jF0OKehRdiXLQZJ7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Similarly to what we already do with qdev, use a helper to overload the
reset QOM methods of the parent in children classes, for clarity.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <157650847239.354886.2782881118916307978.stgit@bahia.lan>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/cpu.c         | 8 ++++++++
 include/hw/core/cpu.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index db1a03c..fde5fd3 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -239,6 +239,14 @@ void cpu_dump_statistics(CPUState *cpu, int flags)
     }
 }
=20
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu))
+{
+    *parent_reset =3D cc->reset;
+    cc->reset =3D child_reset;
+}
+
 void cpu_reset(CPUState *cpu)
 {
     CPUClass *klass =3D CPU_GET_CLASS(cpu);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77c6f05..73e9a86 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1135,6 +1135,10 @@ void cpu_exec_unrealizefn(CPUState *cpu);
  */
 bool target_words_bigendian(void);
=20
+void cpu_class_set_parent_reset(CPUClass *cc,
+                                void (*child_reset)(CPUState *cpu),
+                                void (**parent_reset)(CPUState *cpu));
+
 #ifdef NEED_CPU_H
=20
 #ifdef CONFIG_SOFTMMU
--=20
1.8.3.1



