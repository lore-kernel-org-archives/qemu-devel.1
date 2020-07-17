Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DF0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CDC20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmkZWwU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CDC20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOgA-0007Qv-39
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwOfa-0006vt-PH
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:36:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwOfY-0005Mo-Og
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594985808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V0qb2K23Q5XL/NKMsX3hA6QchA4hYLpgttUt2YOyOg8=;
 b=dmkZWwU/X7Hxftn/w5qaiZwqNQKaZF1rgH8oNsx/5TmCyX62bXaY78IsuWhE26ZJGB7uHc
 teU2+2bBKATdJZejDO/g8DX3dD7hczMmSnzOw2LcRncaDHprcVLqgrLeM6cwWAvSVuRB5H
 6GuqhTLGtkeA7MzkotYdTFOJSOedWs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-Nk9S-Gs1P2udJJkaSCPWMg-1; Fri, 17 Jul 2020 07:36:45 -0400
X-MC-Unique: Nk9S-Gs1P2udJJkaSCPWMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03B9B18A1DE7;
 Fri, 17 Jul 2020 11:36:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF56472AF4;
 Fri, 17 Jul 2020 11:36:43 +0000 (UTC)
Subject: Re: [PATCH for-5.1 v2 1/2] block: Require aligned image size to avoid
 assertion failure
To: Kevin Wolf <kwolf@redhat.com>
References: <20200716142601.111237-1-kwolf@redhat.com>
 <20200716142601.111237-2-kwolf@redhat.com>
 <7567943c-85e0-5c5b-b67e-3b915d5fa9de@redhat.com>
 <20200717113243.GB4550@linux.fritz.box>
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
Message-ID: <83a05f42-1446-6973-f2dd-05a8b37792ac@redhat.com>
Date: Fri, 17 Jul 2020 13:36:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717113243.GB4550@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KodLWUs3T1UTtwnqRhAjSXrZ2elmN2mel"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KodLWUs3T1UTtwnqRhAjSXrZ2elmN2mel
Content-Type: multipart/mixed; boundary="ktw8DTXAShdMbXzPE01tKLo0vzMuys9oE"

--ktw8DTXAShdMbXzPE01tKLo0vzMuys9oE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.07.20 13:32, Kevin Wolf wrote:
> Am 17.07.2020 um 13:02 hat Max Reitz geschrieben:
>> On 16.07.20 16:26, Kevin Wolf wrote:
>>> Unaligned requests will automatically be aligned to bl.request_alignmen=
t
>>> and we can't extend write requests to access space beyond the end of th=
e
>>> image without resizing the image, so if we have the WRITE permission,
>>> but not the RESIZE one, it's required that the image size is aligned.
>>>
>>> Failing to meet this requirement could cause assertion failures like
>>> this if RESIZE permissions weren't requested:
>>>
>>> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_se=
ctor <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
>>>
>>> This was e.g. triggered by qemu-img converting to a target image with 4=
k
>>> request alignment when the image was only aligned to 512 bytes, but not
>>> to 4k.
>>>
>>> Turn this into a graceful error in bdrv_check_perm() so that WRITE
>>> without RESIZE can only be taken if the image size is aligned. If a use=
r
>>> holds both permissions and drops only RESIZE, the function will return
>>> an error, but bdrv_child_try_set_perm() will ignore the failure silentl=
y
>>> if permissions are only requested to be relaxed and just keep both
>>> permissions while returning success.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/block.c b/block.c
>>> index 35a372df57..6371928edb 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -2025,6 +2025,22 @@ static int bdrv_check_perm(BlockDriverState *bs,=
 BlockReopenQueue *q,
>>>          return -EPERM;
>>>      }
>>> =20
>>> +    /*
>>> +     * Unaligned requests will automatically be aligned to bl.request_=
alignment
>>> +     * and without RESIZE we can't extend requests to write to space b=
eyond the
>>> +     * end of the image, so it's required that the image size is align=
ed.
>>> +     */
>>> +    if ((cumulative_perms & BLK_PERM_WRITE) &&
>>
>> What about WRITE_UNCHANGED?  I think this would only matter with nodes
>> that can have backing files (i.e., qcow2 in practice) because
>> WRITE_UNCHANGED is only used by COR and block jobs doing something with
>> a backing chain, so it shouldn=E2=80=99t matter in practice, but, well.
>=20
> So basically just replacing the line with this?
>=20
>     if ((cumulative_perms & (BLK_PERM_WRITE | BDRV_PERM_WRITE_UNCHANGED))=
 &&
>=20
> I can do that while applying if it is what you mean.

Yes. :)

>> So, either way:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
> Thanks!
>=20
> Kevin
>=20
>>> +        !(cumulative_perms & BLK_PERM_RESIZE))
>>> +    {
>>> +        if ((bs->total_sectors * BDRV_SECTOR_SIZE) % bs->bl.request_al=
ignment) {
>>> +            error_setg(errp, "Cannot get 'write' permission without 'r=
esize': "
>>> +                             "Image size is not a multiple of request =
"
>>> +                             "alignment");
>>> +            return -EPERM;
>>> +        }
>>> +    }
>>> +
>>>      /* Check this node */
>>>      if (!drv) {
>>>          return 0;
>>>
>>
>>
>=20
>=20
>=20



--ktw8DTXAShdMbXzPE01tKLo0vzMuys9oE--

--KodLWUs3T1UTtwnqRhAjSXrZ2elmN2mel
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8RjUoACgkQ9AfbAGHV
z0ANkwf/b99LfjER6E2O6DvvSJu3bUWQMBxOCixghRcXwONWgb8sHIsPAw4k1whd
Y8iEF0BRZ+ivVFYoD4NrxjX4G9jknBCdyn1EjT3jPyHNDVzV9efb7N6ssJq4VXOV
9TWw5agK00Jfl2Yu397qvjhVwUV31Uo1cKLQf5J7CrQ5kGJtzGWBAlrXdvplTNPF
ePIGcjkAMvGEpkT3z1wPur/YwxL1GjZtBlT8/JOB+0HgzlU/y8GnxDQm706yTTx4
95BiIjvBgOiskBBD1BTRBOln8r51Y5RmYwatkeT9pIlBDlAEA9AFNwI3+x00iAdQ
n2xw1MPrphUkq3z1xLHIjIrJchpPAA==
=4hPj
-----END PGP SIGNATURE-----

--KodLWUs3T1UTtwnqRhAjSXrZ2elmN2mel--


