Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B765EC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:17:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784A82072E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 15:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9M0AWhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784A82072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK1bS-00083n-KE
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 11:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jK1ai-0007ad-P3
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jK1ah-0000Yp-3W
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:17:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jK1ag-0000YN-SG
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585840630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M3RtyuMIyCBI1kMsSu1wg3j4C1IWbyN+4+1czyRbqBE=;
 b=P9M0AWhWcAeVOo5/YCTkeshgY9JV+kGsBgcYCS5NIEgKjtB94Rlr/5uWB9kPxppaS7/noW
 UD17Jz8zNz/dl/NQ5i646Zp8dOyB1l/ekfAJXaUrjgrYaO2jsSzPKrI1GncbWyqXJgM3xN
 m22FGNKbLCbgbEmMKQdxFI2X+6lVXo4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-gIHNfFP7Nkqm2pJ5HL3XHA-1; Thu, 02 Apr 2020 11:17:08 -0400
X-MC-Unique: gIHNfFP7Nkqm2pJ5HL3XHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4D2713F6;
 Thu,  2 Apr 2020 15:17:06 +0000 (UTC)
Received: from gondolin (ovpn-113-176.ams2.redhat.com [10.36.113.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D395B5D9C9;
 Thu,  2 Apr 2020 15:17:01 +0000 (UTC)
Date: Thu, 2 Apr 2020 17:16:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v3 1/1] vl/s390x: fixup ram sizes for compat machines
Message-ID: <20200402171659.1ba57efc.cohuck@redhat.com>
In-Reply-To: <20200401123754.109602-1-borntraeger@de.ibm.com>
References: <20200401123754.109602-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?B?THVr?= =?UTF-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  1 Apr 2020 08:37:54 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Older QEMU versions did fixup the ram size to match what can be reported
> via sclp. We need to mimic this behaviour for machine types 4.2 and
> older to not fail on inbound migration for memory sizes that do not fit.
> Old machines with proper aligned memory sizes are not affected.
>=20
> Alignment table:
>  VM size (<=3D) | Alignment
> --------------------------
>       1020M   |     1M
>       2040M   |     2M
>       4080M   |     4M
>       8160M   |     8M
>      16320M   |    16M
>      32640M   |    32M
>      65280M   |    64M
>     130560M   |   128M
>     261120M   |   256M
>     522240M   |   512M
>    1044480M   |     1G
>    2088960M   |     2G
>    4177920M   |     4G
>    8355840M   |     8G
>=20
> Suggested action is to replace unaligned -m value with a suitable
> aligned one or if a change to a newer machine type is possible, use a
> machine version >=3D 5.0.
>=20
> A future versions might remove the compatibility handling.

s/versions/version/ (fixed it up)

>=20
> For machine types >=3D 5.0 we can simply use an increment size of 1M and
> use the full range of increment number which allows for all possible
> memory sizes. The old limitation of having a maximum of 1020 increments
> was added for standby memory, which we no longer support. With that we
> can now support even weird memory sizes like 10001234 MB.
>=20
> As we no longer fixup maxram_size as well, make other users use ram_size
> instead. Keep using maxram_size when setting the maximum ram size in KVM,
> as that will come in handy in the future when supporting memory hotplug
> (in contrast, storage keys and storage attributes for hotplugged memory
> will have to be migrated per RAM block in the future).
>=20
> Fixes: 3a12fc61af5c ("390x/s390-virtio-ccw: use memdev for RAM")
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-skeys.c        |  2 +-
>  hw/s390x/s390-stattrib-kvm.c |  4 ++--
>  hw/s390x/s390-virtio-ccw.c   | 21 +++++++++++++++++++++
>  hw/s390x/sclp.c              | 17 +++++------------
>  include/hw/boards.h          |  7 +++++++
>  softmmu/vl.c                 |  3 +++
>  6 files changed, 39 insertions(+), 15 deletions(-)

Thanks, applied to s390-fixes (with the fixup message fixed up.)

[I plan to send a pull request for s390-fixes tomorrow, so please let
me know if there are any further concerns.]


