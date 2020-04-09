Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C92FC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AA120857
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZWnZ7XT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AA120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMWDW-00033Z-T0
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 08:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMWCo-0002E3-5G
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMWCl-0004hz-Lb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:22:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31433
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMWCl-0004gp-G9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586434966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pYgEI5AI9tUAqXkEM/9+23JPVIr5DTIFu/4KHeczKTI=;
 b=bZWnZ7XTL/d36zNPBvWX8s977Ehvoz/9YBQPN4DigVCOur+3mYUW4LP9Jq6qiazEtv5H9b
 5s+tbd9tQ+Qfj/5lcc3L796sLGb5cBNdfbfKhc40hX2vjSEvvqWFkXoW0HdQHHKXZN0hc7
 IQK5crSVFjDSCQkWZhJvF37XaGHOwGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-gT4XXWCmN-qa83Cm299pwA-1; Thu, 09 Apr 2020 08:22:44 -0400
X-MC-Unique: gT4XXWCmN-qa83Cm299pwA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E70E18018A3;
 Thu,  9 Apr 2020 12:22:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 517CE10027AC;
 Thu,  9 Apr 2020 12:22:38 +0000 (UTC)
Subject: Re: [PATCH v4 30/30] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <420b76fbe25d5e2eeda53490a1c646935dab61c4.1584468724.git.berto@igalia.com>
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
Message-ID: <3684cc01-3082-c52a-bd58-49300244a6eb@redhat.com>
Date: Thu, 9 Apr 2020 14:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <420b76fbe25d5e2eeda53490a1c646935dab61c4.1584468724.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jLKGE9pQRAxBy5VmaUINFak5xQIosYL1C"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jLKGE9pQRAxBy5VmaUINFak5xQIosYL1C
Content-Type: multipart/mixed; boundary="v4jigBFnktBrAs3v5y73ANbJIshnisN6B"

--v4jigBFnktBrAs3v5y73ANbJIshnisN6B
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:16, Alberto Garcia wrote:
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  tests/qemu-iotests/271     | 359 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/271.out | 244 +++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 604 insertions(+)
>  create mode 100755 tests/qemu-iotests/271
>  create mode 100644 tests/qemu-iotests/271.out
>=20
> diff --git a/tests/qemu-iotests/271 b/tests/qemu-iotests/271
> new file mode 100755
> index 0000000000..48f4d8d8ce
> --- /dev/null
> +++ b/tests/qemu-iotests/271

[...]

> +# Compare the bitmap of an extended L2 entry against an expected value
> +_verify_l2_bitmap()
> +{
> +    entry_no=3D"$1"        # L2 entry number, starting from 0
> +    expected_alloc=3D"$2"  # Space-separated list of allocated subcluste=
r indexes
> +    expected_zero=3D"$3"   # Space-separated list of zero subcluster ind=
exes
> +
> +    offset=3D$(($l2_offset + $entry_no * 16))
> +    entry=3D`peek_file_be "$TEST_IMG" $offset 8`
> +    offset=3D$(($offset + 8))
> +    bitmap=3D`peek_file_be "$TEST_IMG" $offset 8`
> +
> +    expected_bitmap=3D0
> +    for bit in $expected_alloc; do
> +        expected_bitmap=3D$(($expected_bitmap | (1 << $bit)))
> +    done
> +    for bit in $expected_zero; do
> +        expected_bitmap=3D$(($expected_bitmap | (1 << (32 + $bit))))
> +    done
> +    expected_bitmap=3D`printf "%llu" $expected_bitmap`
> +
> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bitm=
ap"
> +    if [ "$bitmap" !=3D "$expected_bitmap" ]; then
> +        printf "ERROR: expecting bitmap       0x%016lx\n" "$expected_bit=
map"
> +    fi
> +}

Thanks! :)

[...]

> +# Test that writing to an image with subclusters produces the expected
> +# results, in images with and without backing files
> +for use_backing_file in yes no; do

[...]

> +    ### Write subcluster #31-#34 (cluster overlap) ###

#31-#34, I think.

> +    alloc=3D"`seq 0 9` 16 31"; zero=3D""
> +    _test_write 'write -q -P 8 63k 4k' "$alloc" "$zero"
> +    alloc=3D"0 1" ; zero=3D""
> +    _verify_l2_bitmap 1 "$alloc" "$zero"

[...]

> +    ### Partially zeroize an unallocated cluster (#3)
> +    if [ "$use_backing_file" =3D "yes" ]; then
> +        alloc=3D"`seq 0 15`"; zero=3D""

Isn=E2=80=99t this a TODO?  (I.e., ideally we=E2=80=99d want the first 16 s=
ubclusters to
be zero, and the last 16 subclusters to be unallocated, right?)

(I=E2=80=99m asking because you did raise a TODO for the =E2=80=9CZero subc=
luster #1=E2=80=9D test)

> +    else
> +        alloc=3D""; zero=3D"`seq 0 31`"
> +    fi
> +    _test_write 'write -q -z 192k 32k' "$alloc" "$zero" 3
> +done

[...]

> +# Test that corrupted L2 entries are detected in both read and write
> +# operations
> +for corruption_test_cmd in read write; do

[...]

> +    echo
> +    echo "### Compressed cluster with subcluster bitmap !=3D 0 - $corrup=
tion_test_cmd test ###"
> +    echo
> +    # We actually don't consider this a corrupted image.
> +    # The bitmap in compressed clusters is unused so QEMU should just ig=
nore it.
> +    _make_test_img 1M
> +    $QEMU_IO -c 'write -q -P 11 -c 0 64k' "$TEST_IMG"
> +    poke_file "$TEST_IMG" $(($l2_offset+11)) "\x01\x01"
> +    alloc=3D"24"; zero=3D"0"
> +    _verify_l2_bitmap 0 "$alloc" "$zero"
> +    $QEMU_IO -c "$corruption_test_cmd -P 11 0 64k" "$TEST_IMG" | _filter=
_qemu_io

It might be interesting to see the bitmap after the write, i.e., that
it=E2=80=99s just been ignored.  Not necessary, though; the fact that the r=
ead
worked without error tells for sure that qemu ignores the bitmap.

> +done
> +
> +echo
> +echo "### Image creation options ###"
> +echo
> +echo "# cluster_size < 16k"
> +IMGOPTS=3D"extended_l2=3Don,cluster_size=3D8k" _make_test_img 1M
> +
> +echo "# backing file and preallocation=3Dmetadata"
> +IMGOPTS=3D"extended_l2=3Don,preallocation=3Dmetadata" _make_test_img -b =
"$TEST_IMG.backing" 1M

TODO?

> +
> +echo "# backing file and preallocation=3Dfalloc"
> +IMGOPTS=3D"extended_l2=3Don,preallocation=3Dfalloc" _make_test_img -b "$=
TEST_IMG.backing" 1M
> +
> +echo "# backing file and preallocation=3Dfull"
> +IMGOPTS=3D"extended_l2=3Don,preallocation=3Dfull" _make_test_img -b "$TE=
ST_IMG.backing" 1M
> +
> +echo
> +echo "### qemu-img measure ###"
> +echo
> +echo "# 512MB, extended_l2=3Doff" # This needs one L2 table
> +$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=3Doff
> +echo "# 512MB, extended_l2=3Don"  # This needs two L2 tables
> +$QEMU_IMG measure --size 512M -O qcow2 -o extended_l2=3Don
> +
> +echo "# 16K clusters, 64GB, extended_l2=3Doff" # This needs one L1 table

You mean one full L1 table cluster?

> +$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=3D16k,extended_l2=
=3Doff
> +echo "# 16K clusters, 64GB, extended_l2=3Don"  # This needs two L2 table=
s

And two full L1 table clusters?

Max

> +$QEMU_IMG measure --size 64G -O qcow2 -o cluster_size=3D16k,extended_l2=
=3Don
> +
> +echo "# 8k clusters" # This should fail
> +$QEMU_IMG measure --size 1M -O qcow2 -o cluster_size=3D8k,extended_l2=3D=
on
> +
> +echo "# 1024 TB" # Maximum allowed size with extended_l2=3Don and 64K cl=
usters
> +$QEMU_IMG measure --size 1024T -O qcow2 -o extended_l2=3Don
> +echo "# 1025 TB" # This should fail
> +$QEMU_IMG measure --size 1025T -O qcow2 -o extended_l2=3Don
> +
> +# success, all done
> +echo "*** done"
> +rm -f $seq.full
> +status=3D0
> +


--v4jigBFnktBrAs3v5y73ANbJIshnisN6B--

--jLKGE9pQRAxBy5VmaUINFak5xQIosYL1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6PE40ACgkQ9AfbAGHV
z0Az/AgAschtzDi7dBGgQUt/9R/WXTv5AvAzWYzrrYP3LSOW+0vSUgTdDwpieogg
M3ynRuN1hyfTy8yPUT0ZckcWZRJtgYmxW8RTqAiZs19Dj73yqE3Lbpl7paMC+nAW
XpGgGai94CmKIs22f9ee0fxtLo7/Xkz1il6qWcadzn94ctW3CUyhOutUbmpgEIUb
JtAishwmUDK3Vr4XX8gtHJC+CQcebS+lgvw6usGJHV9Gr7JC3hAltE6yFYwpblWF
zC+vnX+FZ9QljbWfwR8lkCsMgkLbB+sZNI/CnkWgAfE95zLCZBB0YjIfS0Ui49+H
AYqiPOXUAZgD1mzVdqNE6l26zS+fhg==
=7Ot4
-----END PGP SIGNATURE-----

--jLKGE9pQRAxBy5VmaUINFak5xQIosYL1C--


