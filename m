Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9134CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B6E2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TgxAmmwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B6E2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNwH-0000xF-G9
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifNtm-0006Au-Pu
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifNtl-0005ry-OW
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:54 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53669
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifNtl-0005qx-Jq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576154933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3eBk9H3wmrRYV94a1hWXPBU9DHclXPvjVNKrXohu3g=;
 b=TgxAmmwCe5jLHP6xzcWAPoYlQ5GChduaRnfHaJzWOCViXOiKIrd+eh7ednU6kHGAO5KDic
 EW1VagCdfztZGOpFTnWsv7/13wmFC+yWgqBUF7TNNKUkYE0l1hJSZQGC4pg/+aSJeD7um4
 qEwtvvKrXK4bFhP88uBgKp9+yk2BHQs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Xs1KILyFN56-Kb0m_Vc_dQ-1; Thu, 12 Dec 2019 07:48:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA7F107ACC4;
 Thu, 12 Dec 2019 12:48:48 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E91710013A1;
 Thu, 12 Dec 2019 12:48:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] numa: properly check if numa is supported
Date: Thu, 12 Dec 2019 13:48:56 +0100
Message-Id: <1576154936-178362-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Xs1KILyFN56-Kb0m_Vc_dQ-1
X-Mimecast-Spam-Score: 0
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Tao Xu <tao3.xu@intel.com>,
 qemu-stable@nongnu.org, Leif Lindholm <leif.lindholm@linaro.org>,
 qemu-arm@nongnu.org
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
---
CC: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Leif Lindholm <leif.lindholm@linaro.org>
CC: qemu-arm@nongnu.org
CC: qemu-stable@nongnu.org


 hw/arm/sbsa-ref.c | 1 -
 hw/core/machine.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 27046cc..c6261d4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -791,7 +791,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *=
data)
     mc->possible_cpu_arch_ids =3D sbsa_ref_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props =3D sbsa_ref_cpu_index_to_props;
     mc->get_default_cpu_node_id =3D sbsa_ref_get_default_cpu_node_id;
-    mc->numa_mem_supported =3D true;
 }
=20
 static const TypeInfo sbsa_ref_info =3D {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3..aa63231 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -958,7 +958,7 @@ static void machine_initfn(Object *obj)
                                         NULL);
     }
=20
-    if (mc->numa_mem_supported) {
+    if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state =3D g_new0(NumaState, 1);
     }
=20
@@ -1102,7 +1102,7 @@ void machine_run_board_init(MachineState *machine)
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


