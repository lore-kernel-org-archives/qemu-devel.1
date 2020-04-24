Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929FEC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C34F20700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yqbi8ARK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C34F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyl8-0004xv-EZ
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRybH-0008MB-B8
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRybB-0000mF-Sb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:42:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28341
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRybB-0000j3-F7
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 09:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587735751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=h6EdEaT0yTg1aFhvV5+hvZHr7Hkpw4R0DlKQgg2u/kg=;
 b=Yqbi8ARK/v3cGGDIDbAL4CW4Q/EH5x/0BZe/JVYIHZ7Rja3Ewl0UvreK2NItKvizCtFXgk
 TesjwvSK7iAy3Dm+Rsyo98QKDix8o83wlexG+/e7M5bDSaAr+VIOmqg0ks6oaGT92ELRE7
 zCdzFTawFqczzdrDZXGmffYGBviFk0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-qxjHqFLOPFujohkCasfGAQ-1; Fri, 24 Apr 2020 09:42:24 -0400
X-MC-Unique: qxjHqFLOPFujohkCasfGAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1DFE8015D2;
 Fri, 24 Apr 2020 13:42:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-192.ams2.redhat.com
 [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC70F605D1;
 Fri, 24 Apr 2020 13:42:08 +0000 (UTC)
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 elena.ufimtseva@oracle.com
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200424124823.GC189569@stefanha-x1.localdomain>
 <00786792-33e1-38cc-3d4c-1cee1e786c9e@redhat.com>
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
Message-ID: <7bc48ca0-a2da-0e3a-3c8a-d22ec1c58c28@redhat.com>
Date: Fri, 24 Apr 2020 15:42:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <00786792-33e1-38cc-3d4c-1cee1e786c9e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="agck1fOs6HuWv0D4aWpYVHUsnCjxGUGP3"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:07:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--agck1fOs6HuWv0D4aWpYVHUsnCjxGUGP3
Content-Type: multipart/mixed; boundary="jhdPvmVUDGCPnnytgj1kGpLJUBvFsxg66"

--jhdPvmVUDGCPnnytgj1kGpLJUBvFsxg66
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 14:53, Eric Blake wrote:
> On 4/24/20 7:48 AM, Stefan Hajnoczi wrote:
>> On Wed, Apr 22, 2020 at 09:13:35PM -0700, elena.ufimtseva@oracle.com
>> wrote:
>>> There is an error in travis-ci build test which does not get reproduced=
.
>>>
>>> =A0 TEST=A0=A0=A0 iotest-qcow2: 041 [fail]
>>> QEMU=A0=A0=A0=A0=A0=A0=A0=A0=A0 --
>>> "/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build=
/dir/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>>> -nodefaults -display none -accel qtest
>=20
>>> +Traceback (most recent call last):
>>> +=A0 File "041", line 1049, in test_with_other_parent
>>> +=A0=A0=A0 self.assert_qmp(result, 'return', {})
>>> +=A0 File
>>> "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotest=
s/iotests.py",
>>> line 821, in assert_qmp
>>> +=A0=A0=A0 result =3D self.dictpath(d, path)
>>> +=A0 File
>>> "/home/travis/build/elena-ufimtseva/qemu-multiprocess/tests/qemu-iotest=
s/iotests.py",
>>> line 797, in dictpath
>>> +=A0=A0=A0 self.fail('failed path traversal for "%s" in "%s"' % (path,
>>> str(d)))
>>> +AssertionError: failed path traversal for "return" in "{'error':
>>> {'class': 'GenericError', 'desc': "UNIX socket path
>>> '/home/travis/build/elena-ufimtseva/qemu-multiprocess/out-of-tree/build=
/dir/tests/qemu-iotests/scratch/nbd.sock'
>>> is too long"}}"
>>
>> UNIX Domain Socket paths have to be 108 characters or less.=A0 The path =
in
>> the failed test case is 110 characters long.=A0 You could rename your
>> branch to "mpqemu" to solve this failure.
>=20
> We recently fixed the iotests to prefer sticking NBD sockets under
> $SOCK_DIR (see commits f0e24942 and friends); did we miss test 41?

Looks more like I broke it.  Oops.  Will fix.

Max


--jhdPvmVUDGCPnnytgj1kGpLJUBvFsxg66--

--agck1fOs6HuWv0D4aWpYVHUsnCjxGUGP3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6i7K8ACgkQ9AfbAGHV
z0C16QgAs0ns9lS4maYkKwWuUMjxmZv+0e/GvVV8z7QkXPLZd8yoPjEnw8N2edbk
7F2AvFtgTA3VmGRN0vNlUne7whxqxzJ1EH9frnWtVtLQuO9tQyIB+hHLAQQ569mi
WxrxvHCRyHjaGLb+D9QMPJjzc7FGrdQyJ8/E4ZEBSblKxf/OA7GEwdGm1krn1b2a
s0FW+mDfWzXzH/lCgUI35hUtn0NTJ37Zx9Z4Oh++MGqW6D82DT6rGoxLeyT/I4BO
ah25Q+nNvCd/lL61zNeTRR+RurdO0q6J3mT7zhJr5dTtxMdEkEsi2v6SEMbFuD+r
T0a4KBOC6XlSA9JvHWniRqng+UmWBg==
=jC8y
-----END PGP SIGNATURE-----

--agck1fOs6HuWv0D4aWpYVHUsnCjxGUGP3--


