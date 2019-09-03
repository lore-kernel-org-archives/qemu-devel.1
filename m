Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCD422CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCD422CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Gam-0000id-Fa
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwh-0004St-U0
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5Fwg-0001TL-MT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5Fwg-0001Sn-Ez
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC23E8980EA;
 Tue,  3 Sep 2019 21:02:33 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53BC319D70;
 Tue,  3 Sep 2019 21:02:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:02:00 -0300
Message-Id: <20190903210201.14627-13-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 21:02:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 12/13] x86: do not advertise die-id in
 query-hotpluggbale-cpus if '-smp dies' is not set
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

From: Igor Mammedov <imammedo@redhat.com>

Commit 176d2cda0 (i386/cpu: Consolidate die-id validity in smp context) a=
dded
new 'die-id' topology property to CPUs and exposed it via QMP command
query-hotpluggable-cpus, which broke -device/device_add cpu-foo for exist=
ing
users that do not support die-id/dies yet. That's would be fine if it hap=
pened
to new machine type only but it also happened to old machine types,
which breaks migration from old QEMU to the new one, for example followin=
g CLI:

  OLD-QEMU -M pc-i440fx-4.0 -smp 1,max_cpus=3D2 \
           -device qemu64-x86_64-cpu,socket-id=3D1,core-id=3D0,thread-id
is not able to start with new QEMU, complaining about invalid die-id.

After discovering regression, the patch
   "pc: Don't make die-id mandatory unless necessary"
makes die-id optional so old CLI would work.

However it's not enough as new QEMU still exposes die-id via query-hotplu=
ggbale-cpus
QMP command, so the users that started old machine type on new QEMU, usin=
g all
properties (including die-id) received from QMP command (as required), wo=
n't be
able to start old QEMU using the same properties since it doesn't support=
 die-id.

Fix it by hiding die-id in query-hotpluggbale-cpus for all machine types =
in case
'-smp dies' is not provided on CLI or -smp dies =3D 1', in which case smp=
_dies =3D=3D 1
and APIC ID is calculated in default way (as it was before DIE support) s=
o we won't
need compat code as in both cases the topology provided to guest via CPUI=
D is the same.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190902120222.6179-1-imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c7200b0b54..bad866fe44 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2916,8 +2916,10 @@ static const CPUArchIdList *pc_possible_cpu_arch_i=
ds(MachineState *ms)
                                  ms->smp.threads, &topo);
         ms->possible_cpus->cpus[i].props.has_socket_id =3D true;
         ms->possible_cpus->cpus[i].props.socket_id =3D topo.pkg_id;
-        ms->possible_cpus->cpus[i].props.has_die_id =3D true;
-        ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
+        if (pcms->smp_dies > 1) {
+            ms->possible_cpus->cpus[i].props.has_die_id =3D true;
+            ms->possible_cpus->cpus[i].props.die_id =3D topo.die_id;
+        }
         ms->possible_cpus->cpus[i].props.has_core_id =3D true;
         ms->possible_cpus->cpus[i].props.core_id =3D topo.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id =3D true;
--=20
2.21.0


