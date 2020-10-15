Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BCFC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD39206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDROrxty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD39206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT6ZS-0007cO-PY
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT6Pf-0005x0-7c
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55449)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kT6Pd-0000oq-Hj
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602780452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zi1qqGieAGNI/EdWl4UpVHHyCS9xYjvSJlcIwm7qrNY=;
 b=CDROrxtyi1pbo+2pHjkR5kgZm8HMA1csuELcMGLfphlxHcz/Xnsd10sy6xNYKy9n32JUl7
 ZHamonodqJJ3zBTQrzeTaPkFTDqTYnDeqVgWuxMzrdo/dK3q5ibq2xQMU47zT2Llk9rrdR
 HsVumVCZbD+o1uKNNjxdUFfAk9KYX/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-ODahlaUcPhCQi5eKiaHoYQ-1; Thu, 15 Oct 2020 12:47:15 -0400
X-MC-Unique: ODahlaUcPhCQi5eKiaHoYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF922876ECF;
 Thu, 15 Oct 2020 16:47:14 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1285D9D5;
 Thu, 15 Oct 2020 16:47:10 +0000 (UTC)
Subject: Re: [PATCH v2 00/20] block/export: Allow exporting BDSs via FUSE
To: Kevin Wolf <kwolf@redhat.com>
References: <20200922104932.46384-1-mreitz@redhat.com>
 <20201015120101.GG4610@merkur.fritz.box>
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
Message-ID: <b5faf1fc-4693-4abe-85e7-3e28b0775eef@redhat.com>
Date: Thu, 15 Oct 2020 18:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015120101.GG4610@merkur.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9k4DmrumRbdzoGN5vYAzVu6jJURmfzUbs"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9k4DmrumRbdzoGN5vYAzVu6jJURmfzUbs
Content-Type: multipart/mixed; boundary="s7BNyaBSAfEGrloEXRO5qgPSjiwLrLNNq"

--s7BNyaBSAfEGrloEXRO5qgPSjiwLrLNNq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.20 14:01, Kevin Wolf wrote:
> Am 22.09.2020 um 12:49 hat Max Reitz geschrieben:
>> Based-on: <20200907182011.521007-1-kwolf@redhat.com>
>>           (=E2=80=9Cblock/export: Add infrastructure and QAPI for block =
exports=E2=80=9D)
>>
>> (Though its patch 16 needs a s/=3D \&blk_exp_nbd/=3D drv/ on top.)
>>
>> v1: https://lists.nongnu.org/archive/html/qemu-block/2019-12/msg00451.ht=
ml
>>
>> Branch: https://github.com/XanClic/qemu.git fuse-exports-v2
>> Branch: https://git.xanclic.moe/XanClic/qemu.git fuse-exports-v2
>>
>>
>> Hi,
>>
>> Ever since I found out that you can mount FUSE filesystems on regular
>> files (not just directories), I had the idea of adding FUSE block
>> exports to qemu where you can export block nodes as raw images.  The
>> best thing is that you=E2=80=99d be able to mount an image on itself, so
>> whatever format it may be in, qemu lets it appear as a raw image (and
>> you can then use regular tools like dd on it).
>>
>> The performance is quite bad so far, but we can always try to improve it
>> if the need arises.  For now I consider it mostly a cute feature to get
>> easy access to the raw contents of image files in any format (without
>> requiring root rights).
>>
>> In this version (as opposed to v1 linked above), I integrated the FUSE
>> export code into Kevin=E2=80=99s proposed common infrastructure for bloc=
k
>> exports.
>=20
> Patches 5-16, 19 and 20:
>=20
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Thanks!

So far, (just FYI,) I=E2=80=99ve tried to address your remarks, gathered th=
em in
a single fat commit, and pushed everything here:

https://github.com/XanClic/qemu/tree/fuse-exports-next

(There=E2=80=99s also something about two bugs in fuse_fallocate(), where t=
here
are these two I/O loops (one for blk_pwrite_zeroes(), one for
blk_pdiscard()), where I both forgot to increment @offset (alongside
decrementing @length).  Oops.)

(And I=E2=80=99ve renamed init_fuse() to init_exports_table(), because that=
 got
really confusing with fuse_init().)

I=E2=80=99ll split that up, squash it into the respective patches, and send=
 v3
when I get back from PTO.

Max


--s7BNyaBSAfEGrloEXRO5qgPSjiwLrLNNq--

--9k4DmrumRbdzoGN5vYAzVu6jJURmfzUbs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+IfQwACgkQ9AfbAGHV
z0BVGggArNojupnWswHKvl9xA+eW+dEW4mQ63zkS4Vf+87AoIprzTmR0qJmVXD3V
H7kDaabbL31RUJ5boeuRMAu2Zxr1La6e6PB0Aom+YvWTWMOPGGcjxPrGljORJd2f
gAvZI98rPv9gysM9snrRG/5QlABR6dc4S1AYOcwpZ7WOGL4SasIOS2DdVQTBjzN5
nEI/QCNy0sYGDtL4uGhBlUsqdgDXpE0lMPKT7q6AbYrAhtT+V3oEKDL65fL2H8JJ
TJyiCsAPGtzFEbAlWcW3fxlNj4VcfybYbXnZa2WN8tZ5aDVoy1990Zh0H9Qc4eIu
Whb6xEW6i8G5XRi6pHpQiBsKioHvcw==
=Royy
-----END PGP SIGNATURE-----

--9k4DmrumRbdzoGN5vYAzVu6jJURmfzUbs--


