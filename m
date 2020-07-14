Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78209C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42659221FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGL3vb6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42659221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNiw-0001qI-HS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jvNhc-00005e-4Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:22:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43661
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jvNhX-0002QQ-CD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594743758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mpy5RV5N/DfFVmLEE51dbX+YEXY2DH+wpwyn0M09OEc=;
 b=YGL3vb6ivVvrdNoV9d4Al70TyskiTlxFohOuaL5gnTPl1t3BWpCsy+8IzeBm4W6arx3XlJ
 rFnqUJH/BdcZP9CTDwFgTHNmG62xaJzD9DL3cNiUt8UjKElqDGgPTQakJsQRk3DLvunnqo
 yrx8WCgLJ9s5nbOdu2uIBxZelVkTQOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-dcqMXx3JNIOl7KM6_JUBkQ-1; Tue, 14 Jul 2020 12:22:36 -0400
X-MC-Unique: dcqMXx3JNIOl7KM6_JUBkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21A86107ACCA;
 Tue, 14 Jul 2020 16:22:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-179.ams2.redhat.com
 [10.36.113.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1F7810013C0;
 Tue, 14 Jul 2020 16:22:33 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
 <20200713142949.GD10318@linux.fritz.box>
 <b91329db-303f-41ab-5638-3ec7543b55ac@redhat.com>
 <20200714110837.GB5120@linux.fritz.box>
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
Message-ID: <af19cad2-f718-c17b-5856-ed0c8cbd3db3@redhat.com>
Date: Tue, 14 Jul 2020 18:22:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714110837.GB5120@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SBYMjjVjhz5fH1u3dCLWfxisLLsvqGm4h"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SBYMjjVjhz5fH1u3dCLWfxisLLsvqGm4h
Content-Type: multipart/mixed; boundary="DagZXzHRKhfTu0xU2V737vjBWE6NN5Jjf"

--DagZXzHRKhfTu0xU2V737vjBWE6NN5Jjf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.07.20 13:08, Kevin Wolf wrote:
> Am 14.07.2020 um 11:56 hat Max Reitz geschrieben:
>> On 13.07.20 16:29, Kevin Wolf wrote:
>>> Am 13.07.2020 um 13:19 hat Max Reitz geschrieben:
>>>> On 10.07.20 16:21, Kevin Wolf wrote:
>>>>> Unaligned requests will automatically be aligned to bl.request_alignm=
ent
>>>>> and we don't want to extend requests to access space beyond the end o=
f
>>>>> the image, so it's required that the image size is aligned.
>>>>>
>>>>> With write requests, this could cause assertion failures like this if
>>>>> RESIZE permissions weren't requested:
>>>>>
>>>>> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_=
sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
>>>>>
>>>>> This was e.g. triggered by qemu-img converting to a target image with=
 4k
>>>>> request alignment when the image was only aligned to 512 bytes, but n=
ot
>>>>> to 4k.
>>>>>
>>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>>> ---
>>>>>  block.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> (I think we had some proposal like this before, but I can=E2=80=99t fi=
nd it,
>>>> unfortunately...)
>>>>
>>>> I can=E2=80=99t see how with this patch you could create qcow2 images =
and then
>>>> use them with direct I/O, because AFAICS, qemu-img create doesn=E2=80=
=99t allow
>>>> specifying caching options, so AFAIU you=E2=80=99re stuck with:
>>>>
>>>> $ ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 1M
>>>> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536
>>>> compression_type=3Dzlib size=3D1048576 lazy_refcounts=3Doff refcount_b=
its=3D16
>>>>
>>>> $ sudo ./qemu-io -t none /mnt/tmp/foo.qcow2
>>>> qemu-io: can't open device /mnt/tmp/foo.qcow2: Image size is not a
>>>> multiple of request alignment
>>>>
>>>> (/mnt/tmp is a filesystem on a =E2=80=9Closetup -b 4096=E2=80=9D devic=
e.)
>>>
>>> Hm, that looks like some regrettable collateral damage...
>>>
>>> Well, you could argue that we should be writing full L1 tables with zer=
o
>>> padding instead of just the used part. I thought we had fixed this long
>>> ago. But looks like we haven't.
>>
>> That would help for the standard case.  It wouldn=E2=80=99t when the clu=
ster
>> size is smaller than the request alignment, which, while maybe not
>> important, would still be a shame.
>=20
> I don't think it would be unreasonable to require a cluster size that is
> a multiple of the logical block size of your host storage if you want to
> use O_DIRECT.

True.

> But we have unaligned images in practice, so this is pure theory anyway.

Hm.  Maybe it would help to just adjust the error message to instruct
the user to resize the image to fit the request alignment?  (e.g. =E2=80=9C=
is
not a multiple of the request alignment %u (try resizing the image to
%llu bytes)=E2=80=9D)

>>> But we should still avoid crashing in other cases, so what is the
>>> difference between both? Is it just that qcow2 has the RESIZE permissio=
n
>>> anyway so it doesn't matter?
>>
>> I assume so.
>>
>>> If so, maybe attaching to a block node with WRITE, but not RESIZE is
>>> what needs to fail when the image size is unaligned?
>>
>> That sounds reasonable.
>>
>> The obvious question is what happens when the RESIZE capability is
>> removed.  Dropping capabilities may never fail =E2=80=93 I suppose we co=
uld
>> force-keep the RESIZE capability for such nodes?
>=20
> It's not nice, but I think we already have this kind of behaviour for
> unlocking failures. So yes, that sounds like an option.
>=20
>> Or we could immediately align such files to the block size once they
>> are opened (with the RESIZE capability).
>=20
> Automatically resizing the image file is obviously harmless for qcow2
> images, but it would be a guest-visible change for raw images. It might
> be better to avoid this.

Well, it seems to be what already happens if the guest device has taken
the RESIZE capability (i.e., whenever there=E2=80=99s no failing assertion)=
.
The only difference that appears to me is just that it happens only when
writing to the end of the image instead of unconditionally when opening it.

Max


--DagZXzHRKhfTu0xU2V737vjBWE6NN5Jjf--

--SBYMjjVjhz5fH1u3dCLWfxisLLsvqGm4h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8N28gACgkQ9AfbAGHV
z0DBqwgAj4yFIYAMKsLKSu7iurkzYE7lIThc3SmFL0OJkOEsjHNWjB4yq5J+kjW5
eP++eZWi8NZ/MHdIuEZI3sRjYFtPcGZz3m3asatx5D940e7ITqQgKI27pPj2SJ9g
EyECuY+b8TATxoQbbu/fsD31p9hXUPL4QyyVs24YLxvHiIVxmA4b35tqOvJhbY+J
v02XCZ5ZJBUfLYVSykpdIXIrSr2LkeILj+bqCaKEx2q2ezaXbh5OOUcmCIBm6K90
67Ebi0i9loAh6Z6ItqgfhgPFIYQby7CJTtG6FFh+dTB2lpaEWJ0Awzp+9nzI9NaM
Fpr6RaJWOBOMqsYw7lXpamT2FO3JQA==
=PSEf
-----END PGP SIGNATURE-----

--SBYMjjVjhz5fH1u3dCLWfxisLLsvqGm4h--


