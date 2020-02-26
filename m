Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFDC4BA13
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:00:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371C821556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 16:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G89klb/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371C821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6z7C-0005q4-6j
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 11:00:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j6z0t-0003d5-0O
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:54:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j6z0r-0003QD-Pl
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:54:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39930
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j6z0r-0003Oa-Lf
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 10:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582732457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BHCVavcwdU9hOi5U0JBlZicFww6IvMYsjJ29cufnJwY=;
 b=G89klb/py8AYTuY2PaSeJslH3n2F4A0gzMa0tuqdBiVRJcV2QJa33Ws0cZYZOKjMswzgmO
 iqw3AJVrBswmz+fujO0J/WPjBPnsxqKXBEh8o7BcK2yTDF7HLKy/EMQX4zq7I282uLR9H7
 mGSZeDNe+rxbxuRBZw0YbPIv/+rRHbc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-IiFkBAvAMrysDeSHjumZrw-1; Wed, 26 Feb 2020 10:54:13 -0500
X-MC-Unique: IiFkBAvAMrysDeSHjumZrw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6248DB65;
 Wed, 26 Feb 2020 15:54:12 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D735B101D482;
 Wed, 26 Feb 2020 15:54:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/13] migration/ram: Tolerate partially changed mappings
 in postcopy code
Date: Wed, 26 Feb 2020 16:53:04 +0100
Message-Id: <20200226155304.60219-14-david@redhat.com>
In-Reply-To: <20200226155304.60219-1-david@redhat.com>
References: <20200226155304.60219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

When we partially change mappings (esp., mmap over parts of an existing
mmap like qemu_ram_remap() does) where we have a userfaultfd handler
registered, the handler will implicitly be unregistered from the parts that
changed.

Trying to place pages onto mappings where there is no longer a handler
registered will fail. Let's make sure that any waiter is woken up - we
have to do that manually.

Let's also document how UFFDIO_UNREGISTER will handle this scenario.

This is mainly a preparation for RAM blocks with resizable allcoations,
where the mapping of the invalid RAM range will change. The source will
keep sending pages that are outside of the new (shrunk) RAM size. We have
to treat these pages like they would have been migrated, but can
essentially simply drop the content (ignore the placement error).

Keep printing a warning when we hit EINVAL, to avoid hiding other
(programming) issues. ENOENT is unique.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/postcopy-ram.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c68caf4e42..f39c6304de 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -506,6 +506,14 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
     range_struct.start =3D (uintptr_t)host_addr;
     range_struct.len =3D length;
=20
+    /*
+     * In case the mapping was partially changed since we enabled userfaul=
t
+     * (e.g., via qemu_ram_remap()), the userfaultfd handler was already r=
emoved
+     * for the mappings that changed. Unregistering will, however, still w=
ork
+     * and ignore mappings without a registered handler. There could only =
be
+     * an issue if we would suddenly encounter a mapping that's incompatib=
le
+     * with UFFD - which cannot happen within a single RAM block.
+     */
     if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
         error_report("%s: userfault unregister %s", __func__, strerror(err=
no));
=20
@@ -1180,6 +1188,17 @@ int postcopy_ram_incoming_setup(MigrationIncomingSta=
te *mis)
     return 0;
 }
=20
+static int qemu_ufd_wake_ioctl(int userfault_fd, void *host_addr,
+                               uint64_t pagesize)
+{
+    struct uffdio_range range =3D {
+        .start =3D (uint64_t)(uintptr_t)host_addr,
+        .len =3D pagesize,
+    };
+
+    return ioctl(userfault_fd, UFFDIO_WAKE, &range);
+}
+
 static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
                                void *from_addr, uint64_t pagesize, RAMBloc=
k *rb)
 {
@@ -1198,6 +1217,26 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, voi=
d *host_addr,
         zero_struct.mode =3D 0;
         ret =3D ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
     }
+
+    /*
+     * When the mapping gets partially changed (e.g., qemu_ram_remap()) be=
fore
+     * we try to place a page, the userfaultfd handler will be removed for=
 the
+     * changed mappings and placing pages will fail. We can safely ignore =
this,
+     * because mappings that changed on the destination don't need data fr=
om the
+     * source (e.g., qemu_ram_remap()). Wake up any waiter waiting for tha=
t page
+     * (unlikely but possible). Waking up waiters is always possible, even
+     * without a registered userfaultfd handler.
+     *
+     * Old kernels report EINVAL, new kernels report ENOENT in case there =
is
+     * no longer a userfaultfd handler for a mapping.
+     */
+    if (ret && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
+        if (errno =3D=3D EINVAL) {
+            warn_report("%s: Failed to place page %p. Waking up any waiter=
s.",
+                         __func__, host_addr);
+        }
+        ret =3D qemu_ufd_wake_ioctl(userfault_fd, host_addr, pagesize);
+    }
     if (!ret) {
         ramblock_recv_bitmap_set_range(rb, host_addr,
                                        pagesize / qemu_target_page_size())=
;
--=20
2.24.1


