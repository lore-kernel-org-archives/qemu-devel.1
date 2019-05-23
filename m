Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A4EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849DC20879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849DC20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35076 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmcV-0004Cn-QR
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:14:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTmal-00036K-1I
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hTmaj-0002Kw-NE
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:13:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>)
	id 1hTmag-0002DO-Kn; Thu, 23 May 2019 08:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC4ED307D989;
	Thu, 23 May 2019 12:12:39 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 37B59795BA;
	Thu, 23 May 2019 12:12:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 23 May 2019 08:12:30 -0400
Message-Id: <20190523121230.17193-3-jsnow@redhat.com>
In-Reply-To: <20190523121230.17193-1-jsnow@redhat.com>
References: <20190523121230.17193-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 23 May 2019 12:12:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/2] docs/bitmaps: use QMP lexer instead of
 json
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The annotated style json we use in QMP documentation is not strict json
and depending on the version of Sphinx (2.0+) or Pygments installed,
might cause the build to fail.

Use the new QMP lexer.

Further, some versions of Sphinx can not apply custom lexers to "code"
directives and require the use of "code-block" directives instead, so
make that change at this time as well.

Tested under:
- Sphinx 1.3.6 and Pygments 2.4
- Sphinx 1.7.6 and Pygments 2.2
- Sphinx 2.0.1 and Pygments 2.4

Reported-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/interop/bitmaps.rst | 54 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index 510e8809a9..cf308f197b 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -199,7 +199,7 @@ persistence, and recording state can be adjusted at c=
reation time.
=20
  to create a new, actively recording persistent bitmap:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-add",
        "arguments": {
@@ -220,7 +220,7 @@ persistence, and recording state can be adjusted at c=
reation time.
  To create a new, disabled (``-recording``), transient bitmap that track=
s
  changes in 32KiB segments:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-add",
        "arguments": {
@@ -254,7 +254,7 @@ Deletes a bitmap. Bitmaps that are ``+busy`` cannot b=
e removed.
=20
  Remove a bitmap named ``bitmap0`` from node ``drive0``:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-remove",
        "arguments": {
@@ -280,7 +280,7 @@ Clears all dirty bits from a bitmap. ``+busy`` bitmap=
s cannot be cleared.
=20
  Clear all dirty bits from bitmap ``bitmap0`` on node ``drive0``:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-clear",
        "arguments": {
@@ -309,7 +309,7 @@ begin being recorded. ``+busy`` bitmaps cannot be ena=
bled.
=20
  To set ``+recording`` on bitmap ``bitmap0`` on node ``drive0``:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-enable",
        "arguments": {
@@ -347,7 +347,7 @@ writes to begin being ignored. ``+busy`` bitmaps cann=
ot be disabled.
=20
  To set ``-recording`` on bitmap ``bitmap0`` on node ``drive0``:
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-disable",
        "arguments": {
@@ -393,7 +393,7 @@ in any one source bitmap, the target bitmap will mark=
 that segment dirty.
  ``drive0``. If ``new_bitmap`` was empty prior to this command, this ach=
ieves
  a copy.
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> { "execute": "block-dirty-bitmap-merge",
        "arguments": {
@@ -424,7 +424,7 @@ attached to nodes serving as the root for guest devic=
es.
  API. This result highlights a bitmap ``bitmap0`` attached to the root n=
ode of
  device ``drive0``.
=20
- .. code:: json
+ .. code-block:: QMP
=20
   -> {
        "execute": "query-block",
@@ -562,7 +562,7 @@ new, empty bitmap that records writes from this point=
 in time forward.
           destination. These writes will be recorded in the bitmap
           accordingly.
=20
-.. code:: json
+.. code-block:: QMP
=20
   -> {
        "execute": "transaction",
@@ -650,7 +650,7 @@ Example: Resetting an Incremental Backup Anchor Point
 If we want to start a new backup chain with an existing bitmap, we can a=
lso
 use a transaction to reset the bitmap while making a new full backup:
=20
-.. code:: json
+.. code-block:: QMP
=20
   -> {
        "execute": "transaction",
@@ -730,7 +730,7 @@ Example: First Incremental Backup
=20
 #. Issue an incremental backup command:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "drive-backup",
@@ -788,7 +788,7 @@ Example: Second Incremental Backup
 #. Issue a new incremental backup command. The only difference here is t=
hat we
    have changed the target image below.
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "drive-backup",
@@ -869,7 +869,7 @@ image:
 #. Issue a new incremental backup command. Apart from the new destinatio=
n
    image, there is no difference from the last two examples.
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "drive-backup",
@@ -932,7 +932,7 @@ point in time.
=20
 #. Create a full (anchor) backup for each drive, with accompanying bitma=
ps:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "transaction",
@@ -1018,7 +1018,7 @@ point in time.
=20
 #. Issue a multi-drive incremental push backup transaction:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "transaction",
@@ -1121,7 +1121,7 @@ described above. This example demonstrates the sing=
le-job failure case:
=20
 #. Attempt to create an incremental backup via QMP:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "drive-backup",
@@ -1139,7 +1139,7 @@ described above. This example demonstrates the sing=
le-job failure case:
=20
 #. Receive a pair of events indicating failure:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...},
@@ -1175,7 +1175,7 @@ described above. This example demonstrates the sing=
le-job failure case:
 #. Retry the command after fixing the underlying problem, such as
    freeing up space on the backup volume:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "drive-backup",
@@ -1193,7 +1193,7 @@ described above. This example demonstrates the sing=
le-job failure case:
=20
 #. Receive confirmation that the job completed successfully:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...},
@@ -1233,7 +1233,7 @@ and one succeeds:
=20
 #. Issue the transaction to start a backup of both drives.
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "transaction",
@@ -1267,13 +1267,13 @@ and one succeeds:
 #. Receive notice that the Transaction was accepted, and jobs were
    launched:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- { "return": {} }
=20
 #. Receive notice that the first job has completed:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...},
@@ -1289,7 +1289,7 @@ and one succeeds:
=20
 #. Receive notice that the second job has failed:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...},
@@ -1365,7 +1365,7 @@ applied:
=20
 #. Issue the multi-drive incremental backup transaction:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     -> {
          "execute": "transaction",
@@ -1401,13 +1401,13 @@ applied:
=20
 #. Receive notice that the Transaction was accepted, and jobs were launc=
hed:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- { "return": {} }
=20
 #. Receive notification that the backup job for ``drive1`` has failed:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...},
@@ -1434,7 +1434,7 @@ applied:
=20
 #. Receive notification that the job for ``drive0`` has been cancelled:
=20
-   .. code:: json
+   .. code-block:: QMP
=20
     <- {
          "timestamp": {...}
--=20
2.20.1


