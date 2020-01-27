Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB964C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:55:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A8D207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMoXVOIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A8D207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4rS-0001j3-LY
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:55:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw4qk-00016Y-NJ
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw4qi-0000mM-Fq
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55462
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw4qg-0000kY-Vm
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580133282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWNPfH9iDtTfSVr70t15jeD9NtyfQH3GjcSgtfZSHEo=;
 b=IMoXVOIB7NvzCMkCeLzbcpuuiOYbtHDrrtBhNEmfLIhRokTLi6/ja03GJuoXaDdgOXxcll
 QAIZMU4jjYZ3BOtVS8NkpSIPy4Hr/2knXfrrQOO75dWsrvE3QLSrBIR9ElJxwnBatsE2GF
 iUMDnAcK7d3nkw6LIRFCkqhLz+nfqrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ImGhBmmQOpaoMpBsEPTQBQ-1; Mon, 27 Jan 2020 08:54:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 918DDDB60;
 Mon, 27 Jan 2020 13:54:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F384E88820;
 Mon, 27 Jan 2020 13:54:37 +0000 (UTC)
Message-ID: <3857b9ee3a4cdf7aae16b065bc8d7ae776f58138.camel@redhat.com>
Subject: Re: [PATCH 8/9] monitor: move hmp_info_block* to blockdev-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 15:54:37 +0200
In-Reply-To: <878sltowh4.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-9-mlevitsk@redhat.com>
 <87blsxkahl.fsf@dusky.pond.sub.org>
 <f3b90836b28bcc59876fb3692a8344bd13d01d1d.camel@redhat.com>
 <878sltowh4.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ImGhBmmQOpaoMpBsEPTQBQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2020-01-27 at 14:33 +0100, Markus Armbruster wrote:
> Maxim Levitsky <mlevitsk@redhat.com> writes:
> 
> > On Wed, 2019-11-27 at 09:08 +0100, Markus Armbruster wrote:
> > > I think it makes sense to collect *all* block HMP stuff here.
> > > 
> > > Left in monitor/hmp-cmds.c: hmp_eject(), hmp_nbd_server_start(), ...
> > > 
> > > I guess hmp_change() has to stay there, because it's both block and ui.
> > > 
> > > Left in blockdev.c: hmp_drive_add_node().
> > 
> > Thank you very much. I added these and bunch more to my patchset.
> > 
> > > 
> > > Quick grep for possible files to check:
> > > 
> > > $ git-grep -l 'monitor[a-z_-]*.h' | xargs grep -l 'block[a-z_-]*\.h'
> > > MAINTAINERS
> > > blockdev-hmp-cmds.c
> > > 
> > > blockdev.c
> > 
> > hmp_drive_add_node is there and I moved it too.
> > 
> > 
> > > cpus.c
> > 
> > Nothing suspicious
> > 
> > > dump/dump.c
> > 
> > qmp_dump_guest_memory is only monitor reference there I think
> > 
> > > hw/display/qxl.c
> > 
> > No way that is related to the block layer
> > 
> > > hw/scsi/vhost-scsi.c
> > 
> > All right, the monitor_fd_param is an interesting thing.
> > Not related to block though.
> > 
> > > hw/usb/dev-storage.c
> > 
> > All right, this for no reason includes monitor/monitor.h,
> > added patch to remove this because why not.
> > 
> > > include/monitor/monitor.h
> > 
> > Nothing suspicious
> > 
> > > migration/migration.c
> > 
> > Nothing suspicious
> > 
> > > monitor/hmp-cmds.c
> > 
> > Added hmp_qemu_io
> > 
> > Maybe I need to add hmp_delvm too?
> > savevm/delvm do old style snapshots
> > which are stored to the first block device
> 
> One foot in the block subsystem, the other foot in the migration
> subsystem.  I'm not sure where this should go.  Kevin?
> 
> > > monitor/hmp.c
> > 
> > There are some block references in monitor_find_completion,
> > but I guess it is not worth it to move that
> > 
> > > monitor/misc.c
> > 
> > vm_completion for delvm/loadvm.
> 
> Having completion close to whatever it completes would be nice, I guess.
> 
> When in doubt, leave the savevm / delvm stuff alone.
Yep.

> 
> > > monitor/qmp-cmds.c
> > 
> > Nothing hmp related at first glance.
> > 
> > > qdev-monitor.c
> > 
> > blk_by_qdev_id - used by both hmp and qmp code
> > 
> > > vl.c
> > 
> > Hopefully nothing hmp+block related, I searched the file for
> > few things but I can't be fully sure.
> > Out of the curiosity do you know why this file is called like that,
> > since it hosts qemu main(), shouldn't it be called main.c ?
> 
> Its first commit 0824d6fc67 "for hard core developpers only: a new user
> mode linux project :-)" calls the executable "vl", and has
> 
>     void help(void)
>     {
>         printf("Virtual Linux version " QEMU_VERSION ", Copyright (c) 2003 Fabrice Bellard\n"
>                "usage: vl [-h] bzImage initrd [kernel parameters...]\n"
>                "\n"
>     [...]
>         exit(1);
>     }
> 
> The executable was renamed soon after.  I guess the source file name has
> made people wonder ever since.
Nice :-)

> 
> > 
> > Best regards and thanks for the detailed review!
> > 	Maxim Levitsky
> 
> You're welcome!

I hope we can move forward with this patch series as well.

Best regards,
	Maxim Levitsky



