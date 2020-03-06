Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E74C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758D72051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1Hu78Qg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758D72051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGpF-000577-KA
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZg-0005GK-67
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZc-0008RH-7K
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30438
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZb-0008PM-Ub
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDPIE2uBT9lfTxkITaSTNTPtgcdUQnhMi/Dy/IkXucU=;
 b=Z1Hu78QgBJRkQj4BL3fdspJMrcSedMyQlbJ39A7nq/PX98WlOgFHCYa2RqETvp2z1bWz1d
 3ouZmH0/YL7nG+PiFftuWKWj4ONgtN5eKjXJxkWDVkVascXGJONKE1JT+vyHMdF4ljhYgI
 gBJJlkqKY/cOupeejwBe5SHJQq61wgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-EbNrTc4wMniklePYqClmcw-1; Fri, 06 Mar 2020 12:15:41 -0500
X-MC-Unique: EbNrTc4wMniklePYqClmcw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FE241005509;
 Fri,  6 Mar 2020 17:15:40 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8343F73873;
 Fri,  6 Mar 2020 17:15:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 27/29] block/rbd: Add support for ceph namespaces
Date: Fri,  6 Mar 2020 18:14:56 +0100
Message-Id: <20200306171458.1848-28-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Florian Florensa <fflorensa@online.net>

Starting from ceph Nautilus, RBD has support for namespaces, allowing
for finer grain ACLs on images inside a pool, and tenant isolation.

In the rbd cli tool documentation, the new image-spec and snap-spec are :
 - [pool-name/[namespace-name/]]image-name
 - [pool-name/[namespace-name/]]image-name@snap-name

When using an non namespace's enabled qemu, it complains about not
finding the image called namespace-name/image-name, thus we only need to
parse the image once again to find if there is a '/' in its name, and if
there is, use what is before it as the name of the namespace to later
pass it to rados_ioctx_set_namespace.
rados_ioctx_set_namespace if called with en empty string or a null
pointer as the namespace parameters pretty much does nothing, as it then
defaults to the default namespace.

The namespace is extracted inside qemu_rbd_parse_filename, stored in the
qdict, and used in qemu_rbd_connect to make it work with both qemu-img,
and qemu itself.

Signed-off-by: Florian Florensa <fflorensa@online.net>
Message-Id: <20200110111513.321728-2-fflorensa@online.net>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json |  3 +++
 block/rbd.c          | 44 +++++++++++++++++++++++++++++++-------------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 48631218fa..9758fc48d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3544,6 +3544,8 @@
 #
 # @pool: Ceph pool name.
 #
+# @namespace: Rados namespace name in the Ceph pool. (Since 5.0)
+#
 # @image: Image name in the Ceph pool.
 #
 # @conf: path to Ceph configuration file.  Values
@@ -3570,6 +3572,7 @@
 ##
 { 'struct': 'BlockdevOptionsRbd',
   'data': { 'pool': 'str',
+            '*namespace': 'str',
             'image': 'str',
             '*conf': 'str',
             '*snapshot': 'str',
diff --git a/block/rbd.c b/block/rbd.c
index 027cbcc695..84115d34b4 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -104,6 +104,7 @@ typedef struct BDRVRBDState {
     rbd_image_t image;
     char *image_name;
     char *snap;
+    char *namespace;
     uint64_t image_size;
 } BDRVRBDState;
=20
@@ -152,7 +153,7 @@ static void qemu_rbd_parse_filename(const char *filenam=
e, QDict *options,
     const char *start;
     char *p, *buf;
     QList *keypairs =3D NULL;
-    char *found_str;
+    char *found_str, *image_name;
=20
     if (!strstart(filename, "rbd:", &start)) {
         error_setg(errp, "File name must start with 'rbd:'");
@@ -171,18 +172,24 @@ static void qemu_rbd_parse_filename(const char *filen=
ame, QDict *options,
     qdict_put_str(options, "pool", found_str);
=20
     if (strchr(p, '@')) {
-        found_str =3D qemu_rbd_next_tok(p, '@', &p);
-        qemu_rbd_unescape(found_str);
-        qdict_put_str(options, "image", found_str);
+        image_name =3D qemu_rbd_next_tok(p, '@', &p);
=20
         found_str =3D qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
         qdict_put_str(options, "snapshot", found_str);
     } else {
-        found_str =3D qemu_rbd_next_tok(p, ':', &p);
+        image_name =3D qemu_rbd_next_tok(p, ':', &p);
+    }
+    /* Check for namespace in the image_name */
+    if (strchr(image_name, '/')) {
+        found_str =3D qemu_rbd_next_tok(image_name, '/', &image_name);
         qemu_rbd_unescape(found_str);
-        qdict_put_str(options, "image", found_str);
+        qdict_put_str(options, "namespace", found_str);
+    } else {
+        qdict_put_str(options, "namespace", "");
     }
+    qemu_rbd_unescape(image_name);
+    qdict_put_str(options, "image", image_name);
     if (!p) {
         goto done;
     }
@@ -343,6 +350,11 @@ static QemuOptsList runtime_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "Rados pool name",
         },
+        {
+            .name =3D "namespace",
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Rados namespace name in the pool",
+        },
         {
             .name =3D "image",
             .type =3D QEMU_OPT_STRING,
@@ -467,13 +479,14 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
      * schema, but when they come from -drive, they're all QString.
      */
     loc =3D rbd_opts->location;
-    loc->pool     =3D g_strdup(qdict_get_try_str(options, "pool"));
-    loc->conf     =3D g_strdup(qdict_get_try_str(options, "conf"));
-    loc->has_conf =3D !!loc->conf;
-    loc->user     =3D g_strdup(qdict_get_try_str(options, "user"));
-    loc->has_user =3D !!loc->user;
-    loc->image    =3D g_strdup(qdict_get_try_str(options, "image"));
-    keypairs      =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
+    loc->pool        =3D g_strdup(qdict_get_try_str(options, "pool"));
+    loc->conf        =3D g_strdup(qdict_get_try_str(options, "conf"));
+    loc->has_conf    =3D !!loc->conf;
+    loc->user        =3D g_strdup(qdict_get_try_str(options, "user"));
+    loc->has_user    =3D !!loc->user;
+    loc->q_namespace =3D g_strdup(qdict_get_try_str(options, "namespace"))=
;
+    loc->image       =3D g_strdup(qdict_get_try_str(options, "image"));
+    keypairs         =3D qdict_get_try_str(options, "=3Dkeyvalue-pairs");
=20
     ret =3D qemu_rbd_do_create(create_options, keypairs, password_secret, =
errp);
     if (ret < 0) {
@@ -648,6 +661,11 @@ static int qemu_rbd_connect(rados_t *cluster, rados_io=
ctx_t *io_ctx,
         error_setg_errno(errp, -r, "error opening pool %s", opts->pool);
         goto failed_shutdown;
     }
+    /*
+     * Set the namespace after opening the io context on the pool,
+     * if nspace =3D=3D NULL or if nspace =3D=3D "", it is just as we did =
nothing
+     */
+    rados_ioctx_set_namespace(*io_ctx, opts->q_namespace);
=20
     return 0;
=20
--=20
2.20.1


