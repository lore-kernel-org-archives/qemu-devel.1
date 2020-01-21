Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9EAC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99162253D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbyyGOv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99162253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itrMi-00056J-Hv
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 06:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itrKZ-0002iP-Op
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itrKW-0002H4-80
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itrKW-0002GO-3s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 06:04:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579604659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9YLZWFuUPGqf31v4qZl1Pp9bDL94NV9XAqJHkBYaeI=;
 b=AbyyGOv/hSPjJphB9/XKPAa6XxYP68qoqlNnRjpgKVGs2Fbq0iGi9axaRzdksR7rypfZgg
 xHdhc+iaXPoAqQPs/4ajTEvh8ffolPyZuhrCu+DPdT2LTFvTVgFtSkYH+Xd9MRQkZcfSpW
 eVdcFOAKGU0u61f3FWiAznyCyY46uOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-LMl9Q4MAPJu1MdrGURLk5g-1; Tue, 21 Jan 2020 06:04:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0497E107ACC7;
 Tue, 21 Jan 2020 11:04:11 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-38.brq.redhat.com [10.40.205.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EC2583860;
 Tue, 21 Jan 2020 11:04:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/10] hw/ppc/spapr_rtas: Use local MachineState variable
Date: Tue, 21 Jan 2020 12:03:40 +0100
Message-Id: <20200121110349.25842-2-philmd@redhat.com>
In-Reply-To: <20200121110349.25842-1-philmd@redhat.com>
References: <20200121110349.25842-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: LMl9Q4MAPJu1MdrGURLk5g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we have the MachineState already available locally,
use it instead of the global current_machine.

Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/spapr_rtas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 8d8d8cdfcb..e88bb1930e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -281,7 +281,7 @@ static void rtas_ibm_get_system_parameter(PowerPCCPU *c=
pu,
                                           "DesProcs=3D%d,"
                                           "MaxPlatProcs=3D%d",
                                           max_cpus,
-                                          current_machine->ram_size / MiB,
+                                          ms->ram_size / MiB,
                                           ms->smp.cpus,
                                           max_cpus);
         if (pcc->n_host_threads > 0) {
--=20
2.21.1


