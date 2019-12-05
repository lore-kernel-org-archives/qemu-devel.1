Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C679BC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9521421823
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAapc3Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9521421823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvQJ-0005ka-Ft
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1icvDV-0007wd-R9
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1icvDU-0004Xw-Gh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25966
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1icvDU-0004TP-6l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 12:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575568023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nDcbxzbOMA4nf42c5ZWc09yQqLCECm9H7b9z/f14cUY=;
 b=AAapc3HpKMIwQWkm5aP2sRPswo/t4jAKc9c3Kp+UX404sifpbo8rBphyGlmFTSjFjmlmvU
 iZXo7bCtwGFVzHI6yJJNE+OrkLKjjIZxa+WwZszvle9vP11FjGuhVaCVTlNv/eez6KKGgo
 cMlZpOI0mabtIUW31lw9AreNvic7LsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-f6jDHjppOY-mqln1pcXhFA-1; Thu, 05 Dec 2019 12:46:59 -0500
X-MC-Unique: f6jDHjppOY-mqln1pcXhFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A80D800D5E;
 Thu,  5 Dec 2019 17:46:54 +0000 (UTC)
Received: from gondolin (unknown [10.36.118.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27FCC19488;
 Thu,  5 Dec 2019 17:46:49 +0000 (UTC)
Date: Thu, 5 Dec 2019 18:46:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
Message-ID: <20191205184637.4e6f4d23.cohuck@redhat.com>
In-Reply-To: <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
 <20191205181532.46bee55c.cohuck@redhat.com>
 <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/9l.JmnWFa2O_0vpL1tJqkQM";
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/9l.JmnWFa2O_0vpL1tJqkQM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Dec 2019 18:34:32 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 12/5/19 6:15 PM, Cornelia Huck wrote:
> > On Fri, 29 Nov 2019 04:48:02 -0500
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Secure guests no longer intercept with code 4 for an instruction
> >> interception. Instead they have codes 104 and 108 for secure
> >> instruction interception and secure instruction notification
> >> respectively.
> >>
> >> The 104 mirrors the 4 interception.
> >>
> >> The 108 is a notification interception to let KVM and QEMU know that
> >> something changed and we need to update tracking information or
> >> perform specific tasks. It's currently taken for the following
> >> instructions:
> >>
> >> * stpx (To inform about the changed prefix location)
> >> * sclp (On incorrect SCCB values, so we can inject a IRQ)
> >> * sigp (All but "stop and store status")
> >> * diag308 (Subcodes 0/1)
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  target/s390x/kvm.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>

> >> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
> >>              (long)cs->kvm_run->psw_addr);
> >>      switch (icpt_code) {
> >>          case ICPT_INSTRUCTION:
> >> +        case ICPT_PV_INSTR:
> >> +        case ICPT_PV_INSTR_NOTIFICATION:
> >>              r =3D handle_instruction(cpu, run); =20
> >=20
> > I'm still a bit uneasy about going through the same path for both 104
> > and 108. How does the handler figure out whether it should emulate an
> > instruction, or just process a notification? Is it guaranteed that a
> > given instruction is always showing up as either a 104 or a 108, so
> > that the handler can check the pv state? =20
>=20
> diag 308 subcode 0/1 are 108, but all other subcodes are defined as a
> 104 (if they are an exit at all)...

I think that's a reason to really split 108 from 4/104, or at least add
an parameter...

>=20
> >=20
> > [Even if that works, it still feels a bit unclean to me.]
> >  =20
> >>              break;
> >>          case ICPT_PROGRAM: =20
> >=20
> >  =20
>=20
>=20


--Sig_/9l.JmnWFa2O_0vpL1tJqkQM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3pQn0ACgkQ3s9rk8bw
L6+LNg/8DgmYj+mH0adbQFGcPj919e6QXab5X2igRtyBrhya8qEFICrAkXV74Lh9
hgvvTH5oi24De5kXvJSXXUmcRLVzD0Xc8g2aMQDd56QPPTVpj+NgAhpgwIYQ9RY7
L3TOfBrwxXX6eoUkrAXn63WMCEfkRLey7P4MvFyfTXIu/x8csBNP0ET18FkqBNLr
V1uNTXeeltDw6xRxpL2Vj1DmWB/A0k8un5QQeXzW0EIrOl6+jHgo5xq1acGluOVr
L/sEbmaHn5fFn+V3CNY6Rq1XR23BLLv0XDc48zZ/y9yYYAgM2FFD2fOzNQiFHDk3
vcQ1PR4OBeOOr+SJr2pUsObWie9fViKGc+At85OyycXIO3/xq4XnyjdjlAEDyRDX
D1NpTb9SzUiwkIXcDmaKeheW9DtBp1ypZxXVBKS6AqLrXPgpeZ/AEIhkJ7l7G/ya
Eyuw38yE1AouJTTLlvqFZKtj5w9gn0vgl8GgDsp5MMYvINNT8OxgiMGDxlpzh4mg
eLxlMfQL7a65RF2UTzaHS1R+peqT9XvktSWxmYha1J7Rj/vHj5GYA+pIyS/3niR3
ob04pS1JBVYb3oNLCS7BvzWnyrq2c+sxM3bCGNlWb6Nvoajz/OkRZRHGeaj8sumJ
LqrwJZDiPx/zXqHFzN8OAA/vgIMAfhBEAZTSVdvujmLYdm1JWmw=
=D/cJ
-----END PGP SIGNATURE-----

--Sig_/9l.JmnWFa2O_0vpL1tJqkQM--


