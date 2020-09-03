Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D68E420758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IEbpL+dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68E420758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDp3V-0007RH-0a
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDp2X-0006au-OW
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:12:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDp2V-0005Ax-K8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599138750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9QOgo3mwhlYQu+kOZSC2Q1bVVWcchZSyFhtaiun/mAo=;
 b=IEbpL+dEESKWBKx+jAmpHJRb58YTnfRWxht6rfVVJtUwYdLSRpoPZ3ixAgLTKbxHufw/OT
 QrzTShJM4v9Ao5bpdwFMI/AQkBcVn07YZ5fztcfjoxiP9zCgkWRmmUFs1Wo1GzcV5MRtJn
 uQEUnzCwW61nQPulu3vOfvAMAwcVATs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-lkBSap4nMmSEF48besOBHA-1; Thu, 03 Sep 2020 09:12:27 -0400
X-MC-Unique: lkBSap4nMmSEF48besOBHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75DF0107464A;
 Thu,  3 Sep 2020 13:12:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-164.ams2.redhat.com
 [10.36.112.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 344D31014165;
 Thu,  3 Sep 2020 13:12:24 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Fix removal of list members from
 BDRVQcow2State.cluster_allocs
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200902174230.12336-1-berto@igalia.com>
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
Message-ID: <3a45705f-563d-d5f9-bb1c-b94309c07a20@redhat.com>
Date: Thu, 3 Sep 2020 15:12:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902174230.12336-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8PcNRO8qraZ5rWa7y1IlSnXHbBYpWTGeA"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8PcNRO8qraZ5rWa7y1IlSnXHbBYpWTGeA
Content-Type: multipart/mixed; boundary="o7dRLpyVcZULgBKTN1U6Y6dDLf6odPEPd"

--o7dRLpyVcZULgBKTN1U6Y6dDLf6odPEPd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.09.20 19:42, Alberto Garcia wrote:
> When a write request needs to allocate new clusters (or change the L2
> bitmap of existing ones) a QCowL2Meta structure is created so the L2
> metadata can be later updated and any copy-on-write can be performed
> if necessary.
>=20
> A write request can span a region consisting of an arbitrary
> combination of previously unallocated and allocated clusters, and if
> the unallocated ones can be put contiguous to the existing ones then
> QEMU will do so in order to minimize the number of write operations.
>=20
> In practice this means that a write request has not just one but a
> number of QCowL2Meta structures. All of them are added to the
> cluster_allocs list that is stored in BDRVQcow2State and is used to
> detect overlapping requests. After the write request finishes all its
> associated QCowL2Meta are removed from that list. calculate_l2_meta()
> takes care of creating and putting those structures in the list, and
> qcow2_handle_l2meta() takes care of removing them.
>=20
> The problem is that the error path in handle_alloc() also tries to
> remove an item in that list, a remnant from the time when this was
> handled there (that code would not even be correct anymore because
> it only removes one struct and not all the ones from the same write
> request).
>=20
> This can trigger a double removal of the same item from the list,
> causing a crash. This is not easy to reproduce in practice because
> it requires that do_alloc_cluster_offset() fails after a successful
> previous allocation during the same write request, but it can be
> reproduced with the included test case.
>=20
> As a last thing, this patch also removes the condition that
> l2meta->nb_clusters is not 0 in qcow2_handle_l2meta(). This was only
> necessary when that structure was allocated in the stack in order
> to detect if it had been initialized or not. This changed in commit
> f50f88b9fe and nowadays nb_clusters is guaranteed to be > 0.

On my search for /(\.|->)nb_clusters/ to verify this, I noticed this
comment for qcow2_alloc_cluster_offset():

 * If the cluster was already allocated, m->nb_clusters is set to 0 and



 * other fields in m are meaningless.

Should that be dropped, too?

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c      |  3 --
>  block/qcow2.c              |  4 +-
>  tests/qemu-iotests/305     | 75 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/305.out | 16 ++++++++
>  tests/qemu-iotests/group   |  1 +
>  5 files changed, 93 insertions(+), 6 deletions(-)
>  create mode 100755 tests/qemu-iotests/305
>  create mode 100644 tests/qemu-iotests/305.out

[...]

> diff --git a/tests/qemu-iotests/305 b/tests/qemu-iotests/305
> new file mode 100755
> index 0000000000..6de3180c17
> --- /dev/null
> +++ b/tests/qemu-iotests/305
> @@ -0,0 +1,75 @@

[...]

> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux
> +_unsupported_imgopts cluster_size refcount_bits extended_l2

data_file, too, because the refcounts work differently there.  (As in:
Not at all for data clusters.)

Also, compat(=3D0.10), because that wouldn=E2=80=99t allow -o refcount_bits=
=3D64.

> +
> +refcount_table_offset=3D$((0x400))

I would like to suggest $(peek_file_be "$TEST_IMG" 48 8), to set an
example for future generations; but not strictly necessary, of course. O:)

Anyway, at least with the _unsupported_imgopts line completed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--o7dRLpyVcZULgBKTN1U6Y6dDLf6odPEPd--

--8PcNRO8qraZ5rWa7y1IlSnXHbBYpWTGeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9Q67YACgkQ9AfbAGHV
z0AM+wf6AmMo1hoArrEgGR5jGRqM2furrBLcBw7TZzOCnywBlR+aeMOQXXk3a03R
m2AINFmeGCBxf7BaU23M+jmG2IpI2iiJ3zkpfzNsQJhFEG2FQ6Yc4Xbb7Tds6h6W
f+y0MtGFB9JZ8Pvkw4P5Z0SAP9gKg1JUTw0GTuo/TYAtsF2q+ZYx3p/KKSavMjHA
mUmHOEy4WcVmUsn//LCriyF6qlBnSpRTDc4CNM1GEUG5CtUlaJ5tBTpWl3ke1aYD
TAz9Q0TtRt32XA1bkCF7jCRBSEkxdSny1++EGf/6TYWYdTWIZBMkbPY0BjH++y7x
ijbd37oe33cIOXhauMMa5TAQyqc/dQ==
=M+wH
-----END PGP SIGNATURE-----

--8PcNRO8qraZ5rWa7y1IlSnXHbBYpWTGeA--


