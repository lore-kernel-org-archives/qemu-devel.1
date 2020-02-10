Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265DEC352A3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E300E20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 11:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIgZ8Ilm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E300E20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j17U2-0003aX-VO
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 06:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1j17TM-00036B-EE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1j17TK-0006dJ-Jd
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:43:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56972
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1j17TK-0006cn-Fg
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 06:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581335005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFfk2qL1MEp6uvjStfGuGk9XdqcASnDP2fJin18aIPc=;
 b=eIgZ8IlmBk744SBBZ4QCiqf8kCS+kBHR3/RN8+aRC2P7LJYglHgO2HFQ6y+ySMT5KE/JVo
 o4otitL+fAI7/ZfIwLHuvJxd3+uHbAaI5Y4eos291pAALoh9I/YJm+OVG/1kEAr3J7jPPJ
 uBtbCvp3bFnM3e8JFBKtBnEDfnKELvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-2dPVMSL0PBSjBjubmPUZNA-1; Mon, 10 Feb 2020 06:43:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C5911800D42;
 Mon, 10 Feb 2020 11:43:20 +0000 (UTC)
Received: from localhost (unknown [10.36.118.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A26B61001281;
 Mon, 10 Feb 2020 11:43:17 +0000 (UTC)
Date: Mon, 10 Feb 2020 11:43:16 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Mykola Ivanets <stenavin@gmail.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [Libguestfs] [RFC] lib: allow to specify physical/logical block
 size for disks
Message-ID: <20200210114316.GW3888@redhat.com>
References: <20200207232528.13461-1-stenavin@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200207232528.13461-1-stenavin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 2dPVMSL0PBSjBjubmPUZNA-1
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
Cc: libguestfs@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Feb 08, 2020 at 01:25:28AM +0200, Mykola Ivanets wrote:
> From: Nikolay Ivanets <stenavin@gmail.com>
>=20
> I faced with situation where libguestfs cannot recognize partitions on a
> disk image which was partitioned on a system with "4K native" sector
> size support.

Do you have a small test case for this?

> In order to fix the issue we need to allow users to specify desired
> physical and/or logical block size per drive basis.

It seems like physical_block_size / logical_block_size in qemu are
completely undocumented.  However I did some experiments with patching
libguestfs and examining the qemu and parted code.  Here are my
observations:

(1) Setting only physical_block_size =3D 4096 seems to do nothing.

(2) Setting only logical_block_size =3D 4096 is explicitly rejected by
virtio-scsi:

https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/scsi/scsi-disk.c;h=3D10d=
0794d60f196f177563aae00bed2181f5c1bb1;hb=3DHEAD#l2352

(A similar test exists for virtio-blk)

(3) Setting both physical_block_size =3D logical_block_size =3D 4096
changes how parted partitions GPT disks.  The partition table is
clearly using 4K sectors as you can see by examining the disk
afterwards with hexdump.

(4) Neither setting changes MBR partitioning by parted, although my
interpretation of Wikipedia indicates that it should be possible to
create a MBR disk with 4K sector size.  Maybe I'm doing something
wrong, or parted just doesn't support this case.

So it appears that we should just have one blocksize control (maybe
called "sectorsize"?) which sets both physical_block_size and
logical_block_size to the same value.  It may also be worth enforcing
that blocksize/sectorsize must be set to 512 or 4096 (which we can
relax later if necessary).

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


