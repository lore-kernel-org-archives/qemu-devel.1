Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DD8CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F3921734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 13:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htt+zL9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F3921734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQXC5-0000OG-3L
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 09:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQXAZ-0007fa-18
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQXAX-0004ub-2X
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:40:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQXAT-0004n9-CK
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 09:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572615644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zdmdLQBi/SxoM+JGhIGF5OcBsyGwHoiY5S6jd58iH3Q=;
 b=htt+zL9uq4RZRdGSlN2vW92TWn5ewhwxb88hShuYyUwRhMfY0d3GliBzuTbME21j4MHm4m
 49ZGDPomRSD+XQB1AJSX1aH62FCcXKEABg+cspRTMEO65bB4fPJ+NWeXSuxOGzFUOG/oya
 q3I/A0lUlNvF4y9b8s/7IzumyOr+5SY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-d6eusVWMONaNKo7pQNx94g-1; Fri, 01 Nov 2019 09:40:37 -0400
X-MC-Unique: d6eusVWMONaNKo7pQNx94g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B1A92AD;
 Fri,  1 Nov 2019 13:40:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D79921001281;
 Fri,  1 Nov 2019 13:40:29 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
To: Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
 <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
 <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
 <e80f5808-a450-3019-1b1f-b718c9bae6f5@virtuozzo.com>
 <120056dc-0c4c-e477-4d5b-2cc2ef5f32fb@virtuozzo.com>
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
Message-ID: <4e7bb2f7-712b-eb44-a48f-6a1f7fb1858a@redhat.com>
Date: Fri, 1 Nov 2019 14:40:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <120056dc-0c4c-e477-4d5b-2cc2ef5f32fb@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YFgsMCoSuWmGgpLLQjJfVuM7a4qpwEvuP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YFgsMCoSuWmGgpLLQjJfVuM7a4qpwEvuP
Content-Type: multipart/mixed; boundary="ck4fDOSER6dbVanUi0mIADwSWtybDNJQa"

--ck4fDOSER6dbVanUi0mIADwSWtybDNJQa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 14:36, Denis Lunev wrote:
> On 11/1/19 4:09 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 01.11.2019 15:34, Max Reitz wrote:
>>> On 01.11.19 12:20, Max Reitz wrote:
>>>> On 01.11.19 12:16, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 01.11.2019 14:12, Max Reitz wrote:
>>>>>> On 01.11.19 11:28, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 01.11.2019 13:20, Max Reitz wrote:
>>>>>>>> On 01.11.19 11:00, Max Reitz wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> This series builds on the previous RFC.  The workaround is now ap=
plied
>>>>>>>>> unconditionally of AIO mode and filesystem because we don=E2=80=
=99t know those
>>>>>>>>> things for remote filesystems.  Furthermore, bdrv_co_get_self_req=
uest()
>>>>>>>>> has been moved to block/io.c.
>>>>>>>>>
>>>>>>>>> Applying the workaround unconditionally is fine from a performanc=
e
>>>>>>>>> standpoint, because it should actually be dead code, thanks to pa=
tch 1
>>>>>>>>> (the elephant in the room).  As far as I know, there is no other =
block
>>>>>>>>> driver but qcow2 in handle_alloc_space() that would submit zero w=
rites
>>>>>>>>> as part of normal I/O so it can occur concurrently to other write
>>>>>>>>> requests.  It still makes sense to take the workaround for file-p=
osix
>>>>>>>>> because we can=E2=80=99t really prevent that any other block driv=
er will submit
>>>>>>>>> zero writes as part of normal I/O in the future.
>>>>>>>>>
>>>>>>>>> Anyway, let=E2=80=99s get to the elephant.
>>>>>>>>>
>>>>>>>>>    From input by XFS developers
>>>>>>>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) it see=
ms clear
>>>>>>>>> that c8bb23cbdbe causes fundamental performance problems on XFS w=
ith
>>>>>>>>> aio=3Dnative that cannot be fixed.  In other cases, c8bb23cbdbe i=
mproves
>>>>>>>>> performance or we wouldn=E2=80=99t have it.
>>>>>>>>>
>>>>>>>>> In general, avoiding performance regressions is more important th=
an
>>>>>>>>> improving performance, unless the regressions are just a minor co=
rner
>>>>>>>>> case or insignificant when compared to the improvement.  The XFS
>>>>>>>>> regression is no minor corner case, and it isn=E2=80=99t insignif=
icant.  Laurent
>>>>>>>>> Vivier has found performance to decrease by as much as 88 % (on p=
pc64le,
>>>>>>>>> fio in a guest with 4k blocks, iodepth=3D8: 1662 kB/s from 13.9 M=
B/s).
>>>>>>>> Ah, crap.
>>>>>>>>
>>>>>>>> I wanted to send this series as early today as possible to get as =
much
>>>>>>>> feedback as possible, so I=E2=80=99ve only started doing benchmark=
s now.
>>>>>>>>
>>>>>>>> The obvious
>>>>>>>>
>>>>>>>> $ qemu-img bench -t none -n -w -S 65536 test.qcow2
>>>>>>>>
>>>>>>>> on XFS takes like 6 seconds on master, and like 50 to 80 seconds w=
ith
>>>>>>>> c8bb23cbdbe reverted.  So now on to guest tests...
>>>>>>> Aha, that's very interesting) What about aio-native which should be=
 slowed down?
>>>>>>> Could it be tested like this?
>>>>>> That is aio=3Dnative (-n).
>>>>>>
>>>>>> But so far I don=E2=80=99t see any significant difference in guest t=
ests (i.e.,
>>>>>> fio --rw=3Dwrite --bs=3D4k --iodepth=3D8 --runtime=3D1m --direct=3D1
>>>>>> --ioengine=3Dlibaio --thread --numjobs=3D16 --size=3D2G --time_based=
), neither
>>>>>> with 64 kB nor with 2 MB clusters.  (But only on XFS, I=E2=80=99ll h=
ave to see
>>>>>> about ext4 still.)
>>>>> hmm, this possibly mostly tests writes to already allocated clusters.=
 Has fio
>>>>> an option to behave like qemu-img bench with -S 65536, i.e. write onc=
e into
>>>>> each cluster?
>>>> Maybe, but is that a realistic depiction of whether this change is wor=
th
>>>> it?  That is why I=E2=80=99m doing the guest test, to see whether it a=
ctually
>>>> has much impact on the guest.
>>> I=E2=80=99ve changed the above fio invocation to use --rw=3Drandwrite a=
nd added
>>> --fallocate=3Dnone.  The performance went down, but it went down both w=
ith
>>> and without c8bb23cbdbe.
>>>
>>> So on my XFS system (XFS on luks on SSD), I see:
>>> - with c8bb23cbdbe: 26.0 - 27.9 MB/s
>>> - without c8bb23cbdbe: 25.6 - 27 MB/s
>>>
>>> On my ext4 system (native on SSD), I see:
>>> - with: 39.4 - 41.5 MB/s
>>> - without: 39.4 - 42.0 MB/s
>>>
>>> So basically no difference for XFS, and really no difference for ext4.
>>> (I ran these tests with 2 MB clusters.)
>>>
>> Hmm. I don't know. For me it seems obvious that zeroing 2M cluster is sl=
ow, and this
>> is proved by simple tests with qemu-img bench, that fallocate is faster =
than zeroing
>> most of the cluster.
>>
>> So, if some guest test doesn't show the difference, this means that "sma=
ll write into
>> new cluster" is effectively rare case in this test.. And this doesn't pr=
ove that it's
>> always rare and insignificant.
>>
>> I don't sure that we have a real-world example that proves necessity of =
this optimization,
>> or was there some original bug about low-performance which was fixed by =
this optimization..
>> Den, Anton, do we have something about it?
>>
> sorry, I have missed the beginning of the thread.
>=20
> Which driver is used for virtual disk - cached or non-cached IO
> is used in QEMU? We use non-cached by default and this could
> make a difference significantly.

I=E2=80=99m using no cache, the above tests were done with aio=3Dnative; I=
=E2=80=99ve sent
another response with aio=3Dthreads numbers.

> Max,
>=20
> can you pls share your domain.xml of the guest config and
> fio file for guest. I will recheck to be 120% sure.

I=E2=80=99m running qemu directly as follows:

x86_64-softmmu/qemu-system-x86_64 \


    -serial stdio \
    -cdrom ~/tmp/arch.iso \
    -m 4096 \
    -enable-kvm \
    -drive \
  if=3Dnone,id=3Dt,format=3Dqcow2,file=3Dtest/test.qcow2,cache=3Dnone,aio=
=3Dnative \
    -device virtio-scsi \
    -device scsi-hd,drive=3Dt \
    -net user \
    -net nic,model=3Drtl8139 \
    -smp 2,maxcpus=3D2,cores=3D1,threads=3D1,sockets=3D2 \
    -cpu SandyBridge \
    -nodefaults \
    -nographic

The full FIO command line is:

fio --rw=3Drandwrite --bs=3D4k --iodepth=3D8 --runtime=3D1m --direct=3D1 \
    --filename=3D/mnt/foo --name=3Djob1 --ioengine=3Dlibaio --thread \
    --group_reporting --numjobs=3D16 --size=3D2G --time_based \
    --output=3D/tmp/fio_result --fallocate=3Dnone

Max


--ck4fDOSER6dbVanUi0mIADwSWtybDNJQa--

--YFgsMCoSuWmGgpLLQjJfVuM7a4qpwEvuP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28NcwACgkQ9AfbAGHV
z0CQ/gf9F2AAeXa5SDKt4ZJ44amWDrRuZ+/r1cnbuLqmpxrTu7JtECtBwZHT5Rpt
1z7HkpgiEwyTwMUS+4itzvX+/SqNMPu1pVTDJ/o7ncLptm8Gowby1kU9b0dcfhog
qoauCJhvG8YR1TApc61/97+gjBbRd/zQcUC1Z3oxBFsgqQ3ps7p1bW9JOKmk/Mb4
wu1ng1ZYxH5UAY9PMITUx0QY0eAL3BFbVNHTCVCeSBWQ85NZEyQVBHnhfsO3Cwxw
eyDjYge/OkVrupQY702Drcx3YiyMehoAmGkTR2oguTWEpVTuxuUG7CjLKUxwxpmR
kvQYHfKQklVkNhno2PhKx2kOU4yzew==
=ffim
-----END PGP SIGNATURE-----

--YFgsMCoSuWmGgpLLQjJfVuM7a4qpwEvuP--


