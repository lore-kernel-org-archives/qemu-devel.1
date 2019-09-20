Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA50C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A384E2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 13:32:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A384E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBJ17-0000l0-CN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 09:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54759)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBIz7-0007l0-E0
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBIz6-000210-4E
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 09:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBIz1-0001wW-F7; Fri, 20 Sep 2019 09:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 968911DB0;
 Fri, 20 Sep 2019 13:29:58 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D2415D9CD;
 Fri, 20 Sep 2019 13:29:57 +0000 (UTC)
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
 <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
 <0baa8d6e-cb3b-9e20-be0e-324a3e270b87@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <a4407b8e-3766-5694-0bbd-71764e6ccca1@redhat.com>
Date: Fri, 20 Sep 2019 15:29:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0baa8d6e-cb3b-9e20-be0e-324a3e270b87@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6ra89j6dIYG7SFEfYSffrUJyYPwfaOnCk"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 20 Sep 2019 13:29:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ra89j6dIYG7SFEfYSffrUJyYPwfaOnCk
Content-Type: multipart/mixed; boundary="d67sKoZNE3T8OsngVggEZT7a9Yu4fsWpm";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <a4407b8e-3766-5694-0bbd-71764e6ccca1@redhat.com>
Subject: Re: [PATCH v5 0/5] qcow2: async handling of fragmented io
References: <20190916175324.18478-1-vsementsov@virtuozzo.com>
 <d4d62196-84c2-0a90-312d-391493eae158@redhat.com>
 <93e72727-c46c-d30a-1f38-634237186126@virtuozzo.com>
 <d392d630-23e5-cc21-c8f5-8c2ec3d4f70b@redhat.com>
 <ea14f4bc-9a0c-0147-e963-9019fc9f4f2b@virtuozzo.com>
 <9b56ef11-8c1e-fa48-d838-4fe3ee043474@redhat.com>
 <0baa8d6e-cb3b-9e20-be0e-324a3e270b87@virtuozzo.com>
In-Reply-To: <0baa8d6e-cb3b-9e20-be0e-324a3e270b87@virtuozzo.com>

--d67sKoZNE3T8OsngVggEZT7a9Yu4fsWpm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.09.19 15:26, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 16:10, Max Reitz wrote:
>> On 20.09.19 14:53, Vladimir Sementsov-Ogievskiy wrote:
>>> 20.09.2019 15:40, Max Reitz wrote:
>>>> On 20.09.19 13:53, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 20.09.2019 14:10, Max Reitz wrote:
>>>>>> On 16.09.19 19:53, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> Hi all!
>>>>>>>
>>>>>>> Here is an asynchronous scheme for handling fragmented qcow2
>>>>>>> reads and writes. Both qcow2 read and write functions loops throu=
gh
>>>>>>> sequential portions of data. The series aim it to parallelize the=
se
>>>>>>> loops iterations.
>>>>>>> It improves performance for fragmented qcow2 images, I've tested =
it
>>>>>>> as described below.
>>>>>>
>>>>>> Thanks again, applied to my block branch:
>>>>>>
>>>>>> https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>>>>>
>>>>> Thanks a lot!
>>>>>
>>>>>>
>>>>>>> v5: fix 026 and rebase on Max's block branch [perf results not up=
dated]:
>>>>>>>
>>>>>>> 01: new, prepare 026 to not fail
>>>>>>> 03: - drop read_encrypted blkdbg event [Kevin]
>>>>>>>        - assert((x & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0) -> assert(=
QEMU_IS_ALIGNED(x, BDRV_SECTOR_SIZE)) [rebase]
>>>>>>>        - full host offset in argument of qcow2_co_decrypt [rebase=
]
>>>>>>> 04: - substitute remaining qcow2_co_do_pwritev by qcow2_co_pwrite=
v_task in comment [Max]
>>>>>>>        - full host offset in argument of qcow2_co_encrypt [rebase=
]
>>>>>>> 05: - Now patch don't affect 026 iotest, so its output is not cha=
nged
>>>>>>>
>>>>>>> Rebase changes seems trivial, so, I've kept r-b marks.
>>>>>>
>>>>>> (For the record, I didn=E2=80=99t consider them trivial, or I=E2=80=
=99d=E2=80=99ve applied
>>>>>> Maxim=E2=80=99s series on top of yours.  I consider a conflict to =
be trivially
>>>>>> resolvable only if there is only one way of doing it; but when I
>>>>>> resolved the conflicts myself, I resolved the one in patch 3 diffe=
rently
>>>>>> from you =E2=80=93 I added an offset_in_cluster variable to
>>>>>> qcow2_co_preadv_encrypted().  Sure, it=E2=80=99s still simple and =
the difference
>>>>>> is minor, but that was exactly where I thought that I can=E2=80=99=
t consider
>>>>>> this trivial.)
>>>>>>
>>>>>
>>>>> Hmm. May be it's trivial enough to keep r-b (as my change is trivia=
l itself), but not
>>>>> trivial enough to change alien patch on queuing? If you disagree, I=
'll be more
>>>>> careful on keeping r-b in changed patches, sorry.
>>>>
>>>> It doesn=E2=80=99t matter much to me, I diff all patches anyway. :-)=

>>>>
>>>
>>> then a bit offtopic:
>>>
>>> Which tools are you use?
>>>
>>> I've some scripts to compare different versions of one serie (or to c=
heck, what
>>> was changed in patches during some porting process..).. The core thin=
g is to filter
>>> some not interesting numbers and hashes, which makes diffs dirty, and=
 then call vimdiff.
>>> But maybe I've reinvented the wheel.
>>
>> Just kompare as a graphical diff tool; I just scroll past the hash dif=
fs.
>>
>> But now that you gave me the idea, maybe I should write a script to
>> filter them...  (So, no, I don=E2=80=99t know of a tool that would do =
that
>> already :-/)
>>
>=20
>=20
> Then you may find my scripts somehow useful, at least as a hint (I'm af=
raid code is not beautiful at all)

Thanks! :-)

Max


--d67sKoZNE3T8OsngVggEZT7a9Yu4fsWpm--

--6ra89j6dIYG7SFEfYSffrUJyYPwfaOnCk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2E1FMACgkQ9AfbAGHV
z0CVzAgAmXysw/ZmqW+N6oGPxe4MFJUcWI4MIOvK7y9FmAeDZD6vyVdJoLaqgmNv
D20i8v8ovjYvgSZbommG0kurk9QSSg26nkOZYNO5o74HeBjvC4tqXOqRiGGuwqpD
SR1yBAqaxzZxkrl+GMsOozdi9PZ3/G2rM5vc5W4RLtSy+wYt/iqZH1zsB4NyMbuM
Nav6W4/gSiEtkd/2f7XwyYZnny7Tu9MHl6oZt8Mp35aquEeiU35yqQstKddmRbrJ
Xk6g2oEm3MJr4SZ+yijIM5thHJAncUzcbeR/7VhKUZYX1F7eQ8jysEBaGGcMHWP0
CPK10b1rqyQ32UK0h7yQ1lD15/IK3A==
=N2Rw
-----END PGP SIGNATURE-----

--6ra89j6dIYG7SFEfYSffrUJyYPwfaOnCk--

