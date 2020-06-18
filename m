Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CC2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E37F20656
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOHXCP/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E37F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwCF-0004kX-3B
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlwB2-0003Uo-J5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:10:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52010
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlwB0-0001Qi-9R
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592493001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HLTUtn+GjA1cxMH9YFaPp8odCwUUfP1SXkXmT2PkozU=;
 b=UOHXCP/kodn5hjGFIycRDmbCpyokh2SHBcOji41ANsC0WI3dLww3iuVCNlYsTvCe+BrMHn
 eqxhFHcXSZTQvImhyq4HgrHQhofmxmGK9rohX6BY2I0QmfHSBXcOT2dtWcT+k2tTD18Ynk
 q/lb6A1cL8YaqcP9hQeeAZnQaYbcT2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-ZXr3uaAmMi-h2VcBHEwI0Q-1; Thu, 18 Jun 2020 11:09:45 -0400
X-MC-Unique: ZXr3uaAmMi-h2VcBHEwI0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3FAB835B44;
 Thu, 18 Jun 2020 15:09:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-185.ams2.redhat.com
 [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D6E25BAC2;
 Thu, 18 Jun 2020 15:09:41 +0000 (UTC)
Subject: Re: [PULL 14/15] qcow2_format.py: dump bitmaps header extension
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200609205245.3548257-1-eblake@redhat.com>
 <20200609205245.3548257-15-eblake@redhat.com>
 <81ba0181-3dfc-1c1e-7c19-278569e65c60@redhat.com>
 <64c3084a-8bda-14d9-907c-da0af67cf9c3@virtuozzo.com>
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
Message-ID: <d29f030e-ce33-d5c1-7f65-3a08c6f6cf9a@redhat.com>
Date: Thu, 18 Jun 2020 17:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <64c3084a-8bda-14d9-907c-da0af67cf9c3@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PpfuW3SfiMzJKtp6WPuOhJFONBNYaz8l5"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PpfuW3SfiMzJKtp6WPuOhJFONBNYaz8l5
Content-Type: multipart/mixed; boundary="tpndFCRtUloVPW0ZKbaWvxlhOf1xFKBRV"

--tpndFCRtUloVPW0ZKbaWvxlhOf1xFKBRV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.06.20 15:28, Vladimir Sementsov-Ogievskiy wrote:
> 18.06.2020 16:13, Max Reitz wrote:
>> On 09.06.20 22:52, Eric Blake wrote:
>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>
>>> Add class for bitmap extension and dump its fields. Further work is to
>>> dump bitmap directory.
>>>
>>> Test new functionality inside 291 iotest.
>>
>> Unfortunately, it also breaks 291 with an external data file, which
>> worked before.=C2=A0 (The problems being that an external data file give=
s you
>> an additional header extension, and that the bitmap directory offset
>> changes.)
>>
>> I think if we want to test testing tools, we have to do that in a
>> controlled environment where we exactly know what the image is.=C2=A0 It
>> looks to me now as if 291 is not such an environment.=C2=A0 Or phrased
>> differently, we probably shouldn=E2=80=99t test some testing tool in nor=
mal
>> tests that test qemu itself.
>>
>> If we only test qcow2.py in normal tests, then I don=E2=80=99t think we =
have to
>> explicitly test it at all.=C2=A0 (Because if you test qcow2.py in a norm=
al
>> test, and the test breaks, it=E2=80=99s unclear what=E2=80=99s broken.=
=C2=A0 So I think you
>> might as well forego the qcow2.py test altogether, because if it breaks,
>> that=E2=80=99ll probably show up in some other test case that uses it.)
>>
>> In this case here, I can see three things we could do:
>>
>> First, could just filter out the data file header extension and the
>> bitmap_directory_offset.=C2=A0 But I=E2=80=99m not sure whether that=E2=
=80=99s the best thing
>> to do, because it might break with some other obscure IMGOPTS that I
>> personally never use for the iotests.
>>
>> I think that if we want a real qcow2.py test somewhere, it should be its
>> own test.=C2=A0 No custom IMGOPTS allowed.=C2=A0 So the second idea woul=
d be to
>> move it there, and drop the qcow2.py usage from here.
>>
>> Or, third, maybe we actually don=E2=80=99t care that much about a real q=
cow2.py
>> test, and really want to just *use* (as opposed to =E2=80=9Ctest=E2=80=
=9D) qcow2.py
>> here.=C2=A0 Then we should filter what we really need from its output in=
stead
>> of dropping what we don=E2=80=99t need.
>>
>>
>> (We could also disable 291 for external data files, but I don=E2=80=99t =
really
>> see why, if the only justification for this addition to it is to test
>> qcow2.py =E2=80=93 which 291 isn=E2=80=99t for.)
>>
> I see your point, agree that the most correct thing is to drop qcow2.py
> testing from 291, reverting test chunks from this commit. I can send a
> patch.

OK, thanks!

> I do think, that we'll need some testing for qcow2.py, as we are going
> to improve it a lot, to be used as separate debugging tool. And we just
> need a separate iotest for it.

Great.

Max


--tpndFCRtUloVPW0ZKbaWvxlhOf1xFKBRV--

--PpfuW3SfiMzJKtp6WPuOhJFONBNYaz8l5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7rg7MACgkQ9AfbAGHV
z0BNgwf9Ef3gsHW9SvxsOXqhnfz5uFncabNJ5OzSfhKrllPF5RV6B9472zWF6f9u
ZyJQot2DQC1DE/M4SVm/v7g1hl7FoGKR+Vdd7EhuRbPbnal/vCP7aV733aDFxJFq
ohcCmIBSma1/1rd0HFaUoNS4IkyKcGBc3nTvBfWGgRX0fo5Ku+3iPq1lo0mfIEip
kFiJamT8oLV7XJ/lVX+2J6HQlAnN3BxA+qcMhsoW7R8rZ86O+7vQUicWCuYQOrCU
wnvuVbVdS6cH8PXWTjiDEVIhxojpgbpvYWR+u9ZA4YyEHH6KTf9Kgi/zUtzoC86b
y4VgX1LjtvlivXM6u1Vt4FiobzQDVA==
=bXvk
-----END PGP SIGNATURE-----

--PpfuW3SfiMzJKtp6WPuOhJFONBNYaz8l5--


