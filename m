Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65EFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7151D20704
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 17:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWZ9XkAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7151D20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iug5x-00046W-1o
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 12:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuctp-0000Si-4d
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iucto-0000NK-1P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuctn-0000M3-UN
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579787515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhWeL2ADPT5bDg7/jmj0T6OuctAf6BKtCLK+BXLaiNI=;
 b=cWZ9XkAq9ImSW/nN6EmOdBjIRMAqJWGasQqsv1vxDrVbuEaJcI5EwYcHE/UnV6ycMj4AJu
 3+7onYjrcsrxXiUjXw8m+ditbKKh1cq4ja1oqPb1SGHxycyAcGCIrTJjHs6FiHzR06dDRh
 Uu4W0LhFqJzqOTgqI56+a/n/IXXhiZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-x_LqWXKjOuuAZoip8sIFhw-1; Thu, 23 Jan 2020 08:51:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 463F46C199
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 13:51:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBDE6857A5;
 Thu, 23 Jan 2020 13:51:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/59] accel: Introduce the current_accel() wrapper
Date: Thu, 23 Jan 2020 14:50:18 +0100
Message-Id: <1579787449-27599-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: x_LqWXKjOuuAZoip8sIFhw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The accel/ code only accesses the MachineState::accel field.
As we simply want to access the accelerator, not the machine,
add a current_accel() wrapper.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200121110349.25842-9-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 5 +++++
 include/sysemu/accel.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/accel/accel.c b/accel/accel.c
index 1c5c3a6..cb555e3 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -63,6 +63,11 @@ int accel_init_machine(AccelState *accel, MachineState *=
ms)
     return ret;
 }
=20
+AccelState *current_accel(void)
+{
+    return current_machine->accelerator;
+}
+
 void accel_setup_post(MachineState *ms)
 {
     AccelState *accel =3D ms->accelerator;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index d4c1429..47e5788 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -70,4 +70,6 @@ int accel_init_machine(AccelState *accel, MachineState *m=
s);
 /* Called just before os_setup_post (ie just before drop OS privs) */
 void accel_setup_post(MachineState *ms);
=20
+AccelState *current_accel(void);
+
 #endif
--=20
1.8.3.1



