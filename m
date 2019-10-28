Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E0ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:27:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C67DA214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dud3yMk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67DA214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3BQ-0007wJ-RT
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP353-0007Vt-SW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP2q2-0007hU-EV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:05:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22364
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP2q2-0007hI-9V
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572260729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VVID0cJaQ5OgycO7g0CujkwXEmISNzWR4qOfjbGZLTA=;
 b=Dud3yMk5iKIoNha8oJ4Z2awZ173EzUmZ9upHp7bKWpeDFdtA6D1Fi5q8u29ccOR94U0u/Y
 ziI1eur5rknxoeqIwOsB5LT+edQR+DONmDanOhC9btHE4cnJmEcTa10HnKwQUI3DJAzAPJ
 YsyW9siTeX5y0DwuJ1q8upN55r/VI+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-YPydsI13NhmF8GO82X8J4g-1; Mon, 28 Oct 2019 07:05:21 -0400
X-MC-Unique: YPydsI13NhmF8GO82X8J4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7CA91005529;
 Mon, 28 Oct 2019 11:05:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44160261A7;
 Mon, 28 Oct 2019 11:05:16 +0000 (UTC)
Subject: Re: [PATCH 4/8] block: Add @exact parameter to bdrv_co_truncate()
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190918095144.955-1-mreitz@redhat.com>
 <20190918095144.955-5-mreitz@redhat.com>
 <24b871b4722d4ccecfc3ce1293adc937fede38f1.camel@redhat.com>
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
Message-ID: <66ef3a2c-4014-fe15-eca0-594fcc6186b8@redhat.com>
Date: Mon, 28 Oct 2019 12:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <24b871b4722d4ccecfc3ce1293adc937fede38f1.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sZHiQ69ieX6g662gCcjTT4rZCNgjbgVuX"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sZHiQ69ieX6g662gCcjTT4rZCNgjbgVuX
Content-Type: multipart/mixed; boundary="lmXp7piqCgUhNKXnxWWeYiPRV2kIK1JdQ"

--lmXp7piqCgUhNKXnxWWeYiPRV2kIK1JdQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 22:50, Maxim Levitsky wrote:
> On Wed, 2019-09-18 at 11:51 +0200, Max Reitz wrote:
>> We have two drivers (iscsi and file-posix) that (in some cases) return
>> success from their .bdrv_co_truncate() implementation if the block
>> device is larger than the requested offset, but cannot be shrunk.  Some
>> callers do not want that behavior, so this patch adds a new parameter
>> that they can use to turn off that behavior.
>>
>> This patch just adds the parameter and lets the block/io.c and
>> block/block-backend.c functions pass it around.  All other callers
>> always pass false and none of the implementations evaluate it, so that
>> this patch does not change existing behavior.  Future patches take care
>> of that.
>>
>> Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block.h          |  6 +++---
>>  include/block/block_int.h      | 17 ++++++++++++++++-
>>  include/sysemu/block-backend.h |  4 ++--
>>  block/block-backend.c          |  6 +++---
>>  block/commit.c                 |  5 +++--
>>  block/crypto.c                 |  8 ++++----
>>  block/file-posix.c             |  3 ++-
>>  block/file-win32.c             |  3 ++-
>>  block/gluster.c                |  1 +
>>  block/io.c                     | 20 +++++++++++++-------
>>  block/iscsi.c                  |  3 ++-
>>  block/mirror.c                 |  4 ++--
>>  block/nfs.c                    |  2 +-
>>  block/parallels.c              |  6 +++---
>>  block/qcow.c                   |  4 ++--
>>  block/qcow2-refcount.c         |  2 +-
>>  block/qcow2.c                  | 22 ++++++++++++----------
>>  block/qed.c                    |  3 ++-
>>  block/raw-format.c             |  5 +++--
>>  block/rbd.c                    |  1 +
>>  block/sheepdog.c               |  5 +++--
>>  block/ssh.c                    |  3 ++-
>>  block/vdi.c                    |  2 +-
>>  block/vhdx-log.c               |  4 ++--
>>  block/vhdx.c                   |  7 ++++---
>>  block/vmdk.c                   |  8 ++++----
>>  block/vpc.c                    |  2 +-
>>  blockdev.c                     |  2 +-
>>  qemu-img.c                     |  2 +-
>>  qemu-io-cmds.c                 |  2 +-
>>  tests/test-block-iothread.c    |  8 ++++----
>>  31 files changed, 102 insertions(+), 68 deletions(-)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 37c9de7446..2f905ae4b7 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -346,10 +346,10 @@ BlockDriverState *bdrv_find_backing_image(BlockDri=
verState *bs,
>>      const char *backing_file);
>>  void bdrv_refresh_filename(BlockDriverState *bs);
>> =20
>> -int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset,
>> +int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, boo=
l exact,
>>                                    PreallocMode prealloc, Error **errp);
>> -int bdrv_truncate(BdrvChild *child, int64_t offset, PreallocMode preall=
oc,
>> -                  Error **errp);
>> +int bdrv_truncate(BdrvChild *child, int64_t offset, bool exact,
>> +                  PreallocMode prealloc, Error **errp);
>> =20
>>  int64_t bdrv_nb_sectors(BlockDriverState *bs);
>>  int64_t bdrv_getlength(BlockDriverState *bs);
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 0422acdf1c..197cc6e7c3 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -334,8 +334,23 @@ struct BlockDriver {
>>       * bdrv_parse_filename.
>>       */
>>      const char *protocol_name;
>> +
>> +    /*
>> +     * Truncate @bs to @offset bytes using the given @prealloc mode
>> +     * when growing.  Modes other than PREALLOC_MODE_OFF should be
>> +     * rejected when shrinking @bs.
>> +     *
>> +     * If @exact is true, @bs must be resized to exactly @offset.
>> +     * Otherwise, it is sufficient for @bs (if it is a host block
>> +     * device and thus there is no way to resize it) to be at least
>> +     * @offset bytes in length.
>> +     *
>> +     * If @exact is true and this function fails but would succeed
>> +     * with @exact =3D false, it should return -ENOTSUP.
>> +     */
> Thanks for adding a documentation here!
> One minor nitpick:
> I would write
>=20
> Otherwise, it is sufficient for @bs (for example if it is a host block
> device and thus there is no way to resize it) to be at least @offset byte=
s in length.

Hm, so just add the =E2=80=9Cfor example=E2=80=9D?  I=E2=80=99d rather not =
add it.  This would
then read as if it were OK for files that aren=E2=80=99t block devices to a=
lso
return success when they cannot be shrunk just because we don=E2=80=99t sup=
port
it.  But it isn=E2=80=99t.  If the protocol theoretically allows it and it =
makes
sense, drivers shouldn=E2=80=99t return success with exact=3Dfalse simply b=
ecause
we haven=E2=80=99t implemented it.

For example, you can shrink files over ssh, I=E2=80=99m sure.  But our driv=
er
doesn=E2=80=99t allow it.  It should thus return ENOTSUP even with exact=3D=
false.

The =E2=80=9CReturn success for shrinking even when the file cannot be shru=
nk=E2=80=9D
really is only for block devices, because then the user will have no
expectation that the shrinking will actually work.  (For ssh, they will
expect it to work, so we must not pretend it succeeded when it didn=E2=80=
=99t.)

Max


--lmXp7piqCgUhNKXnxWWeYiPRV2kIK1JdQ--

--sZHiQ69ieX6g662gCcjTT4rZCNgjbgVuX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22y2oACgkQ9AfbAGHV
z0CuhQf+NGC8GSZkHKeIBRJUkgPQzq5Kq5xj3fwU0p3MszFAqh8Z1utMZwfoSWwj
k/P9vKgI30UUq0hM5ILY4DwYYbK5RccOXxMooLaIhOuky9GdtW9pnT33mubIcVWl
d6dta4fbri7aJqGE5RWBqRPujc5eXTryrozJXs3pPrEuDHewSG1AZv+E1CdctnvH
r5Y3LdUscD3p2QYlRhf5JbAm3iMu5T0y0ao+YE91sh3pfsjv3w4jmdjq6hyqhNx8
acYX4a/y17YF4zmdqnNBL4Atk37cXvX4UYBMklDayB8dZ/t2oHGAxeww0xOCvuD1
NXEAk2/v+z0T/wKM8wcOZhA0u1qoJA==
=seST
-----END PGP SIGNATURE-----

--sZHiQ69ieX6g662gCcjTT4rZCNgjbgVuX--


