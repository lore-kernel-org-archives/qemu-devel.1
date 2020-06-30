Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB20C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:54:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13B94206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xg84yS27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B94206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqC2W-0006QN-BW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC1Z-0005Nq-SX
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22325
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqC1X-0000z4-2Z
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZJzLOAKpD6aX9WWCnM7Dbpe7Dm9NyQnWdEVzekZpvpM=;
 b=Xg84yS27x0VBUnnUfsDs9oxw3xKtPjFoDeYN/3lnplUIZ9JcLQT9lARncfL1Mtany8hVrO
 esCUv/PHSRGy9uckwuPJqygoZM8AvmqJIKm2TkBwtvqMaoIJ+NYQH8xrSWnGYYKO6zVh+T
 kmTzj/s1SwUKO9Xq9QBgUCseWffbUpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-O21HO7ZtNfWLGLCMiK6eSA-1; Tue, 30 Jun 2020 04:53:43 -0400
X-MC-Unique: O21HO7ZtNfWLGLCMiK6eSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C642107ACF3;
 Tue, 30 Jun 2020 08:53:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE18D289B5;
 Tue, 30 Jun 2020 08:53:40 +0000 (UTC)
Subject: Re: [PATCH 06/19] iotests: Check whether luks works
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20200625125548.870061-1-mreitz@redhat.com>
 <20200625125548.870061-7-mreitz@redhat.com>
 <2daeeb10392c783e4dbe3974f9560ee630f9672b.camel@redhat.com>
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
Message-ID: <5961e174-f1cc-e481-ef22-5b3dc9d1de18@redhat.com>
Date: Tue, 30 Jun 2020 10:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2daeeb10392c783e4dbe3974f9560ee630f9672b.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pIICZMGwXBPfNKv4CePnBvf69pVicvw3v"
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
--pIICZMGwXBPfNKv4CePnBvf69pVicvw3v
Content-Type: multipart/mixed; boundary="L6JWoaQQfFKssBi2LhDOMjCbp4f1BdK7R"

--L6JWoaQQfFKssBi2LhDOMjCbp4f1BdK7R
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.06.20 14:03, Maxim Levitsky wrote:
> On Thu, 2020-06-25 at 14:55 +0200, Max Reitz wrote:
>> Whenever running an iotest for the luks format, we should check whether
>> luks actually really works.
>>
>> Tests that try to create luks-encrypted qcow2 images should do the same.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/087        | 1 +
>>  tests/qemu-iotests/178        | 1 +
>>  tests/qemu-iotests/188        | 1 +
>>  tests/qemu-iotests/189        | 1 +
>>  tests/qemu-iotests/198        | 1 +
>>  tests/qemu-iotests/206        | 1 +
>>  tests/qemu-iotests/263        | 1 +
>>  tests/qemu-iotests/284        | 1 +
>>  tests/qemu-iotests/common.rc  | 3 +++
>>  tests/qemu-iotests/iotests.py | 5 +++++
>>  10 files changed, 16 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
>> index bdfdad3454..678e748c58 100755
>> --- a/tests/qemu-iotests/087
>> +++ b/tests/qemu-iotests/087
>> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>>  do_run_qemu()
>>  {
>> diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
>> index 7cf0e27154..f09b27caac 100755
>> --- a/tests/qemu-iotests/178
>> +++ b/tests/qemu-iotests/178
>> @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt raw qcow2
>>  _supported_proto file
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>>  echo "=3D=3D Input validation =3D=3D"
>>  echo
>> diff --git a/tests/qemu-iotests/188 b/tests/qemu-iotests/188
>> index 09b9b6083a..13b225fded 100755
>> --- a/tests/qemu-iotests/188
>> +++ b/tests/qemu-iotests/188
>> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>> =20
>>  size=3D16M
>> diff --git a/tests/qemu-iotests/189 b/tests/qemu-iotests/189
>> index c9ce9d3bed..e6a84b8a3b 100755
>> --- a/tests/qemu-iotests/189
>> +++ b/tests/qemu-iotests/189
>> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>> =20
>>  size=3D16M
>> diff --git a/tests/qemu-iotests/198 b/tests/qemu-iotests/198
>> index fb0d5a29d3..aeb059d5ea 100755
>> --- a/tests/qemu-iotests/198
>> +++ b/tests/qemu-iotests/198
>> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>> =20
>>  size=3D16M
>> diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
>> index f42432a838..11bc51f256 100755
>> --- a/tests/qemu-iotests/206
>> +++ b/tests/qemu-iotests/206
>> @@ -24,6 +24,7 @@ import iotests
>>  from iotests import imgfmt
>> =20
>>  iotests.script_initialize(supported_fmts=3D['qcow2'])
>> +iotests.verify_working_luks()
>> =20
>>  with iotests.FilePath('t.qcow2') as disk_path, \
>>       iotests.FilePath('t.qcow2.base') as backing_path, \
>> diff --git a/tests/qemu-iotests/263 b/tests/qemu-iotests/263
>> index d2c030fae9..f598a12899 100755
>> --- a/tests/qemu-iotests/263
>> +++ b/tests/qemu-iotests/263
>> @@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>> =20
>>  size=3D1M
>> diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
>> index 071e89b33e..9f6c29a79c 100755
>> --- a/tests/qemu-iotests/284
>> +++ b/tests/qemu-iotests/284
>> @@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt qcow2
>>  _supported_proto generic
>>  _supported_os Linux
>> +_require_working_luks
>> =20
>> =20
>>  size=3D1M
>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
>> index f3667f48ab..7ac46edc1f 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -605,6 +605,9 @@ _supported_fmt()
>>      # setting IMGFMT_GENERIC to false.
>>      for f; do
>>          if [ "$f" =3D "$IMGFMT" -o "$f" =3D "generic" -a "$IMGFMT_GENER=
IC" =3D "true" ]; then
>> +            if [ "$IMGFMT" =3D "luks" ]; then
>> +                _require_working_luks
>> +            fi
>>              return
>>          fi
>>      done
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.=
py
>> index 039170a8a3..e1ddfcb662 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -1010,12 +1010,17 @@ def _verify_image_format(supported_fmts: Sequenc=
e[str] =3D (),
>>          # similar to
>>          #   _supported_fmt generic
>>          # for bash tests
>> +        if imgfmt =3D=3D 'luks':
>> +            verify_working_luks()
>>          return
>> =20
>>      not_sup =3D supported_fmts and (imgfmt not in supported_fmts)
>>      if not_sup or (imgfmt in unsupported_fmts):
>>          notrun('not suitable for this image format: %s' % imgfmt)
>> =20
>> +    if imgfmt =3D=3D 'luks':
>> +        verify_working_luks()
>> +
>>  def _verify_protocol(supported: Sequence[str] =3D (),
>>                       unsupported: Sequence[str] =3D ()) -> None:
>>      assert not (supported and unsupported)
>=20
>=20
> If I understand correctly all raw luks tests are now under the condition =
that
> luks works, and qcow2 tests are added to this manually for the tests that
> use encryption. Seems fair to me.
>=20
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>=20
>=20
> PS: I also run the iotests with luks and qcow2, and it works fine.
>=20
> Note that iotest 051 is broken (regardless of these patches)
>=20
> 051      fail       [14:18:42] [14:18:49]                    output misma=
tch (see 051.out.bad)
> --- /home/mlevitsk/UPSTREAM/qemu/src/tests/qemu-iotests/051.pc.out=092020=
-06-07 12:50:28.037624714 +0300
> +++ /home/mlevitsk/UPSTREAM/qemu/build_luks/tests/qemu-iotests/051.out.ba=
d=092020-06-29 14:18:49.372420624 +0300
> @@ -142,7 +142,7 @@
> =20
>  Testing: -drive if=3Dide
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: Initialization of device ide-hd failed: Device needs m=
edia, but drive is empty
> +(qemu) QEMU_PROG: Device needs media, but drive is empty
> =20
>  Testing: -drive if=3Dvirtio
>  QEMU X.Y.Z monitor - type 'help' for more information
> @@ -214,7 +214,7 @@
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dide,readonly=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> -(qemu) QEMU_PROG: Initialization of device ide-hd failed: Block node is =
read-only
> +(qemu) QEMU_PROG: Block node is read-only
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dvirtio,readonly=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> Failures: 051
> Failed 1 of 1 iotests
>=20
>=20
> It seem to use an pc machine type specific 'out' file, thus I might have =
something wrong in my enviroment.

No, it isn=E2=80=99t just you.  The patch to fix that is in my pull request=
:

https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg01159.html

Max


--L6JWoaQQfFKssBi2LhDOMjCbp4f1BdK7R--

--pIICZMGwXBPfNKv4CePnBvf69pVicvw3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl76/ZMACgkQ9AfbAGHV
z0BADAf9FI7uW0+cTsemUofqk5u4+Aajks9/uDhkzScLTVa5KOf3N9pOUdBsm0MM
tYi61NPeOSLMqm36T61HRlePWsvnGg+Eob8i/eJcKFjVKP67H6xEb3Rn3/0mVXyk
0xpAdIFux3DkRclYIqRaSc50I+j6fcZs17cEw++StOUb1YHqzI8a1segdSZVMSQ/
rKT9ZJh7u8/CeFsCLtGb/8N5K0D1ISHKke05Bv2iQY5WbCmhV74g6/dppfjd5ImN
TsNeZaAwnA3BMBDVYZj0IlgyjAfrLdqPcRBlNXDS0AwbsUFDqKWjSsGTgua8GpPA
1t7lvcYE3BQm/cSbqeXzXv5Q303aew==
=NUN3
-----END PGP SIGNATURE-----

--pIICZMGwXBPfNKv4CePnBvf69pVicvw3v--


