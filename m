Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC29C2BA12
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5823D20737
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MD1xfAjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5823D20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK5E7-0007hC-G7
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 15:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jK5B0-0002Tc-EL
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000Mm-E2
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jK5Az-0000Kn-9l
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 15:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585854411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNt1Kfzuq9YitXxQvYRACSU9+bXSxIfVQgQnwMvCeoo=;
 b=MD1xfAjGklFkRrRViRpqDazgCG6Tq6hfGI7cjCFlWTlUpGDhq/QP3mNuZQVQn1QvTW3wRv
 mTjBYcamoPNb8MJVAi3hRj3g0BFb17HUBu+fqGI7Jm73uNT++qgLxws9Lr+yn0xBZcvEUR
 msWcqljxGg6I0HLaQpD01zfTd9o4f78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-s0q8258vN-CVXAmsIA3Rpg-1; Thu, 02 Apr 2020 15:06:50 -0400
X-MC-Unique: s0q8258vN-CVXAmsIA3Rpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44C2D13F6
 for <qemu-devel@nongnu.org>; Thu,  2 Apr 2020 19:06:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA22B89F0A;
 Thu,  2 Apr 2020 19:06:48 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/15] vl: fix broken IPA range for ARM -M virt with KVM enabled
Date: Thu,  2 Apr 2020 15:06:33 -0400
Message-Id: <20200402190640.1693-9-pbonzini@redhat.com>
In-Reply-To: <20200402190640.1693-1-pbonzini@redhat.com>
References: <20200402190640.1693-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Commit a1b18df9a4848, broke virt_kvm_type() logic, which depends on
maxram_size, ram_size, ram_slots being parsed/set on machine instance
at the time accelerator (KVM) is initialized.

set_memory_options() part was already reverted by commit 2a7b18a3205b,
so revert remaining initialization of above machine fields to make
virt_kvm_type() work as it used to.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Auger Eric <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20200326112829.19989-1-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 796a77e234..4f71ac10fd 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4137,6 +4137,9 @@ void qemu_init(int argc, char **argv, char **envp)
     machine_opts =3D qemu_get_machine_opts();
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
+    current_machine->ram_size =3D ram_size;
+    current_machine->maxram_size =3D maxram_size;
+    current_machine->ram_slots =3D ram_slots;
=20
     /*
      * Note: uses machine properties such as kernel-irqchip, must run
@@ -4320,10 +4323,6 @@ void qemu_init(int argc, char **argv, char **envp)
         }
     }
=20
-    current_machine->ram_size =3D ram_size;
-    current_machine->maxram_size =3D maxram_size;
-    current_machine->ram_slots =3D ram_slots;
-
     parse_numa_opts(current_machine);
=20
     if (machine_class->default_ram_id && current_machine->ram_size &&
--=20
2.18.2



