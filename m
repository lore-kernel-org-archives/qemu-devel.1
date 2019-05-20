Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E5EC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78E6E2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E6E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37259 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkGV-0002MB-LZ
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 11:31:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hSkEJ-0000rT-Td
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hSkEH-0004XT-Sk
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:29:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hSkEF-0004Uw-Ki; Mon, 20 May 2019 11:29:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 480375D61E;
	Mon, 20 May 2019 15:29:25 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA42219C68;
	Mon, 20 May 2019 15:29:22 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 17:29:21 +0200
Message-Id: <20190520152921.15959-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 20 May 2019 15:29:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] numa: improve cpu hotplug error message with a
 wrong node-id
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-arm@nongnu.org,
	qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On pseries, core-ids are strongly binded to a node-id by the command
line option. If a user tries to add a CPU to the wrong node, he has
an error but it is not really helpful:

  qemu-system-ppc64 ... -smp 1,maxcpus=3D64,cores=3D1,threads=3D1,sockets=
=3D1 \
                        -numa node,nodeid=3D0 -numa node,nodeid=3D1 ...

  (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=3D30,node-id=3D1
  Error: node-id=3D1 must match numa node specified with -numa option

This patch improves this error message by giving to the user the good
node-id to use with the core-id he's providing:

  Error: core-id 30 can only be plugged into node-id 0

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 numa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index 3875e1efda3a..c419c5b5b8ee 100644
--- a/numa.c
+++ b/numa.c
@@ -470,8 +470,9 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceS=
tate *dev, Error **errp)
                                     "node-id", errp);
         }
     } else if (node_id !=3D slot->props.node_id) {
-        error_setg(errp, "node-id=3D%d must match numa node specified "
-                   "with -numa option", node_id);
+        error_setg(errp,
+                   "core-id %"PRId64" can only be plugged into node-id %=
"PRId64,
+                   slot->props.core_id, slot->props.node_id);
     }
 }
=20
--=20
2.20.1


