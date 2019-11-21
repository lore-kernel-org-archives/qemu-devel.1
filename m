Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91588C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B93E20731
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ3iz71k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B93E20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlRl-0001TC-Bc
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:20:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iXlQR-0008Qj-7J
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iXlQQ-00083p-2f
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23538
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iXlQP-00083d-UV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574338745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJQ6UkowTx5uD+VVfLU3qbhgFPuuR0XKDVQR78mPCno=;
 b=ZQ3iz71kXzt74C3I/EFGHf2efvgFAWrMoyT8XAZ6kIeo4JzNWrrXbjbz3X+LE1ZGil0g1t
 uy/ABp9ha5+h1U3U/hS42Lv/XHs2Y4gs27UQaXebejRdM9qwRyVqNYUTf7S5S3LAF1lPYf
 kyIqNjuzvoWyBmWrYjBBwEHMS1hglYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-4Ac0_gseOOm897NqBPZHVw-1; Thu, 21 Nov 2019 07:19:01 -0500
X-MC-Unique: 4Ac0_gseOOm897NqBPZHVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B9F800A02;
 Thu, 21 Nov 2019 12:19:00 +0000 (UTC)
Received: from gondolin (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2D675379E;
 Thu, 21 Nov 2019 12:18:56 +0000 (UTC)
Date: Thu, 21 Nov 2019 13:18:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 01/15] s390x: Cleanup cpu resets
Message-ID: <20191121131845.3bca7940.cohuck@redhat.com>
In-Reply-To: <bdb52fc3-ce58-4e71-f17d-8f5117f110f9@linux.ibm.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-2-frankja@linux.ibm.com>
 <20191121121055.40968340.cohuck@redhat.com>
 <bdb52fc3-ce58-4e71-f17d-8f5117f110f9@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/MYDu6XhlkOv/hkn6ntGJF3U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/MYDu6XhlkOv/hkn6ntGJF3U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Nov 2019 12:32:38 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/21/19 12:10 PM, Cornelia Huck wrote:
> > On Wed, 20 Nov 2019 06:43:20 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Let's move the resets into one function and switch by type, so we can
> >> use fallthroughs for shared reset actions. =20
> >=20
> > Doing that makes sense.
> >  =20
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c |   3 +
> >>  target/s390x/cpu.c         | 111 ++++++++++++++++--------------------=
-
> >>  2 files changed, 52 insertions(+), 62 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index d3edeef0ad..c1d1440272 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -348,6 +348,9 @@ static void s390_machine_reset(MachineState *machi=
ne)
> >>          break;
> >>      case S390_RESET_LOAD_NORMAL:
> >>          CPU_FOREACH(t) {
> >> +            if (t =3D=3D cs) {
> >> +                continue;
> >> +            } =20
> >=20
> > Hm, why is this needed now? =20
>=20
> The Ultravisor checks which reset is done to which cpu.
> So blindly resetting the calling cpu with a normal reset to then do a
> clear/initial reset will return an error.

Let's split this change out, then? The rest of the patch is a simple
refactoring.

--Sig_/MYDu6XhlkOv/hkn6ntGJF3U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3WgKUACgkQ3s9rk8bw
L692zhAArMLW/5BJON/f/Y1oDAiPmBMRYRaXo7p08AKgPIFGXIWSmkoPjyz635R/
MH8zUY1jsraqKFsJP886XX+Aka3ickg8DhqLJmpD7WBbnc7v0iRZg+jFouziQG3n
J9jeafXq2OEchMGA1F/NeD9Y4ZOHSumt0I1Y1Mf4YbjaL48O9egkUXCaggUFhN4A
vUaBz5ZYUbfxvsECkPTckxW+MkpodQhITWTln5A2CkEuyEbVNTX869OdpuZ9d0y7
cLbrLhIV8A8YrEfQr9T4f5h/MPkXqI7NCFsDueGTF/HNOdC3+4ZD/F1L48O1/ZSy
1bml/MNH03Tu+KBOVuhTGERUFDLNpy6AqX0IS9DQ17d0tZqIpcIaLI4r5AxMJ5Lb
JwLk2gF7c42InAsbemQjxo5q/wCtDa9JVcQ/ovmLtBc3o+pQRXCIX1zyvVs9XUEz
pJDrHkJ/rBd+4WU9kd6ZwCXT5nZclsPHMsLgRp6js5w+1OLMxjo1TK488Kee8qjQ
1sFNl2PZVqXMcPThquHqhrC3hLEVeJp+fMpwAeJIpB8SzxKYCzXs+nQJpYCFSl2q
fb/jDVpiK0QHL5q28SVD9tkmNGwDGSveO1xruNp5dxSxmNL0e7f0kau6KEtj2w/g
NncdEAJ4fnT2mWlb+5K8EArysDBtBsohfq6VWtXX9ngju4JiiWY=
=y75t
-----END PGP SIGNATURE-----

--Sig_/MYDu6XhlkOv/hkn6ntGJF3U--


