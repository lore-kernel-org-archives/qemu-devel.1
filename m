Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D610C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD7002063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haOHc0WS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7002063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5iT-00022N-2s
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5hN-0000sE-9a
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:21:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58412
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw5hL-0001oJ-20
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 11:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594912882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ayG8XWiVBuH+VtO78l/ENcibJAR8wD+zLMd8i7Xav5o=;
 b=haOHc0WSY4jlF30uT/B/ZuTkV63JEZwGXIunoa649nP5MVtsRg0B+ZMzqJzvTWUytUiXbf
 gFH6z0hoIqEfwMuKO+MbhN7FZJuin9Cl2WNYmtkRV2CJ1LvBTSYQOqB/gnfKQK/un6HnkE
 ob9Bb4wzeJ4T5fR3TEe77ClnQwLpv5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-HAlxNtORPXmCbaG-r3YgKw-1; Thu, 16 Jul 2020 11:21:18 -0400
X-MC-Unique: HAlxNtORPXmCbaG-r3YgKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED589800462;
 Thu, 16 Jul 2020 15:21:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2845C1D3;
 Thu, 16 Jul 2020 15:21:15 +0000 (UTC)
Subject: Re: [PATCH v7 21/47] block: Use CAFs in bdrv_refresh_filename()
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-22-mreitz@redhat.com>
 <71aca7a2-ebb0-92f3-c943-6a876cf9f57c@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <f3160ee5-82a2-5810-3494-b59a545042b9@redhat.com>
Date: Thu, 16 Jul 2020 17:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <71aca7a2-ebb0-92f3-c943-6a876cf9f57c@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dV5xJVFDp8QD07tFO5v3qIDpFT5gkUHF3"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dV5xJVFDp8QD07tFO5v3qIDpFT5gkUHF3
Content-Type: multipart/mixed; boundary="S23NKnYuVzbRFgUfKgC4l8XmIW6h520kT"

--S23NKnYuVzbRFgUfKgC4l8XmIW6h520kT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.07.20 14:52, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> bdrv_refresh_filename() and the kind of related bdrv_dirname() should
>> look to the primary child when they wish to copy the underlying file's
>> filename.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block.c | 29 +++++++++++++++++++++--------
>> =C2=A0 1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 8131d0b5eb..7c827fefa0 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6797,6 +6797,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *primary_child_bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *opts;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool backing_overridden;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool generate_json_filename; /* Whether o=
ur default
>> implementation should
>> @@ -6866,20 +6867,30 @@ void bdrv_refresh_filename(BlockDriverState *bs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qobject_unref(bs->full_open_options);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->full_open_options =3D opts;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 primary_child_bs =3D bdrv_primary_bs(bs);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv->bdrv_refresh_filename) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Obsolete infor=
mation is of no use here, so drop the old
>> file name
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * informati=
on before refreshing it */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->exact_filenam=
e[0] =3D '\0';
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drv->bdrv_=
refresh_filename(bs);
>> -=C2=A0=C2=A0=C2=A0 } else if (bs->file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Try to reconstruct valid =
information from the underlying
>> file */
>> +=C2=A0=C2=A0=C2=A0 } else if (primary_child_bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Try to reconstruct v=
alid information from the underlying
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * file -- this only wo=
rks for format nodes (filter nodes
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * cannot be probed and=
 as such must be selected by the user
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * either through an op=
tions dict, or through a special
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * filename which the f=
ilter driver must construct in its
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * .bdrv_refresh_filena=
me() implementation).
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>=20
>=20
> The caller may not be aware of a filter node and intend to refresh the
> name of underlying format node.
>=20
> In that case, the filter driver should redirect the call to the format
> node.

It shouldn=E2=80=99t.  We can only return a plain filename if passing that
filename to qemu (e.g. to -drive) will result in the same block graph
configuration.

This is what the comment means by =E2=80=9Cfilter nodes cannot be probed=E2=
=80=9D: If
there is a filter node, we must generate a json:{} filename, because
otherwise reopening the block device with -drive by passing the filename
generated here would result in a configuration where the filter is missing.

> What are situations the name of the filter itself should be refreshed in?

Hypothetically, if a filename could specify a filter.  For example, say
the filename =E2=80=9Cfilter[copy-on-read]:foo.qcow2=E2=80=9D would result =
in qemu
creating a COR filter on top of a qcow2 node, then we could generate
such a filename.

In practice, filters cannot be configured through plain filenames (apart
from blkverify, but that=E2=80=99s a debugging feature, so it doesn=E2=80=
=99t really
matter), so there is no such situation.  All filter nodes should have an
empty exact_filename and thus get a json:{} pseudo-filename.

> If there are any, should we do both actions or choose either?
>=20
> Andrey
>=20
>=20
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->exact_=
filename[0] =3D '\0';
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * We can us=
e the underlying file's filename if:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - it has =
a filename,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - the current BDS is=
 not a filter,
>=20
>=20
> Should we check the function input parameter for being a filter's BS
> here, in this function, and handle the case here or let the filter
> driver function do that or else the caller should check it?

bdrv_refresh_filename() is called whenever some node in the block graph
has changed, just to refresh its filename (after that change).  The
caller generally doesn=E2=80=99t really care about the result, so it doesn=
=E2=80=99t
matter whether the node is a filter or not (i.e., whether it gets a
plain filename or not).

I don=E2=80=99t think the caller should check it, and in this implementatio=
n we
simply have to handle filter nodes correctly: That is, not give them a
plain filename.

Max


--S23NKnYuVzbRFgUfKgC4l8XmIW6h520kT--

--dV5xJVFDp8QD07tFO5v3qIDpFT5gkUHF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QcGkACgkQ9AfbAGHV
z0BofggAkwzQhfyj+8rJ74QGShl+1QUc2u080vnw6evV2EDs39oOOdyxd8HvVrxH
GRZt42Vcx/xCoW37/jYnSvFXvdT+7VtcDz32xQnqUg0kwncAbZ+ooNICKlZx/HVl
3ZHgMTiIGwGJvvG5nIHv8/SBrSjBNEd925+awpbIxME1yzHYKMmshr7TYTRV5HUo
MMhXVYF67Pbrkll5iHpOePVVU91aCidWck4/zdJ9ZnmTfYExoBa+rrXkcie8c0lE
z7k3hAygASRCAv+/bmzOkoin8Ra2V8B8WoO8HzTWO3JBfJfEFo5s5p9w+mw/JAzy
KDbQo9mDemtXdoh6NaUBqkxcOnluag==
=Rnla
-----END PGP SIGNATURE-----

--dV5xJVFDp8QD07tFO5v3qIDpFT5gkUHF3--


