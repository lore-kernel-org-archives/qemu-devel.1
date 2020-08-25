Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEEAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58FE42068F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7c4NBa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FE42068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVoT-00069B-Lp
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAVnu-0005jP-Bs
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAVnp-0002if-8R
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598349819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KYuFGH105XPcVyX4x/bX6q9o/95Wy8cNlkvoTyNj5Lc=;
 b=d7c4NBa+dRLKwf4tKhC4cufxibcOis4cYrLz4Va2wG/6UUFtYsS5w+cFYPipm3h2PploJZ
 YLTIl/EDVjAuU/UhKhREJakI83kY1yQWlldHlpmb2HvjEi3F4rWWhyOPNuhq8Ciq2sUGJb
 yrNNnnRl+Mtid9qYGULSx/3fAJw87qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-SB1aJ5WaM-2AGaXiezg6tg-1; Tue, 25 Aug 2020 06:03:35 -0400
X-MC-Unique: SB1aJ5WaM-2AGaXiezg6tg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C42807355;
 Tue, 25 Aug 2020 10:03:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-72.ams2.redhat.com
 [10.36.113.72])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCB175D9D3;
 Tue, 25 Aug 2020 10:03:29 +0000 (UTC)
Subject: Re: [RFC PATCH 0/9] block/curl: Add caching of data downloaded from
 the remote server
To: David Edmondson <dme@dme.org>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200818110845.3825105-1-david.edmondson@oracle.com>
 <20200819141137.GC366841@stefanha-x1.localdomain> <m2ft8ivhuu.fsf@dme.org>
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
Message-ID: <2154afa0-9d37-ee31-a446-4d3ec6df45a3@redhat.com>
Date: Tue, 25 Aug 2020 12:03:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <m2ft8ivhuu.fsf@dme.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hNav1VitX22WzJ7uyEUXvPmfZ0iJFvyl3"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNav1VitX22WzJ7uyEUXvPmfZ0iJFvyl3
Content-Type: multipart/mixed; boundary="cweDWoZ3dGsIUEworprDfLSAoKfT5nTF1"

--cweDWoZ3dGsIUEworprDfLSAoKfT5nTF1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 16:19, David Edmondson wrote:
> On Wednesday, 2020-08-19 at 15:11:37 +01, Stefan Hajnoczi wrote:
>=20
>> On Tue, Aug 18, 2020 at 12:08:36PM +0100, David Edmondson wrote:
>>> When using qemu-img to convert an image that is hosted on an HTTP
>>> server to some faster local (or pseudo-local) storage, the overall
>>> performance can be improved by reading data from the HTTP server in
>>> larger blocks and by caching and re-using blocks already read. This
>>> set of patches implements both of these, and adds a further patch
>>> allowing an offset to be added to all of the HTTP requests.
>>
>> Hi David,
>> Thanks for posting this! Kevin and Max are the maintainers in this area,
>> but I wanted to ask an initial question:
>>
>> Is caching curl-specific or could this be implemented as a block filter
>> driver so that it can be stacked on top of other network protocols too?
>=20
> This implementation is curl specific, as you probably surmised. I will
> look at implementing something similar as a block filter.

I think from an implementation standpoint the best would be if we could
just use such a generic caching block filter above all curl nodes so we
can drop all caching from curl.

However, I suppose then we=E2=80=99d at least have the problem of how to pu=
t
this cache node on top of all curl nodes without breaking compatibility,
which may be impossible.

OTOH, maybe it would be fine to leave the new cache optional, and just
leave the curl driver itself as it is.  Which would also mean that
wouldn=E2=80=99t need readahead support in the cache driver.

But if we do need this full cache directly in the curl driver, is it at
least possible to share most of the caching code between it and a
(potential future) dedicated cache block driver?

Max


--cweDWoZ3dGsIUEworprDfLSAoKfT5nTF1--

--hNav1VitX22WzJ7uyEUXvPmfZ0iJFvyl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9E4e8ACgkQ9AfbAGHV
z0CN6Qf/SZwNcU7gHIWRidXBxoHY8RV3bPtLW1+koXW0EYcyLKDNNhd3t22PRk9P
DKlwXRqjaNxN6aLnWGhna7zAmGN1+r8FBeCOtjYBUZ9iviIjXBliXrd2XTUEXgs4
Ra2cdwAH1sY07VeyCpJTuiHPWrKS7W6DcxmuBhPoCSDbK8wmgiCRV8hbNyW9hRrJ
3FaqO0bguZrLGMYhufSD7V/RHizHv64ZcshfOVh9TgentMBjn/v8hXSvR0xRLZrd
XbobhCNyZbMrkcnwmmFTFhmNL9d/BYquNStBDoude44+Tzfuixl5j6MrUQYVMdng
uGA4iL563gwYYpcQMcgZXEGXqJ3JWg==
=mcCE
-----END PGP SIGNATURE-----

--hNav1VitX22WzJ7uyEUXvPmfZ0iJFvyl3--


