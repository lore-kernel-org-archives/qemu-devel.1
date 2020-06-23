Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FCEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A3420724
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TYruvkr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A3420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jng1J-0002L7-W8
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jng0Y-0001Rz-Bp
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:18:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jng0V-0004Lh-IU
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592907501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vwo+r+KZ620W7QY928LUe9//H+IYKpfvsdEQpzrmShw=;
 b=TYruvkr9vYc4jN+ghJUVnjuz+pEeN0qKfzCDk0f/BhVOTxl3vorBOoyd1AP+GvmfnfJjUa
 dSUW8SAr1pKR3MdjsZgX45vAoAmPWltPwiMlpfEh3ZD/W0EWE+5rhPj8fg1+aEA87NJSmi
 pOgw9yVIfiJj5T3DnGettH0oD0jcsBs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-OhDHD3evPty_guJeikdEqw-1; Tue, 23 Jun 2020 06:18:17 -0400
X-MC-Unique: OhDHD3evPty_guJeikdEqw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D66CB464;
 Tue, 23 Jun 2020 10:18:16 +0000 (UTC)
Received: from linux.fritz.box (ovpn-115-78.ams2.redhat.com [10.36.115.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D2A4F5C1D4;
 Tue, 23 Jun 2020 10:18:15 +0000 (UTC)
Date: Tue, 23 Jun 2020 12:18:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Nir Soffer <nsoffer@redhat.com>
Subject: Re: [PATCH 0/2] qcow2: Force preallocation with data-file-raw
Message-ID: <20200623101814.GD5853@linux.fritz.box>
References: <20200619104012.235977-1-mreitz@redhat.com>
 <CAMRbyyu1ZC2qMKSHJXNy7-98-nXHh00dL-v_D0BKcEL6Rmmj+g@mail.gmail.com>
 <72eb5700-faf6-22ee-69be-1e7653cf06c6@redhat.com>
 <CAMRbyyu+tkhZLJXKiuDRxRixZqsXgzQ3GzgcnP0pXN2-r6Xagw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMRbyyu+tkhZLJXKiuDRxRixZqsXgzQ3GzgcnP0pXN2-r6Xagw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.06.2020 um 17:50 hat Nir Soffer geschrieben:
> On Mon, Jun 22, 2020 at 12:47 PM Max Reitz <mreitz@redhat.com> wrote:
> >
> > On 22.06.20 00:25, Nir Soffer wrote:
> > > On Fri, Jun 19, 2020 at 1:40 PM Max Reitz <mreitz@redhat.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> As discussed here:
> > >>
> > >> https://lists.nongnu.org/archive/html/qemu-block/2020-02/msg00644.html
> > >> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00329.html
> > >> https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00240.html
> > >>
> > >> I think that qcow2 images with data-file-raw should always have
> > >> preallocated 1:1 L1/L2 tables, so that the image always looks the same
> > >> whether you respect or ignore the qcow2 metadata.
> > >
> > > I don't know the internals of qcow2 data_file, but are we really using
> > > qcow2 metadata when accessing the data file?
> >
> > Yes.
> >
> > > This may have unwanted performance consequences.
> >
> > I don’t think so, because in practice normal lookups of L1/L2 mappings
> > generally don’t cost that much performance.
> >
> > > If I understand correctly, qcow2 metadata is needed only for keeping
> > > bitmaps (or maybe
> > > future extensions) for raw data file, and reading from the qcow2 image
> > > should be read
> > > directly from the raw file without any extra work.
> > >
> > > Writing to the data file should also bypass the qcow2 metadata, since the bitmap
> > > is updated in memory.
> >
> > Well, with this series, writing would no longer update the metadata at
> > least, because it would always be preallocated already.
> >
> > >>  The easiest way to
> > >> achieve that is to enforce at least metadata preallocation whenever
> > >> data-file-raw is given.
> > >
> > > But preallocation is not free, even on file systems, it can be even
> > > slow (NFS < 4.2).
> >
> > Metadata preallocation with an external data file should be the same
> > speed on every file system.  We only need to create the metadata
> > structures, which, with the default cluster size (64k) take up a bit
> > more than 1/8192 of the full image size.
> >
> > Sure, it’s not free.  But if we decide we should indeed fully ignore the
> > L1/L2 tables for data-file-raw images, the qcow2 spec must be amended.
> > As I can read it, it currently doesn’t say so.
> >
> > (By the way, this is not a trivial change.  Right now, data-file-raw is
> > an autoclear flag: If a version of qemu that doesn’t support it accesses
> > the image, it will automatically clear the flag, but the image stays
> > valid.  If we decide to completely ignore the L1/L2 tables (i.e. not
> > even create them), then this can no longer be an autoclear flag.  We’d
> > need a new incompatible flag.  (Because without L1/L2 tables, the image
> > becomes useless to older qemu versions.))
> >
> > > With block storage this means you need to allocate the entire image size on
> > > storage for writing the metadata.
> > >
> > > While oVirt does not use qcow2 with data_file, having preallocated qcow2
> > > will make this very hard to use, for example for 500 GiB disk we will have to
> > > allocate 500 GiB disk for the raw data file and 500 GiB disk for the qcow2
> > > metadata disk which will be 99% unused.
> >
> > I don’t understand this.  When you use an external data file, the qcow2
> > file will only contain the metadata:
> >
> > $ qemu-img create -f qcow2 \
> >     -o data_file=foo.data,data_file_raw=on,preallocation=metadata \
> >     foo.qcow2 8G
> > Formatting 'foo.qcow2', fmt=qcow2 size=8589934592 data_file=foo.data
> > data_file_raw=on cluster_size=65536 preallocation=metadata
> > lazy_refcounts=off refcount_bits=16
> > $ ls -l foo.qcow2
> > ... 1310720 ... foo.qcow2
> > $ ls -l foo.data
> > ... 8589934592 ... foo.data
> 
> When allocating metadata in regular qcow2, need the to allocate the
> entire device
> (+ extra space for metadata overhead):
> 
> # qemu-img create -f qcow2 -o preallocation=metadata foo.qcow2 500g
> Formatting 'foo.qcow2', fmt=qcow2 size=536870912000 cluster_size=65536
> preallocation=metadata lazy_refcounts=off refcount_bits=16
> 
> # qemu-img check foo.qcow2
> No errors were found on the image.
> 8192000/8192000 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
> Image end offset: 536953094144

I think we shouldn't really call this "allocating" because we don't
actually reserve space for it yet. On a filesystem, you get a large file
size, but it's almost completely sparse. On block devices, it depends on
whether the storage has thin provisioning.

> But I see that with metadata file we allocate much less:
> 
> # qemu-img create -f qcow2 -o
> data_file=foo.data,data_file_raw=on,preallocation=metadata foo.qcow2
> 500g
> Formatting 'foo.qcow2', fmt=qcow2 size=536870912000 data_file=foo.data
> data_file_raw=on cluster_size=65536 preallocation=metadata
> lazy_refcounts=off refcount_bits=16
> 
> # qemu-img check foo.qcow2
> No errors were found on the image.
> 8192000/8192000 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
> Image end offset: 65798144

Actually, this is not much less, but just split in two places. You still
have the 500 GB data file. The metadata is small, but it was already
small before:

536953094144 - 536870912000 = ~78 MB.

Not exactly sure why it's more than the 64 MB you get for an external
data file, maybe some alignment thing, but not significant anyway.

Kevin


