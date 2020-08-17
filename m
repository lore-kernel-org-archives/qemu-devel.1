Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D30C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC4520729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do6vVEQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC4520729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hY0-0004MD-87
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7hAc-0002mX-V0
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:35:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57477
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k7hAa-0006Qr-MT
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597678531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DnEM542Mr5GicBRNuKWc7x2V8iKSHq35OT4nth8iEP8=;
 b=Do6vVEQRMTkNFotnIIU7YUKBfc0xZDGYATsIjshz3iH6d0vPKsbcfzt9dyvnIYWr4sgaXO
 ZyX8D1z5CTdfCO/arevvH9KgHL5HLE7TGbuCg+iylAJYC2kRnbVnzqE7MjnjlEeLRV6uQD
 EQH7Z9xdaaNZKKms48v5uCQS3FmS45U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Ww0ptaVsOXqPyiG2ofvSLg-1; Mon, 17 Aug 2020 11:35:27 -0400
X-MC-Unique: Ww0ptaVsOXqPyiG2ofvSLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1FC5801AAE;
 Mon, 17 Aug 2020 15:35:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1BE7A1C1;
 Mon, 17 Aug 2020 15:35:25 +0000 (UTC)
Subject: Re: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
To: Kevin Wolf <kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-10-kwolf@redhat.com>
 <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
 <20200817131359.GL11402@linux.fritz.box>
 <6c07d929-d7f0-50d8-88b1-b9fa89209c7d@redhat.com>
 <20200817143219.GN11402@linux.fritz.box>
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
Message-ID: <dd38c02f-d1cc-398b-1552-d93c1279d779@redhat.com>
Date: Mon, 17 Aug 2020 17:35:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817143219.GN11402@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ipPWo6Uju0uQMt9u0WqjPcwdXLeVAkpSG"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ipPWo6Uju0uQMt9u0WqjPcwdXLeVAkpSG
Content-Type: multipart/mixed; boundary="tW7DOyUwUj8GrrdYNijHUqXLGbZksnrfv"

--tW7DOyUwUj8GrrdYNijHUqXLGbZksnrfv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.08.20 16:32, Kevin Wolf wrote:
> Am 17.08.2020 um 15:51 hat Max Reitz geschrieben:
>> On 17.08.20 15:13, Kevin Wolf wrote:
>>> Am 17.08.2020 um 14:56 hat Max Reitz geschrieben:
>>>> On 13.08.20 18:29, Kevin Wolf wrote:
>>>>> qemu-nbd allows use of writethrough cache modes, which mean that writ=
e
>>>>> requests made through NBD will cause a flush before they complete.
>>>>> Expose the same functionality in block-export-add.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  qapi/block-export.json | 7 ++++++-
>>>>>  blockdev-nbd.c         | 2 +-
>>>>>  2 files changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>>>> index 1fdc55c53a..4ce163411f 100644
>>>>> --- a/qapi/block-export.json
>>>>> +++ b/qapi/block-export.json
>>>>> @@ -167,10 +167,15 @@
>>>>>  # Describes a block export, i.e. how single node should be exported =
on an
>>>>>  # external interface.
>>>>>  #
>>>>> +# @writethrough: If true, caches are flushed after every write reque=
st to the
>>>>> +#                export before completion is signalled. (since: 5.2;
>>>>> +#                default: false)
>>>>> +#
>>>>>  # Since: 4.2
>>>>>  ##
>>>>>  { 'union': 'BlockExportOptions',
>>>>> -  'base': { 'type': 'BlockExportType' },
>>>>> +  'base': { 'type': 'BlockExportType',
>>>>> +            '*writethrough': 'bool' },
>>>>>    'discriminator': 'type',
>>>>>    'data': {
>>>>>        'nbd': 'BlockExportOptionsNbd'
>>>>
>>>> Hm.  I find it weird to have @writethrough in the base but @device in
>>>> the specialized class.
>>>>
>>>> I think everything that will be common to all block exports should be =
in
>>>> the base, and that probably includes a node-name.  I=E2=80=99m aware t=
hat will
>>>> make things more tedious in the code, but perhaps it would be a nicer
>>>> interface in the end.  Or is the real problem that that would create
>>>> problems in the storage daemon=E2=80=99s command line interface, becau=
se then
>>>> the specialized (legacy) NBD interface would no longer be compatible
>>>> with the new generalized block export interface?
>>>
>>> Indeed. I think patch 15 has what you're looking for.
>>
>> Great. :)
>>
>> Discussions where both participants have the same opinion from the
>> start are the best ones.
>=20
> Makes things a lot easier.
>=20
> Maybe I should try to move patch 15 earlier. The series is mostly just
> in the order that I wrote things, but there were also a few nasty
> dependencies in the part the generalises things from NBD to BlockExport.
> So I'm not sure if this is a patch that can be moved.
>=20
>>>> Anyway, @writable might be a similar story.  A @read-only may make sen=
se
>>>> in general, I think.
>>>
>>> Pulling @writable up is easier than a @read-only, but that's a naming
>>> detail.
>>
>> Sure.
>>
>>> In general I agree, but this part isn't addressed in this series yet.
>>> Part of the reason why this is an RFC was to find out if I should
>>> include things like this or if we'll do it when we add another export
>>> type or common functionality that needs the same option.
>>
>> Sure, sure.
>=20
> So should I or not? :-)

Can we delay it until after this series?  I.e., as long as it retains
the name =E2=80=9Cwritable=E2=80=9D, would pulling it up into BlockExportOp=
tions a
compatible change?

If so, then I suppose we could do it afterwards.  But I think it does
make the most sense to =E2=80=9Cjust=E2=80=9D do it as part of this series.

>> Meta: I personally don=E2=80=99t like RFC patches very much.  RFC to me =
means
>> everything is fair game, and reviewers should be free to let their
>> thoughts wander and come up with perhaps wild ideas, just trying to
>> gauge what everyone thinks.
>>
>> When I=E2=80=99m the submitter, I tend to get defensive then, because I=
=E2=80=99ve
>> invested time in writing the code already, so I tend to be biased
>> against fundamental changes.  (Horrible personal trait.  I=E2=80=99m wor=
king
>> on it.)
>=20
> This makes sense. Nobody likes having to rewrite their RFC series.
>=20
> But there is one thing I dread even more: Polishing the RFC series for
> another week until I can send it out as non-RFC and _then_ having to
> rewrite it.

Yes.  Especially bad with tests.

>> As a reviewer, the code and thus some fleshed out design is there
>> already, so it=E2=80=99s difficult to break free from that and find comp=
letely
>> different solutions to the original problem.
>> (I kind of ventured in that direction for this patch, and it seems like
>> you immediately noticed that my response was different from usual and
>> pointed out the RFC status, perhaps to make me feel more comfortable in
>> questioning the fundamental design more.  Which I noticed, hence this
>> wall of text.)
>=20
> Basically just telling you that I was already interested in your input
> for this point specifically when I sent the series.

OK :)

>> Perhaps I=E2=80=99m wrong.  Perhaps it=E2=80=99s just myself (the points=
 I=E2=80=99ve just
>> listed are definitely my own personal weaknesses), but I can=E2=80=99t h=
elp but
>> project and assume that others may feel similar, at least in part.
>> So I feel like RFCs that consist of patches tend to at least lock me in
>> to the solution that=E2=80=99s present.  I find them difficult to handle=
, both
>> as a submitter and as a reviewer.
>>
>> All in all, that means on either side I tend to handle patch RFCs as
>> =E2=80=9CStandard series, just tests missing=E2=80=9D.  Not sure if that=
=E2=80=99s ideal.  Or
>> maybe that=E2=80=99s exactly what patch RFCs are?
>>
>> (Of course, it can and should be argued that even for standard series, I
>> shouldn=E2=80=99t be afraid of questioning the fundamental design still.=
  But
>> that=E2=80=99s hard...)
>=20
> I usually send RFC patches when I know that I wouldn't consider them
> mergable yet, but I don't want to invest the time to polish them before
> I know that other people agree with the approach and the time won't be
> wasted.
>=20
>> But, well.  The alternative is writing pure design RFCs, and then you
>> tend to get weeks of slow discussion, drawing everything out.  Which
>> isn=E2=80=99t ideal either.  Or is that just a baseless prejudice I have=
?
>=20
> In many cases (and I think this is one of them in large parts), I only
> really learn what the series will look like when I write it.

That=E2=80=99s true.  With a pure design RFC, it=E2=80=99s often difficult =
to know even
the scope of the design until you=E2=80=99ve begun to write code.  So there=
=E2=80=99s a
danger of just writing a bunch of uncontroversial basic design stuff
because one has no idea of what may actually become problematic and
questionable. :/

> I could have sent a design RFC for the QAPI part, but I didn't expect
> this to be contentious because it's just the normal add/del/query thing
> that exists for pretty much everything else, too.

Yeah, the functions themselves are clear.

Hm.  Perhaps software engineering just is actually difficult, and
there=E2=80=99s no way around it.

>>>> Basically, I think that the export code should be separate from the co=
de
>>>> setting up the BlockBackend that should be exported, so all options
>>>> regarding that BB should be common; and those options are @node-name,
>>>> @writethrough, and @read-only.  (And perhaps other things like
>>>> @resizable, too, even though that isn=E2=80=99t something to consider =
for NBD.)
>>>
>>> Do you mean that the BlockBackend should already be created by the
>>> generic block export layer?
>>
>> It would certainly be nice, if it were feasible, don=E2=80=99t you think=
?
>>
>> We don=E2=80=99t have to bend backwards for it, but maybe it would force=
 us to
>> bring the natural separation of block device and export parameters to
>> the interface.
>=20
> I can try. I seem to remember that you had a reason not to do this the
> last time we discussed generalised exports, but I'm not sure what it
> was.
>=20
> The obvious one could be that the block export layer doesn't know which
> permissions are needed. But it can always start with minimal permissions
> and let the driver do a blk_set_perm() if it needs more.

Trying sounds good.  Since there shouldn=E2=80=99t be consequences for the =
QMP
interface, we=E2=84=A2 can always try again later (i.e., when adding more e=
xport
types).

Max


--tW7DOyUwUj8GrrdYNijHUqXLGbZksnrfv--

--ipPWo6Uju0uQMt9u0WqjPcwdXLeVAkpSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl86o7wACgkQ9AfbAGHV
z0CDHAgAhbAaz38b//zIvL4kqFTkCzKxPaZog71mj+J6EdZC8tsj8K3FYwMdT1gb
qJjlzSy9JK1ivxJhOxiPHV3V80nTY5gj0ppzeqxYhyiiY+nf/jDq6BLSEwIFpxmM
IWxJxQZN3sSucJk+f3YvHR8oFpUcHk97BAq2hbfxsWU2r8/4p9pztfjOEjDynxWX
8Did2Kzj5KaVEs3YF/+vGoc3RA7NadwbTZ8s5b3/MVH4iJ7NNEhri9efN+fuVZ4/
+vIzpSRZKRrUVJUNef8cONfAQ2GalxEc0rq7PHgdUogwyVt2/1sSBMgy3GmTCcyt
5OX0Jh86QuP9Xu8o3LLn4m28jaUBmQ==
=2Cch
-----END PGP SIGNATURE-----

--ipPWo6Uju0uQMt9u0WqjPcwdXLeVAkpSG--


