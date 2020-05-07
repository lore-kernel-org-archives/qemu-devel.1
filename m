Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCE7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FA5C20870
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajTM43cR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA5C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWeoj-0004Lt-JC
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWenz-0003kL-5V
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:35:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49439
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWeny-0000DB-6r
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588851305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n1T+IKAfJbf0SgVV2xWaeims2i9aHGm11QCsVdNT/js=;
 b=ajTM43cRcLPKNFlitwxA0kFYTfyVOaOCrIU8wQX9HDNVykgKbNXAXlVnAThGo+EVoTzVqW
 2a3W2YXdW2k68vLbCpCStHUyawrXUUmCwmMigw8lRlNlPFxU3qQVN2jku/eWByDy0yttap
 WnaLFubKVvJfNxZbN/R4dYRMdEpjLEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-PWULdfVFMz-rwpTJHPeDZw-1; Thu, 07 May 2020 07:34:54 -0400
X-MC-Unique: PWULdfVFMz-rwpTJHPeDZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BD29107ACCA;
 Thu,  7 May 2020 11:34:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DDA579AD;
 Thu,  7 May 2020 11:34:51 +0000 (UTC)
Subject: Re: [PATCH v3 09/33] block: Add generic bdrv_inherited_options()
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-10-mreitz@redhat.com>
 <20200506103722.GB6333@linux.fritz.box>
 <7d226c94-2f14-eddb-b795-f8a961023947@redhat.com>
 <20200507111920.GC6019@linux.fritz.box>
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
Message-ID: <050bca13-4781-40c5-318a-e40051fa4ef6@redhat.com>
Date: Thu, 7 May 2020 13:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507111920.GC6019@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hl0tYO4DszT5PgBpgi0eGuNZpfbwmlmva"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hl0tYO4DszT5PgBpgi0eGuNZpfbwmlmva
Content-Type: multipart/mixed; boundary="eXSctbaHNPb0zXvSyO73a6eadCvD5cgyb"

--eXSctbaHNPb0zXvSyO73a6eadCvD5cgyb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.05.20 13:19, Kevin Wolf wrote:
> Am 07.05.2020 um 10:49 hat Max Reitz geschrieben:
>> On 06.05.20 12:37, Kevin Wolf wrote:
>>> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>>>> +    if (role & BDRV_CHILD_COW) {
>>>> +        /* backing files are always opened read-only */
>>>
>>> Not "always", just by default.
>>
>> OK.  I just copied the comment from bdrv_backing_options().
>=20
> Yes, sorry, I noticed this only later (it's how review goes when a move
> is split into a copy in one patch and a removal later). I don't insist
> on a change if you prefer to have a clean copy.
>=20
>>>> +        qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on"=
);
>>>> +        qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY,=
 "off");
>>>> +    } else {
>>>> +        /* Inherit the read-only option from the parent if it's not s=
et */
>>>> +        qdict_copy_default(child_options, parent_options, BDRV_OPT_RE=
AD_ONLY);
>>>> +        qdict_copy_default(child_options, parent_options,
>>>> +                           BDRV_OPT_AUTO_READ_ONLY);
>>>> +    }
>>>> +
>>>> +    if (parent_is_format && !(role & BDRV_CHILD_COW)) {
>>>> +        /*
>>>> +         * Our format drivers take care to send flushes and respect
>>>> +         * unmap policy, so we can default to enable both on lower
>>>> +         * layers regardless of the corresponding parent options.
>>>> +         */
>>>> +        qdict_set_default_str(child_options, BDRV_OPT_DISCARD, "unmap=
");
>>>> +    }
>>>
>>> Why the restriction to format here? Don't we break "unmap" propagation
>>> through filters with this?
>>
>> Right now (before this series), the behavior seems ambiguous, in that
>> for filters that use bs->file, it is set, but for those that use
>> bs->backing, it isn=E2=80=99t.
>=20
> It's probably easy to agree that this is a bug.
>=20
>> But I suspect the main reason for what I did is the way I interpreted
>> the comment (which before this series only mentions block drivers in
>> general, not specifically format drivers): It sounded to me as if the
>> block driver needed to respect the unmap policy, and I didn=E2=80=99t th=
ink
>> filters did that.  So it was my understanding that filter drivers would
>> just propagate discards and thus we couldn=E2=80=99t default-enable unma=
p on
>> their children.
>=20
> This was actually my thought as well. And in order to propagate, we have
> to copy the option from parent_options, no? Currently it will always be
> disabled (unless specified explicitly for the node) because that's the
> default setting for unmap.
>=20
>> But I was wrong, the block driver doesn=E2=80=99t need to respect anythi=
ng,
>> because bdrv_co_pdiscard() already does.
>>
>> So I suppose it should indeed be enabled for all children, with the
>> comment changed to express that it isn=E2=80=99t any block driver that r=
espects
>> unmap policy, but bdrv_co_pdiscard(), e.g.:
>>
>> bdrv_co_pdiscard() respects unmap policy for the parent, so we can
>> default to enable it on lower layers regardless of the parent option.
>=20
> This would restore the behaviour before this series for child_file and
> child_format. It would be different in that it also enables "unmap" for
> backing files, which should be okay.
>=20
>>> It would probably also be a good question why we don't propagate it to
>>> the backing file, but this is preexisting.
>>
>> I suppose we should, although it=E2=80=99s irrelevant, so.  I suppose I=
=E2=80=99ll just
>> drop the parent_is_format, adjust the comment and that should be fine
>> for this series.
>=20
> Isn't it relevant for zero writes during active commit? (The "normal"
> intermediate commit job doesn't even try to optimise zero blocks...)
>=20
> The job will have its own BdrvChild to access the node, but option
> inheritance happens only from the parent that "owns" the backing file,
> so if a qcow2 image doesn't set "unmap" on its COW child, unmap will be
> disabled for the active commit job, too.
>=20
> (Oops. Turns out that it's not the case because the 'unmap' option for
> the job exists only for drive-mirror. blockdev-mirror passes true
> unconditionally and block-commit passes false unconditionally. I'm
> always amazed how consistently we fail to be consistent.

Alles kaputt :)

> But I think using zero writes with MAY_UNMAP in a commit job is an
> obvious extension, so considering it now can't hurt anyway.)

OK.  So I=E2=80=99ll just make unmap=3Don the default always.

Max


--eXSctbaHNPb0zXvSyO73a6eadCvD5cgyb--

--hl0tYO4DszT5PgBpgi0eGuNZpfbwmlmva
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6z8lkACgkQ9AfbAGHV
z0DDEwgAtcn1m66JH1nNSaQ8EAeU9BdqBjDZ4Lio9JQmpQdTq3CruiZ98kWI5SY0
gj3sj1NNBsDkeaAbMrFtGJMNQz4R9LHauAlRcwsMpEom2BGfNg1HkgQn8VNP0Pht
sPoz6vwm4fFx6scrM2eQq40Qw7KUjb7L26fSBpWpnFu+chjclnt3ZdB8Vd2l/KGT
Evne/l/jy7v2LXd+rMSO73Uss/ugSdJtQPMkvL3zpDT/4MPuh9nzuFPMM0t1n75s
KIfJBpfik9kDDPKZDrB5A/eR+ApWFhHfSnm/lsbc9PqX9U6MWBb2Gjy+BH+zeuDe
UZSI35+hZxJ0meNrQfQKGwbaAXfG2Q==
=jgmv
-----END PGP SIGNATURE-----

--hl0tYO4DszT5PgBpgi0eGuNZpfbwmlmva--


