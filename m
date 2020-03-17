Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA477C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9CB20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T41mPmGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9CB20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0L5-00012A-Ut
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41431)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IH-00041w-9G
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IF-0004yV-Tv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0IF-0004xu-Pe
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQBnYkEn5mABwOQVjYOEtia36Kc/+snsuX5m5kADB2o=;
 b=T41mPmGHu3HlexyaXvccPjkL+hF0Mts08K2Mwjyiz0jSiyjOFoCUCXZRkkDqbQKxW6tlKH
 wVSgcA43/vJIT/zRIbTuOYHFJopmga6ZnkalNNCrv/IDRZo77v0GhVSVFZEHvmTU9PhkaW
 EqgUsEF70IkTA+GwjHEW5nwWKecpNxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-z2CnrJbxNsO4r9nOcgPXTw-1; Mon, 16 Mar 2020 20:41:13 -0400
X-MC-Unique: z2CnrJbxNsO4r9nOcgPXTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D355107ACC7;
 Tue, 17 Mar 2020 00:41:12 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23E3F7A411;
 Tue, 17 Mar 2020 00:41:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 04/11] iotests: replace mutable list default args
Date: Mon, 16 Mar 2020 20:40:58 -0400
Message-Id: <20200317004105.27059-5-jsnow@redhat.com>
In-Reply-To: <20200317004105.27059-1-jsnow@redhat.com>
References: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's bad hygiene: if we modify this list, it will be modified across all
invocations.

(Remaining bad usages are fixed in a subsequent patch which changes the
function signature anyway.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/iotests.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index cb9c2cd05d..7cd74e7cb1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -136,7 +136,7 @@ def qemu_img_log(*args):
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
@@ -350,7 +350,7 @@ def _filter(_key, value):
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
@@ -566,7 +566,7 @@ def get_qmp_events_filtered(self, wait=3D60.0):
             result.append(filter_qmp_event(ev))
         return result
=20
-    def qmp_log(self, cmd, filters=3D[], indent=3DNone, **kwargs):
+    def qmp_log(self, cmd, filters=3D(), indent=3DNone, **kwargs):
         full_cmd =3D OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_qmp(kwargs))
@@ -970,7 +970,7 @@ def case_notrun(reason):
     open('%s/%s.casenotrun' % (output_dir, seq), 'a').write(
         '    [case not run] ' + reason + '\n')
=20
-def verify_image_format(supported_fmts=3D[], unsupported_fmts=3D[]):
+def verify_image_format(supported_fmts=3D(), unsupported_fmts=3D()):
     assert not (supported_fmts and unsupported_fmts)
=20
     if 'generic' in supported_fmts and \
@@ -984,7 +984,7 @@ def verify_image_format(supported_fmts=3D[], unsupporte=
d_fmts=3D[]):
     if not_sup or (imgfmt in unsupported_fmts):
         notrun('not suitable for this image format: %s' % imgfmt)
=20
-def verify_protocol(supported=3D[], unsupported=3D[]):
+def verify_protocol(supported=3D(), unsupported=3D()):
     assert not (supported and unsupported)
=20
     if 'generic' in supported:
@@ -1003,11 +1003,11 @@ def verify_platform(supported=3DNone, unsupported=
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
@@ -1047,7 +1047,7 @@ def supported_formats(read_only=3DFalse):
=20
     return supported_formats.formats[read_only]
=20
-def skip_if_unsupported(required_formats=3D[], read_only=3DFalse):
+def skip_if_unsupported(required_formats=3D(), read_only=3DFalse):
     '''Skip Test Decorator
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
@@ -1098,11 +1098,11 @@ def execute_unittest(output, verbosity, debug):
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
2.21.1


