Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28527C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E5220732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvFvOFJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E5220732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6dfg-0006TW-2u
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6dZW-00088V-Mm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6dZV-0004Fu-Ag
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:00:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6dZV-0004Fd-6I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582650036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vMkvvy1bc1SLU387a1G2XyB0Yg/GAh6v1nS+Cxzx/oM=;
 b=hvFvOFJMt9WbfXZ4LwM6Eku6yMOjnoPl3HEVfEYxEEKxGBH6Mnllvo9fU4N96SLiXXCY8w
 RbqlyZvbXqxRjwiAWKZTIcuSvA+mHJ001FzYLGWbs/3uGgfbIa2AbgnHyb/iCgQWKRXl4Z
 G29sWOMKQ7vHYUMb3wKF2cSA0EGYUZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-lI9SP4UZMS6l_MAY9BHlSw-1; Tue, 25 Feb 2020 12:00:32 -0500
X-MC-Unique: lI9SP4UZMS6l_MAY9BHlSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2193D1005514;
 Tue, 25 Feb 2020 17:00:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C786271A1;
 Tue, 25 Feb 2020 17:00:29 +0000 (UTC)
Subject: Re: QAPI schema for desired state of LUKS keyslots
To: Markus Armbruster <armbru@redhat.com>
References: <20200114193350.10830-1-mlevitsk@redhat.com>
 <20200114193350.10830-3-mlevitsk@redhat.com>
 <87lfp36gzh.fsf_-_@dusky.pond.sub.org>
 <ad92d470-7388-c419-f3fb-0bfd541b670b@redhat.com>
 <871rqid35p.fsf@dusky.pond.sub.org>
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
Message-ID: <f6008cc8-e7d2-87a1-384e-eb651cf40ab7@redhat.com>
Date: Tue, 25 Feb 2020 18:00:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <871rqid35p.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ILLeI3nID2uyIGVqibB1LWorNapJzAWxQ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILLeI3nID2uyIGVqibB1LWorNapJzAWxQ
Content-Type: multipart/mixed; boundary="rypwRJNtnGhbN1FXfBzf0zzjq6pLwUEn5"

--rypwRJNtnGhbN1FXfBzf0zzjq6pLwUEn5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.02.20 17:48, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> On 15.02.20 15:51, Markus Armbruster wrote:
>>> Review of this patch led to a lengthy QAPI schema design discussion.
>>> Let me try to condense it into a concrete proposal.
>>>
>>> This is about the QAPI schema, and therefore about QMP.  The
>>> human-friendly interface is out of scope.  Not because it's not
>>> important (it clearly is!), only because we need to *focus* to have a
>>> chance at success.
>>>
>>> I'm going to include a few design options.  I'll mark them "Option:".
>>>
>>> The proposed "amend" interface takes a specification of desired state,
>>> and figures out how to get from here to there by itself.  LUKS keyslots
>>> are one part of desired state.
>>>
>>> We commonly have eight LUKS keyslots.  Each keyslot is either active or
>>> inactive.  An active keyslot holds a secret.
>>>
>>> Goal: a QAPI type for specifying desired state of LUKS keyslots.
>>>
>>> Proposal:
>>>
>>>     { 'enum': 'LUKSKeyslotState',
>>>       'data': [ 'active', 'inactive' ] }
>>>
>>>     { 'struct': 'LUKSKeyslotActive',
>>>       'data': { 'secret': 'str',
>>>                 '*iter-time': 'int } }
>>>
>>>     { 'struct': 'LUKSKeyslotInactive',
>>>       'data': { '*old-secret': 'str' } }
>>>
>>>     { 'union': 'LUKSKeyslotAmend',
>>>       'base': { '*keyslot': 'int',
>>>                 'state': 'LUKSKeyslotState' }
>>>       'discriminator': 'state',
>>>       'data': { 'active': 'LUKSKeyslotActive',
>>>                 'inactive': 'LUKSKeyslotInactive' } }
>>
>> Looks OK to me.  The only thing is that @old-secret kind of works as an
>> address, just like @keyslot,
>=20
> It does.
>=20
>>                              so it might also make sense to me to put
>> @keyslot/@old-secret into a union in the base structure.
>=20
> I'm fine with state-specific extra adressing modes (I better be, I
> proposed them).
>=20
> I'd also be fine with a single state-independent addressing mode, as
> long as we can come up with sane semantics.  Less flexible when adding
> states, but we almost certainly won't.
>=20
> Let's see how we could merge my two addressing modes into one.
>=20
> The two are
>=20
> * active
>=20
>   keyslot     old-secret      slot(s) selected
>   absent      N/A             one inactive slot if exist, else error
>   present     N/A             the slot given by @keyslot

Oh, I thought that maybe we could use old-secret here, too, for
modifying the iter-time.  But if old-secret makes no sense for
to-be-active slots, then there=E2=80=99s little point in putting old-secret=
 in
the base.

(OTOH, specifying old-secret for to-be-active slots does have a sensible
meaning; it=E2=80=99s just that we won=E2=80=99t support changing anything =
about
already-active slots, except making them inactive.  So that might be an
argument for not making it a syntactic error, but just a semantic error.)

[...]

> Note we we don't really care what "inactive, both absent" does.  My
> proposed semantics are just the most regular I could find.  We can
> therefore resolve the conflict by picking "active, both absent":
>=20
>   keyslot     old-secret      slot(s) selected
>   absent      absent          one inactive slot if exist, else error
>   present     absent          the slot given by @keyslot
>   absent      present         all active slots holding @old-secret
>   present     present         the slot given by @keyslot, error unless
>                               it's active holding @old-secret
>=20
> Changes:
>=20
> * inactive, both absent: changed; we select "one inactive slot" instead o=
f
>   "all slots".
>=20
>   "All slots" is a no-op when the current state has no active keyslots,
>   else error.
>=20
>   "One inactive slot" is a no-op when the current state has one, else
>   error.  Thus, we no-op rather than error in some states.
>=20
> * active, keyslot absent or present, old-secret present: new; selects
>   active slot(s) holding @old-secret, no-op when old-secret =3D=3D secret=
,
>   else error (no in place update)
>=20
> Can do.  It's differently irregular, and has a few more combinations
> that are basically useless, which I find unappealing.  Matter of taste,
> I guess.
>=20
> Anyone got strong feelings here?

The only strong feeling I have is that I absolutely don=E2=80=99t have a st=
rong
feeling about this. :)

As such, I think we should just treat my rambling as such and stick to
your proposal, since we=E2=80=99ve already gathered support for it.

Max


--rypwRJNtnGhbN1FXfBzf0zzjq6pLwUEn5--

--ILLeI3nID2uyIGVqibB1LWorNapJzAWxQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5VUqwACgkQ9AfbAGHV
z0AEmAf/TzMTAeimcb1Jy2kgNgHrYPOCH6j3oG59rNV00RKkyHHbBARcj+l1gCgS
TE15LZuxvnCqOl9SFm67EAbZFSo2c0SO6j89fsQ92HktQedeEdDI1+IvLERB7XdF
VsdVvqH+nwKremBwqXT5r0NszitzULRQJA8sgouEUeOqiieR9f2DupmioEorUztD
R4fDLmc8ouTsmud8hPLlIclKr47Rs9mJDobyE6/+HublO/zYZLAS3Z4WY3rf8g+c
WScF42paZfRMvh25sp9FgltIREUUGGCPPxymg8IiIf0Az28vdvH03cNbE3+tdCX6
6aCd65EUim/115S5A5jIMUevxBiR/A==
=rhOs
-----END PGP SIGNATURE-----

--ILLeI3nID2uyIGVqibB1LWorNapJzAWxQ--


