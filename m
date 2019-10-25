Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 763EF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OI8jZGol"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763EF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO02v-0001xd-6t
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvC-0005Tl-Bn
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvB-00008g-7Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28858
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvB-00008D-48
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N2KMQsM9Snog+L7Vjq/rhFIl2mDQsfkLO7SbFop5bb4=;
 b=OI8jZGol7BPwjWE5v7LaeGdI8PuzsfABubSoycw1APmxH/yx2G3pwyPRG9/SHwC1uY5rUn
 zh22zTa8UaHh+1zI3uxog3OU7B91BAmKg7J5/CxSFykHe0iKTZlhLbELH6piRosJFAnD6H
 hlu3Gxx2RD3c2lV7xxsdCN1uhESyB5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-_cln1YskNme_nSLCfGW6Nw-1; Fri, 25 Oct 2019 09:46:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67B0C107AD31;
 Fri, 25 Oct 2019 13:46:21 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34F7C5D70E;
 Fri, 25 Oct 2019 13:46:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/7] iotests: Skip read-only cases in 118 when run as root
Date: Fri, 25 Oct 2019 15:46:06 +0200
Message-Id: <20191025134611.25920-3-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _cln1YskNme_nSLCfGW6Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Some tests in 118 use chmod to remove write permissions from the file
and assume that the image can indeed not be opened read-write
afterwards. This doesn't work when the test is run as root, because root
can still open the file as writable even when the permission bit isn't
set.

Introduce a @skip_if_root decorator and use it in 118 to skip the tests
in question when the script is run as root.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/118        |  3 +++
 tests/qemu-iotests/iotests.py | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index ea0b326ae0..e20080e9a6 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_i=
mg)
=20
+    @iotests.skip_if_user_is_root
     def test_rw_ro_retain(self):
         os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
@@ -530,6 +531,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_i=
mg)
=20
+    @iotests.skip_if_user_is_root
     def test_make_ro_rw(self):
         os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
@@ -571,6 +573,7 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_i=
mg)
=20
+    @iotests.skip_if_user_is_root
     def test_make_ro_rw_by_retain(self):
         os.chmod(new_img, 0o444)
         self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 693fde155a..709def4d5d 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -931,6 +931,16 @@ def skip_if_unsupported(required_formats=3D[], read_on=
ly=3DFalse):
         return func_wrapper
     return skip_test_decorator
=20
+def skip_if_user_is_root(func):
+    '''Skip Test Decorator
+       Runs the test only without root permissions'''
+    def func_wrapper(*args, **kwargs):
+        if os.getuid() =3D=3D 0:
+            case_notrun('{}: cannot be run as root'.format(args[0]))
+        else:
+            return func(*args, **kwargs)
+    return func_wrapper
+
 def execute_unittest(output, verbosity, debug):
     runner =3D unittest.TextTestRunner(stream=3Doutput, descriptions=3DTru=
e,
                                      verbosity=3Dverbosity)
--=20
2.20.1


