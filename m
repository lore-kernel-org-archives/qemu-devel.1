Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4927AC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:53:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E992073A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKVCdrV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E992073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is4e3-0002SQ-88
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37633)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1is4dS-0001uH-4j
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:52:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1is4dR-0006x7-39
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:52:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1is4dQ-0006wd-VZ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579179148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TdSsp/RO9MofIu8PYTjx2kppGEEL4elHaAbRx0uxxfA=;
 b=SKVCdrV0M7bhYSqrgL3fxOGGsKGobjR0X3B5wIppBntoVrfTVnuUqPOr+bN7b4yldYzy+/
 K96b5SM0x3V3HchO2lmMg+bGYdD4bYeovmRgkUF0qtYaQVWfjPWtDCZpqFW7jUWWnNIZxq
 fmrO7NYDLRWeDH+QEvg+f2Avv4hf7mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-w3MbmyMzPByd4VCgVBMKCw-1; Thu, 16 Jan 2020 07:52:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED861137842;
 Thu, 16 Jan 2020 12:52:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-204-105.brq.redhat.com [10.40.204.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D55A75C1C3;
 Thu, 16 Jan 2020 12:52:23 +0000 (UTC)
Subject: Re: [PATCH] s390x/flic: adapter routes handling if !kernel_irqchip
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200116123703.14624-1-cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <57df7c9b-ddd7-3a7a-1113-91f7c1355d10@redhat.com>
Date: Thu, 16 Jan 2020 13:52:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116123703.14624-1-cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: w3MbmyMzPByd4VCgVBMKCw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/01/2020 13.37, Cornelia Huck wrote:
> If the kernel irqchip has been disabled, we don't want the
> {add,release}_adapter_routes routines to call any kvm_irqchip_*
> interfaces, as they may rely on an irqchip actually having been
> created. Just take a quick exit in that case instead.
>=20
> Fixes: d426d9fba8ea ("s390x/virtio-ccw: wire up irq routing and irqfds")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>=20
> Without this patch, QEMU with kernel_irqchip=3Doff will crash in
> kvm_irqchip_release_virq(), so alternatively, we could add a check
> there. kvm_irqchip_add_adapter_route() is actually fine.
>=20
> ---
>  hw/intc/s390_flic_kvm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index dddd33ea61c8..44b7960ebcc8 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -331,6 +331,10 @@ static int kvm_s390_add_adapter_routes(S390FLICState=
 *fs,
>      int ret, i;
>      uint64_t ind_offset =3D routes->adapter.ind_offset;
> =20
> +    if (!kvm_gsi_routing_enabled()) {
> +        return -ENOSYS;
> +    }

As you wrote, this check is not really necessary since it is already
done in  kvm_irqchip_add_adapter_route() ...

>      for (i =3D 0; i < routes->num_routes; i++) {
>          ret =3D kvm_irqchip_add_adapter_route(kvm_state, &routes->adapte=
r);
>          if (ret < 0) {

... so I wonder if it would be simply best to set

               routes->gsi[i] =3D -1;

before the "goto" instead to make sure that
kvm_s390_release_adapter_routes() does not try to clean it up? That
would also fix a potential crash in case kvm_irqchip_add_adapter_route()
returned an error code in case of a different problem, I think.

 Thomas


> @@ -358,6 +362,10 @@ static void kvm_s390_release_adapter_routes(S390FLIC=
State *fs,
>  {
>      int i;
> =20
> +    if (!kvm_gsi_routing_enabled()) {
> +        return;
> +    }
> +
>      for (i =3D 0; i < routes->num_routes; i++) {
>          if (routes->gsi[i] >=3D 0) {
>              kvm_irqchip_release_virq(kvm_state, routes->gsi[i]);
>=20


