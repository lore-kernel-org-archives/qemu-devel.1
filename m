Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6344C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FA62078D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSkJCt9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FA62078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI6nY-0003OG-Bl
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 04:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI6mv-0002sB-SY
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 04:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI6mr-0007pd-BZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 04:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600160284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8dlLcDUjv1ge982E3wx6Gsjb8Qr4K09vgGrerog773Y=;
 b=OSkJCt9UXIzKvyvkRk86rEo3QV0cuTiE8pJKZ9MhdgvQyHUQZf+rMkGt7D5GBxttAsx5ZH
 vqnodytPomdkArWWK2KgQJWbwz11NYrNHLgrmYRuxCeAEMfYLtkEfT+toXfXDz5K0rhS6z
 YqbGobedE8w11oFEQPTbx8s9LLBoSZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-7fLesI3aO5KXwWOzZXBJLg-1; Tue, 15 Sep 2020 04:58:02 -0400
X-MC-Unique: 7fLesI3aO5KXwWOzZXBJLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DEC6802B63;
 Tue, 15 Sep 2020 08:57:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-7.ams2.redhat.com
 [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3B3310001B3;
 Tue, 15 Sep 2020 08:57:52 +0000 (UTC)
Subject: Re: [PATCH v2] qemu-img: Support bitmap --merge into backing image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200914191009.644842-1-eblake@redhat.com>
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
Message-ID: <f4d640aa-6aec-7dbc-69ae-5a2a6921447d@redhat.com>
Date: Tue, 15 Sep 2020 10:57:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914191009.644842-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sR255QXvkRqlNS1GESAuupkLT47msuVIT"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:10:32
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
Cc: kwolf@redhat.com, eshenitz@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sR255QXvkRqlNS1GESAuupkLT47msuVIT
Content-Type: multipart/mixed; boundary="MPbcrqhdHwpipohjwNTDy08CXNAmSG3tA"

--MPbcrqhdHwpipohjwNTDy08CXNAmSG3tA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.09.20 21:10, Eric Blake wrote:
> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
> bitmap from top into base, qemu-img was failing with:
>=20
> qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed=
 to get shared "write" lock
> Is another process using the image [base.qcow2]?
>=20
> The easiest fix is to not open the entire backing chain of either
> image (source or destination); after all, the point of 'qemu-img
> bitmap' is solely to manipulate bitmaps directly within a single qcow2
> image, and this is made more precise if we don't pay attention to
> other images in the chain that may happen to have a bitmap by the same
> name.
>=20
> However, note that during normal usage, it is a feature that qemu will
> allow a bitmap from a backing image to be exposed by an overlay BDS;
> doing so makes it easier to perform incremental backup, where we have:
>=20
> Base <- Active <- temporrary

*temporary

(Also it=E2=80=99s a bit strange that =E2=80=9CBase=E2=80=9D and =E2=80=9CA=
ctive=E2=80=9D are capitalized, but
=E2=80=9Ctemporary=E2=80=9D isn=E2=80=99t)

>           \--block job ->/
>=20
> with temporary being fed by a block-copy 'sync' job; when exposing

s/block-copy 'sync'/backup 'sync=3Dnone'/?

> temporary over NBD, referring to a bitmap that lives only in Active is
> less effort than having to copy a bitmap into temporary [1].  So the
> testsuite additions in this patch check both where bitmaps get
> allocated (the qemu-img info output), and, when NOT using 'qemu-img
> bitmap', that bitmaps are indeed visible through a backing chain.

Well.  It is useful over NBD but I would doubt that it isn=E2=80=99t useful=
 in
general.  For example, the QMP commands that refer to bitmaps always do
so through a node-name + bitmap-name combination, and they require that
the given bitmap is exactly on the given node.

So I think this is a very much a case-by-case question.  (And in
practice, NBD seems to be the outlier, not qemu-img bitmap.)

> [1] Full disclosure: prior to the recent commit 374eedd1c4 and
> friends, we were NOT able to see bitmaps through filters, which meant
> that we actually did not have nice clean semantics for uniformly being
> able to pick up bitmaps from anywhere in the backing chain (seen as a
> change in behavior between qemu 4.1 and 4.2 at commit 00e30f05de, when
> block-copy swapped from a one-off to a filter).  Which means libvirt
> was already coded to copy bitmaps around for the sake of older qemu,
> even though modern qemu no longer needs it.  Oh well.
>=20
> Fixes: http://bugzilla.redhat.com/1877209
> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> In v2:
> - also use BDRV_O_NO_BACKING on source [Max]
> - improved commit message [Max]
>=20
>  qemu-img.c                 | 11 ++++++--
>  tests/qemu-iotests/291     | 12 ++++++++
>  tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 3 deletions(-)

The code looks good to me, but I wonder whether in the commit message it
should be noted that we don=E2=80=99t want to let bitmaps from deeper nodes
shine through by default everywhere, but just in specific cases where
that=E2=80=99s useful (i.e. only NBD so far AFAIA).

Max


--MPbcrqhdHwpipohjwNTDy08CXNAmSG3tA--

--sR255QXvkRqlNS1GESAuupkLT47msuVIT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9ggg8ACgkQ9AfbAGHV
z0B1eAgAnc6YzQDYcvVAWDAviN4Hti7pLWYCwRv+vfIs0c/J/ZhxN/cYL6nkLlYz
chQL3OGWZVtoHr7W8fNduiVBdJkdabPX3bmU5xMmlAtrVWZh0dkkf/m6HlurID1g
hkdG0Tunaot/HQgMIrh6rFuhrbJS6umWWKiihIgxQbmLGcUjviFvDR1y5csT8wVK
SpS31kF9EJJJQAKqHwRD5U7Ll0/sRmYn+Jo0mKe68qyDejn6xWN1upiKodcXP5Kt
DCxlMLsd0WRyXhxj3YaeJKYI0fTtoJ8iMw7GJ95ioNegVQ+cPBvVcR3KE51hh8H4
MdRzRCoa/6EK7EnCqCCpm8Yyv+Hn1g==
=dOGK
-----END PGP SIGNATURE-----

--sR255QXvkRqlNS1GESAuupkLT47msuVIT--


