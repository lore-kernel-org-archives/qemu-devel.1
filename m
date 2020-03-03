Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF92C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C762073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uc41uiGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C762073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j98Pt-0002U1-UH
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 09:21:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1j98P0-0001Lr-Ud
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1j98Oz-00068S-TV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1j98Oz-00067z-Q0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 09:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583245205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MOp3xGTsUD9Bq3uJHwal64VMgYcykTle0vHwPVTjaLI=;
 b=Uc41uiGupOcQZ08QW02alLZP3iXPtx8XRPoT8S6EyEbC778FTggJ78VJIfDFwX4bhaGNxH
 lr4cYbue7ouvWUWmPJkfuzubDYrGHSaK58vaDHjvZFzH9iaIR8qlilcqnVeRjY28xTzZ6D
 rfDTazVZK8lwHoZYb1/IDos+jZz39SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-v8z8_KGhO9G7BGZQLlJWxQ-1; Tue, 03 Mar 2020 09:20:03 -0500
X-MC-Unique: v8z8_KGhO9G7BGZQLlJWxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221051084434;
 Tue,  3 Mar 2020 14:20:02 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-113.ams2.redhat.com [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EA5C60BE1;
 Tue,  3 Mar 2020 14:19:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 0/4] kvm: Implement atomic memory region resizes
Date: Tue,  3 Mar 2020 15:19:35 +0100
Message-Id: <20200303141939.352319-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, when doing a
    memory_region_ram_resize() -> memory_region_set_size()

the old KVM slot will first get removed and the new, resized one, will be
re-added. This is fine as long as no IOCTL is currently using any data from
such a memory slot (e.g., when building ACPI tables). However, if e.g., a
VCPU is in KVM_RUN and tries to access any data on such a slot while we're
growing it, we will get wrong faults while the slot is temporarily removed.

Let's allow to resize memory regions while the guest is running and might
be using the regions. Inhibit any KVM ioctl while we are replacing the
memory slot(s).

This is a preparation for virtio-mem (initially, x86-64 only), which wants
to resize (esp. grow) ram memory regions while the guest is running via
memory_region_ram_resize().

Using pause_all_vcpus()/resume_all_vcpus() is not possible, as it will
temporarily drop the BQL - something most callers can't handle (esp.
when called from vcpu context e.g., in virtio code).

Once we can handle resizes in the kernel (e.g., via
KVM_SET_USER_MEMORY_REGION), we can make inhibiting optional at runtime.

Instead of inhibiting during the region_resize(), we could inhibit for the
hole memory transaction (from begin() to commit()). This could be nice,
because also splitting of memory regions would be atomic (I remember there
was a BUG report regarding that), however, I am not sure if that might
impact any RT users.

Tested so far with x86-64 KVM only. Thoughts? Anything important I am
missing? Any alternatives that don't require kernel changes?

David Hildenbrand (4):
  openpic_kvm: Use kvm_device_ioctl() instead of ioctl()
  intc/s390_flic_kvm.c: Use kvm_device_ioctl() instead of ioctl()
  memory: Add region_resize() callback to memory notifier
  kvm: Implement atomic memory region resizes via region_resize()

 accel/kvm/kvm-all.c     | 121 +++++++++++++++++++++++++++++++++++++---
 hw/intc/openpic_kvm.c   |   8 +--
 hw/intc/s390_flic_kvm.c |  22 ++++----
 include/exec/memory.h   |  18 ++++++
 include/hw/core/cpu.h   |   3 +
 memory.c                |  72 ++++++++++++++++++++++--
 6 files changed, 217 insertions(+), 27 deletions(-)

--=20
2.24.1


