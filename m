Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZWhQ-00071w-Ls
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gZWhK-0002X3-7J
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:55:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gZWhF-0002Qq-9P
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:55:15 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 320A9C0740ED
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 07:55:12 +0000 (UTC)
Date: Wed, 19 Dec 2018 08:55:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181219075510.ci3yypwj3f2plcnv@sirius.home.kraxel.org>
References: <20180222070513.8740-1-kraxel@redhat.com>
	<20180222070513.8740-6-kraxel@redhat.com>
	<20181218184532.GA18660@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218184532.GA18660@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] keymap: consider modifier state
 when picking a mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Adam Williamson <awilliam@redhat.com>

  Hi,

> After this patch the two sequences now show:
> 
>   19237@1545158356.679095:vnc_key_event_map down 1, sym 0xffe1 -> keycode 0x2a [shift]
>   19237@1545158356.896528:vnc_key_event_map down 1, sym 0x3c -> keycode 0x33 [comma]
>   19237@1545158356.993672:vnc_key_event_map down 0, sym 0x3c -> keycode 0x33 [comma]
>   19237@1545158357.233437:vnc_key_event_map down 0, sym 0xffe1 -> keycode 0x2a [shift]
> 
>   19237@1545158358.726002:vnc_key_event_map down 1, sym 0xffe1 -> keycode 0x2a [shift]
>   19237@1545158358.999542:vnc_key_event_map down 1, sym 0x3c -> keycode 0x33 [comma]
>   19237@1545158359.201503:vnc_key_event_map down 0, sym 0xffe1 -> keycode 0x2a [shift]
>   19237@1545158359.435021:vnc_key_event_map down 0, sym 0x3c -> keycode 0x56 [less]
> 
> Notice how we sent a "down(comma)" and paired it with an "up(less)". This
> causes the guest to consider the key stuck down, so next time you type
> a "<" it will get lost.

Ouch.

> This is easily reproduced with gtk-vnc and the following QEMU command
> line:
> 
>   ./x86_64-softmmu/qemu-system-x86_64 -vnc :1 -d trace:vnc* 
> 
> 
> I don't see any nice way to fix the problem without having to keep a
> memory of modifier state with every "down" event, so you can use the
> same modifier state with the later "up" event to ensure you get a
> matching key up.

Well, for key-up you can prefer keys in "down" state instead of looking
at the modifiers.

> This is quite horrible though. I'm more inclined
> to revert this patch and find another way to fix the original problem
> which won't require the UI frontends to track modifier state.

The UIs track modifier state anyway.

I fact I have some WIP patches to add a generic keyboard state tracker,
so the UIs can use common code instead of having their own state
tracking code each.  Also to make UI hotkeys configurable, consistent
across all UIs we have.  Guess I should undust them, at least the state
tracking part of it.

With that in place we can easily pass the full keyboard state to the
keymap code.

cheers,
  Gerd
