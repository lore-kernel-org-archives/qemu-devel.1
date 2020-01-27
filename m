Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D478C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC86F206A2
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL1I5xqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC86F206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2Eu-0007Ym-3P
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48178)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2D2-0004R4-TG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iw2D1-0005lt-Aa
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:05:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34069
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iw2D1-0005lO-66
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580123134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U14zDHAAUsI/iH4k7uZbT+sMckbxTcQ6gy2p9o1U/x8=;
 b=VL1I5xqmEabL4XQ3PWP5n4KThvS6IMI2W7I5nlYXpQa6cUc2tR3OREBmHIvDyKNOlAzTK5
 RCEaC+Gkf4H3QKWI6Fo8N5sl0+8N8wJ9QNmvO31N8Zp31zxhDTOMM9BMa5VE2H8c3Y1iew
 A8UUpRJ2+Ogflz8Cfgguk4r/lsKbVmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-u1EF-TazOCuO7nXLXZNECg-1; Mon, 27 Jan 2020 06:05:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A4B9800D48;
 Mon, 27 Jan 2020 11:05:25 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79E851BC6D;
 Mon, 27 Jan 2020 11:05:23 +0000 (UTC)
Message-ID: <f3b90836b28bcc59876fb3692a8344bd13d01d1d.camel@redhat.com>
Subject: Re: [PATCH 8/9] monitor: move hmp_info_block* to blockdev-hmp-cmds.c
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Jan 2020 13:05:22 +0200
In-Reply-To: <87blsxkahl.fsf@dusky.pond.sub.org>
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-9-mlevitsk@redhat.com>
 <87blsxkahl.fsf@dusky.pond.sub.org>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: u1EF-TazOCuO7nXLXZNECg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-27 at 09:08 +0100, Markus Armbruster wrote:
> I think it makes sense to collect *all* block HMP stuff here.
> 
> Left in monitor/hmp-cmds.c: hmp_eject(), hmp_nbd_server_start(), ...
> 
> I guess hmp_change() has to stay there, because it's both block and ui.
> 
> Left in blockdev.c: hmp_drive_add_node().

Thank you very much. I added these and bunch more to my patchset.

> 
> Quick grep for possible files to check:
> 
> $ git-grep -l 'monitor[a-z_-]*.h' | xargs grep -l 'block[a-z_-]*\.h'
> MAINTAINERS
> blockdev-hmp-cmds.c
> 

> blockdev.c
hmp_drive_add_node is there and I moved it too.


> cpus.c
Nothing suspicious

> dump/dump.c
qmp_dump_guest_memory is only monitor reference there I think

> hw/display/qxl.c
No way that is related to the block layer

> hw/scsi/vhost-scsi.c
All right, the monitor_fd_param is an interesting thing.
Not related to block though.

> hw/usb/dev-storage.c
All right, this for no reason includes monitor/monitor.h,
added patch to remove this because why not.

> include/monitor/monitor.h
Nothing suspicious

> migration/migration.c
Nothing suspicious

> monitor/hmp-cmds.c
Added hmp_qemu_io

Maybe I need to add hmp_delvm too?
savevm/delvm do old style snapshots
which are stored to the first block device


> monitor/hmp.c
There are some block references in monitor_find_completion,
but I guess it is not worth it to move that

> monitor/misc.c
vm_completion for delvm/loadvm.

> monitor/qmp-cmds.c
Nothing hmp related at first glance.

> qdev-monitor.c
blk_by_qdev_id - used by both hmp and qmp code

> vl.c
Hopefully nothing hmp+block related, I searched the file for
few things but I can't be fully sure.
Out of the curiosity do you know why this file is called like that,
since it hosts qemu main(), shouldn't it be called main.c ?


Best regards and thanks for the detailed review!
	Maxim Levitsky




