Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF90C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648D720707
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpHRX/62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648D720707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAqwU-00022k-K9
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAqvg-0001XS-Dk
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:37:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kAqve-0000Fg-Bq
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598431029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9MxhvbZMpIVsBmGYilfS4WLnJzv7AkSFTma7aODI3dg=;
 b=JpHRX/623Z66nofb6cxsiHcCJwq6UeDO9X/srRLfY55PNjt9jkRbpxyrecMsTb9MJ/BT62
 bK+sHTtKaFf9q6mR2fNdCQZaqjKaqxDsPy7G3ohzN2l3LNOrKdyQpVrjB74eOx0l8PXow0
 GPjLamOM0Wnw3qJHN7js2eipFZEAVlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-1RXlpl3rMb662uSw3VUKDw-1; Wed, 26 Aug 2020 04:37:07 -0400
X-MC-Unique: 1RXlpl3rMb662uSw3VUKDw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FBF805EE3;
 Wed, 26 Aug 2020 08:37:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-172.ams2.redhat.com
 [10.36.112.172])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AF57709D2;
 Wed, 26 Aug 2020 08:37:00 +0000 (UTC)
Subject: Re: [PATCH v5 06/10] block: introduce BDRV_REQ_NO_WAIT flag
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200821141123.28538-1-vsementsov@virtuozzo.com>
 <20200821141123.28538-7-vsementsov@virtuozzo.com>
 <15cbc4e6-2a81-935f-ea26-5e98b80f40c2@redhat.com>
 <dc2c501f-ef45-d6b7-6801-ca0d1a4ec9b6@virtuozzo.com>
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
Message-ID: <7e2240d1-03f8-ae64-5b4b-9f87a3d967fd@redhat.com>
Date: Wed, 26 Aug 2020 10:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <dc2c501f-ef45-d6b7-6801-ca0d1a4ec9b6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WNPMzw5ZJptagO6rvcBoCqcVTtitS8qzX"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.602, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 nsoffer@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNPMzw5ZJptagO6rvcBoCqcVTtitS8qzX
Content-Type: multipart/mixed; boundary="0LMOnj7Ul7BATN6XPslX8Rj7w35QTme5w"

--0LMOnj7Ul7BATN6XPslX8Rj7w35QTme5w
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.08.20 08:26, Vladimir Sementsov-Ogievskiy wrote:
> 25.08.2020 16:10, Max Reitz wrote:
>> On 21.08.20 16:11, Vladimir Sementsov-Ogievskiy wrote:
>>> Add flag to make serialising request no wait: if there are conflicting
>>> requests, just return error immediately. It's will be used in upcoming
>>> preallocate filter.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =C2=A0 include/block/block.h |=C2=A0 9 ++++++++-
>>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 11 ++++++++++-
>>> =C2=A0 2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index b8f4e86e8d..877fda06a4 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -67,8 +67,15 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * written to qiov parameter which =
may be NULL.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_PREFETCH=C2=A0 =3D 0x200,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * If we need to wait for other requests, just=
 fail immediately.
>>> Used
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * only together with BDRV_REQ_SERIALISING.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 BDRV_REQ_NO_WAIT =3D 0x400,
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Mask of valid flags */
>>> -=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x3ff,
>>> +=C2=A0=C2=A0=C2=A0 BDRV_REQ_MASK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x7ff,
>>> =C2=A0 } BdrvRequestFlags;
>>> =C2=A0 =C2=A0 typedef struct BlockSizes {
>>> diff --git a/block/io.c b/block/io.c
>>> index dd28befb08..c93b1e98a3 100644
>>> --- a/block/io.c
>>> +++ b/block/io.c
>>> @@ -1912,9 +1912,18 @@ bdrv_co_write_req_prepare(BdrvChild *child,
>>> int64_t offset, uint64_t bytes,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!(bs->open_flags & BDRV_O_INACTIV=
E));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert((bs->open_flags & BDRV_O_NO_IO) =
=3D=3D 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!(flags & ~BDRV_REQ_MASK));
>>> +=C2=A0=C2=A0=C2=A0 assert(!((flags & BDRV_REQ_NO_WAIT) && !(flags &
>>> BDRV_REQ_SERIALISING)));
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & BDRV_REQ_SERIALISING)=
 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_make_request_serialisi=
ng(req, bdrv_get_cluster_size(bs));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_LOCK_GUARD(&bs->reqs_l=
ock);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tracked_request_set_seriali=
sing(req,
>>> bdrv_get_cluster_size(bs));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((flags & BDRV_REQ_NO_WA=
IT) &&
>>> bdrv_find_conflicting_request(req)) {
>>
>> bdrv_find_conflicting_request() will return NULL even if there are
>> conflicting requests, but those have a non-NULL waiting_for.=C2=A0 Is th=
at
>> something to consider?
>>
>> (I would like to think that will never have a real impact because then
>> we must find some other conflicting request; but isn=E2=80=99t is possib=
le that
>> we find an overlapping request that waits for another request with which
>> it overlaps, but our request does not?)
>>
>=20
> Actually check in bdrv_find_conflicting_request() is the same like in
> the following
> bdrv_wait_serialising_requests_locked(), so, if
> bdrv_find_conflicting_request() returns
> NULL, it means that in bdrv_wait_serialising_requests_locked() it will
> return NULL
> again (as there are no yield points) and we will not wait, so all is OK.

OK.  I thought that maybe we would want to avoid that other requests
might have to wait for the preallocation write.  (Of course, we can=E2=80=
=99t
avoid that altogether, but if we already know of such requests at the
beginning of the request...)

Well, if the only thing to look out for is that preallocation writes
themselves do not wait:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> And, why is it OK to ignore already waiting requests in
> bdrv_wait_serialising_requests_locked(): just because if we proceed now
> with our request,
> these waiting requests will have to wait for us, when they wake and go
> to the next iteration
> of waiting loop.

Sure.


--0LMOnj7Ul7BATN6XPslX8Rj7w35QTme5w--

--WNPMzw5ZJptagO6rvcBoCqcVTtitS8qzX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9GHyoACgkQ9AfbAGHV
z0CnkQf+Pfgc7pUyjk2her2pIudhBav5lArDkNaR96PapARPnWPwf4lO6jKkvBCc
Se70bCKzVA3+UEqB0HVEaaW8luOyEHTdX76PJv8oJcJKrzYm6vClD51DoW6ttXZB
JA4KtvzHCYN5wD0qBQ7WkbjPRI41/KIPsb1kngq9Xo9zWGXKe68Ze2reuUQGa0oX
2OeKbNyk70up2LGeDlXSM/Jpn4+1D/+JZ7H9rSGISmRVx2LNXyZfvj7xaJczAVt6
miN8Mr9nISvq4izIOARB00eY11FbttkSUHgxXM/Gv78ZpSM0D9+uy8HPxNsvxh8J
77kRV81Qs/yu2XHb8tyjtxoNp7aohg==
=S9cB
-----END PGP SIGNATURE-----

--WNPMzw5ZJptagO6rvcBoCqcVTtitS8qzX--


