Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1B9C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2554220756
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaGfsmCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554220756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHngH-0005fM-7Z
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHneq-0004cQ-IB
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kHnem-0000Jb-Sh
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600086747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+u0NM8kN+iQ9xUA+bgn6qY78LI7VqfB+2zLqKhtOfsM=;
 b=IaGfsmCpEWS0szsIrd30vb86QCkIVBgBLFul5BxIEMzN4pyuIsAjZ/5u+dxNyo9eJyM4wF
 8n3li6jgVwzAQbiPZ94R3771oWe2AQER+tKPe0mvqCT2WokBWekGz77HOO42GKBwZ/8ok9
 kcU4HGKVoaaB/z4MjDjb12WPQNz4veo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-KzgbXCMsPMCfv7_cfW452Q-1; Mon, 14 Sep 2020 08:32:25 -0400
X-MC-Unique: KzgbXCMsPMCfv7_cfW452Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 530DBCD040;
 Mon, 14 Sep 2020 12:32:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-80.ams2.redhat.com
 [10.36.114.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B29925C1BB;
 Mon, 14 Sep 2020 12:32:22 +0000 (UTC)
Subject: Re: [PATCH] iotests: Work around failing readlink -f
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200914113809.63640-1-mreitz@redhat.com>
 <CAFEAcA-jN39TufevHy6sng-53NAzqfdm=4NEzGe1Yg+oFzfFQg@mail.gmail.com>
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
Message-ID: <450123b0-e56f-57c1-c42b-2618fcaefc77@redhat.com>
Date: Mon, 14 Sep 2020 14:32:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jN39TufevHy6sng-53NAzqfdm=4NEzGe1Yg+oFzfFQg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HqexrfPjRqGTV75iWwPs2paFb6rXPt12G"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:10:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HqexrfPjRqGTV75iWwPs2paFb6rXPt12G
Content-Type: multipart/mixed; boundary="M9NXYZ1IN51JjwsUgp7666yUyL31LHdrT"

--M9NXYZ1IN51JjwsUgp7666yUyL31LHdrT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.09.20 14:31, Peter Maydell wrote:
> On Mon, 14 Sep 2020 at 12:39, Max Reitz <mreitz@redhat.com> wrote:
>>
>> On macOS, (out of the box) readlink does not have -f.  If the recent
>> "readlink -f" call introduced by b1cbc33a397 fails, just fall back to
>> the old behavior (which means you can run the iotests only from the
>> build tree, but that worked fine for six years, so it should be fine
>> still).
>>
>> Keep any potential error message on stderr.  If users want to run the
>> iotests from outside the build tree, this may point them to what's wrong
>> (with their system).
>>
>> Fixes: b1cbc33a3971b6bb005d5ac3569feae35a71de0f
>>        ("iotests: Allow running from different directory")
>> Reported-by: Claudio Fontana <cfontana@suse.de>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Hi Thomas,
>>
>> I thought this would be quicker than writing a witty response on whether
>> you or me should write this patch. O:)
>> ---
>>  tests/qemu-iotests/check | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>> index e14a1f354d..75675e1a18 100755
>> --- a/tests/qemu-iotests/check
>> +++ b/tests/qemu-iotests/check
>> @@ -45,6 +45,10 @@ then
>>      fi
>>      source_iotests=3D$(cd "$source_iotests"; pwd) || _init_error "faile=
d to enter source tree"
>>      build_iotests=3D$(readlink -f $(dirname "$0"))
>> +    if [ "$?" -ne 0 ]; then
>> +        # Perhaps -f is unsupported, revert to pre-b1cbc33a397 behavior
>> +        build_iotests=3D$PWD
>> +    fi
>>  else
>=20
> This still prints
>   readlink: illegal option -- f
>   usage: readlink [-n] [file ...]
>=20
> (you can see it in the build log that Thomas links to).
>=20
>    build_iotests=3D$(readlink -f $(dirname "$0") 2>/dev/null)
>=20
> should avoid that, I think.

I mentioned in the commit message that I find this useful and desirable
behavior.  Something isn=E2=80=99t working that perhaps users are expecting=
 to
work (because it will work on other systems), so I don=E2=80=99t think the =
error
message should be suppressed.

Max


--M9NXYZ1IN51JjwsUgp7666yUyL31LHdrT--

--HqexrfPjRqGTV75iWwPs2paFb6rXPt12G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9fYtQACgkQ9AfbAGHV
z0CNhQf+Oo+LJx0/GvXUQbBdQxFskcoVRch/7Ozvowcs7DVgSNQmSa00jpTezjqc
gErTMJ5KIKaFdDoLKQq7uqFYBXq9/iOWU84SD5dgDmlAAPpXFslDtK5EsG9gUMEl
dsSrKO26rp67PxGkwjBfYKPsPKOmHs55CfJiry/zhzRXEfOk+2n0PGwyBj7bLd8X
yW9AdMgAiP3SNPd3KpBShJch+7yN5gXUaqDhQf2EWdEEytuKRQ85koWDUSfPCbtm
KXy5/UG8kj4KYoXjJ7DQdCHUuAs9BWqLaAN2u6FoPLk1LAY4cRh0IN0yogqMogd9
78WlloyfUf2k8vmxuF19glHbQd0ylQ==
=Ezfn
-----END PGP SIGNATURE-----

--HqexrfPjRqGTV75iWwPs2paFb6rXPt12G--


