Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F92CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDA420719
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhnoVxVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDA420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPuw-0004Jz-7l
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGPuJ-0003TG-Et
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:58:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGPuG-00055c-V4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599757124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CTIpIpP4JsLDwHKMNuR6G4azeR8d6Np+ucHGoMRIZ9w=;
 b=bhnoVxVUHsJEx+OyTY1Mpe3p+8dly0F7bC9Z4lL5Heohk/MJfdfplPhMJpDk04A+9sxYAy
 YPlaDMNJKD7hm6dBcOK//qMyTV5rbu8prsbg4xo4pyLv/bmjR3S/DToFsYVLHtRK+3op1k
 7Iiu1ThvmbUZqQO64kC/8QTM1oVp9Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-gP012_AHM2Gcx0pLWlm-Iw-1; Thu, 10 Sep 2020 12:58:39 -0400
X-MC-Unique: gP012_AHM2Gcx0pLWlm-Iw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73A6C425D7;
 Thu, 10 Sep 2020 16:58:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D59E75121;
 Thu, 10 Sep 2020 16:58:37 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: avoid unaligned read requests during convert
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
References: <20200901125129.6398-1-pl@kamp.de>
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
Message-ID: <ca868c21-eabc-d146-d13c-8ab63a383d50@redhat.com>
Date: Thu, 10 Sep 2020 18:58:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901125129.6398-1-pl@kamp.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mirPiEwXbBZoOWC79MpEuc6qzUP18PnRE"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mirPiEwXbBZoOWC79MpEuc6qzUP18PnRE
Content-Type: multipart/mixed; boundary="AOv0pzprb896Fl7pbJMJaHcXuipVtFjoM"

--AOv0pzprb896Fl7pbJMJaHcXuipVtFjoM
Content-Type: multipart/mixed;
 boundary="------------FE0EA40899F6FC80735D19CB"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FE0EA40899F6FC80735D19CB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.09.20 14:51, Peter Lieven wrote:
> in case of large continous areas that share the same allocation status
> it happens that the value of s->sector_next_status is unaligned to the
> cluster size or even request alignment of the source. Avoid this by
> stripping down the s->sector_next_status position to cluster boundaries.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
>  qemu-img.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

I've just noticed that with this patch, the iotest 251 fails for vhdx.
Would you be OK with squashing this in?

Max

--------------FE0EA40899F6FC80735D19CB
Content-Type: text/plain; charset=UTF-8;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff"

ZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNTEgYi90ZXN0cy9xZW11LWlvdGVzdHMv
MjUxCmluZGV4IDc5MThiYTM1NTkuLjI5NDc3M2JkYzEgMTAwNzU1Ci0tLSBhL3Rlc3RzL3FlbXUt
aW90ZXN0cy8yNTEKKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI1MQpAQCAtNDYsOCArNDYsMTEg
QEAgaWYgWyAiJElNR09QVFNTWU5UQVgiID0gInRydWUiIF07IHRoZW4KICAgICAjIFdlIHVzZSBq
c29uOnt9IGZpbGVuYW1lcyBoZXJlLCBzbyB3ZSBjYW5ub3Qgd29yayB3aXRoIGFkZGl0aW9uYWwg
b3B0aW9ucy4KICAgICBfdW5zdXBwb3J0ZWRfZm10ICRJTUdGTVQKIGVsc2UKLSAgICAjIFdpdGgg
VkRJLCB0aGUgb3V0cHV0IGlzIG9yZGVyZWQgZGlmZmVyZW50bHkuICBKdXN0IGRpc2FibGUgaXQu
Ci0gICAgX3Vuc3VwcG9ydGVkX2ZtdCB2ZGkKKyAgICAjIC0gV2l0aCBWREksIHRoZSBvdXRwdXQg
aXMgb3JkZXJlZCBkaWZmZXJlbnRseS4gIEp1c3QgZGlzYWJsZSBpdC4KKyAgICAjIC0gVkhEWCBo
YXMgbGFyZ2UgY2x1c3RlcnM7IGJlY2F1c2UgcWVtdS1pbWcgY29udmVydCB0cmllcyB0bworICAg
ICMgICBhbGlnbiB0aGUgcmVxdWVzdHMgdG8gdGhlIGNsdXN0ZXIgc2l6ZSwgdGhlIG91dHB1dCBp
cyBvcmRlcmVkCisgICAgIyAgIGRpZmZlcmVudGx5LCBzbyBkaXNhYmxlIGl0LCB0b28uCisgICAg
X3Vuc3VwcG9ydGVkX2ZtdCB2ZGkgdmhkeAogZmkKIAogCg==
--------------FE0EA40899F6FC80735D19CB--

--AOv0pzprb896Fl7pbJMJaHcXuipVtFjoM--

--mirPiEwXbBZoOWC79MpEuc6qzUP18PnRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aWzsACgkQ9AfbAGHV
z0DUBQf9GjCl8SoeFmqieThH8mbo6mrpZ4elpJziIIffhRmIUkcm5B//6zhPouEa
tzJ6WX9kpiTdrgDGNSaRUXyNnIfg8w2iSJNAGHbMSR9E+u3prCb4GOqhTLsX7I1G
kvy5s1HT2JhlE9Fgqkm0c2xk/XTFZ+yiizbUAkvhZnwMl4/fzqDMeh/pujx1Q6Xv
ZX1dbKPRKCxsWaQkD331jg8EgPCLUUY4uu9MdKt4e41M5cZ1az3DwY4cDAVprwJm
9XMgMs+/LrR4YZvGRtCUF9dz3bU0vLbG2qTxGIKBwZw/LAQtoeEQR0tn3wQ2heEX
BwrGvW5YHl47aFORmPkraJjVpjb7ww==
=xjO8
-----END PGP SIGNATURE-----

--mirPiEwXbBZoOWC79MpEuc6qzUP18PnRE--


