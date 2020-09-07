Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49B3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74428207C3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrujSPVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74428207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFFfo-0005qi-Km
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFFa9-0005iJ-Em
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:45:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kFFa7-0003lE-9u
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599479106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3PY+iHzCzYNaFJDP+3GmaN02aP257qQCnWM68c4YePo=;
 b=QrujSPVfH44L1gqVn1T87TFghD+tZXEn3OX6/K6D07yT566HIQZDw97UgHXxftU7yYpPWW
 KToTfhAEKCRzFcqVNXtOnTuDb4S1DiYYvUCwgDGkcTs5SNS1q1QM0+kpiAgomGVxTbXyJR
 xuIt3hZQZXxNy/p2LYcrs3Itj5encRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-nwYzBXWINxyczQomNJssMA-1; Mon, 07 Sep 2020 07:45:03 -0400
X-MC-Unique: nwYzBXWINxyczQomNJssMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9691A1007461;
 Mon,  7 Sep 2020 11:45:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-5.ams2.redhat.com
 [10.36.113.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 637575D9D2;
 Mon,  7 Sep 2020 11:45:00 +0000 (UTC)
Subject: Re: [PATCH v8 6/7] block-stream: freeze link to base node during
 stream job
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1598633579-221780-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1598633579-221780-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <9739719d-0681-d839-cf8d-398b78b6d323@redhat.com>
 <3a52e54e-22fe-6eee-439a-dc1db0a1bf63@virtuozzo.com>
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
Message-ID: <a6bc0dc7-12d8-6a63-6885-2cbff7da580a@redhat.com>
Date: Mon, 7 Sep 2020 13:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3a52e54e-22fe-6eee-439a-dc1db0a1bf63@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xMAuV21ekUqKb38sa4PeEQRGAbCbLhh66"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMAuV21ekUqKb38sa4PeEQRGAbCbLhh66
Content-Type: multipart/mixed; boundary="jUhDgyB1e8dyxnVBUfmv7HWW0EI9cSBLf"

--jUhDgyB1e8dyxnVBUfmv7HWW0EI9cSBLf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.09.20 15:48, Vladimir Sementsov-Ogievskiy wrote:
> 04.09.2020 16:21, Max Reitz wrote:
>> On 28.08.20 18:52, Andrey Shinkevich wrote:
>>> To keep the base node unchanged during the block-stream operation,
>>> freeze it as the other part of the backing chain with the intermediate
>>> nodes related to the job.
>>> This patch revers the change made with the commit c624b015bf as the
>>> correct base file name and its format have to be written down to the
>>> QCOW2 header on the disk when the backing file is being changed after
>>> the stream job completes.
>>> This reversion incurs changes in the tests 030, 245 and discards the
>>> test 258 where concurrent stream/commit jobs are tested. When the link
>>> to a base node is frozen, the concurrent job cannot change the common
>>> backing chain.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++------
>>> =C2=A0 tests/qemu-iotests/030=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +--
>>> =C2=A0 tests/qemu-iotests/245=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +=
-
>>> =C2=A0 tests/qemu-iotests/258=C2=A0=C2=A0=C2=A0=C2=A0 | 161
>>> ---------------------------------------------
>>> =C2=A0 tests/qemu-iotests/258.out |=C2=A0 33 ----------
>>> =C2=A0 5 files changed, 14 insertions(+), 221 deletions(-)
>>> =C2=A0 delete mode 100755 tests/qemu-iotests/258
>>> =C2=A0 delete mode 100644 tests/qemu-iotests/258.out
>>
>> Does this need to be in this series?=C2=A0 (I=E2=80=99m not entirely sur=
e, based on
>> what I can see in patch 7.)
>>
>> When doing this, should we introduce a @bottom-node option alongside, so
>> that we can make all the tests that are deleted here pass still, just
>> with changes?
>>
>=20
> That's a question to discuss, and I asked Andrey to make this patch in th=
is
> simple way to see, how much damage we have with this change.
>=20
> Honestly, I doubt that we need the new option. Previously, we decided tha=
t
> we can make this change without a deprecation. If we still going to do it=
,
> we shouldn't care about these use cases. So, if we freeze base again
> wituhout
> a depreaction and:
>=20
> 1. add bottom-node
>=20
> =C2=A0- we keep the iotests
> =C2=A0- If (unlikely) someone will came and say: hey, you've broken my
> working scenario, we will say "use bottom-node option, sorry"
> =C2=A0- Most likely we'll have unused option and corresponding unused log=
ic,
> making code more complex for nothing (and we'll have to say "sorry" anywa=
y)
>=20
> 2. without option
>=20
> =C2=A0- we loose the iotests. this looks scary, but it is honest: we drop
> use-cases and corresponding iotests
> =C2=A0- If (unlikely) someone will came and say: hey, you've broken my
> working scenario, he will have to wait for next release / package
> version / or update the downstream himself
> =C2=A0- Most likely all will be OK.

Well, yes, we=E2=80=99ll disrupt either way, but it is a difference whether=
 we
can tell people immediately that there=E2=80=99s an alternative now, or whe=
ther
we=E2=80=99ll have to make them wait for the next release.

Basically, the whole argument hinges on the question of whether anyone
uses this right now or not, and we just don=E2=80=99t know.

The question remains whether this patch is necessary for this series.
We also have the option of introducing @bottom-node, leaving @base=E2=80=99=
s
behavior as-is and explaining it as a legacy option from which
@bottom-node is inferred.  Then specifying @base just becomes weird and
problem-prone when the graph is reconfigured while the job is active,
but you can get around that by simply using the non-legacy option.

Max

> Hmm. OK, and the hard-way:
>=20
> 3. Enable all the new logic (filter insertion, freezing base, etc.) only
> when filter-node-name option specified. And immediately deprecate
> not-specifying the option.
> =C2=A0[Note, that in way [3] we don't need bottom-node option]
>=20
>=20
>=20



--jUhDgyB1e8dyxnVBUfmv7HWW0EI9cSBLf--

--xMAuV21ekUqKb38sa4PeEQRGAbCbLhh66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9WHToACgkQ9AfbAGHV
z0Bu4Af/SuSSTeXis+WcKl9o6upI50IjkSbs3hT7DzNmtJUACxZsQ2NUEWjQ+gWB
+t0NX166M3Sb5rAWakVq850sxMAjTtVbeFddNsvQUHj4yh84CxeF0k0pXw5uVtI/
Acv2URA2HzQAxinmMLnJZD1XM23aM2ONGPyF2m0LYjydAHP5iDz7JgS6EKq+lwL3
tQZ1NISgld+dH+WatDDyzVsxmIG2Kt/DoEDc4mLcJhb/tVqGwf2JKxvASAGg6B4N
hGoq35MfLAEKa+dcojsRQBWUH9B7usZ9dUxx+MATCMXDE2vc4KCPg59PbQF3Wmwt
VT+29osg9q4dF31h7RNeq0yYAZl81A==
=WLVy
-----END PGP SIGNATURE-----

--xMAuV21ekUqKb38sa4PeEQRGAbCbLhh66--


