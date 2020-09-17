Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47EEC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112D9206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZvmKa8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112D9206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIueW-0007Ig-Qr
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIuP1-0004bP-V9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIuOy-00007R-Pw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600351004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4818CxCjiwhdz5zVab9qnC9Jda5Li4EiBm6/bb8+Mac=;
 b=ZZvmKa8ja7K6r1WD3Ug8d5X0vsGPyqQy2SQfHvancFLZdHhgH8wHgyIfSJkiM6tDir643m
 IinsWuO50picMTC9GAWqtJOcsaJt58djzzoB9cxv7ztXlmEFXoKtKDHN1jP6K7hwIgvf/z
 u2DB+I6uueiHVcpBearvdvdnqiFMW94=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-kSdSrYhBPP-FU0kE0aSb7w-1; Thu, 17 Sep 2020 09:56:40 -0400
X-MC-Unique: kSdSrYhBPP-FU0kE0aSb7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29ECF6408A;
 Thu, 17 Sep 2020 13:56:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-65.ams2.redhat.com
 [10.36.113.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3EB5DA30;
 Thu, 17 Sep 2020 13:56:34 +0000 (UTC)
Subject: Re: [PATCH 2/3] block: add logging facility for long standing IO
 requests
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20200810101447.7380-1-den@openvz.org>
 <20200810101447.7380-3-den@openvz.org>
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
Message-ID: <1971fbff-b255-d0c1-bc07-553242512bcd@redhat.com>
Date: Thu, 17 Sep 2020 15:56:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810101447.7380-3-den@openvz.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LxeLl1op6K7MwPHl8fIwgtcx3PqkNoCeR"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxeLl1op6K7MwPHl8fIwgtcx3PqkNoCeR
Content-Type: multipart/mixed; boundary="nZzs2Y0w1MjLwJz4r3gIByLYdMblVnZz4"

--nZzs2Y0w1MjLwJz4r3gIByLYdMblVnZz4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.20 12:14, Denis V. Lunev wrote:
> There are severe delays with IO requests processing if QEMU is running in
> virtual machine or over software defined storage. Such delays potentially
> results in unpredictable guest behavior. For example, guests over IDE or
> SATA drive could remount filesystem read-only if write is performed
> longer than 10 seconds.
>=20
> Such reports are very complex to process. Some good starting point for th=
is
> seems quite reasonable. This patch provides one. It adds logging of such
> potentially dangerous long IO operations.
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  block/accounting.c         | 59 +++++++++++++++++++++++++++++++++++++-
>  blockdev.c                 |  7 ++++-
>  include/block/accounting.h |  5 +++-
>  3 files changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/accounting.c b/block/accounting.c
> index 8d41c8a83a..24f48c84b8 100644
> --- a/block/accounting.c
> +++ b/block/accounting.c

[...]

> @@ -182,6 +185,58 @@ void block_latency_histograms_clear(BlockAcctStats *=
stats)
>      }
>  }
> =20
> +static const char *block_account_type(enum BlockAcctType type)
> +{
> +    switch (type) {
> +    case BLOCK_ACCT_READ:
> +        return "READ";
> +    case BLOCK_ACCT_WRITE:
> +        return "WRITE";
> +    case BLOCK_ACCT_FLUSH:
> +        return "DISCARD";
> +    case BLOCK_ACCT_UNMAP:
> +        return "TRUNCATE";

I don=E2=80=99t understand how FLUSH translates to DISCARD, and UNMAP to TR=
UNCATE.

> +    case BLOCK_ACCT_NONE:
> +        return "NONE";
> +    case BLOCK_MAX_IOTYPE:
> +        break;
> +    }
> +    return "UNKNOWN";
> +}
> +
> +static void block_acct_report_long(BlockAcctStats *stats,
> +                                   BlockAcctCookie *cookie, int64_t late=
ncy_ns)
> +{
> +    unsigned latency_ms =3D latency_ns / SCALE_MS;
> +    int64_t start_time_host_s;
> +    char buf[64];
> +    struct tm t;
> +    BlockDriverState *bs;
> +
> +    if (cookie->type =3D=3D BLOCK_ACCT_NONE) {
> +        return;
> +    }
> +    if (stats->latency_log_threshold_ms =3D=3D 0) {
> +        return;
> +    }
> +    if (latency_ms < stats->latency_log_threshold_ms) {
> +        return;
> +    }
> +
> +    start_time_host_s =3D cookie->start_time_ns / NANOSECONDS_PER_SECOND=
;
> +    strftime(buf, sizeof(buf), "%m-%d %H:%M:%S",
> +             localtime_r(&start_time_host_s, &t));
> +
> +    bs =3D blk_bs(blk_stats2blk(stats));
> +    qemu_log("long %s[%ld] IO request: %d.03%d since %s.%03d bs: %s(%s, =
%s)\n",
> +             block_account_type(cookie->type), cookie->bytes,
> +             (int)(latency_ms / 1000), (int)(latency_ms % 1000), buf,

Why not just latency_ms * .001f and %.3f?

> +             (int)((cookie->start_time_ns / 1000000) % 1000),

s/1000000/SCALE_MS/? (But I=E2=80=99m not sure whether that=E2=80=99s what =
the SCALE_?S
are for.)

> +             bs =3D=3D NULL ? "unknown" : bdrv_get_node_name(bs),
> +             bs =3D=3D NULL ? "unknown" : bdrv_get_format_name(bs),
> +             bs =3D=3D NULL ? "unknown" : bs->filename);

Now that I=E2=80=99m writing this response already, I wonder whether a QMP =
event
wouldn=E2=80=99t be nice.  (But considering that accounting apparently just
doesn=E2=80=99t with -blockdev, I suppose that=E2=80=99s not that big of a =
worry.)

> +}
> +
>  static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie =
*cookie,
>                                   bool failed)
>  {

[...]

> diff --git a/blockdev.c b/blockdev.c
> index 3848a9c8ab..66158d1292 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -622,7 +622,8 @@ static BlockBackend *blockdev_init(const char *file, =
QDict *bs_opts,
> =20
>          bs->detect_zeroes =3D detect_zeroes;
> =20
> -        block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled);
> +        block_acct_setup(blk_get_stats(blk), account_invalid, account_fa=
iled,
> +                qemu_opt_get_number(opts, "latency-log-threshold", 0));

latency_log_threshold_ms is an unsigned int and so this will silently
overflow for values >=3D 2^32.

(Or for user-specified values < 0, which are wrapped around.)

> =20
>          if (!parse_stats_intervals(blk_get_stats(blk), interval_list, er=
rp)) {
>              blk_unref(blk);
> @@ -3727,6 +3728,10 @@ QemuOptsList qemu_common_drive_opts =3D {
>              .type =3D QEMU_OPT_BOOL,
>              .help =3D "whether to account for failed I/O operations "
>                      "in the statistics",
> +        },{
> +            .name =3D "latency-log-threshold",
> +            .type =3D QEMU_OPT_NUMBER,
> +            .help =3D "threshold for long I/O report (disabled if <=3D0)=
, in ms",

Because of that overflow, negative values will not necessarily disable
reporting, because truncating them to 32 bit may make them small
absolute values again.

In any case, I=E2=80=99d just say =E2=80=9Cdisabled if 0=E2=80=9D, and not =
mention anything
about <0.

Max


--nZzs2Y0w1MjLwJz4r3gIByLYdMblVnZz4--

--LxeLl1op6K7MwPHl8fIwgtcx3PqkNoCeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9jaxEACgkQ9AfbAGHV
z0COywf+NrxiFSSiYBr576iXPPFvcD4+QbXXydeG2ALE3HS8xak4qHkiT37sB5k/
aH1khTqLXMOfwCrV2HNu+d7DHuwaK/1RcRKOdRWk8c5tjw4PtrtkpGtZHEqWdLty
i0ZlWbgiZa+U4wI8kGJnXhsfzbd4T6bOhnb6bW6eFkINebzTA/cVidYLwu4L+qKs
BLW6z7+TH6FdDCh0RRKeMBY1fYQX6mXxXBhHn/zMY2w2OyoK2VZcmjRUW6aF/9OV
8UqGZdrM1vvdlpV50zGOHZJy5wTpuH9ur+3WwzZRtmTPAFMq+P+EHcXOsw2ojn2m
DxIJYgOi86yi9LFtFTqMUTF9WN0/2g==
=eezJ
-----END PGP SIGNATURE-----

--LxeLl1op6K7MwPHl8fIwgtcx3PqkNoCeR--


