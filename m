Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836EC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76766206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Da440sEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76766206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxCp-0005uB-HG
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9q-00017e-Ky
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45963
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9p-0000kP-Pl
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YnyBd8ScGKasPY9cTIUbuFql1oAw7KI2fvvcNpn2tYQ=;
 b=Da440sEIkMfq3hM0kDps0IqCZRTHLzp7uhmAZyv6RlYn6W+c92dCE3Z+DedWP4hpWvakv3
 /0yjIdjLtNsy9qddWoCQPYOlYyiebWoeUMexjHukVPe2t+AbMWKLtJaFywB2zQWUgo+OWz
 U64Weyq8Fu6BvV5JXEx4o0O77cXk8c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-aMrE8pBlP92UK-S9yIKLRw-1; Tue, 05 May 2020 08:58:38 -0400
X-MC-Unique: aMrE8pBlP92UK-S9yIKLRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B7191899536;
 Tue,  5 May 2020 12:58:37 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F07C960CD1;
 Tue,  5 May 2020 12:58:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/24] iotests: replace mutable list default args
Date: Tue,  5 May 2020 14:58:06 +0200
Message-Id: <20200505125826.1001451-5-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: John Snow <jsnow@redhat.com>

It's bad hygiene: if we modify this list, it will be modified across all
invocations.

(Remaining bad usages are fixed in a subsequent patch which changes the
function signature anyway.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-5-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 37a32c7461..d8dc60275b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -139,7 +139,7 @@ def qemu_img_log(*args):
     log(result, filters=3D[filter_testfiles])
     return result
=20
-def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_args=
=3D[]):
+def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_args=
=3D()):
     args =3D ['info']
     if imgopts:
         args.append('--image-opts')
@@ -354,7 +354,7 @@ def filter_qmp_imgfmt(qmsg):
         return value
     return filter_qmp(qmsg, _filter)
=20
-def log(msg, filters=3D[], indent=3DNone):
+def log(msg, filters=3D(), indent=3DNone):
     '''Logs either a string message or a JSON serializable message (like Q=
MP).
     If indent is provided, JSON serializable messages are pretty-printed.'=
''
     for flt in filters:
@@ -570,7 +570,7 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result
=20
-    def qmp_log(self, cmd, filters=3D[], indent=3DNone, **kwargs):
+    def qmp_log(self, cmd, filters=3D(), indent=3DNone, **kwargs):
         full_cmd =3D OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_qmp(kwargs))
@@ -974,7 +974,7 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D[], unsupported_fmts=3D[]):
+def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -988,7 +988,7 @@ def verify_image_format(supported_fmts=3D[], unsupporte=
d_fmts=3D[]):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
=20
-def verify_protocol(supported=3D[], unsupported=3D[]):
+def verify_protocol(supported=3D(), unsupported=3D()):
     assert not (supported and unsupported)
=20
     if 'generic' in supported:
@@ -1007,11 +1007,11 @@ def verify_platform(supported=3DNone, unsupported=
=3DNone):
         if not any((sys.platform.startswith(x) for x in supported)):
             notrun('not suitable for this OS: %s' % sys.platform)
=20
-def verify_cache_mode(supported_cache_modes=3D[]):
+def verify_cache_mode(supported_cache_modes=3D()):
     if supported_cache_modes and (cachemode not in supported_cache_modes):
         notrun('not suitable for this cache mode: %s' % cachemode)
=20
-def verify_aio_mode(supported_aio_modes=3D[]):
+def verify_aio_mode(supported_aio_modes=3D()):
     if supported_aio_modes and (aiomode not in supported_aio_modes):
         notrun('not suitable for this aio mode: %s' % aiomode)
=20
@@ -1051,7 +1051,7 @@ def supported_formats(read_only=3DFalse):
=20
     return supported_formats.formats[read_only]
=20
-def skip_if_unsupported(required_formats=3D[], read_only=3DFalse):
+def skip_if_unsupported(required_formats=3D(), read_only=3DFalse):
     '''Skip Test Decorator
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
@@ -1102,11 +1102,11 @@ def execute_unittest(output, verbosity, debug):
             sys.stderr.write(out)
=20
 def execute_test(test_function=3DNone,
-                 supported_fmts=3D[],
+                 supported_fmts=3D(),
                  supported_platforms=3DNone,
-                 supported_cache_modes=3D[], supported_aio_modes=3D{},
-                 unsupported_fmts=3D[], supported_protocols=3D[],
-                 unsupported_protocols=3D[]):
+                 supported_cache_modes=3D(), supported_aio_modes=3D(),
+                 unsupported_fmts=3D(), supported_protocols=3D(),
+                 unsupported_protocols=3D()):
     """Run either unittest or script-style tests."""
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
--=20
2.26.2


