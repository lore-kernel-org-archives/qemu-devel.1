Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7568AC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A2820722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVIxjWdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2820722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbmw-0001kH-95
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZblz-0000YY-2I
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZbly-0003mN-0A
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:24:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20984
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZblx-0003m5-SU
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574778297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoQMxEt/37zgd45bQvh1Dlrvcjoe0XaZOgtYEAsExyY=;
 b=eVIxjWdknSs807Md7GM39GPIKsnluhcS3nzpp+nc2TncB6qkGuxvq6zhwRXdeMZcveA2zn
 5HoH6FY/gOM8/s9t0bLYjNTJNFBFtzPoEi8AdG2nHZeX3TKt06n2wtOp7ZppgcLsoG3Wgu
 Ws+BwWldVFbR1hRp7dark6e9bfeTfMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-yQ9QoUE8P6mU3VRSJPOZKg-1; Tue, 26 Nov 2019 09:24:53 -0500
X-MC-Unique: yQ9QoUE8P6mU3VRSJPOZKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8192E80058B;
 Tue, 26 Nov 2019 14:24:52 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-171.ams2.redhat.com [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93DB55C1D8;
 Tue, 26 Nov 2019 14:24:26 +0000 (UTC)
Date: Tue, 26 Nov 2019 15:24:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: API definition for LUKS key management [V2]
Message-ID: <20191126142425.GB5889@linux.fritz.box>
References: <122fc70c802b9a1185e008bf13fb7f078fe70af7.camel@redhat.com>
 <20191112100253.GM2366658@redhat.com>
 <d6ead0c3f9758b5def21dd690217bc9deeace2a9.camel@redhat.com>
 <0b5fec2a-1d93-7e31-55d2-1a80bde89f0b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0b5fec2a-1d93-7e31-55d2-1a80bde89f0b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, John Ferlan <jferlan@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.11.2019 um 19:45 hat Max Reitz geschrieben:
> On 22.11.19 15:22, Maxim Levitsky wrote:
> > Hi!
> >=20
> > This is the second version of the proposed QMP API for key management,
> > after discussion with Keven and Max.
> >=20
> > Will this work?
> >=20
> > Adding Peter Krempa to CC, to hear his opinion from the=20
> > libvirt side.
> >=20
> > Best regards,
> > =09Maxim Levitsky
>=20
> Looks good to me overall.  I don=E2=80=99t think we need to overly push h=
aving
> the same interface for create and amend, because I don=E2=80=99t see much=
 to be
> gained from it.
>=20
> [...]
>=20
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index b2a4cff683..019db682cd 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -309,3 +309,56 @@
> >    'base': 'QCryptoBlockInfoBase',
> >    'discriminator': 'format',
> >    'data': { 'luks': 'QCryptoBlockInfoLUKS' } }
> > +
> > +
> > +##
> > +# @LUKSKeyslotUpdate:
> > +#
> > +# @keyslot:         If specified, will update only keyslot with this i=
ndex
> > +#
> > +# @old-secret:      If specified, will only update keyslots that
> > +#                   can be opened with password which is contained in
> > +#                   QCryptoSecret with @old-secret ID
> > +#
> > +#                   If neither @keyslot nor @old-secret is specified,
> > +#                   first empty keyslot is selected for the update
> > +#
> > +# @new-secret:      The ID of a QCryptoSecret object providing a new d=
ecryption
> > +#                   key to place in all matching keyslots. Empty strin=
g erases the
> > +#                   keyslot.
>=20
> Hm...  Can=E2=80=99t we make this some string-or-null alternate type so t=
hat
> null will erase the keyslot?  That would make more sense to me.

The only problem is that it doesn't map nicely to the command line.

Kevin

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd3TWZAAoJEH8JsnLIjy/WBxUP/1SCqAW4MADFlEgN7FvzVjVC
bf/tqSvufo4bIgBOgXcFGb5NNGyqj68s7xsDjAn4LRxYLIplU7VNK6Ds4pJe6v5x
TCWEry3Fv0lDIBvIN9p1OpVPJJYCXELchN8xQqnoq6KCrCe06B6i3/MnDTKxxiFW
5YxO2AS8MOfBbPB4uXl3NiYcY1DUw2jaLxWZa1EqwKvejv8NVR6fZ305Vje542VR
nKHgK/bSvCi6gSKP8GqZ8fU+BAQlTwPjVrw1L/n/lIIDEuKASTfvGTRhlCgQlKyz
h4RxsEr2kkqjjFEJrg9b8odR3S0cPYvxlqk40r2LEWUxfNMhy8QQQKCeQA6VtNni
6prYA4UKbrW1SSu58faHSQglQvyBL76H/QeDa+nu1zV9guNPLSNVws7Qq8lYYXZD
IuqaTgE6Eiew6Cm5JmqoISJNFAt1ARfKd1STTaitHSupQHdiPUbnG5FGSoXA8uR2
J0hpbpt7AcCC7vkE5S6ZZYaob61VbtOKpktHz9OY6toOHfvvTX5Sp/boMmvK0Ne1
rUxdyOzzF2YmgbHS+334eEykK61jj2zk6/+4qNpVSLsF80RYr9UkimOpgyr+LGxf
SL6gUCcUjFSeyzbLbsdFaKBzeMF0qdw33CP8bN/krIJ/9Abv+EfxaBshCLu5o9rx
zu5XtzCr76Ykl+/mwgq+
=Im4x
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


