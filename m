Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C995C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:28:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C457C20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9SuTItQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C457C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtuwz-0000cf-2q
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtuw0-0008Bv-MD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:27:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48400
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtuvz-0005B2-3M
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594394850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A6IWpjPo9qLDJmODsBkPS5GTwu2482hpOJHBni5JE/s=;
 b=e9SuTItQssP2ozL8eHT5gkTendm4dVzKXK6Cxptvn9JZXB6zaNRPI20L8SFuKn/a+OM8QH
 QrC/bjZ9lbL8h9TsdTy/zeqcMBfdwDyS4PxiaodMIgYuOfXmvh/HNdg0oLJ2GJ9M8nnapN
 SrSXKl3KHfXRcvhgHP0q0Y2MaUkG41c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-jChgojqUN-61WguSqaDqjw-1; Fri, 10 Jul 2020 11:27:28 -0400
X-MC-Unique: jChgojqUN-61WguSqaDqjw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20F2D1932483;
 Fri, 10 Jul 2020 15:27:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D38FF5C1BD;
 Fri, 10 Jul 2020 15:27:25 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <e8aa1eff-ba6c-d8f0-58a6-d7c9ddfe090e@virtuozzo.com>
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
Message-ID: <29c2f784-1ab9-5942-ae20-8a1a2c27b94d@redhat.com>
Date: Fri, 10 Jul 2020 17:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e8aa1eff-ba6c-d8f0-58a6-d7c9ddfe090e@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CMsZ3rCUkZjo7mKtXA7pp3vuovIlsKpzi"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CMsZ3rCUkZjo7mKtXA7pp3vuovIlsKpzi
Content-Type: multipart/mixed; boundary="JfMPYrE8V8CJttHXzLEzsVggArdc63dPr"

--JfMPYrE8V8CJttHXzLEzsVggArdc63dPr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.07.20 17:13, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Because of the (not so recent anymore) changes that make the stream job
>> independent of the base node and instead track the node above it, we
>> have to split that "bottom" node into two cases: The bottom COW node,
>> and the node directly above the base node (which may be an R/W filter
>> or the bottom COW node).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json |=C2=A0 4 +++
>> =C2=A0 block/stream.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 63 +++++++++=
+++++++++++++++++++++++------------
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ++-
>> =C2=A0 3 files changed, 53 insertions(+), 18 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b20332e592..df87855429 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2486,6 +2486,10 @@
>> =C2=A0 # On successful completion the image file is updated to drop the
>> backing file
>> =C2=A0 # and the BLOCK_JOB_COMPLETED event is emitted.
>> =C2=A0 #
>> +# In case @device is a filter node, block-stream modifies the first
>> non-filter
>> +# overlay node below it to point to base's backing node (or NULL if
>> @base was
>=20
> Forgot one thing. To me, it would be more understandable to read
>=20
> "...to point to the base as backing node..." because it may be thought
> as a backing
>=20
> node of the base.

This doesn=E2=80=99t sound like it=E2=80=99s about understandability; =E2=
=80=9Cpoint to the base
as backing node=E2=80=9D and =E2=80=9Cpoint to base=E2=80=99s backing node =
[as backing node]=E2=80=9D
are semantically different.

Was my phrasing just wrong?  @base should be the backing node, so yours
seems correct.

Max


--JfMPYrE8V8CJttHXzLEzsVggArdc63dPr--

--CMsZ3rCUkZjo7mKtXA7pp3vuovIlsKpzi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8IiNwACgkQ9AfbAGHV
z0Ckewf8CG5b+RnC0FeGD26h0CJp0sB5aLbSNKOhpVXuI1KzanIHMtnoi8MHdo6+
Rb6MF2kbsJRL88ByaqWlsd5Uqzkeg0NFmbgFRUK1IfeviYwuX3qfGcQ3QFswUzCV
Np60HiuUGPYwn0xHDqhjLleRYfp/vY56uzYFqk6FfHKi9jg/p8A/g6LYOwdYm6PN
/hx69PYr+JUlnDSXh14XRwfCIThu+tpHSYZncJE9qNIWpwJ93SSX4hl8wMAC1UQR
Kl0a6Ekx/GUIv9cXr3wSWWdXfkf1NRkoacft+V9wxVyZC4cRvpB6LmUor6c7NYL1
KR7BE8fH/2waGJkV9Ra1gbVlMiToaw==
=C5Ts
-----END PGP SIGNATURE-----

--CMsZ3rCUkZjo7mKtXA7pp3vuovIlsKpzi--


