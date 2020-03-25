Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D15C2D0E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CE52076F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 18:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bzl6/1+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CE52076F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHB7K-0006SA-L9
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 14:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jHB6O-0004r4-5H
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jHB6H-0004lG-Ss
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:50:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:33858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jHB6H-0004ky-KC
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 14:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585162200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wKt5+3m0LKtNpV11MCOidUd6Qx2QS5/KPiyqp2NX3k=;
 b=Bzl6/1+s/CIeo5U/g/eJmRN9HNcQvAdKU0PgT8q4cO/RIKqDxpBIjAIcZ7dhy2I+9I61T6
 hqmdqRz+JPdUkG8Xqnqq+9YciPq1yqgRtbsFfEjeMqSKFsDlWkKyZ5IUYBKE+azeDIahOg
 xQqlSnJzLeNoPXgaKjSZefqRuPJ5g+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-eFhFEh_WNs-UYw4DqPkR-Q-1; Wed, 25 Mar 2020 14:49:59 -0400
X-MC-Unique: eFhFEh_WNs-UYw4DqPkR-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20D2C189F76C
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 18:49:58 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C68B90A13;
 Wed, 25 Mar 2020 18:49:51 +0000 (UTC)
Date: Wed, 25 Mar 2020 18:49:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 7/9] KVM: Cache kvm slot dirty bitmap size
Message-ID: <20200325184949.GF2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-8-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-8-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> Cache it too because we'll reference it more frequently in the future.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c      | 1 +
>  include/sysemu/kvm_int.h | 1 +
>  2 files changed, 2 insertions(+)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f81e7a644b..ea7b8f7ca5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -548,6 +548,7 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
>      hwaddr bitmap_size =3D ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS=
),
>                                          /*HOST_LONG_BITS*/ 64) / 8;
>      mem->dirty_bmap =3D g_malloc0(bitmap_size);
> +    mem->dirty_bmap_size =3D bitmap_size;
>  }
> =20
>  /* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 1a19bfef80..71c9946ecf 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -23,6 +23,7 @@ typedef struct KVMSlot
>      int old_flags;
>      /* Dirty bitmap cache for the slot */
>      unsigned long *dirty_bmap;
> +    unsigned long dirty_bmap_size;
>      /* Cache of the address space ID */
>      int as_id;
>      /* Cache of the offset in ram address space */
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


