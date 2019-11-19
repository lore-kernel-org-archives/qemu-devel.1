Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35497C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F406A22304
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwElsRvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F406A22304
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzwi-0001c3-2x
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWzvm-00017e-6F
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:36:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWzvk-0006e5-U7
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:36:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWzvk-0006dy-QC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574156176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PH0QkOAD1SD1evqNzaTL2urt6mrJrcZqQFe7a/BMU4Y=;
 b=gwElsRvZ7DdkNosbNUQzrSJSg+kfFdOtARZYUIahWDev6MQM59k96zjZTr4I7hLCr8v8QP
 yuFpt5+eNFGkGagGtgyzFhLxbCKX7TqHaANS697mXrS63CaRyK5ndWu4aZ9MdUEycp0ioo
 ZQSckMWMj1kfsaTzTGKapa3R3gWLbZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-akF84im8PzW5z1eGRn3gzw-1; Tue, 19 Nov 2019 04:36:13 -0500
X-MC-Unique: akF84im8PzW5z1eGRn3gzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C62D41060DB8;
 Tue, 19 Nov 2019 09:36:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BECF5E24D;
 Tue, 19 Nov 2019 09:36:06 +0000 (UTC)
Subject: Re: [PATCH v3 0/8] blockdev: avoid acquiring AioContext lock twice at
 do_drive_backup and do_blockdev_backup
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191112113012.71136-1-slp@redhat.com>
 <157359898425.22470.3655469789274855006@37313f22b938>
 <87pnhwt9xm.fsf@redhat.com> <87h837ucxa.fsf@redhat.com>
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
Message-ID: <34ffd31f-66c4-59f5-ead1-b2df449ecee6@redhat.com>
Date: Tue, 19 Nov 2019 10:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87h837ucxa.fsf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="U3LUMMDu0F3UVMx3qSIACnxo50fwLfIm8"
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U3LUMMDu0F3UVMx3qSIACnxo50fwLfIm8
Content-Type: multipart/mixed; boundary="ZW2bQzIaupLTer9CcDKFmzv8YaED2U1xK"

--ZW2bQzIaupLTer9CcDKFmzv8YaED2U1xK
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.11.19 14:24, Sergio Lopez wrote:
>=20
> Sergio Lopez <slp@redhat.com> writes:
>=20
>> no-reply@patchew.org writes:
>>
>>> Patchew URL: https://patchew.org/QEMU/20191112113012.71136-1-slp@redhat=
.com/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
>>> their output below. If you have Docker installed, you can probably repr=
oduce it
>>> locally.
>>>
>>> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
>>> #!/bin/bash
>>> make docker-image-centos7 V=3D1 NETWORK=3D1
>>> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
>>> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>>>
>>>   TEST    iotest-qcow2: 268
>>> Failures: 141
>>
>> Hm... 141 didn't fail in my test machine. I'm going to have a look.
>=20
> So here's the output:
>=20
> --- /root/qemu/tests/qemu-iotests/141.out=092019-11-12 04:43:27.651557587=
 -0500
> +++ /root/qemu/build/tests/qemu-iotests/141.out.bad=092019-11-13 08:12:06=
.575967337 -0500
> @@ -10,6 +10,8 @@
>  Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT backing_fmt=3DIMGFMT
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job0"}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "paused", "id": "job0"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job0"}}
>  {"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node i=
s used as backing hd of 'NODE_NAME'"}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "job0"}}
>=20
> Those extra lines, the "paused" and "running", are a result of the job
> being done in a transaction, within a drained section.
>=20
> We can update 141.out, but now I'm wondering, was it safe creating the
> job at do_drive_backup() outside of a drained section, as
> qmp_drive_backup was doing?

I think it is.  Someone needs to drain the source node before attaching
the job filter (which intercepts writes), and bdrv_backup_top_append()
does precisely this.

If the source node is in an I/O thread, you could argue that the drain
starts later than when the user has invoked the backup command, and so
some writes might slip through.  That=92s correct.  But at the same time,
it=92s impossible to drain it the instant the command is received.  So
some writes might always slip through (and the drain will not stop them
either, it will just let them happen).

Therefore, I think it=92s fine the way it is.

> Do you think there may be any potential drawbacks as a result of always
> doing it now inside a drained section?

Well, one drawback is clearly visible.  The job goes to paused for no
reason.

Max


--ZW2bQzIaupLTer9CcDKFmzv8YaED2U1xK--

--U3LUMMDu0F3UVMx3qSIACnxo50fwLfIm8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Tt4UACgkQ9AfbAGHV
z0AzhAf/VQ7zAsGYUObwCFwlrpGQR2opdCK0Lz6HffO1JMqNVR3kGc8Hg3bS7xL6
P0mvWbxLyeoTxD79T/PIxCehNf6d/OJr5qS8iYbSM3Vo4AgcZz5XS8/dJob3kIRp
azssPATkS0o58qrYSgKq69iLMQy7Y8pWXQ1aWsBraouahSkKGve8kwYGDoIOR0HI
dkJm9pl23jAQhbngbPSnvPUAW4igOFLZYVOIUmQUM3tfDqHnWemgHP0oEL62nKCO
zRY7vLnYU0M47PodsO/EWgAAt04rG+gip1wdtmPJe1izFM3g48jUnM5bXt1EHlZH
pwrSHZ03dMmpCiRTPh7BfHgxWRwSRA==
=Xug7
-----END PGP SIGNATURE-----

--U3LUMMDu0F3UVMx3qSIACnxo50fwLfIm8--


