Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38FFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:15:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFC220720
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiHGp+2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFC220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jquNP-0004sK-Qv
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 04:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jquMe-0004Fy-Ec
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:14:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jquMc-0004Zi-Th
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593677674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XMsN0OX0DqNy0N1Qehi4QBMc4/b8RfxYkXxNl47iOfw=;
 b=KiHGp+2cDw2DtLFyJ4UkLh8FT9t4lo3CzvFcF+MR4VNJluXj035aygJYj9V12dIdhzagx3
 uK1Y1u/OIU1iGV54PhGlHz+r6/WIXAhA0jraIy5uXeVg0QV2K/tYLtmerjfGETu4nJEjoj
 7JbeFLTUepk0bLKN5rd09Sz4+XsX3WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-O5ZBqJe0O5OQwIcD4AS_Bg-1; Thu, 02 Jul 2020 04:14:30 -0400
X-MC-Unique: O5ZBqJe0O5OQwIcD4AS_Bg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CE1E518A8220;
 Thu,  2 Jul 2020 08:14:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C358D10016EB;
 Thu,  2 Jul 2020 08:14:26 +0000 (UTC)
Subject: Re: [PATCH 1/4] migration: Prevent memleak by ...params_test_apply
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-2-mreitz@redhat.com>
 <1e801600-db27-1625-f168-1b08396dc5b2@redhat.com>
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
Message-ID: <501a06fb-6c53-d607-5af9-86450f6c2c7b@redhat.com>
Date: Thu, 2 Jul 2020 10:14:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1e801600-db27-1625-f168-1b08396dc5b2@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lHKA3QIeDq7FWPoFmn5wSrNEYsMD9bxLv"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lHKA3QIeDq7FWPoFmn5wSrNEYsMD9bxLv
Content-Type: multipart/mixed; boundary="XEee7d3o3Ts3RC3bNs91OhVpPVuyZkS3X"

--XEee7d3o3Ts3RC3bNs91OhVpPVuyZkS3X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.07.20 16:38, Eric Blake wrote:
> On 6/30/20 3:45 AM, Max Reitz wrote:
>> The created structure is not really a proper QAPI object, so we cannot
>> and will not free its members.=C2=A0 Strings therein should therefore no=
t be
>> duplicated, or we will leak them.
>=20
> This seems fragile to me; having to code QAPI usage differently
> depending on whether the containing struct was malloc'd or not (and
> therefore whether someone will call qapi_free_MigrateSetParameters or
> not) looks awkward to maintain.

I don=E2=80=99t think that=E2=80=99s the point.  The point is that it=E2=80=
=99s just a temporary
object to run some check function on.  This is a very... special use case.

> We have
> visit_type_MigrateSetParameters_members, could that be used as a cleaner
> way to free all members of the struct without freeing the struct itself?
> =C2=A0Should the QAPI generator start generating qapi_free_FOO_members to
> make such cleanup easier?

The whole code is a mess, in my opinion.

The real question is why don=E2=80=99t we just drop migrate_params_test_app=
ly()
and let qmp_migrate_set_parameters() invoke migrate_params_check()
directly on @params.

I think there was some reason why I didn=E2=80=99t do that, but unfortunate=
ly I
don=E2=80=99t remember it off the top of my head (if there was a reason).

In any case, I don=E2=80=99t think any of this is the QAPI generator=E2=80=
=99s fault.

>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 migration/migration.c | 4 ++--
>> =C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 481a590f72..47c7da4e55 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1336,12 +1336,12 @@ static void
>> migrate_params_test_apply(MigrateSetParameters *params,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (params->has_tls_creds) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(params->tl=
s_creds->type =3D=3D QTYPE_QSTRING);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest->tls_creds =3D g_strdup=
(params->tls_creds->u.s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest->tls_creds =3D params->=
tls_creds->u.s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (params->has_tls_hostname) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(params->tl=
s_hostname->type =3D=3D QTYPE_QSTRING);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest->tls_hostname =3D g_str=
dup(params->tls_hostname->u.s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dest->tls_hostname =3D param=
s->tls_hostname->u.s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (params->has_max_bandwidth) {
>>
>=20



--XEee7d3o3Ts3RC3bNs91OhVpPVuyZkS3X--

--lHKA3QIeDq7FWPoFmn5wSrNEYsMD9bxLv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79l2EACgkQ9AfbAGHV
z0B1ywf+JjUBAhBuTNOhL1nJFplyZ06KVGNj2ufTOsncU5cA7ecSFkASsUN7rIki
MFIafwVxuS+2OV9fwEjvJjXJnQtf/U1FGM/HhjFmXzdEFSXReXa/AfupTjMCO4Yu
FoVD7YLJWBd8lcqLtneg5cTQgVwtb4+IS96oFgUjSn76BcanOFZ1dTCs4ZwmzMau
GY5o9f8OWN++wehlSBHes7eSPbOlSvn3NGoyvO3iT19NlT83qevLRe1EIVtAyrLV
O/MtEJfTrBkazBLtUxUG0D4Q8V6w8wNyK+8ZNs9ONaOzCT95KNJCA24X6p+JA0xF
eoldfMbE0SVlaBZ5T/0tJ1AicSDO0A==
=ao4S
-----END PGP SIGNATURE-----

--lHKA3QIeDq7FWPoFmn5wSrNEYsMD9bxLv--


