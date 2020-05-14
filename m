Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DB4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56DD620675
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 09:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xd8D90K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DD620675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ9rP-0002AJ-H7
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 05:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZ9qm-0001H2-Tz
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:08:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27842
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZ9ql-0001fB-Dh
 for qemu-devel@nongnu.org; Thu, 14 May 2020 05:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589447297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L3LWw3pTzIMQJeMQyxXBWIHX0L1DoyXqsE5fTn6pTaU=;
 b=Xd8D90K5jCp38PpW5BPPCeL1Zmtf1ExxujZngGTB5X4vEx4/FRLDzlI4mr0TqZmcF4wQZu
 Mb7xwsmRYxz2Up0g1cPK2PYeczXxsTplmm0WiSlieWmoFs/iSKqp8n1XI1641l8YwzEoyQ
 icwGOJw8TovOPGaXEZ3XTkvXsKJGngA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-l9akLW83PKe61JAbGumGMg-1; Thu, 14 May 2020 05:08:15 -0400
X-MC-Unique: l9akLW83PKe61JAbGumGMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FAF801504;
 Thu, 14 May 2020 09:08:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAA4439E;
 Thu, 14 May 2020 09:08:11 +0000 (UTC)
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200514084242.GB2787@work-vm>
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
Message-ID: <146b4724-69b8-93b5-e2ac-b909721f530b@redhat.com>
Date: Thu, 14 May 2020 11:08:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514084242.GB2787@work-vm>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Uib6DnfrqlPYtBrWS3p8QDsL9YuJ4noC5"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uib6DnfrqlPYtBrWS3p8QDsL9YuJ4noC5
Content-Type: multipart/mixed; boundary="1QtAWWtjlQOusHEn9Sxa3M1yqpdWftqUW"

--1QtAWWtjlQOusHEn9Sxa3M1yqpdWftqUW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.05.20 10:42, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
>=20
> <snip>
>=20
>> +void qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList =
*mapping,
>> +                                         Error **errp)
>> +{
>> +    QDict *in_mapping =3D qdict_new();
>> +    QDict *out_mapping =3D qdict_new();
>> +
>> +    for (; mapping; mapping =3D mapping->next) {
>> +        MigrationBlockNodeMapping *entry =3D mapping->value;
>> +
>> +        if (qdict_haskey(out_mapping, entry->node_name)) {
>> +            error_setg(errp, "Cannot map node name '%s' twice",
>> +                       entry->node_name);
>> +            goto fail;
>> +        }
>=20
> I'm not too clear exactly which case this is protecting against;
> I think that's protecting against mapping
>=20
>   'src1'->'dst1' and 'src1'->'dst2'
> which is a good check.s (or maybe it's checking against dst2 twice?)

This one is against mapping src1 twice.  Both checks together check that
it=E2=80=99s a one-to-one bijective mapping.

The technical reason why it needs to be one-to-one is because we base
two QDicts off of it, so the inverse mapping needs to work.

> What about cases where there is no mapping - e.g. imagine
> that we have b1/b2 on the source and b2/b3 on the dest; now
> if we add just a mapping:
>=20
>   b1->b2
>=20
> then we end up with:
>=20
>   b1 -> b2
>   b2 -> b2  (non-mapped)
>         b3
>=20
> so we have a clash there - are we protected against that?

Oh, no, we aren=E2=80=99t.  That wasn=E2=80=99t intentional.  However, I=E2=
=80=99m not sure how
we=E2=80=99d protect against it.  We can=E2=80=99t check it in
qmp_migrate_set_bitmap_node_mapping(), because we don=E2=80=99t know yet wh=
ich
nodes will exist at the time of migration, and which of those will have
bitmaps.

So we=E2=80=99d need to check it as part of the migration process (by looki=
ng up
any unmapped entries that default to the identity mapping in the
respective reverse mapping, to see whether anything maps to the same name).

OTOH, Vladimir proposed adding a parameter to
migrate-set-bitmap-node-mapping that would make migration fail if any
bitmaps should be migrated off of unmapped nodes, or if any incoming
alias is unmapped (instead of defaulting to the identity mapping).  If
we just make that the only behavior, then we wouldn=E2=80=99t have a proble=
m
with that at all, because all unmapped nodes would always throw an error.

(And on the third hand, I wonder whether we should actually allow
migrating bitmaps from multiple nodes to a single one, but I suppose
that would require two separate commands, one for incoming and one for
outgoing...)

Max


--1QtAWWtjlQOusHEn9Sxa3M1yqpdWftqUW--

--Uib6DnfrqlPYtBrWS3p8QDsL9YuJ4noC5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl69CnoACgkQ9AfbAGHV
z0BQNAf/UjFUq8P5Ye6g16WTEpCHfPigVoc9nJYQ36lEtHlpxYc1FR05jNqBZk0z
lbG0mf/sCvRtjZUCNlqQcdsBxBrRXP/hvvdgL0veSF98SlkdGYD6Cd7jWhqFH98x
3ATpEgL2Ed5rCUSaXRVX5l2IvOD4Kya27ngQ3YFG0GsBzvDo3lijaiNEL7ezGABi
mIlVuOcMrKg7hC8A3yO0DdRE2aoDGzlYzLA8GH5A/c63XwvkC5rC0oX8cTl8c6Ef
xVZ8wwj2a9QxOFp7Gad6f+4hUo3Fz4HtjzxN++a36dkWDa9rxH0Qt0aKVP0DFaKn
dW2WoitIQ+8onx2NX6N1vp2VUBxpjg==
=zmX2
-----END PGP SIGNATURE-----

--Uib6DnfrqlPYtBrWS3p8QDsL9YuJ4noC5--


