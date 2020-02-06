Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F60DC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF18A20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 10:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBcp1mji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF18A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izeAl-0005Ns-5D
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 05:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45132)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ize7x-0003NP-2j
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ize7v-00034F-Lc
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:11:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ize7v-00030O-Ho
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 05:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580983874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3CdYCWhC5zL0BPiJ92q+e0Bm/CqEFX9ShJck0XonbeU=;
 b=QBcp1mjii+s+P7xpUY7G8OnKu+XLqRChPejv9NfRXIndqjp6neVZQ3vUQ8DX5vo3K1MHTN
 yZmnTUL9cwLnshHSXC4Dwq548JHmd4391Q5RrVywnqhcmgRO3Uaw4deyPn9ihP4umeN51S
 PVEc1HaA7AQbaooNASnAYe7anin8UdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-lApCrmfAMG-CeEmpxdSxvw-1; Thu, 06 Feb 2020 05:11:09 -0500
X-MC-Unique: lApCrmfAMG-CeEmpxdSxvw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AC6F1081FA1;
 Thu,  6 Feb 2020 10:11:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7749F5DA7C;
 Thu,  6 Feb 2020 10:11:07 +0000 (UTC)
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
To: Kevin Wolf <kwolf@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
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
Message-ID: <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
Date: Thu, 6 Feb 2020 11:11:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DfRDtBXKYxH2Z9BYeB2WMFKp2S9RNwEIQ"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DfRDtBXKYxH2Z9BYeB2WMFKp2S9RNwEIQ
Content-Type: multipart/mixed; boundary="eT74nns7FhHhRAtH5mFLMW97NqrvAOZrC"

--eT74nns7FhHhRAtH5mFLMW97NqrvAOZrC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 16:38, Kevin Wolf wrote:
> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
>> We will need this to verify that Quorum can let one of its children be
>> replaced without breaking anything else.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/quorum.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/block/quorum.c b/block/quorum.c
>> index 59cd524502..6a7224c9e4 100644
>> --- a/block/quorum.c
>> +++ b/block/quorum.c
>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
>> =20
>>  typedef struct QuorumChild {
>>      BdrvChild *child;
>> +
>> +    /*
>> +     * If set, check whether this node can be replaced without any
>> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
>> +     * WRITE permission.
>> +     */
>> +    bool to_be_replaced;
>=20
> I don't understand these permission changes. How does (preparing for)
> detaching a node from quorum make its content invalid?

It doesn=E2=80=99t, of course.  What we are preparing for is to replace it =
by
some other node with some other content.

> And why do we
> suddenly need WRITE permissions even if the quorum node is only used
> read-only?
>=20
> The comment is a bit unclear, too. "check whether" implies that both
> outcomes could be true, but it doesn't say what happens in either case.
> Is this really "make sure that"?

I think the comment is not only unclear, it is the problem.  (Well,
maybe the code is also.)

This series is about fixing at least some things about replacing nodes
by mirroring.  The original use cases this was introduced for was to fix
broken quorum children: The other children are still intact, so you read
from the quorum node and replace the broken child (which maybe shows
invalid data, or maybe just EIO) by the fixed mirror result.

Replacing that broken node by the fixed one changes the data that=E2=80=99s
visible on that node.

That=E2=80=99s fine with quorum because that one child never influenced its
result anyway.  In fact, we know that the new child agrees with the
quorum, so it actually reduces conflict.

But if there are other parents on the node, they may disagree.  So we
need to warn them that we will disrupt consistency by replacing the node
with a potentially completely different one.  If those other parents
don=E2=80=99t care about consistency (CONSISTENT_READ) and don=E2=80=99t mi=
nd data
changes (other WRITE users), then we can freely replace the node still.


Now (assuming that this reasoning makes sense) it may seem as if the
general block layer should handle such cases; like it should unshare
CONSISTENT_READ and take WRITE.  But that isn=E2=80=99t true, because it ca=
lls
bdrv_recurse_can_replace() specifically to check that the some node can
be replaced by the new node without changing any visible data.  So
usually there are no such sudden data changes.

Quorum is the only node that can tolerate such data changes on its
children without changing its own visible data.  Hence it=E2=80=99s respons=
ible
for ensuring that there=E2=80=99s noone else that minds if one of its child
nodes is replaced by something else.

(Note that this isn=E2=80=99t about replacing a BdrvChild, but about replac=
ing a
BDS.  It isn=E2=80=99t like only quorum=E2=80=99s BdrvChild will be made to=
 point
somewhere else; all BdrvChild pointers to the old node will be made to
point to the new one.)


Again assuming this makes sense, I wonder how we could condense that
into a reasonable comment.

Max


--eT74nns7FhHhRAtH5mFLMW97NqrvAOZrC--

--DfRDtBXKYxH2Z9BYeB2WMFKp2S9RNwEIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl475joACgkQ9AfbAGHV
z0DMAgf/YxacC9aJbMZGK2PJvMmwN6Da6cgyBA4YvLvCu5Srchpc4OCmgbumKQ5z
svPHxlOX72kBCR3fq7aZkoSiNa8S+4x0Vd2G3Rxq+3Q+c5DMFO46eqBvo8aUG1Mt
FtAG5eTBhJKORVXioy2RyOIw6aMxL2l2FcSGCnt1zSI5N+s9fOwCM1Cac4fkee1I
6IcI2a5Qh8EZNs3WlisPv2rH04SBNIUZ2JLTVvktyteILgD9+AcKdjH0UmepRXvQ
rTqterUJFpbiVEv2/tUDiC+tP/52yyr1psuwsNXRUemm2p+X2P/m0DsYu8bn3p/q
178dB6KZ1YtZ2hP3yje+uu4T+tGMkw==
=YSQT
-----END PGP SIGNATURE-----

--DfRDtBXKYxH2Z9BYeB2WMFKp2S9RNwEIQ--


