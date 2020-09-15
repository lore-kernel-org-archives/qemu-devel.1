Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1CFC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD1421D7A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DH/E7G5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD1421D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5I6-0008Q4-1v
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI5HA-0007tm-Qp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:21:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI5H9-0003mT-5O
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600154473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OnxteU9i0gmZYxxx/sY+UuBRzXexb+j6uSU3UahEjLU=;
 b=DH/E7G5M9t9YpguJfXYvi/mb/Tbgx+9PBPKsjY8gR1iUwT3Ix3kBLpag4CHh+UDHL5VFr3
 o1NIyWacV8hxZN6y8g5AYSzniPPVtC0SZjYs9qPvo9Bj30qxm3UV2RWYajM/0rMtXml/cf
 UjcLn7V/PzReQz8N+KHXXyi8yU6uVak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-XCK0A_QJO2WtfTU7yXvZ4g-1; Tue, 15 Sep 2020 03:21:09 -0400
X-MC-Unique: XCK0A_QJO2WtfTU7yXvZ4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EAA801ABA;
 Tue, 15 Sep 2020 07:21:08 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-7.ams2.redhat.com
 [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 865DA610F2;
 Tue, 15 Sep 2020 07:21:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] qcow2: Convert qcow2_alloc_cluster_offset() into
 qcow2_alloc_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1599833007.git.berto@igalia.com>
 <9bfef50ec9200d752413be4fc2aeb22a28378817.1599833007.git.berto@igalia.com>
 <1c70b5a7-222c-0fbb-e8c8-c8c0000252fb@redhat.com>
 <w51363ks41j.fsf@maestria.local.igalia.com>
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
Message-ID: <04c2c90e-fbd7-f505-8379-29ad1be6a402@redhat.com>
Date: Tue, 15 Sep 2020 09:21:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <w51363ks41j.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vKDrTNQSb9UbnUSe23UJLq169zwHA0tr5"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
--vKDrTNQSb9UbnUSe23UJLq169zwHA0tr5
Content-Type: multipart/mixed; boundary="JB9TWmRo32NPwuYoek4Uw7Nis6vO4wlZA"

--JB9TWmRo32NPwuYoek4Uw7Nis6vO4wlZA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.09.20 18:42, Alberto Garcia wrote:
> On Mon 14 Sep 2020 02:14:36 PM CEST, Max Reitz wrote:
>=20
>> However, I wonder what you think about =E2=80=9Ccluster_offset=E2=80=9D =
in
>> qcow2_alloc_host_offset.  It isn=E2=80=99t a cluster offset anymore.
>> Can/should we rename it?
>=20
> That variable was not a cluster offset before this patch either (at
> least not during the first iteration of the loop).

Hm, yes.  Doesn=E2=80=99t make it less wrong, but you=E2=80=99re right, the=
re is no
argument why this should be addressed in this patch (or series).

> The difference is that *host_offset is always the offset of the
> beginning of the requested region, and cluster_offset increases with
> every iteration of the loop. Maybe current_offset / current_host_offset?
> I don't know, but I'm fine with changing it if you have a good name.

current_host_offset sounds nice.  But let=E2=80=99s just leave it how it is=
 for now.

Max


--JB9TWmRo32NPwuYoek4Uw7Nis6vO4wlZA--

--vKDrTNQSb9UbnUSe23UJLq169zwHA0tr5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9ga18ACgkQ9AfbAGHV
z0A57Qf/fk4zS4/Xl3v38NHDP60m3gHV7nmXPmhk0arV1hy39YTIu32mTgGHkcMw
y73yzehXy+Et0+HnLeK7Yuy2+X84F8GAsEDJXz5HP6xLGuIc/U0kb5xWkrGVaweC
RCrRm3JPZZqnWwsleuvzR13YkQjbgIr0QY+KU7VQ4rkm3c5e+AKa145O3t0eqFMr
roPxOKnRwkMv+udAN1awXIMpILfoWE5JQP+e4rXeNth7R02UFvBeHsX51frbCkXJ
t7Q4HoedPxCgOOR6QDiVPN+u2nGbihFXKHULiYmjTasrJj5mbk+YEhPpAC+75a6b
oG58VkoIOssAHABCbvUJR6bVJ45Uww==
=vbXZ
-----END PGP SIGNATURE-----

--vKDrTNQSb9UbnUSe23UJLq169zwHA0tr5--


