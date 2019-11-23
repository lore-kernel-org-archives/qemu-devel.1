Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C5C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 15:30:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6079120706
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 15:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6079120706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYXMy-0005dE-Gx
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 10:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iYXMD-00059m-4B
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:29:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iYXMB-0001De-Ie
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:29:56 -0500
Received: from 3.mo2.mail-out.ovh.net ([46.105.58.226]:57705)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iYXMB-0001Bj-CL
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:29:55 -0500
Received: from player730.ha.ovh.net (unknown [10.109.160.93])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5BB701B604B
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 16:29:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id E6671C53416C;
 Sat, 23 Nov 2019 15:29:41 +0000 (UTC)
Date: Sat, 23 Nov 2019 16:29:40 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix divide by zero bug
Message-ID: <20191123162940.1e3a74cb@bahia.lan>
In-Reply-To: <1786866.o8IioZIX2y@silver>
References: <20191122200034.122564-1-dschatzberg@fb.com>
 <1786866.o8IioZIX2y@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5793880922746755392
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehiedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeftddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.226
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
Cc: qemu-devel@nongnu.org, Dan Schatzberg <dschatzberg@fb.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 22:53:09 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 22. November 2019 21:00:34 CET Dan Schatzberg wrote:
> > Some filesystems may return 0s in statfs (trivially, a FUSE filesystem
> > can do so). QEMU should handle this gracefully and just behave the
> > same as if statfs failed.
> 
> Is that actually legal in non-error cases? Shouldn't a driver without a block 
> size concept return 512 according to POSIX?
> 

The first problem I see is that statfs() isn't POSIX. It is a linux-specific
implementation inspired by 4.4BSD. The equivalent system call in POSIX would
be statvfs():

https://pubs.opengroup.org/onlinepubs/9699919799/functions/statvfs.html

And even there, no details are provided about what f_bsize should contain,
apart from:

"It is unspecified whether all members of the statvfs structure have
 meaningful values on all file systems."

A filesystem isn't necessarily backed by a block device, so I guess it
is legal to get a zero block size and we should definitely cope with it.

> > Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>
> > ---
> >  hw/9pfs/9p.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 37abcdb71e..520177f40c 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1834,8 +1834,10 @@ static int32_t coroutine_fn get_iounit(V9fsPDU *pdu,
> > V9fsPath *path) * and as well as less than (client msize - P9_IOHDRSZ))
> >       */
> >      if (!v9fs_co_statfs(pdu, path, &stbuf)) {
> > -        iounit = stbuf.f_bsize;
> > -        iounit *= (s->msize - P9_IOHDRSZ)/stbuf.f_bsize;
> > +        if (stbuf.f_bsize) {
> > +            iounit = stbuf.f_bsize;
> > +            iounit *= (s->msize - P9_IOHDRSZ) / stbuf.f_bsize;
> > +        }
> >      }
> >      if (!iounit) {
> >          iounit = s->msize - P9_IOHDRSZ;
> 
> Nevertheless, since that will leave iounit initialized with zero and since 
> there is already an !ionunit case handling there ...
> 

This fix looks like the only sensible thing to do.

> Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 

Thanks for the Cc otherwise I would have certainly missed this one :)

I've pushed it to my 9p-fix branch and I'll send a pull request ASAP
in order to have this fixed in rc3.

> Best regards,
> Christian Schoenebeck
> 
> 


