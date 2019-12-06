Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F54CC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A575206C3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAw40+MU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A575206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFPY-0004iv-On
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1idEeZ-00021q-70
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1idEeX-0007xw-Tz
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1idEeV-0007tP-S0
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdM0/clrngtCdjTfFct9BH5736Cv3YIQ9HaUbJP4ixo=;
 b=fAw40+MUwZKV1mZ3p/PY3h9xx97K1EcDMTXukkDiMYevZugcRuMX/BMH/uhFzM2HAaD4hb
 CRXORD/5z3NCIqBDqHoyP8aoRAi4VOtoMfXQXTUagtY3oDgj1oniV8UH602On2ynzMADfk
 IY7R6JoB6MlYS2PqJ9Xuz4rU6UWQfCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-9JzSBnOCM5ehmEsYcNWePw-1; Fri, 06 Dec 2019 03:29:30 -0500
X-MC-Unique: 9JzSBnOCM5ehmEsYcNWePw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E60107ACC7;
 Fri,  6 Dec 2019 08:29:28 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B77C25D9C9;
 Fri,  6 Dec 2019 08:29:24 +0000 (UTC)
Date: Fri, 6 Dec 2019 09:29:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
Message-ID: <20191206092913.3af251dd.cohuck@redhat.com>
In-Reply-To: <bc5eb50d-1647-f40a-73b6-53be5445fd85@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
 <20191205181532.46bee55c.cohuck@redhat.com>
 <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
 <20191205184637.4e6f4d23.cohuck@redhat.com>
 <bc5eb50d-1647-f40a-73b6-53be5445fd85@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/GnMCouvjfL_nGKWxvpxra3Y";
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

--Sig_/GnMCouvjfL_nGKWxvpxra3Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2019 08:44:52 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 12/5/19 6:46 PM, Cornelia Huck wrote:
> > On Thu, 5 Dec 2019 18:34:32 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> On 12/5/19 6:15 PM, Cornelia Huck wrote: =20
> >>> On Fri, 29 Nov 2019 04:48:02 -0500
> >>> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>>    =20
> >>>> Secure guests no longer intercept with code 4 for an instruction
> >>>> interception. Instead they have codes 104 and 108 for secure
> >>>> instruction interception and secure instruction notification
> >>>> respectively.
> >>>>
> >>>> The 104 mirrors the 4 interception.
> >>>>
> >>>> The 108 is a notification interception to let KVM and QEMU know that
> >>>> something changed and we need to update tracking information or
> >>>> perform specific tasks. It's currently taken for the following
> >>>> instructions:
> >>>>
> >>>> * stpx (To inform about the changed prefix location)
> >>>> * sclp (On incorrect SCCB values, so we can inject a IRQ)
> >>>> * sigp (All but "stop and store status")
> >>>> * diag308 (Subcodes 0/1)
> >>>>
> >>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>> ---
> >>>>  target/s390x/kvm.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>> =20
> >  =20
> >>>> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
> >>>>              (long)cs->kvm_run->psw_addr);
> >>>>      switch (icpt_code) {
> >>>>          case ICPT_INSTRUCTION:
> >>>> +        case ICPT_PV_INSTR:
> >>>> +        case ICPT_PV_INSTR_NOTIFICATION:
> >>>>              r =3D handle_instruction(cpu, run);   =20
> >>>
> >>> I'm still a bit uneasy about going through the same path for both 104
> >>> and 108. How does the handler figure out whether it should emulate an
> >>> instruction, or just process a notification? Is it guaranteed that a
> >>> given instruction is always showing up as either a 104 or a 108, so
> >>> that the handler can check the pv state?   =20
> >>
> >> diag 308 subcode 0/1 are 108, but all other subcodes are defined as a
> >> 104 (if they are an exit at all)... =20
> >=20
> > I think that's a reason to really split 108 from 4/104, or at least add
> > an parameter... =20
>=20
> And still call the diag 308 handler or have separate handlers?

I'd probably split it into a "normal" one and one for pv special
handling... does that make sense?

--Sig_/GnMCouvjfL_nGKWxvpxra3Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3qEVkACgkQ3s9rk8bw
L69new//aaXr5qFiRr2CHdB3/qZ9Nch3T/pDwLTz42/TCIR2R5xz84PHCoIYQFVi
MbGvubJVSINVZo7VuGoRcO/Dwe3H/W9DWlwtjQyX4UoOYnyNd5HT3SDbxQUQoax8
hnwq0zxcNQhxNYgpQQ0CbmvZmAueHDnM/Ur+DSBoSueJ4a8Rn3o7ZEg/s/r4JTWd
JhXkCyEibAB3+TfeDHKy7IiVPMmF6KNaTq0hE9AZvvn7Xwt+SqMpbkV94VgftACe
nYq4K7OuahTwsBMkqRVlwS5G3z31hqwRV1wnvWrq0W76uA7R8qwQXYq6ELjjxRyO
7XIT3oOd+asB22IBIiLafd0hseGTXaPIlmy+rKmiZBKZ8OTlG+9aYp6DKuLlgJYN
0c5tnE3W6a9fkcHLcBAw1giLZIT9eJiS4+JwYBCobegYyRodvH83ddYGpVq44M03
oKs9RwMlOpSUqkHuvTj3pOGwGG2oS8cmXNX7q4KAKHMTOljVkN2OPDu5bqP9dTgu
0vmnh1BA4gz1BkiTA+EQG6wJGmKDqMozxiUXhnkF8AtPUi3+G6y66AkOphe+X1/5
JiThZo2RIo9KEd0YJDamKzeWJooY8oPmgsqrIgg/rkkl5Gc5WOgDB5wz7mEf9G2B
Coh+WYfDxyY+gk4HCTDvIUMKl70/mE2LZs3fb5KtgbxykByNeP4=
=XUcx
-----END PGP SIGNATURE-----

--Sig_/GnMCouvjfL_nGKWxvpxra3Y--


