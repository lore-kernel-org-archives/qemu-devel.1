Received: from eggs.gnu.org ([2001:4830:134:3::10]:59006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esnQw-0006sQ-Mn
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esnQs-0005Uk-Sv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:33:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1esnQs-0005UU-MR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:33:26 -0500
Date: Mon, 5 Mar 2018 10:33:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180305103307.GL17368@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Wz4q=+HDpSG_pFHB7xKMez6hCPFodoOxoTgr1FOy5nA@mail.gmail.com>
Subject: Re: [Qemu-devel] QEMU fails to configure on non-x86 hosts with
 recent SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Mar 05, 2018 at 10:24:41AM +0000, Peter Maydell wrote:
> On non-x86 hosts with SDL2 2.0.8, configure fails:
> 
> 
> config-host.mak is out-of-date, running configure
> 
> ERROR: configure test passed without -Werror but failed with -Werror.
>        This is probably a bug in the configure script. The failing command
>        will be at the bottom of config.log.
>        You can run configure with --disable-werror to bypass this check.
> 
> The relevant configure test is the SDL one:
> #include <SDL.h>
> #undef main /* We don't want SDL to override our main() */
> int main( void ) { return SDL_Init (SDL_INIT_VIDEO); }
> 
> and it fails because on non-x86 platforms one of the SDL headers
> triggers a -Wundef warning:
> 
> cc -Wundef -o zz9.o -I /usr/include/SDL2 -c qemu-conf.c
> In file included from /usr/include/SDL2/SDL.h:38:0,
>                  from qemu-conf.c:1:
> /usr/include/SDL2/SDL_cpuinfo.h:63:5: warning: "HAVE_IMMINTRIN_H" is
> not defined, evaluates to 0 [-Wundef]
>  #if HAVE_IMMINTRIN_H && !defined(SDL_DISABLE_IMMINTRIN_H)
>      ^~~~~~~~~~~~~~~~

Ewwww, even ignoring the -Wundef issue, this is a really unpleasant
approach from SDL.  All these HAVE_* symbols SDL2 tests & defines
are polluting the global header namespace and could easily clash
with symbols defined by QEMU / $APP's own configure.ac script :-(

> Any suggestions for how to do a workaround?

Drop -Wundef when running the configiure test, or override it with -Wno-undef

If the actual ui/sdl* files fail for same reason, we could use a gcc
pragma top disable -Wundef in just those files, or set -Wno-undef in
CFLAGS on a per-.o file basis in Makefile.objs

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
