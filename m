Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AFFC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB0B2072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bauA0Uqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB0B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxkG-00049h-Is
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiU-0000iU-Bt
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxiR-0001kF-Mb
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39340
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxiR-0001k0-Fz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNINoW0+Z7+LurDUqBP5ZVHbjUdKXoy86mXdUqjHaME=;
 b=bauA0UquznkyRxGP9Rm0rgPY0whLn2GJD9sPYpgL6d65KgnZIXyVQDrnfzOvtNMWGDGUuc
 RFKzk/QEB/9tgFbv0bI20EzlT5bIHtd6auxLZ/nftYVh0YMyYVefXHCO3/HZnGWXquWCHe
 rSR1XNr6Ec0TKyNEJZQxl8qxrrlngNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-0_GW1qtFPQqFNGzkcvj8oA-1; Sun, 08 Mar 2020 11:19:39 -0400
X-MC-Unique: 0_GW1qtFPQqFNGzkcvj8oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5AB1005513;
 Sun,  8 Mar 2020 15:19:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 611A15C1B0;
 Sun,  8 Mar 2020 15:19:36 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/14] iotests: qemu-img tests for luks key management
Date: Sun,  8 Mar 2020 17:18:59 +0200
Message-Id: <20200308151903.25941-11-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds two tests, which test the new amend interface
of both luks raw images and qcow2 luks encrypted images.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/300     | 207 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out |  99 ++++++++++++++++++
 tests/qemu-iotests/301     |  90 ++++++++++++++++
 tests/qemu-iotests/301.out |  30 ++++++
 tests/qemu-iotests/group   |   3 +
 5 files changed, 429 insertions(+)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out
 create mode 100755 tests/qemu-iotests/301
 create mode 100644 tests/qemu-iotests/301.out

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
new file mode 100755
index 0000000000..aa1a77690f
--- /dev/null
+++ b/tests/qemu-iotests/300
@@ -0,0 +1,207 @@
+#!/usr/bin/env bash
+#
+# Test encryption key management with luks
+# Based on 134
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dmlevitsk@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
+
+_cleanup()
+{
+=09_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2 luks
+_supported_proto file #TODO
+
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+
+if [ "$IMGFMT" =3D "qcow2" ] ; then
+=09PR=3D"encrypt."
+=09EXTRA_IMG_ARGS=3D"-o encrypt.format=3Dluks"
+fi
+
+
+# secrets: you are supposed to see the password as *******, see :-)
+S0=3D"--object secret,id=3Dsec0,data=3Dhunter0"
+S1=3D"--object secret,id=3Dsec1,data=3Dhunter1"
+S2=3D"--object secret,id=3Dsec2,data=3Dhunter2"
+S3=3D"--object secret,id=3Dsec3,data=3Dhunter3"
+S4=3D"--object secret,id=3Dsec4,data=3Dhunter4"
+SECRETS=3D"$S0 $S1 $S2 $S3 $S4"
+
+# image with given secret
+IMGS0=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,${PR}key-=
secret=3Dsec0"
+IMGS1=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,${PR}key-=
secret=3Dsec1"
+IMGS2=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,${PR}key-=
secret=3Dsec2"
+IMGS3=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,${PR}key-=
secret=3Dsec3"
+IMGS4=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,${PR}key-=
secret=3Dsec4"
+
+
+echo "=3D=3D creating a test image =3D=3D"
+_make_test_img $S0 $EXTRA_IMG_ARGS -o ${PR}key-secret=3Dsec0,${PR}iter-tim=
e=3D10 32M
+
+echo
+echo "=3D=3D test that key 0 opens the image =3D=3D"
+$QEMU_IO $S0 -c "read 0 4096" $IMGS0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D adding a password to slot 4 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec4,${PR}iter-time=3D10,${PR}keyslot=3D4
+echo "=3D=3D adding a password to slot 1 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec1,${PR}iter-time=3D10
+echo "=3D=3D adding a password to slot 3 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec3,${PR}iter-time=3D10,${PR}keyslot=3D3
+
+echo "=3D=3D adding a password to slot 2 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec2,${PR}iter-time=3D10
+
+
+echo "=3D=3D erase slot 4 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}keyslot=3D4 =
| _filter_img_create
+
+
+echo
+echo "=3D=3D all secrets should work =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+echo
+echo "=3D=3D erase slot 0 and try it =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec0 | _filter_img_create
+$QEMU_IO $SECRETS -c "read 0 4096" $IMGS0 | _filter_qemu_io | _filter_test=
dir
+
+echo
+echo "=3D=3D erase slot 2 and try it =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}keyslot=3D2 =
| _filter_img_create
+$QEMU_IO $SECRETS -c "read 0 4096" $IMGS2 | _filter_qemu_io | _filter_test=
dir
+
+
+# at this point slots 1 and 3 should be active
+
+echo
+echo "=3D=3D filling  4 slots with secret 2 =3D=3D"
+for i in $(seq 0 3) ; do
+=09$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dactive,${PR}new-secret=
=3Dsec2,${PR}iter-time=3D10
+done
+
+echo
+echo "=3D=3D adding secret 0 =3D=3D"
+=09$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dactive,${PR}new-secret=
=3Dsec0,${PR}iter-time=3D10
+
+echo
+echo "=3D=3D adding secret 3 (last slot) =3D=3D"
+=09$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dactive,${PR}new-secret=
=3Dsec3,${PR}iter-time=3D10
+
+echo
+echo "=3D=3D trying to add another slot (should fail) =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS2 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec3,${PR}iter-time=3D10
+
+echo
+echo "=3D=3D all secrets should work again =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+
+echo
+
+echo "=3D=3D erase all keys of secret 2=3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec2
+
+echo "=3D=3D erase all keys of secret 1=3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec1
+
+echo "=3D=3D erase all keys of secret 0=3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec0
+
+echo "=3D=3D erasing secret3 will fail now since it is the only secret (in=
 3 slots) =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec3
+
+echo
+echo "=3D=3D only secret3 should work now  =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+echo
+echo "=3D=3D add secret0  =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS3 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec0,${PR}iter-time=3D10
+
+echo "=3D=3D erase secret3 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec3
+
+echo
+echo "=3D=3D only secret0 should work now  =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+echo
+echo "=3D=3D replace secret0 with secret1 (should fail)  =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec1,${PR}keyslot=3D0
+
+echo
+echo "=3D=3D replace secret0 with secret1 with force (should work)  =3D=3D=
"
+$QEMU_IMG amend $SECRETS $IMGS0 -o ${PR}state=3Dactive,${PR}new-secret=3Ds=
ec1,${PR}iter-time=3D10,${PR}keyslot=3D0 --force
+
+echo
+echo "=3D=3D only secret1 should work now  =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+
+echo
+echo "=3D=3D erase last secret (should fail)  =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}keyslot=3D0
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec1
+
+
+echo "=3D=3D erase non existing secrets (should fail)  =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec5 --force
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}old-secret=
=3Dsec0 --force
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}keyslot=3D1 =
--force
+
+echo
+echo "=3D=3D erase last secret with force by slot (should work)  =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o ${PR}state=3Dinactive,${PR}keyslot=3D0 =
--force
+
+echo
+echo "=3D=3D we have no secrets now, data is lost forever =3D=3D"
+for IMG in "$IMGS0" "$IMGS1" "$IMGS2" "$IMGS3"; do
+=09$QEMU_IO $SECRETS -c "read 0 4096" $IMG | _filter_qemu_io | _filter_tes=
tdir
+done
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
+
diff --git a/tests/qemu-iotests/300.out b/tests/qemu-iotests/300.out
new file mode 100644
index 0000000000..09ca556387
--- /dev/null
+++ b/tests/qemu-iotests/300.out
@@ -0,0 +1,99 @@
+QA output created by 300
+=3D=3D creating a test image =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+
+=3D=3D test that key 0 opens the image =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D adding a password to slot 4 =3D=3D
+=3D=3D adding a password to slot 1 =3D=3D
+=3D=3D adding a password to slot 3 =3D=3D
+=3D=3D adding a password to slot 2 =3D=3D
+=3D=3D erase slot 4 =3D=3D
+
+=3D=3D all secrets should work =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D erase slot 0 and try it =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D erase slot 2 and try it =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D filling  4 slots with secret 2 =3D=3D
+
+=3D=3D adding secret 0 =3D=3D
+
+=3D=3D adding secret 3 (last slot) =3D=3D
+
+=3D=3D trying to add another slot (should fail) =3D=3D
+qemu-img: Can't add a keyslot - all key slots are in use
+
+=3D=3D all secrets should work again =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D erase all keys of secret 2=3D=3D
+=3D=3D erase all keys of secret 1=3D=3D
+=3D=3D erase all keys of secret 0=3D=3D
+=3D=3D erasing secret3 will fail now since it is the only secret (in 3 slo=
ts) =3D=3D
+qemu-img: Requested operation will erase all active keyslots which will er=
ase all the data in the image irreversibly - refusing operation
+
+=3D=3D only secret3 should work now  =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D add secret0  =3D=3D
+=3D=3D erase secret3 =3D=3D
+
+=3D=3D only secret0 should work now  =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D replace secret0 with secret1 (should fail)  =3D=3D
+qemu-img: Refusing to overwrite active slot 0 - please erase it first
+
+=3D=3D replace secret0 with secret1 with force (should work)  =3D=3D
+
+=3D=3D only secret1 should work now  =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D erase last secret (should fail)  =3D=3D
+qemu-img: Requested operation will erase all active keyslots which will er=
ase all the data in the image irreversibly - refusing operation
+qemu-img: Requested operation will erase all active keyslots which will er=
ase all the data in the image irreversibly - refusing operation
+=3D=3D erase non existing secrets (should fail)  =3D=3D
+qemu-img: No secret with id 'sec5'
+qemu-img: Requested operation didn't match any slots
+
+=3D=3D erase last secret with force by slot (should work)  =3D=3D
+
+=3D=3D we have no secrets now, data is lost forever =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+*** done
diff --git a/tests/qemu-iotests/301 b/tests/qemu-iotests/301
new file mode 100755
index 0000000000..9c95ed8c9a
--- /dev/null
+++ b/tests/qemu-iotests/301
@@ -0,0 +1,90 @@
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=3Dmlevitsk@redhat.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
+
+_cleanup()
+{
+=09_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt luks
+_supported_proto file #TODO
+
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+
+# you are supposed to see the password as *******, see :-)
+S0=3D"--object secret,id=3Dsec0,data=3Dhunter0"
+S1=3D"--object secret,id=3Dsec1,data=3Dhunter1"
+SECRETS=3D"$S0 $S1"
+
+
+IMGS0=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,key-secre=
t=3Dsec0"
+IMGS1=3D"--image-opts driver=3D$IMGFMT,file.filename=3D$TEST_IMG,key-secre=
t=3Dsec1"
+
+echo "=3D=3D creating a test image =3D=3D"
+_make_test_img $S0 -o "key-secret=3Dsec0,iter-time=3D10" 32M
+
+echo
+echo "=3D=3D test that key 0 opens the image =3D=3D"
+$QEMU_IO $S0 -c "read 0 4096" $IMGS0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D adding a password to slot 1 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS0 -o state=3Dactive,new-secret=3Dsec1,keyslo=
t=3D1,iter-time=3D10
+
+echo
+echo "=3D=3D 'backup' the image header =3D=3D"
+dd if=3D$TEST_IMG_FILE of=3D${TEST_IMG_FILE}.bk bs=3D4K skip=3D0 count=3D1
+
+echo
+echo "=3D=3D erase slot 0 =3D=3D"
+$QEMU_IMG amend $SECRETS $IMGS1 -o state=3Dinactive,keyslot=3D0 | _filter_=
img_create
+
+echo
+echo "=3D=3D test that key 0 doesn't open the image =3D=3D"
+$QEMU_IO $S0 -c "read 0 4096" $IMGS0 | _filter_qemu_io | _filter_testdir
+
+echo
+echo "=3D=3D 'restore' the image header =3D=3D"
+dd if=3D${TEST_IMG_FILE}.bk of=3D${TEST_IMG_FILE} bs=3D4K skip=3D0 count=
=3D1 conv=3Dnotrunc
+
+echo
+echo "=3D=3D test that key 0 still doesn't open the image (key material is=
 erased) =3D=3D"
+$QEMU_IO $SECRETS -c "read 0 4096" $IMGS0 | _filter_qemu_io | _filter_test=
dir
+
+echo
+echo "=3D=3D test that key 1 still works =3D=3D"
+$QEMU_IO $SECRETS -c "read 0 4096" $IMGS1 | _filter_qemu_io | _filter_test=
dir
+
+echo "*** done"
+rm -f $seq.full
+status=3D0
+
+
+exit 0
diff --git a/tests/qemu-iotests/301.out b/tests/qemu-iotests/301.out
new file mode 100644
index 0000000000..e653c30330
--- /dev/null
+++ b/tests/qemu-iotests/301.out
@@ -0,0 +1,30 @@
+QA output created by 301
+=3D=3D creating a test image =3D=3D
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D33554432
+
+=3D=3D test that key 0 opens the image =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D adding a password to slot 1 =3D=3D
+
+=3D=3D 'backup' the image header =3D=3D
+1+0 records in
+1+0 records out
+
+=3D=3D erase slot 0 =3D=3D
+
+=3D=3D test that key 0 doesn't open the image =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D 'restore' the image header =3D=3D
+1+0 records in
+1+0 records out
+
+=3D=3D test that key 0 still doesn't open the image (key material is erase=
d) =3D=3D
+qemu-io: can't open: Invalid password, cannot unlock any keyslot
+
+=3D=3D test that key 1 still works =3D=3D
+read 4096/4096 bytes at offset 0
+4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0317667695..0941a4f64e 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -293,3 +293,6 @@
 283 auto quick
 284 rw
 286 rw quick
+
+300 rw auto
+301 rw auto quick
--=20
2.17.2


