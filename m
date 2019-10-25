Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918F4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4988320684
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hSfHxaHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4988320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0Yb-0004j4-M7
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43848)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iO0RV-0001N8-5v
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iO0RT-0000YP-0b
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:19:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iO0RS-0000Y7-Rs
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572013190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=87J/SFw4lJbChEnhaD1mC4SMMZqbw/CVp8NTeBRzWAU=;
 b=hSfHxaHMIv7rxkSzGHkHUybfY2+8rfMqckGU2S2Rmjcyj+G76Q4X4zSLc4KsKCfUy22gSr
 G8Xzf8wwy9CO1T8n6h7vEplzK/GX+eu5g5LiEXXOxIiCBhvAWsTtCkgCRRsHa2h7Iy1u+n
 PFu7EKrk1j+lgWmJeEqBei9ua886O5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-p_VqJbS7O3KoVw7Fa7MjuQ-1; Fri, 25 Oct 2019 10:19:41 -0400
X-MC-Unique: p_VqJbS7O3KoVw7Fa7MjuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C5AC801E5C;
 Fri, 25 Oct 2019 14:19:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-230.ams2.redhat.com
 [10.36.117.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79395600D1;
 Fri, 25 Oct 2019 14:19:31 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
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
Message-ID: <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
Date: Fri, 25 Oct 2019 16:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2q1gJIHvtw5O0Kg1FDdfnEgqFoptJUcU6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2q1gJIHvtw5O0Kg1FDdfnEgqFoptJUcU6
Content-Type: multipart/mixed; boundary="RLd2fnA9WSBEjeMuJU2iGPUI0XCxyfSV1"

--RLd2fnA9WSBEjeMuJU2iGPUI0XCxyfSV1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.10.19 15:56, Vladimir Sementsov-Ogievskiy wrote:
> 25.10.2019 16:40, Vladimir Sementsov-Ogievskiy wrote:
>> 25.10.2019 12:58, Max Reitz wrote:
>>> Hi,
>>>
>>> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driver=
, as
>>> I=E2=80=99ve explained here:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
>>>
>>> In combination with our commit c8bb23cbdbe32f, this may lead to guest
>>> data corruption when using qcow2 images on XFS with aio=3Dnative.
>>>
>>> We can=E2=80=99t wait until the XFS kernel driver is fixed, we should w=
ork
>>> around the problem ourselves.
>>>
>>> This is an RFC for two reasons:
>>> (1) I don=E2=80=99t know whether this is the right way to address the i=
ssue,
>>> (2) Ideally, we should detect whether the XFS kernel driver is fixed an=
d
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if so stop applying the workaround.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 I don=E2=80=99t know how we would go about thi=
s, so this series doesn=E2=80=99t do
>>> =C2=A0=C2=A0=C2=A0=C2=A0 it.=C2=A0 (Hence it=E2=80=99s an RFC.)
>>> (3) Perhaps it=E2=80=99s a bit of a layering violation to let the file-=
posix
>>> =C2=A0=C2=A0=C2=A0=C2=A0 driver access and modify a BdrvTrackedRequest =
object.
>>>
>>> As for how we can address the issue, I see three ways:
>>> (1) The one presented in this series: On XFS with aio=3Dnative, we exte=
nd
>>> =C2=A0=C2=A0=C2=A0=C2=A0 tracked requests for post-EOF fallocate() call=
s (i.e., write-zero
>>> =C2=A0=C2=A0=C2=A0=C2=A0 operations) to reach until infinity (INT64_MAX=
 in practice), mark
>>> =C2=A0=C2=A0=C2=A0=C2=A0 them serializing and wait for other conflictin=
g requests.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Limits the impact to very specific cases
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (And that means it wouldn=E2=80=99=
t hurt too much to keep this workaround
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 even when the XFS driver has been =
fixed)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Works around the bug where it happens, namel=
y in file-posix
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - A bit complex
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - A bit of a layering violation (should file-p=
osix have access to
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracked requests?)
>>>
>>> (2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.=C2=A0 The =
XFS bug only
>>> =C2=A0=C2=A0=C2=A0=C2=A0 becomes visible due to that function: I don=E2=
=80=99t think qcow2 writes
>>> =C2=A0=C2=A0=C2=A0=C2=A0 zeroes in any other I/O path, and raw images a=
re fixed in size so
>>> =C2=A0=C2=A0=C2=A0=C2=A0 post-EOF writes won=E2=80=99t happen.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Maybe simpler, depending on how difficult it=
 is to handle the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 layering violation
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Also fixes the performance problem of handle=
_alloc_space() being
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 slow on ppc64+XFS.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Huge layering violation because qcow2 would =
need to know whether
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the image is stored on XFS or not.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - We=E2=80=99d definitely want to skip this wo=
rkaround when the XFS driver
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 has been fixed, so we need some me=
thod to find out whether it has
>>>
>>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>>> =C2=A0=C2=A0=C2=A0=C2=A0 To my knowledge I=E2=80=99m the only one who h=
as provided any benchmarks for
>>> =C2=A0=C2=A0=C2=A0=C2=A0 this commit, and even then I was a bit skeptic=
al because it performs
>>> =C2=A0=C2=A0=C2=A0=C2=A0 well in some cases and bad in others.=C2=A0 I =
concluded that it=E2=80=99s
>>> =C2=A0=C2=A0=C2=A0=C2=A0 probably worth it because the =E2=80=9Csome ca=
ses=E2=80=9D are more likely to occur.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Now we have this problem of corruption here (g=
ranted due to a bug in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 the XFS driver), and another report of massive=
ly degraded
>>> =C2=A0=C2=A0=C2=A0=C2=A0 performance on ppc64
>>> =C2=A0=C2=A0=C2=A0=C2=A0 (https://bugzilla.redhat.com/show_bug.cgi?id=
=3D1745823 =E2=80=93 sorry, a
>>> =C2=A0=C2=A0=C2=A0=C2=A0 private BZ; I hate that :-/=C2=A0 The report i=
s about 40 % worse
>>> =C2=A0=C2=A0=C2=A0=C2=A0 performance for an in-guest fio write benchmar=
k.)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 So I have to ask the question about what the j=
ustification for
>>> =C2=A0=C2=A0=C2=A0=C2=A0 keeping c8bb23cbdbe32f is.=C2=A0 How much does=
 performance increase with
>>> =C2=A0=C2=A0=C2=A0=C2=A0 it actually?=C2=A0 (On non-(ppc64+XFS) machine=
s, obviously)
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Advantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Trivial
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + No layering violations
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + We wouldn=E2=80=99t need to keep track of wh=
ether the kernel bug has been
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fixed or not
>>> =C2=A0=C2=A0=C2=A0=C2=A0 + Fixes the ppc64+XFS performance problem
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Disadvantages:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Reverts cluster allocation performance to pr=
e-c8bb23cbdbe32f
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 levels, whatever that means
>>>
>>> So this is the main reason this is an RFC: What should we do?=C2=A0 Is =
(1)
>>> really the best choice?
>>>
>>>
>>> In any case, I=E2=80=99ve ran the test case I showed in
>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01282.html
>>> more than ten times with this series applied and the installation
>>> succeeded every time.=C2=A0 (Without this series, it fails like every o=
ther
>>> time.)
>>>
>>>
>>
>> Hi!
>>
>> First, great thanks for your investigation!
>>
>> We need c8bb23cbdbe3 patch, because we use 1M clusters, and zeroing 1M i=
s significant
>> in time.
>>
>> I've tested a bit:
>>
>> test:
>> for img in /ssd/test.img /test.img; do for cl in 64K 1M; do for step in =
4K 64K 1M; do ./qemu-img create -f qcow2 -o cluster_size=3D$cl $img 15G > /=
dev/null; printf '%-15s%-7s%-10s : ' $img cl=3D$cl step=3D$step; ./qemu-img=
 bench -c $((15 * 1024)) -n -s 4K -S $step -t none -w $img | tail -1 | awk =
'{print $4}'; done; done; done
>>
>> on master:
>>
>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.291
>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.813
>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.799
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.217
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.332
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.685
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.751
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 =
: 14.811
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 18.321
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=
=A0=C2=A0 : 0.759
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 13.574
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=
=A0=C2=A0 : 28.970
>>
>> rerun on master:
>>
>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.295
>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 0.803
>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 2.921
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.233
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 0.321
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 0.762
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.873
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 =
: 15.621
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 18.428
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=
=A0=C2=A0 : 0.883
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 13.484
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=
=A0=C2=A0 : 26.244
>>
>>
>> on master + revert c8bb23cbdbe32f5c326
>>
>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.395
>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 4.231
>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.598
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.352
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.519
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 38.919
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.758
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 =
: 9.838
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 13.384
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.849
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 19.405
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=
=A0=C2=A0 : 157.090
>>
>> rerun:
>>
>> /ssd/test.img=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=C2=A0 : 0.407
>> /ssd/test.img=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 : 3.325
>> /ssd/test.img=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=C2=A0 : 5.641
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=A0=C2=A0 : 0.346
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=C2=A0 : 2.583
>> /ssd/test.img=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=A0=C2=A0 : 39.692
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D4K=C2=A0=C2=A0=
=C2=A0 : 1.727
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D64K=C2=A0=C2=A0 =
: 10.058
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D64K step=3D1M=C2=A0=C2=A0=
=C2=A0 : 13.441
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D4K=C2=A0=C2=
=A0=C2=A0 : 1.926
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D64K=C2=A0=
=C2=A0 : 19.738
>> /test.img=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cl=3D1M=C2=A0 step=3D1M=C2=A0=C2=
=A0=C2=A0 : 158.268
>>
>>
>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M cluster-=
size, even on rotational
>> disk, which means that previous assumption about calling handle_alloc_sp=
ace() only for ssd is
>> wrong, we need smarter heuristics..
>>
>> So, I'd prefer (1) or (2).

OK.  I wonder whether that problem would go away with Berto=E2=80=99s subcl=
uster
series, though.

> About degradation in some cases: I think the problem is that one (a bit l=
arger)
> write may be faster than fast-write-zeroes + small write, as the latter m=
eans
> additional write to metadata. And it's expected for small clusters in
> conjunction with rotational disk. But the actual limit is dependent on sp=
ecific
> disk. So, I think possible solution is just sometimes try work with
> handle_alloc_space and sometimes without, remember time and length of req=
uest
> and make dynamic limit...

Maybe make a decision based both on the ratio of data size to COW area
length (only invoke handle_alloc_space() under a certain threshold), and
the absolute COW area length (always invoke it above a certain
threshold, unless the ratio doesn=E2=80=99t allow it)?

Max


--RLd2fnA9WSBEjeMuJU2iGPUI0XCxyfSV1--

--2q1gJIHvtw5O0Kg1FDdfnEgqFoptJUcU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2zBHIACgkQ9AfbAGHV
z0B4vggAl9ulEXcqRmvVM0LCH8YOPdg1iDWfgkfCQjXz6jMSWrOWW8Frn1O4GwKA
49p/hEdq31VbOmGiunfkb0mS+y31S6Laik0pIsRDsXedNe5YLBqdQBf5J3J2n8Gr
6ITe7T676XsHPLODezkewDjdA4sB4QhGrXSJBVv/eB/KoBqijeluWXnw4kgfdcEs
KuJKj0D1hM3cHfSqPhtxDu4tSWQAMZFTjyUu0lvzllzf2KVFMmOvQurWf7u5GcJS
2YFAy+vkeqCh3meVEqRd9b0XhR/5DxtcTO1zTN4uqv6YqeF9K0jiKef6YJqSk2Id
png1++d/Y5aCv4X8P2bqCpqwV5Rz2w==
=t3l9
-----END PGP SIGNATURE-----

--2q1gJIHvtw5O0Kg1FDdfnEgqFoptJUcU6--


