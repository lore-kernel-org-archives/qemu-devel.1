Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483ACC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:32:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2AA207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYLOiEm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2AA207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fzw-0003Rj-9b
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8fzO-00031A-Ly
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8fzM-0004y2-UC
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597912320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jKgWAJuzwRE2mODfz0SEXUqqen/+ivI+jpPWopfv/C0=;
 b=BYLOiEm7i7sU2EL+bRiw5RqGvc00ZHl4aQbPPAJk1l1/s248UgdoAyUcp6Td66KwdT/7xf
 gSwa6jnCJddFazpEXMkZOtAibOLPggudt9nfh5bWYxjaZ0jQ/6Bn2f5zMrczDfWOc6/FTi
 fLPhSho6zHGBZbDyKAkuI5YyDVoPCoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-17wICJ4tP3amqiY7PLFa1Q-1; Thu, 20 Aug 2020 04:31:57 -0400
X-MC-Unique: 17wICJ4tP3amqiY7PLFa1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD4A2100A949;
 Thu, 20 Aug 2020 08:31:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D419B5C893;
 Thu, 20 Aug 2020 08:31:55 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <20200818142851.GD6865@linux.fritz.box>
 <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
 <20200819151625.GF10272@linux.fritz.box>
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
Message-ID: <d3ba4a10-9abb-742b-9a5f-33282f9f9fc2@redhat.com>
Date: Thu, 20 Aug 2020 10:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819151625.GF10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T0Iaj9S30duijnZRkOdDzPfEnOEi0bvRm"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T0Iaj9S30duijnZRkOdDzPfEnOEi0bvRm
Content-Type: multipart/mixed; boundary="dJvAORsBh9vnEHyO4DwIDHjPBFoLf2dKh"

--dJvAORsBh9vnEHyO4DwIDHjPBFoLf2dKh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 17:16, Kevin Wolf wrote:
> Am 19.08.2020 um 16:47 hat Max Reitz geschrieben:
>> On 18.08.20 16:28, Kevin Wolf wrote:
>>> Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
>>>> Because of the (not so recent anymore) changes that make the stream jo=
b
>>>> independent of the base node and instead track the node above it, we
>>>> have to split that "bottom" node into two cases: The bottom COW node,
>>>> and the node directly above the base node (which may be an R/W filter
>>>> or the bottom COW node).
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  qapi/block-core.json |  4 +++
>>>>  block/stream.c       | 63 ++++++++++++++++++++++++++++++++-----------=
-
>>>>  blockdev.c           |  4 ++-
>>>>  3 files changed, 53 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>>> index b20332e592..df87855429 100644
>>>> --- a/qapi/block-core.json
>>>> +++ b/qapi/block-core.json
>>>> @@ -2486,6 +2486,10 @@
>>>>  # On successful completion the image file is updated to drop the back=
ing file
>>>>  # and the BLOCK_JOB_COMPLETED event is emitted.
>>>>  #
>>>> +# In case @device is a filter node, block-stream modifies the first n=
on-filter
>>>> +# overlay node below it to point to base's backing node (or NULL if @=
base was
>>>> +# not specified) instead of modifying @device itself.
>>>
>>> Not to @base's backing node, but to @base itself (or actually, to
>>> above_base's backing node, which is initially @base, but may have
>>> changed when the job is completed).
>>
>> Oh, yes.
>>
>> (I thought I had noticed that already at some point and fixed it
>> locally...  But apparently not.)
>>
>>> Should we also document what using a filter node for @base means?
>>
>> Hm.  What does it mean?  I think the more interesting case is what it
>> means if above_base is a filter, right?
>>
>> Maybe we can put in somewhere in the =E2=80=9CIf a base file is specifie=
d then
>> sectors are not copied from that base file and its backing chain.=E2=80=
=9D  But
>> the more I think about it, the less I know what we could add to it.
>> What happens if there are filters above @base is that their data isn=E2=
=80=99t
>> copied, because that=E2=80=99s exactly the data in @base.
>=20
> The interesting part is probably the graph reconfiguration at the end of
> the job. Which is actually already documented:
>=20
> # When streaming completes the image file will have the base
> # file as its backing file.
>=20
> Of course, this is not entirely correct any more (because the base may
> have changed).
>=20
> If @base is a filter, what backing file path do we write into the top
> layer? A json: filename including the filter?

Yes.

Or, actually.  Now that I read the code...  It takes @base=E2=80=99s filena=
me
before the stream job and then uses that.  So if @base has changed
during the job, then it still uses the old filename.

But that=E2=80=99s not really due to this series.

> Is this worth mentioning
> or do you consider it obvious?

Hm.  I consider it obvious, yes.  @base becomes @top=E2=80=99s backing file=
 (at
least without any graph changes while the job is running), so naturally
what=E2=80=99s written into the image header is @base=E2=80=99s filename =
=E2=80=93 which is a
json:{} filename.

On second thought, @backing-file=E2=80=99s description mysteriously states =
that
=E2=80=9CQEMU will automatically determine the backing file string to use=
=E2=80=9D.
Which makes sense because it would clearly not make sense to describe
what=E2=80=99s actually happening, which is to use @base=E2=80=99s filename=
 at job start
regardless of whether it=E2=80=99s still there at the end of the job.

So I suppose I have the choice of either documenting exactly what=E2=80=99s
happening, even though it doesn=E2=80=99t make much sense, or just not, kee=
ping
it mysterious.

So all in all, I believe the biggest surprise about what=E2=80=99s written =
into
the top layer isn=E2=80=99t that it may be a json:{} filename, but the file=
name
of a node that maybe doesn=E2=80=99t even exist anymore?  (Oh, no, please d=
on=E2=80=99t
tell me you can delete it and get an invalid pointer read...)

The more I think about it, the more I think there are problems beyond
the scope of this series here. :/

Max


--dJvAORsBh9vnEHyO4DwIDHjPBFoLf2dKh--

--T0Iaj9S30duijnZRkOdDzPfEnOEi0bvRm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+NPkACgkQ9AfbAGHV
z0CzTgf9HZeKzqeJEBs2pLMx6jI9aR+ivWMIMrSYV2EXH2WQD2TWsF6Hn73MSTIn
mGy2JWj+DRmolhOH2ytIOtSTWeI0fMBlRJRR9xQY6/PnUm8oaVbMcOLpEM17F4kr
PUxz4xqd7lRL0abcnJosbFgb+98K9adTczDWi9t4vsm9boIUgGRZennUav3VfwHk
AsSHXnvk+f1Mb5W6SWyY3N4VgpPHxpcj0C5h9gj8/UuM3NNy2P500D3jNuIzq4g2
6scKRCbm7hodMOws3i2gl97pdjCBwst3jjMfvrJSQ8ljI3v5ekJdih/z/NR/mw+I
i94RQZMpwjFMzEOigZ6vGBfcYgmVQw==
=FLIV
-----END PGP SIGNATURE-----

--T0Iaj9S30duijnZRkOdDzPfEnOEi0bvRm--


