Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139C1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D150420706
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 12:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inJdV33O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D150420706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kABol-0008Tf-SU
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 08:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kABoD-0007xx-Ik
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:42:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kABoA-00042B-TP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 08:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598272961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i1IDiTltOT09VhMxgWvr2n9rdrEo6HaK4wXnOKXz8w8=;
 b=inJdV33OLNkUCWnUeUGsoxO3EUqk0CnwNYUHrfz+CjCjFNw9VXrPMIZXgXHw0jbOnhOht4
 2Ya8/o81UcOr8wO4AiYI0tVgxaYLgqnGpKhjitc/5I6JkbBX3x1z7vdM0gn+fOJSNF/LQ5
 X0UkTCJza/DqSJIHB9+kWeB9RYeGlwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-FoQGjH61PmCY8yuutg5tMA-1; Mon, 24 Aug 2020 08:42:39 -0400
X-MC-Unique: FoQGjH61PmCY8yuutg5tMA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C9A18A224E;
 Mon, 24 Aug 2020 12:42:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-171.ams2.redhat.com
 [10.36.112.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8CE19C58;
 Mon, 24 Aug 2020 12:42:36 +0000 (UTC)
Subject: Re: [PATCH v7 37/47] qemu-img: Use child access functions
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-38-mreitz@redhat.com>
 <20200821152907.GF5153@linux.fritz.box>
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
Message-ID: <a3c798b3-b120-232f-6881-aaa0f9881979@redhat.com>
Date: Mon, 24 Aug 2020 14:42:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821152907.GF5153@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8wFEKjWyArqNZrzFNWsxcJUTnzlm2isMD"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 03:41:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8wFEKjWyArqNZrzFNWsxcJUTnzlm2isMD
Content-Type: multipart/mixed; boundary="T0n25UWJ36SNQMUR7oZjdhuExHvQjWLp8"

--T0n25UWJ36SNQMUR7oZjdhuExHvQjWLp8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.08.20 17:29, Kevin Wolf wrote:
> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
>> This changes iotest 204's output, because blkdebug on top of a COW node
>> used to make qemu-img map disregard the rest of the backing chain (the
>> backing chain was broken by the filter).  With this patch, the
>> allocation in the base image is reported correctly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
>> @@ -3437,6 +3441,7 @@ static int img_rebase(int argc, char **argv)
>>      uint8_t *buf_old =3D NULL;
>>      uint8_t *buf_new =3D NULL;
>>      BlockDriverState *bs =3D NULL, *prefix_chain_bs =3D NULL;
>> +    BlockDriverState *unfiltered_bs;
>>      char *filename;
>>      const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
>>      int c, flags, src_flags, ret;
>> @@ -3571,6 +3576,8 @@ static int img_rebase(int argc, char **argv)
>>      }
>>      bs =3D blk_bs(blk);
>> =20
>> +    unfiltered_bs =3D bdrv_skip_filters(bs);
>> +
>>      if (out_basefmt !=3D NULL) {
>>          if (bdrv_find_format(out_basefmt) =3D=3D NULL) {
>>              error_report("Invalid format name: '%s'", out_basefmt);
>> @@ -3582,7 +3589,7 @@ static int img_rebase(int argc, char **argv)
>>      /* For safe rebasing we need to compare old and new backing file */
>>      if (!unsafe) {
>>          QDict *options =3D NULL;
>> -        BlockDriverState *base_bs =3D backing_bs(bs);
>> +        BlockDriverState *base_bs =3D bdrv_cow_bs(unfiltered_bs);
>> =20
>>          if (base_bs) {
>>              blk_old_backing =3D blk_new(qemu_get_aio_context(),
>> @@ -3738,8 +3745,9 @@ static int img_rebase(int argc, char **argv)
>>                   * If cluster wasn't changed since prefix_chain, we don=
't need
>>                   * to take action
>>                   */
>> -                ret =3D bdrv_is_allocated_above(backing_bs(bs), prefix_=
chain_bs,
>> -                                              false, offset, n, &n);
>> +                ret =3D bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_=
bs),
>> +                                              prefix_chain_bs, false,
>> +                                              offset, n, &n);
>>                  if (ret < 0) {
>>                      error_report("error while reading image metadata: %=
s",
>>                                   strerror(-ret));
>=20
> img_rebase() has these additional calls:
>=20
>     /* If the cluster is allocated, we don't need to take action */
>     ret =3D bdrv_is_allocated(bs, offset, n, &n);
>=20
> And:
>=20
>     if (out_baseimg && *out_baseimg) {
>         ret =3D bdrv_change_backing_file(bs, out_baseimg, out_basefmt);
>     } else {
>         ret =3D bdrv_change_backing_file(bs, NULL, NULL);
>     }
>=20
> Shouldn't they use unfiltered_bs?

Oh, yes, the second one definitely.

As for the first one, I don=E2=80=99t think there=E2=80=99s a difference.  =
But why not,
we really want to query unfiltered_bs, so it=E2=80=99s better to do so
explicitly than through the implicit fall-through behavior of block_status.

Max


--T0n25UWJ36SNQMUR7oZjdhuExHvQjWLp8--

--8wFEKjWyArqNZrzFNWsxcJUTnzlm2isMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9DtboACgkQ9AfbAGHV
z0CrlggAiC6dFWSWcIbbB3oXN2FNZJnlJzgS2PsprRT0nNpr+XXO+t/MgaHp0R/j
MU/YgRQ5GnpEd5vWG8/TNLmrwT5OycmqK0+FtfoWTsxC7bpPTVuAex/Qvbf3w+RT
XfbIA5aGAnfQ7py125GidJEcKqrF2+lrpEQIk0hCS/6pKmFu9SxdHw+OR0jcrdZ7
yMlxUrgWMwm9pISltD7OSgO/3xWORIUtkttN476IWikRG5/i7wvQelf/PN5pCn6F
yCazlFYM1F0LjVa0AWMx/mi5Robv+kavYG8+3ft0C/hoJou6wpbDQpoKZAwAUfCC
V94aVwypulBKdzlTbmJbc3VMOcPLgw==
=fie8
-----END PGP SIGNATURE-----

--8wFEKjWyArqNZrzFNWsxcJUTnzlm2isMD--


