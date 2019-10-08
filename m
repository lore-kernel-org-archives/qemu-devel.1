Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACF6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 07:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CD2206C2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 07:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CD2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHjyp-0008MA-Dv
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHjxZ-0007cN-Gx
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 03:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHjxW-0000Xg-DE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 03:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iHjxC-0000QL-40; Tue, 08 Oct 2019 03:30:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C8F619D369;
 Tue,  8 Oct 2019 07:30:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 754BE5D9D3;
 Tue,  8 Oct 2019 07:30:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB1D01138648; Tue,  8 Oct 2019 09:30:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v4 00/31] error: auto propagated local_err
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
Date: Tue, 08 Oct 2019 09:30:18 +0200
In-Reply-To: <20191001155319.8066-1-vsementsov@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Oct 2019 18:52:48 +0300")
Message-ID: <87eeznn185.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 08 Oct 2019 07:30:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org, kraxel@redhat.com, mreitz@redhat.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, joel@jms.id.au, marcandre.lureau@redhat.com,
 david@gibson.dropbear.id.au, farman@linux.ibm.com, ehabkost@redhat.com,
 sw@weilnetz.de, groug@kaod.org, yuval.shaia@oracle.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, clg@kaod.org,
 stefanha@redhat.com, david@redhat.com, jsnow@redhat.com, rth@twiddle.net,
 kwolf@redhat.com, integration@gluster.org, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org,
 sundeep.lkml@gmail.com, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Hi all!
>
> Here is a proposal of auto propagation for local_err, to not call
> error_propagate on every exit point, when we deal with local_err.
>
> There are also two issues with errp:
>
> 1. error_fatal & error_append_hint/error_prepend: user can't see this
> additional info, because exit() happens in error_setg earlier than info
> is added. [Reported by Greg Kurz]

How is this series related to Greg's "[PATCH 00/17] Fix usage of
error_append_hint()"?  Do we need both?

> 2. error_abort & error_propagate: when we wrap
> error_abort by local_err+error_propagate, resulting coredump will
> refer to error_propagate and not to the place where error happened.
> (the macro itself don't fix the issue, but it allows to [3.] drop all
> local_err+error_propagate pattern, which will definitely fix the issue)
> [Reported by Kevin Wolf]
>
> Still, applying new macro to all errp-functions is a huge task, which is
> impossible to solve in one series.
>
> So, here is a minimum: solve only [1.], by adding new macro to all
> errp-functions which wants to call error_append_hint.
>
> v4;
> 02: - check errp to be not NULL
>     - drop Eric's r-b
> 03: add Eric's r-b
> 04: - rename macro to ERRP_AUTO_PROPAGATE [Kevin]
>     - improve comment and commit msg, mention
>       error_prepend
> 05: - handle error_prepend too
>     - use new macro name
>     - drop empty line at the end
>
> commit message for auto-generated commits updated,
> commits regenerated.
>
> I'll use cc-cmd to cc appropriate recipients per patch, still
> cover-letter together with 04-06 patches should be interesting for
> all:
[...]

Big series; let me guess its structure.

> Vladimir Sementsov-Ogievskiy (31):
>   errp: rename errp to errp_in where it is IN-argument
>   hw/core/loader-fit: fix freeing errp in fit_load_fdt
>   net/net: fix local variable shadowing in net_client_init

Preparations.

>   error: auto propagated local_err

The new idea.

>   scripts: add script to fix error_append_hint/error_prepend usage
>   python: add commit-per-subsystem.py

Scripts to help you apply it.

>   s390: Fix error_append_hint/error_prepend usage
>   ARM TCG CPUs: Fix error_append_hint/error_prepend usage
>   PowerPC TCG CPUs: Fix error_append_hint/error_prepend usage
>   arm: Fix error_append_hint/error_prepend usage
>   SmartFusion2: Fix error_append_hint/error_prepend usage
>   ASPEED BMCs: Fix error_append_hint/error_prepend usage
>   Boston: Fix error_append_hint/error_prepend usage
>   PowerNV (Non-Virtualized): Fix error_append_hint/error_prepend usage
>   PCI: Fix error_append_hint/error_prepend usage
>   SCSI: Fix error_append_hint/error_prepend usage
>   USB: Fix error_append_hint/error_prepend usage
>   VFIO: Fix error_append_hint/error_prepend usage
>   vhost: Fix error_append_hint/error_prepend usage
>   virtio: Fix error_append_hint/error_prepend usage
>   virtio-9p: Fix error_append_hint/error_prepend usage
>   XIVE: Fix error_append_hint/error_prepend usage
>   block: Fix error_append_hint/error_prepend usage
>   chardev: Fix error_append_hint/error_prepend usage
>   cmdline: Fix error_append_hint/error_prepend usage
>   QOM: Fix error_append_hint/error_prepend usage
>   Migration: Fix error_append_hint/error_prepend usage
>   Sockets: Fix error_append_hint/error_prepend usage
>   nbd: Fix error_append_hint/error_prepend usage
>   PVRDMA: Fix error_append_hint/error_prepend usage
>   ivshmem: Fix error_append_hint/error_prepend usage

Applying it.

Correct?

[...]

