Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46186C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8730D222E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijSIQVrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8730D222E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUS3Z-0001SI-Fs
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 06:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUS2c-0000hE-CW
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kUS2a-0004S1-GH
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 06:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603101919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iAdKFXre24TsTZFLKYEkMw1Xlij12OoP39+MEp19Jpk=;
 b=ijSIQVrNVxLLPzxYNdmnqUynyQ1xRmX0g1oqVC7y0FeaSL72nje3iqqSHODmOADVUqAlxj
 gkPRcsGKUc3I5uscn6T76mojHq4tdO7jLuM51uoQ2ephtfxHghpRztSeA5Q8kacJaDga9J
 7u8lGKVinW3VvkSH7HCM4z8oSRoe9zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-otTSXXdgMzeYtrE2bJqRyw-1; Mon, 19 Oct 2020 06:05:15 -0400
X-MC-Unique: otTSXXdgMzeYtrE2bJqRyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53BEC87951F;
 Mon, 19 Oct 2020 10:05:14 +0000 (UTC)
Received: from localhost (ovpn-115-27.ams2.redhat.com [10.36.115.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F14556198C;
 Mon, 19 Oct 2020 10:05:13 +0000 (UTC)
Date: Mon, 19 Oct 2020 11:05:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Afanasova <eafanasova@gmail.com>
Subject: Re: [PATCH] accel/kvm: add PIO ioeventfds only in case
 kvm_eventfds_allowed is true
Message-ID: <20201019100512.GA83062@stefanha-x1.localdomain>
References: <20201017210102.26036-1-eafanasova@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201017210102.26036-1-eafanasova@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2020 at 02:01:01PM -0700, Elena Afanasova wrote:
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> ---
>  accel/kvm/kvm-all.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Additional information for the commit description:

  MMIO eventfd_add/del are only registered when kvm_eventfds_allowed is
  true but for PIO they are registered unconditionally. This is a bug
  because kvm.ko ioeventfd should not be used if kvm_eventfds_allowed is
  false.

  This issue is a latent bug because ioeventfd is usually available when
  KVM is enabled.

>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9ef5daf4c5..baaa54249d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2239,8 +2239,10 @@ static int kvm_init(MachineState *ms)
> =20
>      kvm_memory_listener_register(s, &s->memory_listener,
>                                   &address_space_memory, 0);
> -    memory_listener_register(&kvm_io_listener,
> -                             &address_space_io);
> +    if (kvm_eventfds_allowed) {
> +        memory_listener_register(&kvm_io_listener,
> +                                 &address_space_io);
> +    }
>      memory_listener_register(&kvm_coalesced_pio_listener,
>                               &address_space_io);
> =20
> --=20
> 2.25.1
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+NZNcACgkQnKSrs4Gr
c8jk7wf/XcM3Wq9dPRNOODvdlY9GML2w0y+mpuPwoEv+iY9G29FuzEdoS/ASRHOa
4JWef+AFBNG7Q1L51uu3BMt06LB3Z0hJoCMgABJOnXV41gxB2RYpQdxJQXTsrYCp
02OkJhkQvMWlVgQp5MAfn7mZKQR1tjun7WEUZ6WDC8FI46eFGQQho+R6f8DSQdB+
ucLtZm0w/CtHuTTERrpFR1G8kB6fmJkveFQutFtlrqJLJkfHMfsyYEBNciYq7Tl4
EPwjvCkSp+RxWH+WDiJctoTwFfM7iet4oiM0NEoNTH/wPVg2kxKt6iXX5sE2lgVB
e1iA9xn5YLjc3qv33/pyKst4pEQGJA==
=/kMV
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


