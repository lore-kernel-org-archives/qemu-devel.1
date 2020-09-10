Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEEE20809
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKJvnFL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEEE20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMiu-0002V2-OX
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGMhu-0001ld-Bd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:33:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGMhr-0000hG-Gh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 09:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599744821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=klLjE0Gw79jeVLmIuNCaFEZxKyAVISEYWj/n1bCY2OI=;
 b=KKJvnFL6NLlEAQpm8u8SZ0cqqjjEPnzNL2DfxDuseDUm4AzjemGC02HXiv2kgN/6prBjp5
 fedQu8RerLYIPgPt6bz0fjT+9OxsMmjLiV6YPq2DHTJkPpIjq5DBTAhqzrWFbdBSu4WthH
 i7SGJd8ZQtBF+oOQeQxdBI5OkD2egVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-70JEpHOmPfuibI1GeSEg5Q-1; Thu, 10 Sep 2020 09:33:39 -0400
X-MC-Unique: 70JEpHOmPfuibI1GeSEg5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 290401882FA1;
 Thu, 10 Sep 2020 13:33:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC3B01002D65;
 Thu, 10 Sep 2020 13:33:36 +0000 (UTC)
Subject: Re: [PATCH 19/29] block/export: Move strong user reference to
 block_exports
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-20-kwolf@redhat.com>
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
Message-ID: <e8e0a9be-2da1-f7f4-6693-5b6faaf6bfd6@redhat.com>
Date: Thu, 10 Sep 2020 15:33:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-20-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nIyKXN6pSqAYCohEi7QHGc49rGd4BqVJf"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:07:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nIyKXN6pSqAYCohEi7QHGc49rGd4BqVJf
Content-Type: multipart/mixed; boundary="7Ajmu8AzIq4KM5739g64c0Q3xGCLHUgGk"

--7Ajmu8AzIq4KM5739g64c0Q3xGCLHUgGk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:20, Kevin Wolf wrote:
> The reference owned by the user/monitor that is created when adding the
> export and dropped when removing it was tied to the 'exports' list in
> nbd/server.c. Every block export will have a user reference, so move it
> to the block export level and tie it to the 'block_exports' list in
> block/export/export.c instead. This is necessary for introducing a QMP
> command for removing exports.
>=20
> Note that exports are present in block_exports even after the user has
> requested shutdown. This is different from NBD's exports where exports
> are immediately removed on a shutdown request, even if they are still in
> the process of shutting down. In order to avoid that the user still
> interacts with an export that is shutting down (and possibly removes it
> a second time), we need to remember if the user actually still owns it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/export.h | 8 ++++++++
>  block/export/export.c  | 6 ++++++
>  blockdev-nbd.c         | 5 -----
>  nbd/server.c           | 2 --
>  4 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

> diff --git a/include/block/export.h b/include/block/export.h
> index cdc6e161ea..4833947e89 100644
> --- a/include/block/export.h
> +++ b/include/block/export.h
> @@ -60,6 +60,14 @@ struct BlockExport {
>       */
>      int refcount;
> =20
> +    /*
> +     * True if one of the references in refcount belongs to the user. Af=
ter the
> +     * user has dropped their reference, they may not e.g. remove the sa=
me
> +     * export a second time (which would decrease the refcount without h=
aving
> +     * it incremented first).

Not sure though whether this (or the request_shutdown documentation)
should mention that request_shutdown drops the user reference.

Max

> +     */
> +    bool user_owned;
> +


--7Ajmu8AzIq4KM5739g64c0Q3xGCLHUgGk--

--nIyKXN6pSqAYCohEi7QHGc49rGd4BqVJf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aKy8ACgkQ9AfbAGHV
z0Cj/wf/ao7rvNtXbsJo3dwyXxbfERgG/8RFu8QCVodF3le4rKGxraDZCV5pk5EB
2Dqn4qUeCMKn5axsk24L10fqboblGO1vU8F00OIWKqWfwjmpv4HrNKRVuA3e4Zcd
ERqzRfqMSa9kEVUiDujF1b+SymVE0ea5pjI8GalBUXpj0VnrMIU9P16Jb0TK4waf
FZqP3WPONO722kpv6rYOSwOtNqv4dj+CfUhsie+X1Oy6xEtsaDISyVcVfIN/PQyo
Vyc8XlBlBmCAW3Z+h8Bv+srLi6sLCroxIOB5ddyNSvZvzzHtxWPc1/9BHPi650p0
Jz6Q9PD7hcVlNSnHtNlpjNe+KVDuzw==
=ABAK
-----END PGP SIGNATURE-----

--nIyKXN6pSqAYCohEi7QHGc49rGd4BqVJf--


