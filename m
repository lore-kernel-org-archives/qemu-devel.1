Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626C3C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:45:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A16221E3
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXbOtnwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A16221E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGegc-00078M-QE
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGefc-0005H5-Pd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:44:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kGefb-0002is-4F
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599813874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TTA9MZ8aUIl276MUEBXq81ro2HhgcO3JcrlnA45PJU=;
 b=LXbOtnwhqKE7BFo4kGh6J4kn/Uicq3Jgz9b6xNOx936iHXu5aT9xNd+/NetDzfpfq0rPK9
 uZbply95fTFsfrIZ4T255r4UpsZwAUe2mfb4G1qFmpTDVfytCbrNIFsczbhj4TR7fhzXU3
 5CfdSOZphoPaWGK2CINhVl2T/M64tUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-Esj6XvldP1evPYuENna4Dw-1; Fri, 11 Sep 2020 04:44:30 -0400
X-MC-Unique: Esj6XvldP1evPYuENna4Dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A6210BBEDA;
 Fri, 11 Sep 2020 08:44:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FEB581C44;
 Fri, 11 Sep 2020 08:44:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] numa: remove fixup numa_state->num_nodes to MAX_NODES
Date: Fri, 11 Sep 2020 04:44:10 -0400
Message-Id: <20200911084410.788171-4-imammedo@redhat.com>
In-Reply-To: <20200911084410.788171-1-imammedo@redhat.com>
References: <20200911084410.788171-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, david@gibson.dropbear.id.au,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

current code permits only nodeids in [0..MAX_NODES) range
due to nodeid check in

  parse_numa_node()
      if (nodenr >= MAX_NODES) {
          error_setg(errp, "Max number of NUMA nodes reached: %"

so subj fixup is not reachable, drop it.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/numa.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 706c1e84c6..7d5d413001 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -677,10 +677,6 @@ void numa_complete_configuration(MachineState *ms)
     if (ms->numa_state->num_nodes > 0) {
         uint64_t numa_total;
 
-        if (ms->numa_state->num_nodes > MAX_NODES) {
-            ms->numa_state->num_nodes = MAX_NODES;
-        }
-
         numa_total = 0;
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             numa_total += numa_info[i].node_mem;
-- 
2.27.0


