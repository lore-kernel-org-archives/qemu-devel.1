Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9E1217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9E1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52286 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU7iX-0000ja-Bl
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:46:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hU7h7-0008Az-8I
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hU7Y5-0004R8-WF
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:35:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>)
	id 1hU7Y4-0004OG-PA; Fri, 24 May 2019 06:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F82D821D1;
	Fri, 24 May 2019 10:35:25 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.205.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C178868417;
	Fri, 24 May 2019 10:35:22 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 12:35:21 +0200
Message-Id: <20190524103521.13847-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Fri, 24 May 2019 10:35:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3] numa: improve cpu hotplug error message
 with a wrong node-id
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
line option. If an user tries to add a CPU to the wrong node, he has
an error but it is not really helpful:

  qemu-system-ppc64 ... -smp 1,maxcpus=3D64,cores=3D1,threads=3D1,sockets=
=3D1 \
                        -numa node,nodeid=3D0 -numa node,nodeid=3D1 ...

  (qemu) device_add power9_v2.0-spapr-cpu-core,core-id=3D30,node-id=3D1
  Error: node-id=3D1 must match numa node specified with -numa option

This patch improves this error message by giving to the user the good
topology information (node-id, socket-id and thread-id if they are
available) to use with the core-id he's providing:

  Error: node-id=3D1 must match numa node specified with -numa option 'no=
de-id 0'

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v3: only add the topology to the existing message
        As suggested by Igor replace
          Error: core-id 30 can only be plugged into node-id 0
        by
          Error: node-id=3D1 must match numa node specified with -numa op=
tion 'node-id 0'
   =20
    v2: display full topology in the error message

 numa.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/numa.c b/numa.c
index 3875e1efda3a..7882ec294be4 100644
--- a/numa.c
+++ b/numa.c
@@ -458,6 +458,27 @@ void qmp_set_numa_node(NumaOptions *cmd, Error **err=
p)
     set_numa_options(MACHINE(qdev_get_machine()), cmd, errp);
 }
=20
+static char *cpu_topology_to_string(const CPUArchId *cpu)
+{
+    GString *s =3D g_string_new(NULL);
+    if (cpu->props.has_socket_id) {
+        g_string_append_printf(s, "socket-id %"PRId64, cpu->props.socket=
_id);
+    }
+    if (cpu->props.has_node_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "node-id %"PRId64, cpu->props.node_id)=
;
+    }
+    if (cpu->props.has_thread_id) {
+        if (s->len) {
+            g_string_append_printf(s, ", ");
+        }
+        g_string_append_printf(s, "thread-id %"PRId64, cpu->props.thread=
_id);
+    }
+    return g_string_free(s, false);
+}
+
 void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **=
errp)
 {
     int node_id =3D object_property_get_int(OBJECT(dev), "node-id", &err=
or_abort);
@@ -470,8 +491,10 @@ void numa_cpu_pre_plug(const CPUArchId *slot, Device=
State *dev, Error **errp)
                                     "node-id", errp);
         }
     } else if (node_id !=3D slot->props.node_id) {
+        char *topology =3D cpu_topology_to_string(slot);
         error_setg(errp, "node-id=3D%d must match numa node specified "
-                   "with -numa option", node_id);
+                   "with -numa option '%s'", node_id, topology);
+        g_free(topology);
     }
 }
=20
--=20
2.20.1


