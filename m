Received: from eggs.gnu.org ([2001:4830:134:3::10]:42453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZeBw-0003qu-2H
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZeBs-0003E4-Nd
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:18:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZeBs-0003DP-HI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:18:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C927883C9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:18:31 +0000 (UTC)
Date: Mon, 24 Jul 2017 15:18:25 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170724141825.GB11443@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724140117.27651-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170724140117.27651-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Fix qemu keymaps, part one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 24, 2017 at 04:01:14PM +0200, Gerd Hoffmann wrote:
> qemu carries a bunch of reverse keymaps in pc-bios/keymaps/, to map
> keysyms it receives from vnc clients back to keycodes.  These keymaps
> seem to be buggy and incomplete at times.  So, to tackle the issue once
> for all, I've written a tool to generate those maps from xkb keyboard
> layout data using libxkbcommon.
> 
> This patch series only adds the tool, it doesn't touch the maps in
> pc-bios/keymaps/ yet.  I want some testing feedback first ...

Hmm, we recently split out the keymap database and code for generating
lookup tables (that was duplicated across spice-gtk, gtk-vnc, and libvirt)
into a shared git sub-module

  https://gitlab.com/keycodemap/keycodemapdb/

some other VNC clients were also switching to its use.

I was coincidentally working on a patch to get QEMU to use this too,
so all projects are aligned on the same data maps and thus share fixes
in this area.

IMHO that'd be preferable than doing something custom in QEMU only.

> How to test:
>   (1) generate a map: "qemu-keymap -f testmap -l $layout"
>   (2) use the map: "qemu -vnc $display -k testmap"
> 
> Gerd Hoffmann (3):
>   keysym: add next and prior
>   ui: move qemu_input_linux_to_qcode()
>   Add qemu-keymap tool.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
