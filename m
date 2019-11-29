Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB4DC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978C3215F1
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 09:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkZDZLHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978C3215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iacF6-0003xo-Kh
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 04:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iacAb-0002ap-8y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iacAO-0005K1-2h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:02:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iacAN-0005CI-Fk
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 04:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575018138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=guDMH0NaPZqDk2jpXf1dCrsyfcgH+cI0XUterk1YwvA=;
 b=YkZDZLHAeLU07zGK2WECGVWXB0u4KbNZsfSS5dBIPaHh8c7+gyYSXm23EesrqEnIzPMmKS
 m4Zc2aUwzhVqVwvIOwyxN3ymlGXJZFe5M8VtFuKSEWd8QcSZZlUXMk/TltW2n6C4g8WQPx
 +X18q5OuAvRxignDHh7vxAc+52buGNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-kpPTuW_OPQ66wY8Kcq8ZJg-1; Fri, 29 Nov 2019 04:02:14 -0500
X-MC-Unique: kpPTuW_OPQ66wY8Kcq8ZJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 214DE10054E3;
 Fri, 29 Nov 2019 09:02:13 +0000 (UTC)
Received: from gondolin (ovpn-116-140.ams2.redhat.com [10.36.116.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 800C4608FD;
 Fri, 29 Nov 2019 09:02:08 +0000 (UTC)
Date: Fri, 29 Nov 2019 10:01:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] s390x: kvm: Make kvm_sclp_service_call void
Message-ID: <20191129100155.331ae2f0.cohuck@redhat.com>
In-Reply-To: <346131a4-4dfe-897c-0ddd-a81f8f3f4d6f@linux.ibm.com>
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-7-frankja@linux.ibm.com>
 <c3b81ef7-860d-8cee-df34-0c6f103a1757@redhat.com>
 <76627b69-5c0a-a9d6-f20e-f7ce61858774@linux.ibm.com>
 <452fc85c-17b7-76d3-8ed8-fb76d50b37a6@linux.ibm.com>
 <20191128183409.4a91ea1c.cohuck@redhat.com>
 <346131a4-4dfe-897c-0ddd-a81f8f3f4d6f@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/LCzTfL/5s+AaeWNyj3+3=4E";
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

--Sig_/LCzTfL/5s+AaeWNyj3+3=4E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Nov 2019 09:16:21 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/28/19 6:34 PM, Cornelia Huck wrote:
> > On Wed, 27 Nov 2019 19:38:06 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> On 11/27/19 7:25 PM, Janosch Frank wrote: =20
> >>>
> >>> There's 0 (initiated), busy and operational and as far as I know we
> >>> implement neither.   =20
> >>
> >> That came out wrong...
> >> s/operational/not operational/
> >>
> >> We only implement "command initiated" / cc =3D 0
> >> We can never have busy, because we handle sclp calls synchronously.
> >> The spec does not give any indication when we could return "not
> >> operational". I guess that's just a free pass for hypervisors. =20
> >=20
> > Regardless, setcc(cpu, r) also feels a bit cleaner to me... =20
>=20
> Ok, do you want to change that while picking the patches up or shall I
> send a new version?

New version (of this patch), please :) Easier for me...

--Sig_/LCzTfL/5s+AaeWNyj3+3=4E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3g3oMACgkQ3s9rk8bw
L68OeQ//QFWqJ2L2NtTeMssvPVkIKLWW1zpXIyilTKOWv8l9ClFKa3NdRQadfgBR
q4KKDQyw894v99kQt5jEJXnnMT7lC8IGNeymWHJzXlF830EhWmVXDprWjucb7kPC
OvnkTSv01tYoUK1nBJQwMgv4gTzA4b2uYiWSdvP2S4UrwY8oNvw5XecQB9lx2j3F
npIq8/gZUvGqUBgfzZW5kJqdzSrR81hOXrmCjYTxfteM30Dl+x6IORMqyyyVEEx8
OYHX3rWe7ciWfGt1n+slM4y+vTk7ZZThWn2kj4JFDR56auHuwwveSWXXNrGMEZuM
n0KmRfj+J7x8FHN0Q4FNx5CGLqIFT/LLnulylayDING+8fz2F0NdRIdeDKY4/Bow
BnWUNMC7svd1SHU5IQP74qOCgjUDvBIPadZYtBJpd9qxO4rn0x2no4T39FkpQLkC
/YXMWAMY5K0he1SCpHx0W1Nq0513Bl8vB58mXjK1EpGp7/SH3UPGTVJ8meg4KlO8
Re/wuHs1Qvzu1lh3KYCw0+8GCnXL8bgKKqLhO1LOX/WfAHiW6xUG/rVT5SAGEADx
Axh7YbFqK3f6XuzN750dbyCUsqJfkMl1x9fY53oQOfz5EVwWjaD6yA6HmnzObfOg
JK8EXMPqsp+FExobPGCpIbNKSFex2eEocqbArRQNi7m1e71yUew=
=oy8J
-----END PGP SIGNATURE-----

--Sig_/LCzTfL/5s+AaeWNyj3+3=4E--


