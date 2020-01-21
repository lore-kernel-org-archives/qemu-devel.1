Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B037C22525
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1DMbo9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B037C22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itwNt-0005rY-MT
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:28:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1itwMv-0004ra-1E
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:27:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1itwMt-0002qg-UN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:27:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1itwMt-0002q6-Ou
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579624027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RIqvn8oRIZbVb1irFfRffMSo3LiysIOQPbexMDEbxyA=;
 b=Z1DMbo9MDzCwBLgRXqdlXLlUNHhGZEeTro1DbREMXX8PUtPKxDMF+/rZveW4h41Lp5VA9T
 jUAhE7v5RCM0lEQgiRo+XPMv8VZMJfqRZXW+R7xDLnV1Gt0Fn/cyrJvHujVWQWoMkuYuO6
 pk1bV3GrbVb734LgHC2oeP3DkvqnO4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-U_v7XSYUP--KZw6GVPmWbA-1; Tue, 21 Jan 2020 11:27:04 -0500
X-MC-Unique: U_v7XSYUP--KZw6GVPmWbA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFE0A18B5F6C;
 Tue, 21 Jan 2020 16:27:03 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4D5248;
 Tue, 21 Jan 2020 16:27:00 +0000 (UTC)
Date: Tue, 21 Jan 2020 16:26:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Bulekov, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v7 01/20] softmmu: split off vl.c:main() into main.c
Message-ID: <20200121162659.GF641751@stefanha-x1.localdomain>
References: <20200120055410.22322-1-alxndr@bu.edu>
 <20200120055410.22322-2-alxndr@bu.edu>
MIME-Version: 1.0
In-Reply-To: <20200120055410.22322-2-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 05:54:38AM +0000, Bulekov, Alexander wrote:
> @@ -3813,7 +3794,7 @@ int main(int argc, char **argv, char **envp)
>      set_memory_options(&ram_slots, &maxram_size, machine_class);
> =20
>      os_daemonize();
> -    rcu_disable_atfork();
> +    /* rcu_disable_atfork(); */

In response to my question about this you said:

"Yes, though obviously it didn't make it into v6 :) I'm planning to just
check qtest_enabled(), since for now we are always using qtest."

Please resolve this in v8.

Lines shouldn't be commented out, especially not without an explanation
in the comments.

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4nJlMACgkQnKSrs4Gr
c8hwiwf/YBOHYQp9C5yOnTRtJEcqx5Thfz/WYR0grjH9LTLPErGbuQE0jcMQNr2u
Do3OKQu+sM3U5PTBMJ11uIofjIJioP6PotbGQzWEZuILRaiCJy1jiC7M6CkFm6Ts
lJTcUgLqoC41ypBA6KfTpuOGf9UROAuND7HA03aSfldSKkBIe9M5XobJNbzSz/sd
5md/aH2jhi7Hw+JeG0vbiSmiF/Ld17/J1uoUjIEyeZVzMomvMVT4OWL2j17R3VQX
hu94dti1pXlkhUeAFHWgVDvoKgO2ciw9+Ri6yTb1xXBzAys7V0m/9El4DOluzZvx
gYO1VzqWjAER492C0jSQkI/irdYhnQ==
=+NDy
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--


