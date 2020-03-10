Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569AAC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF4E21927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O8k99UK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF4E21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBikT-0003qg-4u
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBij5-0003LJ-SP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:31:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBij4-000241-8H
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:31:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32649
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBij4-00020n-2A
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583861488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q2VVjoerMZgjTEd6HOjMIk4rVKB//n0r3rQnFhdtEQc=;
 b=O8k99UK5gMZ40Svl5EZUAaZY9dPZp/GjbqKfRp9NMxVXZp8WjcZm7hxVxe7+e5KVU7z5X/
 mNTfKAaT6Nw7jj6NvbDQPaUB+N3W7h1nti/L8fH0DZPnO7WBbRM/HN5m6tIO/tmMOX5PHP
 PK7L8bMQ/YhIulpQJHUQZrPNflRpx+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-jh6VlSwkMbKfIugjQNOlGg-1; Tue, 10 Mar 2020 13:31:26 -0400
X-MC-Unique: jh6VlSwkMbKfIugjQNOlGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4ED618A72A1;
 Tue, 10 Mar 2020 17:31:25 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB2B28F354;
 Tue, 10 Mar 2020 17:31:23 +0000 (UTC)
Subject: Re: [PATCH 3/3] iotests/138: Test leaks/corruptions fixed report
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-4-mreitz@redhat.com>
 <7336bd34-0f48-acf2-ef2b-0fb466f564f4@redhat.com>
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
Message-ID: <9c583104-a108-3aca-44bd-82782fd19cd2@redhat.com>
Date: Tue, 10 Mar 2020 18:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <7336bd34-0f48-acf2-ef2b-0fb466f564f4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X4ErPtTaRn0If7lHduoUwaisPjyFmddEv"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X4ErPtTaRn0If7lHduoUwaisPjyFmddEv
Content-Type: multipart/mixed; boundary="B1BgaGV71RvVT2Djg16AKGWOVjj87on6B"

--B1BgaGV71RvVT2Djg16AKGWOVjj87on6B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 19:56, Eric Blake wrote:
> On 2/27/20 11:02 AM, Max Reitz wrote:
>> Test that qemu-img check reports the number of leaks and corruptions
>> fixed in its JSON report (after a successful run).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/138=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++++++++++++=
+++++++++++++++++++++++--
>> =C2=A0 tests/qemu-iotests/138.out | 14 +++++++++++++
>> =C2=A0 2 files changed, 53 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
>> index 54b01046ad..25bfbd4cca 100755
>> --- a/tests/qemu-iotests/138
>> +++ b/tests/qemu-iotests/138
>> @@ -41,8 +41,10 @@ _supported_fmt qcow2
>> =C2=A0 _supported_proto file
>> =C2=A0 _supported_os Linux
>> =C2=A0 # With an external data file, data clusters are not refcounted
>> -# (and so qemu-img check does not check their refcount)
>> -_unsupported_imgopts data_file
>> +# (and so qemu-img check does not check their refcount);
>=20
> Not this patch's problem, but is that a bug in 'qemu-img check' for not
> validating refcounts on an external data file?=C2=A0 Or is it merely this
> comment wording is not quite perfect?

There are no refcounts for an external data file, because every cluster
is refcounted exactly once and we don=E2=80=99t need refcounts to allocated
clusters (the offset in the data file is the same as the guest offset in
the image).

It kind of is what the comment says, but I suppose we could drop the
part about qemu-img check?

>> +# we want to modify the refcounts, so we need them to have a specific
>> +# format (namely u16)
>> +_unsupported_imgopts data_file 'refcount_bits=3D\([^1]\|.\([^6]\|$\)\)'
>> =C2=A0 =C2=A0 echo
>> =C2=A0 echo '=3D=3D=3D Check on an image with a multiple of 2^32 cluster=
s =3D=3D=3D'
>> @@ -65,6 +67,41 @@ poke_file "$TEST_IMG" $((2048 + 8))
>> "\x00\x80\x00\x00\x00\x00\x00\x00"
>> =C2=A0 # allocate memory", we have an error showing that l2 entry is inv=
alid.
>> =C2=A0 _check_test_img
>> =C2=A0 +echo
>> +echo '=3D=3D=3D Check leaks-fixed/corruptions-fixed report'
>> +echo
>> +
>> +# After leaks and corruptions were fixed, those numbers should be
>> +# reported by qemu-img check
>> +_make_test_img 64k
>> +
>> +# Allocate data cluster
>> +$QEMU_IO -c 'write 0 64k' "$TEST_IMG" | _filter_qemu_io
>> +
>> +reftable_ofs=3D$(peek_file_be "$TEST_IMG" 48 8)
>> +refblock_ofs=3D$(peek_file_be "$TEST_IMG" $reftable_ofs 8)
>> +
>> +# Introduce a leak: Make the image header's refcount 2
>> +poke_file "$TEST_IMG" "$refblock_ofs" "\x00\x02"
>=20
> Why not use your brand-new poke_file_be "$TEST_IMG" "$refblock_ofs" 2 2

Because I didn=E2=80=99t need it at this point.  I only needed it for the n=
ext
line, so I wrote it in between. :)

But yes, it does make sense to use it wherever possible now that we have it=
.

>> +
>> +l1_ofs=3D$(peek_file_be "$TEST_IMG" 40 8)
>> +
>> +# Introduce a corruption: Drop the COPIED flag from the (first) L1 entr=
y
>> +l1_entry=3D$(peek_file_be "$TEST_IMG" $l1_ofs 8)
>> +l1_entry=3D$((l1_entry & ~(1 << 63)))
>> +poke_file_be "$TEST_IMG" $l1_ofs 8 $l1_entry
>=20
> Yep, the new function makes this task easier.=C2=A0 (You could also just =
peek
> 1 byte at $((l1_ofs+7)) then write it back out with poke_file
> "$TEST_IMG" $((l1_ofs + 7)) $(printf '\\x%02x' $((val & 0xfe)))", but
> that just doesn't look as nice)
>=20
>> +
>> +echo
>> +# Should print the number of corruptions and leaks fixed
>> +# (Filter out all JSON fields (recognizable by their four-space
>> +# indentation), but keep the "-fixed" fields (by removing two spaces
>> +# from their indentation))
>> +# (Also filter out the L1 entry, because why not)
>> +_check_test_img -r all --output=3Djson \
>> +=C2=A0=C2=A0=C2=A0 | sed -e 's/^=C2=A0 \(.*\)-fixed"/\1-fixed"/' \
>> +=C2=A0=C2=A0=C2=A0 | grep -v '^=C2=A0=C2=A0=C2=A0 ' \
>> +=C2=A0=C2=A0=C2=A0 | sed -e "s/\\<$(printf %x $l1_entry)\\>/L1_ENTRY_VA=
LUE/"
>=20
> sed | grep | sed can often be done with a single sed:
>=20
> ... | sed -e 's/^=C2=A0 \(.*\)-fixed"/\1-fixed"/' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e '/^=C2=A0=C2=A0=C2=A0 /d' \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s/\\..."

Nice.

> Using \\< and \\> in the sed regex is a GNUism; do we want this test to
> run on BSD?

Hm.  I suppose we can just use [^0-9a-f] instead.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!

Max


--B1BgaGV71RvVT2Djg16AKGWOVjj87on6B--

--X4ErPtTaRn0If7lHduoUwaisPjyFmddEv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5nzuoACgkQ9AfbAGHV
z0APfgf/bNclRfYT6KApAG8ODCKH+WqS/BqTZiXgwEg+py8uOvZrXaMGV0+w49Gq
uatcg/BXyQ8lGTEtYbpaP/V4ziJ0/DRjKoeKcFwWr5ZYttZLIByt5ljRFGVuqIpg
XBUni7DYZHKlUMTAJNvrRiv4EoX3KLf3MNUW4Jwx2T6iIwHUCshCziRvK+xTQM5k
n6igbX/A93egzs6mczWdt2yxoklSefJ9spzymRAyVKckFjjsYofK5ZPTPiKrfeQL
iqk3AaKOk/tgqdjDTM5Xa7onLvgWlXraCcpj20x3DL7GfbIRbDV1W1Q5lU7oEAII
JsKl6ML6LoQnRCQegUBC+CgG+FEI6w==
=l2QU
-----END PGP SIGNATURE-----

--X4ErPtTaRn0If7lHduoUwaisPjyFmddEv--


