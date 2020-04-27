Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C092C55199
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C782D206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="jQsWlTau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C782D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0Eq-00086S-UQ
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jT0E5-0006ok-DF
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jT0E4-00013Q-T1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:38:57 -0400
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:49692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jT0Dv-0000RR-GX; Mon, 27 Apr 2020 05:38:48 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E78AD2E0DDB;
 Mon, 27 Apr 2020 12:38:38 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net
 (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Gz0JQogBxN-cZQOlabg; Mon, 27 Apr 2020 12:38:38 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587980318; bh=58bnVAmHqFrCWzlW/V20/mHgMY3ZzYOjLUidyQPQPvI=;
 h=In-Reply-To:Message-ID:Subject:To:From:References:Date:Cc;
 b=jQsWlTau2EpKeZiO3QytH1aqJUZ6PSsq2lzBUNdUCejMUup5QbSB/oDjnpS/gbfH7
 7K8PYV8Lh0Zr1RXIB3s2lOdhIhKmgdPRjAfhMXudYmztthNSjCZLipCxE43rswpH8F
 wcuz8jjt6hx3lhHbGFXboYphIPQq+qBeZTXuJwcY=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-iva.dhcp.yndx.net (dynamic-iva.dhcp.yndx.net
 [2a02:6b8:b080:9012::1:1])
 by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 j4zkk2ThIK-cZWm2nLh; Mon, 27 Apr 2020 12:38:35 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client certificate not present)
Date: Mon, 27 Apr 2020 12:38:33 +0300
From: Dima Stepanov <dimastep@yandex-team.ru>
To: Li Feng <fengli@smartx.com>
Subject: Re: [RFC PATCH v1 3/7] char-socket: initialize reconnect timer only
 if close is emitted
Message-ID: <20200427093824.GA8175@dimastep-nix>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
 <23b36a73ce1150cc501f436684ca558608de3322.1587667007.git.dimastep@yandex-team.ru>
 <CAJ+F1CJgzqSDnU==Fi4-fQ3Fh97BgEnNd_GZOg8n9i1C4xsOmw@mail.gmail.com>
 <CAHckoCz7ZjKQu6XkFNA9DLH4RMbjGRTpZDAwyiRbUB2_Zw7+NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHckoCz7ZjKQu6XkFNA9DLH4RMbjGRTpZDAwyiRbUB2_Zw7+NQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Received-SPF: pass client-ip=2a02:6b8:0:1619::183;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1j.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:6b8:0:1619::183
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Gonglei <arei.gonglei@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 yc-core@yandex-team.ru, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Apr 26, 2020 at 03:26:58PM +0800, Li Feng wrote:
> This patch is trying to fix the same issue with me.
> However, our fix is different.
> 
> I think that check the s->reconnect_timer is better.

I also thought about your solution:
  - if (s->reconnect_time) {
  + if (s->reconnect_time && !s->reconnect_timer) {
But was afraid of possible side effects. Since Marc-André approved your
fix, i'm also good with your approach. In this case i'll remove this
patch from the v2 patchset.

Thanks for handling it!

> 
> Thanks,
> Feng Li
> 
> Marc-André Lureau <marcandre.lureau@gmail.com> 于2020年4月24日周五 上午3:16写道：
> 
> 
> >
> > Hi
> >
> > On Thu, Apr 23, 2020 at 8:41 PM Dima Stepanov <dimastep@yandex-team.ru> wrote:
> > >
> > > During vhost-user reconnect functionality testing the following assert
> > > was hit:
> > >   qemu-system-x86_64: chardev/char-socket.c:125:
> > >   qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.
> > >   Aborted (core dumped)
> >
> > That looks related to "[PATCH 3/4] char-socket: avoid double call
> > tcp_chr_free_connection"
> >
> > > This is observed only if the connection is closed by the vhost-user-blk
> > > daemon during the initialization routine. In this case the
> > > tcp_chr_disconnect_locked() routine is called twice. First time it is
> > > called in the tcp_chr_write() routine, after getting the SIGPIPE signal.
> > > Second time it is called when vhost_user_blk_connect() routine return
> > > error. In general it looks correct, because the initialization routine
> > > can return error in many cases.
> > > The tcp_chr_disconnect_locked() routine could be fixed. The timer will
> > > be restarted only if the close event is emitted.
> > >
> > > Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
> > > ---
> > >  chardev/char-socket.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index c128cca..83ca4d9 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -476,7 +476,7 @@ static void update_disconnected_filename(SocketChardev *s)
> > >  static void tcp_chr_disconnect_locked(Chardev *chr)
> > >  {
> > >      SocketChardev *s = SOCKET_CHARDEV(chr);
> > > -    bool emit_close = s->state == TCP_CHARDEV_STATE_CONNECTED;
> > > +    bool was_connected = s->state == TCP_CHARDEV_STATE_CONNECTED;
> > >
> > >      tcp_chr_free_connection(chr);
> > >
> > > @@ -485,11 +485,11 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
> > >                                                chr, NULL, chr->gcontext);
> > >      }
> > >      update_disconnected_filename(s);
> > > -    if (emit_close) {
> > > +    if (was_connected) {
> > >          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> > > -    }
> > > -    if (s->reconnect_time) {
> > > -        qemu_chr_socket_restart_timer(chr);
> > > +        if (s->reconnect_time) {
> > > +            qemu_chr_socket_restart_timer(chr);
> > > +        }
> > >      }
> > >  }
> > >
> > > --
> > > 2.7.4
> > >
> > >
> >
> >
> > --
> > Marc-André Lureau
> 
> -- 
> The SmartX email address is only for business purpose. Any sent message 
> that is not related to the business is not authorized or permitted by 
> SmartX.
> 本邮箱为北京志凌海纳科技有限公司（SmartX）工作邮箱. 如本邮箱发出的邮件与工作无关,该邮件未得到本公司任何的明示或默示的授权.
> 
> 

