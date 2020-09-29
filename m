Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,WEIRD_QUOTING autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DF7C5516A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1412D208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 20:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWh3RkFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1412D208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNMQl-0003g4-1Z
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 16:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6K-0001ww-1f
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNM6E-0003Wh-MY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 16:19:51 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601410786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBJPg+vCH4UXWdVqF/vNvoeuSOJbiwX5WR6hADxNMtU=;
 b=DWh3RkFSE7NXF5ire/5HZnD4/tDaAiFsgaN5z4rzuanKBl2pbf1JLjYWBAHcRkRvEB8JUZ
 eVqYZwOWc/DrNSClS5OpE8SBBLBAhcoV/yZ+4zaZfFAk3znt1T0xlzGSrtQoK4RTBUNG3s
 O+WO4H5TDfItYjc92kxrFITrCDqAjhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-5tElGGFIOw-VxhxC2kXN8g-1; Tue, 29 Sep 2020 16:19:34 -0400
X-MC-Unique: 5tElGGFIOw-VxhxC2kXN8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9C8610BBED8;
 Tue, 29 Sep 2020 20:19:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 962AF6198E;
 Tue, 29 Sep 2020 20:19:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E39E911358D5; Tue, 29 Sep 2020 22:19:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] tests/qapi-schema: Add test of the rST QAPI doc-comment
 output
Date: Tue, 29 Sep 2020 22:19:20 +0200
Message-Id: <20200929201926.2155622-24-armbru@redhat.com>
In-Reply-To: <20200929201926.2155622-1-armbru@redhat.com>
References: <20200929201926.2155622-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Add a test of the rST output from the QAPI doc-comment generator,
similar to what we currently have that tests the Texinfo output.

This is a bit more awkward with Sphinx, because the generated output
is not 100% under our control the way the QAPI-to-Texinfo generator
was. We can't observe the data we generate, only the Sphinx
output. Two issues.

One, the output can vary with the Sphinx version. In practice Sphinx's
plaintext output generation has been identical between at least Sphinx
1.6 and 3.0, so we use that. (The HTML output has had changes across
versions). We use an exact-match comparison check, with the
understanding that perhaps changes in a future Sphinx version might
require us to implement something more clever to cope with variation
in the output.

Two, the test can only protect us from changes in the data we generate
that are visible in plain text.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200925162316.21205-16-peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message improved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.rst |   5 +
 tests/qapi-schema/doc-good.txt | 288 +++++++++++++++++++++++++++++++++
 tests/qapi-schema/meson.build  |  55 +++++++
 3 files changed, 348 insertions(+)
 create mode 100644 tests/qapi-schema/doc-good.rst
 create mode 100644 tests/qapi-schema/doc-good.txt

diff --git a/tests/qapi-schema/doc-good.rst b/tests/qapi-schema/doc-good.rst
new file mode 100644
index 0000000000..1e4c23305a
--- /dev/null
+++ b/tests/qapi-schema/doc-good.rst
@@ -0,0 +1,5 @@
+..
+   Test Sphinx manual that pulls in the test schema file. We will generate
+   a plain-text output file and compare it against a reference.
+
+.. qapi-doc:: tests/qapi-schema/doc-good.json
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
new file mode 100644
index 0000000000..6ca03d49d0
--- /dev/null
+++ b/tests/qapi-schema/doc-good.txt
@@ -0,0 +1,288 @@
+Section
+*******
+
+
+Subsection
+==========
+
+*with emphasis* "var" {in braces}
+
+* List item one
+
+* Two, multiple lines
+
+* Three Still in list
+
+Not in list
+
+* Second list Note: still in list
+
+Note: not in list
+
+1. Third list is numbered
+
+2. another item
+
+Returns: the King Since: the first age Notes:
+
+1. Lorem ipsum dolor sit amet
+
+2. Ut enim ad minim veniam
+
+Duis aute irure dolor
+
+Example:
+
+-> in <- out Examples: - *verbatim* - {braces}
+
+
+"Enum" (Enum)
+-------------
+
+
+Values
+~~~~~~
+
+"one" (**If: **"defined(IFONE)")
+   The _one_ {and only}
+
+"two"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"enum-feat"
+   Also _one_ {and only}
+
+"two" is undocumented
+
+
+If
+~~
+
+"defined(IFCOND)"
+
+
+"Base" (Object)
+---------------
+
+
+Members
+~~~~~~~
+
+"base1": "Enum"
+   the first member
+
+
+"Variant1" (Object)
+-------------------
+
+A paragraph
+
+Another paragraph (but no "var": line)
+
+
+Members
+~~~~~~~
+
+"var1": "string" (**If: **"defined(IFSTR)")
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"variant1-feat"
+   a feature
+
+"member-feat"
+   a member feature
+
+
+"Variant2" (Object)
+-------------------
+
+
+"Object" (Object)
+-----------------
+
+
+Members
+~~~~~~~
+
+The members of "Base"
+The members of "Variant1" when "base1" is ""one""
+The members of "Variant2" when "base1" is ""two"" (**If: **"IFTWO")
+
+Features
+~~~~~~~~
+
+"union-feat1"
+   a feature
+
+
+"SugaredUnion" (Object)
+-----------------------
+
+
+Members
+~~~~~~~
+
+"type"
+   One of "one", "two"
+
+"data": "Variant1" when "type" is ""one""
+"data": "Variant2" when "type" is ""two"" (**If: **"IFTWO")
+
+Features
+~~~~~~~~
+
+"union-feat2"
+   a feature
+
+
+"Alternate" (Alternate)
+-----------------------
+
+
+Members
+~~~~~~~
+
+"i": "int"
+   an integer "b" is undocumented
+
+"b": "boolean"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"alt-feat"
+   a feature
+
+
+Another subsection
+==================
+
+
+"cmd" (Command)
+---------------
+
+
+Arguments
+~~~~~~~~~
+
+"arg1": "int"
+   the first argument
+
+"arg2": "string" (optional)
+   the second argument
+
+"arg3": "boolean"
+   Not documented
+
+
+Features
+~~~~~~~~
+
+"cmd-feat1"
+   a feature
+
+"cmd-feat2"
+   another feature
+
+
+Note
+~~~~
+
+"arg3" is undocumented
+
+
+Returns
+~~~~~~~
+
+"Object"
+
+
+TODO
+~~~~
+
+frobnicate
+
+
+Notes
+~~~~~
+
+* Lorem ipsum dolor sit amet
+
+* Ut enim ad minim veniam
+
+Duis aute irure dolor
+
+
+Example
+~~~~~~~
+
+   -> in
+   <- out
+
+
+Examples
+~~~~~~~~
+
+   - *verbatim*
+   - {braces}
+
+
+Since
+~~~~~
+
+2.10
+
+
+"cmd-boxed" (Command)
+---------------------
+
+If you're bored enough to read this, go see a video of boxed cats
+
+
+Arguments
+~~~~~~~~~
+
+The members of "Object"
+
+Features
+~~~~~~~~
+
+"cmd-feat1"
+   a feature
+
+"cmd-feat2"
+   another feature
+
+
+Example
+~~~~~~~
+
+   -> in
+
+   <- out
+
+
+"EVT-BOXED" (Event)
+-------------------
+
+
+Arguments
+~~~~~~~~~
+
+The members of "Object"
+
+Features
+~~~~~~~~
+
+"feat3"
+   a feature
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 83a0a68389..0c4a6a2936 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -224,3 +224,58 @@ qapi_doc = custom_target('QAPI doc',
 test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
+
+# Test the document-comment document generation code by running a test schema
+# file through Sphinx's plain-text builder and comparing the result against
+# a golden reference. This is in theory susceptible to failures if Sphinx
+# changes its output, but the text output has historically been very stable
+# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
+# texinfo or HTML generation, both of which have had changes. We might
+# need to add more sophisticated logic here in future for some sort of
+# fuzzy comparison if future Sphinx versions produce different text,
+# but for now the simple comparison suffices.
+qapi_doc_out = custom_target('QAPI rST doc',
+                             output: ['doc-good.txt'],
+                             input: files('doc-good.json', 'doc-good.rst'),
+                             build_by_default: build_docs,
+                             depend_files: sphinx_extn_depends,
+                             # We use -E to suppress Sphinx's caching, because
+                             # we want it to always really run the QAPI doc
+                             # generation code. It also means we don't
+                             # clutter up the build dir with the cache.
+                             command: [SPHINX_ARGS,
+                                       '-b', 'text', '-E',
+                                       '-c', meson.source_root() / 'docs',
+                                       '-D', 'master_doc=doc-good',
+                                       meson.current_source_dir(),
+                                       meson.current_build_dir()])
+
+# Fix possible inconsistency in line endings in generated output and
+# in the golden reference (which could otherwise cause test failures
+# on Windows hosts). Unfortunately diff --strip-trailing-cr
+# is GNU-diff only. The odd-looking perl is because we must avoid
+# using an explicit '\' character in the command arguments to
+# a custom_target(), as Meson will unhelpfully replace it with a '/'
+# (https://github.com/mesonbuild/meson/issues/1564)
+qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
+                                  output: ['doc-good.txt.nocr'],
+                                  input: qapi_doc_out[0],
+                                  build_by_default: build_docs,
+                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  capture: true)
+
+qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
+                                  output: ['doc-good.ref.nocr'],
+                                  input: files('doc-good.txt'),
+                                  build_by_default: build_docs,
+                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                  capture: true)
+
+if build_docs
+  # "full_path()" needed here to work around
+  # https://github.com/mesonbuild/meson/issues/7585
+  test('QAPI rST doc', diff, args: ['-u', qapi_doc_ref_nocr[0].full_path(),
+                                    qapi_doc_out_nocr[0].full_path()],
+       depends: [qapi_doc_ref_nocr, qapi_doc_out_nocr],
+       suite: ['qapi-schema', 'qapi-doc'])
+endif
-- 
2.26.2


