Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B30C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:00:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DF6217AB
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 12:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmp8CQ47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DF6217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57847 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaewM-0000St-Le
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 07:00:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaef9-0006sC-TT
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaef2-0000rw-9B
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:42:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57058
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaef2-0000gD-3b
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 06:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575027726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kmZVuKEFiONgUFEeMlmk46DxyuEvOn8n4lTM36ThZdA=;
 b=Pmp8CQ47l7EkHOouowb9DFB6ygUgOT76WEU7wfnrnw1YREr1KIDglIAOxMpcY+6F4ZVZIQ
 T1oXozr4W64Ae6Nu4Lmg/vcRvUv0Q4B2GsMvv0YOdYGPMkNC8jjVxJ/oWqxJWQp5kGzspX
 6UaksbHCm6aOjejMbtYtKIRduKMOZRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-LQlLx7BYN2aJyJirqzA6nA-1; Fri, 29 Nov 2019 06:42:03 -0500
X-MC-Unique: LQlLx7BYN2aJyJirqzA6nA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C61C61800D42;
 Fri, 29 Nov 2019 11:42:01 +0000 (UTC)
Received: from gondolin (ovpn-116-140.ams2.redhat.com [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BFC25D9E1;
 Fri, 29 Nov 2019 11:41:55 +0000 (UTC)
Date: Fri, 29 Nov 2019 12:41:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
Message-ID: <20191129124140.5f2e7d59.cohuck@redhat.com>
In-Reply-To: <46d14db9-f7cc-adce-df1c-d35cd26dc546@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-2-frankja@linux.ibm.com>
 <d12fe27e-fcce-1704-8ac3-5dca18627422@redhat.com>
 <46d14db9-f7cc-adce-df1c-d35cd26dc546@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/36xmoFmHr8fWMKGpbfJB/A7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/36xmoFmHr8fWMKGpbfJB/A7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Nov 2019 12:18:56 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/29/19 11:09 AM, David Hildenbrand wrote:

> >> @@ -94,6 +115,7 @@ enum s390_reset {
> >>      S390_RESET_REIPL,
> >>      S390_RESET_MODIFIED_CLEAR,
> >>      S390_RESET_LOAD_NORMAL,
> >> +    S390_RESET_PV, =20
> >=20
> > I do wonder if that should be called S390_RESET_PV_START =20
>=20
> I have no strong feelings for the name, whatever floats you boat(s)

PVY_MC_PVFACE?

But seriously speaking, I'd also prefer S390_RESET_PV_START.

--Sig_/36xmoFmHr8fWMKGpbfJB/A7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3hA/QACgkQ3s9rk8bw
L6/mJRAAlkXp+fNPteWY51QePojOEknL4C+Dl9mzA9coLHZB74Hj2+ORXEANx0Le
5L2377LqeoScm0ZDsyyAD1+EBDVC/KOjYiw9s4rDbuOk/mWyAjilXwz4GYgCs5BF
hN7PWL1k3bZJ8PO4LAQzRLLrYfLIvl61PIHP5ppODD0p4juoOrsdfFCSDRnAvnL3
Hfn1FP2+FTk1su9ict/3TXTn4vywDJYLHW6kuhh1JFuv/zIryEac0w6uHp9C2IcP
m//dwjBdU38ueS6mVPrfoRGmUAMNBfS8yrx8UB+LFxqw/wMLZrqi/26KaZ9fjUiO
yS16n01cX+ZF35vc/F+12Snjj3GxN/tqDt/3yQNbC7y3raX1SkA8Q2VeVQEww6iF
e6eWjP4ooenf23hbhxOSEPySGuXrSOAZLnNLuMHqgob766lujalxfWvBrL4ZavMa
1yKL2oOKI150aTOF0SvWYenGK45ahvoZh38tTpQr18QCMhvOwQN4ye67wAMW1JtO
WD3hvyuIIupif7yTHF0+3pYq43VlGbaMKT1firwtGPsTlQTrUEQv61c/7d2jytJk
rIHt9jXUFxqrBVdeFxrl18mDC3QOIf45dRJZfiD7xP8MtzTASp9rYiF8CWETB5JZ
o8tS88g0EvujDBKbiIoiF8K0EiF4sYxqtyat7/l18OEA6sR+ktM=
=XpF8
-----END PGP SIGNATURE-----

--Sig_/36xmoFmHr8fWMKGpbfJB/A7--


