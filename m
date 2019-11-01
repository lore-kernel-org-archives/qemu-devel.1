Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1380CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC326222CB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrG2Ar8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC326222CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZTL-00046V-Jw
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQZNp-0007G5-27
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQZNm-0000jy-Ny
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:02:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47885
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQZNm-0000QO-C3
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572624153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UkS/nkj9XTBNWuex7cpymqsx5t1dyAQuwv0iXFf0l1M=;
 b=OrG2Ar8PIC8+l6rHvLbu2QgOk8YiuStmdx8RBHcbQrz63QRaxsm7r4le7aDmtV/q8mVuvw
 2VfqOdnEK3j/dcOIHv88maXf5Kn02667oKuEdKOotN/bEYBDqpaP+1Dw3WBiTWOJeyuBGw
 n54zWsDUShzmVqYjsVsItlQQy3O5I48=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-CBg6zaYiNaSHT6zTqVR8GQ-1; Fri, 01 Nov 2019 12:02:27 -0400
X-MC-Unique: CBg6zaYiNaSHT6zTqVR8GQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B5421800D67;
 Fri,  1 Nov 2019 16:02:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1EF15C297;
 Fri,  1 Nov 2019 16:02:20 +0000 (UTC)
Subject: Re: [PATCH for-4.2 1/4] Revert "qcow2: skip writing zero buffers to
 empty COW areas"
To: Kevin Wolf <kwolf@redhat.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <20191101100019.9512-2-mreitz@redhat.com>
 <c4e21028-0321-20ea-21b8-31dec87fac97@redhat.com>
 <e8f8ae20-b036-4330-4851-f099fc534f9b@redhat.com>
 <20191101154241.GA23153@localhost.localdomain>
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
Message-ID: <d6864a28-ed91-29d4-e4cc-dacc26f1b764@redhat.com>
Date: Fri, 1 Nov 2019 17:02:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101154241.GA23153@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rc09sqFmyXbTOfWoFyNuUnKtMuAzhyDjC"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rc09sqFmyXbTOfWoFyNuUnKtMuAzhyDjC
Content-Type: multipart/mixed; boundary="GN5U5G54LsBYoMt53GWKFEiMZhS4xQ6bf"

--GN5U5G54LsBYoMt53GWKFEiMZhS4xQ6bf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 16:42, Kevin Wolf wrote:
> Am 01.11.2019 um 15:01 hat Max Reitz geschrieben:
>> On 01.11.19 13:40, Eric Blake wrote:
>>> On 11/1/19 11:00 AM, Max Reitz wrote:
>>>> This reverts commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a.
>>>>
>>>> This commit causes fundamental performance problems on XFS (because
>>>> fallocate() stalls the AIO pipeline), and as such it is not clear that
>>>> we should unconditionally enable this behavior.
>>>>
>>>> We expect subclusters to alleviate the performance penalty of small
>>>> writes to newly allocated clusters, so when we get them, the originall=
y
>>>> intended performance gain may actually no longer be significant.
>>>>
>>>> If we want to reintroduce something similar to c8bb23cbdbe, it will
>>>> require extensive benchmarking on various systems with subclusters
>>>> enabled.
>>>>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>
>>>> +++ b/qapi/block-core.json
>>>> @@ -3304,8 +3304,6 @@
>>>> =C2=A0 #
>>>> =C2=A0 # @cor_write: a write due to copy-on-read (since 2.11)
>>>> =C2=A0 #
>>>> -# @cluster_alloc_space: an allocation of file space for a cluster
>>>> (since 4.1)
>>>> -#
>>>> =C2=A0 # @none: triggers once at creation of the blkdebug node (since =
4.1)
>>>
>>> Deleting released qapi is not backwards-compatible.
>>
>> Right. :-/
>>
>> I=E2=80=99ll just not make changes to the QAPI schema.  It doesn=E2=80=
=99t hurt to leave
>> this in.
>=20
> Why would it be incompatible to drop an enum value that is only ever
> used in output and that QEMU doesn't generate?

This isn=E2=80=99t output at all, it=E2=80=99s input for blockdev-add for b=
lkdebug nodes.

Max


--GN5U5G54LsBYoMt53GWKFEiMZhS4xQ6bf--

--rc09sqFmyXbTOfWoFyNuUnKtMuAzhyDjC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28VwsACgkQ9AfbAGHV
z0CK6QgAhyiqvd/SKKxBGLOPdqM6r4EadRD3Bnv+/+BgUucTVoKLg9Z5Sgeb/AZ+
jC7ps5YxuJD4Op+aaZgIlAM7HYaWLVKJDAz0Iijv3c8LtfL+35Uj6UgBM8+xI8W9
THKTUliNxz14Oum/ODoLQEpMuBx0/aPlQhNkQyTqjxYBemcc1rk6n0Ve934UWMJN
jyDLTfVDtxDdIIl4FSL39KqKAAiTxX/sduWJ17STTbvGEQkPpeQXSPj6sHGRG/CY
otmCUe2sWbWRrO3JlW+l4e4tTes41cDXvk+z4BKYJHOxn5fRBBv7Mn09CNjVKcvj
M9qyry9UFbRK4T2C+jqvRbDwy9a74Q==
=lLUt
-----END PGP SIGNATURE-----

--rc09sqFmyXbTOfWoFyNuUnKtMuAzhyDjC--


