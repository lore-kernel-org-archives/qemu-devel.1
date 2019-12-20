Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32D5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1C0206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 19:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKNq0E99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1C0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiNqo-0000DK-Bj
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 14:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpQ-00073P-Pz
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiNpP-0005of-Oq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:48 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiNpP-0005ma-Kf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 14:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576869646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zETl4ubOq+A35YsHo8u3TdJ3UnMGQKtYOawhE190Qs8=;
 b=XKNq0E99mMmMLnAjsdQGG6tvREHkJ1fYczITMhWhtCeIGhewDOUYpswPRbA6T78UBA7iWO
 XGAjFroOQoU5FTYDv8mw2UF7ez4Zmn3ejbseciTvQgPjd7BzgVNXMHIMmVGtcLTZFA14tS
 UTbjBywjMpsW/CSF5gfFR79iciQ8imQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-FnyqBFRGNju0BkwNDN0c6w-1; Fri, 20 Dec 2019 14:20:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29F27107ACC5;
 Fri, 20 Dec 2019 19:20:44 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820A25C1B0;
 Fri, 20 Dec 2019 19:20:43 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/3] numa: remove not needed check
Date: Fri, 20 Dec 2019 16:20:30 -0300
Message-Id: <20191220192031.2226378-3-ehabkost@redhat.com>
In-Reply-To: <20191220192031.2226378-1-ehabkost@redhat.com>
References: <20191220192031.2226378-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: FnyqBFRGNju0BkwNDN0c6w-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Currently parse_numa_node() is always called from already numa
enabled context.
Drop unnecessary check if numa is supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1576154936-178362-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/numa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a984f..19f082de12 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -83,10 +83,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOp=
tions *node,
         return;
     }
=20
-    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) =
{
-        error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
-    }
     for (cpus =3D node->cpus; cpus; cpus =3D cpus->next) {
         CpuInstanceProperties props;
         if (cpus->value >=3D max_cpus) {
@@ -178,9 +174,8 @@ void parse_numa_distance(MachineState *ms, NumaDistOpti=
ons *dist, Error **errp)
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err =3D NULL;
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
=20
-    if (!mc->numa_mem_supported) {
+    if (!ms->numa_state) {
         error_setg(errp, "NUMA is not supported by this machine-type");
         goto end;
     }
--=20
2.23.0


