Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B8C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C298B2464E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2X9Q7TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C298B2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOxR-00043U-Vl
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izOwf-0003Xt-Jl
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:58:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izOwe-0001hz-C6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:58:37 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izOwe-0001fy-8D
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580925515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JIKs3TcMZwfdCu3Wb/tIi7OHYWi0270UqTNKVKcbkfo=;
 b=Q2X9Q7TIr/k/0oG5RW+WeyTt7Nv3D6DI1Ov7w03/ukMfiRlCDjf3o5VP0DXWsckKwcPMMY
 jI7Bov6aC5nqWihxBxoK5b01mQcsOqKA4xwe5VuKspmU7SCFbyaIZ6zNyDeGrgB6hLeYLT
 O8la6iNe3j4pmi4sP+VLXYrkNdbg7z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-RM7l7mmePa-5iJq3Ivrbjg-1; Wed, 05 Feb 2020 12:58:27 -0500
X-MC-Unique: RM7l7mmePa-5iJq3Ivrbjg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D96963AD7;
 Wed,  5 Feb 2020 17:58:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86541867EC;
 Wed,  5 Feb 2020 17:58:24 +0000 (UTC)
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
 <99576c66-00d2-14a3-5f1f-6d7cebfa6553@virtuozzo.com>
 <8b650616-ff80-c430-5d4e-6c9311bec2f6@redhat.com>
 <5494fd19-3dbe-8878-628b-20b3c0a0c6cd@virtuozzo.com>
 <d5bed92b-0351-7ae7-6b18-f814fe1533ba@virtuozzo.com>
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
Message-ID: <51829e78-30d7-f0c6-f191-fc12c8cb37f4@redhat.com>
Date: Wed, 5 Feb 2020 18:58:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d5bed92b-0351-7ae7-6b18-f814fe1533ba@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mXDqnAuaIs18jVZGAkwXmVYEWTlaajsAj"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mXDqnAuaIs18jVZGAkwXmVYEWTlaajsAj
Content-Type: multipart/mixed; boundary="39a8O5WaOn0g0JTQzczNrv2DjtoiIDPZJ"

--39a8O5WaOn0g0JTQzczNrv2DjtoiIDPZJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 16:14, Vladimir Sementsov-Ogievskiy wrote:
> 05.02.2020 17:47, Vladimir Sementsov-Ogievskiy wrote:
>> 05.02.2020 17:26, Eric Blake wrote:
>>> On 2/5/20 3:25 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>>>> 3. For qcow2
>>>>> Hmm. Here, as I understand, than main case is freshly created qcow2,
>>>>> which is fully-unallocated. To understand that it is empty, we
>>>>> need only to check all L1 entries. And for empty L1 table it is fast.
>>>>> So we don't need any qcow2 format improvement to check it.
>>>>>
>>>>
>>>> Ah yes, I forget about preallocated case. Hmm. For preallocated
>>>> clusters,
>>>> we have zero bits in L2 entries. And with them, we even don't need
>>>> preallocated to be filled by zeros, as we never read them (but just
>>>> return
>>>> zeros on read)..
>>>
>>> Scanning all L2 entries is O(n), while an autoclear bit properly
>>> maintained is O(1).
>>>
>>>>
>>>> Then, may be we want similar flag for L1 entry (this will enable large
>>>> fast write-zero). And may be we want flag which marks the whole image
>>>> as read-zero (it's your flag). So, now I think, my previous idea
>>>> of "all allocated is zero" is worse. As for fully-preallocated images
>>>> we are sure that all clusters are allocated, and it is more native to
>>>> have flags similar to ZERO bit in L2 entry.
>>>
>>> Right now, we don't have any L1 entry flags.=C2=A0 Adding one would
>>> require adding an incompatible feature flag (if older qemu would
>>> choke to see unexpected flags in an L1 entry), or at best an
>>> autoclear feature flag (if the autoclear bit gets cleared because an
>>> older qemu opened the image and couldn't maintain L1 entry flags
>>> correctly, then newer qemu knows it cannot trust those L1 entry
>>> flags).=C2=A0 But as soon as you are talking about adding a feature bit=
,
>>> then why add one that still requires O(n) traversal to check (true,
>>> the 'n' in an O(n) traversal of L1 tables is much smaller than the
>>> 'n' in an O(n) traversal of L2 tables), when you can instead just add
>>> an O(1) autoclear bit that maintains all_zero status for the image as
>>> a whole?
>>>
>>
>> My suggestion about L1 entry flag is side thing, I understand
>> difference between O(n) and O(1) :) Still additional L1 entry will
>> help to make efficient large block-status and write-zero requests.
>>
>> And I agree that we need top level flag.. I just try to say, that it
>> seems good to make it similar with existing L2 flag. But yes, it would
>> be incomaptible change, as it marks all clusters as ZERO, and older
>> Qemu can't understand it and may treat all clusters as unallocated.
>>
>=20
> Still, how long is this O(n) ? We load the whole L1 into memory anyway.
> For example, 16Tb disk with 64K granularity, we'll have 32768 L1
> entries. Will we get sensible performance benefit with an extension? I
> doubt in it now. And anyway, if we have an extension, we should fallback
> to this O(n) if we don't have the flag set.

(Sorry, it=E2=80=99s late and I haven=E2=80=99t followed this particular co=
nversation
too closely, but:)

Keep in mind that the default metadata overlap protection mode causes
all L1 entries to be scanned on each I/O write.  So it can=E2=80=99t be tha=
t bad.

Max


--39a8O5WaOn0g0JTQzczNrv2DjtoiIDPZJ--

--mXDqnAuaIs18jVZGAkwXmVYEWTlaajsAj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl47Aj4ACgkQ9AfbAGHV
z0DRUwf7BVebl3dPdDzZsKvYI4B/0J6aeJa80AOHeX6r9tjO7ZJUxvHC2REy/qdo
s52CVUliAF1B67MTLCHalxop3qsqXSn5mrw5zohty6H3OMhDLXFLA5a+KtVy8DJw
GbxYDpiBpPCpGLlbkKHiX23nOYqQw3Y9qa/1hsWdREwkMg9jF1WKB6N6OAzzngZd
xbt6IVasgfwD0W6AEEYdVSBWomJOkROLr1ueINKklhVvTJ+izhAscB96a3DLyoxJ
e8SZAlp97CLdc/yods1hO+fyopJkp2GcC37yQaobcXrk9DEQzZueHyHw96bP83W4
obfNOsMauXUfTQd5ewTj6AsDCIi6tg==
=8fxA
-----END PGP SIGNATURE-----

--mXDqnAuaIs18jVZGAkwXmVYEWTlaajsAj--


