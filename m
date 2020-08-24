Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF707C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBCA020738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PAVgkRrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBCA020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADdR-0000N4-04
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kADTy-0000Iy-VF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:30:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kADTw-0002kU-Tw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598279395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4+8xjLSNaiV6eRfBfi/Ntqs6O3lKjF284ztUu3sNY7c=;
 b=PAVgkRrWE5r8EUhycNTwVVqVeZzi7QLBFxeQByYbVeGcQwpTUMl1wbXdAqzL1N5yNqJllb
 3vCbCv6ZR6jeboHnqdu3jqjrRoBimXt17isSkU/FbvcDHvuYYcx4RrVdK6SdOyK1zNlKkY
 4NPqHW0AuwDnNqcH/sdRi0Jyrr8Cuac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-jKtr6d5iOoyxmi72RzMkEg-1; Mon, 24 Aug 2020 10:29:53 -0400
X-MC-Unique: jKtr6d5iOoyxmi72RzMkEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68AD5100CEC3;
 Mon, 24 Aug 2020 14:29:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-171.ams2.redhat.com
 [10.36.112.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32CD270891;
 Mon, 24 Aug 2020 14:29:48 +0000 (UTC)
Subject: Re: [PATCH v7 41/47] block: Leave BDS.backing_file constant
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-42-mreitz@redhat.com>
 <20200824131412.GA10708@linux.fritz.box>
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
Message-ID: <280f4c43-e4c5-f29e-54be-91374ed80574@redhat.com>
Date: Mon, 24 Aug 2020 16:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824131412.GA10708@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xTxzeU5HvFJ9GgM4mPPQVjSQZ9SU9G3Hj"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTxzeU5HvFJ9GgM4mPPQVjSQZ9SU9G3Hj
Content-Type: multipart/mixed; boundary="7kp97mCrU9SO8HbchdEWAvbSAGtq2W59Q"

--7kp97mCrU9SO8HbchdEWAvbSAGtq2W59Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.08.20 15:14, Kevin Wolf wrote:
> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
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
>> qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow=
2'
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.=
qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'fo=
o/top.qcow2'
>>
>> After this patch:
>>
>> $ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
>> Image committed.
>> $ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
>> qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.=
qcow2'
>> $ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
>> Image committed.
>>
>> With this change, bdrv_find_backing_image() must look at whether the
>> user has overridden a BDS's backing file.  If so, it can no longer use
>> bs->backing_file, but must instead compare the given filename against
>> the backing node's filename directly.
>>
>> Note that this changes the QAPI output for a node's backing_file.  We
>> had very inconsistent output there (sometimes what the image header
>> said, sometimes the actual filename of the backing image).  This
>> inconsistent output was effectively useless, so we have to decide one
>> way or the other.  Considering that bs->backing_file usually at runtime
>> contained the path to the image relative to qemu's CWD (or absolute),
>> this patch changes QAPI's backing_file to always report the
>> bs->backing->bs->filename from now on.  If you want to receive the image
>> header information, you have to refer to full-backing-filename.
>>
>> This necessitates a change to iotest 228.  The interesting information
>> it really wanted is the image header, and it can get that now, but it
>> has to use full-backing-filename instead of backing_file.  Because of
>> this patch's changes to bs->backing_file's behavior, we also need some
>> reference output changes.
>>
>> Along with the changes to bs->backing_file, stop updating
>> BDS.backing_format in bdrv_backing_attach() as well.  In order not to
>> change our externally visible behavior (incompatibly), we have to let
>> bdrv_query_image_info() try to get the image format from bs->backing if
>> bs->backing_format is unset.  (The QAPI schema describes
>> backing-filename-format as "the format of the backing file", so it is
>> not necessarily what the image header says, but just the format of the
>> file referenced by backing-filename (if known).)
>=20
> Why is it okay to change backing-filename incompatibly, but not
> backing-filename-format?

I hope you=E2=80=99re asking the reverse, i.e. why I don=E2=80=99t change
backing-filename-format, too.  The answer to that is yeah, why not. :)

> I would find it much more consistent if
> ImageInfo reported the value from the header in both fields, and
> BlockDeviceInfo reported the values actually in use.
>=20
> The QAPI schema described ImageInfo as "Information about a QEMU image
> file" and runtime state really isn't information about an image file.
>=20
> If you want to know the probed image format, you can still look at
> backing-image.format. I don't think this change is much different from
> what you described above for BlockDeviceInfo.backing_file.

Well, OK then.

Max


--7kp97mCrU9SO8HbchdEWAvbSAGtq2W59Q--

--xTxzeU5HvFJ9GgM4mPPQVjSQZ9SU9G3Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9DztoACgkQ9AfbAGHV
z0B2mQgAgbE7JFb+AsLcOGo6ErokdyKOurWpT9HphancJ+I/5UerImw90B64FtmA
NR3Ujf6SP9wSy8+HR2NXTbMKzHe7g5MO0RBAwdGxRqYL2T00h8CSHCfntrneNnEl
AW5/NEw9dInDp5+yx0nzDHRKV9V6NgcQyQkNEb6VVuYoblG8a4DUkrTuYW0TMa9y
vNqcYOEBP14DRU/mZJeaFVnzn8cIkyX7S6KtXUD8Sx3JJU2Dlnymog5J+aEryPIs
aeWNU18/rfFXEZZ4ANa7yVYAgTHJsXtavvbu72VArWoKgtpi8TcNisFvkLJuyvpZ
4hUZVFrnBpd9H3ZmVs8dEyq/j5MAqw==
=MAj5
-----END PGP SIGNATURE-----

--xTxzeU5HvFJ9GgM4mPPQVjSQZ9SU9G3Hj--


