Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B8C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2657206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2JV2ZrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2657206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QMn-0007Mn-96
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0QJ8-0003On-4g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46431
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0QJ5-0006ec-AP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 10:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595945414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UrcZfWnAdb+7nVVGWxQZM6Q6HCwFoqdqXrY/nAYiwEU=;
 b=H2JV2ZrOWBWpYfWbEF4CLwgOHYJHwZxbmxwov8d2Iqdf4yiVlBGMi9CtfcOpGTFGhBQDR1
 Ngpc1bcijaLFN8P2q2gUTsi0aZG0UNuksxFxPNb1euTBdOvunHfLp8D2XtmPQci1KwGri5
 vddUAxq2uyFg3RO5I5ZH342FyC18BsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-YXVvh2VfPhqhpTlsOvknTA-1; Tue, 28 Jul 2020 10:10:10 -0400
X-MC-Unique: YXVvh2VfPhqhpTlsOvknTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D5C19067E0;
 Tue, 28 Jul 2020 14:10:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-145.ams2.redhat.com
 [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 842AD73023;
 Tue, 28 Jul 2020 14:10:07 +0000 (UTC)
Subject: Re: [PATCH v7 41/47] block: Leave BDS.backing_file constant
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-42-mreitz@redhat.com>
 <17ef88da-15fc-57ae-801e-a5374e87743f@virtuozzo.com>
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
Message-ID: <df876252-af71-7a6a-778a-202b6735ebde@redhat.com>
Date: Tue, 28 Jul 2020 16:10:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <17ef88da-15fc-57ae-801e-a5374e87743f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LeFPUrHmVCPpXx3ACIBaHXyVWhTfScNCT"
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LeFPUrHmVCPpXx3ACIBaHXyVWhTfScNCT
Content-Type: multipart/mixed; boundary="ILtv09RkOz8qvWazmUPTBVauMTVaLxloh"

--ILtv09RkOz8qvWazmUPTBVauMTVaLxloh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.07.20 14:27, Andrey Shinkevich wrote:
> On 25.06.2020 18:22, Max Reitz wrote:
>> Parts of the block layer treat BDS.backing_file as if it were whatever
>> the image header says (i.e., if it is a relative path, it is relative to
>> the overlay), other parts treat it like a cache for
>> bs->backing->bs->filename (relative paths are relative to the CWD).
>> Considering bs->backing->bs->filename exists, let us make it mean the
>> former.
>>
>> Among other things, this now allows the user to specify a base when
>> using qemu-img to commit an image file in a directory that is not the
>> CWD (assuming, everything uses relative filenames).
>>
>> Before this patch:
>>
>> $ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
>> $ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
>> $ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
>> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>>
>> After this patch:
>>
>> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
>> Image committed.
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of
>> 'foo/top.qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> Image committed.
>>
>> With this change, bdrv_find_backing_image() must look at whether the
>> user has overridden a BDS's backing file.=C2=A0 If so, it can no longer =
use
>> bs->backing_file, but must instead compare the given filename against
>> the backing node's filename directly.
>>
>> Note that this changes the QAPI output for a node's backing_file.=C2=A0 =
We
>> had very inconsistent output there (sometimes what the image header
>> said, sometimes the actual filename of the backing image).=C2=A0 This
>> inconsistent output was effectively useless, so we have to decide one
>> way or the other.=C2=A0 Considering that bs->backing_file usually at run=
time
>> contained the path to the image relative to qemu's CWD (or absolute),
>> this patch changes QAPI's backing_file to always report the
>> bs->backing->bs->filename from now on.=C2=A0 If you want to receive the =
image
>> header information, you have to refer to full-backing-filename.
>>
>> This necessitates a change to iotest 228.=C2=A0 The interesting informat=
ion
>> it really wanted is the image header, and it can get that now, but it
>> has to use full-backing-filename instead of backing_file.=C2=A0 Because =
of
>> this patch's changes to bs->backing_file's behavior, we also need some
>> reference output changes.
>>
>> Along with the changes to bs->backing_file, stop updating
>> BDS.backing_format in bdrv_backing_attach() as well.=C2=A0 In order not =
to
>> change our externally visible behavior (incompatibly), we have to let
>> bdrv_query_image_info() try to get the image format from bs->backing if
>> bs->backing_format is unset.=C2=A0 (The QAPI schema describes
>> backing-filename-format as "the format of the backing file", so it is
>> not necessarily what the image header says, but just the format of the
>> file referenced by backing-filename (if known).)
>>
>> iotest 245 changes in behavior: With the backing node no longer
>> overriding the parent node's backing_file string, you can now omit the
>> @backing option when reopening a node with neither a default nor a
>> current backing file even if it used to have a backing node at some
>> point.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/block_int.h=C2=A0 | 21 ++++++++++++++++-----
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 ++++++++++++=
+++++++++++++++--------
>> =C2=A0 block/qapi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++++++----
>> =C2=A0 tests/qemu-iotests/228=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
>> =C2=A0 tests/qemu-iotests/228.out |=C2=A0 6 +++---
>> =C2=A0 tests/qemu-iotests/245=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>> =C2=A0 6 files changed, 65 insertions(+), 24 deletions(-)
>>
> ...
>> diff --git a/block/qapi.c b/block/qapi.c
>> index 2628323b63..5da6d7e6e0 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -47,7 +47,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend
>> *blk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ImageInfo **p_image_info;
>> -=C2=A0=C2=A0=C2=A0 BlockDriverState *bs0;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs0, *backing;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDeviceInfo *info;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs->drv) {
>> @@ -76,9 +76,10 @@ BlockDeviceInfo
>> *bdrv_block_device_info(BlockBackend *blk,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->node_name =
=3D g_strdup(bs->node_name);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs->backing_file[0]) {
>> +=C2=A0=C2=A0=C2=A0 backing =3D bdrv_cow_bs(bs);
>> +=C2=A0=C2=A0=C2=A0 if (backing) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->has_backing=
_file =3D true;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->backing_file =3D g_str=
dup(bs->backing_file);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->backing_file =3D g_str=
dup(backing->filename);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!QLIST_EMPTY(&bs->dirty_bitmap=
s)) {
>> @@ -314,6 +315,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_filename =3D bs->backing_file;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (backing_filename[0] !=3D '\0') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *backing_fil=
ename2;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *backing_format =
=3D NULL;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->backing_fil=
ename =3D g_strdup(backing_filename);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->has_backing=
_filename =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backing_filename2=
 =3D bdrv_get_full_backing_filename(bs, NULL);
>> @@ -326,7 +329,13 @@ void bdrv_query_image_info(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bs->ba=
cking_format[0]) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info=
->backing_filename_format =3D
>> g_strdup(bs->backing_format);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 back=
ing_format =3D bs->backing_format;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (bs->backing && bs=
->backing->bs->drv &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !bdrv_backing_overridden(bs)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 back=
ing_format =3D bs->backing->bs->drv->format_name;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>=20
> In case bdrv_backing_overridden() returns true , should we invoke
> bdrv_refresh_filename() and assign the format_name then?

I don=E2=80=99t think so.  The format we return in info->backing_filename_f=
ormat
should be the format of the file returned in info->backing_filename.
The latter is bs->backing_file, which (as of this patch), is the backing
file as reported by the image header.  Therefore, if the backing file
was overridden, we cannot assume that bs->backing->bs refers to the same
file as bs->backing_file, and so we cannot assume
bs->backing->bs->drv->format_name to be info->backing_filename=E2=80=99s fo=
rmat.

Max


--ILtv09RkOz8qvWazmUPTBVauMTVaLxloh--

--LeFPUrHmVCPpXx3ACIBaHXyVWhTfScNCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8gMb0ACgkQ9AfbAGHV
z0B0fAgAkDgfKtWlJ2kH2ZFRfgEPgend+gnHiGw79+JfnbIFyz7YmatDBOqgKJLI
7/o3K1KURJ4CUTH3SQH5xgZcgaDK4HFyipjxzJB0CnkuhXNH3TPcfaM2wXIwwXV8
KdTSPiGpm712WRxYJHbUUccHCxAYsT5hEVxvYJ+n1dHnKM5UmlfrMjX76o1VQckn
KocrQVDW9DfGBSjBMKvRztkoPDE0hw9R6AotVGR6Z0deSEnjC6/vHv72E682+jk8
qOMs6T2ha7GHhXTuqNbN6LWUGAfGqENE46zDg7vqNclp+dwhdnrsOZIHDG+vOgQs
88CXYifsK2Ku8ib9P2q1CJpJ74PDcQ==
=iqn4
-----END PGP SIGNATURE-----

--LeFPUrHmVCPpXx3ACIBaHXyVWhTfScNCT--


