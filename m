Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DB9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13277206DC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fML2XD8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13277206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAJi-0004vL-8Z
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jhAJ7-0004Pk-0f
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:14:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30962
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jhAJ5-0007c6-V1
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591355679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bmw6jv5DYDR/qe3ERQ5EnSv39OW4PC0Oj+ai2eJmZp0=;
 b=fML2XD8O5qeZzsMCHpbXj2skAphXD4gynllYa4pPfvq/ZB8M5845Fho8d6ZVBBd7hVFqqd
 mslTrrCrWZ2txGGCzI5oeh4MwmMYdSCnCGzjeqJSWbiXVIz1JuEWK4kpCTtadmXNkOYwSc
 FnAT/hNICc0IyMkxx+YSgUratVf+9pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-lXfxg6UiOVe9sF99ow1vpA-1; Fri, 05 Jun 2020 07:14:35 -0400
X-MC-Unique: lXfxg6UiOVe9sF99ow1vpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F53107ACCA;
 Fri,  5 Jun 2020 11:14:34 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-112.ams2.redhat.com [10.36.113.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E18560C05;
 Fri,  5 Jun 2020 11:14:32 +0000 (UTC)
Date: Fri, 5 Jun 2020 13:14:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
Message-ID: <20200605111431.GI5869@linux.fritz.box>
References: <20200415190207.21118-1-berto@igalia.com>
 <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.06.2020 um 15:53 hat Max Reitz geschrieben:
> On 15.04.20 21:02, Alberto Garcia wrote:
> > Although we cannot create these images with qemu-img it is still
> > possible to do it using an external tool. QEMU should refuse to open
> > them until the data-file-raw bit is cleared with 'qemu-img check'.
> >=20
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> >  block/qcow2.c              | 39 ++++++++++++++++++++++++++++++++++++++
> >  tests/qemu-iotests/244     | 13 +++++++++++++
> >  tests/qemu-iotests/244.out | 14 ++++++++++++++
> >  3 files changed, 66 insertions(+)
>=20
> Sorry for the long delay. :/
>=20
> The patch itself looks good, but I=E2=80=99m not sure whether it is exten=
sive
> enough.  Let me just jump straight to the problem:
>=20
> $ ./qemu-img create -f qcow2 \
>     -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
>     foo.qcow2 64M
> (Create some file empty foo.qcow2 with external data file that=E2=80=99s =
raw)
>=20
> $ ./qemu-img create -f qcow2 backing.qcow2 64M
> $ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
> (Create some file filled with 42s)
>=20
> $ ./qemu-img compare foo.qcow2 foo.qcow2.raw
> Images are identical.
> (As expected, foo.qcow2 is identical to its raw data file)
>=20
> $ ./qemu-img compare --image-opts \
>     file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
>     file.filename=3Dfoo.qcow2.raw
> Content mismatch at offset 0!
> (Oops.)
>=20
> So when the user manually gives a backing file without one having been
> given by the image file, we run into the same problem.  Now I=E2=80=99m n=
ot
> quite sure what the problem is here.  We could make this patch more
> extensive and also forbid this case.

I guess what we should really be checking is that bs->backing is NULL
after the node is fully opened. The challenging part is that the backing
child isn't managed by the block driver, but by the generic block layer,
and .brv_open() comes first. So we don't really have a place to check
this. (And there is also the case that the image is originally opened
with BDRV_O_NO_BACKING and the later bdrv_open_backing_file().)

> But I think there actually shouldn=E2=80=99t be a problem.  The qcow2 dri=
ver
> shouldn=E2=80=99t fall back to a backing file for raw external data files=
.  But
> how exactly should that be implemented?  I think the correct way would
> be to preallocate all metadata whenever data_file_raw=3Don =E2=80=93 the =
qcow2
> spec doesn=E2=80=99t say to ignore the metadata with data_file_raw=3Don, =
it just
> says that the data read from the qcow2 file must match that read from
> the external data file.
> (I seem to remember I proposed this before, but I don=E2=80=99t know exac=
tly...)

I don't find preallocation convincing, mostly for two reasons.

First is, old images or images created by another program could miss the
preallocation, but we still shouldn't access the backing file.

The other one is that discard breaks preallocation, so we would also
have to make sure to have a special case in every operation that could
end up discarding clusters (and to add it to every future operation we
might add).

It just sounds very brittle.

> (In contrast, I don=E2=80=99t think it would be correct to just treat
> unallocated clusters as zero whenever data_file_raw=3Don.)
>=20
> What do you think?  Should we force preallocation with data_file_raw=3Don=
,
> and then just take this patch, even though it still lets users give
> backing files to a qcow2 file at runtime without error?  (Except the
> backing file wouldn=E2=80=99t have an effect, then.)

Honestly, maybe passing a backing file at runtime to an image that
doesn't logically have one is just a case of "then don't do that".

Kevin

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl7aKRcACgkQfwmycsiP
L9bPTxAAtTivx9UWH/0HbnvxwL7aD28iEolCAfTa/E6CCXIlXNRYpserrz6XIYW9
bJVYv5GCGgCpxOqhfbU/dNrGLko2tLuhSozHrzlmnDUUyduHbE56xx9RZ9hpNKrG
WnHFQYH1PLlVIHhXRxoP3qmdHhQUMfCPND8wR2wMRl54vAV2Wa07TtUHEvro9UCd
x3K2cWmzmCapxH14cB+gYeoz9FLGfhxkHUbMRijpKv81pVudKo58PZGNHaEiAfKx
kxvYlEIeF1Y3AGGhyYKb97I4Tl7OLJQvnq+M2XLOF7SskbDX6SkW9gEOKgMi0TKs
0fXCZAV7ZPhKtTrICSQo4hEJL5I3UB3y+xZzKK8spxGQqoZe5v8KSM/CJvV3WrB6
sj9XNq1b3OMm0bYnT5mwyLkSpQEcLnZnqk8FdZBiuvAfWZuHxdBevBqmD11uwEpP
AhflmwPhJDoO0BbkSLgkVw132xVvafoDlXStJavhqVjgqAfJj6ozNkzGVkzXTUj/
ddHRNhqlwutODxiosmQBR6OvaY75VyQsxZD5XkHsAmwbgGlecgvALcyxwK+JxSvi
rvxN0vIm6mMNeV7kdLf7BQpqUEpTwFE100GA+vUXTvjB+SlZNa9XB5/4djEP/0H8
zR69gaiju8mCfUqmWlwWtxSu99lWrQ0WW5px35Y3KQAGpUyD+E0=
=GmWd
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--


