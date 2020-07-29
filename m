Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6225C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7545F2075F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="ZnSZlSm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7545F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0q36-0005uZ-Os
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 13:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0q2R-0005UE-Hz
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:38:49 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:55507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1k0q2K-00065U-5p
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 13:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=PWo66lvoHSq9UAOoHaMjoWJWu4LkM4e1HqyE9OVAfOY=; b=ZnSZlSm+alLv3vccXhD7iWtxew
 MIiBJAio7gZ3anzZ5xB/eM7L4gGpINWRoXPIVTLkNHoDV3TcOuKhA5T4ZfeMm/jC2FCosjHojk5Lc
 Ynbostl5a5GToI4ySkBA13HW3FR4w4N81moVrNyrFURIrT6iACvTMcg+iB/chadPNgCL6scHttstA
 SQmPJbpKFkpS2FDmVoKnDK1PQ6b7CouchIBlyfCAc+W9fznLSQKU+wRCAHgIy3t3M/quA0Z4XaxCH
 tv9R7bgjyxq9n2ZPoIzpib7bt3qRE0PAulxvezE7hdEsJgr0+BaYmjdJHiHFFQ6rXvIDpA8ADsqpW
 KxBgT7nw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v8 3/7] 9pfs: split out fs driver core of v9fs_co_readdir()
Date: Wed, 29 Jul 2020 19:38:36 +0200
Message-ID: <4434973.n5yQ5FX491@silver>
In-Reply-To: <20200729180256.23eca3e0@bahia.lan>
References: <cover.1596012787.git.qemu_oss@crudebyte.com>
 <a426ee06e77584fa2d8253ce5d8bea519eb3ffd4.1596012787.git.qemu_oss@crudebyte.com>
 <20200729180256.23eca3e0@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 13:24:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 29. Juli 2020 18:02:56 CEST Greg Kurz wrote:
> On Wed, 29 Jul 2020 10:11:54 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > The implementation of v9fs_co_readdir() has two parts: the outer
> > part is executed by main I/O thread, whereas the inner part is
> > executed by fs driver on a background I/O thread.
> > 
> > Move the inner part to its own new, private function do_readdir(),
> > so it can be shared by another upcoming new function.
> > 
> > This is just a preparatory patch for the subsequent patch, with the
> > purpose to avoid the next patch to clutter the overall diff.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  hw/9pfs/codir.c | 37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
> > index 73f9a751e1..ff57fb8619 100644
> > --- a/hw/9pfs/codir.c
> > +++ b/hw/9pfs/codir.c
> > @@ -18,28 +18,37 @@
> > 
> >  #include "qemu/main-loop.h"
> >  #include "coth.h"
> > 
> > +/*
> > + * This must solely be executed on a background IO thread.
> > + */
> 
> Well, technically this function could be called from any context
> but of course calling it from the main I/O thread when handling
> T_readdir would make the request synchronous, which is certainly
> not what we want. So I'm not sure this comment brings much.

Yeah, the intention was to more clearly separate functions' intended usage 
context either being TH or rather BH focused, by sticking appropriate human-
readable API comments to them.

But you are right, the TH functions are more limited in this regards as they 
usually contain a co-routine dispatch call, whereas BH functions usually 
preserve a more flexible/universal nature.

So maybe rather:

/*
 * Intended to be called from bottom-half (e.g. background I/O thread) 
 * context.
 */

On doubt I can also just drop the comment, as the function is really quite 
simple.

> Anyway, the code change is okay so:
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> > +static int do_readdir(V9fsPDU *pdu, V9fsFidState *fidp, struct dirent
> > **dent) +{
> > +    int err = 0;
> > +    V9fsState *s = pdu->s;
> > +    struct dirent *entry;
> > +
> > +    errno = 0;
> > +    entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > +    if (!entry && errno) {
> > +        *dent = NULL;
> > +        err = -errno;
> > +    } else {
> > +        *dent = entry;
> > +    }
> > +    return err;
> > +}
> > +
> > 
> >  int coroutine_fn v9fs_co_readdir(V9fsPDU *pdu, V9fsFidState *fidp,
> >  
> >                                   struct dirent **dent)
> >  
> >  {
> >  
> >      int err;
> > 
> > -    V9fsState *s = pdu->s;
> > 
> >      if (v9fs_request_cancelled(pdu)) {
> >      
> >          return -EINTR;
> >      
> >      }
> > 
> > -    v9fs_co_run_in_worker(
> > -        {
> > -            struct dirent *entry;
> > -
> > -            errno = 0;
> > -            entry = s->ops->readdir(&s->ctx, &fidp->fs);
> > -            if (!entry && errno) {
> > -                err = -errno;
> > -            } else {
> > -                *dent = entry;
> > -                err = 0;
> > -            }
> > -        });
> > +    v9fs_co_run_in_worker({
> > +        err = do_readdir(pdu, fidp, dent);
> > +    });
> > 
> >      return err;
> >  
> >  }




