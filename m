Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9193A20768
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9193A20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5WI3-0003A9-Og
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 11:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5WEJ-0007j0-Rg
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:30:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k5WEH-0002P7-Kn
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 11:30:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-E2JI0fNdN9Gw7T28fXJKgA-1; Tue, 11 Aug 2020 11:30:16 -0400
X-MC-Unique: E2JI0fNdN9Gw7T28fXJKgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2960919067E0;
 Tue, 11 Aug 2020 15:30:15 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F137D8AD10;
 Tue, 11 Aug 2020 15:30:13 +0000 (UTC)
Subject: [PATCH 2/2] spapr/nvram: Allocate enough space for all -prom-env
 options
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Date: Tue, 11 Aug 2020 17:30:13 +0200
Message-ID: <159715981316.1635409.16117540313443167075.stgit@bahia.lan>
In-Reply-To: <159715979684.1635409.14107632395902701971.stgit@bahia.lan>
References: <159715979684.1635409.14107632395902701971.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
support the -prom-env parameter"), pseries machines can pre-initialize
the "system" partition in the NVRAM with the data passed to all -prom-env
parameters on the QEMU command line.

In this cases it is assumed that all the data fits in 64 KiB, but the user
can easily pass more and crash QEMU:

$ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
  echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; done) ; \
  done) # this requires ~128 Kib
malloc(): corrupted top size
Aborted (core dumped)

Call chrp_nvram_create_system_partition() first with its recently added
parameter dry_run set to false, to know the required size and allocate
the NVRAM buffer accordingly.

Fixes: 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to support the =
-prom-env parameter")
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/nvram/spapr_nvram.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 992b818d34e7..1b74bec6200a 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -165,6 +165,10 @@ static void spapr_nvram_realize(SpaprVioDevice *dev, E=
rror **errp)
         if (ret < 0) {
             return;
         }
+    } else if (nb_prom_envs > 0) {
+        nvram->size =3D chrp_nvram_create_system_partition(NULL,
+                                                         MIN_NVRAM_SIZE / =
4,
+                                                         true);
     } else {
         nvram->size =3D DEFAULT_NVRAM_SIZE;
     }



