Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97593C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9D820720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRHjjaY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9D820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5IO-0004dP-JC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jY5HD-0003M4-Vz
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:03:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25395
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jY5HC-0006V0-KY
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589191389;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqVwnXsDwAbEkbwXTKfqdMhlry8L9N15Tw8DNn4mcxM=;
 b=CRHjjaY9ee+KdbFh3pOWKu38/wCGXEz2FCQmozN30VKqL0GEIUu2N61c77KIflQEI3Hg+e
 vJ8HohF286UMKHycAKkxKsj60zu1IYi5BXxVUF5fZUKKUAEZ0EWwU4wyKH+7KIbwKJALy9
 O+RLF5BGIzhd/MxySv37etu9U9g1Pdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-zN2HLYH4NWG0kQ5snE4p2Q-1; Mon, 11 May 2020 06:03:05 -0400
X-MC-Unique: zN2HLYH4NWG0kQ5snE4p2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826BA800687;
 Mon, 11 May 2020 10:03:03 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBCE2E189;
 Mon, 11 May 2020 10:03:00 +0000 (UTC)
Date: Mon, 11 May 2020 11:02:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Li Feng <fengli@smartx.com>
Subject: Re: [PATCH v3 1/2] io/channel: fix crash when qio_channel_readv_all
 return 0
Message-ID: <20200511100257.GG1135885@redhat.com>
References: <20200428085122.1621-1-fengli@smartx.com>
 <20200508051441.8143-1-fengli@smartx.com>
 <20200508051441.8143-2-fengli@smartx.com>
 <CAJ+F1CK6S-M4ykYp0DapZ9q0nAD046Uim-F7cxUTYqYC5anBTA@mail.gmail.com>
 <CAHckoCxh5USw8bqWyn-mc6fEemnu_EEn+NWSLjG-PbuWAaAB7w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHckoCxh5USw8bqWyn-mc6fEemnu_EEn+NWSLjG-PbuWAaAB7w@mail.gmail.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Li Feng <lifeng1519@gmail.com>, Kyle Zhang <kyle@smartx.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Dima Stepanov <dimastep@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 08, 2020 at 08:42:22PM +0800, Li Feng wrote:
> Marc-André Lureau <marcandre.lureau@gmail.com> 于2020年5月8日周五 下午8:32写道：
> >
> > Hi
> >
> > On Fri, May 8, 2020 at 7:14 AM Li Feng <fengli@smartx.com> wrote:
> > >
> > > Root cause:
> > > From `man recvmsg`, the RETURN VALUE says:
> > > These  calls return the number of bytes received, or -1 if an error occurred.
> > > In the event of an error, errno is set to indicate the error.
> > > The return value will be 0 when the peer has performed an orderly shutdown.
> > >
> > > When an error happens, the socket will be closed, and recvmsg return 0,
> > > then error_setg will trigger a crash.
> > >
> > > This unit test could reproduce this issue:
> > > tests/test-char -p /char/socket/client/reconnect-error/unix
> >
> > Current master doesn't trigger the backtrace, it's only after your patch 2.
> Yes. However, the issue did exist in the master code base.
> The test case in patch 2 revealed this issue.
> 
> >
> > >
> > > The core file backtrace is :
> > >
> > > (gdb) bt
> > >     #0  0x00007ffff5ac3277 in raise () from /lib64/libc.so.6
> > >     #1  0x00007ffff5ac4968 in abort () from /lib64/libc.so.6
> > >     #2  0x00005555555aaa94 in error_handle_fatal (errp=<optimized out>, err=0x7fffec0012d0) at util/error.c:40
> > >     #3  0x00005555555aab6d in error_setv (errp=0x555555802a08 <error_abort>, src=0x5555555c4280 "io/channel.c", line=148,
> > >         func=0x5555555c4580 <__func__.17489> "qio_channel_readv_all", err_class=ERROR_CLASS_GENERIC_ERROR,
> > >         fmt=<optimized out>, ap=0x7ffff423bae0, suffix=0x0) at util/error.c:73
> > >     #4  0x00005555555aacf0 in error_setg_internal (errp=errp@entry=0x555555802a08 <error_abort>,
> > >         src=src@entry=0x5555555c4280 "io/channel.c", line=line@entry=148,
> > >         func=func@entry=0x5555555c4580 <__func__.17489> "qio_channel_readv_all",
> > >         fmt=fmt@entry=0x5555555c43a0 "Unexpected end-of-file before all bytes were read") at util/error.c:97
> > >     #5  0x000055555556c25c in qio_channel_readv_all (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>,
> > >         errp=0x555555802a08 <error_abort>) at io/channel.c:147
> > >     #6  0x000055555556c29a in qio_channel_read_all (ioc=<optimized out>, buf=<optimized out>, buflen=<optimized out>,
> > >         errp=<optimized out>) at io/channel.c:247
> > >     #7  0x000055555556ad22 in char_socket_ping_pong (ioc=0x7fffec0008c0) at tests/test-char.c:732
> > >     #8  0x000055555556ae12 in char_socket_client_server_thread (data=data@entry=0x55555582e350) at tests/test-char.c:891
> > >     #9  0x00005555555a95b6 in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:519
> > >     #10 0x00007ffff5e61e25 in start_thread () from /lib64/libpthread.so.0
> > >     #11 0x00007ffff5b8bbad in clone () from /lib64/libc.so.6
> > >
> > > Signed-off-by: Li Feng <fengli@smartx.com>
> > > ---
> > >  io/channel.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/io/channel.c b/io/channel.c
> > > index e4376eb0bc..1a4a505f01 100644
> > > --- a/io/channel.c
> > > +++ b/io/channel.c
> > > @@ -144,8 +144,6 @@ int qio_channel_readv_all(QIOChannel *ioc,
> > >
> > >      if (ret == 0) {
> > >          ret = -1;
> > > -        error_setg(errp,
> > > -                   "Unexpected end-of-file before all bytes were read");
> >
> > Nack, this code is fine.
> >
> > The problem is that the test case doesn't expect a disconnect in
> > char_socket_ping_pong().
> Yes, in the test case I try to inject an error in char_socket_ping_pong.
> Any concerns about these two patches?

I agree with Marc-André - this patch is wrong. qio_channel_readv_all
*MUST* always set 'errp' if the return value is -1. To not set 'errp'
is violating the calling convention.

The bug here is in your test case - it is passing '&error_abort' to the
'qio_channel_readv_all' call.  If you don't want the test to crash, then
don't pass &error_abort

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


