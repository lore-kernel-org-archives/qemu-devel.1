Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00E8C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C5220720
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do7oJQvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C5220720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkGr-0003Oh-OQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54597)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izkGA-0002gj-1V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:44:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izkG8-00057w-Ec
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:44:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izkG8-00056u-8g
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581007447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dl3L7AwCWEeD8nsaf0dXL9VpMMIvIIB6XnJdif2cCWk=;
 b=Do7oJQvj/89y8H/AewYvbMS9spyxjuRlPkVPeHpMW13A2mbUcHPHZW2aO9m+0u3z+6I4jd
 UzT1csGIcmNnkqGWAqJ5Fycx2YGjc016bQZYWhGlYzWFPCd/1lPG/XDgkNyMIqFcfMMDL3
 yVM82vwWR1OHwcQ2JFClr2oW5jYOiPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-wzONPR71Py2UON3GwM59Nw-1; Thu, 06 Feb 2020 11:44:03 -0500
X-MC-Unique: wzONPR71Py2UON3GwM59Nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8778FDBBC;
 Thu,  6 Feb 2020 16:44:02 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 469C390064;
 Thu,  6 Feb 2020 16:44:01 +0000 (UTC)
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
To: Kevin Wolf <kwolf@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
 <20200206155110.GG4926@linux.fritz.box>
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
Message-ID: <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
Date: Thu, 6 Feb 2020 17:43:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206155110.GG4926@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="TrHxucQCgeP0hoHTuB0j9n0xcmqp8NGWS"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TrHxucQCgeP0hoHTuB0j9n0xcmqp8NGWS
Content-Type: multipart/mixed; boundary="vXU5LiQ5M7FzOHFNUrw7xPB8izo3e1BUc"

--vXU5LiQ5M7FzOHFNUrw7xPB8izo3e1BUc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.20 16:51, Kevin Wolf wrote:
> Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
>> On 06.02.20 15:58, Kevin Wolf wrote:
>>> Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
>>>> On 05.02.20 16:38, Kevin Wolf wrote:
>>>>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
>>>>>> We will need this to verify that Quorum can let one of its children =
be
>>>>>> replaced without breaking anything else.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>  block/quorum.c | 25 +++++++++++++++++++++++++
>>>>>>  1 file changed, 25 insertions(+)
>>>>>>
>>>>>> diff --git a/block/quorum.c b/block/quorum.c
>>>>>> index 59cd524502..6a7224c9e4 100644
>>>>>> --- a/block/quorum.c
>>>>>> +++ b/block/quorum.c
>>>>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
>>>>>> =20
>>>>>>  typedef struct QuorumChild {
>>>>>>      BdrvChild *child;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * If set, check whether this node can be replaced without any
>>>>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
>>>>>> +     * WRITE permission.
>>>>>> +     */
>>>>>> +    bool to_be_replaced;
>>>>>
>>>>> I don't understand these permission changes. How does (preparing for)
>>>>> detaching a node from quorum make its content invalid?
>>>>
>>>> It doesn=E2=80=99t, of course.  What we are preparing for is to replac=
e it by
>>>> some other node with some other content.
>>>>
>>>>> And why do we
>>>>> suddenly need WRITE permissions even if the quorum node is only used
>>>>> read-only?
>>>>>
>>>>> The comment is a bit unclear, too. "check whether" implies that both
>>>>> outcomes could be true, but it doesn't say what happens in either cas=
e.
>>>>> Is this really "make sure that"?
>>>>
>>>> I think the comment is not only unclear, it is the problem.  (Well,
>>>> maybe the code is also.)
>>>>
>>>> This series is about fixing at least some things about replacing nodes
>>>> by mirroring.  The original use cases this was introduced for was to f=
ix
>>>> broken quorum children: The other children are still intact, so you re=
ad
>>>> from the quorum node and replace the broken child (which maybe shows
>>>> invalid data, or maybe just EIO) by the fixed mirror result.
>>>>
>>>> Replacing that broken node by the fixed one changes the data that=E2=
=80=99s
>>>> visible on that node.
>>>
>>> Hm, yes, that's true. But I wonder if this is really something that the
>>> permission system must catch. Like other graph manipulations, it's
>>> essentially the user saying "trust me, I know what I'm doing, this node
>>> makes sense in this place".
>>>
>>> Because if you assume that the user could add a node with unsuitable
>>> content and you want to prevent this, where do we stop?
>>> blockdev-snapshot can insert a non-empty overlay, which would result in
>>> visible data change. Should we therefore only allow snapshots when
>>> shared writes are allowed? This doesn't work obviously.
>>>
>>> So I'm inclined to say that this is the user's responsibility and we
>>> don't have to jump through hoops to prevent every possible way that the
>>> user could mess up. (Which often also result in preventing legitimate
>>> cases like here a quorum of read-only nodes.)
>>
>> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we als=
o have to ask
>> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the user kn=
ows what they=E2=80=99re
>> doing, we might as well drop the whole can_replace infrastructure
>> altogether and just assume that you can replace any node by anything.
>=20
> Well, I don't actually know if that would be completely unreasonable.
> The idea was obviously to keep graph changes restricted to very specific
> cases to avoid nasty surprises like triggering latent bugs. Meanwhile we
> have quite a few more operations that allow changing the graph.
>=20
> So if preventing some cases gives us headaches and is probably more work
> than dealing with any bugs they might reveal, maybe preventing them is
> wrong.
>=20
> I'm just afraid that we might be overengineering this and waste time on
> things that we don't actually get much use from.

That=E2=80=99s why I=E2=80=99m asking.

>> If the WRITE permission is the problem, then I suppose we can drop that.
>>  Unsharing CONSISTENT_READ is bad enough that it effectively deters all
>> other parents anyway.
>=20
> WRITE is probably the more practical problem, though it's technically
> the correct one to take.
>=20
> CONSISTENT_READ is already a problem in theory because replacing a child
> node with different content doesn't even match its definition:
>=20
>     /**
>      * A user that has the "permission" of consistent reads is guaranteed=
 that
>      * their view of the contents of the block device is complete and
>      * self-consistent, representing the contents of a disk at a specific
>      * point.
>      *
>      * For most block devices (including their backing files) this is tru=
e, but
>      * the property cannot be maintained in a few situations like for
>      * intermediate nodes of a commit block job.
>      */
>     BLK_PERM_CONSISTENT_READ    =3D 0x01,
>=20
> Replacing an image with a different image means that the node represents
> the content of a different disk now, but it's probably still complete
> and self-consistent.

At any point in time yes, but not over the time span of the change.  The
definition doesn=E2=80=99t say that the node represents the contents of a d=
isk
at a specific point, but the view from the parent.

I argue that that view is always over some period of time, so if you
suddenly switch out the whole disk, then it isn=E2=80=99t a self-consistent=
 view.

Alternatively, we could of course also just forego the permission system
here altogether and just check that there are no other parents at all.
(Which is effectively the same as unsharing CONSISTENT_READ.)

Max


--vXU5LiQ5M7FzOHFNUrw7xPB8izo3e1BUc--

--TrHxucQCgeP0hoHTuB0j9n0xcmqp8NGWS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48Qk8ACgkQ9AfbAGHV
z0C6tQf8CcfYQYGrsRz709JdVZavlwDTtV3mt8+QKgjurFtoOFiIOhWiknAfszth
e7gOjyPAQAFSIFePWvp5g7sm870Eh4hTafbEhoRPiTi4q4pxrgw42vnvQVQUj0qO
cafnZ6nlhUunx0r2hrZN3iTaHgrDsrq0R7Alj9W0uHrXaz9QHxzo8+3jF6Q5zd2o
xQBx6CU3248fi/80WdKyZ7/hWu/6gcasGCKplTxqdYNYZ3PsMtjO3HL2YWPjpr/V
kZY3ieQYHrZMsxg6+p+zUucKcJYW4HRxSlLVMxg8iTepQKhZQAx0tHgHXoq5gd/J
bHd2fmJ326xgvoyIJ9HW3MrsvmM8hg==
=DwKZ
-----END PGP SIGNATURE-----

--TrHxucQCgeP0hoHTuB0j9n0xcmqp8NGWS--


