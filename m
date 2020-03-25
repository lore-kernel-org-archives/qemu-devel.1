Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E707C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:35:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEA22073E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 16:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUFUAq75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEA22073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8zt-0006q7-Vb
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 12:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1jH8zC-0006Q5-Vo
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1jH8zA-0004D1-VU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:34:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1jH8zA-0004CV-LN
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 12:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585154070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=It5IFA4WOAT+Bhk6HPwF9OjkE1kcED0YjUdeQs9Ckpc=;
 b=MUFUAq75QzeTk+0NSDUuTM/QH0DEnQrDNF1SdU92u0AC5NpErxuU9oxO69UDpLXgArYUOO
 SpQjuRHOvLwt00GGJylSVgAYNWZzh9Md54DcyMeSsSldYNDyGJkfrvajCpdp4ufXll58e3
 SzSo57OfSEaNTHpFxleHCTgb8m4H6IU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-ilk1FSGaNJSXpOmLoEWQiQ-1; Wed, 25 Mar 2020 12:34:28 -0400
X-MC-Unique: ilk1FSGaNJSXpOmLoEWQiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E4201005512
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 16:34:27 +0000 (UTC)
Received: from work-vm (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDCDB60BF3;
 Wed, 25 Mar 2020 16:34:19 +0000 (UTC)
Date: Wed, 25 Mar 2020 16:34:16 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH RFC 1/9] KVM: Fixup kvm_log_clear_one_slot() ioctl return
 check
Message-ID: <20200325163416.GA2635@work-vm>
References: <20200205141749.378044-1-peterx@redhat.com>
 <20200205141749.378044-2-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200205141749.378044-2-peterx@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Xu (peterx@redhat.com) wrote:
> kvm_vm_ioctl() handles the errno trick already for ioctl() on
> returning -1 for errors.  Fix this.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  accel/kvm/kvm-all.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index c111312dfd..4be3cd2352 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -688,14 +688,13 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int=
 as_id, uint64_t start,
>      d.num_pages =3D bmap_npages;
>      d.slot =3D mem->slot | (as_id << 16);
> =20
> -    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) =3D=3D -1) {
> -        ret =3D -errno;
> +    ret =3D kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d);
> +    if (ret) {
>          error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=3D%d, "
>                       "start=3D0x%"PRIx64", size=3D0x%"PRIx32", errno=3D%=
d",
>                       __func__, d.slot, (uint64_t)d.first_page,
>                       (uint32_t)d.num_pages, ret);
>      } else {
> -        ret =3D 0;
>          trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
>      }
> =20
> --=20
> 2.24.1
>=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


