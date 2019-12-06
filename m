Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2550C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:15:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A87C24677
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9XppBsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A87C24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEOF-0000gN-5O
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1idEIU-0003PG-Ex
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1idEIT-0001y1-31
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41052
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1idEIS-0001wn-TN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fhFDF3hw0ekT6e8+tJ3KjLJrVHu7tSnx7yxOIERiLNs=;
 b=h9XppBsY7DwSyKnNdSow8/EaDrsG2wPg72JVybB5xT+cOPRYjHV/XfjFWwIfJuAqo2xs3Y
 UAvssj9y3254Nfr1tfQigp3oJ776hwdtjGAEjndVQGfMdDP3X/QSAuCZRDYTOXa4sz73TO
 FrFD5Wcg4HzmBfD4p4TJMIkKoVXt9wE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-rNBXJXfuPSi2IjCtrRwriQ-1; Fri, 06 Dec 2019 04:08:38 -0500
X-MC-Unique: rNBXJXfuPSi2IjCtrRwriQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9D5B1005514;
 Fri,  6 Dec 2019 09:08:36 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B503A6B8D5;
 Fri,  6 Dec 2019 09:08:32 +0000 (UTC)
Date: Fri, 6 Dec 2019 10:08:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 06/13] s390x: protvirt: KVM intercept changes
Message-ID: <20191206100821.06b933e8.cohuck@redhat.com>
In-Reply-To: <c7490fc2-e706-bf51-9979-559a90c65f6c@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-7-frankja@linux.ibm.com>
 <20191205181532.46bee55c.cohuck@redhat.com>
 <3cdbba69-c465-f2ce-d3e4-15e0b8d1218e@linux.ibm.com>
 <20191205184637.4e6f4d23.cohuck@redhat.com>
 <bc5eb50d-1647-f40a-73b6-53be5445fd85@linux.ibm.com>
 <20191206092913.3af251dd.cohuck@redhat.com>
 <c7490fc2-e706-bf51-9979-559a90c65f6c@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/ldhRrfeWzO=Q3lKU9kBnY9q";
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

--Sig_/ldhRrfeWzO=Q3lKU9kBnY9q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2019 09:45:41 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 12/6/19 9:29 AM, Cornelia Huck wrote:
> > On Fri, 6 Dec 2019 08:44:52 +0100
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> On 12/5/19 6:46 PM, Cornelia Huck wrote: =20
> >>> On Thu, 5 Dec 2019 18:34:32 +0100
> >>> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>>    =20
> >>>> On 12/5/19 6:15 PM, Cornelia Huck wrote:   =20
> >>>>> On Fri, 29 Nov 2019 04:48:02 -0500
> >>>>> Janosch Frank <frankja@linux.ibm.com> wrote:
> >>>>>      =20
> >>>>>> Secure guests no longer intercept with code 4 for an instruction
> >>>>>> interception. Instead they have codes 104 and 108 for secure
> >>>>>> instruction interception and secure instruction notification
> >>>>>> respectively.
> >>>>>>
> >>>>>> The 104 mirrors the 4 interception.
> >>>>>>
> >>>>>> The 108 is a notification interception to let KVM and QEMU know th=
at
> >>>>>> something changed and we need to update tracking information or
> >>>>>> perform specific tasks. It's currently taken for the following
> >>>>>> instructions:
> >>>>>>
> >>>>>> * stpx (To inform about the changed prefix location)
> >>>>>> * sclp (On incorrect SCCB values, so we can inject a IRQ)
> >>>>>> * sigp (All but "stop and store status")
> >>>>>> * diag308 (Subcodes 0/1)
> >>>>>>
> >>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >>>>>> ---
> >>>>>>  target/s390x/kvm.c | 6 ++++++
> >>>>>>  1 file changed, 6 insertions(+)
> >>>>>>   =20
> >>>    =20
> >>>>>> @@ -1664,6 +1668,8 @@ static int handle_intercept(S390CPU *cpu)
> >>>>>>              (long)cs->kvm_run->psw_addr);
> >>>>>>      switch (icpt_code) {
> >>>>>>          case ICPT_INSTRUCTION:
> >>>>>> +        case ICPT_PV_INSTR:
> >>>>>> +        case ICPT_PV_INSTR_NOTIFICATION:
> >>>>>>              r =3D handle_instruction(cpu, run);     =20
> >>>>>
> >>>>> I'm still a bit uneasy about going through the same path for both 1=
04
> >>>>> and 108. How does the handler figure out whether it should emulate =
an
> >>>>> instruction, or just process a notification? Is it guaranteed that =
a
> >>>>> given instruction is always showing up as either a 104 or a 108, so
> >>>>> that the handler can check the pv state?     =20
> >>>>
> >>>> diag 308 subcode 0/1 are 108, but all other subcodes are defined as =
a
> >>>> 104 (if they are an exit at all)...   =20
> >>>
> >>> I think that's a reason to really split 108 from 4/104, or at least a=
dd
> >>> an parameter...   =20
> >>
> >> And still call the diag 308 handler or have separate handlers? =20
> >=20
> > I'd probably split it into a "normal" one and one for pv special
> > handling... does that make sense?
> >  =20
> IMHO: not really
> We still need to do ipa/ipb parsing for both paths, which will result in
> code duplication. Looking at diag308 subcode 4, we would have a code 4
> one which just does the device resets and reboots and one which does all
> that, plus the teardown of the protected guest.
>=20
> I tried to inline as much as possible to have as little changes as
> possible. Notable exception is sclp, which has more checks than
> emulation code...

Fair enough.

But taking a step back: What's the purpose of the new exits, then?
IIUC, we have the following cases:

- code 4: normal guest, nothing special
- code 104: protected guest, emulate the instruction
- code 108: protected guest, notification for the instruction

The backend code can figure out what to do simply by checking whether
the guest is protected or not (as whatever needs to be done is simply
determined by that anyway).

Are we overlooking something? Or is the information contained in the
different exits simply redundant?

--Sig_/ldhRrfeWzO=Q3lKU9kBnY9q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3qGoUACgkQ3s9rk8bw
L68Xmg/9Etl6Exn8d63S/Ec6NC5FnME1i25KVrLvYr9oamtE+9k24lax58quIesg
uqXei7bXKJU9z8+ht9NAAXNHqNSZlgzhZKqA7sM4DNzsCJ9XlUfxygQd9vEN3m31
qMfBGANhm1pJmbsq/9omEb+H2KhbyEYDPozet6oCa1r8gRtpkFSVutpRhyfgHr1R
7mJEmGwwaA+7L5QAud6X/07sg8j7/p7CaSzUslVc63iL9jteWpbPQK312P1aCCgj
D4kghIxBOVun+QuSW3zI356Nl8zKVESGujrfysLeOF3mbBiNJM6BmPeBpRaT0Xtd
UvfI+inatQyupdazPsX4HD/4xoUeqHcRtpmUecZfid0nWC42ZnfMOSaHxk0oiUik
IaeLrqTXdXRYcOqEBsWHmgvYc/3lwv04FWxwjoIcIXJqKEYlN57YBGijxtxJKCdm
MTPCgGgv8vlipGWxzMw/4412mpKOb38ozylTYN+s/Dld2JwOy0fUnlwS50CtKZAD
uCKHJbxPyfrDhek/+FcyQLTIDxjHdWmCvY4Oj7+bmvO3NRudleh/A3ftCYAQtQj3
0M43iz0z9RPMLTQwczveqU56vHBo+GGNGJGMjFCJGuKO5YUEZT8GqV+Xxlk1ecMb
FnmbuL5RCoSGFSGhecbhTopMijFjtv63XH64Vq9IB30BuBUimhM=
=BmD2
-----END PGP SIGNATURE-----

--Sig_/ldhRrfeWzO=Q3lKU9kBnY9q--


