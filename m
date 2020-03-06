Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CFFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3079C2072A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 05:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IzjSp/jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3079C2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jA5zW-0004bE-8m
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 00:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jA5yw-0004AA-D1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jA5yu-0005Vm-HW
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:57:09 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50683
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jA5yu-0005Qv-Cr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 00:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583474227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSM7iVRJ99l1TUhE/BveXrJDnUQbBSOVRpZCMG7YiHI=;
 b=IzjSp/jbix5Akr3kstwCBCc9OY/qyWMT+y+fTwU38PgIcnihtt/fJgC+cCbNNeZcUPMvoB
 MJAWK0gbyRA2NJS/NvTudskYYrdYSDVg5DbaXhVYNjVpbQ6AAEtm9xL9MWYEcFG65LBXnc
 9NjkixUUJSbVuxLduy8uvNCcOaZ8Zcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-48TXb1gIOQSLefOn-DZ5sw-1; Fri, 06 Mar 2020 00:57:03 -0500
X-MC-Unique: 48TXb1gIOQSLefOn-DZ5sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0FE107ACC9;
 Fri,  6 Mar 2020 05:57:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCC6D5C21B;
 Fri,  6 Mar 2020 05:56:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4EAC111386A6; Fri,  6 Mar 2020 06:56:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] console: make QMP screendump use coroutine
References: <20200113144848.2168018-1-marcandre.lureau@redhat.com>
 <87a74ueudt.fsf@dusky.pond.sub.org>
 <CAJ+F1C+GY6d8Jr+NjSMuXpX+QiMsFQ9qd-rEJyp+oF9Ld6Z1wQ@mail.gmail.com>
Date: Fri, 06 Mar 2020 06:56:58 +0100
In-Reply-To: <CAJ+F1C+GY6d8Jr+NjSMuXpX+QiMsFQ9qd-rEJyp+oF9Ld6Z1wQ@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 5 Mar 2020
 16:08:00 +0100")
Message-ID: <87k13y9gb9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Mar 5, 2020 at 3:46 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> I tried to observe the main loop keeps running while the screendump does
>> its work.
>>
>> The main loop appears to lack trace points.  Alright, if there's no
>> hammer handy, I'll use a rock:
>>
>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>> index 5549f4b619..b6561a65d7 100644
>> --- a/softmmu/vl.c
>> +++ b/softmmu/vl.c
>> @@ -1661,6 +1661,7 @@ void qemu_main_loop(void)
>>  #ifdef CONFIG_PROFILER
>>          ti =3D profile_getclock();
>>  #endif
>> +        printf("*** main loop\n");
>>          main_loop_wait(false);
>>  #ifdef CONFIG_PROFILER
>>          dev_time +=3D profile_getclock() - ti;
>>
>>
>> First experiment: does the main loop continue to run when writing out
>> the screendump blocks / would block?
>>
>> Observe qmp_screendump() opens the file without O_EXCL.  Great, that
>> lets me block output by making it open a FIFO.
>>
>> Terminal#1:
>>
>>     $ mkfifo s
>>
>> Terminal#2:
>>
>>     $ upstream-qemu -S -display none -chardev socket,id=3Dqmp,path=3Dtes=
t-qmp,server=3Don,wait=3Doff -mon mode=3Dcontrol,chardev=3Dqmp
>>     *** main loop
>>     *** main loop
>>     *** main loop
>>
>> Keeps printing at a steady pace.
>>
>> Terminal#3:
>>
>>     $ socat "READLINE,history=3D$HOME/.qmp_history,prompt=3DQMP>" UNIX-C=
ONNECT:$HOME/work/images/test-qmp
>>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 4}, =
"package": "v4.2.0-2069-g5e5ae6b644-dirty"}, "capabilities": ["oob"]}}
>>     QMP>{"execute": "qmp_capabilities"}
>>     {"return": {}}
>>     QMP>{"execute": "screendump", "arguments": {"filename": "s"}}
>>
>> The printing in terminal#2 stops.  This is expected; qemu_open() calls
>> open(), which blocks, because the FIFO has no reader.
>>
>> Terminal#1:
>>
>>     $ exec 4<s
>>
>> Now the FIFO has a reader.  Terminal#2 remains quiet.
>>
>> We now hang in ppm_save().  Abridged stack backtrace:
>>
>>     #0  0x00007ffff519d0f5 in writev () at /lib64/libc.so.6
>>     #1  0x0000555555e15f61 in qio_channel_file_writev
>>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0=
, nfds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel-file.c:1=
23
>>     #2  0x0000555555e133d3 in qio_channel_writev_full
>>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, fds=3D0x0=
, nfds=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:86
>>     #3  0x0000555555e137a2 in qio_channel_writev
>>         (ioc=3D0x5555567bf5f0, iov=3D0x555556a441b0, niov=3D1, errp=3D0x=
7fffe9d81d10)
>>         at /work/armbru/qemu/io/channel.c:207
>>     #4  0x0000555555e13696 in qio_channel_writev_all
>>         (ioc=3D0x5555567bf5f0, iov=3D0x7fffe9d81bd0, niov=3D1, errp=3D0x=
7fffe9d81d10)
>>         at /work/armbru/qemu/io/channel.c:171
>>     #5  0x0000555555e139b1 in qio_channel_write_all
>>         (ioc=3D0x5555567bf5f0, buf=3D0x555556b05200 "", buflen=3D1920, e=
rrp=3D0x7fffe9d81d10) at /work/armbru/qemu/io/channel.c:257
>>     #6  0x0000555555cd74ff in ppm_save
>>         (fd=3D22, image=3D0x5555568ffdd0, errp=3D0x7fffe9d81d10)
>>         at /work/armbru/qemu/ui/console.c:336
>>     #7  0x0000555555cd77e6 in qmp_screendump
>>         (filename=3D0x555556ea0900 "s", has_device=3Dfalse, device=3D0x0=
, has_head=3Dfalse, head=3D0, errp=3D0x7fffe9d81d10) at /work/armbru/qemu/u=
i/console.c:401
>>
>> A brief inspection of qio_channel_file_writev() and
>> qio_channel_writev_all() suggests this might work if you make the output
>> file descriptor non-blocking.
>
> Right, the goal was rather originally to fix rhbz#1230527. We got
> coroutine IO by accident, and I was too optimistic about default
> behaviour change ;) I will update the patch.
>
>>
>>     $ head -c 1 <&4 | hexdump -C
>>     00000000  50                                                |P|
>>     00000001
>>
>> Still quiet.
>>
>>     $ cat <&4 >/dev/null
>>
>> The printing resumes.
>>
>>     $ exec 4<&-
>>
>>
>> Second experiment: does the main loop continue to run while we wait for
>> graphic_hw_update_done()?
>>
>> Left as an exercise for the patch submitter ;)
>>
>>
>
> With your main loop printf, one printf in graphic_hw_update() and one
> in graphic_hw_update_done() ? (rather part of testing commit
> 4d6316218bf7bf3b8c7c7165b072cc314511a7a7, soon 4y old!)

We might also need to artificially delay graphic_hw_update_done().


