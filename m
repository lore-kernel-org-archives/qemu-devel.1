Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB36C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:34:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA40124673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoEsx3Ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA40124673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKSz-0001Oj-Om
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irKRP-0000Sl-3s
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irKRN-0000Ap-MM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:32:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48357
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irKRN-00008u-HN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:32:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579001576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nTqLCgL9g6NejDSo8n9k6M9RxGHbx/VDf0Sngv/XvZc=;
 b=NoEsx3RubxdQ52kfsMTK64DAvWgvQHJ6iMjzIlbLdbeFnhAxhlE65xHeqZDM9oJl0LwZ5D
 6efO8W7SZUmrsGsPmkfpqdHkCFLpZ2Qutc7rSse5MuVotn7kycZo6R8sbe70zMz1dCOm8g
 V16meqpJPjIMcQYdYUHq09ZDNppYqhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-9xwJ-iItPGOfHckFYxNLjA-1; Tue, 14 Jan 2020 06:32:53 -0500
X-MC-Unique: 9xwJ-iItPGOfHckFYxNLjA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC52A803A21;
 Tue, 14 Jan 2020 11:32:50 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEDD80A48;
 Tue, 14 Jan 2020 11:32:47 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2: Assert that host cluster offsets fit in L2
 table entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200113161146.20099-1-berto@igalia.com>
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
Message-ID: <2ef39c30-a535-f9f9-aa21-2084988c6644@redhat.com>
Date: Tue, 14 Jan 2020 12:32:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113161146.20099-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FWumvSZekW3VHOJ2HcReH06S4MbXApr6F"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FWumvSZekW3VHOJ2HcReH06S4MbXApr6F
Content-Type: multipart/mixed; boundary="5YFFZj9wYdY8mwI4rE2AfTow25HSu30aJ"

--5YFFZj9wYdY8mwI4rE2AfTow25HSu30aJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.01.20 17:11, Alberto Garcia wrote:
> The standard cluster descriptor in L2 table entries has a field to
> store the host cluster offset. When we need to get that offset from an
> entry we use L2E_OFFSET_MASK to ensure that we only use the bits that
> belong to that field.
>=20
> But while that mask is used every time we read from an L2 entry, it
> is never used when we write to it. Due to the QCOW_MAX_CLUSTER_OFFSET
> limit set in the cluster allocation code QEMU can never produce
> offsets that don't fit in that field so any such offset would indicate
> a bug in QEMU.
>=20
> Compressed cluster descriptors contain two fields (host cluster offset
> and size of the compressed data) and the situation with them is
> similar. In this case the masks are not constant but are stored in the
> csize_mask and cluster_offset_mask fields of BDRVQcow2State.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v2: the previous version was sent months ago but fell through the
>     cracks, so I'm resending it. I rebased it although the patch
>     doesn't need any changes.

Sorry. :-/

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--5YFFZj9wYdY8mwI4rE2AfTow25HSu30aJ--

--FWumvSZekW3VHOJ2HcReH06S4MbXApr6F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4dpt0ACgkQ9AfbAGHV
z0C9IAgAmDf/Hu20pi5XfXNWZFsXgssB2VL003Ik57WjPW39sItBVCMIfAHAXlK3
GE5qd7Xa7MLd2reXFH8hkK7Dl/k4aThqEp6pmxT5s2Ak+IPwNFb65rcQY/FTcTjy
U90gNGelQ3kuq3NuLt2BzY9TmP4IMt2ARWR9aocjF7E41SwlIctINvi0Mj88SC2R
bhWqgCaQRhUWskRJmjeuEyQXrZiOiF+smTo3hVz2AkOcZNE0NapljOmXCS/jCEIA
FsXZe4tLl4NDIIlUdzrkSFaQlbiAkbOXdMKMi5SzUVxnfHEN88OuEakr9E6XCK69
FR4gR9Do7IjL+n1pSsJYIjC4N/QDUg==
=BC7S
-----END PGP SIGNATURE-----

--FWumvSZekW3VHOJ2HcReH06S4MbXApr6F--


