Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D758C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586BE20716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bH9ZhU9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586BE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4Wp-0001uj-CT
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iw4W2-0000z0-Tn
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:33:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iw4W1-0005gr-II
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:33:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57691
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iw4W1-0005gQ-Es
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580132001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzdDdrY6WlpUM9JBDhs0ERS25v+EQEoa1JwFKcZ9h1k=;
 b=bH9ZhU9is8xun9Nc35976Mh/8STqcDpq9deuhjHJndf8aKQh8Gc+iFB3VFuMEMcwErkRPX
 74bQaKdSfwGT3/VoanNxb7ZDu+yE+AkMH/vbXJLRgNWOp0RtC3I/uA27BEUZVaacc5kfsB
 l84Zvt/uK865AZDl9ogVWc3TkeJI9ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-nZQ45OHnNjuTm40wdDaCSw-1; Mon, 27 Jan 2020 08:33:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB7AC18CA243;
 Mon, 27 Jan 2020 13:33:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86262863CF;
 Mon, 27 Jan 2020 13:33:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 06EF21138600; Mon, 27 Jan 2020 14:33:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 8/9] monitor: move hmp_info_block* to blockdev-hmp-cmds.c
References: <20191120185850.18986-1-mlevitsk@redhat.com>
 <20191120185850.18986-9-mlevitsk@redhat.com>
 <87blsxkahl.fsf@dusky.pond.sub.org>
 <f3b90836b28bcc59876fb3692a8344bd13d01d1d.camel@redhat.com>
Date: Mon, 27 Jan 2020 14:33:11 +0100
In-Reply-To: <f3b90836b28bcc59876fb3692a8344bd13d01d1d.camel@redhat.com>
 (Maxim Levitsky's message of "Mon, 27 Jan 2020 13:05:22 +0200")
Message-ID: <878sltowh4.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: nZQ45OHnNjuTm40wdDaCSw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Maxim Levitsky <mlevitsk@redhat.com> writes:

> On Wed, 2019-11-27 at 09:08 +0100, Markus Armbruster wrote:
>> I think it makes sense to collect *all* block HMP stuff here.
>>=20
>> Left in monitor/hmp-cmds.c: hmp_eject(), hmp_nbd_server_start(), ...
>>=20
>> I guess hmp_change() has to stay there, because it's both block and ui.
>>=20
>> Left in blockdev.c: hmp_drive_add_node().
>
> Thank you very much. I added these and bunch more to my patchset.
>
>>=20
>> Quick grep for possible files to check:
>>=20
>> $ git-grep -l 'monitor[a-z_-]*.h' | xargs grep -l 'block[a-z_-]*\.h'
>> MAINTAINERS
>> blockdev-hmp-cmds.c
>>=20
>
>> blockdev.c
> hmp_drive_add_node is there and I moved it too.
>
>
>> cpus.c
> Nothing suspicious
>
>> dump/dump.c
> qmp_dump_guest_memory is only monitor reference there I think
>
>> hw/display/qxl.c
> No way that is related to the block layer
>
>> hw/scsi/vhost-scsi.c
> All right, the monitor_fd_param is an interesting thing.
> Not related to block though.
>
>> hw/usb/dev-storage.c
> All right, this for no reason includes monitor/monitor.h,
> added patch to remove this because why not.
>
>> include/monitor/monitor.h
> Nothing suspicious
>
>> migration/migration.c
> Nothing suspicious
>
>> monitor/hmp-cmds.c
> Added hmp_qemu_io
>
> Maybe I need to add hmp_delvm too?
> savevm/delvm do old style snapshots
> which are stored to the first block device

One foot in the block subsystem, the other foot in the migration
subsystem.  I'm not sure where this should go.  Kevin?

>> monitor/hmp.c
> There are some block references in monitor_find_completion,
> but I guess it is not worth it to move that
>
>> monitor/misc.c
> vm_completion for delvm/loadvm.

Having completion close to whatever it completes would be nice, I guess.

When in doubt, leave the savevm / delvm stuff alone.

>> monitor/qmp-cmds.c
> Nothing hmp related at first glance.
>
>> qdev-monitor.c
> blk_by_qdev_id - used by both hmp and qmp code
>
>> vl.c
> Hopefully nothing hmp+block related, I searched the file for
> few things but I can't be fully sure.
> Out of the curiosity do you know why this file is called like that,
> since it hosts qemu main(), shouldn't it be called main.c ?

Its first commit 0824d6fc67 "for hard core developpers only: a new user
mode linux project :-)" calls the executable "vl", and has

    void help(void)
    {
        printf("Virtual Linux version " QEMU_VERSION ", Copyright (c) 2003 =
Fabrice Bellard\n"
               "usage: vl [-h] bzImage initrd [kernel parameters...]\n"
               "\n"
    [...]
        exit(1);
    }

The executable was renamed soon after.  I guess the source file name has
made people wonder ever since.

>
> Best regards and thanks for the detailed review!
> =09Maxim Levitsky

You're welcome!


