Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B6C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110E421741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6S+BBF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110E421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izi2X-0001CF-6y
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izi1b-0000K8-VG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izi1X-0001i7-Gp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:20:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49463
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izi1X-0001g7-CZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580998854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Lz95xRktdP9KlbzaKPpgfKypflDSYX5X64lp4MhxmvQ=;
 b=d6S+BBF8dmq8/eS+ND/ct9D9up6U9aDyaHu2f3RkCJ4ITCxDPHtkYvMDkfr6CCmX4O/OWk
 F6LUIwlyVPm+mLw6gq08EXbj1SfpOQD7MOAHoiCfv2KJYkOME7QSDWyf8NiyPKu5xEhG3q
 jSInWBA5CTBzsmTOtxw3tqyqHv4AByk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-7hmfCGrWMfaQ5V2sTo3rqQ-1; Thu, 06 Feb 2020 09:20:50 -0500
X-MC-Unique: 7hmfCGrWMfaQ5V2sTo3rqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C247918B6417;
 Thu,  6 Feb 2020 14:20:49 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06588857BF;
 Thu,  6 Feb 2020 14:20:42 +0000 (UTC)
Subject: Re: [PATCH 02/13] qcrypto-luks: implement encryption key management
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200130125319.GD1891831@redhat.com>
 <87zhe5ovbv.fsf@dusky.pond.sub.org> <20200130150108.GM1891831@redhat.com>
 <877e18oq76.fsf@dusky.pond.sub.org> <87mu9xxwzv.fsf@dusky.pond.sub.org>
 <20200205093011.GA5768@dhcp-200-226.str.redhat.com>
 <87tv45wdui.fsf@dusky.pond.sub.org>
 <20200205110250.GB5768@dhcp-200-226.str.redhat.com>
 <87blqdgl70.fsf@dusky.pond.sub.org> <87blqbu8xe.fsf@dusky.pond.sub.org>
 <20200206134918.GM2391707@redhat.com>
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
Message-ID: <f5f7380d-d5b3-65ce-96c9-5fb3c75d050a@redhat.com>
Date: Thu, 6 Feb 2020 15:20:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206134918.GM2391707@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E7yktZxFmwh8SAwUbGLngDe7SRG4t3B0p"
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E7yktZxFmwh8SAwUbGLngDe7SRG4t3B0p
Content-Type: multipart/mixed; boundary="VMRZ2XI2Qqi10dU8LajXNHHYwt3HATCRW"

--VMRZ2XI2Qqi10dU8LajXNHHYwt3HATCRW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.20 14:49, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Feb 06, 2020 at 02:44:45PM +0100, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>
>>>> Am 05.02.2020 um 11:03 hat Markus Armbruster geschrieben:
>>>>> Kevin Wolf <kwolf@redhat.com> writes:
>> [...]
>>>>>> Adding a key gets more complicated with your proposed interface beca=
use
>>>>>> state must be set explicitly now whereas before it was derived
>>>>>> automatically from the fact that if you give a key, only active make=
s
>>>>>> sense.
>>>>>
>>>>> The explicitness could be viewed as an improvement :)
>>>>
>>>> Not really. I mean, I really know to appreciate the advantages of
>>>> -blockdev where needed, but usually I don't want to type all that stuf=
f
>>>> for the most common tasks. qemu-img amend is similar.
>>>>
>>>> For deleting, I might actually agree that explicitness is an
>>>> improvement, but for creating it's just unnecessary verbosity.
>>>>
>>>>> If you'd prefer implicit here: Max has patches for making union tags
>>>>> optional with a default.  They'd let you default active to true.
>>>>
>>>> I guess this would improve the usability in this case.
>>
>> Thinking and writing in the "Making QEMU easier for management tools and
>> applications" monster thread have made me realize we're mixing up two
>> aspects that ought to be kept separate: machine-friendly QMP and
>> human-friendly CLI.
>>
>> You argue that
>>
>>     $ qemu-img amend -o encrypt.keys.0.new-secret=3Dsec0 test.qcow2
>>
>> is nicer than
>>
>>     $ qemu-img amend -o encrypt.keys.0.state=3Dactive,encrypt.keys.0.sec=
ret=3Dsec0 test.qcow2
>>
>> and you do have a point: humans want their CLI terse.  Redundancy is
>> unwanted, except perhaps to protect users from dangerous accidents.  In
>> this example, state=3Dactive is redundant when a secret is given, becaus=
e
>> anything else would be an error.
>>
>> In QMP, however, we like things simple and explicit, and we eschew
>> magic.
>>
>> This particular magic might just be simple enough to be acceptable in
>> QMP.  We'd "merely" have to support explicit defaults in the schema (a
>> clear improvement if you ask me), and optional union tags (tolerable as
>> long as the default comes from the schema, I guess).
>>
>> My point is: QAPI schema design *must* focus on QMP and nothing else.
>> If we try to serve both QMP and human-friendly CLI, we'll likely botch
>> both.
>>
>> I believe a truly human-friendly CLI requires more than just
>> human-friendly concrete syntax for QMP.  Same as HMP, really.
>=20
> A human-friendly approach to this problem would never even
> have the generic "amend" design IMHO. Friendly would be to
> have a CLI that is approx the same as "cryptsetup" provides
> eg
>=20
>     $ qemu-img add-key /path/to/disk
>     enter key>..
>     re-enter key>...
>=20
> or
>=20
>     qemu-img add-key --keyfile /some/file.txt /path/to/disk

I have only scanned through the discussion up until this point, but I
agree that amend doesn=E2=80=99t need to be human-friendly at all cost.

If we really want a human-friendly keyslot modification interface, we
can always add a specific qemu-img subcommand that provides high-level
succinct operations based on a low-level and more verbose amend interface.

(Or just a script that isn=E2=80=99t even built into qemu-img, because I su=
ppose
such a operation =E2=80=9Ctranslation=E2=80=9D would be easier to implement=
 in a
scripting language.  Maybe qemu-img could be extended to invoke external
scripts for specific subcommands?  But anyway, those would all be ideas
for the future.)

Max


--VMRZ2XI2Qqi10dU8LajXNHHYwt3HATCRW--

--E7yktZxFmwh8SAwUbGLngDe7SRG4t3B0p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48ILkACgkQ9AfbAGHV
z0AGqwf/f4KH6XLpvnk2wyqcPhFduiA2Y4RkNXFhmO7bI4WZG1Zfvk/1Xr3HPE+n
M7tqfIACKgtzEFGVBTNvZRp6/Iz+dBMCXiNYrJBZWMSChurRr2D/bm173irmNTuY
RlJ1BOACHOz2vu0KBNHxGUVCX9ehsFfFma9nka1RUckBM3yCu4LcQV0cpusw49b3
zX0CTlg2RLqf9lAPFqa9Hb8WGk7sV9BwD6Ogx/FluwqASqujtyjts7ePLUEopeVV
NxGcThRs7vxS8uUzz650XfGYWyfBR1jsa/sy/IoTosKt6IyCBaEQ68jDbKXzovHS
rhq+IWCNToSq06PbBYlNN9lIpWJ4Dg==
=PE9u
-----END PGP SIGNATURE-----

--E7yktZxFmwh8SAwUbGLngDe7SRG4t3B0p--


