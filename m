Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0870C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA9520728
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 07:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvojWaPk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA9520728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSyXA-0001WF-ID
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 03:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jSyVx-0000oM-QQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jSyVw-0005SU-GA
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:49:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52685
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jSyVw-0005S7-3V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 03:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587973754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YQWuvsVKnxqVvQumMXOmnfnH9ZwRn9h4BizBtPqCA58=;
 b=XvojWaPkxYia8Z3KWIzNDCenw8BVVUJJcrS62bDslc+jKJEaZA5VLTAuQQqx5OrixFJnQ5
 B0gTyxWrauJ1awPV7U9j5SSgCaHlL26sDGj1Wo4FeXvayvAl58k6WvpC9X9mNQqtB7PBfy
 YI2+Wyogl6duoOyEr1g77pDhIdan5Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-K_E0ZLUVMRmIAeCbUI7xTg-1; Mon, 27 Apr 2020 03:49:08 -0400
X-MC-Unique: K_E0ZLUVMRmIAeCbUI7xTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 706D81B18BC0;
 Mon, 27 Apr 2020 07:49:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com
 [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2E1E85D9DA;
 Mon, 27 Apr 2020 07:49:02 +0000 (UTC)
Subject: Re: [PATCH v4 24/30] qcow2: Clear the L2 bitmap when allocating a
 compressed cluster
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <6d596d82ed62615a8565b661691a06bfaf32237e.1584468723.git.berto@igalia.com>
 <w51r1wcn7eu.fsf@maestria.local.igalia.com>
 <1606ecb5-98ea-fefb-bb98-2ecda1d65f5c@redhat.com>
 <w51o8rgn6j6.fsf@maestria.local.igalia.com>
 <57ac1a2f-1632-1a00-b18d-1fc2169175b6@redhat.com>
 <w51lfmkn4ws.fsf@maestria.local.igalia.com>
 <2ed917cb-edf1-faeb-532b-ad5edb39d293@virtuozzo.com>
 <w51imhon30t.fsf@maestria.local.igalia.com>
 <cc3301dc-14e0-1b1c-fb97-4f4b8a520dfd@redhat.com>
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
Message-ID: <c6a86c0d-e7cc-2bee-d9ea-7fa8abb344be@redhat.com>
Date: Mon, 27 Apr 2020 09:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cc3301dc-14e0-1b1c-fb97-4f4b8a520dfd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Zz6oPXjOP1VWDr0q7Q04FBfIwezL898Xa"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zz6oPXjOP1VWDr0q7Q04FBfIwezL898Xa
Content-Type: multipart/mixed; boundary="lbgePEhkyibrymfrtdxxzHW1Cjiia6Nid"

--lbgePEhkyibrymfrtdxxzHW1Cjiia6Nid
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.04.20 20:47, Eric Blake wrote:
> On 4/24/20 1:37 PM, Alberto Garcia wrote:
>> On Fri 24 Apr 2020 08:25:45 PM CEST, Vladimir Sementsov-Ogievskiy
>> <vsementsov@virtuozzo.com> wrote:
>>>>> Reading the entire cluster will be interesting - you'll have to
>>>>> decompress the entire memory, then overwrite the zeroed portions.
>>>>
>>>> I don't think so, qcow2_get_host_offset() would detect the number of
>>>> contiguous subclusters of the same type at the given offset. In this
>>>> case they would be _ZERO subclusters so there's no need to decompress
>>>> anything, or even read it (it works the same with uncompressed
>>>> clusters).
>>>
>>> But if at least one of subclusters to read is not _ZERO, you'll have
>>> to decompress the whole cluster, and after decompression rewrite
>>> zero-subclusters by zeroes, as Eric says.. Or I lost the thread:)
>>
>> I don't see why you would need to rewrite anything... you do have to
>> decompress the whole cluster, and the uncompressed cluster in memory
>> would have stale data, but you never need to use that data for anything,
>> let alone to return it to the guest.
>>
>> Even if there's a COW, the new cluster would inherit the compressed
>> cluster's bitmap so the zeroized subclusters still read as zeroes.
>>
>> It's the same with normal clusters, 'write -P 0xff 0 64k' followed by
>> 'write -z 16k 16k'. The host cluster on disk still reads as 0xff but the
>> L2 entry indicates that part of it is just zeroes.
>=20
> The point is this:=A0 Consider 'write -P 0xff 0 64k', then 'write -z 16k
> 16k', then 'read 0 64k'.=A0 For normal clusters, we can just do a
> scatter-gather iov read of read 0-16k and 32-64k, plus a memset of
> 16-32k.=A0 But for compressed clusters, we have to read and decompress th=
e
> entire 64k, AND also memset 16k-32k.=A0 But if zeroing after reading is
> not that expensive, then the same technique for normal clusters is fine
> (instead of a scatter-gather read of 48k, just read the whole 64k
> cluster before doing the memset).

It would also mean letting qcow2_co_preadv_part() special-handle such
cases, i.e., whenever the whole clusters is compressed, it needs to read
it as a whole, regardless of the subcluster status, and then memset()
all areas to zero that are all-zero subclusters.  Otherwise we=92d read
and decompress the whole buffer twice (once for 0 to 16k, once for 32k
to 64k).

This may be complicated a bit by the task schema, i.e. that reads are
scheduled in the task pool.  For qcow2_co_preadv_part() to memset some
area after decompression, it would need to wait on the read_compressed
task, which would make the whole task pool thing moot (for compressed
clusters).  Or it just does the memset() at the end, when we have to
settle the task pool anyway, but then it would have to remember all
areas it still needs to zero.

Hm, or, qcow2_co_preadv_compresed() could figure out where the zeroed
subclusters are and then memset() them itself, e.g. by receiving the
subcluster bitmap.  Probably the simplest implementation, but it seems a
bit like a layering breach.

Not sure how bad the complexity is on the write side for not letting
zero writes just zero the subcluster, but it doesn=92t seem to me that the
opposite would come for free on the read side.

Max


--lbgePEhkyibrymfrtdxxzHW1Cjiia6Nid--

--Zz6oPXjOP1VWDr0q7Q04FBfIwezL898Xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6mjmwACgkQ9AfbAGHV
z0AdyggAkWU9+t1wxbClUme/ENJogKRFLW4m6KfWLAXYl9CL8t1Urbo3fuA0lkwi
3gdIMFv2Xvxz2pNHshKoPcH4lH8O5Qvu8VkNdH2rPxq63Q8GdAXSMjNlNiToLstc
V2MCGF1j1SZd5biUdjuL2bBEhc3uGxMSQGD+Pntj9xUmUbqDH/C4oUP6fL04YhCN
NWorQg7ECEevUW0m2ZIzE4ZgDU2ylNUBpF8TQs69NV1FbJiiFmuZ9sS60OzMVKGo
/wtX81A0p2/ZHUf/QLWnplu2l3oMVvqI03RpYAtDzOf/6sjZ70vTN1PCehtZiqdf
XAJyn1m/e3SbTfVSfCXhphlGkL4VFg==
=78NN
-----END PGP SIGNATURE-----

--Zz6oPXjOP1VWDr0q7Q04FBfIwezL898Xa--


