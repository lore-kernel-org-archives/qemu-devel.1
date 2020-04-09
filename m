Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A5C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:47:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C9E20A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 12:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUmU63hJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C9E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMWaR-0002MS-Nm
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 08:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <coiby.xu@gmail.com>) id 1jMWZN-0001v8-3P
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <coiby.xu@gmail.com>) id 1jMWZL-0002tQ-KH
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:46:08 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <coiby.xu@gmail.com>) id 1jMWZL-0002s4-Eg
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 08:46:07 -0400
Received: by mail-pf1-x441.google.com with SMTP id a13so4074904pfa.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
 bh=FfMutHfPv59oDCzVNwwLhjab7CAHet+es1VaaKPvpOE=;
 b=NUmU63hJi2rpLvgN+38wMcWJMYo4SCEsY1ZN5hSdflXVNug6t93I+GaIJYbVFkPWNZ
 3bdf1kQW69KXOr9GfGuRihVOA4T8gxs/edc/fgMsABz6CkbFTofPLzx0/plMPMhqhlOP
 SCOLHF8G+/sa8+upyXbczCZoOBjBBX+O08rmfFjozBDMUDZWX1rgt5805Dre3lidgWpR
 sStri0Exdb7QoWTSdqdF2y8RAStwms5pdQBgHfcLLU3vMphZL5AypFeBG41MXAUgPJiR
 sSH8tqSSWsFyMLeVsD1XSVIt32+JUICTKHwPj9O67BUh0h1vID2bPfEfi/aG2giPv6HG
 Eauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=FfMutHfPv59oDCzVNwwLhjab7CAHet+es1VaaKPvpOE=;
 b=PG+8t8yxbcRO0E9SruwNvGKr2NYiDN6N5Ym1Z4BexO7Zhw5c3ymojUb1MkLzdsAH8b
 Bodi4oDNkvZtygGXM9fmBYyehrK+zozV9vgPyK6TqoLWG95XQPffAJirmwfz4ns/Mf8i
 jYQEZQ10rHTEB+Gf9qtHyBczgaBU0HiINZrKGcowjUwh1nfvN8FGo+m3Y7o6ukWQgvtP
 w29jG6wVAir9EAzRBuq+lwPVAwJ1oV1d8UKk4l+c5lg4uKQRrkwpPBw8Cx0Y/QqHljrJ
 CS1JvnWs5CXRHUmZ2nx5vfD1+McZILDI/VGQCSpOEbAJn36Z6zvCIPpd9lOAVUmxxc8w
 TmhQ==
X-Gm-Message-State: AGi0PuaU98PCURTnI9oS2/RFBIx+dGwkdIUw0mxc6apQ5IQjJ/NBDZmC
 heymrjDxbff5aNMnX2A5CYA00ggg9GjEdFXd
X-Google-Smtp-Source: APiQypKrzPYmilA5Oj+izzj5e3K0U67tMDA0/A6PjOSxVZKMJeIikaZ+J92J1/yNmHZeXOCep54VOA==
X-Received: by 2002:a65:5ccb:: with SMTP id b11mr11351512pgt.387.1586436365698; 
 Thu, 09 Apr 2020 05:46:05 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
 by smtp.gmail.com with ESMTPSA id 6sm19084393pfx.69.2020.04.09.05.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 05:46:05 -0700 (PDT)
From: Coiby Xu <coiby.xu@gmail.com>
X-Google-Original-From: Coiby Xu <Coiby.Xu@gmail.com>
Date: Thu, 9 Apr 2020 20:46:01 +0800
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Replace GSource with AioContext for chardev
Message-ID: <20200409124601.toh6jpbfcwiwzb6z@r>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi,

I'm now implementing vhost-user block device backend
https://patchew.org/QEMU/20200309100342.14921-1-coiby.xu@gmail.com/
and want to use chardev to help manage vhost-user client connections
and read socket message. However there are two issues that need to be
addressed.

Firstly, chardev isn't suitable for the case when exported drive is
run in an IOThread because for mow chardev use GSource to dispatch
socket fd events. So I have to specify which IOThread the exported
drive is using when launching vhost-user block device backend,
for example, the following syntax will be used,

   -drive file=file.img,id=disk -device virtio-blk,drive=disk,iothread=iothread0 \
    -object vhost-user-blk-server,node-name=disk,chardev=mon1,iothread=iothread0 \
    -object iothread,id=iothread0 \
    -chardev socket,id=mon1,path=/tmp/vhost-user-blk_vhost.socket,server,nowait

then iothread_get_g_main_context(IOThread *iothread) has to be called
to run the gcontext in IOThread. If we use AioContext to dispatch socket
fd events, we needn't to specify IOThread twice. Besides aio_poll is faster
than g_main_loop_run.

Secondly, socket chardev's async read handler (set through
qemu_chr_fe_set_handlers) doesn't take the case of socket short read
into consideration.  I plan to add one which will make use qio_channel_yield.

According to
[1] Improving the QEMU Event Loop - Linux Foundation Events
http://events17.linuxfoundation.org/sites/events/files/slides/Improving%20the%20QEMU%20Event%20Loop%20-%203.pdf

"Convert chardev GSource to aio or an equivalent source" (p.30) should have
been finished. I'm curious why the plan didn't continue. If it's desirable,
I'm going to finish the leftover work to resolve the aforementioned two issues.

Any suggestion will be appreciated.
Thank you!

