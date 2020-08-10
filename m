Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D57C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:16:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C211D2075F
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecMQbGjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211D2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59XS-0006sC-Vy
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k59WV-0006Lb-1Q
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:15:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21680
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k59WT-0005Sq-1i
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597072535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DbNUdx9eYu9POaljrB5yXvmiEkwwO/vbYcz0pUqPafc=;
 b=ecMQbGjpKSOxru6IICLXfcIEULmZbP5w1wttCOGr1lhu3Ifvl+pDK2+VsKIWmdx3/ta1QO
 lyhbDGVS75T56m+x8muilBOUIN0dFCrjVhYmnwXaWyDD8gC6S7Lgk+pHvzKMdBxgIewHps
 FZtjvMYbJz6KmbJI18NPSK2uZnJ0gOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-35JMEEwQMJKmxNa4bx2hEQ-1; Mon, 10 Aug 2020 11:15:30 -0400
X-MC-Unique: 35JMEEwQMJKmxNa4bx2hEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 865468064B7;
 Mon, 10 Aug 2020 15:15:29 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-36.ams2.redhat.com
 [10.36.113.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B97C18A6D;
 Mon, 10 Aug 2020 15:15:28 +0000 (UTC)
Subject: Re: [PATCH for-5.1 v2 1/2] block/block-copy: always align copied
 region to cluster size
To: Stefan Reiter <s.reiter@proxmox.com>, qemu-block@nongnu.org
References: <20200810095523.15071-1-s.reiter@proxmox.com>
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
Message-ID: <8fd06678-0f68-0cfc-b15a-c793f8f231cd@redhat.com>
Date: Mon, 10 Aug 2020 17:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810095523.15071-1-s.reiter@proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0tYVUDluKI9Rg48WJiYCkAOCuSKRiGwuc"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:13:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0tYVUDluKI9Rg48WJiYCkAOCuSKRiGwuc
Content-Type: multipart/mixed; boundary="hW4BzBJkmrzgXGtHgVEaAdKjgakzhvXgP"

--hW4BzBJkmrzgXGtHgVEaAdKjgakzhvXgP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.08.20 11:55, Stefan Reiter wrote:
> Since commit 42ac214406e0 (block/block-copy: refactor task creation)
> block_copy_task_create calculates the area to be copied via
> bdrv_dirty_bitmap_next_dirty_area, but that can return an unaligned byte
> count if the image's last cluster end is not aligned to the bitmap's
> granularity.
>=20
> Always ALIGN_UP the resulting bytes value to satisfy block_copy_do_copy,
> which requires the 'bytes' parameter to be aligned to cluster size.
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
> ---
>=20
> I've now marked it for-5.1 since it is just a fix, but it's probably okay=
 if
> done later as well.

42ac214406e0 wasn=E2=80=99t in 5.0, so this would be a regression if we don=
=E2=80=99t
get it in 5.1.  I suppose this is an edge case, because most images
should be aligned to the cluster size, but I think objectively this is
something for 5.1.

So I=E2=80=99ll apply this series to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

And I think I=E2=80=99m going to send a pull request tomorrow morning.  I s=
ee
there=E2=80=99s another patch for 5.1 on the list, so it should be OK.

If you want me to act on any of the suggestions I gave on your test,
feel free to say so and I=E2=80=99ll handle those that make sense to you (l=
ike,
I hope the s/4097/4096/ thing perhaps).

Thanks for finding and fixing this!

Max


--hW4BzBJkmrzgXGtHgVEaAdKjgakzhvXgP--

--0tYVUDluKI9Rg48WJiYCkAOCuSKRiGwuc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8xZI4ACgkQ9AfbAGHV
z0C4WQf8D1owg1jn4eBwtzq8cRB7KK3F3vrwPuJ9sLE6h9iTtxJ2kYrWFQypM65U
C7nqzKmRj+6tTi2IVkobWY+i5kmoTV4n9/hp2PRAhiEL4OJ8VDbiKVCEBByT+Ks6
e0MJH7wv/Y/SG5LiFDPYegv0G/olzn0XqI/4h4seEDv+g/6Bycd+n2vWUlSQRsZf
htTmozAZTGyNB+rZmOKb8lvJ7LHooYChr8m2wjhb4FWJyVNVeh8eFVxjF4oaZ3v/
zDzNu9IMJ9fEU7R5hz/WF2W1ztjkuSUXe3i/G7s8zVAZo6wIMygp9MTC18pCrrFO
aGRcSnursmJr8PoDRW3AueGJaMJSaw==
=P0EB
-----END PGP SIGNATURE-----

--0tYVUDluKI9Rg48WJiYCkAOCuSKRiGwuc--


