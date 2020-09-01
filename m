Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8B7C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:16:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94B9207D3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpnp7mSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94B9207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD81V-0004kJ-1R
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:16:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7sg-0007wK-Ub
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:07:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48677
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kD7sc-0004B2-VU
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598972845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DjSk/e5SXMdCtxWQeU7ZGcAUJHMwTAmNVplEoQQtlYE=;
 b=dpnp7mSC3t7hfa03oOp9AAg6QcNy4PROnlQ1klbaiA8OJYA/jwKr9ipuPmIZ7VdBAMKb+O
 7tKv8ighD6Ma4HBhpKpLk9ao00NXIPpc5H0fr8Xoji58xlIo3KyTA30Oa0X5k8ik3G/bMv
 v2I2EgbM1eIWkFGRZlRosNmoa+PmPQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-1JMOkRucM0SQq0RJjjHYZA-1; Tue, 01 Sep 2020 11:07:23 -0400
X-MC-Unique: 1JMOkRucM0SQq0RJjjHYZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF3268015A8;
 Tue,  1 Sep 2020 15:07:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-83.ams2.redhat.com
 [10.36.113.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FA619C66;
 Tue,  1 Sep 2020 15:07:16 +0000 (UTC)
Subject: Re: [PATCH v5 00/10] preallocate filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <3a810fb7-eedc-bd54-4319-f1862b5382c0@virtuozzo.com>
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
Message-ID: <1c027e2c-651c-7077-09e3-f94c71c6dde7@redhat.com>
Date: Tue, 1 Sep 2020 17:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3a810fb7-eedc-bd54-4319-f1862b5382c0@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wVzrZ1owYKa5uZaIm51SADd4IX81VQCxR"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wVzrZ1owYKa5uZaIm51SADd4IX81VQCxR
Content-Type: multipart/mixed; boundary="qy7IAreQaHzq0KRNV7YB2ldsD5ACN7OFz"

--qy7IAreQaHzq0KRNV7YB2ldsD5ACN7OFz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.08.20 23:08, Vladimir Sementsov-Ogievskiy wrote:
> 21.08.2020 17:11, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all!
>>
>> Here is a filter, which does preallocation on write.
>>
>> In Virtuozzo we have to deal with some custom distributed storage
>> solution, where allocation is relatively expensive operation. We have to
>> workaround it in Qemu, so here is a new filter.
>=20
> I have a problem now with this thing.
>=20
> We need preallocation. But we don't want to explicitly specify it in all
> the management tools.

Why?

> So it should be inserted by default.

Why?  You mean without any option?  That seems...  Interesting?

(Also like a recipe for reports of performance regression in some cases.)

> It's OK for
> us to keep this default different from upstream... But there are
> problems with the implicitly inserted filter (actually iotests fail and
> I failed to fix them)

I would suspect even if the iotests passed we would end up with a heap
of problems that we would only notice at some later point.  I thought
you too weren=E2=80=99t too fond of the idea of implicit filters.

> 1. I have to set bs->inherits_from for filter and it's child by hand
> after bdrv_replace_node(), otherwise bdrv_check_perm doesn't work.
>=20
> 2. I have to set filter_bs->implicit and teach bdrv_refresh_filename()
> to ignore implicit filters when it checks for drv->bdrv_file_open, to
> avoid appearing of json in backing file names
>=20
> 3. And the real design problem, which seems impossible to fix: reopen is
> broken, just because user is not prepared to the fact that file child is
> a filter, not a file node and has another options, and don't support
> options of file-posix.

Well, what should I say.  I feel like we have made efforts in the past
years to make the block graph fully visible to users and yield the
responsibility of managing it to the users, too, so I=E2=80=99m not surpris=
ed if
a step backwards breaks that.

> And seems all it (and mostly [3]) shows that implicitly inserting the
> filter is near to be impossible..
>=20
> So, what are possible solutions?
>=20
> In virtuozzo7 we have preallocation feature done inside qcow2 driver.
> This is very uncomfortable: we should to handle each possible over-EOF
> write to underlying node (to keep data_end in sync to be able to shrink
> preallocation on close()).. I don't like this way and don't want to port
> it..
>=20
> Another option is implementing preallocation inside file-posix driver.
> Then, instead of BDRV_REQ_NO_WAIT flag I'll need to extend serialising
> requests API (bdrv_make_request_serialising() is already used in
> file-posix.c) to dupport no-wait behavior + expanding the serialising
> request bounds. This option seems feasible, so I'll try this way if no
> other ideas.

Possible, but you haven=E2=80=99t yet explained what the problem with the
management layer inserting the preallocation filter is.

> Filter is obviously the true way: we use generic block layer for native
> request serialising, don't need to catch every write in qcow2 driver,
> don't need to modify any other driver and get a universal thing. But how
> to insert it implicitly (or at least automatically in some cases) and
> avoid all the problems?

I don=E2=80=99t understand why inserting it implicitly is important.

Max


--qy7IAreQaHzq0KRNV7YB2ldsD5ACN7OFz--

--wVzrZ1owYKa5uZaIm51SADd4IX81VQCxR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9OY6IACgkQ9AfbAGHV
z0AMFQgAozEDZeU/1iQR9vtRi3rLSjRcauJEYSlA8Jp5a5VBd9ECEM/sm2PxKTTd
UiuVwk+GTjJAP9u/pNKiofo82zLQPlEMBYugdMaqpBxTrg/Al606GPLteoUBZNYF
jUN5JJnwIfIeRjuMMkzdSmDVgGJH0ovqzW0RDANC2/bosDAyTOPzCiKKpFyGr8jT
wZnVO/sL8oyzrwmMCZzY+5N0dF4ve+GYqs/adtsycWD/A4uGSU0W7AzGAZ2hnZzF
2ylXlUKTs6eqgj3tiWnjpMzZBfy/5Xn+wvXVxjfSki8wW+dqF2gHh/8wZ2VxlySL
gZkQG+AG/tnt42jCoFf2WIYNMFNXng==
=MG6k
-----END PGP SIGNATURE-----

--wVzrZ1owYKa5uZaIm51SADd4IX81VQCxR--


