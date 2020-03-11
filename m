Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD938C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:21:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F0E20848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 09:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaLiylAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F0E20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBxYF-0006aI-Lg
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 05:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47675)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jBxXY-00060V-LE
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jBxXX-0006gt-FG
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 05:20:36 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34989)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jBxXT-0006fo-9w; Wed, 11 Mar 2020 05:20:31 -0400
Received: by mail-qt1-x843.google.com with SMTP id v15so1025095qto.2;
 Wed, 11 Mar 2020 02:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=APmIVqmBsoZXs5rkYmbco9uylxdJj5LRenwxKDqG8N4=;
 b=oaLiylAkF8GJTuUMNXaoTX6KRI2Kfk56S7WJhh6FgiPalpoZuF5lB93zUOF2Ape4jj
 MEKhADVgGehj044gJVU0V/ruRqQY+K4ywXqrQQngpj2CmmVKiyEmSuf2amPvt4orF8+7
 1L3vvxgJEnyIRwWbKU0a44XeBeJFW8XmhVFESJWOWXjUpLOSU/5011yEfE3l9UEOtj+4
 IBZs7UnYQQqPtzbWXfLt6huYz7P++wUip6+KjpY0rp+bpKPpUvs9PF8nVqaDHPCp5N5e
 dONMpJ/EJnBJ6yRCpZUyzLZEXoXf6ahHyjGeyv+v2EnbtGLScxCZ/aFkf5iP3g57AKmC
 IQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=APmIVqmBsoZXs5rkYmbco9uylxdJj5LRenwxKDqG8N4=;
 b=DmflCuS1kqykK1YaBbfJmC4aRhv5+LHGX8eS5N8cUuQ5Oiiu8/sDhawYDgg7kcmh10
 BrkQOxDs3ahfhL1dmJehfIKZbR8IYcAGyKGHoHSeaciXyZr3jxFycv+FAVyFBvup/Lsw
 ux4DVwNhFjGty2Z1dHH3G9dJ0qjE2BGRDcXsAxJ5ztziheUqUpmpJiMmpKxp9QnKM5cc
 6xi2SpFbHMW+sOeWpB6dNdQpe/TzYjrRxvF8TYxm4z+LcsEDpg2BiYH81/poGE69UYG/
 RbE9Oa9k0kAWfZHwZfnAaSRC050yrxWYIIRfR4uDcJ1Ju6UaeaMRbdKdufOXM1b4LAuf
 JF9A==
X-Gm-Message-State: ANhLgQ1uhuBljhB0+xmkhMA9htveSOp44sjGSu2D48IckbhTU3O6HPBF
 5SR41pkXd57QRB+a8lI17uygDndDiGPgpq+PFaI=
X-Google-Smtp-Source: ADFU+vvZOBJwuoVTk/+yOX+QPJLlcNKL5tQEDAjMgzwzR9iAisZ6JEfjntDC/XGVCdRImnmaghuQUxHGQpN+MRVqNsc=
X-Received: by 2002:ac8:48c7:: with SMTP id l7mr1746078qtr.174.1583918430655; 
 Wed, 11 Mar 2020 02:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200306223853.37958-1-andrzej.jakowski@linux.intel.com>
 <20200310095147.GC140737@stefanha-x1.localdomain>
 <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
In-Reply-To: <15b8a77d-50de-2228-a0e6-a461b82f1873@linux.intel.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Mar 2020 09:20:18 +0000
Message-ID: <CAJSP0QXatOWgicLo5sGt9KA2QupC2qXD2LCdHWKgHFdzgt9pEg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] block/nvme: introduce PMR support from NVMe 1.4
 spec
To: Andrzej Jakowski <andrzej.jakowski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>,
 qemu block <qemu-block@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Zhang Yi <yi.z.zhang@linux.intel.com>, "He,
 Junyan" <junyan.he@intel.com>, kbusch@kernel.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 8:09 PM Andrzej Jakowski
<andrzej.jakowski@linux.intel.com> wrote:
> On 3/10/20 2:51 AM, Stefan Hajnoczi wrote:
> > On Fri, Mar 06, 2020 at 03:38:53PM -0700, Andrzej Jakowski wrote:
> >> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> >> index d28335cbf3..ff7e74d765 100644
> >> --- a/hw/block/nvme.c
> >> +++ b/hw/block/nvme.c
> >> @@ -19,10 +19,14 @@
> >>   *      -drive file=<file>,if=none,id=<drive_id>
> >>   *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
> >>   *              cmb_size_mb=<cmb_size_mb[optional]>, \
> >> + *              [pmr_file=<pmr_file_path>,] \
> >>   *              num_queues=<N[optional]>
> >>   *
> >>   * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
> >>   * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
> >> + *
> >> + * Either cmb or pmr - due to limitation in avaialbe BAR indexes.
> >
> > s/avaialbe/available/
> >
> >> + * pmr_file file needs to be preallocated and power of two in size.
> >
> > Why does it need to be preallocated?
>
> PMR file is mmaped into address space. If memory accesses are made outside of
> file then SIGBUS signal is raised. Preallocation requirement was introduced
> to prevent this situation.

Oh, I think I see what you mean.  That is not how the term
"preallocated" is usually used in POSIX file systems.  File systems
have sparse files by default and the term preallocation is used in the
context of fadvise(2) for reserving space.

In this case I think you're saying the file cannot grow.  That is
implicit since the BAR can't grow either so you could drop the comment
about preallocation.

> >
> >>   */
> >>
> >>  #include "qemu/osdep.h"
> >> @@ -1141,6 +1145,28 @@ static void nvme_write_bar(NvmeCtrl *n, hwaddr offset, uint64_t data,
> >>          NVME_GUEST_ERR(nvme_ub_mmiowr_cmbsz_readonly,
> >>                         "invalid write to read only CMBSZ, ignored");
> >>          return;
> >> +#ifndef _WIN32
> >
> > This ifdef is a hint that the layering is not right.  QEMU device models
> > usually only implement the "frontend" device registers, interrupts, and
> > request processing logic.  The platform-specific host "backend"
> > (mmapping files, sending network packets, audio/graphics APIs, etc) is
> > implemented separately.
>
> Agree. I couldn't find QEMU backend ensuring persistence - thus decided to
> go with mmap.

Please try:

  $ git grep pmem

backends/hostmem-file.c is the backend that can be used and the
pmem_persist() API can be used to flush writes.

