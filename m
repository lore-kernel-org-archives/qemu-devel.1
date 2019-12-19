Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D7AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D9F621D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBpdOkx7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9F621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihtAO-0001dQ-6j
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:36:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iht9I-0000vo-QU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iht9H-0006SQ-NM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:35:16 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iht9H-0006PF-EP
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576751715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rBbHYGOcmiQJwG8n8IHsWLvLPderYiA8yx5NLzqb7cQ=;
 b=UBpdOkx7+HhPtWL6YgP9HefPS3dwCev3H4/72jc3YrYxWnNLsO9XG21/u3uqsROmpaHs9w
 Da0mgWyLnEs3jGVScnKKGpVVnbbyH/xNVlXuBMUUbS68P6Y6rtgWl6zFbW4WLDD0HVwE2v
 S3Jr/vVeJYysplUkzFgBgI4GF/9mMys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Swm7U2SYO4ef59b6bPNVHA-1; Thu, 19 Dec 2019 05:35:07 -0500
X-MC-Unique: Swm7U2SYO4ef59b6bPNVHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5EEBDBE6;
 Thu, 19 Dec 2019 10:35:06 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-138.brq.redhat.com
 [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BAE826E51;
 Thu, 19 Dec 2019 10:35:05 +0000 (UTC)
Subject: Re: qcow2 api not secured by mutex lock
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <1ea7f93d-8f48-d565-70e7-0d66f1b80c1e@virtuozzo.com>
 <20191219100230.GC5230@linux.fritz.box>
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
Message-ID: <28355f81-2eb3-4883-f05d-03e4fde4f74b@redhat.com>
Date: Thu, 19 Dec 2019 11:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219100230.GC5230@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WzrAwVn4TqVExdVo05aVoZ7NcaTnYPj13"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WzrAwVn4TqVExdVo05aVoZ7NcaTnYPj13
Content-Type: multipart/mixed; boundary="AxAsqKSFB4N4VUEFNZPN8YTHhDoLPwZOA"

--AxAsqKSFB4N4VUEFNZPN8YTHhDoLPwZOA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 11:02, Kevin Wolf wrote:
> Am 18.12.2019 um 11:28 hat Vladimir Sementsov-Ogievskiy geschrieben:

[...]

>> qcow2_write_snapshots actually called unlocked from
>> qcow2_check_fix_snapshot_table.. It seems unsafe.
>=20
> This is curious, I'm not sure why you would drop the lock there. Max?
>=20
> bdrv_flush() calls would have to replaced with qcow2_write_caches() to
> avoid a deadlock, but otherwise I don't see why we would want to drop
> the lock.
>=20
> Of course, this should only be called from qemu-img check, so in
> practice it's probably not a bug.

Maybe I should have read all of this before replying...  Is
qcow2_write_caches() all that we want?  I mean, bdrv_flush() also
flushes the children (well, at least the file child right now).

OTOH qcow2_write_snapshots() probably does not need to take care of
actually flushing @bs, does it?

Max


--AxAsqKSFB4N4VUEFNZPN8YTHhDoLPwZOA--

--WzrAwVn4TqVExdVo05aVoZ7NcaTnYPj13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl37UlcACgkQ9AfbAGHV
z0Au0AgAoRE1DBw90xG9JJiTlJmxVNWbyTa+AMClW0IkT1oGOFMFD/AJ9Q+b7vTK
28ZiX1hTgixCmCoh7+EwMBUBbghKC3YRuJ8FExQmazoXPMq6Ne4ZLymOzfG6PN89
rR6d9t2jCCbfTglxY7J8J6HCXe4snGy+1UYHpMp84q7HCWJgonznntS/ftjIIYUn
9yF3ZLxo3gIINZxaBcXDbyDI+1Clh4k9GZpEamnK0yzA8zpfcLp/K1wseQAM1NAn
uLJ2NAJ+BkJWQzm4ROurCjUcnt5g3kiz/HbRcnulnxgqPpFaJEzctuHamGAadFfg
T3DOFkCZlnJPfcWK3neTIw4PEluVeg==
=pEN1
-----END PGP SIGNATURE-----

--WzrAwVn4TqVExdVo05aVoZ7NcaTnYPj13--


