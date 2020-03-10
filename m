Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC7EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566E021927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zel++8uW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566E021927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBibB-00007W-J0
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55508)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBiaW-00085Y-7r
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:22:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBiaU-0001ay-UO
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:22:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBiaU-0001Yu-PS
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583860958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RFzhG6DccDih/C5kt8Q+2Vlh0I+HGVm9IzOwXIoOxc8=;
 b=Zel++8uWzJSr4xoaEu7VxXvLAwZV8kdzOGWN3lG/zoOnAq38jsCvOC0dNv7IlgbCmFJvQg
 QynVr9L+8adWyDl9mVHUaMe1Cs3deoTuDu3FX61BWIutaXy4sb/Tg0HJmbzWyiAM+LOtcF
 hsvPfaAI/6QuVEYSkcxA61fnVGcifmE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-NmFpfafqObeFoOP9XF7EqQ-1; Tue, 10 Mar 2020 13:22:35 -0400
X-MC-Unique: NmFpfafqObeFoOP9XF7EqQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6827100550D;
 Tue, 10 Mar 2020 17:22:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9753160BF4;
 Tue, 10 Mar 2020 17:22:32 +0000 (UTC)
Subject: Re: [PATCH 2/3] iotests: Add poke_file_[bl]e functions
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200227170251.86113-1-mreitz@redhat.com>
 <20200227170251.86113-3-mreitz@redhat.com>
 <473f2e22-bf5b-32f4-51db-bf12f7a2d4fe@redhat.com>
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
Message-ID: <16d049db-8952-0e6b-5021-3f212712d70d@redhat.com>
Date: Tue, 10 Mar 2020 18:22:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <473f2e22-bf5b-32f4-51db-bf12f7a2d4fe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tXZ36kMzjmTiAKbFgMuCg2ojsxTJcm9ES"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
--tXZ36kMzjmTiAKbFgMuCg2ojsxTJcm9ES
Content-Type: multipart/mixed; boundary="eJ6D7pvqn1oNMwjkhAmGSZtEVi6AqtcKK"

--eJ6D7pvqn1oNMwjkhAmGSZtEVi6AqtcKK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.02.20 19:46, Eric Blake wrote:
> On 2/27/20 11:02 AM, Max Reitz wrote:
>> Similarly to peek_file_[bl]e, we may want to write binary integers into
>> a file.=C2=A0 Currently, this often means messing around with poke_file =
and
>> raw binary strings.=C2=A0 I hope these functions make it a bit more
>> comfortable.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/common.rc | 37 +++++++++++++++++++++++++++++++=
+++++
>> =C2=A0 1 file changed, 37 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index 4c246c0450..604f837668 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -53,6 +53,43 @@ poke_file()
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf "$3" | dd "of=3D$1" bs=3D1 "seek=
=3D$2" conv=3Dnotrunc &>/dev/null
>> =C2=A0 }
>> =C2=A0 +# poke_file_le 'test.img' 512 2 65534
>> +poke_file_le()
>> +{
>=20
> I like the interface.=C2=A0 However, the implementation is a bit bloated =
(but
> then again, that's why you cc'd me for review ;)
>=20
>> +=C2=A0=C2=A0=C2=A0 local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''
>> +
>> +=C2=A0=C2=A0=C2=A0 for i in $(seq 0 $((len - 1))); do
>=20
> No need to fork seq, when we can let bash do the iteration for us:
>=20
> while ((len--)); do
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 byte=3D$((val & 0xff))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ $byte !=3D 0 ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr=
=3D"$(printf "\x$(printf %x $byte)")"
>=20
> Why are we doing two printf command substitutions instead of 1?

Because I had no idea that $() would evaluate '\x*' escape sequences.
Interesting.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chr=
=3D"\0"
>=20
> Why do we have to special-case 0?=C2=A0 printf '\x00' does the right thin=
g.

The non-special-cased version didn=E2=80=99t seem to work for NUL.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str+=3D"$chr"
>=20
> I'd go with the faster str+=3D$(printf '\\x%02x' $((val & 0xff))),
> completely skipping the byte and chr variables.

Sure!  That=E2=80=99s much better.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val=3D$((val >> 8))
>> +=C2=A0=C2=A0=C2=A0 done
>> +
>> +=C2=A0=C2=A0=C2=A0 poke_file "$img" "$ofs" "$str"
>> +}
>=20
> So my version:
>=20
> poke_file_le()
> {
> =C2=A0=C2=A0=C2=A0 local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D
> =C2=A0=C2=A0=C2=A0 while ((len--)); do
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 str+=3D$(printf '\\x%02x' $((v=
al & 0xff)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val=3D$((val >> 8))
> =C2=A0=C2=A0=C2=A0 done
> =C2=A0=C2=A0=C2=A0 poke_file "$img" "$ofs" "$str"
> }

Much better indeed.

>> +
>> +# poke_file_be 'test.img' 512 2 65279
>> +poke_file_be()
>> +{
>> +=C2=A0=C2=A0=C2=A0 local img=3D$1 ofs=3D$2 len=3D$3 val=3D$4 str=3D''
>=20
> And this one's even easier: we get big-endian for free from printf
> output, with a sed post-processing to add \x:
>=20
> poke_file_be()
> {
> =C2=A0=C2=A0=C2=A0 local str=3D"$(printf "%0$(($3 * 2))x\n" $4 | sed 's/\=
(..\)/\\x\1/g')"
> =C2=A0=C2=A0=C2=A0 poke_file "$1" "$2" "$str"
> }

Thanks.  I knew I could count on you. :)

Max


--eJ6D7pvqn1oNMwjkhAmGSZtEVi6AqtcKK--

--tXZ36kMzjmTiAKbFgMuCg2ojsxTJcm9ES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5nzNYACgkQ9AfbAGHV
z0BhhAgAtPqjgaRdx0I6l4vvKKr0WXAheOhOiAYYJwi8vwOuD/4fRz+xG1M3sPnS
iYhO5iPNMqTc29GvG9+3ZvM4n+WQg6usbFO+gvd4V36tnX1O93Wu2vYxTI6B9GfR
MXgKdSonR/AFakHIoYT1MoL9g74bXGyEcl9Sg2y1ZvT9yYWDgadGTMkV/QHUN7Lj
Mb/AssabPiWkHLCQe/G6bYRJju855gSvY0SDfhO/BEXljvYWirDHReaU9yDbXEGt
uBZDMtqtNwJIgKtdf7wp5Ar3Th9Pq0xSkCL7u2MKWjMezaKAjosdMFa7RKysJJ8V
v2zombS04p6gbo0DPYif56MVjcnmSA==
=nsRu
-----END PGP SIGNATURE-----

--tXZ36kMzjmTiAKbFgMuCg2ojsxTJcm9ES--


