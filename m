Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF51C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:20:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155AB21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEkXn2VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155AB21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XKF-0006HX-7v
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6XJI-0004xG-0G
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6XJG-0002sJ-RK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27846
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6XJG-0002rw-Gs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582625966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P+753CdsIAdHZ7HpOoaLKyM7RnPbCesRbPwpTupD1qk=;
 b=DEkXn2VAFCBB+s2zawdFuFlez2Ba/CBdFYF9itpO9fK4txcTR0O/zfHHbddqubV5E3jm2y
 lW4q6VfRWzdgi70/eurdZwnG0ezlif+GcegHXJ+jjQnAHiOq5OMxcIDeJghn/AQ8+zWSPC
 1u8X6EqkwXXsJKUvx5mb0axrpWAadaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-xR3Mq_sMPsGBI9Mw3JH4jg-1; Tue, 25 Feb 2020 05:19:21 -0500
X-MC-Unique: xR3Mq_sMPsGBI9Mw3JH4jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2A6D1882CD6;
 Tue, 25 Feb 2020 10:19:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F52F101D489;
 Tue, 25 Feb 2020 10:19:18 +0000 (UTC)
Subject: Re: [PULL 11/18] block: Generic file creation fallback
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200220160710.533297-1-mreitz@redhat.com>
 <20200220160710.533297-12-mreitz@redhat.com>
 <CAFEAcA8YFHy9uf5WXP0qwkRkcxgC1ufOYDXQExsV8AVgU5OReQ@mail.gmail.com>
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
Message-ID: <9ac108c0-860c-fc1e-602a-c597c1691ff0@redhat.com>
Date: Tue, 25 Feb 2020 11:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8YFHy9uf5WXP0qwkRkcxgC1ufOYDXQExsV8AVgU5OReQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BgWP2bjsoj1tlrcRw8WQWwxSoowtw7d0f"
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BgWP2bjsoj1tlrcRw8WQWwxSoowtw7d0f
Content-Type: multipart/mixed; boundary="PC6FitPxW7St7yBEcz8ZMwX9g3DYkUqeu"

--PC6FitPxW7St7yBEcz8ZMwX9g3DYkUqeu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.02.20 11:05, Peter Maydell wrote:
> On Thu, 20 Feb 2020 at 16:11, Max Reitz <mreitz@redhat.com> wrote:
>>
>> If a protocol driver does not support image creation, we can see whether
>> maybe the file exists already.  If so, just truncating it will be
>> sufficient.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Message-Id: <20200122164532.178040-3-mreitz@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Hi; Coverity thinks there's a memory leak in the error
> codepaths in this function (CID 1419884): is it right?

Yes, it is, I=E2=80=99ll write a patch.

>> +static int bdrv_create_file_fallback(const char *filename, BlockDriver =
*drv,
>> +                                     QemuOpts *opts, Error **errp)
>> +{
>> +    BlockBackend *blk;
>> +    QDict *options =3D qdict_new();
>=20
> We create the QDict here...
>=20
>> +    int64_t size =3D 0;
>> +    char *buf =3D NULL;
>> +    PreallocMode prealloc;
>>      Error *local_err =3D NULL;
>>      int ret;
>>
>> +    size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
>> +    buf =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
>> +    prealloc =3D qapi_enum_parse(&PreallocMode_lookup, buf,
>> +                               PREALLOC_MODE_OFF, &local_err);
>> +    g_free(buf);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return -EINVAL;
>=20
> ...but here and in other error return paths we don't
> free it (I think that might need a qobject_unref() but
> am not sure).
>=20
>> +    }
>> +
>> +    if (prealloc !=3D PREALLOC_MODE_OFF) {
>> +        error_setg(errp, "Unsupported preallocation mode '%s'",
>> +                   PreallocMode_str(prealloc));
>> +        return -ENOTSUP;
>> +    }
>=20
> (You could probably postpone qdict_new() to here to avoid
> having to change the error handling paths above this point, but
> you still need to deal with the error path for blk_new_open failing.)

Indeed.  Or maybe put the unref() under the out label and set @options
to NULL after it=E2=80=99s captured by @blk.  I=E2=80=99ll see.

>> +
>> +    qdict_put_str(options, "driver", drv->format_name);
>> +
>> +    blk =3D blk_new_open(filename, NULL, options,
>> +                       BDRV_O_RDWR | BDRV_O_RESIZE, errp);
>> +    if (!blk) {
>> +        error_prepend(errp, "Protocol driver '%s' does not support imag=
e "
>> +                      "creation, and opening the image failed: ",
>> +                      drv->format_name);
>> +        return -EINVAL;
>> +    }
>=20
> I guess for error-paths after blk_new_open() succeeds
> that the blk object owns the options dictionary and
> will deal with unreffing it for us?

Yes.

Max

>> +
>> +    size =3D create_file_fallback_truncate(blk, size, errp);
>> +    if (size < 0) {
>> +        ret =3D size;
>> +        goto out;
>> +    }
>> +
>> +    ret =3D create_file_fallback_zero_first_sector(blk, size, errp);
>> +    if (ret < 0) {
>> +        goto out;
>> +    }
>> +
>> +    ret =3D 0;
>> +out:
>> +    blk_unref(blk);
>> +    return ret;
>> +}
>=20
> thanks
> -- PMM
>=20



--PC6FitPxW7St7yBEcz8ZMwX9g3DYkUqeu--

--BgWP2bjsoj1tlrcRw8WQWwxSoowtw7d0f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5U9KQACgkQ9AfbAGHV
z0D1aQgArmY/C6aJVRDYvgR16YxMBe0WBKxJnNT1xlSXEZezaKfT10p7gBDaGMYh
ZknZ54ToMt9aLUlt6FcLBoXROTLmFuGLET56QS4V023ObXqF5PFL0yW3IJUsxzvN
xk/ICiwS0lpFVG4x0Kg94tqO1INsjUPEeH0ixij072IO5ZR1e0/71DO2dYf02yKB
y2g5tpl10lZyBT3W6yNESSSRft/drZanqdGXar2lGFMxph3OIf2IzCSv3SrXt6n3
DCqbF/zdEoJOvIALfAooJKUKWXRgWdynZAKnVKT/zUFCdrENimKXI2QwSNtpEbH7
LYQIYkST75j1KnJVSoniCjM5k5Y2Kg==
=cDIU
-----END PGP SIGNATURE-----

--BgWP2bjsoj1tlrcRw8WQWwxSoowtw7d0f--


