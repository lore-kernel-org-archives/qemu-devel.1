Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59830C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2485620674
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FnsRyEUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2485620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUh4-00052w-Jp
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1itUR9-0008FI-JJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1itUR7-0003K5-2I
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31158
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1itUR6-0003Jd-VL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/qRvnKikU/zZW4H4BQbW8b5TjzE8O1lK0e+sh7nSqVM=;
 b=FnsRyEUSD4SXba/H+uoVGS91PT+KVKs1uMXO5xEOZ3yIJEOJKzIEDBCb2YwKsX5K2u0xpu
 FvttIqRdHs52ggJjyP9yeRHetoN0bH2ZbPaM8iE9O4oT4oZ4TPPjRxpU/aPj5rmBMzX6pD
 x3F+ZlIWZPJGOIQYvzeokrFcXpxUlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-ubv4fPYtNKmsUxd_MdmgYw-1; Mon, 20 Jan 2020 05:37:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533F6800D54;
 Mon, 20 Jan 2020 10:37:32 +0000 (UTC)
Received: from secure.mitica (ovpn-116-207.ams2.redhat.com [10.36.116.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0971860E5;
 Mon, 20 Jan 2020 10:37:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/29] apic: Use 32bit APIC ID for migration instance ID
Date: Mon, 20 Jan 2020 11:33:38 +0100
Message-Id: <20200120103340.25118-28-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
References: <20200120103340.25118-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ubv4fPYtNKmsUxd_MdmgYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Xu <peterx@redhat.com>

Migration is silently broken now with x2apic config like this:

     -smp 200,maxcpus=3D288,sockets=3D2,cores=3D72,threads=3D2 \
     -device intel-iommu,intremap=3Don,eim=3Don

After migration, the guest kernel could hang at anything, due to
x2apic bit not migrated correctly in IA32_APIC_BASE on some vcpus, so
any operations related to x2apic could be broken then (e.g., RDMSR on
x2apic MSRs could fail because KVM would think that the vcpu hasn't
enabled x2apic at all).

The issue is that the x2apic bit was never applied correctly for vcpus
whose ID > 255 when migrate completes, and that's because when we
migrate APIC we use the APICCommonState.id as instance ID of the
migration stream, while that's too short for x2apic.

Let's use the newly introduced initial_apic_id for that.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/intc/apic_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 54b8731fca..b5dbeb6206 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -268,7 +268,10 @@ static void apic_common_realize(DeviceState *dev, Erro=
r **errp)
     APICCommonState *s =3D APIC_COMMON(dev);
     APICCommonClass *info;
     static DeviceState *vapic;
-    uint32_t instance_id =3D s->id;
+    uint32_t instance_id =3D s->initial_apic_id;
+
+    /* Normally initial APIC ID should be no more than hundreds */
+    assert(instance_id !=3D VMSTATE_INSTANCE_ID_ANY);
=20
     info =3D APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
--=20
2.24.1


