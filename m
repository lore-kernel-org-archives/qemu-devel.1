Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A85C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:58:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC5A21771
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 16:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPqcL4l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC5A21771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaN7Q-0007Y9-SS
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 11:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iaMmp-0003RU-Jx
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iaMmo-00066j-30
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:36:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40968
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iaMmn-000630-Qv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 11:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574959017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sDY4EHN/2WjdATAM7Mip7HYiILKqCIGJFYl2PDvEOX4=;
 b=LPqcL4l5g5pXssAhg2s8okJz1fZgLPIYz8jpZYfC0Uq54TYTiBzwP9jCtsb2mXBnRFns8E
 QrlgFlhGx+7aAG6RtUvS/a1x3Zjib99utcOvOc4hmASK6s34kM99ghTCamynfuK0jxXGaD
 KvDQ4Irf/hxffIZppE0VFIoVSdnn+Mo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-yD9JXXQ3OYOA6Wo56npNUA-1; Thu, 28 Nov 2019 11:36:54 -0500
X-MC-Unique: yD9JXXQ3OYOA6Wo56npNUA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FDBA593A1;
 Thu, 28 Nov 2019 16:36:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-182.brq.redhat.com
 [10.40.204.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42B9860BE0;
 Thu, 28 Nov 2019 16:36:52 +0000 (UTC)
Subject: Re: [PATCH for-5.0 02/31] block: Add BdrvChildRole
To: Kevin Wolf <kwolf@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
 <20191127131624.1062403-3-mreitz@redhat.com>
 <20191128141218.GA4944@linux.fritz.box>
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
Message-ID: <42032cd8-c3ed-2eaa-3f11-306f9c16f5f1@redhat.com>
Date: Thu, 28 Nov 2019 17:36:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191128141218.GA4944@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FIiHuhm7X9ygDV4dYdPWlHVPIfCQIuovd"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--FIiHuhm7X9ygDV4dYdPWlHVPIfCQIuovd
Content-Type: multipart/mixed; boundary="xELTjV0fBqxFSbQRXkjZUae19m3VYikQU"

--xELTjV0fBqxFSbQRXkjZUae19m3VYikQU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.11.19 15:12, Kevin Wolf wrote:
> Am 27.11.2019 um 14:15 hat Max Reitz geschrieben:
>> This enum will supplement BdrvChildClass when it comes to what role (or
>> combination of roles) a child takes for its parent.
>>
>> Because empty enums are not allowed, let us just start with it filled.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block.h | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/include/block/block.h b/include/block/block.h
>> index 38963ef203..36817d5689 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -279,6 +279,44 @@ enum {
>>      DEFAULT_PERM_UNCHANGED      =3D BLK_PERM_ALL & ~DEFAULT_PERM_PASSTH=
ROUGH,
>>  };
>> =20
>> +typedef enum BdrvChildRole {
>> +    /*
>> +     * If present, bdrv_replace_node() will not change the node this
>> +     * BdrvChild points to.
>> +     */
>> +    BDRV_CHILD_STAY_AT_NODE =3D (1 << 0),
>> +
>> +    /* Child stores data */
>> +    BDRV_CHILD_DATA         =3D (1 << 1),
>> +
>> +    /* Child stores metadata */
>> +    BDRV_CHILD_METADATA     =3D (1 << 2),
>> +
>> +    /* Filtered child */
>> +    BDRV_CHILD_FILTERED     =3D (1 << 3),
>> +
>> +    /* Child to COW from (backing child) */
>> +    BDRV_CHILD_COW          =3D (1 << 4),
>> +
>> +    /* Child is expected to be a protocol node */
>> +    BDRV_CHILD_PROTOCOL     =3D (1 << 5),
>> +
>> +    /* Child is expected to be a format node */
>> +    BDRV_CHILD_FORMAT       =3D (1 << 6),
>=20
> In theory, a node shouldn't care what other nodes it has as its
> children. For a parent, protocols and formats look exactly the same.
>=20
> Of course, we do have BDRV_O_PROTOCOL, but if I'm not mistaken this is
> basically only about probing or not probing an image format when a
> legacy filename is given rather than BlockdevOptions.
>=20
> Therefore, unless you have a real reason for this to be here, I'd prefer
> if we could keep such legacy flags outside of the core infrastructure if
> at all possible.

Hm.  The reason I have it here is because currently this is handled by
BdrvChildClass.inherit_options.  For filtered and backing children, that
will leave PROTOCOL as it is; for the file child of format nodes it will
set PROTOCOL; and for some children (blkverify and quorum) it will clear
PROTOCOL.

So without these flags here, we can=E2=80=99t unify child_file, child_forma=
t,
and child_backing in a single class, just because they bequeath the
PROTOCOL flag differently.  At least not directly.

(I=E2=80=99d like to note that this doesn=E2=80=99t make anything worse.  R=
ight now,
drivers need to make a conscious choice on this flag, too, namely by
choosing the right BdrvChildClass.)

Hmm.  Can we do better?  Instead of the driver hinting at what they
expect from the child, can we somehow infer that automatically in
block.c (i.e., in inherit_options without it being given PROTOCOL or
FORMAT)?  FILTERED || COW always means keeping it as-is.  METADATA
generally means setting PROTOCOL, I suppose.

The two problems that come to my mind are blkverify and quorum.
blkverify is special: It must enforce format-probing on the test image,
and it must disable format-probing on the verification (the raw) image.

Quorum wants format probing on everything, but all its children are
simply DATA children.  Other DATA children are e.g. external data files
of qcow2, and we certainly want to force-disable format probing there.

I suppose for the quorum problem we could introduce a
BlockDriver.is_format flag that would force O_PROTOCOL for all non-COW
children, but we would unset O_PROTOCOL for DATA children of
non-is_format drivers.

I suppose the same could work for blkverify=E2=80=99s test image.  For its =
raw
image, we=E2=80=99d probably just have to enforce the raw driver (or rely o=
n the
fact that blkverify is technically a protocol driver in a way (it
implements .bdrv_file_open...), so it will always have O_PROTOCOL set on
itself; thus, its filtered child (the raw child) will automatically have
it, too, as long as we don=E2=80=99t touch it).

Do you have a better idea?

>> +    /*
>> +     * The primary child.  For most drivers, this is the child whose
>> +     * filename applies best to the parent node.
>> +     */
>> +    BDRV_CHILD_PRIMARY      =3D (1 << 7),
>=20
> If primary is a flag of each BdrvChild, then you could end up having
> multiple children that claim that they're the primary child. On the
> other hand, if we have a bs->primary_child instead to make sure that we
> only have one primary child, we'd have to keep this consistent when
> children change.
>=20
> So maybe just document that this flag must be given to only one
> BdrvChild link for each parent.

Sure.

Max


--xELTjV0fBqxFSbQRXkjZUae19m3VYikQU--

--FIiHuhm7X9ygDV4dYdPWlHVPIfCQIuovd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3f96IACgkQ9AfbAGHV
z0BvOQf+P8iqfiNt4SHjhUygWrjUr4jO+EDncDpDzdQ7g+yTI9409zMfJIUhL9Tm
3fkwlVgMf9ykLuqaXsXmHroqMNDXHMXrFtxmI2j0fAUN4dKjAX0ma2fZ2yRJ1Lf8
UR7fhwdzPA8pvkmw7kN9v69JhZ8ycpCeWYakeZkaaQtwbAhJX6uh/9YXCFGts/UD
dNca6zY1iDJ4kyEmJhqjmWLVhSJJY/XXzfUfpFkpOzdn6YjTTR1D7RJ/bSKYNibK
89Ji8RSeQzqjVPhYHXwwUpOCS7eHz+u3mm7GyCXVUI3WjrZDTlpX12sxzafYXvDu
Peoz3TGv9dnpks5HxmZiYdRp1mnVqw==
=5Ruw
-----END PGP SIGNATURE-----

--FIiHuhm7X9ygDV4dYdPWlHVPIfCQIuovd--


