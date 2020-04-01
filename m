Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7147C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2E22077D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 10:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VmIDrN4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2E22077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJaPP-0001C1-KT
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 06:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJaNO-0006Fk-PY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:13:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJaNN-0006gI-2U
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:13:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43634
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJaNM-0006ef-Pv
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 06:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585736016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfTPjGLQAzoYlDfdQ6i07Pm+toKV6cSO5T+iFH+IbRI=;
 b=VmIDrN4eCktZXfWwhamVUmRKeyXU6fR5bMJDGwsorvAqmEDoqeUGsp7ANTPJWKAwegEiu0
 bT59GH8WtNIS+fBrQlSGdqctE2moKhd/QpRRT79aUwaVk65Gq4WvUnABkw9I78vtAG03p+
 ICWh04xJ/ZbzxbP2LTg6/iu83L9Vbws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-NLUXwDw7MvKtDMRq1gx1sg-1; Wed, 01 Apr 2020 06:13:34 -0400
X-MC-Unique: NLUXwDw7MvKtDMRq1gx1sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0FB5DBB1;
 Wed,  1 Apr 2020 10:13:32 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCA9218A85;
 Wed,  1 Apr 2020 10:13:27 +0000 (UTC)
Date: Wed, 1 Apr 2020 12:13:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2] vl/s390: fixup ram sizes for compat machines
Message-ID: <20200401121324.379cfd0d.cohuck@redhat.com>
In-Reply-To: <20200401085014.100125-1-borntraeger@de.ibm.com>
References: <20200401085014.100125-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Wed,  1 Apr 2020 04:50:14 -0400
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

"to replace any unaligned -m value" ?

> aligned one or to use a machine version >=3D 5.0 as future versions might
> remove the compatibility handling.

I'm confused by the second part of the sentence. Warning about possible
future removal of the compat stuff is fine, but I don't understand the
suggestion to use a machine type >=3D 5.0. If I create a new machine that
does not need be migrated to an old QEMU, using the latest machine type
always seems like the best idea, right? And for a migration target it's
not like we can choose the version freely anyway.

>=20
> For machine types >=3D 5.0 we can simply use an increment size of 1M and
> use the full range of increment number which allows for all possible
> memory sizes. The old limitation of having a maximum of 1020 increments
> was added for standby memory, which we no longer support. With that we
> can now support even weird memory sizes like 10001234 MB.
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
>  hw/s390x/s390-virtio-ccw.c   | 19 +++++++++++++++++++
>  hw/s390x/sclp.c              | 19 ++++++-------------
>  include/hw/boards.h          |  7 +++++++
>  softmmu/vl.c                 |  3 +++
>  6 files changed, 38 insertions(+), 16 deletions(-)
>=20

> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 236d239c19..0532143327 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -152,6 +152,12 @@ typedef struct {
>   *    It also will be used as a way to optin into "-m" option support.
>   *    If it's not set by board, '-m' will be ignored and generic code wi=
ll
>   *    not create default RAM MemoryRegion.
> + * @fixup_ram_size:
> + *    amends user provided ram size (with -m option) using machine
> + *    specific algorithm. to be used by old machine types for compat
> + *    purposes only.
> + *    Applies only to default memory backend, i.e. explicit memory backe=
nd
> + *    wasn't used.

"Applies only to the default memory backend, i.e., an explicitly
specified memory backend will not be affected."

?

>   */
>  struct MachineClass {
>      /*< private >*/


