Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0671C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2BF208B3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeLO3xhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2BF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDpfU-0006rN-Uz
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDpee-0005wA-06
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDpec-0002Ah-0M
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599141112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qjfTuVSUMnBMQ1OxXmxodd3enxMxI6BQu9tCRf8lgwc=;
 b=KeLO3xhWk+U00Po4CZqdUqYh0usO3FnufdV/wEVYDwDzlx7fP8nSjajgShKKeHtIKrS8Bz
 rEs465SkSTCL9fypeOPQX4EVHGoMfClFAO5MlxutMszIhTdlsek8h/aRSKffOcfE9habNc
 vx07EVLarrE/7LcgsReo/2Apb3qzgKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-w15k2X7cNk2ZGbqYCvSbCg-1; Thu, 03 Sep 2020 09:51:49 -0400
X-MC-Unique: w15k2X7cNk2ZGbqYCvSbCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5993E1019625;
 Thu,  3 Sep 2020 13:51:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-164.ams2.redhat.com
 [10.36.112.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAA6A19C78;
 Thu,  3 Sep 2020 13:51:46 +0000 (UTC)
Subject: Re: [RFC qemu 0/6] mirror: implement incremental and bitmap modes
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
 <d35a76de-78d5-af56-0b34-f7bd2bbd3733@redhat.com>
 <1599127031.9uxdp5h9o2.astroid@nora.none>
 <ef545f46-7cbb-43f0-2ab8-f3d49643d1e6@redhat.com>
 <20200903123850.GB8835@linux.fritz.box>
 <ec747431-b2fa-2e67-984b-3cf70e0c79e4@redhat.com>
 <20200903132343.GD8835@linux.fritz.box>
 <1599140071.n44h532eeu.astroid@nora.none>
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
Message-ID: <f061cf19-2633-e8c9-34b8-baa8b6004c47@redhat.com>
Date: Thu, 3 Sep 2020 15:51:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599140071.n44h532eeu.astroid@nora.none>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rOkZwV6iD1BjoLYT3W5M9KOejgRPM5pNG"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rOkZwV6iD1BjoLYT3W5M9KOejgRPM5pNG
Content-Type: multipart/mixed; boundary="PqllfYE3his0zitYEfDyKnMc81uFR9ZfN"

--PqllfYE3his0zitYEfDyKnMc81uFR9ZfN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.09.20 15:36, Fabian Gr=C3=BCnbichler wrote:
> On September 3, 2020 3:23 pm, Kevin Wolf wrote:
>> Am 03.09.2020 um 14:57 hat Max Reitz geschrieben:
>>> On 03.09.20 14:38, Kevin Wolf wrote:
>>>> Am 03.09.2020 um 13:04 hat Max Reitz geschrieben:
>>>>> On 03.09.20 12:13, Fabian Gr=C3=BCnbichler wrote:
>>>>>> On August 21, 2020 3:03 pm, Max Reitz wrote:
>>>>>>> On 18.02.20 11:07, Fabian Gr=C3=BCnbichler wrote:
>>>>>> I am not sure how=20
>>>>>> the S-O-B by John is supposed to enter the mix - should I just inclu=
de=20
>>>>>> it in the squashed patch (which would be partly authored, but=20
>>>>>> not-yet-signed-off by him otherwise?)?
>>>>>
>>>>> I=E2=80=99m not too sure on the proceedings, actually.  I think it sh=
ould be
>>>>> fine if you put his S-o-b there, as long as your patch is somehow bas=
ed
>>>>> on a patch that he sent earlier with his S-o-b underneath.  But I=E2=
=80=99m not
>>>>> sure.
>>>>
>>>> Signed-off-by means that John certifies the DCO for the patch (at leas=
t
>>>> the original version that you possibly modified), so you cannot just a=
dd
>>>> it without asking him.
>>>
>>> But what if you take a patch from someone and heavily modify it =E2=80=
=93
>>> wouldn=E2=80=99t you keep the original S-o-b and explain the modificati=
ons in
>>> the commit message?
>>
>> Ah, if that patch already had a S-o-b, then yes. You keep it not only to
>> show who touched the patch, but also because your own S-o-b depends on
>> the one from the original author (you only have the rights to contribute
>> it because the original author had them and could pass them on to you).
>>
>> I thought it was based on a patch that came without S-o-b.
>=20
> it is (taken from John's git, with his approval, and implicit admission=
=20
> that S-O-B is just missing because it was a WIP branch/tree that I=20
> started from). that was also the reason why I kept that patch unmodified=
=20
> and sent my modifications as patches on-top, to make it easier for John=
=20
> to verify that that one patch is his original WIP one and add this=20
> missing S-O-B ;)

OK, I see now.  I thought the S-o-b got lost somewhere, but was present
originally.

Max


--PqllfYE3his0zitYEfDyKnMc81uFR9ZfN--

--rOkZwV6iD1BjoLYT3W5M9KOejgRPM5pNG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9Q9PEACgkQ9AfbAGHV
z0CUwgf6AhtNH3hu8N+0wOVvzwnpOpzaHatG6r8DCZ6oY5WEZjA2mSFcTc+Qf/kj
i6+Xtq3G6RTp44N5dL8esaCuhYZPRdyAzTyuduLBcy/KR8CQtlzaJuTqKhQY1ivT
crVLn4TAvSJZWsJSmcE6XpTG5JXmBVPYx6qd81SfIAvKCHz4t7D2qAUpi7fHsTcP
rwuVjM3BeGF5ARUY5Pl4FMlECy7dXPF7684+1xHVKZd3Xqg5KO1HiZhoNwosHmuD
vsSyVX5uKaav6adUcil3muG8T36qsZm2qtN5j7tRWszeTOqobTy0R936bai2h1AD
/HlshIKWav0Sn0IKn4boX7TZ2rBCfw==
=eT3o
-----END PGP SIGNATURE-----

--rOkZwV6iD1BjoLYT3W5M9KOejgRPM5pNG--


