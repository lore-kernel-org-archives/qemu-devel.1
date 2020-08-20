Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE32054F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1u703lK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEE32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8izi-0002V2-89
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8izA-00020K-SI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:44:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54978
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8iz8-0003xh-CY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597923836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zIMxa/krUz8APclTTJ8AIGIyYGRX8zIYy6yc1EchuMI=;
 b=g1u703lKmzD7aV9cYdktVz+6RxjLwbVHBJcdF+jKbB1FDTcXjOHbQkh5ZNstMsFSuodjgp
 ZFKgzEPF2K4nCP+leU9cvHjDfgDsdGrsiDJWraCzcJvUb9Vc6KRoFa6e9bHQt1vTzgwZ52
 t2EQ3IRQiNVrbOXC8PkxlPjlijYI2k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-tCSHQboRPIKLH0lW4o0bhQ-1; Thu, 20 Aug 2020 07:43:54 -0400
X-MC-Unique: tCSHQboRPIKLH0lW4o0bhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26C648030C0;
 Thu, 20 Aug 2020 11:43:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 288C67B8F4;
 Thu, 20 Aug 2020 11:43:51 +0000 (UTC)
Subject: Re: [PATCH v7 14/47] stream: Deal with filters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-15-mreitz@redhat.com>
 <20200818142851.GD6865@linux.fritz.box>
 <59fe8d64-b073-aeff-1afb-b526e9a085f1@redhat.com>
 <20200819151625.GF10272@linux.fritz.box>
 <d3ba4a10-9abb-742b-9a5f-33282f9f9fc2@redhat.com>
 <e424496d-cf18-c19b-3418-7c50bd58c8df@redhat.com>
 <e543223d-0110-a846-db45-d0a5982a3699@virtuozzo.com>
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
Message-ID: <707f0e00-f1ec-a5d6-87ce-972db7f06d77@redhat.com>
Date: Thu, 20 Aug 2020 13:43:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e543223d-0110-a846-db45-d0a5982a3699@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pr1feb8hSSOmjn87yFZut3ZFOxO5FI6mE"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pr1feb8hSSOmjn87yFZut3ZFOxO5FI6mE
Content-Type: multipart/mixed; boundary="410qqB5IwFluG6QTsgQVgUZkm4Lw95FUJ"

--410qqB5IwFluG6QTsgQVgUZkm4Lw95FUJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.20 12:49, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2020 12:22, Max Reitz wrote:
>> On 20.08.20 10:31, Max Reitz wrote:
>>
>> [...]
>>
>>> So all in all, I believe the biggest surprise about what=E2=80=99s writ=
ten into
>>> the top layer isn=E2=80=99t that it may be a json:{} filename, but the =
filename
>>> of a node that maybe doesn=E2=80=99t even exist anymore?=C2=A0 (Oh, no,=
 please don=E2=80=99t
>>> tell me you can delete it and get an invalid pointer read...)
>>
>> (I tried triggering that, but, oh, it=E2=80=99s strdup=E2=80=99ed() in s=
tream_start().
>> I=E2=80=99m a bit daft.)
>>
>=20
>=20
> If it's broken anyway, probably we can just revert c624b015bf and start
> to freeze base again?

Well, it=E2=80=99s only broken if you care about the backing filename strin=
g
that=E2=80=99s written to @top.  So it isn=E2=80=99t broken altogether.

Though, well.  If we all agree to just revert it and maybe add a @bottom
parameter instead, then I suppose we could do it.

(Maybe in a follow-up, though.)

Max


--410qqB5IwFluG6QTsgQVgUZkm4Lw95FUJ--

--Pr1feb8hSSOmjn87yFZut3ZFOxO5FI6mE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+YfYACgkQ9AfbAGHV
z0BTugf/WkxLaujCZStFIMTvDA4OuLVIOqRqBw6fcpV+qBbJYQpqbkpGc8Yarjp5
6uY1Fl9sRwIHAmYsk8ZUbz6sOdHdvhtS4B0q8b+EHHtpVpXn8/IhuOgcA/pkQWjs
2pr0yonbxJ2HWRtkjCpVeeTrOgXhGlmYAP8SuByNal7vxsc0YJg+TjGh1t3iCP3q
puxERlyHh3clr11x+nhAoVp7yfjZD+sjdoIJ/RZKQ22dIQrL37BaRGXb29JPbQ85
rG0kahp21LoMr22jNQikAlacYSnlaie3Y8CPkfhHXuY6Ju9gSoz0cUetwTDE2ShY
dvRvaTw5oFrJGhtsjq3m5ROKvQlw1w==
=YrMl
-----END PGP SIGNATURE-----

--Pr1feb8hSSOmjn87yFZut3ZFOxO5FI6mE--


