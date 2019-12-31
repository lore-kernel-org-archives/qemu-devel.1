Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F9C2D0DD
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9F9206E4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTuEloua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9F9206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHDq-0007BI-Hg
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:06:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54342)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBl-00051B-Hg
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBj-0001wE-Gt
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28171
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBj-0001tT-Ba
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZRqSlxyEb2ZTaTC9B8OpQelTn+FwE72xQVBk3qgcRFo=;
 b=bTuElouaTE1sXn3eI/EPBscD7RWDMqKFbN3erJIauwnhQvxYCisJo7ajgTxg8pkgLwMYPZ
 A7kbmEdTgus4WgaF7iAkGOZyewrufUWDcYvxDuqFg+5Jf2dPUbYLPXrWbzk2dmYaZ4VQUd
 8mIFJrTdAqTusKXCoEhNkG7nVaPzwcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-qkivLEI3MlayGS6PLGGlLA-1; Tue, 31 Dec 2019 08:03:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F126E1005502
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7679D78E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:51 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/86] numa: properly check if numa is supported
Date: Tue, 31 Dec 2019 14:02:46 +0100
Message-Id: <1577797450-88458-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qkivLEI3MlayGS6PLGGlLA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/arm/sbsa-ref.c | 1 -
 hw/core/machine.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5853bde..9b5bcb5 100644
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
index 56137e9..73bf1f8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -843,7 +843,7 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
=20
-    if (mc->numa_mem_supported) {
+    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state =3D g_new0(NumaState, 1);
     }
=20
@@ -966,7 +966,7 @@ void machine_run_board_init(MachineState *machine)
 {
     MachineClass *machine_class =3D MACHINE_GET_CLASS(machine);
=20
-    if (machine_class->numa_mem_supported) {
+    if (machine->numa_state) {
         numa_complete_configuration(machine);
         if (machine->numa_state->num_nodes) {
             machine_numa_finish_cpu_init(machine);
--=20
2.7.4


