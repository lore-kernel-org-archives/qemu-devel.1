Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC672065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DejCV8nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC672065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NWI-0005V0-Et
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0NVE-0004gZ-Et
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:10:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30391
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0NVC-0007KY-6Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595934632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V8a1qqetWZlXGkm6cQk/ftSmY+PslSjpEZVTFf8OUM0=;
 b=DejCV8ntcHfV2C+s9ho6fN9NkoZHO0k2QLS5pKMBM/QoXYOkYSMkxlUvzhiyk6/n1fzGvu
 cFDf6NJNCUUvGsW3SfrwMBuSqcI/tDDCDy+mpGi1/rcNFPa6K16q6Tb5qHNoVgBoqOo+tm
 ypUOaQaEpTOyvz3PkCy/by5mAI4QO8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-HrJvuAdUNzyqMd1zLHJOhA-1; Tue, 28 Jul 2020 07:10:28 -0400
X-MC-Unique: HrJvuAdUNzyqMd1zLHJOhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29F70107ACCA;
 Tue, 28 Jul 2020 11:10:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-145.ams2.redhat.com
 [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CB1810013C4;
 Tue, 28 Jul 2020 11:10:18 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
To: Bruce Rogers <brogers@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
 <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
 <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
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
Message-ID: <72ff33d4-653f-5702-fc04-9090653ab782@redhat.com>
Date: Tue, 28 Jul 2020 13:10:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f455e82e0a4f3662918dcdc85d1cfc5a3187896.camel@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xIYrrYz77WyCPU0YD4C3cvbO9SizI2ll4"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:05:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 vsementsov@virtuozzo.com, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xIYrrYz77WyCPU0YD4C3cvbO9SizI2ll4
Content-Type: multipart/mixed; boundary="2mmdwZpVxvW7Oe8wJI1kuCGCcPrkQy9Ys"

--2mmdwZpVxvW7Oe8wJI1kuCGCcPrkQy9Ys
Content-Type: multipart/mixed;
 boundary="------------48A211AB4AF50949C0057025"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------48A211AB4AF50949C0057025
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.07.20 01:09, Bruce Rogers wrote:
> On Tue, 2020-07-21 at 10:22 +0200, Claudio Fontana wrote:
>> On 7/20/20 8:24 PM, Claudio Fontana wrote:
>>> I have now been able to reproduce this on X86 as well.
>>>
>>> It happens much more rarely, about once every 10 times.
>>>
>>> I will sort out the data and try to make it even more reproducible,
>>> then post my findings in detail.
>>>
>>> Overall I proceeded as follows:
>>>
>>> 1) hooked the savevm code to skip all fields with the exception of
>>> "s390-skeys". So only s390-skeys are actually saved.
>>>
>>> 2) reimplemented "s390-skeys" in a common implementation in cpus.c,
>>> used on both x86 and s390, modeling the behaviour of save/load from
>>> hw/s390
>>>
>>> 3) ran ./check -qcow2 267 on both x86 and s390.
>>>
>>> In the case of s390, failure seems to be reproducible 100% of the
>>> times.
>>> On X86, it is as mentioned failing about 10% of the times.
>>>
>>> Ciao,
>>>
>>> Claudio
>>
>> And here is a small series of two patches that can be used to
>> reproduce the problem.
>>
>> Clearly, this is not directly related to s390 or to skeys or to
>> icount in particular, it is just an issue that happened to be more
>> visible there.
>>
>> If you could help with this, please apply the attached patches.
>>
>> Patch 1 just adds a new "300" iotest. It is way easier to extract the
>> relevant part out of test 267, which does a bit too much in the same
>> file.
>> Also this allows easier use of valgrind, since it does not "require"
>> anything.
>>
>> Patch 2 hooks the savevm code to skip all fields during the snapshot
>> with the exception of "s390-skeys", a new artificial field
>> implemented to
>> model what the real s390-skeys is doing.
>>
>> After applying patch 1 and patch 2, you can test (also on X86), with:
>>
>> ./check -qcow2 300
>>
>> On X86 many runs will be successful, but a certain % of them will
>> instead fail like this:
>>
>>
>> claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests>=20
>> ./check -qcow2 300
>> QEMU          -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64"
>> -nodefaults -display none -accel qtest
>> QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-img"=20
>> QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio
>> threads -f qcow2
>> QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/../../qemu-nbd"=20
>> IMGFMT        -- qcow2 (compat=3D1.1)
>> IMGPROTO      -- file
>> PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
>> TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/scratch
>> SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
>> SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-
>> build/tests/qemu-iotests/socket_scm_helper
>>
>> 300      fail       [10:14:05] [10:14:06]      (last: 0s)    output
>> mismatch (see 300.out.bad)
>> --- /home/claudio/git/qemu-pristine/qemu/tests/qemu-
>> iotests/300.out     2020-07-21 10:03:54.468104764 +0200
>> +++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-
>> iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
>> @@ -12,6 +12,9 @@
>>  ID        TAG                 VM SIZE                DATE       VM
>> CLOCK
>>  --        snap0                  SIZE yyyy-mm-dd
>> hh:mm:ss   00:00:00.000
>>  (qemu) loadvm snap0
>> +Unexpected storage key data: 0
>> +error while loading state for instance 0x0 of device 's390-skeys'
>> +Error: Error -22 while loading VM state
>>  (qemu) quit
>> =20
>>  *** done
>> Failures: 300
>> Failed 1 of 1 iotests
>>
>>
>> At this point somebody more knowledgeable about QCOW2, coroutines and
>> backing files could chime in?
>>
> <trim>
>=20
> I used the reproducer you provide here to do a git bisect as I assume
> whatever is now broken wasn't always broken, and it pointed to the
> following commit:
>=20
> commit df893d25ceea3c0dcbe6d6b425309317fab6b22e (refs/bisect/bad)
> Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Date:   Tue Jun 4 19:15:13 2019 +0300
>=20
>     block/qcow2: implement .bdrv_co_preadv_part
>=20
> Indeed, I am currently able to reliable reproduce the issue with this
> commit applied, and not reproduce it without it.
>=20
> That said, I've not been able to identify exactly what is going wrong.
> I'm fairly confident the savevm data is correctly written out, but on
> the loadvm side, somehow the last part of the s390 data is not
> correctly read in the data (it's in the second pass through the while
> loop in qcow2_co_preadv_part() where that happens.)
>=20
> If anyone familiar with this code can have a look or provide some
> pointers, it would be much appreciated.

Thanks for both your investigation.  Does the attached patch help?

Max

--------------48A211AB4AF50949C0057025
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-block-Fix-bdrv_aligned_preadv-with-qiov_offset.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-block-Fix-bdrv_aligned_preadv-with-qiov_offset.patch"

From 3df2df667d561dfe423e4ee5784e83943205974a Mon Sep 17 00:00:00 2001
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 28 Jul 2020 13:02:31 +0200
Subject: [PATCH] block: Fix bdrv_aligned_preadv() with qiov_offset

---
 block/io.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index b6564e34c5..bd45d739c7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1524,12 +1524,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChi=
ld *child,
             assert(num);
=20
             ret =3D bdrv_driver_preadv(bs, offset + bytes - bytes_remainin=
g,
-                                     num, qiov, bytes - bytes_remaining, 0=
);
+                                     num, qiov,
+                                     qiov_offset + bytes - bytes_remaining=
, 0);
             max_bytes -=3D num;
         } else {
             num =3D bytes_remaining;
-            ret =3D qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
-                                    bytes_remaining);
+            ret =3D qemu_iovec_memset(qiov, qiov_offset + bytes - bytes_re=
maining,
+                                    0, bytes_remaining);
         }
         if (ret < 0) {
             goto out;
--=20
2.26.2


--------------48A211AB4AF50949C0057025--

--2mmdwZpVxvW7Oe8wJI1kuCGCcPrkQy9Ys--

--xIYrrYz77WyCPU0YD4C3cvbO9SizI2ll4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8gB5gACgkQ9AfbAGHV
z0D+HAf/X5M9d6h4r2FRcuRx6fe0odh7U8+7U7ZHnDHVGqOkJYtBhDHGxmzZ8zVl
FkDh/a3jJKJxnD1PC6lerTqZ4RSTQCon9+LmHbu0HtqOZh7yLNAfTBqMxj/rpyp/
FwRm5QNBxnkxpeC75lZTLISpiI+Kn2L3S/vB/c0cvEi+unr/ibevysAquF2PHfPy
3Ym8YjQzPQfDQshd0wFrdQM9bMGvBCC3lgDK00Rc3rDtySEzzNChx3y3n1xXKrRY
U7VjI53BvBHhoD+EviAFHM2CEf3RklTvNF2RiuM9X8QbRBSnNM7NMdSbFkJ9goVo
LPtezohnnQ/4/QxuTyqxzOlOqrAhzA==
=ubV7
-----END PGP SIGNATURE-----

--xIYrrYz77WyCPU0YD4C3cvbO9SizI2ll4--


