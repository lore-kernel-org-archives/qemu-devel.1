Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2C5C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:55:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C81216F4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 15:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiHA9WyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C81216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaicU-0006Lu-18
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 10:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iahQD-0004IP-4D
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iahQ6-0003zj-AQ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:38:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42518
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iahQ5-0003rq-1X
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575038331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=SAh+xBH+NG0Z678qWnFJqufizw6LtGi5UK/C+k8Yxxg=;
 b=RiHA9WyLIEXI99OqhbsQw2NZp+qU0oTFf2G3IhHrtrRf6Uvv3b/wp2IvcIwlM08X2zitfh
 7eCBbBbKljeZwFYIDjsokMjqZW9e1TnkSVkpeF8cdFmOnGYmLT6u7feQVp9Y+LAYYi7kjV
 eB8OGFcpqpg3h2HQ/acjvlwD8bz3PMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-133hq1IwPzST0w5cXsRA-g-1; Fri, 29 Nov 2019 09:38:49 -0500
X-MC-Unique: 133hq1IwPzST0w5cXsRA-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9C8800D41;
 Fri, 29 Nov 2019 14:38:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-206-40.brq.redhat.com
 [10.40.206.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAFF119C58;
 Fri, 29 Nov 2019 14:38:46 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-16-mreitz@redhat.com>
 <2c47c1be-e633-c769-88fe-684fe1ebe80f@virtuozzo.com>
 <88baa19f-1433-178e-33eb-16c275dec909@redhat.com>
 <c85c5101-2b88-5fb7-1d32-09261646b57c@virtuozzo.com>
 <af704f0a-273e-e4eb-3348-c7bec6936f87@redhat.com>
 <4249aa4c-0e85-f25c-f1cc-672dd3245878@virtuozzo.com>
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
Message-ID: <ac678e61-a59b-ed7c-a679-d3877ccbaac4@redhat.com>
Date: Fri, 29 Nov 2019 15:38:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4249aa4c-0e85-f25c-f1cc-672dd3245878@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lJAnAVb2CyPxQYvYYh9FrejoYB20lJ82o"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lJAnAVb2CyPxQYvYYh9FrejoYB20lJ82o
Content-Type: multipart/mixed; boundary="GKJM2KuyAsyO65pQbdGDYGZsjwIlqpuq6"

--GKJM2KuyAsyO65pQbdGDYGZsjwIlqpuq6
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.11.19 15:26, Vladimir Sementsov-Ogievskiy wrote:
> 29.11.2019 17:17, Max Reitz wrote:
>> On 29.11.19 14:55, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.11.2019 16:46, Max Reitz wrote:
>>>> On 29.11.19 13:01, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 11.11.2019 19:02, Max Reitz wrote:
>>>>>> While bdrv_replace_node() will not follow through with it, a specifi=
c
>>>>>> @replaces asks the mirror job to create a loop.
>>>>>>
>>>>>> For example, say both the source and the target share a child where =
the
>>>>>> source is a filter; by letting @replaces point to the common child, =
you
>>>>>> ask for a loop.
>>>>>>
>>>>>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>>>>>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must =
point
>>>>>> to a child of the source, and sync=3Dnone makes the source the backi=
ng
>>>>>> file of the target after the job).
>>>>>>
>>>>>> bdrv_replace_node() will not create those loops, but by doing so, it
>>>>>> ignores the user-requested configuration, which is not ideally eithe=
r.
>>>>>> (In the first example above, the target's child will remain what it =
was,
>>>>>> which may still be reasonable.  But in the second example, the targe=
t
>>>>>> will just not become a child of the source, which is precisely what =
was
>>>>>> requested with @replaces.)
>>>>>>
>>>>>> So prevent such configurations, both before the job, and before it
>>>>>> actually completes.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>     block.c                   | 30 ++++++++++++++++++++++++
>>>>>>     block/mirror.c            | 19 +++++++++++++++-
>>>>>>     blockdev.c                | 48 +++++++++++++++++++++++++++++++++=
+++++-
>>>>>>     include/block/block_int.h |  3 +++
>>>>>>     4 files changed, 98 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/block.c b/block.c
>>>>>> index 0159f8e510..e3922a0474 100644
>>>>>> --- a/block.c
>>>>>> +++ b/block.c
>>>>>> @@ -6259,6 +6259,36 @@ out:
>>>>>>         return to_replace_bs;
>>>>>>     }
>>>>>>    =20
>>>>>> +/*
>>>>>> + * Return true iff @child is a (recursive) child of @parent, with a=
t
>>>>>> + * least @min_level edges between them.
>>>>>> + *
>>>>>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  =
For
>>>>>> + * @min_level =3D=3D 1, @child needs to be at least a real child; f=
or
>>>>>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and =
so on.)
>>>>>> + */
>>>>>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *pa=
rent,
>>>>>> +                      int min_level)
>>>>>> +{
>>>>>> +    BdrvChild *c;
>>>>>> +
>>>>>> +    if (child =3D=3D parent && min_level <=3D 0) {
>>>>>> +        return true;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!parent) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    QLIST_FOREACH(c, &parent->children, next) {
>>>>>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>>>>>> +            return true;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return false;
>>>>>> +}
>>>>>> +
>>>>>>     /**
>>>>>>      * Iterates through the list of runtime option keys that are sai=
d to
>>>>>>      * be "strong" for a BDS.  An option is called "strong" if it ch=
anges
>>>>>> diff --git a/block/mirror.c b/block/mirror.c
>>>>>> index 68a4404666..b258c7e98b 100644
>>>>>> --- a/block/mirror.c
>>>>>> +++ b/block/mirror.c
>>>>>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>>>>>              * there.
>>>>>>              */
>>>>>>             if (bdrv_recurse_can_replace(src, to_replace)) {
>>>>>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>>>>>> +            /*
>>>>>> +             * It is OK for @to_replace to be an immediate child of
>>>>>> +             * @target_bs, because that is what happens with
>>>>>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: targ=
et_bs's
>>>>>> +             * backing file will be the source node, which is also
>>>>>> +             * to_replace (by default).
>>>>>> +             * bdrv_replace_node() handles this case by not letting
>>>>>> +             * target_bs->backing point to itself, but to the sourc=
e
>>>>>> +             * still.
>>>>>> +             */
>>>>>
>>>>> Hmm.. So, we want the following valid case:
>>>>>
>>>>> (other parents of source) ----> source =3D to_replace <--- backing --=
- target
>>>>>
>>>>> becomes
>>>>>
>>>>> (other parents of source) ----> target --- backing ---> source
>>>>>
>>>>> But it seems for me, that the following is not less valid:
>>>>>
>>>>> (other parents of source) ----> source =3D to_replace <--- backing --=
- X <--- backing --- target
>>>>>
>>>>> becomes
>>>>>
>>>>> (other parents of source) ----> target --- backing ---> X --- backing=
 ---> source
>>>>
>>>> I think it is less valid.  The first case works with sync=3Dnone, beca=
use
>>>> target is initially empty and then you just copy all new data, so the
>>>> target keeps looking like the source.
>>>>
>>>> But in the second case, there are intermediate nodes that mean that
>>>> target may well not look like the source.
>>>
>>> Maybe, it's valid if target node is a filter? Or, otherwise, it's backi=
ng is a filter,
>>> but this seems less useful.
>>
>> The question to me is whether it=92s really useful.  The thing is that
>> maybe bdrv_replace_node() can make sense of it.  But still, from the
>> user=92s perspective, they kind of are asking for a loop whenever
>> to_replace is a child of target.  It just so happens that we must allow
>> one of these cases because it=92s the default case for sync=3Dnone.
>>
>> So I=92d rather forbid all such cases, because it should be understandab=
le
>> to users why...
>>
>=20
> Okay, I don't have more arguments:) Honestly, I just feel that relying on=
 existing
> of chains between nodes of some hardcoded length is not good generic crit=
eria...
>=20
> bdrv_replace_node never creates loops.. Maybe, just document this behavio=
r in
> qapi? And (maybe) return error, if we see that bdrv_replace_node will be =
noop?
>=20
> And if it is not noop, may be user don't tries to create a loop, but inst=
ead,
> user is powerful, knows how bdrv_replace_node works and wants exactly thi=
s
> behavior?

I don=92t know whether that=92s a good point.  We have strong restrictions
on @replaces anyway (that=92s the point of this series, to fix them).  So
if we want to loosen those restrictions and allow the user to do
anything they want because it=92s their job to be careful, that would be a
whole different series.

Also, one of the examples in the commit message is using @replaces with
drive-mirror sync=3Dnone mode=3Dabsolute-paths.  @replaces must be a child
of the source.  So what will happen is that it=92s replaced and then we
can=92t attach the source as the backing file of the target.  So the
target will probably just read garbage, given that it now lacks the
source as its backing file.

So I=92m not sold on =93If the user knows what=92ll happen, it=92s all good=
=94.
Because I don=92t think they=92ll really know.  I=92d rather keep it tight
until someone complains.

Max


--GKJM2KuyAsyO65pQbdGDYGZsjwIlqpuq6--

--lJAnAVb2CyPxQYvYYh9FrejoYB20lJ82o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3hLXUACgkQ9AfbAGHV
z0C+Owf+L9Q4wXZ2X/whO17JBx9yVzt5MH9qH6nHVvbxioc+1rmNv2DdTs+HRRMR
aTP8nbqni6HlTLZr5SBVjKfd1DfJBQ+ExSE0RbXWzBjvc547PXWjhYrfXjaC2zQJ
unHbEV/kzQ1c9sVj66ROSHWcdC7LV+hI1Gu1z1LIIEmtQO3XobKpksfoyBMldlqj
mlt025IA4Dx3wmxSXCnrcvuZpWl4YCIc9xY6F+dcXLAF9bljQvnjGLX189NBH2mi
/R5GqNjFP1cdujc2P1yl05lSGYbB1ARMUs4Q1/zj09gzPuFeOVqgv7eIwQdWDx0S
/2ourG1aGuF19tCsHLF/JhNtqiNr/w==
=Si2Y
-----END PGP SIGNATURE-----

--lJAnAVb2CyPxQYvYYh9FrejoYB20lJ82o--


