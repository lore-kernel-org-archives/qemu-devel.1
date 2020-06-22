Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FCC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC9020716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx7xcZNQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC9020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOkY-0004F2-HG
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOij-0002j6-Um
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:50:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1jnOii-0005eu-1S
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592841051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUmD0SmFLVtA9AhJZISVPng0qT+tx3SIDalKpUzlpeU=;
 b=Yx7xcZNQx1x0N+H+kpbaQT5KIzagiAgAn5g8tRHKx18bYsjhw1XTNOBrHqJENwhRgV+Pbr
 bfKdMnxizlTLsRyiQe+N+9JqyZeOPnFj9Y4ra8rWBmVSeQY+CsXvxw0otnLwuAhQBUdL0t
 y2i23jodrqoPGjg+rsD67blTST5iyLY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-oNog-at1MYyjLm329jsvEg-1; Mon, 22 Jun 2020 11:50:34 -0400
X-MC-Unique: oNog-at1MYyjLm329jsvEg-1
Received: by mail-oi1-f198.google.com with SMTP id m22so8197567oih.21
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eUmD0SmFLVtA9AhJZISVPng0qT+tx3SIDalKpUzlpeU=;
 b=a25cx5jjDDKZdotunoV9sYEifRvTbWQVnckFp1ag8uq9CnNhgBA5b7gFwGrzwGyY2T
 5wOE2gLEYOOs1CIq3EZw04wNEdxEeN+1nUa2cy9Fn6kHRZebqewsBnsSFt6BjhUUaLHl
 PNBpKcEeV3xMviDbNwQ2fuEsPBVFbRVSsYHmBRKhk91xPK97VNM0SUdrdnlTz1T5VlY6
 qUHgOUuLDmLuc7xOcbsNhzXYklngirhPUq7LQQdpviA+/S1uOpU1gFIuQ0KE+FYUI3ui
 U6HioCfWJ29m43hZ7vjgBTlfWMordO9WKgjkKaPWrfXvWf7b3RbUAwbxAtTZTLVrwSRn
 Mseg==
X-Gm-Message-State: AOAM533I/IoV1KgBANgc0RD39kPQtTknmDQtZDCh8y90ZqV95fgZhpBr
 gNYxHJJwdtjHn4CY63L/IbL8XqzuMUHyxy4LHoluwtky20uv6R1D8WBy69hMFs6Csrlpjqc7UWi
 r7BALrFaYlNl2xrOrfUX5U/rnjN41bdw=
X-Received: by 2002:a05:6808:2d5:: with SMTP id
 a21mr12496686oid.156.1592841032080; 
 Mon, 22 Jun 2020 08:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdmg9qBApAcVPgRHpHcQ9hTMcGgelC3lvBTeKJMs96v7Qxzor7kqwyWCJOOldp0TLYY/BLJmTtns6Msj60Z+s=
X-Received: by 2002:a05:6808:2d5:: with SMTP id
 a21mr12496666oid.156.1592841031698; 
 Mon, 22 Jun 2020 08:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200619104012.235977-1-mreitz@redhat.com>
 <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
 <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
In-Reply-To: <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 22 Jun 2020 18:50:14 +0300
Message-ID: <CAMRbyyu+tkhZLJXKiuDRxRixZqsXgzQ3GzgcnP0pXN2-r6Xagw@mail.gmail.com>
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
To: Max Reitz <mreitz@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=nsoffer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=nsoffer@redhat.com;
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

On Mon, Jun 22, 2020 at 12:47 PM Max Reitz <mreitz@redhat.com> wrote:
>
> On 22.06.20 00:25, Nir Soffer wrote:
> > On Fri, Jun 19, 2020 at 1:40 PM Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> As discussed here:
> >>
> >> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
> >> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html
> >> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00240.html
> >>
> >> I think that qcow2 images with data-file-raw should always have
> >> preallocated 1:1 L1/L2 tables, so that the image always looks the same
> >> whether you respect or ignore the qcow2 metadata.
> >
> > I don't know the internals of qcow2 data_file, but are we really using
> > qcow2 metadata when accessing the data file?
>
> Yes.
>
> > This may have unwanted performance consequences.
>
> I don=E2=80=99t think so, because in practice normal lookups of L1/L2 map=
pings
> generally don=E2=80=99t cost that much performance.
>
> > If I understand correctly, qcow2 metadata is needed only for keeping
> > bitmaps (or maybe
> > future extensions) for raw data file, and reading from the qcow2 image
> > should be read
> > directly from the raw file without any extra work.
> >
> > Writing to the data file should also bypass the qcow2 metadata, since t=
he bitmap
> > is updated in memory.
>
> Well, with this series, writing would no longer update the metadata at
> least, because it would always be preallocated already.
>
> >>  The easiest way to
> >> achieve that is to enforce at least metadata preallocation whenever
> >> data-file-raw is given.
> >
> > But preallocation is not free, even on file systems, it can be even
> > slow (NFS < 4.2).
>
> Metadata preallocation with an external data file should be the same
> speed on every file system.  We only need to create the metadata
> structures, which, with the default cluster size (64k) take up a bit
> more than 1/8192 of the full image size.
>
> Sure, it=E2=80=99s not free.  But if we decide we should indeed fully ign=
ore the
> L1/L2 tables for data-file-raw images, the qcow2 spec must be amended.
> As I can read it, it currently doesn=E2=80=99t say so.
>
> (By the way, this is not a trivial change.  Right now, data-file-raw is
> an autoclear flag: If a version of qemu that doesn=E2=80=99t support it a=
ccesses
> the image, it will automatically clear the flag, but the image stays
> valid.  If we decide to completely ignore the L1/L2 tables (i.e. not
> even create them), then this can no longer be an autoclear flag.  We=E2=
=80=99d
> need a new incompatible flag.  (Because without L1/L2 tables, the image
> becomes useless to older qemu versions.))
>
> > With block storage this means you need to allocate the entire image siz=
e on
> > storage for writing the metadata.
> >
> > While oVirt does not use qcow2 with data_file, having preallocated qcow=
2
> > will make this very hard to use, for example for 500 GiB disk we will h=
ave to
> > allocate 500 GiB disk for the raw data file and 500 GiB disk for the qc=
ow2
> > metadata disk which will be 99% unused.
>
> I don=E2=80=99t understand this.  When you use an external data file, the=
 qcow2
> file will only contain the metadata:
>
> $ qemu-img create -f qcow2 \
>     -o data_file=3Dfoo.data,data_file_raw=3Don,preallocation=3Dmetadata \
>     foo.qcow2 8G
> Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D8589934592 data_file=3Dfoo.dat=
a
> data_file_raw=3Don cluster_size=3D65536 preallocation=3Dmetadata
> lazy_refcounts=3Doff refcount_bits=3D16
> $ ls -l foo.qcow2
> ... 1310720 ... foo.qcow2
> $ ls -l foo.data
> ... 8589934592 ... foo.data

When allocating metadata in regular qcow2, need the to allocate the
entire device
(+ extra space for metadata overhead):

# qemu-img create -f qcow2 -o preallocation=3Dmetadata foo.qcow2 500g
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D536870912000 cluster_size=3D6553=
6
preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16

# qemu-img check foo.qcow2
No errors were found on the image.
8192000/8192000 =3D 100.00% allocated, 0.00% fragmented, 0.00% compressed c=
lusters
Image end offset: 536953094144

But I see that with metadata file we allocate much less:

# qemu-img create -f qcow2 -o
data_file=3Dfoo.data,data_file_raw=3Don,preallocation=3Dmetadata foo.qcow2
500g
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D536870912000 data_file=3Dfoo.dat=
a
data_file_raw=3Don cluster_size=3D65536 preallocation=3Dmetadata
lazy_refcounts=3Doff refcount_bits=3D16

# qemu-img check foo.qcow2
No errors were found on the image.
8192000/8192000 =3D 100.00% allocated, 0.00% fragmented, 0.00% compressed c=
lusters
Image end offset: 65798144

I tested this also with block device:

# lvcreate --size 500g --name foo.data test
  Logical volume "foo.data" created.

 lvcreate --size 128m --name foo.qcow2 test
  Logical volume "foo.qcow2" created.

# time qemu-img create -f qcow2 -o
data_file=3D/dev/test/foo.data,data_file_raw=3Don,preallocation=3Dmetadata
/dev/test/foo.qcow2 500g
Formatting '/dev/test/foo.qcow2', fmt=3Dqcow2 size=3D536870912000
data_file=3D/dev/test/foo.data data_file_raw=3Don cluster_size=3D65536
preallocation=3Dmetadata lazy_refcounts=3Doff refcount_bits=3D16

real 0m4.263s
user 0m0.149s
sys 0m0.387s

# qemu-img info /dev/test/foo.qcow2
image: /dev/test/foo.qcow2
file format: qcow2
virtual size: 500 GiB (536870912000 bytes)
disk size: 0 B
cluster_size: 65536
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    data file: /dev/test/foo.data
    data file raw: true
    corrupt: false

# qemu-img check /dev/test/foo.qcow2
No errors were found on the image.
8192000/8192000 =3D 100.00% allocated, 0.00% fragmented, 0.00% compressed c=
lusters
Image end offset: 65798144


The overhead 63 MiB per 500 GiB seems reasonable and preallocating the meta=
data
is not that bad.

> > I don't think that kubevirt is planning to use this either, but if
> > they decide to use
> > this it may be a problem for them as well when using block storage.
> >
> > It looks like we abuse preallocation for getting the side effect that
> > the backing file
> > will be rejected, instead of adding the validation rejecting backing
> > file in this case.
>
> That isn=E2=80=99t the case.
>
> I want to use preallocation because I interpret the spec such that it
> requires metadata preallocation.  It says when accessing a qcow2 file
> with data-file-raw, you can ignore the L1/L2 tables.  To me, that means
> that the L1/L2 tables must give a 1:1 mapping so that you get the same
> result whether you interpret them or not.

I agree that this is reasonable, and we will be able to use this if we need=
.

Not having to allocate metadata at all and never using the 1:1 mapping
would be even better.

Nir


