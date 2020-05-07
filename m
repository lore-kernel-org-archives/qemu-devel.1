Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B937C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB933208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 09:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aksqgo24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB933208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWcyB-0006Wg-UK
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 05:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcxc-00062H-1o
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:36:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jWcxb-0007yu-48
 for qemu-devel@nongnu.org; Thu, 07 May 2020 05:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588844214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AHuja6XADl+X51k5NW/6QCBtJCgLMCom4u9zGSqG9Cg=;
 b=Aksqgo24U2oo1HuOExawybkhDn+1GrmkajDzQh048tvZGxO1MkVYZlU4/N96z7L6tQyUUh
 /MRWXYu33a07LRo7flP2XxWirYp0E5t3fMuemRz4E0RX7ydCwFNBLG45edIZ3EKYUUy8Vm
 CdHwciYyaVlSBJmwTWjJyMtrrucqqdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-HCq-bjIYN9qDHxcO8qmrzw-1; Thu, 07 May 2020 05:36:52 -0400
X-MC-Unique: HCq-bjIYN9qDHxcO8qmrzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71400100A8E7;
 Thu,  7 May 2020 09:36:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-92.ams2.redhat.com
 [10.36.114.92])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A36262A43;
 Thu,  7 May 2020 09:36:49 +0000 (UTC)
Subject: Re: [PATCH v3 32/33] block: Pass BdrvChildRole in remaining cases
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-33-mreitz@redhat.com>
 <20200506171315.GJ6333@linux.fritz.box>
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
Message-ID: <1a39d014-e921-3a6c-e540-55724ad77bb1@redhat.com>
Date: Thu, 7 May 2020 11:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506171315.GJ6333@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yxnHcaDU7j4MHWjFZlAtx7N3e5MZSVONr"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
--yxnHcaDU7j4MHWjFZlAtx7N3e5MZSVONr
Content-Type: multipart/mixed; boundary="8X0G3kGdajnMkGEjrTSwkGqOZmpOYLaUG"

--8X0G3kGdajnMkGEjrTSwkGqOZmpOYLaUG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.05.20 19:13, Kevin Wolf wrote:
> Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
>> These calls have no real use for the child role yet, but it will not
>> harm to give one.
>>
>> Notably, the bdrv_root_attach_child() call in blockjob.c is left
>> unmodified because there is not much the generic BlockJob object wants
>> from its children.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index 8f4ff5a97e..d4f4218924 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -3186,7 +3186,7 @@ static int enable_write_target(BlockDriverState *b=
s, Error **errp)
>>      options =3D qdict_new();
>>      qdict_put_str(options, "write-target.driver", "qcow");
>>      s->qcow =3D bdrv_open_child(s->qcow_filename, options, "write-targe=
t", bs,
>> -                              &child_vvfat_qcow, 0, false, errp);
>> +                              &child_vvfat_qcow, BDRV_CHILD_DATA, false=
, errp);
>=20
> Doesn't it contain metadata, too?

Aw, I don=E2=80=99t know...  This is vvfat, I don=E2=80=99t want to know.

Do you mean metadata beyond the filesystem structures?  Are those
structures data or metadata in this context?  Does it even matter?

I suppose I just don=E2=80=99t want to think about all of that, and the sim=
plest
way to do it is to indeed pass METADATA, too.

Max


--8X0G3kGdajnMkGEjrTSwkGqOZmpOYLaUG--

--yxnHcaDU7j4MHWjFZlAtx7N3e5MZSVONr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6z1q8ACgkQ9AfbAGHV
z0CeIwgAoqrDE3H5PT2kzze77rCgAc/gwINEbeHfsTKfqsgEcSz281FedgGGNSvm
b8mtDbKSl10X4GQgboDrapIlmeRrWmIY4QdUbd3ND2I+jFlHeg59mKE0NSxARh03
pBZUkzkg2FDprdSo6UHlqfwuGdWNZh4TE6wE3bWXwUgnM2YZzjhV6BpEwcjojr3r
w/HuNCVmwdr70/+c+b6yZz3r28IvxH6DgOkBJA9WLs1Ql+AP0PCmXNgEc3TLkCeJ
sPFGfo/ZQycsYRonxNzhdslDSOrIS1J+vyZsXRbrSLYu7iLHzpEM8Slpd4LA/JdK
EMfQhgi4GFQKDzpbV8GRy7vNzS8diQ==
=oUf6
-----END PGP SIGNATURE-----

--yxnHcaDU7j4MHWjFZlAtx7N3e5MZSVONr--


