Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E8EC33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201FC21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vhydb0LY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201FC21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiMM-0000xh-98
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iuhcF-0003MZ-AP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iuhcD-0006XN-Id
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:54:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51051
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iuhcD-0006WW-DM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 13:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579805644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FKpXVIMznCBmvilSjxuwt9752+QjXVA0fS6vVcbMg3o=;
 b=Vhydb0LY28WgPtFTmlIvl1WnTcaa6YqNkhH0J3N7mAszovnvixcxWUW3xf48Rbg0MN0BAx
 w6mfIydsegHS8AnTq+i2g6KdNWto9tuOr53pF8eC1n0d296YKn9vzG5XlmhYRjN7AiE3Tq
 lE8IPubc+Clk5MahSWpIExZG1LU13aE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181--6RrpPOHMXemS56nwhwviw-1; Thu, 23 Jan 2020 13:54:01 -0500
X-MC-Unique: -6RrpPOHMXemS56nwhwviw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3F50108A47F;
 Thu, 23 Jan 2020 18:54:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF94E5C1BB;
 Thu, 23 Jan 2020 18:53:58 +0000 (UTC)
Subject: Re: qemu-img convert vs writing another copy tool
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, eblake@redhat.com, berrange@redhat.com,
 mkletzan@redhat.com, ptoscano@redhat.com
References: <20200123183500.GA27166@redhat.com>
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
Message-ID: <ef3492f5-b1ab-52d2-9484-3c42e2b6af87@redhat.com>
Date: Thu, 23 Jan 2020 19:53:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200123183500.GA27166@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4TiBvYcsh27VMFOkKSo7ptnrudESTcV8N"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: marnold@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4TiBvYcsh27VMFOkKSo7ptnrudESTcV8N
Content-Type: multipart/mixed; boundary="Ir2pAMNq2gMygFO56H2A6Yc6OvRJsf40e"

--Ir2pAMNq2gMygFO56H2A6Yc6OvRJsf40e
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.01.20 19:35, Richard W.M. Jones wrote:
> I guess some people are aware that virt-v2v, which is a tool which
> converts guests from VMware to run on KVM, and some other
> OpenStack-OpenStack migration tools we have, use "qemu-img convert" to
> copy the data around.
>=20
> Historically we've had bugs here.  The most recent was discussed in
> the thread on this list called "Bug? qemu-img convert to preallocated
> image makes it sparse"
> (https://www.mail-archive.com/qemu-block@nongnu.org/msg60479.html)
>=20
> We've been kicking around the idea of writing some alternate tool.  My
> proposal would be a tool (not yet written, maybe it will never be
> written) called nbdcp for copying between NBD servers and local files.
> An outline manual page for this proposed tool is attached.
>=20
> Some of the things which this tool might do which qemu-img convert
> cannot do right now:
>=20
>  - Hint that the target already contains zeroes.  It's almost always
>    the case that we know this, but we cannot tell qemu.  This was the
>    cause of a big performance regression last year.
>=20
>  - Declare that we want the target to be either sparse or
>    preallocated.  qemu-img convert can sort of do this in a
>    round-about way (create the target in advance and use the -n
>    option), but also it's broken at the moment.

Both of these would be solved by --target-is-zero, I think.

>  - NBD multi-conn.  In my tests this makes a really massive
>    performance difference in certain situations.  Again, virt-v2v has
>    a lot of information that we cannot pass to qemu: we know, for
>    example, exactly if the server supports the feature, how many
>    threads are available, in some situations even have information
>    about the network and backing disks that the data will travel over
>    / be stored on.

As far as I understand it, you use qemu-img convert with an NBD source
or target, too?

I suppose it=E2=80=99s always easier to let a specialized and freshly writt=
en
tool handle such information.  But it sounds like if such information is
useful and makes that big of a difference, then it would be good to be
able to specify it to qemu=E2=80=99s NBD block driver, too.

>  - Machine-parsable progress bars.  You can, sort of, parse the
>    progress bar from qemu-img convert, but it's not as easy as it
>    could be.  In particular it would be nice if the format was treated
>    as ABI, and if there was a way to have the tool write the progress
>    bar info to a precreated file descriptor.

It doesn=E2=80=99t seem impossible to add this feature to qemu-img, althoug=
h I
wonder about the interface.  I suppose we could make it an alternative
progress output mode (with some command-line flag), and then the
information would be emitted to stdout (just like the existing progress
report).  You can of course redirect stdout to whatever fd you=E2=80=99d li=
ke,
so I don=E2=80=99t know whether qemu-img itself needs that specific capabil=
ity.

OTOH, if you need this feature, why not just use qemu itself?  That is,
a mirror or a backup block job in an otherwise empty VM.

>  - External block lists.  This is a rather obscure requirement, but
>    it's necessary in the case where we can get the allocated block map
>    from another source (eg. pyvmomi) and then want to use that with an
>    NBD source that does not support extents (eg. nbdkit-ssh-plugin /
>    libssh / sftp).  [Having said that, it may be possible to implement
>    this as an nbdkit filter, so maybe this is not a blocking feature.]

That too seems like a feature that=E2=80=99s easily implementable in a
specialized tool, but hard to implement in qemu-img.

I suppose we=E2=80=99d want a dirty bitmap copy mode which copies only the
regions that the bitmap reports as dirty =E2=80=93 but at that point you=E2=
=80=99re
probably again better off not using qemu-img, but qemu itself.  Then
we=E2=80=99d need some way to import bitmaps, and I actually don=E2=80=99t =
think we have
that yet.

But again, if this is a generally useful feature, I think we want it in
qemu anyway.

> One thing which qemu-img convert can do which nbdcp could not:
>=20
>  - Read or write from qcow2 files.
>=20
> So instead of splitting the ecosystem and writing a new tool that
> doesn't do as much as qemu-img convert, I wonder what qemu developers
> think about the above missing features?  For example, are they in
> scope for qemu-img convert?

What I think is that there may be features that we don=E2=80=99t want in
qemu-img, because they are more appropriate for the mirror or backup
block job.  For example, I don=E2=80=99t think we want to let qemu-img conv=
ert
mess around with dirty bitmaps.

But apart from that, the features you propose all seem useful to have in
qemu itself.  Maybe some of them are too hard to implement (specifically
importing bitmaps from external sources), then it might be pragmatic to
write a new tool where such features can be easily implemented because
they don=E2=80=99t need to be integrated into an existing API.

As for performance, well, if qemu=E2=80=99s NBD driver is slow, then naivel=
y I=E2=80=99d
think that=E2=80=99s a bug, isn=E2=80=99t it?  And if improving performance=
 requires
knobs, then that=E2=80=99s how it is.

Max


--Ir2pAMNq2gMygFO56H2A6Yc6OvRJsf40e--

--4TiBvYcsh27VMFOkKSo7ptnrudESTcV8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4p68UACgkQ9AfbAGHV
z0BWUggArKIbC+vzzBfEz5Udm5AqqXlHuGZlOo0IP3BCxjyYNNOVV16lNZoHCrcG
J+ao+tFl+hCzPC+YL60Eud+gNeUKjjhbME9EE+EyfcUi69AYzNTxxnetmuh34UuP
ntaqA+C+sI3NW9RSOrjtFXdqletkSWT0m+ulop5H2zX1yM31Wjga7mhV+GURLcuC
r57aHAzOfDCQR8jQc5H3LDAsIUSj9efAlRMq90wbgUo+slhKbZDYT//tImVodylb
X/7UcDyqStGGBKHD5HEY3mE4P9tKlry11fkzBNbihE1loDIBg0dFmy4fJ37QAvyD
YwNOJOEOguv1b6qWjuiP5+BgMNsGaw==
=bEjd
-----END PGP SIGNATURE-----

--4TiBvYcsh27VMFOkKSo7ptnrudESTcV8N--


