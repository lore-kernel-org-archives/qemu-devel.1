Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CF3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3012E20732
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 14:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AycPI9OA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3012E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9rmY-0008Hz-Bl
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 09:47:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j9rhW-0001De-Jb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j9rhQ-0004fl-Iq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:42:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j9rhQ-0004em-EJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 09:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583419327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Y1TpzWyVomtii9gDt42fMqEW8ONPhTPB2dcd5tF6E4=;
 b=AycPI9OAyVFRe7A1ORz/4ZNyulhI6Nwu0ReFVeajTYD1MNMigGdACfZeujzVRm/oC5KJgp
 Stn18E4cd/R+0M8WRlp5u+FCug00l4m8BH8z1HR0tcb05Ii4g/TBDsafP8auxmXI/v8+d7
 R4KHugYVEnlaAm4oUqhisTV8XsFtbVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-gavpQTyINIGhGulhGzR3kg-1; Thu, 05 Mar 2020 09:42:05 -0500
X-MC-Unique: gavpQTyINIGhGulhGzR3kg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DC4C132205
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 14:42:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78E7591844;
 Thu,  5 Mar 2020 14:41:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07AD511386A6; Thu,  5 Mar 2020 15:41:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
Date: Thu, 05 Mar 2020 15:41:50 +0100
In-Reply-To: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 13 Jan 2020
 18:48:48 +0400")
Message-ID: <87a74ueudt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I tried to observe the main loop keeps running while the screendump does
its work.

The main loop appears to lack trace points.  Alright, if there's no
hammer handy, I'll use a rock:

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 5549f4b619..b6561a65d7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1661,6 +1661,7 @@ void qemu_main_loop(void)
 #ifdef CONFIG_PROFILER
         ti =3D profile_getclock();
 #endif
+        printf("*** main loop\n");
         main_loop_wait(false);
 #ifdef CONFIG_PROFILER
         dev_time +=3D profile_getclock() - ti;


First experiment: does the main loop continue to run when writing out
the screendump blocks / would block?

Observe qmp_screendump() opens the file without O_EXCL.  Great, that
lets me block output by making it open a FIFO.

Terminal#1:

    $ mkfifo s

Terminal#2:

    $ upstream-qemu -S -display none -chardev socket,id=3Dqmp,path=3Dtest-q=
mp,server=3Don,wait=3Doff -mon mode=3Dcontrol,chardev=3Dqmp
    *** main loop
    *** main loop
    *** main loop

Keeps printing at a steady pace.

Terminal#3:

    $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-CONN=
ECT:$HOME/work/images/test-qmp=20
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 4}, "pa=
ckage": "v4.2.0-2069-g5e5ae6b644-dirty"}, "capabilities": ["oob"]}}
    QMP>{"execute": "qmp_capabilities"}
    {"return": {}}
    QMP>{"execute": "screendump", "arguments": {"filename": "s"}}

The printing in terminal#2 stops.  This is expected; qemu_open() calls
open(), which blocks, because the FIFO has no reader.

Terminal#1:

    $ exec 4<s

Now the FIFO has a reader.  Terminal#2 remains quiet.

We now hang in ppm_save().  Abridged stack backtrace:

    #0  0x00007ffff519d0f5 in writev () at /lib64/libc.so.6
    #1  0x0000555555e15f61 in qio_channel_file_writev
        (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0, n=
fds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel-file.c:123
    #2  0x0000555555e133d3 in qio_channel_writev_full
        (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0, n=
fds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:86
    #3  0x0000555555e137a2 in qio_channel_writev
        (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, errp=3D0x7ff=
fe9d81d10)
        at /work/armbru/qemu/io/channel.c:207
    #4  0x0000555555e13696 in qio_channel_writev_all
        (ioc=3D0x5555567bf5f0, iov=3D0x7fffe9d81bd0, niov=3D1, errp=3D0x7ff=
fe9d81d10)
        at /work/armbru/qemu/io/channel.c:171
    #5  0x0000555555e139b1 in qio_channel_write_all
        (ioc=3D0x5555567bf5f0, buf=3D0x555556b05200 "", buflen=3D1920, errp=
=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:257
    #6  0x0000555555cd74ff in ppm_save
        (fd=3D22, image=3D0x5555568ffdd0, errp=3D0x7fffe9d81d10)
        at /work/armbru/qemu/ui/console.c:336
    #7  0x0000555555cd77e6 in qmp_screendump
        (filename=3D0x555556ea0900 "s", has_device=3Dfalse, device=3D0x0, h=
as_head=3Dfalse, head=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/ui/c=
onsole.c:401

A brief inspection of qio_channel_file_writev() and
qio_channel_writev_all() suggests this might work if you make the output
file descriptor non-blocking.

    $ head -c 1 <&4 | hexdump -C
    00000000  50                                                |P|
    00000001

Still quiet.

    $ cat <&4 >/dev/null

The printing resumes.

    $ exec 4<&-


Second experiment: does the main loop continue to run while we wait for
graphic_hw_update_done()?

Left as an exercise for the patch submitter ;)


