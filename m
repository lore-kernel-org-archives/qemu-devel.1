Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C201C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F68A206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YA/N03dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F68A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juufx-00056M-Js
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1juufN-0004ca-5S
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:22:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59548
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1juufL-0005aQ-Mx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594632146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=I3j4hn+zPLNhAllBpg8PZOOXyW1pDeS0TKh9JA3Q8tQ=;
 b=YA/N03dmkmrdE5oPeouA1SHIbEzkf58gs0OznW0T5GxXJEav7fc4pBb3Ha+sAH78ml1gFl
 Xu0ljCJivKLmPfXT7ch9+0uO2UxMiGW7ex2b7Xb+RN9ejR1/fKpeUeN4AdlDLHEvbzFoJ+
 UyKdH+jjEFxXHX3r47u1+/NTfWEbKFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-3G8QMWUaPCi_rewopwxqog-1; Mon, 13 Jul 2020 05:22:24 -0400
X-MC-Unique: 3G8QMWUaPCi_rewopwxqog-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 940628027F6;
 Mon, 13 Jul 2020 09:22:23 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-8.ams2.redhat.com
 [10.36.113.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E1AE27DE92;
 Mon, 13 Jul 2020 09:22:18 +0000 (UTC)
Subject: Re: [PATCH v6 01/10] qemu-img: Flush stdout before before potential
 stderr messages
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200706203954.341758-1-eblake@redhat.com>
 <20200706203954.341758-2-eblake@redhat.com>
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
Message-ID: <f7e74b02-140e-4aa1-0b1d-ae58d97c0efa@redhat.com>
Date: Mon, 13 Jul 2020 11:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706203954.341758-2-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VP8i3NQ273D13LHDhrBFmDB28lkqzAfVj"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: kwolf@redhat.com, libvir-list@redhat.com, pkrempa@redhat.com,
 qemu-block@nongnu.org, kchamart@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VP8i3NQ273D13LHDhrBFmDB28lkqzAfVj
Content-Type: multipart/mixed; boundary="3ZElYTPGbkxVyns7z0Z1o6kIICzCMVcfz"

--3ZElYTPGbkxVyns7z0Z1o6kIICzCMVcfz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.07.20 22:39, Eric Blake wrote:
> During 'qemu-img create ... 2>&1', if --quiet is not in force, we can
> end up with buffered I/O in stdout that was produced before failure,
> but which appears in output after failure.  This is confusing; the fix
> is to flush stdout prior to attempting anything that might produce an
> error message.  Several iotests demonstrate the resulting ordering
> change now that the merged outputs now reflect chronology.  (An even
> better fix would be to avoid printf from within block.c altogether,
> but that's much more invasive...)
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                    | 1 +
>  tests/qemu-iotests/049.out | 8 ++++----
>  tests/qemu-iotests/054.out | 2 +-
>  tests/qemu-iotests/079.out | 2 +-
>  tests/qemu-iotests/112.out | 4 ++--
>  tests/qemu-iotests/259.out | 2 +-
>  6 files changed, 10 insertions(+), 9 deletions(-)

282 also needs some treatment.

Max


--3ZElYTPGbkxVyns7z0Z1o6kIICzCMVcfz--

--VP8i3NQ273D13LHDhrBFmDB28lkqzAfVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8MJ8kACgkQ9AfbAGHV
z0DqQgf9H8LZ7TwexNn7JnBtdvF7+0eyl5xUUhKhv55K2f8ZjOws3Te+FvBUEzs1
Z7ysV9Rg761u+Qe5fWXpT6TBtDkDRdB5ME/ZUf8J/8+sOCiDh1RP7cDi4FUp7lyW
kd7Eg5wBZ3jtf2VTvDvJ4bnd2uUsH028IN42FiFjRQ8QGF/i6cb8sF73PeJ3L5fK
QenbHZs79Kf7wiwRxH2NKsTa8K3gMz5PDiIzFZFG4nS+immeV841mY1Y0JGnKW37
cht5fKxG/3VgKOnr1kjOuEbEZ/KRaeQTU8HQCtAw1eCasXPlgzYqk+g1xYw2Jx/q
GaInYSu7/AL3rSGFe/pva0qpzcE+lA==
=wIJK
-----END PGP SIGNATURE-----

--VP8i3NQ273D13LHDhrBFmDB28lkqzAfVj--


