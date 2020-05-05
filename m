Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C8EC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1048D2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c51wduVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1048D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxVw-0008WT-Gd
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxUl-0006jj-Jg
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:20:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25419
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxUj-0003N1-Sh
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588684820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gRyoUcRVjfG1FfWtZf231ncqGMu4fEpr59pljQr0wfk=;
 b=c51wduVMGuq9W63godjdWILOWSFMQpzn8HMbSAsaxqCFfbIjEL9KpJnlrL0PPzC2KDT4Kw
 PKbuKQi3oQJa2BqIAiaEK63Fd2rexct+qMBzbYptk/hqayThoodMMwGXm1go8ycevh+eBg
 F/3sQnNQPvrG3oTkq6m9+zJwGN4+Ctc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-ZfJ7CmsIOUKuLg-xi3OPcQ-1; Tue, 05 May 2020 09:20:18 -0400
X-MC-Unique: ZfJ7CmsIOUKuLg-xi3OPcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CF52800687;
 Tue,  5 May 2020 13:20:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-206.ams2.redhat.com
 [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F4506295D;
 Tue,  5 May 2020 13:20:16 +0000 (UTC)
Subject: Re: [PATCH v3 03/33] block: Add BdrvChildRole and BdrvChildRoleBits
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-4-mreitz@redhat.com>
 <20200505111936.GJ5759@linux.fritz.box>
 <aa2c60ac-0e41-bf3b-d81d-fe504c42c172@redhat.com>
 <20200505125413.GK5759@linux.fritz.box>
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
Message-ID: <3b03c233-7aa7-b292-d05a-c9a79d7e9703@redhat.com>
Date: Tue, 5 May 2020 15:20:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505125413.GK5759@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="X9h8DOfr7yQ7gxwtj94YABQ3CJEexMZYB"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
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
--X9h8DOfr7yQ7gxwtj94YABQ3CJEexMZYB
Content-Type: multipart/mixed; boundary="MybxbMYWXRR2dubflwdTseothxaNZ0cpA"

--MybxbMYWXRR2dubflwdTseothxaNZ0cpA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.05.20 14:54, Kevin Wolf wrote:
> Am 05.05.2020 um 13:59 hat Max Reitz geschrieben:
>> On 05.05.20 13:19, Kevin Wolf wrote:
>>> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:

[...]

>>>> +    /* Useful combination of flags */
>>>> +    BDRV_CHILD_IMAGE        =3D BDRV_CHILD_DATA
>>>> +                              | BDRV_CHILD_METADATA
>>>> +                              | BDRV_CHILD_PRIMARY,
>>>> +};
>>>> +
>>>> +/* Mask of BdrvChildRoleBits values */
>>>> +typedef unsigned int BdrvChildRole;
>>>> +
>>>>  char *bdrv_perm_names(uint64_t perm);
>>>>  uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm);
>>>
>>> The list intuitively makes sense to me. Let me try to think of some
>>> interesting cases to see whether the documentation is complete or
>>> whether it could be improved.
>>>
>>>
>>> qcow2 is what everyone has in mind, so it should be obvious:
>>>
>>> * Without a data file:
>>>   * file: BDRV_CHILD_IMAGE
>>>   * backing: BDRV_CHILD_COW
>>>
>>> * With a data file:
>>>   * file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
>>>   * data-file: BDRV_CHILD_DATA
>>>   * backing: BDRV_CHILD_COW
>>>
>>>
>>> We can use VMDK to make things a bit more interesting:
>>>
>>> * file: BDRV_CHILD_PRIMARY | BDRV_CHILD_METADATA
>>> * extents.*: BDRV_CHILD_METADATA | BDRV_CHILD_DATA
>>> * backing: BDRV_CHILD_COW
>>>
>>> In other words, we can have multiple data and metadata children. Is thi=
s
>>> correct or should extents not be marked as metadata? (Checked the final
>>> code: yes we do have multiple of them in vmdk.) Should this be mentione=
d
>>> in the documentation?
>>
>> If the extents contain metadata (I thought not, but I think I was just
>> wrong; sparse extents must contain their respective mapping structures),
>> then yes, they should all be marked as metadata children.
>>
>> I=E2=80=99m not sure whether that needs to be mentioned explicitly in th=
e doc,
>> because =E2=80=9CChild stores metadata=E2=80=9D seems sufficient to me.
>=20
> When you're the author, the meaning of everything is clear to you. :-)
>=20
> In case of doubt, I would be more explicit so that the comment gives a
> clear guideline for which role to use in which scenario.

OK, so you mean just noting everywhere explicitly how many children can
get a specific flag, and not just in some cases?  That is, make a note
for DATA and METADATA that they can be given to an arbitrary number of
children, and COW only to at most one.

>>> Do we then also want to allow multiple BDRV_CHILD_COW children? We don'=
t
>>> currently have a driver that needs it, but maybe it would be consistent
>>> with DATA and METADATA then. However, it would contradict the
>>> documentation that it's the "Child from which to read all data".
>>
>> Yes.  I would revisit that problem when the need arises.
>>
>> It seems to me like this would open a whole can of worms, just like
>> allowing multiple filtered children does.
>=20
> Okay. Shall we document it explicitly like we do for the filter role?

Yep.

>>> blkverify:
>>>
>>> * x-image: BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
>>> * x-raw: BDRV_CHILD_DATA | BDRV_CHILD_FILTERED
>>>
>>> Hm, according to the documentation, this doesn't work, FILTERED can be
>>> set only for one node. But the condition ("the parent forwards all read=
s
>>> and writes") applies to both children. I think the documentation should
>>> mention what needs to be done in such cases.
>>
>> I don=E2=80=99t know.  blkverify is a rare exception by design, because =
it can
>> abort when both children don=E2=80=99t match.  (I suppose we could theor=
etically
>> have a quorum mode where a child gets ejected once a mismatch is
>> detected, but that isn=E2=80=99t the case now.)
>=20
> Well, yes, this is exceptional. I would ignore that property for
> assigning roles because when it comes to play, roles don't matter any
> more because the whole process is gone. So...
>=20
>> Furthermore, I would argue that blkverify actually expects the formatted
>> image to sometimes differ from the raw image, if anything, because the
>> format driver is to be tested.  This is the reason why I chose x-raw to
>> be the filtered child.
>=20
> ...I don't think this case is relevant. If blkverify returns something,
> both children have the same data.

Another argument is that right now, bs->file points to x-raw, and
.is_filter is set.  So x-raw is already treated as the filtered child.

>> So there is no general instruction on what to do in such cases that I
>> followed here, I specifically chose one child based on what blkverify is
>> and what it=E2=80=99s supposed to do.  Therefore, I can=E2=80=99t really=
 give a general
>> instruction on =E2=80=9Cwhat needs to be done in such cases=E2=80=9D.
>=20
> Maybe the missing part for me is what FILTERED is even used for. I
> assume it's for skipping over filters in certain functions in the
> generic block layer?

Yes.

> In this case, maybe the right answer is that...
>=20
>>> For blkverify, both
>>> children are not equal in intention, so I guess the "real" filtered
>>> child is x-image. But for quorum, you can't make any such distinction. =
I
>>> assume the recommendation should be not to set FILTERED for any child
>>> then.
>>
>> Quorum just isn=E2=80=99t a filter driver.
>=20
> ...blkverify isn't one either because performing an operation on only
> one child usually won't be correct.

Good point.  It would work if filters are just skipped for functions
that read/query stuff, which I think is the case.  I don=E2=80=99t think we=
 ever
skip filters when it comes to modifying data.

In any case, I wouldn=E2=80=99t lose too much sleep over blkverify whatever=
 we
do.  It=E2=80=99s a driver used purely for debugging purposes.

>>> Looking at the final code... Hm, your choice looks quite different: You
>>> don't have DATA for x-raw, but you make it the PRIMARY and FILTERED
>>> child. I think PRIMARY/FILTERED is just a bug (e.g. getlength and flush
>>> being forwarded only to x-image show that it's primary).
>>
>> I rather consider getlength() a special case.  Ideally, we=E2=80=99d for=
ward
>> getlength() to both and compare the results; however, image formats
>> might have different size resolution than raw files, so there could be a
>> difference, but it=E2=80=99d be irrelevant.
>>
>> It makes then sense to forward it to the formatted image, because
>> generally formats have byte resolution for the disk size, whereas for
>> raw files it depends on caching and the filesystem, I think.
>>
>> As for flush, yes, why do we forward it only to x-image?  Why is =E2=80=
=9Cthe
>> raw file not important=E2=80=9D?
>=20
> Because it's the copy that is used to check whether the main image is
> correct. If things break, you just create a new copy. At least that's
> how blkverify was supposed to be used.

I wonder why blkverify decides that.  This should be up to the user, and
if the user wants to keep the verification image around, blkverify
shouldn=E2=80=99t prevent that.

> In fact, I guess in the typical use cases for blkverify, cache=3Dunsafe i=
s
> enough anyway because you would start over from scratch, so... not a
> strong argument.

That too.

>>> I do wonder
>>> whether I have a different interpretation of DATA than you, though.
>>
>> I never set DATA for FILTERED, because I consider FILTERED to be
>> stronger than DATA, so once FILTERED is set, it doesn=E2=80=99t matter w=
hether
>> DATA is set or not.  I suppose that should either be mentioned in the
>> documentation, or we decide that we should always set DATA regardless.
>=20
> Either option should be fine. I guess documenting it is less work.

OK.

>>> Also, the comparison makes me wonder whether FILTERED always implies
>>> PRIMARY? Would there ever be a scenario where a child is FILTERED, but
>>> not PRIMARY?
>>
>> I don=E2=80=99t know.  I suppose it does.  But what=E2=80=99s the implic=
ation?
>=20
> *shrug* I was just asking to see if I understand things right. We could
> document it, but I don't have a good reason why we must do that.

OK.

> Maybe the more relevant question would be if a FILTERED child must be
> the only child to avoid the problems we're discussing for blkverify. But
> I think I already answered that question for myself with "no", so
> probably not much use asking it.

blkverify is just a bit weird, and I personally don=E2=80=99t mind just tre=
ating
it as something =E2=80=9Cspecial=E2=80=9D, considering it=E2=80=99s just a =
debugging aid.

Regardless of blkverify, I don=E2=80=99t think FILTERED children must be th=
e
only children, though, because I can well imagine filter drivers having
metadata children on the side, e.g. config data or bitmaps (not just
dirty bitmaps, but also e.g. what to cache for a hypothetical cache driver)=
.

Max


--MybxbMYWXRR2dubflwdTseothxaNZ0cpA--

--X9h8DOfr7yQ7gxwtj94YABQ3CJEexMZYB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6xaA4ACgkQ9AfbAGHV
z0C9QAgApOP7tHhR53NA1G1T2LZWdrpj1k6AQvKzqMwWLcx+/TmcLeUKfgE6zdK9
bLnUk/7SU8VTAf8OsEGx1PExw9k4m5Yi+BnA+APcOOEtxW5mKSx//tB9F8tBAkig
Yc9HFMeS5ILaKEAiFNfXC0cgY90WCBj8mVq2iicuskCnr3CjDjASMKlDVeyoZ97f
iXMzSoKJTz/dx5YhywfT7NDiHj7WsyoWU6ifZROVIqZ0lh0KxGyKt2kMsXv/NAsM
GMt8WTh3oVWQvedGBRg/wCT0OU+oJFVfbaIS5Q8ImEF8sqkzwuC5YY9eDVNzI2Or
CzPTEAXuZrlzzl30C8S7CuM+BaBhoA==
=I1SO
-----END PGP SIGNATURE-----

--X9h8DOfr7yQ7gxwtj94YABQ3CJEexMZYB--


