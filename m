Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C6EC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BE720714
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 21:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcRtOwJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BE720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHwgz-0007Rj-NT
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 17:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHwgK-0006ml-Cm
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHwgI-0000bS-TI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:38:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHwgI-0000bF-QO
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585345102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2DKEeFqeB7MUguOAKe/Hj1XHV+zJd8pLyreKFQ4afo=;
 b=OcRtOwJJi+Nj2t80TijBMBxp1GsOq+ZtKaQfe8mm2razC2IkHCaOFHf8HHouPQZakYpLv2
 fNh4NlVCQqwqp7TLytvUi3Rr8o80nBFvlJrodSACct0U6p2Pu2C6D1Uw48WbInH4iC8q/E
 JJG8IqjaBRdlLJm1tf6eQokacuXJKCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-O4yAOWFaNDmSB_MRPeFlrQ-1; Fri, 27 Mar 2020 17:38:18 -0400
X-MC-Unique: O4yAOWFaNDmSB_MRPeFlrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7419C8017CC;
 Fri, 27 Mar 2020 21:38:17 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D324A60BF4;
 Fri, 27 Mar 2020 21:38:10 +0000 (UTC)
Date: Fri, 27 Mar 2020 22:38:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] s390x: Reject unaligned RAM sizes
Message-ID: <20200327223808.74cf4287@redhat.com>
In-Reply-To: <77067f3b-4fe6-f67a-d8f3-d3de1f3b5a85@redhat.com>
References: <20200327152930.66636-1-david@redhat.com>
 <20200327174823.48c523dc@redhat.com>
 <77067f3b-4fe6-f67a-d8f3-d3de1f3b5a85@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: =?UTF-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 17:51:23 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 27.03.20 17:48, Igor Mammedov wrote:
> > On Fri, 27 Mar 2020 16:29:30 +0100
> > David Hildenbrand <david@redhat.com> wrote:
> >  =20
> >> Historically, we fixed up the RAM size (rounded it down), to fit into
> >> storage increments. Since commit 3a12fc61af5c ("390x/s390-virtio-ccw: =
use
> >> memdev for RAM"), we no longer consider the fixed-up size when
> >> allcoating the RAM block - which will break migration.
> >>
> >> Let's simply drop that manual fixup code and let the user supply sane
> >> RAM sizes. This will bail out early when trying to migrate (and make
> >> an existing guest with e.g., 12345 MB non-migratable), but maybe we
> >> should have rejected such RAM sizes right from the beginning.
> >>
> >> As we no longer fixup maxram_size as well, make other users use ram_si=
ze
> >> instead. Keep using maxram_size when setting the maximum ram size in K=
VM,
> >> as that will come in handy in the future when supporting memory hotplu=
g
> >> (in contrast, storage keys and storage attributes for hotplugged memor=
y
> >>  will have to be migrated per RAM block in the future).
> >>
> >> This fixes (or rather rejects early):
> >>
> >> 1. Migrating older QEMU to upstream QEMU (e.g., with "-m 1235M"), as t=
he
> >>    RAM block size changed.
> >>
> >> 2. Migrating upstream QEMU to upstream QEMU (e.g., with "-m 1235M"), a=
s
> >>    we receive storage attributes for memory we don't expect (as we fix=
ed up
> >>    ram_size and maxram_size).
> >>
> >> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> >> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> >> Cc: Igor Mammedov <imammedo@redhat.com>
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/s390x/s390-skeys.c        |  4 +---
> >>  hw/s390x/s390-stattrib-kvm.c |  7 ++-----
> >>  hw/s390x/sclp.c              | 21 +++++++++++----------
> >>  3 files changed, 14 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> >> index 5da6e5292f..2545b1576b 100644
> >> --- a/hw/s390x/s390-skeys.c
> >> +++ b/hw/s390x/s390-skeys.c
> >> @@ -11,7 +11,6 @@
> >> =20
> >>  #include "qemu/osdep.h"
> >>  #include "qemu/units.h"
> >> -#include "hw/boards.h"
> >>  #include "hw/s390x/storage-keys.h"
> >>  #include "qapi/error.h"
> >>  #include "qapi/qapi-commands-misc-target.h"
> >> @@ -174,9 +173,8 @@ out:
> >>  static void qemu_s390_skeys_init(Object *obj)
> >>  {
> >>      QEMUS390SKeysState *skeys =3D QEMU_S390_SKEYS(obj);
> >> -    MachineState *machine =3D MACHINE(qdev_get_machine());
> >> =20
> >> -    skeys->key_count =3D machine->maxram_size / TARGET_PAGE_SIZE;
> >> +    skeys->key_count =3D ram_size / TARGET_PAGE_SIZE; =20
> >=20
> > why are you dropping machine->foo all around and switching to global ra=
m_size?
> > (I'd rather do other way around) =20
>=20
> Not sure what the latest best practice is. I can also simply convert to
> machine->ram_size if that's the right thing to do.
My understanding of it was not to use globals if possible.
(I planned on removing global ram_size an leave only machine->ram_size
but that a bit tricky since things tend to explode once a global touched,
so it needs some more thought/patience)



