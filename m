Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81665CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0D820673
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSZbo1FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0D820673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmar-0004G4-DI
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYmaH-0003kG-5l
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:17:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43100
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jYmaF-0006Fr-MR
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589357862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n/9ndjq8pAL5FqGXhewL1HdHqCbbdY+ZXc+oe+r4I44=;
 b=CSZbo1FJcR+nqOP3/l8nhDSuJdp2bnBO+tCaVo/CH5/toRfwizzveS3TlIm87yBohbKOXR
 gTG+jCbY1Tp8SCk3PuuTWnQSXAtEr/dY7ScrGeLIGrS7+QbwbZNVt8LksOfj4FFVh/uFuo
 o7vfV27vCbUlhN+xoS9AVSi29bUo9fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-TSKn9gn8PgCioJ1Jl-9HLA-1; Wed, 13 May 2020 04:17:00 -0400
X-MC-Unique: TSKn9gn8PgCioJ1Jl-9HLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 599DF8005B7;
 Wed, 13 May 2020 08:16:58 +0000 (UTC)
Received: from gondolin (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1D8391;
 Wed, 13 May 2020 08:16:50 +0000 (UTC)
Date: Wed, 13 May 2020 10:16:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
Message-ID: <20200513101637.2f325838.cohuck@redhat.com>
In-Reply-To: <5ed5bc04-e4e3-21ca-057f-a978ef411ad8@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-3-walling@linux.ibm.com>
 <58bc496c-28bb-26f8-ab46-aba6ad141717@linux.ibm.com>
 <737869a8-13b2-1831-00c6-629d5a109d9c@redhat.com>
 <05ab2e59-10c0-c7df-c014-b54883ddccd3@linux.ibm.com>
 <9a39a948-91a1-7cfe-f2a5-d30e5564f318@redhat.com>
 <20200512180140.4be69d60.cohuck@redhat.com>
 <5ed5bc04-e4e3-21ca-057f-a978ef411ad8@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/QY_q6TYpcDHvMVu7kDcSeMB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Collin Walling <walling@linux.ibm.com>, mst@redhat.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/QY_q6TYpcDHvMVu7kDcSeMB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2020 09:43:37 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 5/12/20 6:01 PM, Cornelia Huck wrote:
> > On Mon, 11 May 2020 17:02:06 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >  =20
> >> On 11.05.20 16:50, Janosch Frank wrote: =20
> >>> On 5/11/20 4:44 PM, David Hildenbrand wrote:   =20
> >>>> On 11.05.20 16:36, Janosch Frank wrote:   =20
> >>>>> On 5/9/20 1:08 AM, Collin Walling wrote:   =20
> >>>>>> The SCCB must be checked for a sufficient length before it is fill=
ed
> >>>>>> with any data. If the length is insufficient, then the SCLP comman=
d
> >>>>>> is suppressed and the proper response code is set in the SCCB head=
er.
> >>>>>>
> >>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>   =20
> >>>>>
> >>>>> Fixes tag? =20
> >=20
> > Probably
> >=20
> > Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
> >=20
> > ?
> >  =20
> >>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>   =20
> >>>>
> >>>> This is not a fix AFAIKs.
> >>>> sclp_service_call()/sclp_service_call_protected() always supplies a =
full
> >>>> SCCB of exactly 4k size.
> >>>>   =20
> >>>
> >>> We don't check for QEMU's 4k buffer here, but for the length that was
> >>> specified by the guest.
> >>>
> >>> It's valid for the guest to request cpu info and state that its buffe=
r
> >>> is only 1k. We can't write everything in 1k if we have ~200 cpus, so
> >>> we'll report the insufficient length rc.
> >>>
> >>> What he fixes here is the time of the length check, it should be done
> >>> before any changes are being done to the work_sccb.   =20
> >>
> >> I don't have access to the spec, especially, if the guest can expect
> >> nothing else in the sccb to change in case we report an error code. So
> >> whatever you tell me, I have to trust you :) =20
> >=20
> > Same here. Sounds plausible, but I have to trust the folks with the
> > documentation :)
> >  =20
>=20
> The AR states that:
> * Command validity check (has prio over length, as length is dependent
> on command)
> * boundary (if extended-length is not available)
> * Sufficient length check
>=20
> are done before "any other command action is taken".
> If a test fails the command is suppressed.

Thanks, makes sense.

--Sig_/QY_q6TYpcDHvMVu7kDcSeMB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl67rOUACgkQ3s9rk8bw
L6+FxA//VydvDVgsY2Xc/4I6BhhDCEiK/DjMXltMbw1P0Tzkewoi+nhZqwD2e3Tj
qwVP1G80LtqSTHDUYl7MLexWwQFWQ57AbU+JbalLAZzgdT5n4xJOji2c8ViZhw9t
lNxtZafssxh8vyw3/UZlGwZcz72KcwBF3pzKM++ue7TqgGreDxVBvecqKDVetVEX
LUCjlqjbzMw82SEFkfdqlFIRs6gYaH0QPfDAbvr6uME2NwNnvsgg2RkUEQnW25of
Q9EQNSB4hJd/lv6SLBy6q0CouE7TEY70mKxG93N/mdRRL0PR88qMFZyZyuKSKRMN
BEm/hiHqu0ti/ynheiKIzJk7l660g0qVKZBX21gH8nwPwxy99/bpEZyyHTNTx6mX
2AJftzEmD3vFNiRcBaKPzt+eEbIzTKEkngBOx5lFcOZXjpyKoGsd+K+tHQNbl9LS
LUgdD3eZwMCtg3FQBzVtpJLGQHfdjLjo47VdC3TSEJHK+EQ8ho7lgn0EJfYm9CWt
YjbSnJnFU0jnbbEckrKa+ZXC3pc8lLEiX+gwyUVVaXSX+2vC2JMEmgJNBJCJNCNw
9/LOi5l79XHE/063HnrbDw+FNpzaDlc2k60fT9x6rOeZrAsD9hc0Egn7NBffY0Ar
89H2NrkTEymH0riT5iY3baeo4Ctz10ejl07YSS4xNbX9dSDDcrw=
=FcdX
-----END PGP SIGNATURE-----

--Sig_/QY_q6TYpcDHvMVu7kDcSeMB--


