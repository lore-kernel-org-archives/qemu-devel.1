Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E3CC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F206624673
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkKCd1+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206624673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SfB-0007kf-47
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j4S4C-0002QE-KX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j4S4B-0004bO-AI
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j4S4B-0004bC-5j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582129154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYUPpy9WR4gX9r+idlmlab2lhjNaErepqbjyGHIWibo=;
 b=NkKCd1+AzgwZutL5iqqdYcyOIVw9nHLdh334cqYHkzcPwvXEoeHBoheb+3lk+3mh7M6gvm
 gOL50tMDgbbs+oF7SGj4YCqJ4hSMhbW02KYSuNdi+kfsYDMCCxo/IR007SBfc52L2RUZYf
 TGweDRHtMiDjbG/fxxj3a5L1Kx0jBYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-i8EiePW9Pny-NPyjic8OoQ-1; Wed, 19 Feb 2020 11:19:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C11271022F89;
 Wed, 19 Feb 2020 16:19:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCE19811F8;
 Wed, 19 Feb 2020 16:19:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 13/13] migrate/ram: Tolerate partially changed mappings in
 postcopy code
Date: Wed, 19 Feb 2020 17:17:25 +0100
Message-Id: <20200219161725.115218-14-david@redhat.com>
In-Reply-To: <20200219161725.115218-1-david@redhat.com>
References: <20200219161725.115218-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: i8EiePW9Pny-NPyjic8OoQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we partially change mappings (e.g., mmap over parts of an existing
mmap) where we have a userfaultfd handler registered, the handler will
implicitly be unregistered from the parts that changed. This is e.g., the
case when doing a qemu_ram_remap(), but is also a preparation for RAM
blocks with resizable allocations and we're shrinking RAM blocks.

When the mapping is changed and the handler is removed, any waiters are
woken up. Trying to place pages will fail. We can simply ignore erors
due to that when placing pages - as the mapping changed on the migration
destination, also the content is stale. E.g., after shrinking a RAM
block, nobody should be using that memory. After doing a
qemu_ram_remap(), the old memory is expected to have vanished.

Let's tolerate such errors (but still warn for now) when placing pages.
Also, add a comment why unregistering will continue to work even though
the mapping might have changed.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/postcopy-ram.c | 43 ++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c68caf4e42..df9d27c004 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -506,6 +506,13 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
     range_struct.start =3D (uintptr_t)host_addr;
     range_struct.len =3D length;
=20
+    /*
+     * In case the mapping was partially changed since we enabled userfaul=
t
+     * (esp. when whrinking RAM blocks and we have resizable allocations, =
or
+     * via qemu_ram_remap()), the userfaultfd handler was already removed =
for
+     * the mappings that changed. Unregistering will, however, still work =
and
+     * ignore mappings without a registered handler.
+     */
     if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
         error_report("%s: userfault unregister %s", __func__, strerror(err=
no));
=20
@@ -1239,10 +1246,28 @@ int postcopy_place_page(MigrationIncomingState *mis=
, void *host, void *from,
      */
     if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, from, pagesize, rb)) =
{
         int e =3D errno;
-        error_report("%s: %s copy host: %p from: %p (size: %zd)",
-                     __func__, strerror(e), host, from, pagesize);
=20
-        return -e;
+        /*
+         * When the mapping gets partially changed before we try to place =
a page
+         * (esp. when whrinking RAM blocks and we have resizable allocatio=
ns, or
+         * via qemu_ram_remap()), the userfaultfd handler will be removed =
and
+         * placing pages will fail. In that case, any waiter was already w=
oken
+         * up when the mapping was changed. We can safely ignore this, as
+         * mappings that change once we're running on the destination impl=
y
+         * that memory of these mappings vanishes. Let's still print a war=
ning
+         * for now.
+         *
+         * Old kernels report EINVAL, new kernels report ENOENT.
+         */
+        if (e =3D=3D ENOENT || e =3D=3D EINVAL) {
+            warn_report("%s: %s copy host: %p from: %p (size: %zd)",
+                        __func__, strerror(e), host, from, pagesize);
+        } else {
+            error_report("%s: %s copy host: %p from: %p (size: %zd)",
+                         __func__, strerror(e), host, from, pagesize);
+
+            return -e;
+        }
     }
=20
     trace_postcopy_place_page(host);
@@ -1266,10 +1291,16 @@ int postcopy_place_page_zero(MigrationIncomingState=
 *mis, void *host,
     if (qemu_ram_is_uf_zeroable(rb)) {
         if (qemu_ufd_copy_ioctl(mis->userfault_fd, host, NULL, pagesize, r=
b)) {
             int e =3D errno;
-            error_report("%s: %s zero host: %p",
-                         __func__, strerror(e), host);
=20
-            return -e;
+            /* See the comment in postcopy_place_page() */
+            if (e =3D=3D ENOENT || e =3D=3D EINVAL) {
+                warn_report("%s: %s zero host: %p", __func__, strerror(e),
+                            host);
+            } else {
+                error_report("%s: %s zero host: %p", __func__, strerror(e)=
,
+                             host);
+                return -e;
+            }
         }
         return postcopy_notify_shared_wake(rb,
                                            qemu_ram_block_host_offset(rb,
--=20
2.24.1


