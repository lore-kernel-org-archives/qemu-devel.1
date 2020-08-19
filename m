Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616F3C433E3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30220207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoIhXkiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30220207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Q8a-0003eO-Fz
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 11:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8Q7g-00037H-TE
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:35:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22867
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8Q7e-0001vK-5t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 11:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597851328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DruFG1VEnACEh3qLqxCz0RvmvHON9+gy03dEm0zOkdw=;
 b=OoIhXkiFzphbAS7Vb1MJnrPwRs7kNVlFbbtCdgchoaoqkWxvMrDLp1k2pU1mmCewSW9n6F
 I4QYLV+yVU41xkCPl54xq6Ip3MoEis1n0BS37urR/h3vKEeXBemYSrStQu1e2Glt8EIWqZ
 bwDJh0o6/vVeQ98P2JR3PCweDxJkaDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-P73RA3IXMiCBR-LX2xiZaw-1; Wed, 19 Aug 2020 11:35:26 -0400
X-MC-Unique: P73RA3IXMiCBR-LX2xiZaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 820FB425D6;
 Wed, 19 Aug 2020 15:35:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-120.ams2.redhat.com
 [10.36.113.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 414CF7093C;
 Wed, 19 Aug 2020 15:35:24 +0000 (UTC)
Subject: Re: [PATCH v7 10/47] mirror-top: Support compressed writes
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-11-mreitz@redhat.com>
 <20200818102734.GC6865@linux.fritz.box>
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
Message-ID: <b586341c-4276-eb17-dbcc-c637c5c9d375@redhat.com>
Date: Wed, 19 Aug 2020 17:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818102734.GC6865@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZC0pcH0s56SGNIalODk46d1NfZ2hmGFdc"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZC0pcH0s56SGNIalODk46d1NfZ2hmGFdc
Content-Type: multipart/mixed; boundary="coZsQ656yyszpRryIBAFY7gAWukPabRS7"

--coZsQ656yyszpRryIBAFY7gAWukPabRS7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.08.20 12:27, Kevin Wolf wrote:
> Am 25.06.2020 um 17:21 hat Max Reitz geschrieben:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/mirror.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index e8e8844afc..469acf4600 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1480,6 +1480,15 @@ static int coroutine_fn bdrv_mirror_top_pdiscard(=
BlockDriverState *bs,
>>                                      NULL, 0);
>>  }
>> =20
>> +static int coroutine_fn bdrv_mirror_top_pwritev_compressed(BlockDriverS=
tate *bs,
>> +                                                           uint64_t off=
set,
>> +                                                           uint64_t byt=
es,
>> +                                                           QEMUIOVector=
 *qiov)
>> +{
>> +    return bdrv_mirror_top_pwritev(bs, offset, bytes, qiov,
>> +                                   BDRV_REQ_WRITE_COMPRESSED);
>> +}
>=20
> Hm, not sure if it's a problem, but bdrv_supports_compressed_writes()
> will now return true for mirror-top. However, with an active mirror to a
> target that doesn't support compression, trying to actually do a
> compressed write will always return -ENOTSUP.

Right.

> So I guess the set of nodes patch 7 looks at still isn't quite complete.
> However, it's not obvious how to make it more complete without
> delegating to the driver.
>=20
> Maybe we need to use bs->supported_write_flags, which is set by the
> driver, instead of looking at the presence of callbacks.

Hm, yes, that would work better.  Not sure if it=E2=80=99s worth it for thi=
s series.

The only problem we=E2=80=99d have is late failure when trying to do a
compressed backup to a target that=E2=80=99s running an active mirror.  (La=
te as
in =E2=80=9Cfirst write fails without explanation=E2=80=9D, as opposed to =
=E2=80=9Cjob fails
during set-up=E2=80=9D.)

Which I hope is not a case anyone would ever encounter, and even if they
do, the failure doesn=E2=80=99t seem catastrophic to me.  So I don=E2=80=99=
t think it=E2=80=99s
really a problem.

Max


--coZsQ656yyszpRryIBAFY7gAWukPabRS7--

--ZC0pcH0s56SGNIalODk46d1NfZ2hmGFdc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl89RroACgkQ9AfbAGHV
z0AHNAf/UTOanDwtcV7tT7dUW4n010mYnUX9QuwIOnuGSGU8rn2ckViDzLd6ANuN
W/M8hiLdzDK4VX1PLAE5X2DQDc36DP3Ecd1tS3ZUHRUBb/sFY68/h2y8ioDD5O0a
9cPQJU6v3S3exrQlDWrCqZfribvYCvhlodKYEyeHX+WaLi4foh7pGHWjoTY5TF2C
PugJP5Cn11N5lA/LWuvytl4SXxuZnsZEqQ/v9/k9sUc95XIt76sxhIH07kSuX72B
vCOPI/qQjKIjPZs75OqxOFgV3FKyfxE5ln2Nzz05pGJyb6a5rE/5cTRT0eniBAjO
Sc4hvmR0pb7DbgW4S4HwGpmRevJ0PA==
=l/jC
-----END PGP SIGNATURE-----

--ZC0pcH0s56SGNIalODk46d1NfZ2hmGFdc--


