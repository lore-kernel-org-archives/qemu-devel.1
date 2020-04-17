Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E56C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EEEE221EC
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 10:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="pwQvXuXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EEEE221EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOVp-0003oG-Ca
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 06:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jPOVB-0003PN-1R
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1jPOV9-0008Ie-PV
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:45:40 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jPOV9-0008H5-C2
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=3yRC8iCz9dgGRqOI/PyhAztOC209HGv1fk/R5Iv4Eb4=; b=pwQvXuXgtVhJ6pZA/vug+QWsLy
 VlbXXurqmugIYdgMca3TgNj1/EQevoN0JFY6joEHi2YSP7eeDjTEpcSaCJBfObuwz+zWHrq8CUH2M
 6MiCsWQgq8MamkqXqzmtKnNR2eiR65ybAuGYECL5SPuvKZelvTpwo4yuOSAiV26wASOyiumCn89vV
 K+27LKaoAa6vUAAGgBK54MmFrXxfgaZHCWKrAjWWHyPHyIKEPxkaqJsw2H2Hfh2ld5nj54INqggi8
 QCY+GLAvuSHVzSY27X5/+7kciACYWU+EtbDnCsMheT/M7SukuFUuKVh8BtDNwL3qa8C5rwvylzjuX
 EJ6xLTWQ==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Omar Sandoval <osandov@osandov.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: local: ignore O_NOATIME if we don't have permissions
Date: Fri, 17 Apr 2020 12:45:36 +0200
Message-ID: <1939315.5ePf2Jtb4B@silver>
In-Reply-To: <20200416184711.GB696015@vader>
References: <1e65cffe9778857735e7ae6066d6f0df0b0e2db3.1586997767.git.osandov@fb.com>
 <2496702.lrWaslOkEp@silver> <20200416184711.GB696015@vader>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.194.90.13
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 16. April 2020 20:47:11 CEST Omar Sandoval wrote:
> > > Luckily, O_NOATIME is effectively a hint, and is often ignored by, e.g.,
> > > network filesystems. open(2) notes that O_NOATIME "may not be effective
> > > on all filesystems. One example is NFS, where the server maintains the
> > > access time." This means that we can honor it when possible but fall
> > > back to ignoring it.
> > 
> > I am not sure whether NFS would simply silently ignore O_NOATIME i.e.
> > without returning EPERM. I don't read it that way.
> 
> As far as I can tell, the NFS protocol has nothing equivalent to
> O_NOATIME and thus can't honor it. Feel free to test it:

I did not doubt that NFS does not support O_NOATIME, what I said was that I 
thought using O_NOATIME on NFS would return EPERM, but ...

>   # mount -t nfs -o vers=4,rw 10.0.2.2:/ /mnt
>   # echo foo > /mnt/foo
>   # touch -d "1 hour ago" /mnt/foo
>   # stat /mnt/foo | grep 'Access: [0-9]'
>   Access: 2020-04-16 10:43:36.838952593 -0700
>   # # Drop caches so we have to go to the NFS server.
>   # echo 3 > /proc/sys/vm/drop_caches
>   # strace -e openat dd if=/mnt/foo of=/dev/null iflag=noatime |& grep
> /mnt/foo openat(AT_FDCWD, "/mnt/foo", O_RDONLY|O_NOATIME) = 3
>   # stat /mnt/foo | grep 'Access: [0-9]'
>   Access: 2020-04-16 11:43:36.906462928 -0700

... I tried this as well, and you are right, O_NOATIME is indeed simply 
*silently* dropped/ignored by NFS (i.e. without raising any error).

> > It would certainly fix the problem in your use case. But it would also
> > unmask O_NOATIME for all other ones (i.e. regular users on guest).
> 
> The guest kernel will still check whether processes on the guest have
> permission to use O_NOATIME. This only changes the behavior when the
> guest kernel believes that the process has permission even though the
> host QEMU process doesn't.

Good point!

> > I mean I understand your point, but I also have to take other use cases
> > into account which might expect to receive EPERM if O_NOATIME cannot be
> > granted.
> If you'd still like to preserve this behavior, would it be acceptable to
> make this a QEMU option? Maybe something like "-virtfs
> honor_noatime=no": the default would be "yes", which is the current
> behavior, and "no" would always mask out NOATIME.

That was my initial tendency yesterday, but your arguments now convinced me 
that the implied re-run, in the way your provided patch already does, is in 
this particular case the better choice.

Making that a configurable option would render this issue unnecessarily 
complicated and probably even contra productive for other users which might 
stumble over the same issue.

Just do me a favour: you already thoroughly explained the issue in the commit 
log, that's good, but please also add a short comment in code why the rerun is 
required, because it is not obvious by just reading the code. Finding that 
info from git log becomes tedious as soon as code is refactored there.

Aside of the missing comment in code:

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Best regards,
Christian Schoenebeck



