Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45458C31E40
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32A220872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 22:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnKYuVgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32A220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIJiw-0006Va-0d
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 18:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdY-00073y-2W
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIJdV-0002fb-V5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 18:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600209676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrBk6YK6MU8V9BbMDwXymbJJzmJpFy5SUCQcQwKspTA=;
 b=gnKYuVgsHkehmsljpykhlvph7twzCO6MNjHlnidQslTbmIIblWIlDjJlVsGN6Qwb2M/fR2
 uq/KVB2IHtUIE4cuhSs8H2cUeSxMK3Qq1JUsNIpN1g40ucb0xQEZ9EqtheA87Ton5JUgoV
 j9RUxc25DTrn5Ya3zYCyI0KmT8XwOp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-p2VRsBsIMMeuzBJw4FCttQ-1; Tue, 15 Sep 2020 18:41:15 -0400
X-MC-Unique: p2VRsBsIMMeuzBJw4FCttQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F1718B9EDF;
 Tue, 15 Sep 2020 22:40:58 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1EC376E16;
 Tue, 15 Sep 2020 22:40:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 13/37] qapi/common.py: add notational type hints
Date: Tue, 15 Sep 2020 18:40:03 -0400
Message-Id: <20200915224027.2529813-14-jsnow@redhat.com>
In-Reply-To: <20200915224027.2529813-1-jsnow@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 18:40:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/common.py | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 4c079755d3..af01348b35 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,6 +12,7 @@
 # See the COPYING file in the top-level directory.
 
 import re
+from typing import Optional, Union, Sequence
 
 
 EATSPACE = '\033EATSPACE.'
@@ -22,7 +23,7 @@
 # ENUMName -> ENUM_NAME, EnumName1 -> ENUM_NAME1
 # ENUM_NAME -> ENUM_NAME, ENUM_NAME1 -> ENUM_NAME1, ENUM_Name2 -> ENUM_NAME2
 # ENUM24_Name -> ENUM24_NAME
-def camel_to_upper(value):
+def camel_to_upper(value: str) -> str:
     c_fun_str = c_name(value, False)
     if value.isupper():
         return c_fun_str
@@ -41,7 +42,9 @@ def camel_to_upper(value):
     return new_name.lstrip('_').upper()
 
 
-def c_enum_const(type_name, const_name, prefix=None):
+def c_enum_const(type_name: str,
+                 const_name: str,
+                 prefix: Optional[str] = None) -> str:
     if prefix is not None:
         type_name = prefix
     return camel_to_upper(type_name) + '_' + c_name(const_name, False).upper()
@@ -56,7 +59,7 @@ def c_enum_const(type_name, const_name, prefix=None):
 # into substrings of a generated C function name.
 # '__a.b_c' -> '__a_b_c', 'x-foo' -> 'x_foo'
 # protect=True: 'int' -> 'q_int'; protect=False: 'int' -> 'int'
-def c_name(name, protect=True):
+def c_name(name: str, protect: bool = True) -> str:
     # ANSI X3J11/88-090, 3.1.1
     c89_words = set(['auto', 'break', 'case', 'char', 'const', 'continue',
                      'default', 'do', 'double', 'else', 'enum', 'extern',
@@ -134,24 +137,24 @@ def pop(self, amount: int = 4) -> int:
 
 # Generate @code with @kwds interpolated.
 # Obey INDENT level, and strip EATSPACE.
-def cgen(code, **kwds):
+def cgen(code: str, **kwds: Union[str, int]) -> str:
     raw = code % kwds
     if INDENT:
         raw, _ = re.subn(r'^(?!(#|$))', str(INDENT), raw, flags=re.MULTILINE)
     return re.sub(re.escape(EATSPACE) + r' *', '', raw)
 
 
-def mcgen(code, **kwds):
+def mcgen(code: str, **kwds: Union[str, int]) -> str:
     if code[0] == '\n':
         code = code[1:]
     return cgen(code, **kwds)
 
 
-def c_fname(filename):
+def c_fname(filename: str) -> str:
     return re.sub(r'[^A-Za-z0-9_]', '_', filename)
 
 
-def guardstart(name):
+def guardstart(name: str) -> str:
     return mcgen('''
 #ifndef %(name)s
 #define %(name)s
@@ -160,7 +163,7 @@ def guardstart(name):
                  name=c_fname(name).upper())
 
 
-def guardend(name):
+def guardend(name: str) -> str:
     return mcgen('''
 
 #endif /* %(name)s */
@@ -168,7 +171,7 @@ def guardend(name):
                  name=c_fname(name).upper())
 
 
-def gen_if(ifcond):
+def gen_if(ifcond: Sequence[str]) -> str:
     ret = ''
     for ifc in ifcond:
         ret += mcgen('''
@@ -177,7 +180,7 @@ def gen_if(ifcond):
     return ret
 
 
-def gen_endif(ifcond):
+def gen_endif(ifcond: Sequence[str]) -> str:
     ret = ''
     for ifc in reversed(ifcond):
         ret += mcgen('''
@@ -186,7 +189,9 @@ def gen_endif(ifcond):
     return ret
 
 
-def build_params(arg_type, boxed, extra=None):
+def build_params(arg_type,
+                 boxed: bool,
+                 extra: Optional[str] = None) -> str:
     ret = ''
     sep = ''
     if boxed:
-- 
2.26.2


