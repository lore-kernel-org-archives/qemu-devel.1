Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909ACC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D3720715
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 13:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPZmjKhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D3720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVEvE-0008DV-Cx
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 08:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57971)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVEuP-0007ZP-Fx
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVEuM-0001mM-VI
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:11:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVEuM-0001ls-Jd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 08:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573737093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w7F/HyMuz0Z6Clf4KRwkLfPRFTy4XTwdWnWNwb2NTz4=;
 b=LPZmjKhNuMJIdDUcMVUo2vzGXVhU7pIZ8+2rMs8OakN5v+CmaMBpq6aeG5W3LGXEHaBMXL
 37dy6nSC1B6QKQZe+2BsrQgTXwRC0FzX8Lv8jQyVypKvCkIeb+yC7Qoaq0hKZwzX/T4KPk
 wHO4t409MDUnAkpEnEIycAL+G3T5n0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-OiQv7oNVM6e6ZDGNjsftBA-1; Thu, 14 Nov 2019 08:11:32 -0500
X-MC-Unique: OiQv7oNVM6e6ZDGNjsftBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 850EE13AE90;
 Thu, 14 Nov 2019 13:11:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7B1019481;
 Thu, 14 Nov 2019 13:11:29 +0000 (UTC)
Subject: Re: [PATCH v6 22/42] block: Fix bdrv_get_allocated_file_size's
 fallback
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-23-mreitz@redhat.com>
 <20190910145229.GI4446@localhost.localdomain>
 <d7226d81-b89f-5c24-9dd4-39ae832bf61b@redhat.com>
 <20190911065517.GA4907@localhost.localdomain>
 <f082931e-154f-5393-f5b0-ff82f43eff31@redhat.com>
 <20190911082743.GC4907@localhost.localdomain>
 <aa9a6a3d-73ae-c7d4-78c9-a9c6c18fcfa4@redhat.com>
 <20190911103123.GE4907@localhost.localdomain>
 <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
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
Message-ID: <49450f24-844f-555f-e740-6beb0bd38fe3@redhat.com>
Date: Thu, 14 Nov 2019 14:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c22a405b-d79b-ad00-427f-c4e54e897f0d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zfGj6VYhNEvSiFODkAxuKY2rnThwNYrW2"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--zfGj6VYhNEvSiFODkAxuKY2rnThwNYrW2
Content-Type: multipart/mixed; boundary="T5l2jqYSKeegwU8Dv7H3tX00RY1NnLq7X"

--T5l2jqYSKeegwU8Dv7H3tX00RY1NnLq7X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.19 13:00, Max Reitz wrote:
> On 11.09.19 12:31, Kevin Wolf wrote:
>> Am 11.09.2019 um 12:00 hat Max Reitz geschrieben:
>>> On 11.09.19 10:27, Kevin Wolf wrote:
>>>> Am 11.09.2019 um 09:37 hat Max Reitz geschrieben:
>>>>> On 11.09.19 08:55, Kevin Wolf wrote:
>>>>>> Well, by default the primary child, which should cover like 90% of t=
he
>>>>>> drivers?
>>>>>
>>>>> Hm, yes.
>>>>>
>>>>> But I still think that the drivers that do not want to count every
>>>>> single non-COW child are the exception.
>>>>
>>>> They are, but drivers that want to count more than their primary node
>>>> are exceptions, too. And I think you're more likely to remember adding
>>>> the callback when you want to have a certain feature, not when you don=
't
>>>> want to have it.
>>>>
>>>> I really think we're likely to forget adding the callback where we nee=
d
>>>> to disable the feature.
>>>
>>> Well, I mean, we did forget adding it for qcow2.
>>
>> I'm afraid I have to agree. So the conclusion is that we won't get it
>> right anyway?
>>
>>>> I can see two options that should address both of our views:
>>>>
>>>> 1. Just don't have a fallback at all, make the callback mandatory and
>>>>    provide implementations in block.c that can be referred to in
>>>>    BlockDriver. Not specifying the callback causes an assertion failur=
e,
>>>>    so we'd hopefully notice it quite early (assuming that we run eithe=
r
>>>>    'qemu-img info' or 'query-block' on a configuration with the block
>>>>    driver, but I think that's faily safe to assume).
>>>
>>> Hm.  Seems a bit much, but if we can=E2=80=99t agree on what=E2=80=99s =
a good general
>>> implementation that works for everything, this is probably the only
>>> thing that would actually keep us from forgetting to add special cases.
>>>
>>> Though I actually don=E2=80=99t know.  I=E2=80=99d probably add two glo=
bally available
>>> helpers, one that returns the sum of everything but the backing node,
>>> and one that just returns the primary node.
>>
>> Yes, I think this is the same as I meant by "provide implementations in
>> block.c".
>>
>>> Now if I were to make qcow2 use the primary node helper function, would
>>> we have remembered changing it once we added a data file?
>>>
>>> Hmm.  Maybe not, but it should be OK to just make everything use the su=
m
>>> helper, except the drivers that want the primary node.  That should wor=
k
>>> for all cases.  (I think that whenever a format driver suddenly gains
>>> more child nodes, we probably will want to count them.  OTOH, everythin=
g
>>> that has nodes that shouldn=E2=80=99t be counted probably always wants =
to use
>>> the primary node helper function from the start.)
>>
>> The job filter nodes have only one child currently, which should be
>> counted. We'll add other children that shouldn't be counted only later.
>>
>> But we already have an idea of what possible extensions look like, so we
>> can probably choose the right function from the start.
>=20
> Yep.
>=20
>>>> 2. Make the 90% solution a 100% solution: Allow drivers to have multip=
le
>>>>    storage children (for vmdk) and then have the fallback add up the
>>>>    primary child plus all storage children. This is what I suggested a=
s
>>>>    the documented semantics in my initial reply to this patch (that yo=
u
>>>>    chose not to answer).
>>>
>>> I didn=E2=80=99t answer that because I didn=E2=80=99t disagree.
>>>
>>>>    Adding the size of storage children covers qcow2 and vmdk.
>>>
>>> That=E2=80=99s of course exactly what we=E2=80=99re trying to do, but t=
he question is,
>>> how do we figure out that storage children?  Make it a per-BdrvChild
>>> attribute?  That seems rather heavy-handed, because I think we=E2=80=99=
d need it
>>> only here.
>>
>> Well, you added bdrv_storage_child().I'd argue this interface is wrong
>=20
> Yes, it probably is.
>=20
>> because it assumes that only one storage child exists. You just didn't
>> implement it for vmdk so that the problem didn't become apparent. It
>> would have to return a list rather than a single child. So fixing the
>> interface and then using it is what I was thinking.
>>
>> Now that you mention a per-BdrvChild attribute, however, I start to
>> wonder if the distinction between COW children, filter children, storage
>> children, metadata children, etc. isn't really what BdrvChildRole was
>> supposed to represent?
>=20
> That=E2=80=99s a good point.
>=20
>> Maybe we want to split off child_storage from child_file, though it's
>> not strictly necessary for this specific case because we want to treat
>> both metadata and storage nodes the same. But it could be useful for
>> other users of bdrv_storage_child(), if there are any.
>=20
> Possible.  Maybe it turns out that at least for this series I don=E2=80=
=99t need
> bdrv_storage_child() at all.
>=20
>>>>    As the job filter won't declare the target or any other involved
>>>>    nodes their storage nodes (I hope), this will do the right thing fo=
r
>>>>    them, too.
>>>>
>>>>    For quorum and blkverify both ways could be justifiable. I think th=
ey
>>>>    probably shouldn't declare their children as storage nodes. They ar=
e
>>>>    more like filters that don't have a single filtered node. So some
>>>>    kind of almost-filters.
>>>
>>> I don=E2=80=99t think quorum is a filter, and blkverify can only be jus=
tified to
>>> be a filter because it quits qemu when there is a mismatch.
>>>
>>> The better example is replication, but that has a clear filtered child
>>> (the primary node).
>>>
>>>
>>> So all in all I think it=E2=80=99s best to make the callback mandatory =
and add
>>> two global helper functions.  That=E2=80=99s simple enough and should p=
revent
>>> us from making mistakes by forgetting to adjust something in the
>>> future.
>>
>> Yes, that should work.
>>
>> We should probably still figure out what the relationship between the
>> child access functions and child roles is, even if we don't need it for
>> this solution. But it feels like an important part of the design.
>=20
> Hm.  It feels like something that should be done before this series,
> actually.
>=20
> So I think we should add at least a child role per child access function
> so that they match?  And then maybe in bdrv_attach_child() assert that a
> BDS never has more than one primary or filtered child (a filtered child
> acts as a primary child, too), or more than one COW child.  (And that
> these are always in bs->file or bs->backing so the child access
> functions do work.)

I=E2=80=99ve been trying to make this work, but I don=E2=80=99t think it do=
es.  It just
feels all wrong and I need up with things like
=E2=80=9Cchild_metadata_and_data=E2=80=9D.  The last straw was that blkveri=
fy should
have the raw file be the filtered child (because, well, it=E2=80=99s bs->fi=
le),
but then the format file would need to be a non-filtered child, and
those would default to BDRV_O_PROTOCOL (which we decidedly don=E2=80=99t wa=
nt).

Anyway, I=E2=80=99m currently attempting to solve this differently:
BdrvChildRole isn=E2=80=99t suitable for the job, I think.  The name is
completely what we want, but it actually doesn=E2=80=99t look like somethin=
g
that describes the child role to me.

Instead, I=E2=80=99m introducing a new BdrvChildRole enum mask that describ=
es
how the child is going to be used: stay-at-node, cow, metadata, data, etc.

I=E2=80=99m going to rename the current BdrvChildRole structure to
BdrvChildParent (in want of a better name), because really most of what
it does is describe the parent, but precisely not the child.  I=E2=80=99m m=
oving
.stay_as_node to the new BdrvChildRole enum.

I hope this lets me unify child_file, child_backing, and child_format
into a child_of_bds object.  The callbacks should then decide the
particularities based on the BdrvChildRole enum.

Hope that makes sense. (? :S)

At least I feel much happier implementing it this way, which I suppose
is a good sign.

Max


--T5l2jqYSKeegwU8Dv7H3tX00RY1NnLq7X--

--zfGj6VYhNEvSiFODkAxuKY2rnThwNYrW2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3NUn8ACgkQ9AfbAGHV
z0DUSQf/XzA55YHMnH+A4ENi7SeUqBslsKYJbb1QNrYW+/O3DC1ZC80xs+WYLK8n
4XLoSqWeHcIXVKaT7RXmNtxal98ubPMhbBBb9AJtJDGt2lk2jmZrnF0UfwkJ8kU5
0Jqxzedb2BJTNpPJRtZf1x6hUtX2Kb7PmRRZXuXrUDMcS0zP8m6qxbMnBcPT016W
QuS8hzTENttqEnNAPi4p9GNeQXetj6IMK3ccneioIZbEneaEwQWwfqVSyrTweZAu
q0bNgIJ6848FJZUH3nBy0SEXMs8mZMAPv7xq+OqoxUscpH32OE8ThXRclF6pHmmJ
QW0G/J3KjKDzLyPcaDVuwlFFsVyrew==
=oflB
-----END PGP SIGNATURE-----

--zfGj6VYhNEvSiFODkAxuKY2rnThwNYrW2--


