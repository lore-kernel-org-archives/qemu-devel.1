Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693BDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D62206A2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YKoDu0MN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D62206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgTq7-0002iz-Dx
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 09:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jgTpT-0002CR-0m
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 09:53:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jgTpR-0003l6-J0
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591192392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j32L1MJsJGHQF1G5fr3J6Ak2AO2zgqbVM6B08avRVyY=;
 b=YKoDu0MNINQ9nqRCwUo395QmJwlDKTOxtX+sxEHVFOePIcpr+22wYEu40+cITp61ZgF0kW
 /DVPGUat8YWqwryfSmxdjss/bSrika3rgbWQLof33f9P4DP31qp53WVviLT86XOCs+I1q0
 SCkhDjFvbT5ELOMCMXZKO7V1qAMlEvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-18jGt9NIMrSkBXl-aeUqMw-1; Wed, 03 Jun 2020 09:53:09 -0400
X-MC-Unique: 18jGt9NIMrSkBXl-aeUqMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AD42800685;
 Wed,  3 Jun 2020 13:53:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-6.ams2.redhat.com
 [10.36.115.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA1385C3FD;
 Wed,  3 Jun 2020 13:53:04 +0000 (UTC)
Subject: Re: [PATCH for-5.1] qcow2: Don't open images with a backing file and
 the data-file-raw bit
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200415190207.21118-1-berto@igalia.com>
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
Message-ID: <b0202150-5a43-18d5-3716-b758ab7e5824@redhat.com>
Date: Wed, 3 Jun 2020 15:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200415190207.21118-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mD9dXNkklsdNwPFjyXUM3m4dGCxGUin93"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:12:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
--mD9dXNkklsdNwPFjyXUM3m4dGCxGUin93
Content-Type: multipart/mixed; boundary="g5M6YifAmPM0VjThXhbEJ7FiLD78Tvf9G"

--g5M6YifAmPM0VjThXhbEJ7FiLD78Tvf9G
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.04.20 21:02, Alberto Garcia wrote:
> Although we cannot create these images with qemu-img it is still
> possible to do it using an external tool. QEMU should refuse to open
> them until the data-file-raw bit is cleared with 'qemu-img check'.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              | 39 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/244     | 13 +++++++++++++
>  tests/qemu-iotests/244.out | 14 ++++++++++++++
>  3 files changed, 66 insertions(+)

Sorry for the long delay. :/

The patch itself looks good, but I=E2=80=99m not sure whether it is extensi=
ve
enough.  Let me just jump straight to the problem:

$ ./qemu-img create -f qcow2 \
    -o data_file=3Dfoo.qcow2.raw,data_file_raw=3Don \
    foo.qcow2 64M
(Create some file empty foo.qcow2 with external data file that=E2=80=99s ra=
w)

$ ./qemu-img create -f qcow2 backing.qcow2 64M
$ ./qemu-io -c 'write -P 42 0 64M' backing.qcow2
(Create some file filled with 42s)

$ ./qemu-img compare foo.qcow2 foo.qcow2.raw
Images are identical.
(As expected, foo.qcow2 is identical to its raw data file)

$ ./qemu-img compare --image-opts \
    file.filename=3Dfoo.qcow2,backing.file.filename=3Dbacking.qcow2 \
    file.filename=3Dfoo.qcow2.raw
Content mismatch at offset 0!
(Oops.)

So when the user manually gives a backing file without one having been
given by the image file, we run into the same problem.  Now I=E2=80=99m not
quite sure what the problem is here.  We could make this patch more
extensive and also forbid this case.

But I think there actually shouldn=E2=80=99t be a problem.  The qcow2 drive=
r
shouldn=E2=80=99t fall back to a backing file for raw external data files. =
 But
how exactly should that be implemented?  I think the correct way would
be to preallocate all metadata whenever data_file_raw=3Don =E2=80=93 the qc=
ow2
spec doesn=E2=80=99t say to ignore the metadata with data_file_raw=3Don, it=
 just
says that the data read from the qcow2 file must match that read from
the external data file.
(I seem to remember I proposed this before, but I don=E2=80=99t know exactl=
y...)

(In contrast, I don=E2=80=99t think it would be correct to just treat
unallocated clusters as zero whenever data_file_raw=3Don.)

What do you think?  Should we force preallocation with data_file_raw=3Don,
and then just take this patch, even though it still lets users give
backing files to a qcow2 file at runtime without error?  (Except the
backing file wouldn=E2=80=99t have an effect, then.)


--g5M6YifAmPM0VjThXhbEJ7FiLD78Tvf9G--

--mD9dXNkklsdNwPFjyXUM3m4dGCxGUin93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7Xqz8ACgkQ9AfbAGHV
z0CVmAf/eAOMi8itqrw/6Zw6+QA1P3bznHNiV9H1kqQGFGKZCG/ZM5tmde8Vzf1K
BdL2Mt7yJb8SmWTRoVGZ3teElhQOvsBojZWy1Rd6smeGrIjTw4fZfJqWjs+EEpB/
EpxnS/Peg1FDlvW5xhyEkz9926ml0YD3jBX8CCjZtzi/bofkvHuxOSjzF0cyiw1U
eeQXlgX+Y5TOrkoLA2QShI3cfNvcPSjsp/grTWN+TEl34PFtTHiAKH15ortb449X
r8kNryyYivg9kZRcz4ebRFMal0Csnrj8acYqn1ESTdWFDDuLupV+3xEgVBqonW2B
PZMzMd2NvU8RcPniUICJUbWJEV5LZA==
=CDT7
-----END PGP SIGNATURE-----

--mD9dXNkklsdNwPFjyXUM3m4dGCxGUin93--


