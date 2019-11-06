Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B072C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3600120869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 10:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3600120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSIfT-00006g-CF
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 05:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <w.bumiller@proxmox.com>) id 1iSIeS-0007kQ-Rx
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:35:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <w.bumiller@proxmox.com>) id 1iSIeQ-0004ri-SP
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 05:35:00 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:17162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
 id 1iSIeN-0004nI-H5; Wed, 06 Nov 2019 05:34:55 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DDE8F461CC;
 Wed,  6 Nov 2019 11:34:51 +0100 (CET)
Date: Wed, 6 Nov 2019 11:34:50 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: backup_calculate_cluster_size does not consider source
Message-ID: <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
User-Agent: NeoMutt/20180716
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Dietmar Maurer <dietmar@proxmox.com>, qemu-block@nongnu.org,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 06, 2019 at 10:37:04AM +0100, Max Reitz wrote:
> On 06.11.19 09:32, Stefan Hajnoczi wrote:
> > On Tue, Nov 05, 2019 at 11:02:44AM +0100, Dietmar Maurer wrote:
> >> Example: Backup from ceph disk (rbd_cache=3Dfalse) to local disk:
> >>
> >> backup_calculate_cluster_size returns 64K (correct for my local .raw=
 image)
> >>
> >> Then the backup job starts to read 64K blocks from ceph.
> >>
> >> But ceph always reads 4M block, so this is incredibly slow and produ=
ces
> >> way too much network traffic.
> >>
> >> Why does backup_calculate_cluster_size does not consider the block s=
ize from
> >> the source disk?=20
> >>
> >> cluster_size =3D MAX(block_size_source, block_size_target)
>=20
> So Ceph always transmits 4 MB over the network, no matter what is
> actually needed?  That sounds, well, interesting.

Or at least it generates that much I/O - in the end, it can slow down
the backup by up to a multi-digit factor...

> backup_calculate_cluster_size() doesn=E2=80=99t consider the source siz=
e because
> to my knowledge there is no other medium that behaves this way.  So I
> suppose the assumption was always that the block size of the source
> doesn=E2=80=99t matter, because a partial read is always possible (with=
out
> having to read everything).

Unless you enable qemu-side caching this only works until the
block/cluster size of the source exceeds the one of the target.

> What would make sense to me is to increase the buffer size in general.
> I don=E2=80=99t think we need to copy clusters at a time, and
> 0e2402452f1f2042923a5 has indeed increased the copy size to 1 MB for
> backup writes that are triggered by guest writes.  We haven=E2=80=99t y=
et
> increased the copy size for background writes, though.  We can do that,
> of course.  (And probably should.)
>=20
> The thing is, it just seems unnecessary to me to take the source cluste=
r
> size into account in general.  It seems weird that a medium only allows
> 4 MB reads, because, well, guests aren=E2=80=99t going to take that int=
o account.

But guests usually have a page cache, which is why in many setups qemu
(and thereby the backup process) often doesn't.


