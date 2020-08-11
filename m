Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DA0720774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iyrVYF9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA0720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5OWW-000399-0l
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 03:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3T0QyXwMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com>)
 id 1k5OQG-00053r-Fa
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:12 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a]:54374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3T0QyXwMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com>)
 id 1k5OQD-0000la-7p
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 03:10:12 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id b127so15635436ybh.21
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 00:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=n8F3e7zpn77NODyrxjfL4R2P/H4DSjSuJcBVxAzaq1k=;
 b=iyrVYF9ozKSnxO1QZnM8zZPM2mkYzBI9Ry1cBHQeBZ4//+N03tLM2ZqETqZYSNdNTX
 B7QKH20/Q1/8DLPbRmr+/3prjjXesigvkk76rjS2A8AAarEM67+cbLlA3+oV9MgNBD+o
 CiXbC0aPWSh327Mubz7+QU/ix8bTStl0LhvqFe1GcyXQv15Up34ACFBSren68/I5zShY
 TJ98FbACqu2WFhJ17OWOWd/A5kN8FOrVzRLRxCGDAERi/QBc/axl2Kvolxxem77rCxTZ
 U1hOa8uXxDqGkOTs69EKsi3O0EDvQs08+6Id/cnaTGAnBzhZEgbOvRVpAfQwzOiFRH7R
 hD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=n8F3e7zpn77NODyrxjfL4R2P/H4DSjSuJcBVxAzaq1k=;
 b=lqh9md738G+CPpQHTtQbCyW/tRJM+bhO6YEbiXy0KypGw8LhaUBv+vBtoxy4QDl8nu
 lptABBgWHPkpBMxZL1XTX0toOZpPZ54+4SNVf57Jj/XHhMoQahvbxs8xak48quqEhOlf
 n1sswgdpWvLte+bV1N6l+mK+sSaxyqwAfzbhiw6klUlHwGt59fyhQKEFHBcXcTWp0VUU
 UxL57aq0xSJVFjKmGdzg4pBydcn8jy1E1cVBeBAiSItjacO2IwqJDcXb5Ovw8XaxVoac
 EXC07TB6r6NHHc45BQurl+gWtUsUlZ6yo7LnNC0C1batEbPZkKuJPExWel+G2M8ZI848
 Halw==
X-Gm-Message-State: AOAM530DtwkWbnA+juKul+tq1NL3M78NMwX5ehaiS7/hGm22dzWYaZg7
 u1SJxlyzfPN7dFcHO1PZTs5p84gjwMx/q+iBYg/ihEYhqfmEhoI1fSpj/vXxS/OLVbwb4htfxWx
 tQH5tzmYHup6Yk0RRHWaHQvGDsW7F+6iPV9kr50tifbPckHkq/GxC
X-Google-Smtp-Source: ABdhPJy8Rf8yBiLXH8BBrs6AzIrKEI/+b5JmglIj3LqwlGp9EBheSAxE/VQkUMA+p8LGS8OxBQ0eiYs=
X-Received: by 2002:a25:3790:: with SMTP id
 e138mr18979408yba.421.1597129807111; 
 Tue, 11 Aug 2020 00:10:07 -0700 (PDT)
Date: Tue, 11 Aug 2020 00:09:47 -0700
In-Reply-To: <cover.1597129029.git.scw@google.com>
Message-Id: <e0754f52180aee6418eae8b3b8aa5981fcac12fd.1597129029.git.scw@google.com>
Mime-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v2 7/8] thunk: supports flexible arrays
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Shu-Chun Weng <scw@google.com>, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3T0QyXwMKCqASCWGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -105
X-Spam_score: -10.6
X-Spam_bar: ----------
X-Spam_report: (-10.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Flexible arrays may appear in the last field of a struct and are heavily
used in the ioctl(SIOCETHTOOL) system call on Linux. E.g.

  struct ethtool_regs {
      __u32   cmd;
      __u32   version; /* driver-specific, indicates different chips/revs */
      __u32   len; /* bytes */
      __u8    data[0];
  };

where number of elements in `data` is specified in `len`. It is translated
into:

  STRUCT(ethtool_regs,
         TYPE_INT, /* cmd */
         TYPE_INT, /* version */
         TYPE_INT, /* len */
         MK_FLEXIBLE_ARRAY(TYPE_CHAR, 2)) /* data[0]: len */

where the "2" passed to `MK_FLEXIBLE_ARRAY` means the number of element
is specified by field number 2 (0-index).

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
v1 -> v2:
  Fix style problems.

 include/exec/user/thunk.h |  24 ++++++
 thunk.c                   | 152 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 7992475c9f..d0d7c83f1f 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -39,12 +39,21 @@ typedef enum argtype {
     TYPE_ARRAY,
     TYPE_STRUCT,
     TYPE_OLDDEVT,
+    TYPE_FLEXIBLE_ARRAY,
 } argtype;
 
 #define MK_PTR(type) TYPE_PTR, type
 #define MK_ARRAY(type, size) TYPE_ARRAY, size, type
 #define MK_STRUCT(id) TYPE_STRUCT, id
 
+/*
+ * Should only appear as the last element of a TYPE_STRUCT. `len_field_idx` is
+ * the index into the fields in the enclosing struct that specify the length of
+ * the flexibly array. The length field MUST be a TYPE_INT field.
+ */
+#define MK_FLEXIBLE_ARRAY(type, len_field_idx) \
+    TYPE_FLEXIBLE_ARRAY, (len_field_idx), type
+
 #define THUNK_TARGET 0
 #define THUNK_HOST   1
 
@@ -55,6 +64,8 @@ typedef struct {
     int *field_offsets[2];
     /* special handling */
     void (*convert[2])(void *dst, const void *src);
+    int (*thunk_size[2])(const void *src);
+
     int size[2];
     int align[2];
     const char *name;
@@ -75,6 +86,11 @@ const argtype *thunk_convert(void *dst, const void *src,
                              const argtype *type_ptr, int to_host);
 const argtype *thunk_print(void *arg, const argtype *type_ptr);
 
+bool thunk_type_has_flexible_array(const argtype *type_ptr);
+/* thunk_type_size but can handle TYPE_FLEXIBLE_ARRAY */
+int thunk_type_size_with_src(const void *src, const argtype *type_ptr,
+                             int is_host);
+
 extern StructEntry *struct_entries;
 
 int thunk_type_size_array(const argtype *type_ptr, int is_host);
@@ -137,6 +153,12 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
     case TYPE_STRUCT:
         se = struct_entries + type_ptr[1];
         return se->size[is_host];
+    case TYPE_FLEXIBLE_ARRAY:
+        /*
+         * Flexible arrays do not count toward sizeof(). Users of structures
+         * containing them need to calculate it themselves.
+         */
+        return 0;
     default:
         g_assert_not_reached();
     }
@@ -187,6 +209,8 @@ static inline int thunk_type_align(const argtype *type_ptr, int is_host)
     case TYPE_STRUCT:
         se = struct_entries + type_ptr[1];
         return se->align[is_host];
+    case TYPE_FLEXIBLE_ARRAY:
+        return thunk_type_align_array(type_ptr + 2, is_host);
     default:
         g_assert_not_reached();
     }
diff --git a/thunk.c b/thunk.c
index c5d9719747..d9c6cba3bd 100644
--- a/thunk.c
+++ b/thunk.c
@@ -50,6 +50,8 @@ static inline const argtype *thunk_type_next(const argtype *type_ptr)
         return thunk_type_next_ptr(type_ptr + 1);
     case TYPE_STRUCT:
         return type_ptr + 1;
+    case TYPE_FLEXIBLE_ARRAY:
+        return thunk_type_next_ptr(type_ptr + 1);
     default:
         return NULL;
     }
@@ -122,6 +124,34 @@ void thunk_register_struct_direct(int id, const char *name,
     se->name = name;
 }
 
+static const argtype *
+thunk_convert_flexible_array(void *dst, const void *src,
+                             const uint8_t *dst_struct,
+                             const uint8_t *src_struct, const argtype *type_ptr,
+                             const StructEntry *se, int to_host) {
+    int len_field_idx, dst_size, src_size, i;
+    uint32_t array_length;
+    uint8_t *d;
+    const uint8_t *s;
+
+    assert(*type_ptr == TYPE_FLEXIBLE_ARRAY);
+    type_ptr++;
+    len_field_idx = *type_ptr++;
+    array_length =
+        *(const uint32_t *)(to_host ?
+                            dst_struct + se->field_offsets[1][len_field_idx] :
+                            src_struct + se->field_offsets[0][len_field_idx]);
+    dst_size = thunk_type_size(type_ptr, to_host);
+    src_size = thunk_type_size(type_ptr, to_host);
+    d = dst;
+    s = src;
+    for (i = 0; i < array_length; i++) {
+        thunk_convert(d, s, type_ptr, to_host);
+        d += dst_size;
+        s += src_size;
+    }
+    return thunk_type_next(type_ptr);
+}
 
 /* now we can define the main conversion functions */
 const argtype *thunk_convert(void *dst, const void *src,
@@ -246,7 +276,7 @@ const argtype *thunk_convert(void *dst, const void *src,
 
             assert(*type_ptr < max_struct_entries);
             se = struct_entries + *type_ptr++;
-            if (se->convert[0] != NULL) {
+            if (se->convert[to_host] != NULL) {
                 /* specific conversion is needed */
                 (*se->convert[to_host])(dst, src);
             } else {
@@ -256,7 +286,18 @@ const argtype *thunk_convert(void *dst, const void *src,
                 src_offsets = se->field_offsets[1 - to_host];
                 d = dst;
                 s = src;
-                for(i = 0;i < se->nb_fields; i++) {
+                for (i = 0; i < se->nb_fields; i++) {
+                    if (*field_types == TYPE_FLEXIBLE_ARRAY) {
+                        field_types = thunk_convert_flexible_array(
+                            d + dst_offsets[i],
+                            s + src_offsets[i],
+                            d,
+                            s,
+                            field_types,
+                            se,
+                            to_host);
+                        continue;
+                    }
                     field_types = thunk_convert(d + dst_offsets[i],
                                                 s + src_offsets[i],
                                                 field_types, to_host);
@@ -264,6 +305,11 @@ const argtype *thunk_convert(void *dst, const void *src,
             }
         }
         break;
+    case TYPE_FLEXIBLE_ARRAY:
+        fprintf(stderr,
+                "Invalid flexible array (type 0x%x) outside of a structure\n",
+                type);
+        break;
     default:
         fprintf(stderr, "Invalid type 0x%x\n", type);
         break;
@@ -271,6 +317,45 @@ const argtype *thunk_convert(void *dst, const void *src,
     return type_ptr;
 }
 
+static const argtype *
+thunk_print_flexible_array(void *arg, const uint8_t *arg_struct,
+                           const argtype *type_ptr, const StructEntry *se) {
+    int array_length, len_field_idx, arg_size, i;
+    uint8_t *a;
+    int is_string = 0;
+
+    assert(*type_ptr == TYPE_FLEXIBLE_ARRAY);
+    type_ptr++;
+    len_field_idx = *type_ptr++;
+
+    array_length = tswap32(
+        *(const uint32_t *)(arg_struct + se->field_offsets[0][len_field_idx]));
+    arg_size = thunk_type_size(type_ptr, 0);
+    a = arg;
+
+    if (*type_ptr == TYPE_CHAR) {
+        qemu_log("\"");
+        is_string = 1;
+    } else {
+        qemu_log("[");
+    }
+
+    for (i = 0; i < array_length; i++) {
+        if (i > 0 && !is_string) {
+            qemu_log(",");
+        }
+        thunk_print(a, type_ptr);
+        a += arg_size;
+    }
+
+    if (is_string) {
+        qemu_log("\"");
+    } else {
+        qemu_log("]");
+    }
+    return thunk_type_next(type_ptr);
+}
+
 const argtype *thunk_print(void *arg, const argtype *type_ptr)
 {
     int type;
@@ -414,17 +499,80 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
                 if (i > 0) {
                     qemu_log(",");
                 }
+                if (*field_types == TYPE_FLEXIBLE_ARRAY) {
+                    field_types = thunk_print_flexible_array(
+                        a + arg_offsets[i], a, field_types, se);
+                    continue;
+                }
                 field_types = thunk_print(a + arg_offsets[i], field_types);
             }
             qemu_log("}");
         }
         break;
+    case TYPE_FLEXIBLE_ARRAY:
+        fprintf(stderr,
+                "Invalid flexible array (type 0x%x) outside of a structure\n",
+                type);
+        break;
     default:
         g_assert_not_reached();
     }
     return type_ptr;
 }
 
+bool thunk_type_has_flexible_array(const argtype *type_ptr)
+{
+  int i;
+  const StructEntry *se;
+  const argtype *field_types;
+    if (*type_ptr != TYPE_STRUCT) {
+        return false;
+    }
+    se = struct_entries + type_ptr[1];
+    field_types = se->field_types;
+    for (i = 0; i < se->nb_fields; i++) {
+        if (*field_types == TYPE_FLEXIBLE_ARRAY) {
+            return true;
+        }
+        field_types = thunk_type_next(type_ptr);
+    }
+    return false;
+}
+
+int thunk_type_size_with_src(const void *src, const argtype *type_ptr,
+                             int is_host)
+{
+    switch (*type_ptr) {
+    case TYPE_STRUCT: {
+        int i;
+        const StructEntry *se = struct_entries + type_ptr[1];
+        const argtype *field_types;
+        if (se->thunk_size[is_host] != NULL) {
+            return (*se->thunk_size[is_host])(src);
+        }
+
+        field_types = se->field_types;
+        for (i = 0; i < se->nb_fields; i++) {
+            if (*field_types == TYPE_FLEXIBLE_ARRAY) {
+                uint32_t array_length = *(const uint32_t *)(
+                    (const uint8_t *)src +
+                    se->field_offsets[is_host][field_types[1]]);
+                if (!is_host) {
+                    array_length = tswap32(array_length);
+                }
+                return se->size[is_host] +
+                    array_length *
+                    thunk_type_size(field_types + 2, is_host);
+            }
+            field_types = thunk_type_next(type_ptr);
+        }
+        return se->size[is_host];
+    }
+    default:
+        return thunk_type_size(type_ptr, is_host);
+    }
+}
+
 /* from em86 */
 
 /* Utility function: Table-driven functions to translate bitmasks
-- 
2.28.0.220.ged08abb693-goog


