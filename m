Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74185C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD8C2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 09:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rt9YsHGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD8C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isNgh-00040W-CO
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 04:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1isNfz-0003VO-Iy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1isNfx-0002rY-8h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:12:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25466
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1isNfw-0002pm-Dv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 04:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579252339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1yHyjzo2+ogqcOE869IrNIezhi+1/I30KF3pbqNsW1o=;
 b=Rt9YsHGeCGiloJCm3eCFSTq15Qxy9ZCgs4ZhOhY+5jdIKS2unbq0lEM3ghdFxHYElDivJL
 Glz97cTDbl/HTR+/QxiaP7F0cmKKnOIVFh+1UM4Wtyhwz/jT+G4RUy4SamqC6uXNP264ZW
 Y5Psj3N6FpNr8TjH8WLyl7BOGiw21Ow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-btC1yEndPGG8dO1xvIQ6Tw-1; Fri, 17 Jan 2020 04:12:16 -0500
X-MC-Unique: btC1yEndPGG8dO1xvIQ6Tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9736101FC91;
 Fri, 17 Jan 2020 09:12:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-75.ams2.redhat.com
 [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AF98845A6;
 Fri, 17 Jan 2020 09:12:12 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] qcow2: Use BDRV_SECTOR_SIZE instead of the
 hardcoded value
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1578596897.git.berto@igalia.com>
 <e3982d5118a90db2442c6ac18f339ec8ba006df2.1578596897.git.berto@igalia.com>
 <02552511-6fcf-d678-362c-707ce6d73659@redhat.com>
 <w517e1rf0fo.fsf@maestria.local.igalia.com>
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
Message-ID: <56ec1ead-bba9-f4de-5c87-e81f802dfc79@redhat.com>
Date: Fri, 17 Jan 2020 10:12:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <w517e1rf0fo.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aLkcg6svwyUSXuxEzbSFhNtUOzzcuXkom"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aLkcg6svwyUSXuxEzbSFhNtUOzzcuXkom
Content-Type: multipart/mixed; boundary="KM8Gd3fg7zPYS28d0JoPp4n6rffNPljo0"

--KM8Gd3fg7zPYS28d0JoPp4n6rffNPljo0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.01.20 00:26, Alberto Garcia wrote:
> On Tue 14 Jan 2020 03:15:48 PM CET, Max Reitz wrote:
>>> @@ -219,7 +219,7 @@ static int l2_load(BlockDriverState *bs, uint64_t o=
ffset,
>>>   * Writes one sector of the L1 table to the disk (can't update single =
entries
>>>   * and we really don't want bdrv_pread to perform a read-modify-write)
>>>   */
>>> -#define L1_ENTRIES_PER_SECTOR (512 / 8)
>>> +#define L1_ENTRIES_PER_SECTOR (BDRV_SECTOR_SIZE / 8)
>>>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index)
>>
>> Here it=E2=80=99s because the comment is wrong: =E2=80=9CCan=E2=80=99t u=
pdate single entries=E2=80=9D =E2=80=93
>> yes, we can.  We=E2=80=99d just have to do a bdrv_pwrite() to a single e=
ntry.
>=20
> What's the point of qcow2_write_l1_entry() then?

I think the point was that we couldn=E2=80=99t, for a long time, because th=
e
block layer only provided sector-granularity access.  This function
simply was never changed when the block layer gained the ability to do
byte-granularity I/O.

(We=E2=80=99d still need this function, but only for the endian swap, I thi=
nk.)

>>> @@ -3836,7 +3837,7 @@ qcow2_co_copy_range_from(BlockDriverState *bs,
>>>          case QCOW2_CLUSTER_NORMAL:
>>>              child =3D s->data_file;
>>>              copy_offset +=3D offset_into_cluster(s, src_offset);
>>> -            if ((copy_offset & 511) !=3D 0) {
>>> +            if (!QEMU_IS_ALIGNED(copy_offset, BDRV_SECTOR_SIZE)) {
>>
>> Hm.  I don=E2=80=99t get this one.
>=20
> Checking the code (e.g. block_copy_do_copy()) it seems that the whole
> chunk must be cluster aligned so I don't get this one either.

Hm, how did you get to block_copy_do_copy()?  That=E2=80=99s part of the
block-copy infrastructure that=E2=80=99s only used for the backup job, as f=
ar as
I=E2=80=99m aware.  It=E2=80=99s different from copy_range.

I don=E2=80=99t see any limitation for copy_range.  I suppose maybe it does=
n=E2=80=99t
work for anything that isn=E2=80=99t aligned to physical sectors?  But the =
qcow2
driver shouldn=E2=80=99t care about that.

On thing=E2=80=99s for sure, the raw driver doesn=E2=80=99t care about it.

Max


--KM8Gd3fg7zPYS28d0JoPp4n6rffNPljo0--

--aLkcg6svwyUSXuxEzbSFhNtUOzzcuXkom
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4hemoACgkQ9AfbAGHV
z0DhFAf+PsgHRgYz7Xftl5AzqoBmiQlhy3TqYYtVAhhyOzm4YIUL2W2gHnxcEYSh
gD5J2KIitzp1ih1jfvV7D7OlqcEDf3e4mTqgg5kYPKTYdNoWdaE35a92MEzd2hwz
rJCh9icc2HWQH5FbUuL1POSYSpR8kRuWQlBAhSZqI4zQn5J2ebIg/Y6X15LZ1zIq
Ubtly7vspt1xYflMzHMo2bh0+fGtkxEitfETP9LX88gf1G+RA7A4/ZJcWU2N2h0a
v9G/9J2LeqRUJVvYhOnNA2C/i1qGD0GsB62HBZyh75HppnS38K5QFVCVS/TjS2RM
GEpdociir+Gpn5rX4Quum2KzDyn5sQ==
=uBWF
-----END PGP SIGNATURE-----

--aLkcg6svwyUSXuxEzbSFhNtUOzzcuXkom--


