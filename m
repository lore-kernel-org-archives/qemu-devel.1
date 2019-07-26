Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D492C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:20:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8B8216B7
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zrudgZOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8B8216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41079 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr21L-0002eJ-SN
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37594)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20m-0000mk-Bl
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr20k-0006zn-VI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:20:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr20k-0006xI-NC
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:19:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id p17so54814585wrf.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 08:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8Ez3hO5NBzLE8OGsz9miDbwv9XPAsoT5BmbFIkSdYCU=;
 b=zrudgZOKePIXYhIIBGLfOABPT0SHQZuKHPmPn3TT57RLA9CTpKg/lgSz1wOSVKOR7/
 QR8fgQOEohByVgb+pBGH63sDDQjgTRpMs5oibYWb5Jn5tlhEFMe93oPTmCF1TOKCMIL3
 Mu8/MSzVDUpCpjgVdTfkZJKw+CWUcoVqHSZnbNWBmjrIr6LXB2WasG2houjGL5xQVGPK
 JEI2dCRWp2sNSMLY4LHMizj+j5DkqjAjr8VLdW3kWDNET8eY/hOLL53V3BOZFr05cCGL
 kqjc66zoy+5N0Mm83RaDP0aWQzbnu2XHg1i3maH1eXT2GhQYKvaO10DVFDAZwSvi+m0t
 bkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Ez3hO5NBzLE8OGsz9miDbwv9XPAsoT5BmbFIkSdYCU=;
 b=cP4KuxIs9204uqLIIXJb/VqRRv9VGsjkb9cJ4Ik46BrkJkPhhFEZqN8+ZzjNI4F1Ho
 641gBPkRfdIjQQl8e090vxv1YGotsAxxsJcP27x/SiSHkL8E/L8VawPmhRo/P4hsNwEH
 QSqxKhBMIsd8miT/wPfr2toCrZk/eDEtsWVWEEf3AXUcsMMpFDy+jOr/wezXy5b+x/TQ
 2JL6vQTGx0p3ufwIlJ6HIUheJk6H+8t4I5oi6FeI30kHzescQRWVx823xQ8n2k5hq3JR
 roLEnhQ6e9vVl3/e5S/wYwPeyVMFILXvbYUyVQ3kVX5LYTTCd7T7UTAu/BpYFJ3/oCob
 heXA==
X-Gm-Message-State: APjAAAWjg3dZRD62i8ImsoYbYynNo3u9/Bp33S9EGXza0oxVt0xtyT59
 dS09Ti7guZVqxICkcDUAMe5RWZW506XqKQ==
X-Google-Smtp-Source: APXvYqzh9I3cGAPuZZ7M/P/nZ/XUII8DQaE4eNFJ19uV6aYXJsJbeEyi16DrwMWkKHuHieqSUtfe/g==
X-Received: by 2002:adf:c70e:: with SMTP id
 k14mr105934337wrg.201.1564154397480; 
 Fri, 26 Jul 2019 08:19:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v16sm32746844wrn.28.2019.07.26.08.19.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 08:19:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 16:19:50 +0100
Message-Id: <20190726151952.1932-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726151952.1932-1-peter.maydell@linaro.org>
References: <20190726151952.1932-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PULL 3/5] vmstate.h: Type check VMSTATE_STRUCT_VARRAY
 macros
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The VMSTATE_STRUCT_VARRAY_UINT32 macro is intended to handle
migrating a field which is an array of structs, but where instead of
migrating the entire array we only migrate a variable number of
elements of it.

The VMSTATE_STRUCT_VARRAY_POINTER_UINT32 macro is intended to handle
migrating a field which is of pointer type, and points to a
dynamically allocated array of structs of variable size.

We weren't actually checking that the field passed to
VMSTATE_STRUCT_VARRAY_UINT32 really is an array, with the result that
accidentally using it where the _POINTER_ macro was intended would
compile but silently corrupt memory on migration.

Add type-checking that enforces that the field passed in is
really of the right array type. This applies to all the VMSTATE
macros which use flags including VMS_VARRAY_* but not VMS_POINTER.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
Tested-by: Damien Hedde <damien.hedde@greensocs.com>
Message-id: 20190725163710.11703-3-peter.maydell@linaro.org
---
 include/migration/vmstate.h | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index ca68584eba4..c2bfa7a7f0c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -227,8 +227,22 @@ extern const VMStateInfo vmstate_info_bitmap;
 extern const VMStateInfo vmstate_info_qtailq;
 
 #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
+/*
+ * Check that type t2 is an array of type t1 of size n,
+ * e.g. if t1 is 'foo' and n is 32 then t2 must be 'foo[32]'
+ */
 #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
 #define type_check_pointer(t1,t2) ((t1**)0 - (t2*)0)
+/*
+ * type of element 0 of the specified (array) field of the type.
+ * Note that if the field is a pointer then this will return the
+ * pointed-to type rather than complaining.
+ */
+#define typeof_elt_of_field(type, field) typeof(((type *)0)->field[0])
+/* Check that field f in struct type t2 is an array of t1, of any size */
+#define type_check_varray(t1, t2, f)                                 \
+    (type_check(t1, typeof_elt_of_field(t2, f))                      \
+     + QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(((t2 *)0)->f)))
 
 #define vmstate_offset_value(_state, _field, _type)                  \
     (offsetof(_state, _field) +                                      \
@@ -253,6 +267,10 @@ extern const VMStateInfo vmstate_info_qtailq;
     vmstate_offset_array(_state, _field, uint8_t,                    \
                          sizeof(typeof_field(_state, _field)))
 
+#define vmstate_offset_varray(_state, _field, _type)                 \
+    (offsetof(_state, _field) +                                      \
+     type_check_varray(_type, _state, _field))
+
 /* In the macros below, if there is a _version, that means the macro's
  * field will be processed only if the version being received is >=
  * the _version specified.  In general, if you add a new field, you
@@ -347,7 +365,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT32|VMS_MULTIPLY_ELEMENTS,           \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 #define VMSTATE_ARRAY_TEST(_field, _state, _num, _test, _info, _type) {\
@@ -376,7 +394,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_INT32,                                  \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 #define VMSTATE_VARRAY_INT32(_field, _state, _field_num, _version, _info, _type) {\
@@ -416,7 +434,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .info       = &(_info),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_VARRAY_UINT16,                                 \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 #define VMSTATE_VSTRUCT_TEST(_field, _state, _test, _version, _vmsd, _type, _struct_version) { \
@@ -520,7 +538,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_STRUCT|VMS_VARRAY_UINT8,                       \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 /* a variable length array (i.e. _type *_field) but we know the
@@ -573,7 +591,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_STRUCT|VMS_VARRAY_INT32,                       \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 #define VMSTATE_STRUCT_VARRAY_UINT32(_field, _state, _field_num, _version, _vmsd, _type) { \
@@ -583,7 +601,7 @@ extern const VMStateInfo vmstate_info_qtailq;
     .vmsd       = &(_vmsd),                                          \
     .size       = sizeof(_type),                                     \
     .flags      = VMS_STRUCT|VMS_VARRAY_UINT32,                      \
-    .offset     = offsetof(_state, _field),                          \
+    .offset     = vmstate_offset_varray(_state, _field, _type),      \
 }
 
 #define VMSTATE_STRUCT_VARRAY_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) {\
-- 
2.20.1


