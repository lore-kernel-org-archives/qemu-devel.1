Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E896EC17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B122190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibqG9qQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B122190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyxr-00037y-Us
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRywz-0002dO-Cx
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRyww-0002yw-Qr
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:32:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRyww-0002ye-Lt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572960766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sgF7RD/vMNoKWpFeEGTdHTZkU+w8r9zlMxOnhlR5eDw=;
 b=ibqG9qQIKmDICY8u8R4XDOnKw8uPop9gjHCZFWgzDMZEik99Xq28Sir34o7i7fQtCBYiCf
 HKq1fje5xwpKy9oboe/MqG/nDaPwQVcos9AFDAZec8u79Dohs1fl64hP1FSgDfkHZ3Pkyj
 +quZCeuZBQdsxbr3u9QpgHZTbIokib8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-pEM1YL3YMFCPqE756Khx9A-1; Tue, 05 Nov 2019 08:32:42 -0500
X-MC-Unique: pEM1YL3YMFCPqE756Khx9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 644D68017DD;
 Tue,  5 Nov 2019 13:32:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B911E5C1B2;
 Tue,  5 Nov 2019 13:32:38 +0000 (UTC)
Subject: Re: [RFC PATCH v2 00/26] Add subcluster allocation to qcow2
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
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
Message-ID: <7ff9d343-9148-6276-e068-f29d49f47fdc@redhat.com>
Date: Tue, 5 Nov 2019 14:32:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MI90STtfn1QZQE5EYhZVLlkKLuyk0nnfs"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MI90STtfn1QZQE5EYhZVLlkKLuyk0nnfs
Content-Type: multipart/mixed; boundary="3mmPrL4bINaAMev8dlgGCEePA9XL45CD9"

--3mmPrL4bINaAMev8dlgGCEePA9XL45CD9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Hi,
>=20
> here's the new version of the patches to add subcluster allocation
> support to qcow2.
>=20
> Please refer to the cover letter of the first version for a full
> description of the patches:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html
>=20
> This version includes a few tests, but I'm planning to add more for
> the next revision.

I think what would help most with testing is if it were possible to
simply run the iotests with -o extended_l2=3Don.

In general, the RFC looks OK to me.  The one thing I dislike is that I
feel that it is a bit, well, uncourageous.  Now, after looking at the
series, I don=E2=80=99t know whether you really changed everything that nee=
ds to
be changed so it can deal with subclusters.

To me it feels like this is because you tried to keep everything as it
is and only do minimal changes.  That is usually a good thing, but here
I don=E2=80=99t know, because this way we can=E2=80=99t simply grep for pla=
ces that need
fixing (because they use /\<cluster/ instead of /subcluster/).

To me it feels like with subclusters, the whole design should be
different.  Note that the following is just a very na=C3=AFve idea, but
anyway: I feel like what we need to separate isn=E2=80=99t L2 entries vs.
clusters vs. subclusters (so a separation based on, well, syntax?) but a
separation based on offset vs. allocation status (so a separation based
on semantics).

So I imagine there would be one function that sets a whole cluster=E2=80=99=
s
(i.e., a group of subclusters) allocation offset; and another function
that sets individual subclusters=E2=80=99 allocation status.

Reversely, there should be a function to query a cluster=E2=80=99s/subclust=
er=E2=80=99s
allocation offset, and another to query a subcluster=E2=80=99s type.

To me it looks like the places where
QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER is handled separately from
QCOW2_CLUSTER_UNALLOCATED are places where we=E2=80=99re really not interes=
ted
in the subcluster=E2=80=99s type at all, but just whether there=E2=80=99s a=
n allocation
or not.  This is the case in qcow2_get_cluster_offset(),
calculate_l2_meta(), and qcow2_co_block_status().

(These places should then use the function to query the allocation
offset and evaluate the result instead of querying the subcluster type.)


Does that sound in any way acceptable to you?  You have more insight
into this now and so maybe you know already that it can=E2=80=99t work.
(Or maybe it=E2=80=99s just too invasive.)


Right now, all I can do is grep for QCOW2_CLUSTER_ and set_l2_entry().
And all of those places look OK to me.  But I just can=E2=80=99t shake off =
the
uneasy feeling of not being able to really know whether this series
really got to all the places that need adjustment.

Max


--3mmPrL4bINaAMev8dlgGCEePA9XL45CD9--

--MI90STtfn1QZQE5EYhZVLlkKLuyk0nnfs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BefQACgkQ9AfbAGHV
z0AGbQf/WDJSJPpTzGpGnWq49Ra1xt7lAn+pa6hFmh1DGSQoaOaBeryMJ2+yz0D+
HRm5S37dvWgjUAX8gLXog/oDmd9hFOQOzHjSml75CTzA0AMUU4uUyXuWQSkjb+PW
PnGKGJI3y50IexfGo3dupuJKELYJ1bQ+xo126gY6ze7VIbcbRiKPcwRROKu1jdX6
ADX7Nv9QWsqxi+I+zvDN8XT4LNDLTHCLK5adiKzBSocwN9eOIooZnepHSBG6PnIg
YHvU3JRqIeDurUAWBZeftlWvxbf1Rm3pj2F2RRfZGFwApO3iC5FgaHtWe59D+sND
EF/U2Lkh7Ly9hFLv0ntxuRnwtSt2nw==
=ygyZ
-----END PGP SIGNATURE-----

--MI90STtfn1QZQE5EYhZVLlkKLuyk0nnfs--


