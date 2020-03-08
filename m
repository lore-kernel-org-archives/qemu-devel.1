Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD870C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7980B2072A
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 15:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbHfz1Ca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7980B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAxnF-0000ep-MH
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 11:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxig-000143-NB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jAxid-0001ns-Px
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jAxid-0001nZ-Kc
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 11:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583680795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMqqEFj7MmuWmdpDvkS0xdZXCtUbacPc/u/+pZDE1Dc=;
 b=NbHfz1CaZu4PYPHS8g5/e9fDrB45NcN1CLMpwf5nVTb1vMmDhczd3e8j9xt4BTz0Ak8ixx
 NR29LZdcbGI8VJRNBSije9a24wBmKFhh3E6rCw48ZbFxhSwQjsKuH9ZYdY+oNzv/A2r/eY
 x007uBhr1AQrbKrhY/Suc8Mx0Y9RNsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-7WHuuUXuPxShsTJIOc5LnA-1; Sun, 08 Mar 2020 11:19:53 -0400
X-MC-Unique: 7WHuuUXuPxShsTJIOc5LnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478CA1005512;
 Sun,  8 Mar 2020 15:19:52 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB4C5C1B0;
 Sun,  8 Mar 2020 15:19:47 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/14] iotests: add tests for blockdev-amend
Date: Sun,  8 Mar 2020 17:19:03 +0200
Message-Id: <20200308151903.25941-15-mlevitsk@redhat.com>
In-Reply-To: <20200308151903.25941-1-mlevitsk@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

This commit adds two tests that cover the
new blockdev-amend functionality of luks and qcow2 driver

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/302     | 278 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/302.out |  40 ++++++
 tests/qemu-iotests/303     | 233 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/303.out |  33 +++++
 tests/qemu-iotests/group   |   3 +
 5 files changed, 587 insertions(+)
 create mode 100755 tests/qemu-iotests/302
 create mode 100644 tests/qemu-iotests/302.out
 create mode 100755 tests/qemu-iotests/303
 create mode 100644 tests/qemu-iotests/303.out

diff --git a/tests/qemu-iotests/302 b/tests/qemu-iotests/302
new file mode 100755
index 0000000000..a6b1155c33
--- /dev/null
+++ b/tests/qemu-iotests/302
@@ -0,0 +1,278 @@
+#!/usr/bin/env python3
+#
+# Test case QMP's encrypted key management
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
+import iotests
+import os
+import time
+import json
+
+test_img =3D os.path.join(iotests.test_dir, 'test.img')
+
+class Secret:
+    def __init__(self, index):
+        self._id =3D "keysec" + str(index)
+        # you are not supposed to see the password...
+        self._secret =3D "hunter" + str(index)
+
+    def id(self):
+        return self._id
+
+    def secret(self):
+        return self._secret
+
+    def to_cmdline_object(self):
+        return  [ "secret,id=3D" + self._id + ",data=3D" + self._secret]
+
+    def to_qmp_object(self):
+        return { "qom_type" : "secret", "id": self.id(),
+                 "props": { "data": self.secret() } }
+
+##########################################################################=
######
+class EncryptionSetupTestCase(iotests.QMPTestCase):
+
+    # test case startup
+    def setUp(self):
+        # start the VM
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+        # create the secrets and load 'em into the VM
+        self.secrets =3D [ Secret(i) for i in range(0, 6) ]
+        for secret in self.secrets:
+            result =3D self.vm.qmp("object-add", **secret.to_qmp_object())
+            self.assert_qmp(result, 'return', {})
+
+        if iotests.imgfmt =3D=3D "qcow2":
+            self.pfx =3D "encrypt."
+            self.img_opts =3D [ '-o', "encrypt.format=3Dluks" ]
+        else:
+            self.pfx =3D ""
+            self.img_opts =3D []
+
+    # test case shutdown
+    def tearDown(self):
+        # stop the VM
+        self.vm.shutdown()
+
+    ######################################################################=
#####
+    # create the encrypted block device
+    def createImg(self, file, secret):
+
+        iotests.qemu_img(
+            'create',
+            '--object', *secret.to_cmdline_object(),
+            '-f', iotests.imgfmt,
+            '-o', self.pfx + 'key-secret=3D' + secret.id(),
+            '-o', self.pfx + 'iter-time=3D10',
+            *self.img_opts,
+            file,
+            '1M')
+
+    ######################################################################=
#####
+    # open an encrypted block device
+    def openImageQmp(self, id, file, secret, read_only =3D False):
+
+        encrypt_options =3D {
+            'key-secret' : secret.id()
+        }
+
+        if iotests.imgfmt =3D=3D "qcow2":
+            encrypt_options =3D {
+                'encrypt': {
+                    'format':'luks',
+                    **encrypt_options
+                }
+            }
+
+        result =3D self.vm.qmp('blockdev-add', **
+            {
+                'driver': iotests.imgfmt,
+                'node-name': id,
+                'read-only': read_only,
+
+                **encrypt_options,
+
+                'file': {
+                    'driver': 'file',
+                    'filename': test_img,
+                }
+            }
+        )
+        self.assert_qmp(result, 'return', {})
+
+    # close the encrypted block device
+    def closeImageQmp(self, id):
+        result =3D self.vm.qmp('blockdev-del', **{ 'node-name': id })
+        self.assert_qmp(result, 'return', {})
+
+    ######################################################################=
#####
+    # add a key to an encrypted block device
+    def addKeyQmp(self, id, secret, unlock_secret =3D None,
+                  slot =3D None, force =3D False):
+
+        crypt_options =3D {
+            'state'      : 'active',
+            'new-secret' : secret.id(),
+            'iter-time' : 10
+        }
+
+        if slot !=3D None:
+            crypt_options['keyslot'] =3D slot
+
+
+        if unlock_secret !=3D None:
+            crypt_options['unlock-secret'] =3D unlock_secret.id()
+
+        if iotests.imgfmt =3D=3D "qcow2":
+            crypt_options['format'] =3D 'luks'
+            crypt_options =3D {
+                'encrypt': crypt_options
+            }
+
+        args =3D {
+            'node-name': id,
+            'job-id' : 'job_add_key',
+            'options' : {
+                    'driver' : iotests.imgfmt,
+                    **crypt_options
+                },
+        }
+
+        if force =3D=3D True:
+            args['force'] =3D True
+
+        #TODO: check what jobs return
+        result =3D self.vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] =3D=3D {}
+        self.vm.run_job('job_add_key')
+
+    # erase a key from an encrypted block device
+    def eraseKeyQmp(self, id, secret =3D None, slot =3D None, force =3D Fa=
lse):
+
+        crypt_options =3D {
+            'state'      : 'inactive',
+        }
+
+        if slot !=3D None:
+            crypt_options['keyslot'] =3D slot
+        if secret !=3D None:
+            crypt_options['old-secret'] =3D secret.id()
+
+        if iotests.imgfmt =3D=3D "qcow2":
+            crypt_options['format'] =3D 'luks'
+            crypt_options =3D {
+                'encrypt': crypt_options
+            }
+
+        args =3D {
+            'node-name': id,
+            'job-id' : 'job_erase_key',
+            'options' : {
+                    'driver' : iotests.imgfmt,
+                    **crypt_options
+                },
+        }
+
+        if force =3D=3D True:
+            args['force'] =3D True
+
+        result =3D self.vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] =3D=3D {}
+        self.vm.run_job('job_erase_key')
+
+    ######################################################################=
#####
+    # create image, and change its key
+    def testChangeKey(self):
+
+        # create the image with secret0 and open it
+        self.createImg(test_img, self.secrets[0]);
+        self.openImageQmp("testdev", test_img, self.secrets[0])
+
+        # add key to slot 1
+        self.addKeyQmp("testdev", secret =3D self.secrets[1])
+
+        # add key to slot 5
+        self.addKeyQmp("testdev", secret =3D self.secrets[2], slot=3D5)
+
+        # erase key from slot 0
+        self.eraseKeyQmp("testdev", secret =3D self.secrets[0])
+
+        #reopen the image with secret1
+        self.closeImageQmp("testdev")
+        self.openImageQmp("testdev", test_img, self.secrets[1])
+
+        # close and erase the image for good
+        self.closeImageQmp("testdev")
+        os.remove(test_img)
+
+    # test that if we erase the old password,
+    # we can still change the encryption keys using 'old-secret'
+    def testOldPassword(self):
+
+        # create the image with secret0 and open it
+        self.createImg(test_img, self.secrets[0]);
+        self.openImageQmp("testdev", test_img, self.secrets[0])
+
+        # add key to slot 1
+        self.addKeyQmp("testdev", secret =3D self.secrets[1])
+
+        # erase key from slot 0
+        self.eraseKeyQmp("testdev", secret =3D self.secrets[0])
+
+        # this will fail as the old password is no longer valid
+        self.addKeyQmp("testdev", secret =3D self.secrets[2])
+
+        # this will work
+        self.addKeyQmp("testdev", secret =3D self.secrets[2], unlock_secre=
t =3D self.secrets[1])
+
+        # close and erase the image for good
+        self.closeImageQmp("testdev")
+        os.remove(test_img)
+
+    def testUseForceLuke(self):
+
+        self.createImg(test_img, self.secrets[0]);
+        self.openImageQmp("testdev", test_img, self.secrets[0])
+
+        # Add bunch of secrets
+        self.addKeyQmp("testdev", secret =3D self.secrets[1], slot=3D4)
+        self.addKeyQmp("testdev", secret =3D self.secrets[4], slot=3D2)
+
+        # overwrite an active secret
+        self.addKeyQmp("testdev", secret =3D self.secrets[5], slot=3D2)
+        self.addKeyQmp("testdev", secret =3D self.secrets[5], slot=3D2, fo=
rce=3DTrue)
+
+        self.addKeyQmp("testdev", secret =3D self.secrets[0])
+
+        # Now erase all the secrets
+        self.eraseKeyQmp("testdev", secret =3D self.secrets[5])
+        self.eraseKeyQmp("testdev", slot=3D4)
+
+        # erase last keyslot
+        self.eraseKeyQmp("testdev", secret =3D self.secrets[0])
+        self.eraseKeyQmp("testdev", secret =3D self.secrets[0], force=3DTr=
ue)
+
+        self.closeImageQmp("testdev")
+        os.remove(test_img)
+
+
+if __name__ =3D=3D '__main__':
+    # Encrypted formats support
+    iotests.main(supported_fmts =3D ['qcow2', 'luks'])
diff --git a/tests/qemu-iotests/302.out b/tests/qemu-iotests/302.out
new file mode 100644
index 0000000000..da4d43d31e
--- /dev/null
+++ b/tests/qemu-iotests/302.out
@@ -0,0 +1,40 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+Job failed: Invalid password, cannot unlock any keyslot
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+Job failed: Refusing to overwrite active slot 2 - please erase it first
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_add_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+Job failed: Requested operation will erase all active keyslots which will =
erase all the data in the image irreversibly - refusing operation
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/303 b/tests/qemu-iotests/303
new file mode 100755
index 0000000000..58f6ba3ef7
--- /dev/null
+++ b/tests/qemu-iotests/303
@@ -0,0 +1,233 @@
+#!/usr/bin/env python3
+#
+# Test case for encryption key management versus image sharing
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
+import iotests
+import os
+import time
+import json
+
+test_img =3D os.path.join(iotests.test_dir, 'test.img')
+
+class Secret:
+    def __init__(self, index):
+        self._id =3D "keysec" + str(index)
+        # you are not supposed to see the password...
+        self._secret =3D "hunter" + str(index)
+
+    def id(self):
+        return self._id
+
+    def secret(self):
+        return self._secret
+
+    def to_cmdline_object(self):
+        return  [ "secret,id=3D" + self._id + ",data=3D" + self._secret]
+
+    def to_qmp_object(self):
+        return { "qom_type" : "secret", "id": self.id(),
+                 "props": { "data": self.secret() } }
+
+##########################################################################=
######
+
+class EncryptionSetupTestCase(iotests.QMPTestCase):
+
+    # test case startup
+    def setUp(self):
+
+        # start the VMs
+        self.vm1 =3D iotests.VM(path_suffix =3D 'VM1')
+        self.vm2 =3D iotests.VM(path_suffix =3D 'VM2')
+        self.vm1.launch()
+        self.vm2.launch()
+
+        # create the secrets and load 'em into the VMs
+        self.secrets =3D [ Secret(i) for i in range(0, 4) ]
+        for secret in self.secrets:
+            result =3D self.vm1.qmp("object-add", **secret.to_qmp_object()=
)
+            self.assert_qmp(result, 'return', {})
+            result =3D self.vm2.qmp("object-add", **secret.to_qmp_object()=
)
+            self.assert_qmp(result, 'return', {})
+
+    # test case shutdown
+    def tearDown(self):
+        # stop the VM
+        self.vm1.shutdown()
+        self.vm2.shutdown()
+
+    ######################################################################=
#####
+    # create the encrypted block device using qemu-img
+    def createImg(self, file, secret):
+
+        output =3D iotests.qemu_img_pipe(
+            'create',
+            '--object', *secret.to_cmdline_object(),
+            '-f', iotests.imgfmt,
+            '-o', 'key-secret=3D' + secret.id(),
+            '-o', 'iter-time=3D10',
+            file,
+            '1M')
+
+        iotests.log(output, filters=3D[iotests.filter_test_dir])
+
+    # attempts to add a key using qemu-img
+    def addKey(self, file, secret_open, secret_add):
+
+        image_options =3D {
+            'key-secret' : secret_open.id(),
+            'driver' : iotests.imgfmt,
+            'file' : {
+                'driver':'file',
+                'filename': file,
+                }
+            }
+
+        output =3D iotests.qemu_img_pipe(
+            'amend',
+            '--object', *secret_open.to_cmdline_object(),
+            '--object', *secret_add.to_cmdline_object(),
+
+            '-o', 'state=3Dactive',
+            '-o', 'new-secret=3D' + secret_add.id(),
+            '-o', 'iter-time=3D10',
+
+            "json:" + json.dumps(image_options)
+            )
+
+        iotests.log(output, filters=3D[iotests.filter_test_dir])
+
+    ######################################################################=
#####
+    # open an encrypted block device
+    def openImageQmp(self, vm, id, file, secret,
+                     readOnly =3D False, reOpen =3D False):
+
+        command =3D 'x-blockdev-reopen' if reOpen else 'blockdev-add'
+
+        result =3D vm.qmp(command, **
+            {
+                'driver': iotests.imgfmt,
+                'node-name': id,
+                'read-only': readOnly,
+                'key-secret' : secret.id(),
+                'file': {
+                    'driver': 'file',
+                    'filename': test_img,
+                }
+            }
+        )
+        self.assert_qmp(result, 'return', {})
+
+    # close the encrypted block device
+    def closeImageQmp(self, vm, id):
+        result =3D vm.qmp('blockdev-del', **{ 'node-name': id })
+        self.assert_qmp(result, 'return', {})
+
+    ######################################################################=
#####
+
+    # add a key to an encrypted block device
+    def addKeyQmp(self, vm, id, secret):
+
+        args =3D {
+            'node-name': id,
+            'job-id' : 'job0',
+            'options' : {
+                'state'     : 'active',
+                'driver'    : iotests.imgfmt,
+                'new-secret': secret.id(),
+                'iter-time' : 10
+            },
+        }
+
+        result =3D vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] =3D=3D {}
+        vm.run_job('job0')
+
+    # test that when the image opened by two qemu processes,
+    # neither of them can update the image
+    def test1(self):
+        self.createImg(test_img, self.secrets[0]);
+
+        # VM1 opens the image and adds a key
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0])
+        self.addKeyQmp(self.vm1, "testdev", secret =3D self.secrets[1])
+
+
+        # VM2 opens the image
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+
+
+        # neither VMs now should be able to add a key
+        self.addKeyQmp(self.vm1, "testdev", secret =3D self.secrets[2])
+        self.addKeyQmp(self.vm2, "testdev", secret =3D self.secrets[2])
+
+
+        # VM 1 closes the image
+        self.closeImageQmp(self.vm1, "testdev")
+
+
+        # now VM2 can add the key
+        self.addKeyQmp(self.vm2, "testdev", secret =3D self.secrets[2])
+
+
+        # qemu-img should also not be able to add a key
+        self.addKey(test_img, self.secrets[0], self.secrets[2])
+
+        # cleanup
+        self.closeImageQmp(self.vm2, "testdev")
+        os.remove(test_img)
+
+
+    def test2(self):
+        self.createImg(test_img, self.secrets[0]);
+
+        # VM1 opens the image readonly
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0],
+                          readOnly =3D True)
+
+        # VM2 opens the image
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+
+        # VM1 can't add a key since image is readonly
+        self.addKeyQmp(self.vm1, "testdev", secret =3D self.secrets[2])
+
+        # VM2 can't add a key since VM is has the image opened
+        self.addKeyQmp(self.vm2, "testdev", secret =3D self.secrets[2])
+
+
+        #VM1 reopens the image read-write
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0],
+                          reOpen =3D True, readOnly =3D False)
+
+        # VM1 still can't add the key
+        self.addKeyQmp(self.vm1, "testdev", secret =3D self.secrets[2])
+
+        # VM2 gets away
+        self.closeImageQmp(self.vm2, "testdev")
+
+        # VM1 now can add the key
+        self.addKeyQmp(self.vm1, "testdev", secret =3D self.secrets[2])
+
+        self.closeImageQmp(self.vm1, "testdev")
+        os.remove(test_img)
+
+
+if __name__ =3D=3D '__main__':
+    # support only raw luks since luks encrypted qcow2 is a proper
+    # format driver which doesn't allow any sharing
+    iotests.main(supported_fmts =3D ['luks'])
diff --git a/tests/qemu-iotests/303.out b/tests/qemu-iotests/303.out
new file mode 100644
index 0000000000..a62bb20b67
--- /dev/null
+++ b/tests/qemu-iotests/303.out
@@ -0,0 +1,33 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
+Formatting 'TEST_DIR/test.img', fmt=3Dluks size=3D1048576 key-secret=3Dkey=
sec0 iter-time=3D10
+
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+Job failed: Failed to get shared "consistent read" lock
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+Job failed: Failed to get shared "consistent read" lock
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+qemu-img: Failed to get shared "consistent read" lock
+Is another process using the image [TEST_DIR/test.img]?
+
+Formatting 'TEST_DIR/test.img', fmt=3Dluks size=3D1048576 key-secret=3Dkey=
sec0 iter-time=3D10
+
+Job failed: Block node is read-only
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+Job failed: Failed to get shared "consistent read" lock
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+Job failed: Failed to get shared "consistent read" lock
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 0941a4f64e..a44f5aff0d 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -296,3 +296,6 @@
=20
 300 rw auto
 301 rw auto quick
+302 rw auto
+303 rw auto
+
--=20
2.17.2


