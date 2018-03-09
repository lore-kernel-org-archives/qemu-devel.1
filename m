Received: from eggs.gnu.org ([2001:4830:134:3::10]:48093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euBtp-0002OP-NT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1euBtl-0004fF-RI
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:53:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1euBtl-0004f6-MA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 01:53:01 -0500
Date: Fri, 9 Mar 2018 07:52:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180309065247.xzribx4zjgx5bnj5@sirius.home.kraxel.org>
References: <20180308083231.20180-1-kraxel@redhat.com>
	<CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8wUN_T9XrUULCROVFdv+vGipdMuhNz5km1mcX_nVrQgg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/8] Ui 20180308 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> Hi. This gives me a new warning on FreeBSD:
> 
>   CC      ui/gtk.o
> /root/qemu/ui/gtk.c:2141:13: warning: 'gtk_widget_set_double_buffered'
> is deprecated [-Wdeprecated-declarations]
>             gtk_widget_set_double_buffered(vc->gfx.drawing_area, FALSE);
>             ^
> /usr/local/include/gtk-3.0/gtk/gtkwidget.h:876:23: note:
> 'gtk_widget_set_double_buffered' has been explicitly marked deprecated
> here
> void                  gtk_widget_set_double_buffered    (GtkWidget    *widget,

Known issue.  The gtk-egl.c code needs this even though it is
deprecated.  We have a diagnostic pragma in place for gcc, seems that
doesn't work on freebsd because it builds with clang not gcc.

Hmm, quick googling shows clang seems to support this too.
https://clang.llvm.org/docs/UsersManual.html#pragma-gcc-diagnostic

/me looks puzzled.  Test for CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE not
working properly on freebsd?

Seems clang doesn't support a pragma used in qemu, config.log says:

error: unknown warning group '-Wunused-but-set-variable'.

Maybe I should move the code to a separate source file so it can be
built with different compiler flags, without needing #pragma?  I don't
feel like building all gtk code with -Wno-deprecated-declarations ...

cheers,
  Gerd
