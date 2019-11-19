Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968B9C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAF5219F6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OomJC6gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAF5219F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWu1x-0005VU-95
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWtsU-0002Ej-I6
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWtsL-0004qh-AQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46919
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWtsK-0004ph-Il
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574132899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AIH6JxCAKb0IeM3U+p4Z9zTJk9uNIkdsv4zT6IjEftU=;
 b=OomJC6gP5AHJVgW+2OlPZv8NU3W16hIU5SWSvzzI9Sg8Mp784hg+Taq4lBFvS9305B+Y0L
 xxDWCkj1GwzUjK84q/AzATVVIrrdOSLD1yFr7v4fdZKQh3pDTIGUrfTwbGHwJVLnfAkamx
 wTusX8fiq5trBHQqPfyFjFgZtt1a5HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-9HwMJmJwOS2uBwF4T4hYww-1; Mon, 18 Nov 2019 22:08:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCAD9107ACC4;
 Tue, 19 Nov 2019 03:08:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18B9E87B1;
 Tue, 19 Nov 2019 03:08:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] iotests: Include QMP input in .out files
Date: Mon, 18 Nov 2019 21:07:58 -0600
Message-Id: <20191119030759.24907-10-eblake@redhat.com>
In-Reply-To: <20191119030759.24907-1-eblake@redhat.com>
References: <20191119030759.24907-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9HwMJmJwOS2uBwF4T4hYww-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We generally include relevant HMP input in .out files, by virtue of
the fact that HMP echoes its input.  But QMP does not, so we have to
explicitly inject it in the output stream (appropriately filtered to
keep the tests passing), in order to make it easier to read .out files
to see what behavior is being tested (especially true where the output
file is a sequence of {'return': {}}).

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191114213415.23499-4-eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.qemu |  9 ++++
 tests/qemu-iotests/085.out     | 26 ++++++++++
 tests/qemu-iotests/094.out     |  4 ++
 tests/qemu-iotests/095.out     |  2 +
 tests/qemu-iotests/109.out     | 88 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/117.out     |  5 ++
 tests/qemu-iotests/127.out     |  4 ++
 tests/qemu-iotests/140.out     |  5 ++
 tests/qemu-iotests/141.out     | 26 ++++++++++
 tests/qemu-iotests/143.out     |  3 ++
 tests/qemu-iotests/144.out     |  5 ++
 tests/qemu-iotests/153.out     | 11 +++++
 tests/qemu-iotests/156.out     | 11 +++++
 tests/qemu-iotests/161.out     |  8 ++++
 tests/qemu-iotests/173.out     |  4 ++
 tests/qemu-iotests/182.out     |  8 ++++
 tests/qemu-iotests/183.out     | 11 +++++
 tests/qemu-iotests/185.out     | 18 +++++++
 tests/qemu-iotests/191.out     |  8 ++++
 tests/qemu-iotests/200.out     |  1 +
 tests/qemu-iotests/223.out     | 19 ++++++++
 tests/qemu-iotests/229.out     |  3 ++
 tests/qemu-iotests/249.out     |  6 +++
 23 files changed, 285 insertions(+)

diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.qem=
u
index 8d2021a7eb0c..de680cf1c7c9 100644
--- a/tests/qemu-iotests/common.qemu
+++ b/tests/qemu-iotests/common.qemu
@@ -123,6 +123,9 @@ _timed_wait_for()
 # until either timeout, or a response.  If it is not set, or <=3D0,
 # then the command is only sent once.
 #
+# If neither $silent nor $mismatch_only is set, and $cmd begins with '{',
+# echo the command before sending it the first time.
+#
 # If $qemu_error_no_exit is set, then even if the expected response
 # is not seen, we will not exit.  $QEMU_STATUS[$1] will be set it -1 in
 # that case.
@@ -152,6 +155,12 @@ _send_qemu_cmd()
         shift $(($# - 2))
     fi

+    # Display QMP being sent, but not HMP (since HMP already echoes its
+    # input back to output); decide based on leading '{'
+    if [ -z "$silent" ] && [ -z "$mismatch_only" ] &&
+            [ "$cmd" !=3D "${cmd#\{}" ]; then
+        echo "${cmd}" | _filter_testdir | _filter_imgfmt
+    fi
     while [ ${count} -gt 0 ]
     do
         echo "${cmd}" >&${QEMU_IN[${h}]}
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index 2a5f256cd3ec..bb50227b8265 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -7,48 +7,61 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D13421=
7728

 =3D=3D=3D Sending capabilities =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 =3D=3D=3D Create a single snapshot on virtio0 =3D=3D=3D

+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
 Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/t.qcow2.1 backing_fmt=3Dqcow2 cluster_size=3D65536 la=
zy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}

 =3D=3D=3D Invalid command - missing device and nodename =3D=3D=3D

+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'snapshot-file':'TES=
T_DIR/1-snapshot-v0.IMGFMT', 'format': 'IMGFMT' } }
 {"error": {"class": "GenericError", "desc": "Cannot find device=3D nor nod=
e_name=3D"}}

 =3D=3D=3D Invalid command - missing snapshot-file =3D=3D=3D

+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'format': 'IMGFMT' } }
 {"error": {"class": "GenericError", "desc": "Parameter 'snapshot-file' is =
missing"}}


 =3D=3D=3D Create several transactional group snapshots =3D=3D=3D

+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/2-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/2-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/1-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/t.qcow2.2 backing_fmt=3Dqcow2 cluster_size=3D65536 la=
zy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/3-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/3-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/2-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/2-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/4-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/4-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/3-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/3-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/5-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/5-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/4-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/4-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/6-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/6-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/5-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/5-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/7-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/7-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/6-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/6-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/8-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/8-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/7-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/7-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/9-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : { =
'device': 'virtio1', 'snapshot-file': 'TEST_DIR/9-snapshot-v1.IMGFMT' } } ]=
 } }
 Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/8-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 ba=
cking_file=3DTEST_DIR/8-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'transaction', 'arguments': {'actions': [ { 'type': 'blockdev=
-snapshot-sync', 'data' : { 'device': 'virtio0', 'snapshot-file': 'TEST_DIR=
/10-snapshot-v0.IMGFMT' } }, { 'type': 'blockdev-snapshot-sync', 'data' : {=
 'device': 'virtio1', 'snapshot-file': 'TEST_DIR/10-snapshot-v1.IMGFMT' } }=
 ] } }
 Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=3Dqcow2 size=3D134217728 b=
acking_file=3DTEST_DIR/9-snapshot-v0.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2 size=3D134217728 b=
acking_file=3DTEST_DIR/9-snapshot-v1.qcow2 backing_fmt=3Dqcow2 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"return": {}}
@@ -56,35 +69,48 @@ Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=3Dqcow2=
 size=3D134217728 backing_fil
 =3D=3D=3D Create a couple of snapshots using blockdev-snapshot =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/10-snapshot-v0.IMGFMT
+{ 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_11', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TES=
T_DIR/11-snapshot-v0.IMGFMT', 'node-name': 'file_11' } } }
 {"return": {}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_11' } }
 {"return": {}}
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/11-snapshot-v0.IMGFMT
+{ 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_12', 'backing': null, 'file': { 'driver': 'file', 'filename': 'TES=
T_DIR/12-snapshot-v0.IMGFMT', 'node-name': 'file_12' } } }
 {"return": {}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_12' } }
 {"return": {}}

 =3D=3D=3D Invalid command - cannot create a snapshot using a file BDS =3D=
=3D=3D

+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node':'virtio0', 'overla=
y':'file_12' } }
 {"error": {"class": "GenericError", "desc": "The overlay does not support =
backing images"}}

 =3D=3D=3D Invalid command - snapshot node used as active layer =3D=3D=3D

+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_12' } }
 {"error": {"class": "GenericError", "desc": "The overlay is already in use=
"}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node':'virtio0', 'overla=
y':'virtio0' } }
 {"error": {"class": "GenericError", "desc": "The overlay is already in use=
"}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node':'virtio0', 'overla=
y':'virtio1' } }
 {"error": {"class": "GenericError", "desc": "The overlay is already in use=
"}}

 =3D=3D=3D Invalid command - snapshot node used as backing hd =3D=3D=3D

+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_11' } }
 {"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: node =
is used as backing hd of 'snap_12'"}}

 =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134217728 backing_file=
=3DTEST_DIR/t.IMGFMT.base
+{ 'execute': 'blockdev-add', 'arguments': { 'driver': 'IMGFMT', 'node-name=
': 'snap_13', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT', =
'node-name': 'file_13' } } }
 {"return": {}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_13' } }
 {"error": {"class": "GenericError", "desc": "The overlay already has a bac=
king image"}}

 =3D=3D=3D Invalid command - The node does not exist =3D=3D=3D

+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_14' } }
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dsnap_14 =
nor node_name=3Dsnap_14"}}
+{ 'execute': 'blockdev-snapshot', 'arguments': { 'node':'nodevice', 'overl=
ay':'snap_13' } }
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnodevice=
 nor node_name=3Dnodevice"}}
 *** done
diff --git a/tests/qemu-iotests/094.out b/tests/qemu-iotests/094.out
index f3b9ecf22b73..9b6c57b3e280 100644
--- a/tests/qemu-iotests/094.out
+++ b/tests/qemu-iotests/094.out
@@ -1,16 +1,20 @@
 QA output created by 094
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/source.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{'execute': 'qmp_capabilities'}
 {"return": {}}
+{'execute': 'drive-mirror', 'arguments': {'device': 'src', 'target': 'nbd+=
unix:///?socket=3DSOCK_DIR/nbd', 'format': 'nbd', 'sync':'full', 'mode':'ex=
isting'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 67108864, "offset": 6=
7108864, "speed": 0, "type": "mirror"}}
+{'execute': 'block-job-complete', 'arguments': {'device': 'src'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": 67108864, "offset=
": 67108864, "speed": 0, "type": "mirror"}}
+{'execute': 'quit'}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/095.out b/tests/qemu-iotests/095.out
index d2e393fef8e1..614e5ccbbb38 100644
--- a/tests/qemu-iotests/095.out
+++ b/tests/qemu-iotests/095.out
@@ -10,7 +10,9 @@ virtual size: 5 MiB (5242880 bytes)

 =3D=3D=3D Running QEMU Live Commit Test =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'block-commit', 'arguments': { 'device': 'test', 'top': 'TEST=
_DIR/t.IMGFMT.snp1' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "test"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "test"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 9c1159bf08ed..884f65f18d9c 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -4,7 +4,9 @@ QA output created by 109

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -16,18 +18,24 @@ WARNING: Image format was not specified for 'TEST_DIR/t=
.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0,=
 "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024,=
 "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "=
ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -42,7 +50,9 @@ Images are identical.

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -54,18 +64,24 @@ WARNING: Image format was not specified for 'TEST_DIR/t=
.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 51=
2, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197=
120, "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status=
": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -80,7 +96,9 @@ Images are identical.

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -92,18 +110,24 @@ WARNING: Image format was not specified for 'TEST_DIR/=
t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 26=
2144, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327=
680, "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status=
": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -118,7 +142,9 @@ Images are identical.

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -130,18 +156,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0,=
 "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024,=
 "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "=
ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -156,7 +188,9 @@ Images are identical.

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -168,18 +202,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0,=
 "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 6553=
6, "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status":=
 "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -194,7 +234,9 @@ Images are identical.

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 Formatting 'TEST_DIR/t.raw.src', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -206,18 +248,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": 0,=
 "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560,=
 "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "=
ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -231,7 +279,9 @@ Images are identical.
 =3D=3D=3D Copying sample image empty.bochs into raw =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -243,18 +293,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OF=
FSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560,=
 "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "=
ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -268,7 +324,9 @@ Images are identical.
 =3D=3D=3D Copying sample image iotest-dirtylog-10G-4M.vhdx into raw =3D=3D=
=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -280,18 +338,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OF=
FSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 3=
1457280, "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "st=
atus": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror=
"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -305,7 +369,9 @@ Images are identical.
 =3D=3D=3D Copying sample image parallels-v1 into raw =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -317,18 +383,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OF=
FSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327=
680, "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status=
": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -342,7 +414,9 @@ Images are identical.
 =3D=3D=3D Copying sample image simple-pattern.cloop into raw =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -354,18 +428,24 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "src", "len": LEN, "offset": OF=
FSET, "speed": 0, "type": "mirror", "error": "Operation not permitted"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
+{"execute":"query-block-jobs"}
 {"return": []}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048,=
 "speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "=
ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -379,7 +459,9 @@ Images are identical.
 =3D=3D=3D Write legitimate MBR into raw =3D=3D=3D

 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing g=
uessed raw.
          Automatically detecting the format is dangerous for raw images, w=
rite operations on block 0 will be restricted.
          Specify the 'raw' format explicitly to remove the restrictions.
@@ -388,7 +470,9 @@ WARNING: Image format was not specified for 'TEST_DIR/t=
.raw' and probing guessed
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "=
speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "re=
ady", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
@@ -398,13 +482,17 @@ WARNING: Image format was not specified for 'TEST_DIR=
/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "src"}}
 Warning: Image size mismatch!
 Images are identical.
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{'execute':'drive-mirror', 'arguments':{ 'device': 'src', 'target': 'TEST_=
DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'existing', 'sync': 'full'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "src"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "=
speed": 0, "type": "mirror"}}
+{"execute":"query-block-jobs"}
 {"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "a=
uto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "re=
ady", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "src"}}
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 57079af167a5..bb623dcc0a49 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -1,11 +1,16 @@
 QA output created by 117
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'blockdev-add', 'arguments': { 'node-name': 'protocol', 'driv=
er': 'file', 'filename': 'TEST_DIR/t.IMGFMT' } }
 {"return": {}}
+{ 'execute': 'blockdev-add', 'arguments': { 'node-name': 'format', 'driver=
': 'IMGFMT', 'file': 'protocol' } }
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io format "write -P 42 0 64k"' } }
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 No errors were found on the image.
diff --git a/tests/qemu-iotests/127.out b/tests/qemu-iotests/127.out
index 6c98b1824ea6..623d52bbd150 100644
--- a/tests/qemu-iotests/127.out
+++ b/tests/qemu-iotests/127.out
@@ -4,16 +4,20 @@ Formatting 'TEST_DIR/t.IMGFMT.overlay0', fmt=3DIMGFMT siz=
e=3D65536 backing_file=3DTEST
 Formatting 'TEST_DIR/t.IMGFMT.overlay1', fmt=3DIMGFMT size=3D65536 backing=
_file=3DTEST_DIR/t.IMGFMT
 wrote 42/42 bytes at offset 0
 42 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'drive-mirror', 'arguments': { 'job-id': 'mirror', 'device': =
'source', 'target': 'TEST_DIR/t.IMGFMT.overlay1', 'mode': 'existing', 'sync=
': 'top' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "mirror", "len": 65536, "offset": 6=
5536, "speed": 0, "type": "mirror"}}
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'mirror' } }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "mirror", "len": 65536, "offset=
": 65536, "speed": 0, "type": "mirror"}}
+{ 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "mirror"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/140.out b/tests/qemu-iotests/140.out
index 2511eb7369e4..86b985da75be 100644
--- a/tests/qemu-iotests/140.out
+++ b/tests/qemu-iotests/140.out
@@ -2,14 +2,19 @@ QA output created by 140
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D65536
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'unix', =
'data': { 'path': 'SOCK_DIR/nbd' }}}}
 {"return": {}}
+{ 'execute': 'nbd-server-add', 'arguments': { 'device': 'drv' }}
 {"return": {}}
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'eject', 'arguments': { 'device': 'drv' }}
 {"return": {}}
 qemu-io: can't open device nbd+unix:///drv?socket=3DSOCK_DIR/nbd: Requeste=
d export not available
 server reported: export 'drv' not present
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index e3b578282da4..3645675ce83c 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -2,82 +2,108 @@ QA output created by 141
 Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D1048576
 Formatting 'TEST_DIR/m.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/b.IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/m.IMGFMT
+{'execute': 'qmp_capabilities'}
 {"return": {}}

 =3D=3D=3D Testing drive-backup =3D=3D=3D

+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driver': =
'IMGFMT', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT' }}}
 {"return": {}}
+{'execute': 'drive-backup', 'arguments': {'job-id': 'job0', 'device': 'drv=
0', 'target': 'TEST_DIR/o.IMGFMT', 'format': 'IMGFMT', 'sync': 'none'}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is =
used as backing hd of 'NODE_NAME'"}}
+{'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 0, "speed": 0, "type": "backup"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"return": {}}

 =3D=3D=3D Testing drive-mirror =3D=3D=3D

+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driver': =
'IMGFMT', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT' }}}
 {"return": {}}
+{'execute': 'drive-mirror', 'arguments': {'job-id': 'job0', 'device': 'drv=
0', 'target': 'TEST_DIR/o.IMGFMT', 'format': 'IMGFMT', 'sync': 'none'}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "spe=
ed": 0, "type": "mirror"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: mirror"}}
+{'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "mirror"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"return": {}}

 =3D=3D=3D Testing active block-commit =3D=3D=3D

+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driver': =
'IMGFMT', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT' }}}
 {"return": {}}
+{'execute': 'block-commit', 'arguments': {'job-id': 'job0', 'device': 'drv=
0'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "spe=
ed": 0, "type": "commit"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block de=
vice is in use by block job: commit"}}
+{'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"return": {}}

 =3D=3D=3D Testing non-active block-commit =3D=3D=3D

 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driver': =
'IMGFMT', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT' }}}
 {"return": {}}
+{'execute': 'block-commit', 'arguments': {'job-id': 'job0', 'device': 'drv=
0', 'top': 'TEST_DIR/m.IMGFMT', 'speed': 1}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 524288, "speed": 1, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"return": {}}

 =3D=3D=3D Testing block-stream =3D=3D=3D

 wrote 1048576/1048576 bytes at offset 0
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'drv0', 'driver': =
'IMGFMT', 'file': { 'driver': 'file', 'filename': 'TEST_DIR/t.IMGFMT' }}}
 {"return": {}}
+{'execute': 'block-stream', 'arguments': {'job-id': 'job0', 'device': 'drv=
0', 'speed': 1}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{'execute': 'block-job-cancel', 'arguments': {'device': 'job0'}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset=
": 524288, "speed": 1, "type": "stream"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
+{'execute': 'blockdev-del', 'arguments': {'node-name': 'drv0'}}
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/143.out b/tests/qemu-iotests/143.out
index 037d34a40988..1f4001c60131 100644
--- a/tests/qemu-iotests/143.out
+++ b/tests/qemu-iotests/143.out
@@ -1,8 +1,11 @@
 QA output created by 143
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'unix', =
'data': { 'path': 'SOCK_DIR/nbd' }}}}
 {"return": {}}
 qemu-io: can't open device nbd+unix:///no_such_export?socket=3DSOCK_DIR/nb=
d: Requested export not available
 server reported: export 'no_such_export' not present
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index a9a8216beac7..c7aa2e482000 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -6,17 +6,21 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D53687=
0912

 =3D=3D=3D Performing Live Snapshot 1 =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/tmp.IMGFMT', 'format': 'IMGFMT' } }
 Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D536870912 backing_file=
=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=
=3Doff refcount_bits=3D16
 {"return": {}}

 =3D=3D=3D Performing block-commit on active layer =3D=3D=3D

+{ 'execute': 'block-commit', 'arguments': { 'device': 'virtio0' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "virtio0"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "virtio0", "len": 0, "offset": 0, "=
speed": 0, "type": "commit"}}
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'virtio0' } }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "virtio0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "virtio0"}}
@@ -26,6 +30,7 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=3Dqcow2 size=3D53687=
0912 backing_file=3DTEST_DIR/

 =3D=3D=3D Performing Live Snapshot 2 =3D=3D=3D

+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'virtio0',=
 'snapshot-file':'TEST_DIR/tmp2.IMGFMT', 'format': 'IMGFMT' } }
 Formatting 'TEST_DIR/tmp2.qcow2', fmt=3Dqcow2 size=3D536870912 backing_fil=
e=3DTEST_DIR/t.qcow2 backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcount=
s=3Doff refcount_bits=3D16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
index e96942000662..f7464dd8d345 100644
--- a/tests/qemu-iotests/153.out
+++ b/tests/qemu-iotests/153.out
@@ -144,6 +144,7 @@ _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2

 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+{ 'execute': 'quit' }

 Round done

@@ -266,6 +267,7 @@ _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2

 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+{ 'execute': 'quit' }

 Round done

@@ -367,6 +369,7 @@ _qemu_img_wrapper bench -U -c 1 TEST_DIR/t.qcow2

 _qemu_img_wrapper bench -U -w -c 1 TEST_DIR/t.qcow2
 qemu-img: Could not open 'TEST_DIR/t.qcow2': force-share=3Don can only be =
used with read-only images
+{ 'execute': 'quit' }

 Round done

@@ -412,11 +415,14 @@ QEMU_PROG: -drive if=3Dnone,file=3DTEST_DIR/t.qcow2: =
Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?

 =3D=3D Active commit to intermediate layer should work when base in use =
=3D=3D
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 _qemu_img_wrapper commit -b TEST_DIR/t.qcow2.b TEST_DIR/t.qcow2.c
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
 Adding drive
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_add 0 if=3Dnone,id=3Dd0,file=3DTEST_DIR/t.IMGFMT' } }
 {"return": "OKrn"}

 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
@@ -426,20 +432,25 @@ Creating overlay with qemu-img when the guest is runn=
ing should be allowed

 _qemu_img_wrapper create -f qcow2 -b TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.ove=
rlay
 =3D=3D Closing an image should unlock it =3D=3D
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_del d0' } }
 {"return": ""}

 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 Adding two and closing one
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_add 0 if=3Dnone,id=3Dd0,file=3DTEST_DIR/t.IMGFMT,readonly=3Don' } }
 {"return": "OKrn"}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_add 0 if=3Dnone,id=3Dd1,file=3DTEST_DIR/t.IMGFMT,readonly=3Don' } }
 {"return": "OKrn"}

 _qemu_img_wrapper info TEST_DIR/t.qcow2
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_del d0' } }
 {"return": ""}

 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
 qemu-io: can't open device TEST_DIR/t.qcow2: Failed to get "write" lock
 Is another process using the image [TEST_DIR/t.qcow2]?
 Closing the other
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'driv=
e_del d1' } }
 {"return": ""}

 _qemu_io_wrapper TEST_DIR/t.qcow2 -c write 0 512
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 4c391a760371..084be5ad7151 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -5,21 +5,27 @@ wrote 262144/262144 bytes at offset 0
 256 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 196608/196608 bytes at offset 65536
 192 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
 Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=3DIMGFMT size=3D1048576 backin=
g_file=3DTEST_DIR/t.IMGFMT
+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'source', =
'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'format': 'IMGFMT', 'mode': '=
existing' } }
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "write -P 3 128k 128k"' } }
 wrote 131072/131072 bytes at offset 131072
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
 Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=3DIMGFMT size=3D1048576=
 backing_file=3DTEST_DIR/t.IMGFMT.target
+{ 'execute': 'drive-mirror', 'arguments': { 'device': 'source', 'target': =
'TEST_DIR/t.IMGFMT.target.overlay', 'mode': 'existing', 'sync': 'top' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "source"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072, "offset": =
131072, "speed": 0, "type": "mirror"}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "write -P 4 192k 64k"' } }
 wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'source' } }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "source"}}
@@ -27,19 +33,24 @@ wrote 65536/65536 bytes at offset 196608
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "source"}}

+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "read -P 1 0k 64k"' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "read -P 2 64k 64k"' } }
 read 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "read -P 3 128k 64k"' } }
 read 65536/65536 bytes at offset 131072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io source "read -P 4 192k 64k"' } }
 read 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}

+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}

diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index 39951993ee84..aef9741ed31c 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -5,15 +5,20 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.

 *** Change an option on the backing file

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io none0 "reopen -o backing.detect-zeroes=3Don"' } }
 {"return": ""}

 *** Stream and then change an option on the backing file

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'block-stream', 'arguments': { 'device': 'none0', 'base': 'TE=
ST_DIR/t.IMGFMT.base' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io none0 "reopen -o backing.detect-zeroes=3Don"' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offse=
t": 1048576, "speed": 0, "type": "stream"}}
@@ -26,10 +31,13 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
 Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'block-commit', 'arguments': { 'device': 'none0', 'top': 'TES=
T_DIR/t.IMGFMT.int' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io none0 "reopen -o backing.detect-zeroes=3Don"' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offse=
t": 1048576, "speed": 0, "type": "commit"}}
diff --git a/tests/qemu-iotests/173.out b/tests/qemu-iotests/173.out
index e83d17ec2f64..b5114b5c7952 100644
--- a/tests/qemu-iotests/173.out
+++ b/tests/qemu-iotests/173.out
@@ -4,9 +4,13 @@ Formatting 'TEST_DIR/image.snp1', fmt=3DIMGFMT size=3D1048=
57600

 =3D=3D=3D Running QEMU, using block-stream to find backing image =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'arguments': { 'device': 'disk2', 'format': 'IMGFMT', 'mode': 'existing'=
, 'snapshot-file': 'TEST_DIR/image.snp1', 'snapshot-node-name': 'snp1' }, '=
execute': 'blockdev-snapshot-sync' }
 {"return": {}}
+{ 'arguments': { 'backing-file': 'image.base', 'device': 'disk2', 'image-n=
ode-name': 'snp1' }, 'execute': 'change-backing-file' }
 {"return": {}}
+{ 'arguments': { 'base': 'TEST_DIR/image.base', 'device': 'disk2' }, 'exec=
ute': 'block-stream' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk2"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk2"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/182.out b/tests/qemu-iotests/182.out
index ffef23e32bc2..a8eea166c305 100644
--- a/tests/qemu-iotests/182.out
+++ b/tests/qemu-iotests/182.out
@@ -8,17 +8,25 @@ Is another process using the image [TEST_DIR/t.qcow2]?

 =3D=3D=3D Testing reopen =3D=3D=3D

+{'execute': 'qmp_capabilities'}
 {"return": {}}
+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'node0', 'driver':=
 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
+{'execute': 'blockdev-snapshot-sync', 'arguments': { 'node-name': 'node0',=
 'snapshot-file': 'TEST_DIR/t.IMGFMT.overlay', 'snapshot-node-name': 'node1=
' } }
 Formatting 'TEST_DIR/t.qcow2.overlay', fmt=3Dqcow2 size=3D197120 backing_f=
ile=3DTEST_DIR/t.qcow2 backing_fmt=3Dfile cluster_size=3D65536 lazy_refcoun=
ts=3Doff refcount_bits=3D16
 {"return": {}}
+{'execute': 'blockdev-add', 'arguments': { 'node-name': 'node1', 'driver':=
 'file', 'filename': 'TEST_DIR/t.IMGFMT', 'locking': 'on' } }
 {"return": {}}
+{'execute': 'nbd-server-start', 'arguments': { 'addr': { 'type': 'unix', '=
data': { 'path': 'SOCK_DIR/nbd.socket' } } } }
 {"return": {}}
+{'execute': 'nbd-server-add', 'arguments': { 'device': 'node1' } }
 {"return": {}}

 =3D=3D=3D Testing failure to loosen restrictions =3D=3D=3D

+{'execute': 'qmp_capabilities'}
 {"return": {}}
+{'execute': 'quit'}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 *** done
diff --git a/tests/qemu-iotests/183.out b/tests/qemu-iotests/183.out
index 112cf31f8bd6..d4be2cb2de5f 100644
--- a/tests/qemu-iotests/183.out
+++ b/tests/qemu-iotests/183.out
@@ -4,37 +4,48 @@ Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=3DIMGFMT size=3D=
67108864

 =3D=3D=3D Starting VMs =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 =3D=3D=3D Write something on the source =3D=3D=3D

+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "write -P 0x55 0 64k"' } }
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "read -P 0x55 0 64k"' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}

 =3D=3D=3D Do block migration to destination =3D=3D=3D

+{ 'execute': 'migrate', 'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'bl=
k': true } }
 {"return": {}}
+{ 'execute': 'query-status' }
 {"return": {"status": "postmigrate", "singlestep": false, "running": false=
}}

 =3D=3D=3D Do some I/O on the destination =3D=3D=3D

+{ 'execute': 'query-status' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "RESUME"}
 {"return": {"status": "running", "singlestep": false, "running": true}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "read -P 0x55 0 64k"' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "write -P 0x66 1M 64k"' } }
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}

 =3D=3D=3D Shut down and check image =3D=3D=3D

+{"execute":"quit"}
 {"return": {}}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index ddfbf3c76548..8379ac585422 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -3,65 +3,83 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D=
67108864

 =3D=3D=3D Starting VM =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 =3D=3D=3D Creating backing chain =3D=3D=3D

+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 's=
napshot-file': 'TEST_DIR/t.IMGFMT.mid', 'format': 'IMGFMT', 'mode': 'absolu=
te-paths' } }
 Formatting 'TEST_DIR/t.qcow2.mid', fmt=3Dqcow2 size=3D67108864 backing_fil=
e=3DTEST_DIR/t.qcow2.base backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_ref=
counts=3Doff refcount_bits=3D16
 {"return": {}}
+{ 'execute': 'human-monitor-command', 'arguments': { 'command-line': 'qemu=
-io disk "write 0 4M"' } }
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
+{ 'execute': 'blockdev-snapshot-sync', 'arguments': { 'device': 'disk', 's=
napshot-file': 'TEST_DIR/t.IMGFMT', 'format': 'IMGFMT', 'mode': 'absolute-p=
aths' } }
 Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D67108864 backing_file=3D=
TEST_DIR/t.qcow2.mid backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcount=
s=3Doff refcount_bits=3D16
 {"return": {}}

 =3D=3D=3D Start commit job and exit qemu =3D=3D=3D

+{ 'execute': 'block-commit', 'arguments': { 'device': 'disk', 'base':'TEST=
_DIR/t.IMGFMT.base', 'top': 'TEST_DIR/t.IMGFMT.mid', 'speed': 65536 } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offse=
t": 524288, "speed": 65536, "type": "commit"}}

 =3D=3D=3D Start active commit job and exit qemu =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'block-commit', 'arguments': { 'device': 'disk', 'base':'TEST=
_DIR/t.IMGFMT.base', 'speed': 65536 } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset=
": 4194304, "speed": 65536, "type": "commit"}}

 =3D=3D=3D Start mirror job and exit qemu =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'drive-mirror', 'arguments': { 'device': 'disk', 'target': 'T=
EST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 =
} }
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "offset=
": 4194304, "speed": 65536, "type": "mirror"}}

 =3D=3D=3D Start backup job and exit qemu =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'drive-backup', 'arguments': { 'device': 'disk', 'target': 'T=
EST_DIR/t.IMGFMT.copy', 'format': 'IMGFMT', 'sync': 'full', 'speed': 65536 =
} }
 Formatting 'TEST_DIR/t.qcow2.copy', fmt=3Dqcow2 size=3D67108864 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offse=
t": 65536, "speed": 65536, "type": "backup"}}

 =3D=3D=3D Start streaming job and exit qemu =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}
+{ 'execute': 'block-stream', 'arguments': { 'device': 'disk', 'speed': 655=
36 } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "disk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "disk"}}
 {"return": {}}
+{ 'execute': 'quit' }
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, "offse=
t": 524288, "speed": 65536, "type": "stream"}}
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 3fc92bb56e57..34cec7b9ecf3 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -8,6 +8,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6710886=
4 backing_file=3DTEST_DIR/t
 Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.mid
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {
     "return": {
     }
@@ -15,6 +16,7 @@ wrote 65536/65536 bytes at offset 1048576

 =3D=3D=3D Perform commit job =3D=3D=3D

+{ 'execute': 'block-commit', 'arguments': { 'job-id': 'commit0', 'device':=
 'top', 'base':'TEST_DIR/t.IMGFMT.base', 'top': 'TEST_DIR/t.IMGFMT.mid' } }
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -102,6 +104,7 @@ wrote 65536/65536 bytes at offset 1048576

 =3D=3D=3D Check that both top and top2 point to base now =3D=3D=3D

+{ 'execute': 'query-named-block-nodes' }
 {
     "return": [
         {
@@ -378,6 +381,7 @@ wrote 65536/65536 bytes at offset 1048576
         }
     ]
 }
+{ 'execute': 'quit' }
 {
     "return": {
     }
@@ -415,6 +419,7 @@ Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=3DIMGFMT size=
=3D67108864 backing_file=3DTEST_
 Formatting 'TEST_DIR/t.IMGFMT.ovl3', fmt=3DIMGFMT size=3D67108864 backing_=
file=3DTEST_DIR/t.IMGFMT.ovl2
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'qmp_capabilities' }
 {
     "return": {
     }
@@ -422,6 +427,7 @@ wrote 65536/65536 bytes at offset 1048576

 =3D=3D=3D Perform commit job =3D=3D=3D

+{ 'execute': 'block-commit', 'arguments': { 'job-id': 'commit0', 'device':=
 'top', 'base':'TEST_DIR/t.IMGFMT.base', 'top': 'TEST_DIR/t.IMGFMT.mid' } }
 {
     "timestamp": {
         "seconds":  TIMESTAMP,
@@ -509,6 +515,7 @@ wrote 65536/65536 bytes at offset 1048576

 =3D=3D=3D Check that both top and top2 point to base now =3D=3D=3D

+{ 'execute': 'query-named-block-nodes' }
 {
     "return": [
         {
@@ -796,6 +803,7 @@ wrote 65536/65536 bytes at offset 1048576
         }
     ]
 }
+{ 'execute': 'quit' }
 {
     "return": {
     }
diff --git a/tests/qemu-iotests/200.out b/tests/qemu-iotests/200.out
index af6a809e309d..a6776070e4d6 100644
--- a/tests/qemu-iotests/200.out
+++ b/tests/qemu-iotests/200.out
@@ -6,6 +6,7 @@ wrote 314572800/314572800 bytes at offset 512

 =3D=3D=3D Starting QEMU VM =3D=3D=3D

+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 =3D=3D=3D Sending stream/cancel, checking for SIGSEGV only =3D=3D=3D
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 23b34fcd202e..861ddbd9e0a4 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -24,19 +24,32 @@ wrote 2097152/2097152 bytes at offset 2097152

 =3D=3D=3D End dirty bitmaps, and start serving image over NBD =3D=3D=3D

+{"execute":"qmp_capabilities"}
 {"return": {}}
+{"execute":"blockdev-add", "arguments":{"driver":"IMGFMT", "node-name":"n"=
, "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT"}}}
 {"return": {}}
+{"execute":"x-blockdev-set-iothread", "arguments":{"node-name":"n", "iothr=
ead":"io0"}}
 {"return": {}}
+{"execute":"block-dirty-bitmap-disable", "arguments":{"node":"n", "name":"=
b"}}
 {"return": {}}
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data":=
{"path":"SOCK_DIR/nbd"}}}}
 {"return": {}}
+{"execute":"nbd-server-start", "arguments":{"addr":{"type":"unix", "data":=
{"path":"SOCK_DIR/nbd1"}}}}
 {"error": {"class": "GenericError", "desc": "NBD server already running"}}
 exports available: 0
+{"execute":"nbd-server-add", "arguments":{"device":"n", "bitmap":"b"}}
 {"return": {}}
+{"execute":"nbd-server-add", "arguments":{"device":"nosuch"}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch n=
or node_name=3Dnosuch"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n"}}
 {"error": {"class": "GenericError", "desc": "NBD server already has export=
 named 'n'"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b2"}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompati=
ble with readonly export"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "bitm=
ap":"b3"}}
 {"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
+{"execute":"nbd-server-add", "arguments":{"device":"n", "name":"n2", "writ=
able":true, "bitmap":"b2"}}
 {"return": {}}
 exports available: 2
  export: 'n'
@@ -84,11 +97,17 @@ read 2097152/2097152 bytes at offset 2097152

 =3D=3D=3D End qemu NBD server =3D=3D=3D

+{"execute":"nbd-server-remove", "arguments":{"name":"n"}}
 {"return": {}}
+{"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
 {"return": {}}
+{"execute":"nbd-server-remove", "arguments":{"name":"n2"}}
 {"error": {"class": "GenericError", "desc": "Export 'n2' is not found"}}
+{"execute":"nbd-server-stop"}
 {"return": {}}
+{"execute":"nbd-server-stop"}
 {"error": {"class": "GenericError", "desc": "NBD server not running"}}
+{"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}

diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index a3eb33788a6f..22350d75d7b1 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -3,10 +3,12 @@ Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D20971=
52
 Formatting 'TEST_DIR/d.IMGFMT', fmt=3DIMGFMT size=3D1048576
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{'execute': 'qmp_capabilities'}
 {"return": {}}

 =3D=3D=3D Starting drive-mirror, causing error & stop  =3D=3D=3D

+{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': =
'IMGFMT', 'target': 'TEST_DIR/d.IMGFMT', 'sync': 'full', 'mode': 'existing'=
, 'on-source-error': 'stop', 'on-target-error': 'stop' }}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
@@ -15,6 +17,7 @@ wrote 2097152/2097152 bytes at offset 0

 =3D=3D=3D Force cancel job paused in error state  =3D=3D=3D

+{'execute': 'block-job-cancel', 'arguments': { 'device': 'testdisk', 'forc=
e': true}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "testdisk"}}
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 1c93164e84be..51307ed0f795 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -2,24 +2,29 @@ QA output created by 249
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
 Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_fi=
le=3DTEST_DIR/t.IMGFMT.base
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int
+{ 'execute': 'qmp_capabilities' }
 {"return": {}}

 =3D=3D=3D Send a write command to a drive opened in read-only mode (1)

+{ 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
 {"return": "Block node is read-onlyrn"}

 =3D=3D=3D Run block-commit on base using an invalid filter node name

+{ 'execute': 'block-commit', 'arguments': {'job-id': 'job0', 'device': 'no=
ne1', 'top-node': 'int', 'filter-node-name': '1234'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job0"}}
 {"error": {"class": "GenericError", "desc": "Invalid node name"}}

 =3D=3D=3D Send a write command to a drive opened in read-only mode (2)

+{ 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
 {"return": "Block node is read-onlyrn"}

 =3D=3D=3D Run block-commit on base using the default filter node name

+{ 'execute': 'block-commit', 'arguments': {'job-id': 'job0', 'device': 'no=
ne1', 'top-node': 'int'}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
 {"return": {}}
@@ -31,5 +36,6 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D10485=
76 backing_file=3DTEST_DIR/t.

 =3D=3D=3D Send a write command to a drive opened in read-only mode (3)

+{ 'execute': 'human-monitor-command', 'arguments': {'command-line': 'qemu-=
io none0 "aio_write 0 2k"'}}
 {"return": "Block node is read-onlyrn"}
 *** done
--=20
2.21.0


