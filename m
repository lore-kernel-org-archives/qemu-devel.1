Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60F1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E8D520767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvfjR6wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E8D520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn4t-0004SS-DP
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDn3B-00029R-Mu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:05:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDn38-0005MV-Um
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iiXT1sorOwJhPQ9aXhXiHrtrxFHQHZVpByOWOZVgF/E=;
 b=OvfjR6wc1l9ScvR6yC3UOn+XCjt4q9KQmWRSYogqbpvhioPbvai53Qh2zNz5U/zq6M5ZTx
 0PJtqsuQ7QHKnYFnJv0hzWA/kERxfUzPdn4Yk/tj2DsPorKAKq19ArOyt+NhYUSjh0EJ6g
 UvHq9k0KmU58FOxDPvEV/Ss49DBEV6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-aL_D4SPMNaOmpmWWrSMQBQ-1; Thu, 03 Sep 2020 07:04:59 -0400
X-MC-Unique: aL_D4SPMNaOmpmWWrSMQBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AB5581F002;
 Thu,  3 Sep 2020 11:04:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-164.ams2.redhat.com
 [10.36.112.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE15B5D9CC;
 Thu,  3 Sep 2020 11:04:55 +0000 (UTC)
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 qemu-devel@nongnu.org
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
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
Message-ID: <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
Date: Thu, 3 Sep 2020 13:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599127031.9uxdp5h9o2.astroid@nora.none>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hJXcfCH8ATLmS1RqrSpxDRbkKpuB4L54I"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hJXcfCH8ATLmS1RqrSpxDRbkKpuB4L54I
Content-Type: multipart/mixed; boundary="avzPtqhIsINHFbmZdhdYwrpnIMb5xrwwY"

--avzPtqhIsINHFbmZdhdYwrpnIMb5xrwwY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.09.20 12:13, Fabian Gr=C3=BCnbichler wrote:
> On August 21, 2020 3:03 pm, Max Reitz wrote:
>> On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:
>>
>> [Sorry :/]
>=20
> same, I've been meaning to ping/pick this back up but other stuff got in=
=20
> the way. so thanks for the reminder to get this upstream ;)
>=20
>>
>>> picking up on John's in-progress patch series from last summer, this is
>>> a stab at rebasing and adding test cases for the low-hanging fruits:
>>>
>>> - bitmap mirror mode with always/on-success/never bitmap sync mode
>>> - incremental mirror mode as sugar for bitmap + on-success
>>>
>>> Fabian Gr=C3=BCnbichler (4):
>>>   mirror: add check for bitmap-mode without bitmap
>>>   mirror: switch to bdrv_dirty_bitmap_merge_internal
>>>   iotests: add test for bitmap mirror
>>>   mirror: move some checks to QMP
>>>
>>> John Snow (2):
>>>   drive-mirror: add support for sync=3Dbitmap mode=3Dnever
>>>   drive-mirror: add support for conditional and always bitmap sync mode=
s
>>
>> Looks reasonable to me.  I would indeed merge patches 2 through 4 into a
>> single one, and perhaps switch patches 5 and 6.
>>
>> Also, we still need an S-o-b from John on patch 2.
>>
>> I have one question: When the mirror job completes successfully (or is
>> cancelled =E2=80=9Csuccessfully=E2=80=9D), the bitmap is always fully cl=
eared when the
>> job completes, right?  (Unless in =E2=80=9Cnever=E2=80=9D mode.)
>=20
> I have to take a closer look as well, it's been a while ;)

No problem, I=E2=80=99m... *cough* not exactly in a hurry.

> IIRC the idea=20
> was that failed mirrors would allow re-using the bitmap for a next=20
> attempt, unless the mode is always. we are not using that feature (yet)=
=20
> though (see below).
>=20
>> Not that I think we should change the current implementation of =E2=80=
=9Cclear
>> sync_bitmap; merge dirty_bitmap into sync_bitmap;=E2=80=9D.  Just a ques=
tion for
>> understanding.
>>
>>
>> Soo...  What=E2=80=99s the plan?
>=20
> I'll rebase, squash as suggested and resend next week!

OK :)

> I am not sure how=20
> the S-O-B by John is supposed to enter the mix - should I just include=20
> it in the squashed patch (which would be partly authored, but=20
> not-yet-signed-off by him otherwise?)?

I=E2=80=99m not too sure on the proceedings, actually.  I think it should b=
e
fine if you put his S-o-b there, as long as your patch is somehow based
on a patch that he sent earlier with his S-o-b underneath.  But I=E2=80=99m=
 not
sure.

> do you pick it up once he's replied with one?

Yes, that=E2=80=99s what would be best.

> FWIW, with been running with this for quite a while downstream with no=20
> issues, but we are only using the following part:
>=20
> - create bitmap(s)
> - (incrementally) replicate storage volume(s) out of band (using ZFS)
> - incrementally drive mirror as part of a live migration of VM
> - drop bitmap(s)
>=20
> so no fancy semi-permanent bitmap that gets re-used here. I've been=20
> toying with implementing some sort of generic replication feature akin=20
> to zfs send/recv though, but given that we only have built-in persistent=
=20
> bitmaps with qcow2 and the chance of some other tool or the user messing=
=20
> up other image formats is high, the safe usage scenarios are a bit=20
> limited.

OK.

> we do use such long-running bitmaps for our new backup driver though,=20
> and it works quite well there!

Good! :)

Max


--avzPtqhIsINHFbmZdhdYwrpnIMb5xrwwY--

--hJXcfCH8ATLmS1RqrSpxDRbkKpuB4L54I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9QzdYACgkQ9AfbAGHV
z0CX4gf+OGRQuUNxPYM7wfF7nLt46XjT45IOp8ZcbCpj4mhT+jaWa5rHinSG0hsR
QIk52aSJzKC9WFY/38liNbmSZG70kcfGN7ArquYiPun8tLIMyncHYQs1sBdpBGni
DagtjTqGXxAf1guRTAAOCways5CBh6i9/JMDL0TaSEp9/tSO7qBJBqjU81qpL1WP
9O6GPxE2FXE5P8hky6NEP6QlxmJASVm4Piu60MkATOC+D+aS/4B4VrOI2uCV32Oi
y0rNfNfE/Uw0IxVnUPKuzjV8SJRbX145daZbHN5CG9YLId2ydwjeJXVL9esMSe8m
6XKTOsIqMUlUG0cM+1Wg/uv6wSdOwA==
=LLGm
-----END PGP SIGNATURE-----

--hJXcfCH8ATLmS1RqrSpxDRbkKpuB4L54I--


