Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5552207CD
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea4rAuz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5552207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADjw-0006AP-2J
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kADfk-00063e-G0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:42:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60796
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kADfg-0004yH-7s
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598280123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WYUXSTa+rnpB122QtBJOwo9akjCZ/niIoMj+BZJAPJs=;
 b=ea4rAuz+/8H6pl8B5VwbMY1q3Qwd49XYwhH6X76xnaLYgFsUdo69z6/MzBUIwByhk5HX1L
 UDv8hc4Bykk6yp3LPp2pMuRDxvouE7yGGFjzWD7fyJxCFQktTl3OP0gUyoGqm4yJ1+h1/B
 cGf9nNUVMEVIzgDXAXiCnk3emV+E+OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-Eb8dQCQzOleYsfaoee35aQ-1; Mon, 24 Aug 2020 10:41:59 -0400
X-MC-Unique: Eb8dQCQzOleYsfaoee35aQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0FF98030D5;
 Mon, 24 Aug 2020 14:41:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-171.ams2.redhat.com
 [10.36.112.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A68397038A;
 Mon, 24 Aug 2020 14:41:57 +0000 (UTC)
Subject: Re: [PATCH v7 39/47] blockdev: Fix active commit choice
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-40-mreitz@redhat.com>
 <20200821155011.GA26691@linux.fritz.box>
 <74e6ed51-d610-0982-d265-c8168b5f958c@redhat.com>
 <20200824140739.GB10708@linux.fritz.box>
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
Message-ID: <7a02c449-2bef-08d4-bd3f-41eac0276424@redhat.com>
Date: Mon, 24 Aug 2020 16:41:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824140739.GB10708@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2kNNfbDtQmBahod1t9a0db6lcynQPjjef"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 08:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--2kNNfbDtQmBahod1t9a0db6lcynQPjjef
Content-Type: multipart/mixed; boundary="KbKCuwliht0gWyOVFnpIHWh5Ud3q0vVq1"

--KbKCuwliht0gWyOVFnpIHWh5Ud3q0vVq1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.08.20 16:07, Kevin Wolf wrote:
> Am 24.08.2020 um 15:18 hat Max Reitz geschrieben:
>> On 21.08.20 17:50, Kevin Wolf wrote:
>>> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
>>>> We have to perform an active commit whenever the top node has a parent
>>>> that has taken the WRITE permission on it.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>  blockdev.c | 24 +++++++++++++++++++++---
>>>>  1 file changed, 21 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/blockdev.c b/blockdev.c
>>>> index 402f1d1df1..237fffbe53 100644
>>>> --- a/blockdev.c
>>>> +++ b/blockdev.c
>>>> @@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const cha=
r *job_id, const char *device,
>>>>      AioContext *aio_context;
>>>>      Error *local_err =3D NULL;
>>>>      int job_flags =3D JOB_DEFAULT;
>>>> +    uint64_t top_perm, top_shared;
>>>> =20
>>>>      if (!has_speed) {
>>>>          speed =3D 0;
>>>> @@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const c=
har *job_id, const char *device,
>>>>          goto out;
>>>>      }
>>>> =20
>>>> -    if (top_bs =3D=3D bs) {
>>>> +    /*
>>>> +     * Active commit is required if and only if someone has taken a
>>>> +     * WRITE permission on the top node.
>>>
>>> ...or if someone wants to take a WRITE permission while the job is
>>> running.
>>>
>>> Future intentions of the user is something that we can't know, so maybe
>>> this should become an option in the future (not in this series, of
>>> course).
>>>
>>>>                                            Historically, we have alway=
s
>>>> +     * used active commit for top nodes, so continue that practice.
>>>> +     * (Active commit is never really wrong.)
>>>> +     */
>>>
>>> Changing the practice would break compatibility with clients that start
>>> an active commit job and then attach it to a read-write device, so we
>>> must continue the practice. I think the comment should be clearer about
>>> this, it sounds more like "no reason, but why not".
>>
>> I think that=E2=80=99s what I meant by =E2=80=9Chistorically=E2=80=9D.  =
Is =E2=80=9Clegacily=E2=80=9D a word?
>>
>> But sure, I can make it more explicit.
>>
>>> This is even more problematic because the commit job doesn't unshare
>>> BLK_PERM_WRITE yet, so it would lead to silent corruption rather than a=
n
>>> error.
>>>
>>>> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
>>>> +    if (top_perm & BLK_PERM_WRITE ||
>>>> +        bdrv_skip_filters(top_bs) =3D=3D bdrv_skip_filters(bs))
>>>> +    {
>>>>          if (has_backing_file) {
>>>>              error_setg(errp, "'backing-file' specified,"
>>>>                               " but 'top' is the active layer");
>>>
>>> Hm, this error message isn't accurate any more.
>>>
>>> In fact, the implementation isn't consistent with the QAPI documentatio=
n
>>> any more, because backing-file is only an error for the top level.
>>
>> Hm.  I wanted to agree, and then I wanted to come up with a QAPI
>> documentation that fits the new behavior (because I think it makes more
>> sense to change the QAPI documentation along with the behavior change,
>> rather than to force us to allow backing-file for anything that isn=E2=
=80=99t on
>> the top layer).
>>
>> But in the process of coming up with a better description, I noticed
>> that this doesn=E2=80=99t say =E2=80=9Cis a root node=E2=80=9D, it says =
=E2=80=9Cis the active layer=E2=80=9D.
>> I would say a node in the active layer is a node that has some parent
>> that has taken a WRITE permission on it.  So actually I think that the
>> documentation is right, and this code only now fits.
>=20
> Then you may have not only "the" active layer, but multiple active
> layers. I find this a bit counterintuitive.

Depends on what you count as a layer.  I don=E2=80=99t think that=E2=80=99s=
 a clearly
defined term, is it?  I only know of =E2=80=9Cactive layer=E2=80=9D, =E2=80=
=9Cformat layer=E2=80=9D,
=E2=80=9Cprotocol layer=E2=80=9D, and you can at least have multiple format=
 layers above
each other.  So I don=E2=80=99t find it counterintuitive.

But perhaps it=E2=80=99d be best to just get away from the term =E2=80=9Cac=
tive layer=E2=80=9D,
as you propose below.

> There is a simple reason why backing-file is an error for a root node:
> It doesn't have overlays, so a value to write to the header of overlay
> images just doesn't make sense.

Ah, yeah...

> The same reasoning doesn't apply for writable images that do have
> overlays. Forbidding backing-file is a more arbitrary restriction there.
> I'm not saying that we can't make arbitrary restrictions where allowing
> an option is not worth the effort, but I feel they should be spelt out
> more explicitly instead of twisting words like "active layer" until they
> fit the code.

I=E2=80=99m all for spelling it out more explicitly.  I just noticed that I
couldn=E2=80=99t clearly distinguish =E2=80=9Cactive layer=E2=80=9D from =
=E2=80=9Cother=E2=80=9D cases of nodes
with writers on them, which is why I noted that =E2=80=9Cactive=E2=80=9D to=
 me means the
post-patch behavior already.

You=E2=80=99re right that there is no semantic reason for making it an erro=
r.
So I just want it to be an error to be lazy.  I hope you let me do that.
 (I don=E2=80=99t think there=E2=80=99s much of a problem with it, consider=
ing that
commits on nodes that have the WRITE permission taken are basically just
completely broken right now.)

>> Though I do think this wants for some clarification.  Perhaps =E2=80=9CI=
f 'top'
>> is the active layer (i.e., is a node that may be written to), specifying
>> a backing [...]=E2=80=9D?
>=20
> "If 'top' doesn't have an overlay image or is in use by a writer..."?

I.e., avoiding the term =E2=80=9Cactive layer=E2=80=9D altogether?  Sounds =
good.  Only,
I don=E2=80=99t know about =E2=80=9Cwriter=E2=80=9D...  But it=E2=80=99s al=
ready used in
BlockdevOptionsFile.dynamic-auto-read-only=E2=80=99s description, so I supp=
ose
we can use it here, too.  (I just don=E2=80=99t know if as a
non-block-layer-developer I=E2=80=99d know what it means.)

(Also, yes, you=E2=80=99re right, the current behavior of giving all root n=
odes
an active commit of course remains, even when there are no writers.)

>> There=E2=80=99s more wrong with the specification, namely the whole part=
 under
>> @backing-file past the =E2=80=9C(Since 2.1)=E2=80=9D, starting with =E2=
=80=9CIf top =3D=3D base=E2=80=9D.  I
>> think all of that should go to the top level.  (And =E2=80=9CIf top =3D=
=3D active=E2=80=9D
>> should be changed to =E2=80=9CIf top is active (i.e., may be written to)=
=E2=80=9D.)
>=20
> At least the latter only becomes wrong with this patch, so I think it
> needs to be changed by this patch.

Sure.  So I understand you agree with moving the whole chunk, right?

Max


--KbKCuwliht0gWyOVFnpIHWh5Ud3q0vVq1--

--2kNNfbDtQmBahod1t9a0db6lcynQPjjef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9D0bMACgkQ9AfbAGHV
z0CKjAf/SC4PymcwXKUlLu4xFOTp89df6qV9hS/XTYNheKexEg9+gIAufwNJdrdN
GyHIm54Y/Oe43KV0KuhfK3HdB5w0BTCxErFHhB+42N7W/2ywfjtNARettY+mpJRK
MaWuceYA8iCw44DwRuOKbtt1ilTMKhrQpt5S2qGjsGscvaAVdxsfVaH2W+OJ3HHi
6VyWOmf6iJXDg+YtjyfKtrViD1ICnUkBabHpo1UbEOwvVI4Zu+N1HiJLGm/90Ftn
Y3ESflxL18TuLAghOUMgTDd/tQO31YlAEtKKOfdRUvbDu8WZmfubgwWx9Yt/epcK
ZUVPdwj2z12oYutfafdm8D09esiwmg==
=rPdA
-----END PGP SIGNATURE-----

--2kNNfbDtQmBahod1t9a0db6lcynQPjjef--


