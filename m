Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F9FC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53EB320715
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gMe2hEgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EB320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j19Ro-0000MV-Ik
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:50:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j19Qo-0008HF-41
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j19Qm-0001O8-NN
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:48:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j19Qm-0001Nj-KB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581342536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SyahGRT5pilxDexVoeO/ghNtFqv5Plb+GSHNvSNShE=;
 b=gMe2hEgzTsf3HGxa5/SDdqrWfSwc3QSahjEas82bbZoI29UsCr7Xw/vo+FfjdehWunCG/R
 tPUqfun6vY+Maayd76bCF4cdLt+6HEbfykMXKpITwhg6wOdtGcG/EX0ZduNDI8KZff+MgE
 x7j8sVqDiLKU8FzAzs8HwZcOIQowwbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-SKja5nJxN3eSA9UveJdLLw-1; Mon, 10 Feb 2020 08:48:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49325800D4E;
 Mon, 10 Feb 2020 13:48:51 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 707D3857B4;
 Mon, 10 Feb 2020 13:48:47 +0000 (UTC)
Date: Mon, 10 Feb 2020 14:48:46 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [Libguestfs] [RFC] lib: allow to specify physical/logical block
 size for disks
Message-ID: <20200210134846.GD5955@linux.fritz.box>
References: <20200207232528.13461-1-stenavin@gmail.com>
 <20200210114316.GW3888@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200210114316.GW3888@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SKja5nJxN3eSA9UveJdLLw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Mykola Ivanets <stenavin@gmail.com>, libguestfs@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.02.2020 um 12:43 hat Richard W.M. Jones geschrieben:
> On Sat, Feb 08, 2020 at 01:25:28AM +0200, Mykola Ivanets wrote:
> > From: Nikolay Ivanets <stenavin@gmail.com>
> >=20
> > I faced with situation where libguestfs cannot recognize partitions on =
a
> > disk image which was partitioned on a system with "4K native" sector
> > size support.
>=20
> Do you have a small test case for this?
>=20
> > In order to fix the issue we need to allow users to specify desired
> > physical and/or logical block size per drive basis.
>=20
> It seems like physical_block_size / logical_block_size in qemu are
> completely undocumented.  However I did some experiments with patching
> libguestfs and examining the qemu and parted code.  Here are my
> observations:
>=20
> (1) Setting only physical_block_size =3D 4096 seems to do nothing.

The guest sees the physical_block_size and can try to keep its requests
aligned as an optimisation. But it doesn't actually make a semantic
difference as to how the content of the disk is accessed.

> (2) Setting only logical_block_size =3D 4096 is explicitly rejected by
> virtio-scsi:
>=20
> https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/scsi/scsi-disk.c;h=3D1=
0d0794d60f196f177563aae00bed2181f5c1bb1;hb=3DHEAD#l2352
>=20
> (A similar test exists for virtio-blk)
>=20
> (3) Setting both physical_block_size =3D logical_block_size =3D 4096
> changes how parted partitions GPT disks.  The partition table is
> clearly using 4K sectors as you can see by examining the disk
> afterwards with hexdump.

This is what you want for emulating a 4k native disk.

> (4) Neither setting changes MBR partitioning by parted, although my
> interpretation of Wikipedia indicates that it should be possible to
> create a MBR disk with 4K sector size.  Maybe I'm doing something
> wrong, or parted just doesn't support this case.

I seem to remember that 4k native disks require GPT, but if you say you
read otherwise, I'm not 100% sure about this any more.

> So it appears that we should just have one blocksize control (maybe
> called "sectorsize"?) which sets both physical_block_size and
> logical_block_size to the same value.  It may also be worth enforcing
> that blocksize/sectorsize must be set to 512 or 4096 (which we can
> relax later if necessary).

A single option (to control logical_block_size) makes sense for
libguestfs. physical_block_size is only relevant for the appliance and
not for the resulting image, so it can be treated as an implementation
detail.

Kevin


