Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B7AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B98206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4Akychf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B98206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC1F-0004iM-RI
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC0U-0003bg-PD
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:52:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC0S-0000sa-SC
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h/keYVa/RQ1nchMl00Bkwp+1BGlVXQLRPx0yDc6gsmU=;
 b=G4AkychfaC3ts/W62EuIwJ7TwNtc4j5GTH4kvbp7wsAg4HWpS1WvPwrlV02Tqr75pxXrSE
 i9J8XS35ADdLNevSNLXL0GdnwiuH+e2x9K6pVY8UDWBFI7ZIcNUhlPAfw0knwnlNrXG8+W
 zrXkH9QenaB5pj6oPHDxiiG65njnXBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-RaP93JuWMnmLIw9JGQGq2A-1; Tue, 30 Jun 2020 04:52:41 -0400
X-MC-Unique: RaP93JuWMnmLIw9JGQGq2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12095107ACF3;
 Tue, 30 Jun 2020 08:52:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E14237FE9C;
 Tue, 30 Jun 2020 08:52:39 +0000 (UTC)
Subject: Re: [PATCH 05/19] iotests.py: Add (verify|has)_working_luks()
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20200625125548.870061-1-mreitz@redhat.com>
 <20200625125548.870061-6-mreitz@redhat.com>
 <64a986ceccb48c45aaf9910c9a0ab865916b6fa6.camel@redhat.com>
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
Message-ID: <85fe6726-0bac-f991-a3cb-c4adbfd29582@redhat.com>
Date: Tue, 30 Jun 2020 10:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <64a986ceccb48c45aaf9910c9a0ab865916b6fa6.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dU0ubZ5s0QM0yQeeudjH7iPAyW0FbVa6K"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dU0ubZ5s0QM0yQeeudjH7iPAyW0FbVa6K
Content-Type: multipart/mixed; boundary="EyJJi9aXamUaydEeWGVjiKfjtoiXl9DwF"

--EyJJi9aXamUaydEeWGVjiKfjtoiXl9DwF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.06.20 12:12, Maxim Levitsky wrote:
> On Thu, 2020-06-25 at 14:55 +0200, Max Reitz wrote:
>> Similar to _require_working_luks for bash tests, these functions can be
>> used to check whether our luks driver can actually create images.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 39 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.=
py
>> index eee94e18cc..039170a8a3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -1052,6 +1052,45 @@ def verify_quorum():
>>      if not supports_quorum():
>>          notrun('quorum support missing')
>> =20
>> +def has_working_luks() -> Tuple[bool, str]:
>> +    """
>> +    Check whether our LUKS driver can actually create images
>> +    (this extends to LUKS encryption for qcow2).
>> +
>> +    If not, return the reason why.
>> +    """
>> +
>> +    img_file =3D f'{test_dir}/luks-test.luks'
>> +    (output, status) =3D \
>> +        qemu_img_pipe_and_status('create', '-f', 'luks',
>> +                                 '--object', luks_default_secret_object=
,
>> +                                 '-o', luks_default_key_secret_opt,
>> +                                 '-o', 'iter-time=3D10',
>> +                                 img_file, '1G')
>> +    try:
>> +        os.remove(img_file)
>> +    except OSError:
>> +        pass
>> +
>> +    if status !=3D 0:
>> +        reason =3D output
>> +        for line in output.splitlines():
>> +            if img_file + ':' in line:
>> +                reason =3D line.split(img_file + ':', 1)[1].strip()
>> +                break
>> +
>> +        return (False, reason)
>> +    else:
>> +        return (True, '')
>> +
>> +def verify_working_luks():
>> +    """
>> +    Skip test suite if LUKS does not work
>> +    """
>> +    (working, reason) =3D has_working_luks()
>> +    if not working:
>> +        notrun(reason)
>> +
>>  def qemu_pipe(*args):
>>      """
>>      Run qemu with an option to print something and exit (e.g. a help op=
tion).
>=20
> It just occured to me that we can have a situation when luks driver is bl=
acklisted
> (via block driver blacklist "--block-drv-whitelist=3D") then this test.
>=20
> THe whilelist only affects the qmp it seems so this check doesn't catch i=
t,=20
> plus you could have case when luks driver is blacklisted but qcow2 isn't

Yes, the whitelist only affects qemu proper, not qemu-img.

> When I build qemu with
> '--block-drv-whitelist=3D'raw,qcow2' I was able to break iotests 295 296
> But this is such a non issue, that I am just noting for reference.

Hm.  If anything, that=E2=80=99s actually a problem in the test infrastruct=
ure,
isn=E2=80=99t it?  For example, if you don=E2=80=99t whitelist qcow2, then =
all qcow2
tests break.  Ideally, they shouldn=E2=80=99t.  The test infrastructure sho=
uld
check whether the format used to run the test ($IMGFMT) is actually
supported (e.g. iotests.py=E2=80=99s _verify_image_format() could check whe=
ther
the format is actually in supported_formats()), and if it isn=E2=80=99t, sk=
ip
the test.

OTOH, that=E2=80=99s pretty much the user=E2=80=99s fault for using an $IMG=
FMT that they
didn=E2=80=99t whitelist, so I=E2=80=99m not sure whether we=E2=80=99re act=
ually keen on fixing
that.

*shrug* O:)

Max


--EyJJi9aXamUaydEeWGVjiKfjtoiXl9DwF--

--dU0ubZ5s0QM0yQeeudjH7iPAyW0FbVa6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl76/VUACgkQ9AfbAGHV
z0BmgggAm4H0CNJ/RR6FNIXwuhYbmbDLo+iV4Uer+hmnnRIbuaICr/vO8Z9f/rTr
au5cEIe6u0hYV2kTpi7HRzNuqk/Wegs87rOwMpE34Cwt0DqVV+368V72E2cGpHpl
XmPPWNrNdzXVH0FqWgJKq+4sqyMn/TvUGyrusHuIJDcsyz7KKCKKrR67yNZMxRBq
SFKZqMtl8GzePyIJzHiuJmFOK+7+DU23W1Yzbd/EH1IobZ/7Nsb0+3uhUixmmyRD
gCtqX+nqckjyyO7H/KTwbjOf1R0ZyUTFp8cZ0G0SHUqZTvulsoIAJKi8WBdAUFR1
YdbcvjzGSTjMn/yegXRHiMcN9xsDRA==
=1G9L
-----END PGP SIGNATURE-----

--dU0ubZ5s0QM0yQeeudjH7iPAyW0FbVa6K--


