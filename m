Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F99AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB59206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvXKhYs1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB59206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNr4-0000ac-Jg
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpX-0007FH-9P
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpV-00065p-KV
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:55 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26314
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiNpV-00064N-GU
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576869652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=047QDZ7MEcEODejWVJcX4yQRTyXLQpY0SHXb+5Ij/5M=;
 b=QvXKhYs1H9rIt2uJb9JxtLJuQe47FwbdDdPwGCR+yRGA88LOFgeCg3rMTlpvWkpqjcs+q3
 zzLn+nQ8W9wboCf/HYJyU7CgXXVyuwgTJT/sVyDFac7lO3ixO/1WUBa8sjnDm8/KltWntp
 BFYXuAFwRkAoL1oHSz4OWIepNq7jHko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-85yPauv1MeKXac_BPKRh8Q-1; Fri, 20 Dec 2019 14:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D6C1883522;
 Fri, 20 Dec 2019 19:20:49 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 490DE60BEC;
 Fri, 20 Dec 2019 19:20:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/3] numa: properly check if numa is supported
Date: Fri, 20 Dec 2019 16:20:31 -0300
Message-Id: <20191220192031.2226378-4-ehabkost@redhat.com>
In-Reply-To: <20191220192031.2226378-1-ehabkost@redhat.com>
References: <20191220192031.2226378-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 85yPauv1MeKXac_BPKRh8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Commit aa57020774b, by mistake used MachineClass::numa_mem_supported
to check if NUMA is supported by machine and also as unrelated change
set it to true for sbsa-ref board.

Luckily change didn't break machines that support NUMA, as the field
is set to true for them.

But the field is not intended for checking if NUMA is supported and
will be flipped to false within this release for new machine types.

Fix it:
 - by using previously used condition
      !mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id
   the first time and then use MachineState::numa_state down the road
   to check if NUMA is supported
 - dropping stray sbsa-ref chunk

Fixes: aa57020774b690a22be72453b8e91c9b5a68c516
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1576154936-178362-3-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/sbsa-ref.c | 1 -
 hw/core/machine.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5853bdee5c..9b5bcb5634 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -789,7 +789,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *=
data)
     mc->possible_cpu_arch_ids =3D sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props =3D sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id =3D sbsa_ref_get_default_cpu_node_id;
-    mc->numa_mem_supported =3D true;
 }
=20
 static const TypeInfo sbsa_ref_info =3D {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 023548b4f3..e81f43cd0b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -963,7 +963,7 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
=20
-    if (mc->numa_mem_supported) {
+    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state =3D g_new0(NumaState, 1);
     }
=20
@@ -1107,7 +1107,7 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
=20
-    if (machine_class->numa_mem_supported) {
+    if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
             machine_numa_finish_cpu_init(machine);
--=20
2.23.0


