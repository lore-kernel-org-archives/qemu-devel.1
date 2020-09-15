Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25E2C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 600392080C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9l9RFro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 600392080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5JV-00011I-IO
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI5Ie-0000T5-BL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:22:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36889
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI5Ic-0003v7-IV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600154565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9dDR/ccingGWGx7eG48cWsT8qIw2UIsTuZ97epINvco=;
 b=U9l9RFro1rqWgMX7bpLvN291czuYY5yHHReF5TMqhYIfmasRZ98WxpE/q3IcxzWtrAA+i/
 Z+eJRWvgrXGyhtdGJrpll6KNpTipOtrEOP16LAkQYW94EZU0YOS7L2xgI/51aI1edZM6yF
 YiceIVEJn7mLvW5rvVbrDwtnpzbbUYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-_C2LzLibNNeHBggELV4_NQ-1; Tue, 15 Sep 2020 03:22:37 -0400
X-MC-Unique: _C2LzLibNNeHBggELV4_NQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DAD257050;
 Tue, 15 Sep 2020 07:22:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-7.ams2.redhat.com
 [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9267E7839F;
 Tue, 15 Sep 2020 07:22:35 +0000 (UTC)
Subject: Re: [PATCH 0/2] Make preallocate_co() resize the image to the correct
 size
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1599833007.git.berto@igalia.com>
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
Message-ID: <5d79dd2a-d5e9-2bf7-e308-bac199887d9d@redhat.com>
Date: Tue, 15 Sep 2020 09:22:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1599833007.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="98VeuuZqVABbuv2Uj2n2WGzaTxhmtbioz"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
--98VeuuZqVABbuv2Uj2n2WGzaTxhmtbioz
Content-Type: multipart/mixed; boundary="IdFf9vqB03LCxph9iVtF5JKvFOrcLTTxT"

--IdFf9vqB03LCxph9iVtF5JKvFOrcLTTxT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.09.20 16:09, Alberto Garcia wrote:
> preallocate_co() does not resize the image correctly if the original
> size was not cluster-aligned.
>=20
> This series should be applied on top of Max's block branch (I tested
> it with commit 8e66c829eda997dad661d49d73668b1fd3e6043d).
>=20
>    https://git.xanclic.moe/XanClic/qemu/commits/branch/block
>=20
> Alberto Garcia (2):
>   qcow2: Make preallocate_co() resize the image to the correct size
>   qcow2: Convert qcow2_alloc_cluster_offset() into
>     qcow2_alloc_host_offset()
>=20
>  block/qcow2.h              |  6 +++---
>  block/qcow2-cluster.c      | 14 +++++++++----
>  block/qcow2.c              | 35 +++++++++++++--------------------
>  tests/qemu-iotests/125     | 40 +++++++++++++++++++++-----------------
>  tests/qemu-iotests/125.out | 28 ++++++++++++++++++++++++--
>  5 files changed, 74 insertions(+), 49 deletions(-)

Thanks, applied to my block branch.

Max


--IdFf9vqB03LCxph9iVtF5JKvFOrcLTTxT--

--98VeuuZqVABbuv2Uj2n2WGzaTxhmtbioz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9ga7oACgkQ9AfbAGHV
z0B6zggAiIp0hYYxUwVe6ijhazZdiE1rAuwnnkgJQxHXvwRrrpi93N3KEjU5kTBy
H3eNF0SDX9AMxoSmGFKxwTREsxpo9doXBxBge7cv6MR0fzdQssGmhZlQef0x4hvh
8EZ+UtN/aokAa16Q5Zt/Mxqom4LkmRBMHeXj/xdCE81Ru1Yl3kYYCqDZhpq5VQN0
R/eM9zDPcRijjjAbGGDdmpStzYNedNNXAA9i7doWsELrJXtVea0ExSVLy2l115E+
dXNqZvf3VjSgnGnljO0D5xswndOisNJvG7inNI+ZDHNUkQDr8UGuos7Dmhq1lg9X
safSW36SOWe5wdj5LuGcAz+pX60VNQ==
=MDep
-----END PGP SIGNATURE-----

--98VeuuZqVABbuv2Uj2n2WGzaTxhmtbioz--


