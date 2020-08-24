Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12030C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10362074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TW3pNfvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10362074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEOF-0000PJ-2b
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kAENN-0007wA-IV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:27:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39906
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kAENK-00045f-S4
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598282829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cKIyacX1Y1vEDM5g9IGByt/b+KSXgHQgwLQ2hLbqwY=;
 b=TW3pNfvfnwaDl/HIsy8zVRidBVm6BmT1QVF5AfcQMMVQDTT8Ox0ox3IxmEEepuurg2IwkP
 7W34WG3/dOM1EzKbv8Z6AkiFJi1jAfMXvOUMXxXXkjWeaEhyY7aJXudAFeDJTRIyrhMPJE
 7YD/94uVevc9c4qQ1OKS5KzsjqnBJj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-iTWCQIb9Ojq4oYitJjqNrg-1; Mon, 24 Aug 2020 11:27:07 -0400
X-MC-Unique: iTWCQIb9Ojq4oYitJjqNrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7B89800FFF;
 Mon, 24 Aug 2020 15:27:05 +0000 (UTC)
Received: from localhost (ovpn-112-178.ams2.redhat.com [10.36.112.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98A4860C11;
 Mon, 24 Aug 2020 15:27:01 +0000 (UTC)
Date: Mon, 24 Aug 2020 16:26:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: wanghonghao <wanghonghao@bytedance.com>
Subject: Re: [PATCH 1/2] QSLIST: add atomic replace operation
Message-ID: <20200824152659.GA7124@stefanha-x1.localdomain>
References: <20200824043121.13421-1-wanghonghao@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20200824043121.13421-1-wanghonghao@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 08:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 12:31:20PM +0800, wanghonghao wrote:
> Replace a queue with another atomicly. It's useful when we need to transf=
er
> queues between threads.
>=20
> Signed-off-by: wanghonghao <wanghonghao@bytedance.com>
> ---
>  include/qemu/queue.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 456a5b01ee..a3ff544193 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -226,6 +226,10 @@ struct {                                            =
                    \
>          (dest)->slh_first =3D atomic_xchg(&(src)->slh_first, NULL);     =
   \
>  } while (/*CONSTCOND*/0)
> =20
> +#define QSLIST_REPLACE_ATOMIC(dest, src) do {                           =
      \
> +        (src)->slh_first =3D atomic_xchg(&(dest)->slh_first, (src)->slh_=
first); \
> +} while (/*CONSTCOND*/0)

This is atomic for dest but not src.

Maybe the name should make this clear: QSLIST_REPLACE_ATOMIC_DEST().

Please also add a doc comment mentioning that the modification to src is
not atomic.

Stefan

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9D3EEACgkQnKSrs4Gr
c8heswgAjaX93OcnqW+/VCPTErhl3qvTPXFwzxwxRmpsBS2mPq+KTZWpQfGS05KD
dwZjP0RT2et8Dz+MKr3TVazwu8Vfcq5MRe8wypiQ/49ESqRq7bqgHvfvmBgSyhFJ
4rKJXKkxdF4WHMbq7cZw4wSCKUZZWBgrcPgo38ivSv3SHal2Jzfd1IOGJnCVLzEF
y897FhYJg5RAMysogAFKyOGHhDsjjKeydhFyNlaY2zmEv7ncGpCHirbK41UrHEnZ
HjNxUNGem7wQ23msOMRXTRTCkQx4Di9sBN66cBn+EW1eWNcxjOj/ykW8rvJldvW3
3eVDSeL6IW+DoROIc18EONCfwNFsVA==
=nOHN
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--


