Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA06C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:13:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B2920772
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 10:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAN6ILyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B2920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsO7P-0000Fk-Fx
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 06:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO0B-00048M-VP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44117
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jsO09-00049Q-3I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 06:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594029928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lpbulm5lS9190h3fLSIzCWsJgBk4fRL7hvkNSDwZQZc=;
 b=VAN6ILyAIJVr6W1cnKXgmQmklNDzuORXN624oHQMBJ58dtQSrqJk6or3kFremi5aqYj2QZ
 UJZ0MTBfzIGxuRJa02SeTqTOJ6dLXsea4I0St5BvgztWPAdGA1QJQAwe6USLg9UKShlVBQ
 oPOREAXaP+rDfsNVvx5Y71ai9E5/uGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-2gXPcPbCMm-DkoxYbc7O4Q-1; Mon, 06 Jul 2020 06:05:25 -0400
X-MC-Unique: 2gXPcPbCMm-DkoxYbc7O4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C299B8014D7;
 Mon,  6 Jul 2020 10:05:24 +0000 (UTC)
Received: from localhost (ovpn-112-176.ams2.redhat.com [10.36.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 146315C3F8;
 Mon,  6 Jul 2020 10:05:23 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 21/31] iotests: add tests for blockdev-amend
Date: Mon,  6 Jul 2020 12:04:22 +0200
Message-Id: <20200706100432.2301919-22-mreitz@redhat.com>
In-Reply-To: <20200706100432.2301919-1-mreitz@redhat.com>
References: <20200706100432.2301919-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:52:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

This commit adds two tests that cover the
new blockdev-amend functionality of luks and qcow2 driver

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[mreitz: Let 295 verify that LUKS works; drop 295 and 296 from the auto
         group]
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200625125548.870061-20-mreitz@redhat.com>
---
 tests/qemu-iotests/295     | 280 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/295.out |  40 ++++++
 tests/qemu-iotests/296     | 234 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/296.out |  33 +++++
 tests/qemu-iotests/group   |   2 +
 5 files changed, 589 insertions(+)
 create mode 100755 tests/qemu-iotests/295
 create mode 100644 tests/qemu-iotests/295.out
 create mode 100755 tests/qemu-iotests/296
 create mode 100644 tests/qemu-iotests/296.out

diff --git a/tests/qemu-iotests/295 b/tests/qemu-iotests/295
new file mode 100755
index 0000000000..59e674fa85
--- /dev/null
+++ b/tests/qemu-iotests/295
@@ -0,0 +1,280 @@
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
+test_img = os.path.join(iotests.test_dir, 'test.img')
+
+class Secret:
+    def __init__(self, index):
+        self._id = "keysec" + str(index)
+        # you are not supposed to see the password...
+        self._secret = "hunter" + str(index)
+
+    def id(self):
+        return self._id
+
+    def secret(self):
+        return self._secret
+
+    def to_cmdline_object(self):
+        return  [ "secret,id=" + self._id + ",data=" + self._secret]
+
+    def to_qmp_object(self):
+        return { "qom_type" : "secret", "id": self.id(),
+                 "props": { "data": self.secret() } }
+
+################################################################################
+class EncryptionSetupTestCase(iotests.QMPTestCase):
+
+    # test case startup
+    def setUp(self):
+        # start the VM
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        # create the secrets and load 'em into the VM
+        self.secrets = [ Secret(i) for i in range(0, 6) ]
+        for secret in self.secrets:
+            result = self.vm.qmp("object-add", **secret.to_qmp_object())
+            self.assert_qmp(result, 'return', {})
+
+        if iotests.imgfmt == "qcow2":
+            self.pfx = "encrypt."
+            self.img_opts = [ '-o', "encrypt.format=luks" ]
+        else:
+            self.pfx = ""
+            self.img_opts = []
+
+    # test case shutdown
+    def tearDown(self):
+        # stop the VM
+        self.vm.shutdown()
+
+    ###########################################################################
+    # create the encrypted block device
+    def createImg(self, file, secret):
+
+        iotests.qemu_img(
+            'create',
+            '--object', *secret.to_cmdline_object(),
+            '-f', iotests.imgfmt,
+            '-o', self.pfx + 'key-secret=' + secret.id(),
+            '-o', self.pfx + 'iter-time=10',
+            *self.img_opts,
+            file,
+            '1M')
+
+    ###########################################################################
+    # open an encrypted block device
+    def openImageQmp(self, id, file, secret, read_only = False):
+
+        encrypt_options = {
+            'key-secret' : secret.id()
+        }
+
+        if iotests.imgfmt == "qcow2":
+            encrypt_options = {
+                'encrypt': {
+                    'format':'luks',
+                    **encrypt_options
+                }
+            }
+
+        result = self.vm.qmp('blockdev-add', **
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
+        result = self.vm.qmp('blockdev-del', **{ 'node-name': id })
+        self.assert_qmp(result, 'return', {})
+
+    ###########################################################################
+    # add a key to an encrypted block device
+    def addKeyQmp(self, id, new_secret, secret = None,
+                  slot = None, force = False):
+
+        crypt_options = {
+            'state'      : 'active',
+            'new-secret' : new_secret.id(),
+            'iter-time' : 10
+        }
+
+        if slot != None:
+            crypt_options['keyslot'] = slot
+
+
+        if secret != None:
+            crypt_options['secret'] = secret.id()
+
+        if iotests.imgfmt == "qcow2":
+            crypt_options['format'] = 'luks'
+            crypt_options = {
+                'encrypt': crypt_options
+            }
+
+        args = {
+            'node-name': id,
+            'job-id' : 'job_add_key',
+            'options' : {
+                    'driver' : iotests.imgfmt,
+                    **crypt_options
+                },
+        }
+
+        if force == True:
+            args['force'] = True
+
+        #TODO: check what jobs return
+        result = self.vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] == {}
+        self.vm.run_job('job_add_key')
+
+    # erase a key from an encrypted block device
+    def eraseKeyQmp(self, id, old_secret = None, slot = None, force = False):
+
+        crypt_options = {
+            'state'      : 'inactive',
+        }
+
+        if slot != None:
+            crypt_options['keyslot'] = slot
+        if old_secret != None:
+            crypt_options['old-secret'] = old_secret.id()
+
+        if iotests.imgfmt == "qcow2":
+            crypt_options['format'] = 'luks'
+            crypt_options = {
+                'encrypt': crypt_options
+            }
+
+        args = {
+            'node-name': id,
+            'job-id' : 'job_erase_key',
+            'options' : {
+                    'driver' : iotests.imgfmt,
+                    **crypt_options
+                },
+        }
+
+        if force == True:
+            args['force'] = True
+
+        result = self.vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] == {}
+        self.vm.run_job('job_erase_key')
+
+    ###########################################################################
+    # create image, and change its key
+    def testChangeKey(self):
+
+        # create the image with secret0 and open it
+        self.createImg(test_img, self.secrets[0]);
+        self.openImageQmp("testdev", test_img, self.secrets[0])
+
+        # add key to slot 1
+        self.addKeyQmp("testdev", new_secret = self.secrets[1])
+
+        # add key to slot 5
+        self.addKeyQmp("testdev", new_secret = self.secrets[2], slot=5)
+
+        # erase key from slot 0
+        self.eraseKeyQmp("testdev", old_secret = self.secrets[0])
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
+        self.addKeyQmp("testdev", new_secret = self.secrets[1])
+
+        # erase key from slot 0
+        self.eraseKeyQmp("testdev", old_secret = self.secrets[0])
+
+        # this will fail as the old password is no longer valid
+        self.addKeyQmp("testdev", new_secret = self.secrets[2])
+
+        # this will work
+        self.addKeyQmp("testdev", new_secret = self.secrets[2], secret = self.secrets[1])
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
+        self.addKeyQmp("testdev", new_secret = self.secrets[1], slot=4)
+        self.addKeyQmp("testdev", new_secret = self.secrets[4], slot=2)
+
+        # overwrite an active secret
+        self.addKeyQmp("testdev", new_secret = self.secrets[5], slot=2)
+        self.addKeyQmp("testdev", new_secret = self.secrets[5], slot=2, force=True)
+
+        self.addKeyQmp("testdev", new_secret = self.secrets[0])
+
+        # Now erase all the secrets
+        self.eraseKeyQmp("testdev", old_secret = self.secrets[5])
+        self.eraseKeyQmp("testdev", slot=4)
+
+        # erase last keyslot
+        self.eraseKeyQmp("testdev", old_secret = self.secrets[0])
+        self.eraseKeyQmp("testdev", old_secret = self.secrets[0], force=True)
+
+        self.closeImageQmp("testdev")
+        os.remove(test_img)
+
+
+if __name__ == '__main__':
+    iotests.verify_working_luks()
+    # Encrypted formats support
+    iotests.activate_logging()
+    iotests.main(supported_fmts = ['qcow2', 'luks'])
diff --git a/tests/qemu-iotests/295.out b/tests/qemu-iotests/295.out
new file mode 100644
index 0000000000..ad34b2ca2c
--- /dev/null
+++ b/tests/qemu-iotests/295.out
@@ -0,0 +1,40 @@
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
+Job failed: Refusing to overwrite active keyslot 2 - please erase it first
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
+Job failed: All the active keyslots match the (old) password that was given and erasing them will erase all the data in the image irreversibly - refusing operation
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job_erase_key"}}
+{"return": {}}
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
new file mode 100755
index 0000000000..ec69ec8974
--- /dev/null
+++ b/tests/qemu-iotests/296
@@ -0,0 +1,234 @@
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
+test_img = os.path.join(iotests.test_dir, 'test.img')
+
+class Secret:
+    def __init__(self, index):
+        self._id = "keysec" + str(index)
+        # you are not supposed to see the password...
+        self._secret = "hunter" + str(index)
+
+    def id(self):
+        return self._id
+
+    def secret(self):
+        return self._secret
+
+    def to_cmdline_object(self):
+        return  [ "secret,id=" + self._id + ",data=" + self._secret]
+
+    def to_qmp_object(self):
+        return { "qom_type" : "secret", "id": self.id(),
+                 "props": { "data": self.secret() } }
+
+################################################################################
+
+class EncryptionSetupTestCase(iotests.QMPTestCase):
+
+    # test case startup
+    def setUp(self):
+
+        # start the VMs
+        self.vm1 = iotests.VM(path_suffix = 'VM1')
+        self.vm2 = iotests.VM(path_suffix = 'VM2')
+        self.vm1.launch()
+        self.vm2.launch()
+
+        # create the secrets and load 'em into the VMs
+        self.secrets = [ Secret(i) for i in range(0, 4) ]
+        for secret in self.secrets:
+            result = self.vm1.qmp("object-add", **secret.to_qmp_object())
+            self.assert_qmp(result, 'return', {})
+            result = self.vm2.qmp("object-add", **secret.to_qmp_object())
+            self.assert_qmp(result, 'return', {})
+
+    # test case shutdown
+    def tearDown(self):
+        # stop the VM
+        self.vm1.shutdown()
+        self.vm2.shutdown()
+
+    ###########################################################################
+    # create the encrypted block device using qemu-img
+    def createImg(self, file, secret):
+
+        output = iotests.qemu_img_pipe(
+            'create',
+            '--object', *secret.to_cmdline_object(),
+            '-f', iotests.imgfmt,
+            '-o', 'key-secret=' + secret.id(),
+            '-o', 'iter-time=10',
+            file,
+            '1M')
+
+        iotests.log(output, filters=[iotests.filter_test_dir])
+
+    # attempts to add a key using qemu-img
+    def addKey(self, file, secret, new_secret):
+
+        image_options = {
+            'key-secret' : secret.id(),
+            'driver' : iotests.imgfmt,
+            'file' : {
+                'driver':'file',
+                'filename': file,
+                }
+            }
+
+        output = iotests.qemu_img_pipe(
+            'amend',
+            '--object', *secret.to_cmdline_object(),
+            '--object', *new_secret.to_cmdline_object(),
+
+            '-o', 'state=active',
+            '-o', 'new-secret=' + new_secret.id(),
+            '-o', 'iter-time=10',
+
+            "json:" + json.dumps(image_options)
+            )
+
+        iotests.log(output, filters=[iotests.filter_test_dir])
+
+    ###########################################################################
+    # open an encrypted block device
+    def openImageQmp(self, vm, id, file, secret,
+                     readOnly = False, reOpen = False):
+
+        command = 'x-blockdev-reopen' if reOpen else 'blockdev-add'
+
+        result = vm.qmp(command, **
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
+        result = vm.qmp('blockdev-del', **{ 'node-name': id })
+        self.assert_qmp(result, 'return', {})
+
+    ###########################################################################
+
+    # add a key to an encrypted block device
+    def addKeyQmp(self, vm, id, new_secret):
+
+        args = {
+            'node-name': id,
+            'job-id' : 'job0',
+            'options' : {
+                'state'     : 'active',
+                'driver'    : iotests.imgfmt,
+                'new-secret': new_secret.id(),
+                'iter-time' : 10
+            },
+        }
+
+        result = vm.qmp('x-blockdev-amend', **args)
+        assert result['return'] == {}
+        vm.run_job('job0')
+
+    # test that when the image opened by two qemu processes,
+    # neither of them can update the image
+    def test1(self):
+        self.createImg(test_img, self.secrets[0]);
+
+        # VM1 opens the image and adds a key
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0])
+        self.addKeyQmp(self.vm1, "testdev", new_secret = self.secrets[1])
+
+
+        # VM2 opens the image
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+
+
+        # neither VMs now should be able to add a key
+        self.addKeyQmp(self.vm1, "testdev", new_secret = self.secrets[2])
+        self.addKeyQmp(self.vm2, "testdev", new_secret = self.secrets[2])
+
+
+        # VM 1 closes the image
+        self.closeImageQmp(self.vm1, "testdev")
+
+
+        # now VM2 can add the key
+        self.addKeyQmp(self.vm2, "testdev", new_secret = self.secrets[2])
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
+                          readOnly = True)
+
+        # VM2 opens the image
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+
+        # VM1 can't add a key since image is readonly
+        self.addKeyQmp(self.vm1, "testdev", new_secret = self.secrets[2])
+
+        # VM2 can't add a key since VM is has the image opened
+        self.addKeyQmp(self.vm2, "testdev", new_secret = self.secrets[2])
+
+
+        #VM1 reopens the image read-write
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0],
+                          reOpen = True, readOnly = False)
+
+        # VM1 still can't add the key
+        self.addKeyQmp(self.vm1, "testdev", new_secret = self.secrets[2])
+
+        # VM2 gets away
+        self.closeImageQmp(self.vm2, "testdev")
+
+        # VM1 now can add the key
+        self.addKeyQmp(self.vm1, "testdev", new_secret = self.secrets[2])
+
+        self.closeImageQmp(self.vm1, "testdev")
+        os.remove(test_img)
+
+
+if __name__ == '__main__':
+    # support only raw luks since luks encrypted qcow2 is a proper
+    # format driver which doesn't allow any sharing
+    iotests.activate_logging()
+    iotests.main(supported_fmts = ['luks'])
diff --git a/tests/qemu-iotests/296.out b/tests/qemu-iotests/296.out
new file mode 100644
index 0000000000..afb6d2d09d
--- /dev/null
+++ b/tests/qemu-iotests/296.out
@@ -0,0 +1,33 @@
+Formatting 'TEST_DIR/test.img', fmt=luks size=1048576 key-secret=keysec0 iter-time=10
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
+Formatting 'TEST_DIR/test.img', fmt=luks size=1048576 key-secret=keysec0 iter-time=10
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
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b945dd4f20..9b07a7ed03 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -303,4 +303,6 @@
 292 rw auto quick
 293 rw
 294 rw quick
+295 rw
+296 rw
 297 meta
-- 
2.26.2


