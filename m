Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA647C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:05:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA6C206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsM4suM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA6C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfnl-0001BC-PK
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnfmm-0000dU-Cs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:04:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jnfmk-0001VV-2C
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592906649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bSavz6YDarB5/b/Xb/JT/cnozWrzyWSD5E0IxcxF/2U=;
 b=AsM4suM32+ADjWKZUIKirOVSq0eV8gBW/F4jlS4MhV6JsZ6/OInAgKWfTItcwhdcRkwc4H
 Cuy0GzJek03T8MuaxZf+pkrBL/eGi1TruRzS/wtOFakOLsF9qPOcCHydD6uSB2vpZKTo8q
 32+hipi2Hee8kH9Mswc79BohsxIF5gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-2GpQHgD1O5GskRvWbY6yCw-1; Tue, 23 Jun 2020 06:04:07 -0400
X-MC-Unique: 2GpQHgD1O5GskRvWbY6yCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF474464;
 Tue, 23 Jun 2020 10:04:05 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A24B67D8F2;
 Tue, 23 Jun 2020 10:04:01 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:04:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
Message-ID: <20200623100400.GC5853@linux.fritz.box>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
 <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
 <w51lfkf807y.fsf@maestria.local.igalia.com>
 <66581529-dc44-5fd0-54a3-1117b073077a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <66581529-dc44-5fd0-54a3-1117b073077a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Nir Soffer <nsoffer@redhat.com>, Alberto Garcia <berto@igalia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 23.06.2020 um 09:28 hat Max Reitz geschrieben:
> On 22.06.20 19:44, Alberto Garcia wrote:
> > On Mon 22 Jun 2020 11:47:32 AM CEST, Max Reitz wrote:
> >>> I don't know the internals of qcow2 data_file, but are we really usin=
g
> >>> qcow2 metadata when accessing the data file?
> >>
> >> Yes.
> >>
> >>> This may have unwanted performance consequences.
> >>
> >> I don=E2=80=99t think so, because in practice normal lookups of L1/L2 =
mappings
> >> generally don=E2=80=99t cost that much performance.
> >=20
> > ...if the L2 cache size is large enough. Otherwise you need one extra
> > read operation to retrieve the L2 metadata.
> >=20
> > Possible performance problems when you have preallocation:
> >=20
> >    - If a block hasn't been written yet (it's all zeroes) then you stil=
l
> >      need to read the L2 entry and read the data block. If there is not
> >      L2 table then you can simply return zeroes without going to disk a=
t
> >      all. This of course assumes that the contents of the unwritten dat=
a
> >      block are zeroes.
> >=20
> >    - QEMU still needs to read from disk (and cache in memory) the L2
> >      metadata, when it already knows in advance the contents of the L2
> >      entry (guest_offset =3D=3D host_offset).
>=20
> We could well optimize this regardless of preallocation.  With
> data-file-raw, qemu doesn=E2=80=99t have to look at the L2 metadata at al=
l.
>=20
> So the problem isn=E2=80=99t preallocation at all, it=E2=80=99s the fact =
that we don=E2=80=99t
> have such an optimization.  But note that to implement such an
> optimization, we really do need preallocation: Because it would mean
> that we wouldn=E2=80=99t touch the L1/L2 tables for data-file-raw images =
during
> runtime, which would effectively make those images empty to today=E2=80=
=99s qemu
> versions.

It depends. For reads, bypassing the L1/L2 tables is completely fine
with data-file-raw. It may miss opportunities to optimise reading
unallocated/zeroed clusters, but if the data file is actually sparse, it
shouldn't make a big difference. Maybe we should just do this.

For (potentially allocating) writes, you're right that we need to be
more careful. If we want to completely bypass L1/L2 tables,
preallocation is not enough, but we have to make sure that we never
discard any clusters.

Whatever we do for writes will be a non-trivial change. I wonder if it's
really worth doing this for optimisation when nobody uses the feature
yet anyway.

> (OTOH, preallocation would then be pretty much superfluous for all newer
> versions of qemu.  To address that, we could then add an incompatible
> version of data-file-raw.  But I think we should only think about that
> once we get to that point.)

Well, if we create an incompatible version, we can have one that doesn't
even store L1/L2 tables.

Kevin

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7x05AACgkQfwmycsiP
L9YlQA/+I9lAKwepQzwGE+6etoZxx8Hl+kZwFcORp8cVieVZ7834d4T3WC3Jf1hE
qpdA3kU+ee+vdjQtfy+E80nutGXvwCSQrfRK3noYd1NswcJf+geAOQHLoBQXZyqP
5bR6pFDbUAZwmdcHBnajlwBnlhm0LP8MOlpiLpgZNr4MZROwX0b12NH4hao3+3ZG
eBpNjyto9eff0tXr1yQWTsB8ZWFp4v1OR1hLrri+D30Dsucn/Cg1sdGRgYRFdNHZ
mWajtD4Kh74sLlnP6tMot5k72+mQZ4A3Z8cfgRRQD9OEdz/eyuZzci/gIxaIzaEo
azwYIJoXdLkT+qeZYJ3UNKnKyzrhmm48twhboSCwBBjp6Jby9HYHfSNMFw83KP0S
YRosmvSTdHqnSARyZ1wZKnYrM30h4KVMV/OI80PgyOQFgLf3zvNXGUXVzmaW4Aob
YjlB3OApSbcBZTKIYgDtedTLH7boI+9Gy0VgwQ+ddKsQ37sAt1quGXWiS2Wi9qmE
Hv1q38EaI28DYH+/UR5+c0m5gusAFRfJWyCdzKPav0wBZ+VpTYpDhuSot9eSp1Fh
EyAI+796XMmiywCz3rdDaJvwYvppqrDU3yvNKsmbrI/9Iyzw5BFOVmOfgF3jO6ET
UFlvn5mmWyxAp6pa882egV7yb7ntGnCq6rn7z3YKzh8VE0kkvEk=
=bywN
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


