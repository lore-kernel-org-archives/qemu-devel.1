Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:52:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4176B206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiYGi36s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4176B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJ7h-0001Uv-HQ
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnJ3J-0003WM-1m
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:47:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jnJ3F-0004dj-IF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592819260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IG0xyW8Y+2IhjrkUff/gvAIPuJaTf/JbQT5eqrRgUHk=;
 b=SiYGi36sy4Cpm0+UB2VUJUrs7QZrLX3UbdSWMJHWEI0KFyc3VLK5vYkwvQ1VctEjWdAzLl
 ++DCl/PcjbaENd7HrYUoKck+Boe/kvxCHCxdz8QtiKuUSxLZa/h70cbR9jElzTAMcOZ/lk
 vnlXWE4yubOKUXSV+sTawW/xaLLPKq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-KGs0P0iDNeizKhGRgf2rGg-1; Mon, 22 Jun 2020 05:47:36 -0400
X-MC-Unique: KGs0P0iDNeizKhGRgf2rGg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75A9D1005512;
 Mon, 22 Jun 2020 09:47:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-85.ams2.redhat.com
 [10.36.114.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5624760C05;
 Mon, 22 Jun 2020 09:47:34 +0000 (UTC)
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
To: Nir Soffer <nsoffer@redhat.com>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
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
Message-ID: <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
Date: Mon, 22 Jun 2020 11:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GCoYbktY6qXrOSVNuVgTu3bEnB2Unq607"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GCoYbktY6qXrOSVNuVgTu3bEnB2Unq607
Content-Type: multipart/mixed; boundary="X1Hir02OSvdG7moJuO6lOKkrzbflM1mdY"

--X1Hir02OSvdG7moJuO6lOKkrzbflM1mdY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.06.20 00:25, Nir Soffer wrote:
> On Fri, Jun 19, 2020 at 1:40 PM Max Reitz <mreitz@redhat.com> wrote:
>>
>> Hi,
>>
>> As discussed here:
>>
>> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
>> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html
>> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00240.html
>>
>> I think that qcow2 images with data-file-raw should always have
>> preallocated 1:1 L1/L2 tables, so that the image always looks the same
>> whether you respect or ignore the qcow2 metadata.
>=20
> I don't know the internals of qcow2 data_file, but are we really using
> qcow2 metadata when accessing the data file?

Yes.

> This may have unwanted performance consequences.

I don=E2=80=99t think so, because in practice normal lookups of L1/L2 mappi=
ngs
generally don=E2=80=99t cost that much performance.

> If I understand correctly, qcow2 metadata is needed only for keeping
> bitmaps (or maybe
> future extensions) for raw data file, and reading from the qcow2 image
> should be read
> directly from the raw file without any extra work.
>=20
> Writing to the data file should also bypass the qcow2 metadata, since the=
 bitmap
> is updated in memory.

Well, with this series, writing would no longer update the metadata at
least, because it would always be preallocated already.

>>  The easiest way to
>> achieve that is to enforce at least metadata preallocation whenever
>> data-file-raw is given.
>=20
> But preallocation is not free, even on file systems, it can be even
> slow (NFS < 4.2).

Metadata preallocation with an external data file should be the same
speed on every file system.  We only need to create the metadata
structures, which, with the default cluster size (64k) take up a bit
more than 1/8192 of the full image size.

Sure, it=E2=80=99s not free.  But if we decide we should indeed fully ignor=
e the
L1/L2 tables for data-file-raw images, the qcow2 spec must be amended.
As I can read it, it currently doesn=E2=80=99t say so.

(By the way, this is not a trivial change.  Right now, data-file-raw is
an autoclear flag: If a version of qemu that doesn=E2=80=99t support it acc=
esses
the image, it will automatically clear the flag, but the image stays
valid.  If we decide to completely ignore the L1/L2 tables (i.e. not
even create them), then this can no longer be an autoclear flag.  We=E2=80=
=99d
need a new incompatible flag.  (Because without L1/L2 tables, the image
becomes useless to older qemu versions.))

> With block storage this means you need to allocate the entire image size =
on
> storage for writing the metadata.
>=20
> While oVirt does not use qcow2 with data_file, having preallocated qcow2
> will make this very hard to use, for example for 500 GiB disk we will hav=
e to
> allocate 500 GiB disk for the raw data file and 500 GiB disk for the qcow=
2
> metadata disk which will be 99% unused.

I don=E2=80=99t understand this.  When you use an external data file, the q=
cow2
file will only contain the metadata:

$ qemu-img create -f qcow2 \
    -o data_file=3Dfoo.data,data_file_raw=3Don,preallocation=3Dmetadata \
    foo.qcow2 8G
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D8589934592 data_file=3Dfoo.data
data_file_raw=3Don cluster_size=3D65536 preallocation=3Dmetadata
lazy_refcounts=3Doff refcount_bits=3D16
$ ls -l foo.qcow2
... 1310720 ... foo.qcow2
$ ls -l foo.data
... 8589934592 ... foo.data

> I don't think that kubevirt is planning to use this either, but if
> they decide to use
> this it may be a problem for them as well when using block storage.
>=20
> It looks like we abuse preallocation for getting the side effect that
> the backing file
> will be rejected, instead of adding the validation rejecting backing
> file in this case.

That isn=E2=80=99t the case.

I want to use preallocation because I interpret the spec such that it
requires metadata preallocation.  It says when accessing a qcow2 file
with data-file-raw, you can ignore the L1/L2 tables.  To me, that means
that the L1/L2 tables must give a 1:1 mapping so that you get the same
result whether you interpret them or not.

Max


--X1Hir02OSvdG7moJuO6lOKkrzbflM1mdY--

--GCoYbktY6qXrOSVNuVgTu3bEnB2Unq607
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7wfjQACgkQ9AfbAGHV
z0CL+gf+Km/T8DxYdnd+fwqQ92dBh/dslXTbHdzY9WvxmrWRnc102j/tJqFLxkil
in1uy67UReMGVpJyY1lcFGxN7TrMXwnY2t9pBJGIpEe81PlXY3ENKDWIeXqLAPtN
Di6sKBW3Ar+/b+p5b4a5ywgIqx3uUgqKAjQVRrZID3mLLnoMWiHkrmfRmdRpXZYN
ljQh1wr4RDZp7W52VkYU6k217oTzZWviK64WMapqZ0M7EQNbsBGgOOztBgSXZBws
iaCcFIkQ0S/iugXnDm6E1AaUG1zvw2YXc+zGVqMeyuYUbE9ut8yCWzwe/GSOhAC9
+mnrP8PugwO0lv5QTYfINYiiTz1HBQ==
=hJJ6
-----END PGP SIGNATURE-----

--GCoYbktY6qXrOSVNuVgTu3bEnB2Unq607--


