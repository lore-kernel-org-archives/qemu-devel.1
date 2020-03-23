Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E02C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B8E20658
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxLuz04+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B8E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGMiF-0001Lt-Am
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGMhE-0000Op-Jv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGMh9-0008IY-4l
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:00:48 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGMh8-0008HL-Aa
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584968439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=623LeO9w00YqzCPxLv9R4JEVojqaWd0ll6YpGmtFEC8=;
 b=ZxLuz04+Nb6LaD1toDEb/Wx5ooo4oq/YyEBOUNu122Rx1rfT9a30tmxZZ+8Sy0PIPO3wYX
 3+iusp5Kfy+N38LptU+bFG5ZWAnF7msr9WVbbHy1Eio6PQzS4LRB0S+OeZ17BBxQcq6YX6
 nctYA389UNWDwV0GK77Y0Wt/Vx6w0mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Kd9nOPFjNM-sq5dGQCxQlA-1; Mon, 23 Mar 2020 09:00:36 -0400
X-MC-Unique: Kd9nOPFjNM-sq5dGQCxQlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B262C1851C00;
 Mon, 23 Mar 2020 13:00:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E84F810002AA;
 Mon, 23 Mar 2020 13:00:33 +0000 (UTC)
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
 <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
 <a36e50a8-38c5-027d-16b8-1daa10ed378c@virtuozzo.com>
 <ad885deb-6384-700e-6a26-a2dd9e1e06f9@virtuozzo.com>
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
Message-ID: <18af3397-be93-1cf1-189b-e8298d30ec5d@redhat.com>
Date: Mon, 23 Mar 2020 14:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ad885deb-6384-700e-6a26-a2dd9e1e06f9@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2QB6bcYIhGu1uzLRWAEcYdOXQp11LqRCc"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2QB6bcYIhGu1uzLRWAEcYdOXQp11LqRCc
Content-Type: multipart/mixed; boundary="S2njvkXkXivfU4fQVbsx2F3ZmkZpFQQwC"

--S2njvkXkXivfU4fQVbsx2F3ZmkZpFQQwC
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.03.20 13:06, Vladimir Sementsov-Ogievskiy wrote:
> 12.03.2020 14:59, Vladimir Sementsov-Ogievskiy wrote:
>> 11.03.2020 14:06, Max Reitz wrote:
>>> On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
>>>> Prior to the commit the following command lead to crash:
>>>>
>>>> =A0=A0 ./qemu-io --image-opts -c 'write 0 512' \
>>>> =A0=A0 driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.siz=
e=3D512
>>>>
>>>> It failes on assertion in bdrv_aligned_pwritev:
>>>> =A0=A0 "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RE=
SIZE"
>>>>
>>>> The problem is obvious: 512 is aligned to 4096 and becomes larger than
>>>> file size. And the core bad thing is that file size is unaligned to
>>>> request_alignment.
>>>>
>>>> Let's catch such case on bdrv_open_driver and fail.
>>>
>>> I think we had a discussion on this before, but I can=92t find it right
>>> now.=A0 (Although I think that had more to do with something in the
>>> file-posix driver, because it wasn=92t limited to alignments above 512.=
)
>>>
>>> In any case, the file itself is totally valid.=A0 Most importantly, qco=
w2
>>> will regularly create files with unaligned file lengths.
>>>
>>> So let me create a qcow2 image on a 4k-aligned device:
>>>
>>> $ truncate 512M fs.img

Oops, =93truncate --size=3D512M fs.img=94, of course.

>>> $ sudo losetup -f --show -b 4096 fs.img
>>> /dev/loop0
>>> $ sudo mkfs.ext4 /dev/loop0
>>> [...]
>>> $ sudo mount /dev/loop0 /mnt/tmp
>>>
>>> $ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
>>> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
>>> cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
>>> $ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
>>> qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned t=
o
>>> request alignment
>>>
>>> Which is too bad.
>>
>> What exactly is bad?

That with this patch you can no longer create a qcow2 image on a 4k
block size medium and then open it with O_DIRECT.

>> Is it correct that create succeeded? Without new error, how would
>> qcow2 driver
>> read from unaligned tail of file-posix? It will crash, isn't it?

Well, the above test works, which is better already.

Basically part of the problem seems to be changing from unsafe caching
(during create) to O_DIRECT.  If we used O_DIRECT all the time, the
image would always be aligned to the block alignment.

Now that makes me wonder how such cases are handled right now.  Do we crash=
?

So I tried to create an image with 512 byte clusters, write to it with
normal WB caching, thus creating an image that isn=92t aligned to 4k:

$ sudo ./qemu-img create -f qcow2 -o cluster_size=3D512 \
      /mnt/tmp/foo.qcow2 64M
[...]
$ sudo ./qemu-io -c 'write -P 42 0 512' /mnt/tmp/foo.qcow2
[...]
$ printf '%x\n' $(stat -c '%s' /mnt/tmp/foo.qcow2)
4a00

(So not aligned to 4k)

$ sudo ./qemu-io -t none -c 'read -P 42 0 512' /mnt/tmp/foo.qcow2
read 512/512 bytes at offset 0
512 bytes, 1 ops; 00.00 sec (4.567 MiB/sec and 9352.6997 ops/sec)

So actually, that works just fine right now.

When I let file-posix print all pread() calls, this is what I can see:

[...]
pread(9, buf_ofs=3D+0, file_ofs=3D0x4000, size=3D0x1000)
-> 2560
pread(9, buf_ofs=3D+0xa00, file_ofs=3D0x4a00, size=3D0x600)
-> 0
[...]

So all reads are increased to the alignment (4k), and to read the data
cluster, we read all 4k from 0x4000 (even though it actually is just 512
bytes at 0x4800).  This succeeds, even though just as a partial read
(2560 =3D=3D 0xa00), so we try to read the rest of the 4k block, but that
doesn=92t work (it=92s at the EOF), and so we stop reading.

handle_aiocb_rw() then zeroes out the rest of the buffer (below the
=93out=94 label) and everyone=92s happy.

So to me it looks like it works perfectly fine right now.  No crashes.

> Hmm, it crashes only on write-part if don't have RESIZE permission.. So
> for qcow2
> everything is OK.
>=20
> And generic read don't care about reading past-EOF because of alignment,
> read is passed
> to driver.

(And only after the test, I realize that you apparently answered the
question yourself...  Oops.)

>>> So the real solution would probably...=A0 Be to align the file size up =
to
>>> the alignment?
>>
>> On creation, you mean?

Yes.  But I suspect we=92d need to do it all the time, because see my
above example: The user might access an image with WB caching at one
point, and then with O_DIRECT the next time.

But I can see two problems:

First, we don=92t even know what the block alignment is.  It=92s hard enoug=
h
to figure it out for O_DIRECT images, I=92m not sure we can reliably do so
for WB-cached images.

Second, this wouldn=92t help with pre-existing images.  And note that
=93pre-existing=94 might mean an image a user creates on an FS with 512 byt=
e
blocks and then moves it to another with 4k blocks.

So I don=92t think aligning the file size up would work, actually.  Except
if we decided to always align it up to 4k, but then we=92d still have a
problem with older pre-existing images...

Max

>>>
>>> Max
>>>
>>>> Note, that file size and request_alignment may become out of sync
>>>> later, so this commit is not full fix of the problem, but it's better
>>>> than nothing.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> =A0 block.c | 7 +++++++
>>>> =A0 1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/block.c b/block.c
>>>> index ecd09dbbfd..4cfc6c33a2 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -1324,6 +1324,13 @@ static int bdrv_open_driver(BlockDriverState
>>>> *bs, BlockDriver *drv,
>>>> =A0=A0=A0=A0=A0 assert(bdrv_min_mem_align(bs) !=3D 0);
>>>> =A0=A0=A0=A0=A0 assert(is_power_of_2(bs->bl.request_alignment));
>>>> +=A0=A0=A0 if (bs->bl.request_alignment > 512 &&
>>>> +=A0=A0=A0=A0=A0=A0=A0 !QEMU_IS_ALIGNED(bs->total_sectors,
>>>> bs->bl.request_alignment / 512))
>>>> +=A0=A0=A0 {
>>>> +=A0=A0=A0=A0=A0=A0=A0 error_setg(errp, "File size is unaligned to req=
uest
>>>> alignment");
>>>> +=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
>>>> +=A0=A0=A0 }
>>>> +
>>>> =A0=A0=A0=A0=A0 for (i =3D 0; i < bs->quiesce_counter; i++) {
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (drv->bdrv_co_drain_begin) {
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 drv->bdrv_co_drain_begin(bs);
>>>>
>>>
>>>
>>
>>
>=20
>=20



--S2njvkXkXivfU4fQVbsx2F3ZmkZpFQQwC--

--2QB6bcYIhGu1uzLRWAEcYdOXQp11LqRCc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54su8ACgkQ9AfbAGHV
z0Beygf/attrLQ5b01De7NrVuaS2hTfCpywMNIc48Mv/VJqvulvxpLmRBY3YC78p
UNsH499IK1OvHftJqFWc4HwI2tTNCecBiJwxstXpIEyE1FRXOhcaC+Q7yGBxu+cC
67UEJjNyEEHGyN42PPH518BbaGmVdjEokue9lpkCVKGic8DOKnEb2xb91Q0Gd2oy
JwYJWZzU45u7B5uD17HxUhbUuzA00sz28COg89HrmBaxeSbCaC4AkyprHG3XWJdY
a425HwHhbHpCBWSF/+ivc/TCO0LLqDuxquZerhk66elHfxgud/QmxiiGUuElh+0y
ZQhPNfO4Q5W96BUSDCma8tWS4h8YAw==
=9WxP
-----END PGP SIGNATURE-----

--2QB6bcYIhGu1uzLRWAEcYdOXQp11LqRCc--


