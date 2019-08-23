Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36126C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA8822CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA8822CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AzA-0007pZ-JO
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AiF-00059A-DQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AiD-0005mg-JD
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:38:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1Ai9-0005fR-40; Fri, 23 Aug 2019 10:38:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 821C980F7C;
 Fri, 23 Aug 2019 14:38:40 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10F3B60A9F;
 Fri, 23 Aug 2019 14:38:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: libguestfs@redhat.com
Date: Fri, 23 Aug 2019 09:38:36 -0500
Message-Id: <20190823143836.27321-2-eblake@redhat.com>
In-Reply-To: <20190823143836.27321-1-eblake@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
 <20190823143836.27321-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 23 Aug 2019 14:38:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [libnbd PATCH 1/1] api: Add support for FAST_ZERO flag
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qemu was able to demonstrate that knowing whether a zero operation is
fast is useful when copying from one image to another: there is a
choice between bulk pre-zeroing and then revisiting the data sections
(fewer transactions, but depends on the zeroing to be fast),
vs. visiting every portion of the disk only once (more transactions,
but no time lost to duplicated I/O due to slow zeroes).  As such, the
NBD protocol is adding an extension to allow clients to request fast
failure when zero is not efficient, from servers that advertise
support for the new flag.

In libnbd, this results in the addition of a new flag, a new functoin
nbd_can_fast_zero, and the ability to use the new flag in nbd_zero
variants.  It also enhances the testsuite to test the flag against
new enough nbdkit, which is being patched at the same time.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 lib/nbd-protocol.h     |  2 ++
 generator/generator    | 29 +++++++++++++++++++++++------
 lib/flags.c            | 12 ++++++++++++
 lib/protocol.c         |  1 +
 lib/rw.c               |  9 ++++++++-
 tests/Makefile.am      | 20 ++++++++++++++++++++
 tests/eflags-plugin.sh |  5 +++++
 7 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/lib/nbd-protocol.h b/lib/nbd-protocol.h
index 3e3fb4e..04e93d3 100644
--- a/lib/nbd-protocol.h
+++ b/lib/nbd-protocol.h
@@ -108,6 +108,7 @@ struct nbd_fixed_new_option_reply {
 #define NBD_FLAG_SEND_DF           (1 << 7)
 #define NBD_FLAG_CAN_MULTI_CONN    (1 << 8)
 #define NBD_FLAG_SEND_CACHE        (1 << 10)
+#define NBD_FLAG_SEND_FAST_ZERO    (1 << 11)

 /* NBD options (new style handshake only). */
 #define NBD_OPT_EXPORT_NAME        1
@@ -250,6 +251,7 @@ struct nbd_structured_reply_error {
 #define NBD_EINVAL     22
 #define NBD_ENOSPC     28
 #define NBD_EOVERFLOW  75
+#define NBD_ENOTSUP    95
 #define NBD_ESHUTDOWN 108

 #endif /* NBD_PROTOCOL_H */
diff --git a/generator/generator b/generator/generator
index c509573..9b1f5d8 100755
--- a/generator/generator
+++ b/generator/generator
@@ -958,10 +958,11 @@ let all_enums =3D [ tls_enum ]
 let cmd_flags =3D {
   flag_prefix =3D "CMD_FLAG";
   flags =3D [
-    "FUA",     1 lsl 0;
-    "NO_HOLE", 1 lsl 1;
-    "DF",      1 lsl 2;
-    "REQ_ONE", 1 lsl 3;
+    "FUA",       1 lsl 0;
+    "NO_HOLE",   1 lsl 1;
+    "DF",        1 lsl 2;
+    "REQ_ONE",   1 lsl 3;
+    "FAST_ZERO", 1 lsl 4;
   ]
 }
 let all_flags =3D [ cmd_flags ]
@@ -1389,6 +1390,19 @@ the server does not."
 ^ non_blocking_test_call_description;
   };

+  "can_fast_zero", {
+    default_call with
+    args =3D []; ret =3D RBool;
+    permitted_states =3D [ Connected; Closed ];
+    shortdesc =3D "does the server support the fast zero flag?";
+    longdesc =3D "\
+Returns true if the server supports the use of the
+C<LIBNBD_CMD_FLAG_FAST_ZERO> flag to the zero command
+(see C<nbd_zero>, C<nbd_aio_zero>).  Returns false if
+the server does not."
+^ non_blocking_test_call_description;
+  };
+
   "can_df", {
     default_call with
     args =3D []; ret =3D RBool;
@@ -1668,9 +1682,12 @@ The C<flags> parameter may be C<0> for no flags, o=
r may contain
 C<LIBNBD_CMD_FLAG_FUA> meaning that the server should not
 return until the data has been committed to permanent storage
 (if that is supported - some servers cannot do this, see
-L<nbd_can_fua(3)>), and/or C<LIBNBD_CMD_FLAG_NO_HOLE> meaning that
+L<nbd_can_fua(3)>), C<LIBNBD_CMD_FLAG_NO_HOLE> meaning that
 the server should favor writing actual allocated zeroes over
-punching a hole.";
+punching a hole, and/or C<LIBNBD_CMD_FLAG_FAST_ZERO> meaning
+that the server must fail quickly if writing zeroes is no
+faster than a normal write (if that is supported - some servers
+cannot do this, see L<nbd_can_fast_zero(3)>).";
   };

   "block_status", {
diff --git a/lib/flags.c b/lib/flags.c
index 2bcacb8..d55d10a 100644
--- a/lib/flags.c
+++ b/lib/flags.c
@@ -47,6 +47,12 @@ nbd_internal_set_size_and_flags (struct nbd_handle *h,
     eflags &=3D ~NBD_FLAG_SEND_DF;
   }

+  if (eflags & NBD_FLAG_SEND_FAST_ZERO &&
+      !(eflags & NBD_FLAG_SEND_WRITE_ZEROES)) {
+    debug (h, "server lacks write zeroes, ignoring claim of fast zero");
+    eflags &=3D ~NBD_FLAG_SEND_FAST_ZERO;
+  }
+
   h->exportsize =3D exportsize;
   h->eflags =3D eflags;
   return 0;
@@ -100,6 +106,12 @@ nbd_unlocked_can_zero (struct nbd_handle *h)
   return get_flag (h, NBD_FLAG_SEND_WRITE_ZEROES);
 }

+int
+nbd_unlocked_can_fast_zero (struct nbd_handle *h)
+{
+  return get_flag (h, NBD_FLAG_SEND_FAST_ZERO);
+}
+
 int
 nbd_unlocked_can_df (struct nbd_handle *h)
 {
diff --git a/lib/protocol.c b/lib/protocol.c
index 6087887..acee203 100644
--- a/lib/protocol.c
+++ b/lib/protocol.c
@@ -36,6 +36,7 @@ nbd_internal_errno_of_nbd_error (uint32_t error)
   case NBD_EINVAL: return EINVAL;
   case NBD_ENOSPC: return ENOSPC;
   case NBD_EOVERFLOW: return EOVERFLOW;
+  case NBD_ENOTSUP: return ENOTSUP;
   case NBD_ESHUTDOWN: return ESHUTDOWN;
   default: return EINVAL;
   }
diff --git a/lib/rw.c b/lib/rw.c
index d427681..adb6bc2 100644
--- a/lib/rw.c
+++ b/lib/rw.c
@@ -426,7 +426,8 @@ nbd_unlocked_aio_zero (struct nbd_handle *h,
     return -1;
   }

-  if ((flags & ~(LIBNBD_CMD_FLAG_FUA | LIBNBD_CMD_FLAG_NO_HOLE)) !=3D 0)=
 {
+  if ((flags & ~(LIBNBD_CMD_FLAG_FUA | LIBNBD_CMD_FLAG_NO_HOLE |
+                 LIBNBD_CMD_FLAG_FAST_ZERO)) !=3D 0) {
     set_error (EINVAL, "invalid flag: %" PRIu32, flags);
     return -1;
   }
@@ -437,6 +438,12 @@ nbd_unlocked_aio_zero (struct nbd_handle *h,
     return -1;
   }

+  if ((flags & LIBNBD_CMD_FLAG_FAST_ZERO) !=3D 0 &&
+      nbd_unlocked_can_fast_zero (h) !=3D 1) {
+    set_error (EINVAL, "server does not support the fast zero flag");
+    return -1;
+  }
+
   if (count =3D=3D 0) {             /* NBD protocol forbids this. */
     set_error (EINVAL, "count cannot be 0");
     return -1;
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2b4ea93..a7bc1b5 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -145,6 +145,8 @@ check_PROGRAMS +=3D \
 	can-not-trim-flag \
 	can-zero-flag \
 	can-not-zero-flag \
+	can-fast-zero-flag \
+	can-not-fast-zero-flag \
 	can-multi-conn-flag \
 	can-not-multi-conn-flag \
 	can-cache-flag \
@@ -177,6 +179,8 @@ TESTS +=3D \
 	can-not-trim-flag \
 	can-zero-flag \
 	can-not-zero-flag \
+	can-fast-zero-flag \
+	can-not-fast-zero-flag \
 	can-multi-conn-flag \
 	can-not-multi-conn-flag \
 	can-cache-flag \
@@ -289,6 +293,22 @@ can_not_zero_flag_CPPFLAGS =3D \
 can_not_zero_flag_CFLAGS =3D $(WARNINGS_CFLAGS)
 can_not_zero_flag_LDADD =3D $(top_builddir)/lib/libnbd.la

+can_fast_zero_flag_SOURCES =3D eflags.c
+can_fast_zero_flag_CPPFLAGS =3D \
+	-I$(top_srcdir)/include -Dflag=3Dcan_fast_zero \
+	-Drequire=3D'"has_can_fast_zero=3D1"' \
+	$(NULL)
+can_fast_zero_flag_CFLAGS =3D $(WARNINGS_CFLAGS)
+can_fast_zero_flag_LDADD =3D $(top_builddir)/lib/libnbd.la
+
+can_not_fast_zero_flag_SOURCES =3D eflags.c
+can_not_fast_zero_flag_CPPFLAGS =3D \
+	-I$(top_srcdir)/include -Dflag=3Dcan_fast_zero -Dvalue=3Dfalse \
+	-Drequire=3D'"has_can_fast_zero=3D1"' \
+	$(NULL)
+can_not_fast_zero_flag_CFLAGS =3D $(WARNINGS_CFLAGS)
+can_not_fast_zero_flag_LDADD =3D $(top_builddir)/lib/libnbd.la
+
 can_multi_conn_flag_SOURCES =3D eflags.c
 can_multi_conn_flag_CPPFLAGS =3D \
 	-I$(top_srcdir)/include -Dflag=3Dcan_multi_conn \
diff --git a/tests/eflags-plugin.sh b/tests/eflags-plugin.sh
index 8fccff8..3c4cc65 100755
--- a/tests/eflags-plugin.sh
+++ b/tests/eflags-plugin.sh
@@ -52,6 +52,11 @@ case "$1" in
         # be read-only and methods like can_trim will never be called.
         exit 0
         ;;
+    can_zero)
+	# We have to default to answering this with true before
+	# can_fast_zero has an effect.
+	exit 0
+	;;
     *)
         exit 2
         ;;
--=20
2.21.0


