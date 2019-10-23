Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804CDCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5439A21872
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5439A21872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIEa-0003wN-QJ
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33051)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iNHzs-0000pF-VC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iNHzr-0004Ay-Br
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52376
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iNHzr-0004Ad-6v
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:52:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9NEpPWu079567
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:22 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vts0ag1c0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:52:22 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 23 Oct 2019 15:52:19 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Oct 2019 15:52:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9NEqGln41746582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2019 14:52:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BA656A4060;
 Wed, 23 Oct 2019 14:52:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81BA9A4054;
 Wed, 23 Oct 2019 14:52:16 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.36.67])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2019 14:52:16 +0000 (GMT)
Subject: [PATCH 4/6] qom: Add object_child_foreach_type() helper function
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Oct 2019 16:52:16 +0200
In-Reply-To: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
References: <157184231371.3053790.17713393349394736594.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102314-4275-0000-0000-000003763436
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102314-4276-0000-0000-000038895BDE
Message-Id: <157184233616.3053790.246919545000657597.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling a function for children of a certain type is a recurring pattern
in the QEMU code base. In order to avoid the need to setup the same boiler
plate again and again, introduce a variant of object_child_foreach() that
only considers children of the given type.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 include/qom/object.h |   35 +++++++++++++++++++++++++++++++++++
 qom/object.c         |   30 +++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 128d00c77fd6..e9e3c2eae8ed 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1728,6 +1728,41 @@ int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opaque),
 int object_child_foreach_recursive(Object *obj,
                                    int (*fn)(Object *child, void *opaque),
                                    void *opaque);
+
+/**
+ * object_child_foreach_type:
+ * @obj: the object whose children will be navigated
+ * @typename: the type of child objects to consider
+ * @fn: the iterator function to be called
+ * @opaque: an opaque value that will be passed to the iterator
+ *
+ * This is similar to object_child_foreach, but it only calls @fn for
+ * child objects of the give @typename.
+ *
+ * Returns: The last value returned by @fn, or 0 if there is no child of
+ * the given @typename.
+ */
+int object_child_foreach_type(Object *obj, const char *typename,
+                              int (*fn)(Object *child, void *opaque),
+                              void *opaque);
+
+/**
+ * object_child_foreach_recursive_type:
+ * @obj: the object whose children will be navigated
+ * @typename: the type of child objects to consider
+ * @fn: the iterator function to be called
+ * @opaque: an opaque value that will be passed to the iterator
+ *
+ * This is similar to object_child_foreach_recursive, but it only calls
+ * @fn for child objects of the give @typename.
+ *
+ * Returns: The last value returned by @fn, or 0 if there is no child of
+ * the given @typename.
+ */
+int object_child_foreach_recursive_type(Object *obj, const char *typename,
+                                        int (*fn)(Object *child, void *opaque),
+                                        void *opaque);
+
 /**
  * container_get:
  * @root: root of the #path, e.g., object_get_root()
diff --git a/qom/object.c b/qom/object.c
index 6fa9c619fac4..a2dec1261ff7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -986,7 +986,7 @@ void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
     enumerating_types = false;
 }
 
-static int do_object_child_foreach(Object *obj,
+static int do_object_child_foreach(Object *obj, const char *typename,
                                    int (*fn)(Object *child, void *opaque),
                                    void *opaque, bool recurse)
 {
@@ -999,12 +999,14 @@ static int do_object_child_foreach(Object *obj,
         if (object_property_is_child(prop)) {
             Object *child = prop->opaque;
 
-            ret = fn(child, opaque);
-            if (ret != 0) {
-                break;
+            if (!typename || object_dynamic_cast(child, typename)) {
+                ret = fn(child, opaque);
+                if (ret != 0) {
+                    break;
+                }
             }
             if (recurse) {
-                do_object_child_foreach(child, fn, opaque, true);
+                do_object_child_foreach(child, typename, fn, opaque, true);
             }
         }
     }
@@ -1014,14 +1016,28 @@ static int do_object_child_foreach(Object *obj,
 int object_child_foreach(Object *obj, int (*fn)(Object *child, void *opaque),
                          void *opaque)
 {
-    return do_object_child_foreach(obj, fn, opaque, false);
+    return do_object_child_foreach(obj, NULL, fn, opaque, false);
 }
 
 int object_child_foreach_recursive(Object *obj,
                                    int (*fn)(Object *child, void *opaque),
                                    void *opaque)
 {
-    return do_object_child_foreach(obj, fn, opaque, true);
+    return do_object_child_foreach(obj, NULL, fn, opaque, true);
+}
+
+int object_child_foreach_type(Object *obj, const char *typename,
+                              int (*fn)(Object *child, void *opaque),
+                              void *opaque)
+{
+    return do_object_child_foreach(obj, typename, fn, opaque, false);
+}
+
+int object_child_foreach_recursive_type(Object *obj, const char *typename,
+                                        int (*fn)(Object *child, void *opaque),
+                                        void *opaque)
+{
+    return do_object_child_foreach(obj, typename, fn, opaque, true);
 }
 
 static void object_class_get_list_tramp(ObjectClass *klass, void *opaque)


