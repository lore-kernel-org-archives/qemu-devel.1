Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E831C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCA82075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jM4OzgCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCA82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8m1P-0000qO-C4
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8lzr-0007yx-Pc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:56:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8lzq-0004rF-2s
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597935413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IMnX1mOaZJRhZdSb3ITBPSl8BvpA4tcONC88Rp20xUw=;
 b=jM4OzgCn8zeMCXC1620MkW0O5AV7BM9uKckBkzYmSZRrTrBiMm48YQ3GlP94L7In7O0VO1
 3/UV+10AJ8MEJv6Edzd0S8V3nBNoKnPDvF5cDGdAtOPmdgY86K50BVsXfKIgEk1tWSoJTN
 KACWpymL4vsUwZYq8Xt46MsQ8xyP/nY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-QNW8078JPf2tzWYQBGF_Rw-1; Thu, 20 Aug 2020 10:56:49 -0400
X-MC-Unique: QNW8078JPf2tzWYQBGF_Rw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F245F8030A9;
 Thu, 20 Aug 2020 14:56:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D006210027AB;
 Thu, 20 Aug 2020 14:56:45 +0000 (UTC)
Subject: Re: [PATCH v4 2/4] iotests.py: Add wait_for_runstate()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-3-mreitz@redhat.com>
 <753a17ec-af13-326b-1dc8-2d9881c86cd8@redhat.com>
 <20200820142330.GF2664@work-vm>
 <65e2c000-1de9-78f8-5ac0-6f31319e6f46@virtuozzo.com>
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
Message-ID: <0af603ac-82b2-8270-8e7c-3bd56f38fbfb@redhat.com>
Date: Thu, 20 Aug 2020 16:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <65e2c000-1de9-78f8-5ac0-6f31319e6f46@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C2Iq38IcqXmgyYb7PvLJJNemc0TWBGmbd"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C2Iq38IcqXmgyYb7PvLJJNemc0TWBGmbd
Content-Type: multipart/mixed; boundary="DVqG3NgfI6b5yzM4uUTaEzEOZTDFLIY7x"

--DVqG3NgfI6b5yzM4uUTaEzEOZTDFLIY7x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.20 16:34, Vladimir Sementsov-Ogievskiy wrote:
> 20.08.2020 17:23, Dr. David Alan Gilbert wrote:
>> * Eric Blake (eblake@redhat.com) wrote:
>>> On 8/18/20 8:32 AM, Max Reitz wrote:
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 tests/qemu-iotests/iotests.py | 4 ++++
>>>> =C2=A0=C2=A0 1 file changed, 4 insertions(+)
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>>>
>>>> diff --git a/tests/qemu-iotests/iotests.py
>>>> b/tests/qemu-iotests/iotests.py
>>>> index 717b5b652c..ee93cf22db 100644
>>>> --- a/tests/qemu-iotests/iotests.py
>>>> +++ b/tests/qemu-iotests/iotests.py
>>>> @@ -833,6 +833,10 @@ class VM(qtest.QEMUQtestMachine):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'Found node %s un=
der %s (but expected %s)' % \
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (node['name'], pa=
th, expected_node)
>>>> +=C2=A0=C2=A0=C2=A0 def wait_for_runstate(self, runstate: str) -> None=
:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while self.qmp('query-stat=
us')['return']['status'] !=3D
>>>> runstate:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti=
me.sleep(0.2)
>>>
>>> This looks like it could inf-loop if we have a bug where the status
>>> never
>>> changes as expected; but I guess CI bots have timeouts at higher
>>> layers that
>>> would detect if such a bug sneaks in.
>>
>> Although it might be useful to make sure when such a timeout lands, you
>> know which state you thought you were waiting for.
>>
>> Dave
>>
>=20
> Timeout class is defined in iotests.py, so we can simply insert
> something like
>=20
> =C2=A0... , timeout=3D60) -> None:
> =C2=A0 with Timeout(timeout, f"Timeout waiting for '{runstate}' runstate"=
):
> =C2=A0=C2=A0=C2=A0=C2=A0 ...

Actually, I=E2=80=99m not even using this function here in v4 anymore, so t=
his
patch might as well be dropped.

Max


--DVqG3NgfI6b5yzM4uUTaEzEOZTDFLIY7x--

--C2Iq38IcqXmgyYb7PvLJJNemc0TWBGmbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+jywACgkQ9AfbAGHV
z0AggAgAoaqx4c4BxN3R1e0xxkUGfTYuQmWZvi4aENiAsJYpyPi2jRV3lwrCmOQ4
CpVuJDngHvyLZRSkbIwLa6w1xLoeb0o3ZAmsrT3m0R/vS6MVQH07jHHCGQc9d3vW
F/fy9EIlRNKBTxzLmnjkiVacASjVzppO05rc6zuUwET1UUFQTkIOO0n4hIyiJF93
1PQPZfvXF+GmubzRdxM4Z0Rnxr8wTd2TbLZMHxlT0xET7u8YJBbduAM4EMzmuLs+
YaSzlKh9DUW8rNbTTNKHicD+3/lgB62ECD96kZtjXxZG7/fms0z5CAxnKid4WRVb
zhpTWx305RXiNan7VY8SxTWPpT8edg==
=v8aa
-----END PGP SIGNATURE-----

--C2Iq38IcqXmgyYb7PvLJJNemc0TWBGmbd--


