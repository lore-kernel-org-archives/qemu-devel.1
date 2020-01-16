Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765AFC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD3F207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bq1xwXz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD3F207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is7eA-0007Yb-B5
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 11:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is7bC-00050T-KP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is7bB-0006Jo-JW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:02:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is7bB-0006Je-Ev
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 11:02:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579190540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oK3Qb3EHIjWTjXl4xd5GYOmi51Z5sPZb2+HuvsNUE78=;
 b=bq1xwXz1Bl067q1qjc5DMqAHf0lrJDL90HrOOv05GVQM0KUjS7tuFW0UkTQ8uy/HdANmx3
 kBS32H1iCTiiUe8IiFKwwQk7GmnN41IvaBS6yRRk8IAyy1npKNQZGwkizxUGeYaBcljjws
 Ht/o4R1Si1LRtslivv1g7b1xARCCyzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-qw0siqVZNAeNLlf1aWPB_Q-1; Thu, 16 Jan 2020 11:02:19 -0500
X-MC-Unique: qw0siqVZNAeNLlf1aWPB_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 715B410120A3;
 Thu, 16 Jan 2020 16:02:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-185.ams2.redhat.com
 [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C75219C5B;
 Thu, 16 Jan 2020 16:02:10 +0000 (UTC)
Subject: Re: Bug? qemu-img convert to preallocated image makes it sparse
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
References: <20200116141352.GA32053@redhat.com>
 <7586b832-ecd2-e766-6781-3a25f382c9ed@redhat.com>
 <20200116145048.GG9470@linux.fritz.box>
 <5fcb531c-24ef-6e91-294d-517631c5a2cb@redhat.com>
 <03ebf1f7ad780fca65dfc7486e860beb33c71d20.camel@redhat.com>
 <20200116160044.GS3888@redhat.com>
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
Message-ID: <3cf00630-3c0b-4893-7c1e-2515794cc0d5@redhat.com>
Date: Thu, 16 Jan 2020 17:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116160044.GS3888@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5sAR75olrmNyLdxrMcc2zW2mAjUefasDU"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5sAR75olrmNyLdxrMcc2zW2mAjUefasDU
Content-Type: multipart/mixed; boundary="94U2uRSiACG6qW1UvkPA3hBbz3BvIChXz"

--94U2uRSiACG6qW1UvkPA3hBbz3BvIChXz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.01.20 17:00, Richard W.M. Jones wrote:
> On Thu, Jan 16, 2020 at 05:38:03PM +0200, Maxim Levitsky wrote:
>> How about doing write zeros without discard only in this particular case=
 (convert to existing image)
>> Basically omitting the BDRV_REQ_MAY_UNMAP flag to blk_co_pwrite_zeroes.
>> It will be slow, but maybe for this particular case, it is acceptable?
>=20
> I should probably say that we don't want to break the other case
> (which is likely more important) where we write a sparse source to a
> sparse target and want the target to contain only the union of the two
> sparse maps, not fully allocated :-)
>=20
> It would be fine, I think, to have a new "make this disk fully
> allocated" operation.  qemu-img resize could almost do it with a
> request to add 0 extra bytes, but the --preallocation flag only
> applies to the new space.

Well, that works with -S 0, as Kevin has said.  But that will take time
because it will write actual zeroes wherever the source is zero.

Max


--94U2uRSiACG6qW1UvkPA3hBbz3BvIChXz--

--5sAR75olrmNyLdxrMcc2zW2mAjUefasDU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4giP8ACgkQ9AfbAGHV
z0C3ewf/eL/OJOoLxeKLLEnerXrB1Q/ZlDe7jsf8dmLTEozQvbELSSOIMf+RGxE6
1v+aE9J7gF3Ola87r0aZzcUjAWC3WxK62KIQXqC7ONqqK43aUD5XUKXyAxThdFrx
IRFyruvO2uCH6Pr5sNT9FmixDOHTTiHgbJ1mBhqWuDTIhRgqLx1l6r9ZrEi7q6NG
hl8Qzz343HwNdXKnnP6WqHakLxMbS1atnisZqjIGr6i8iSWO1i7bUOsOMQY/5s0Z
W1uTh9BJwHEDB7ZYm9T2zvht3iN8+7XLn0rTZCJSWuQ6RCU6tkjbqH1xsgvCPc8m
5gKSxyhg3W1swfGXZXsXi18e9EhGLA==
=HtYf
-----END PGP SIGNATURE-----

--5sAR75olrmNyLdxrMcc2zW2mAjUefasDU--


