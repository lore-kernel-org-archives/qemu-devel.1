Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E21BC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688522467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fzx5BBnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688522467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGgu-0007gF-JT
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiGg5-00076a-Ca
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:42:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiGg3-0002eG-MJ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:42:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21776
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiGg3-0002Xd-E8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576842157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cmx53BLtrS6c5bDrWq/raR8FBeN5uEQ1Wl68SDh5GbM=;
 b=Fzx5BBnTpRkDAhZkUQzAs54JMeSAJNuQbK/6s4PajKigD2HykqKjBX/2crfmHTou6tX5l7
 IY7dUkzI6GbyGHM12VhS1bcb9pEic1qwIvhS1il60fvcq3ttkF5PfROUF7UkzhP308nIa7
 XZgyUkWJU+9ANiRTcXXO12s9MoocRvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-XeteUJMgN4KqQjV0hQ0jdg-1; Fri, 20 Dec 2019 06:42:34 -0500
X-MC-Unique: XeteUJMgN4KqQjV0hQ0jdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C140801E6D;
 Fri, 20 Dec 2019 11:42:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2E3226FB3;
 Fri, 20 Dec 2019 11:42:31 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 18/23] iotests: Add VM.assert_block_path()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-19-mreitz@redhat.com>
 <16697362-7d89-74a0-53d4-7d9d48a1386a@virtuozzo.com>
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
Message-ID: <a24fc116-52a4-c08a-6505-d4ee28b28613@redhat.com>
Date: Fri, 20 Dec 2019 12:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <16697362-7d89-74a0-53d4-7d9d48a1386a@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6YE5NveLmyDzaXnXhp3T9dAE3MiF1Eroc"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6YE5NveLmyDzaXnXhp3T9dAE3MiF1Eroc
Content-Type: multipart/mixed; boundary="mW61bOmkPoglyxidOBi8RNzp2xuBWljoT"

--mW61bOmkPoglyxidOBi8RNzp2xuBWljoT
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.12.19 12:27, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2019 19:02, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/iotests.py | 59 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.=
py
>> index d34305ce69..3e03320ce3 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -681,6 +681,65 @@ class VM(qtest.QEMUQtestMachine):
>>  =20
>>           return fields.items() <=3D ret.items()
>>  =20
>> +    """
>> +    Check whether the node under the given path in the block graph is
>> +    @expected_node.
>> +
>> +    @root is the node name of the node where the @path is rooted.
>> +
>> +    @path is a string that consists of child names separated by
>> +    slashes.  It must begin with a slash.
>> +
>> +    Examples for @root + @path:
>> +      - root=3D"qcow2-node", path=3D"/backing/file"
>> +      - root=3D"quorum-node", path=3D"/children.2/file"
>> +
>> +    Hypothetically, @path could be empty, in which case it would point
>> +    to @root.  However, in practice this case is not useful and hence
>> +    not allowed.
>> +
>> +    @expected_node may be None.
>> +
>> +    @graph may be None or the result of an x-debug-query-block-graph
>> +    call that has already been performed.
>> +    """
>> +    def assert_block_path(self, root, path, expected_node, graph=3DNone=
):
>> +        if graph is None:
>> +            graph =3D self.qmp('x-debug-query-block-graph')['return']
>> +
>> +        iter_path =3D iter(path.split('/'))
>> +
>> +        # Must start with a /
>> +        assert next(iter_path) =3D=3D ''
>> +
>> +        node =3D next((node for node in graph['nodes'] if node['name'] =
=3D=3D root),
>> +                    None)
>> +
>> +        for path_node in iter_path:
>=20
> I'd rename path_node to child or edge, to not interfere with block nodes =
here.

Sure.  Or maybe child_name.

Max


--mW61bOmkPoglyxidOBi8RNzp2xuBWljoT--

--6YE5NveLmyDzaXnXhp3T9dAE3MiF1Eroc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl38s6YACgkQ9AfbAGHV
z0AQ3gf/UK4LD2kONawj2iHbi7GRIHFBhMLn5JAE8AaS3v3K5IFJN7dmt9zztdFp
rL6JhQtoKab1koyTsLpJclWLPXwtPntN9OcMBpmOpeFrrGPDkieAOSURH+I9RFtU
/rNEEqIHJdr1/CETlmsewMxoZm3tXeRXKmfWXw6863C9xtMuDoH6psE5AZSNefzw
0qA1kYWokIkcQq7mhuULGPxezi3rxxuv7JJawVJzE+UEpJR23Ke3sU5BX+9PAaFe
TAYxBNCOWsv5q/66ARif6yKPtNIvdb0SVZK+Ez5PyP4e2aOMVuuhEzf4ezJy1Xo2
hsjhowD/frfYLwsPZlkVXzb2YZAe7g==
=Om1w
-----END PGP SIGNATURE-----

--6YE5NveLmyDzaXnXhp3T9dAE3MiF1Eroc--


