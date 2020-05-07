Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782C0C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C5220870
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 13:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqWSM8MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C5220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWgEN-0007Dl-CP
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 09:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWg6v-0006vd-PU
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:58:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWg6u-00067K-F4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 08:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588856323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZI9ZRuNEg9i9hlJyonN9gH8n/bQYkVUeQ7qLh1wD/vc=;
 b=KqWSM8MH2k2KbLQxx2OWSqbpufpyMPRi3gFQt3dz/cvNYOmpxiLaAXS3/MFkw2wwnIRL0W
 ati2ORX/HCRvf2YvgH8+Sya/rP10YtqtihPm2TrYfs6fnffwRLWLsgxP6VXJvjG30Vo52x
 HdIHmdp9R0N/1okqrUWF/ZsMH8MJ2sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-BDqcaiE4PA2nLSxE5E-15A-1; Thu, 07 May 2020 08:58:39 -0400
X-MC-Unique: BDqcaiE4PA2nLSxE5E-15A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FD0F1083E81;
 Thu,  7 May 2020 12:58:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61068707A9;
 Thu,  7 May 2020 12:58:36 +0000 (UTC)
Subject: Re: backing chain & block status & filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu block <qemu-block@nongnu.org>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
 <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
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
Message-ID: <9b5b1114-9a45-9cad-bc25-d3c10df45dc1@redhat.com>
Date: Thu, 7 May 2020 14:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c00f089e-44f6-32ee-97ea-0414b552bdae@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u6T5dh0NlGO4smvPdThjpw1LbFtPa1ZJt"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u6T5dh0NlGO4smvPdThjpw1LbFtPa1ZJt
Content-Type: multipart/mixed; boundary="PwuO4RSSjeELGNH39Wyfl5hnxNlMKLFq3"

--PwuO4RSSjeELGNH39Wyfl5hnxNlMKLFq3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 16:51, Vladimir Sementsov-Ogievskiy wrote:
> 28.04.2020 14:08, Max Reitz wrote:
>> On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi!
>>>
>>> I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
>>> is_allocated_above", and returned to all the inconsistencies about
>>> block-status. I keep in mind Max's series about child-access functions,
>>> and Andrey's work about using COR filter in block-stream, which depends
>>> on Max's series (because, without them COR fitler with file child break=
s
>>> backing chains).. And, it seems that it's better to discuss some
>>> questions before resending.
>>>
>>> First, problems about block-status:
>>>
>>> 1. We consider ALLOCATED =3D ZERO | DATA, and documented as follows:
>>>
>>> =C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_DATA: allocation for data at offset is =
tied to this
>>> layer
>>> =C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_ZERO: offset reads as zero
>>> =C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_OFFSET_VALID: an associated offset exis=
ts for accessing
>>> raw data
>>> =C2=A0=C2=A0=C2=A0 * BDRV_BLOCK_ALLOCATED: the content of the block is =
determined by
>>> this
>>> =C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 layer rather than any backing, set by block
>>> layer
>>>
>>> This actually means, that we should always have BDRV_BLOCK_ALLOCATED fo=
r
>>> formats which doesn't support backing. So, all such format drivers must
>>> return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, fo=
r
>>> example, iscsi - doesn't.
>>
>> Hm.=C2=A0 I could imagine that there are formats that have non-zero hole=
s
>> (e.g. 0xff or just garbage).=C2=A0 It would be a bit wrong for them to r=
eturn
>> ZERO or DATA then.
>>
>> But OTOH we don=E2=80=99t care about such cases, do we?=C2=A0 We need to=
 know whether
>> ranges are zero, data, or unallocated.=C2=A0 If they aren=E2=80=99t zero=
, we only
>> care about whether reading from it will return data from this layer or
>> not.
>>
>> So I suppose that anything that doesn=E2=80=99t support backing files (o=
r
>> filtered children) should always return ZERO and/or DATA.
>>
>>> 2. ZERO. The meaning differs a bit for generic block_status and for
>>> drivers.. I think, we at least should document it like this:
>>>
>>> BDRV_BLOCK_DATA: allocation for data at offset is tied to this layer
>>> BDRV_BLOCK_ZERO: if driver return ZERO, than the region is allocated at
>>> this layer and read as ZERO. If generic block_status returns ZERO, it
>>> only mean that it reads as zero, but the region may be allocated on
>>> underlying level.
>>
>> Hm.=C2=A0 What does that mean?
>>
>> One of the problems is that =E2=80=9Callocated=E2=80=9D has two meanings=
:
>> (1) reading data returns data defined at this backing layer,
>> (2) actually allocated, i.e. takes up space on the file represented by
>> this BDS.
>>
>> As far as I understand, we actually don=E2=80=99t care about (2) in the =
context
>> of block_status, but just about (1).
>>
>> So if a layer returns ZERO, it is by definition (1)-allocated.=C2=A0 (It
>> isn=E2=80=99t necessarily (2)-allocated.)
>>
>>> 3. bdi.unallocated_blocks_are_zero
>>>
>>> I think it's very bad, that we have formats, that supports backing, but
>>> doesn't report bdi.unallocated_blocks_are_zero as true. It means that
>>> UNALLOCATED region reads as zero if we have short backing file, and not
>>> as zero if we remove this short backing file.
>>
>> What do you mean by =E2=80=9Cremove this short backing file=E2=80=9D?=C2=
=A0 Because generally
>> one can=E2=80=99t just drop a backing file.
>>
>> So maybe a case like block-stream?=C2=A0 Wouldn=E2=80=99t that be a bug =
in
>> block-stream them, i.e. shouldn=E2=80=99t it stream zeros after the end =
of the
>> backing file?
>>
>>> I can live with it but
>>> this is weird logic. These bad drivers are qcow (not qcow2), parallels
>>> and vmdk. I hope, they actually just forget to set
>>> unallocated_blocks_are_zero to true.
>>
>> qcow definitely sounds like it.
>>
>>> Next. But what about drivers which doesn't support backing? As we
>>> considered above, they should always return ZERO or DATA, as everything
>>> is allocated in this backing-chain level (last level, of course).. So
>>> again unallocated_blocks_are_zero is meaningless. So, I think, that
>>> driver which doesn't support backings, should be fixed to return always
>>> ZERO or DATA, than we don't need this unallocated_blocks_are_zero at
>>> all.
>>
>> Agreed.
>>
>>> 3.
>>
>> The second 3.? :)
>>
>>> Short backing files in allocated_above: we must consider space after
>>> EOF as ALLOCATED, if short backing file is inside requested
>>> backing-chain part, as it produced exactly because of this short file
>>> (and we never go to backing).
>>
>> Sounds correct.
>>
>>> (current realization of allocated_above is
>>> buggy, see my outdated series "[PATCH 0/4] fix & merge
>>> block_status_above and is_allocated_above")
>>>
>>> 4. Long ago we've discussed problems about BDRV_BLOCK_RAW, when we have
>>> a backing chain of non-backing child.. I just remember that we didn't
>>> reach the consensus.
>>
>> Possible? :)
>>
>>> 5. Filters.. OK we have two functions for them:
>>> bdrv_co_block_status_from_file and bdrv_co_block_status_from_backing. I
>>> think both are wrong:
>>>
>>> bdrv_co_block_status_from_file leads to problem [4], when we can report
>>> UNALLOCATED, which refers not to the current backing chain, but to sub
>>> backing chain of file child, which is inconsistent with
>>> block_status_above and is_allocated_above iteration.
>>>
>>> bdrv_co_block_status_from_backing is also is not consistent with
>>> block_status_above iteration.. At least at leads to querying the same
>>> node twice.
>>
>> Well, yes.
>>
>>> So, about filters and backing chains. Keeping (OK, just, trying to keep=
)
>>> all these things in mind, I think that it's better to keep backing
>>> chains exactly *backing* chains, so that "backing" child is the only
>>> "not own" child of the node. So, its close to current behavior and we
>>> don't need child-access functions. Then how filters should work:
>>>
>>> Filter with backing child, should always return UNALLOCATED (i.e. no
>>> DATA, no ZERO), it is honest: everything is on the other level of
>>> backing chain.
>>
>> I disagree, because filters with or without backing children should work
>> exactly the same way and just not appear in the backing chain.
>=20
> They work the same way in my variant too. The only difference is that if
> you use file-child-based filters, you can't do stream/commit around
> them.

Which is a bug that=E2=80=99s been know for a long time, and the primary ca=
use
for the =E2=80=9CDeal with filters=E2=80=9D series.

> I just think, that binding the concept to the "backing" link of
> the node is simpler and more generic. In blockdev era, when all nodes
> will be named and libvirt will take care of all nodes including filters,
> we will not need any filter-skipping magic, libvirt will directly point
> to exact nodes it means. And we can deprecate "file" children of
> existing filters,

One thing to note is that all user-creatable filter drivers currently
use =E2=80=9Cfile=E2=80=9D, so this would change them all.

The idea of just using backing for filters just always seems to me like
trying to take the easy way out.  It seems to me like many things around
filters are broken because we weren=E2=80=99t careful enough when introduci=
ng
them (mostly a combination of =E2=80=9Clet=E2=80=99s see whether it just wo=
rks=E2=80=9D and =E2=80=9Cit
seems to mostly work=E2=80=9D), and the =E2=80=9CDeal with filters=E2=80=9D=
 series attempts to
rectify that.  As evidenced by the reviews that required even more
preliminary work (like the still on-list and under-discussion
BdrvChildRole series), there is really a ton of design that should be
improved.

That makes me very hesitant to just switch filters over to backing,
because I feel that might alleviate some of the most pressing symptoms,
while not addressing the underlying issues.  And without symptoms that
hurt, nobody might want to fix the issues.  Basically, it feels like
more of the same =E2=80=9CLet=E2=80=99s try whether it mostly works=E2=80=
=9D and =E2=80=9Cit seems to
mostly work=E2=80=9D.

(Also, my na=C3=AFve feeling is that if just treating backing and file the
same for filter drivers, the deal with filters series would be ten
patches long and v1 would have been uncontroversial.)

Max


--PwuO4RSSjeELGNH39Wyfl5hnxNlMKLFq3--

--u6T5dh0NlGO4smvPdThjpw1LbFtPa1ZJt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl60BfoACgkQ9AfbAGHV
z0AfoQf9FaKH+VrAwf1QVzs+3/ES9/CJTY6A2Fn7sVTl1boaspOij1qbzTSHs6Ly
aG8njvsQiORDRKGQDWNTNjqH4T110/qK4jx5nX7lXzI/0EjpSVW9LN8w0ot1KNL4
iVQQSZC1gBh2Vz7GOZrni0BWGy+oEtLuVLZKpvq9GT/6MNG5z+FBkJr6YzzGknHA
sJsAadAeIsbwtiV3y+2h4q7Ix+eEKvWqyBWoQpLcyiaZyz2Z28Y9eQi3pS7UHjpO
q3KGHXCzHsaByFDq0pKNfMA5plsEWpxGLmnTLap5txe6hUaz5C+8Z4K+onkv7lyl
Vbw5PhrsGPfeIn1YxYFPVwwPCviMkA==
=Zm6Y
-----END PGP SIGNATURE-----

--u6T5dh0NlGO4smvPdThjpw1LbFtPa1ZJt--


