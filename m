Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CEC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1602067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsyGNpz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1602067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BUH-0001FA-Do
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j5BP2-0000UH-Tf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j5BP1-0007Av-Lv
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j5BP1-0007AZ-Hq
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582303427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iN/iIsf5KW8kt8ZFOB0qJCWWVyHiN82SW45bVtrhFO8=;
 b=LsyGNpz7EeAthSG7lGMesGULjYY6gdas+BC0NKzPd/HK/eOibtwpXULNI1nun2WwDQUTqC
 3DTeUBaDJFI1tef0t5K/JevD6oq+KeplIO8OnOmCEl06kKfYHYl7T2iSYwuErdLgGPUKtT
 7wx+MCzwgSn1io1deziNtqDCza3kzAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-RU53FHqHMqKNdV34k6A8Fw-1; Fri, 21 Feb 2020 11:43:45 -0500
X-MC-Unique: RU53FHqHMqKNdV34k6A8Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C758E1083E81;
 Fri, 21 Feb 2020 16:43:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-197.ams2.redhat.com [10.36.117.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD4995C105;
 Fri, 21 Feb 2020 16:43:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/13] migration/ram: Tolerate partially changed mappings
 in postcopy code
Date: Fri, 21 Feb 2020 17:42:04 +0100
Message-Id: <20200221164204.105570-14-david@redhat.com>
In-Reply-To: <20200221164204.105570-1-david@redhat.com>
References: <20200221164204.105570-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Keep printing a warning on EINVAL, to avoid hiding other (programming)
issues. ENOENT is unique.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 migration/postcopy-ram.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index c68caf4e42..f023830b9a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -506,6 +506,12 @@ static int cleanup_range(RAMBlock *rb, void *opaque)
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
+     * and ignore mappings without a registered handler.
+     */
     if (ioctl(mis->userfault_fd, UFFDIO_UNREGISTER, &range_struct)) {
         error_report("%s: userfault unregister %s", __func__, strerror(err=
no));
=20
@@ -1180,6 +1186,17 @@ int postcopy_ram_incoming_setup(MigrationIncomingSta=
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
@@ -1198,6 +1215,26 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, voi=
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


