Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694AEC43467
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB33E20872
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 09:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McvgS9O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTLq5-0000re-JW
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 05:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTLpA-0000J3-Jo
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTLp7-0002uS-S4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 05:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602839692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bTusnzipxaGFd5PXbrpJRrhrrCBj5KbGi9OrkcK7d5w=;
 b=McvgS9O99CzFTFbKqoHiGX1XqAvf/QgVAPiLdFmBbLkQNEKXUi2eou3y6oW11WktUHJeRd
 y47KGYewg95czvsE3GQLi2v7NCTE1KT6Tl7rEflxqKe/r39rvp53UyaiguogtzDpqAARge
 bD3LPqEFQYM3dWxzVfIemXglgwaslcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-IM1gcxbPNKWnqsOKJiRUuA-1; Fri, 16 Oct 2020 05:14:49 -0400
X-MC-Unique: IM1gcxbPNKWnqsOKJiRUuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD6B1015EC4;
 Fri, 16 Oct 2020 09:14:48 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34AF60BFA;
 Fri, 16 Oct 2020 09:14:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: move SPHINX_ARGS references within "if build_docs"
Date: Fri, 16 Oct 2020 05:14:47 -0400
Message-Id: <20201016091447.1552469-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qapi-schema/meson.build | 88 +++++++++++++++++------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 1f222a7a13..66c7f04cf8 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -219,53 +219,53 @@ qapi_doc = custom_target('QAPI doc',
                                     '-p', 'doc-good-', '@INPUT0@' ],
                          depend_files: qapi_gen_depends)
 
-# Test the document-comment document generation code by running a test schema
-# file through Sphinx's plain-text builder and comparing the result against
-# a golden reference. This is in theory susceptible to failures if Sphinx
-# changes its output, but the text output has historically been very stable
-# (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
-# texinfo or HTML generation, both of which have had changes. We might
-# need to add more sophisticated logic here in future for some sort of
-# fuzzy comparison if future Sphinx versions produce different text,
-# but for now the simple comparison suffices.
-qapi_doc_out = custom_target('QAPI rST doc',
-                             output: ['doc-good.txt'],
-                             input: files('doc-good.json', 'doc-good.rst'),
-                             build_by_default: build_docs,
-                             depend_files: sphinx_extn_depends,
-                             # We use -E to suppress Sphinx's caching, because
-                             # we want it to always really run the QAPI doc
-                             # generation code. It also means we don't
-                             # clutter up the build dir with the cache.
-                             command: [SPHINX_ARGS,
-                                       '-b', 'text', '-E',
-                                       '-c', meson.source_root() / 'docs',
-                                       '-D', 'master_doc=doc-good',
-                                       meson.current_source_dir(),
-                                       meson.current_build_dir()])
+if build_docs
+  # Test the document-comment document generation code by running a test schema
+  # file through Sphinx's plain-text builder and comparing the result against
+  # a golden reference. This is in theory susceptible to failures if Sphinx
+  # changes its output, but the text output has historically been very stable
+  # (no changes between Sphinx 1.6 and 3.0), so it is a better bet than
+  # texinfo or HTML generation, both of which have had changes. We might
+  # need to add more sophisticated logic here in future for some sort of
+  # fuzzy comparison if future Sphinx versions produce different text,
+  # but for now the simple comparison suffices.
+  qapi_doc_out = custom_target('QAPI rST doc',
+                               output: ['doc-good.txt'],
+                               input: files('doc-good.json', 'doc-good.rst'),
+                               build_by_default: true,
+                               depend_files: sphinx_extn_depends,
+                               # We use -E to suppress Sphinx's caching, because
+                               # we want it to always really run the QAPI doc
+                               # generation code. It also means we don't
+                               # clutter up the build dir with the cache.
+                               command: [SPHINX_ARGS,
+                                         '-b', 'text', '-E',
+                                         '-c', meson.source_root() / 'docs',
+                                         '-D', 'master_doc=doc-good',
+                                         meson.current_source_dir(),
+                                         meson.current_build_dir()])
 
-# Fix possible inconsistency in line endings in generated output and
-# in the golden reference (which could otherwise cause test failures
-# on Windows hosts). Unfortunately diff --strip-trailing-cr
-# is GNU-diff only. The odd-looking perl is because we must avoid
-# using an explicit '\' character in the command arguments to
-# a custom_target(), as Meson will unhelpfully replace it with a '/'
-# (https://github.com/mesonbuild/meson/issues/1564)
-qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
-                                  output: ['doc-good.txt.nocr'],
-                                  input: qapi_doc_out[0],
-                                  build_by_default: build_docs,
-                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
-                                  capture: true)
+  # Fix possible inconsistency in line endings in generated output and
+  # in the golden reference (which could otherwise cause test failures
+  # on Windows hosts). Unfortunately diff --strip-trailing-cr
+  # is GNU-diff only. The odd-looking perl is because we must avoid
+  # using an explicit '\' character in the command arguments to
+  # a custom_target(), as Meson will unhelpfully replace it with a '/'
+  # (https://github.com/mesonbuild/meson/issues/1564)
+  qapi_doc_out_nocr = custom_target('QAPI rST doc newline-sanitized',
+                                    output: ['doc-good.txt.nocr'],
+                                    input: qapi_doc_out[0],
+                                    build_by_default: true,
+                                    command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                    capture: true)
 
-qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
-                                  output: ['doc-good.ref.nocr'],
-                                  input: files('doc-good.txt'),
-                                  build_by_default: build_docs,
-                                  command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
-                                  capture: true)
+  qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
+                                    output: ['doc-good.ref.nocr'],
+                                    input: files('doc-good.txt'),
+                                    build_by_default: true,
+                                    command: ['perl', '-pe', '$x = chr 13; s/$x$//', '@INPUT@'],
+                                    capture: true)
 
-if build_docs
   # "full_path()" needed here to work around
   # https://github.com/mesonbuild/meson/issues/7585
   test('QAPI rST doc', diff, args: ['-u', qapi_doc_ref_nocr[0].full_path(),
-- 
2.26.2


