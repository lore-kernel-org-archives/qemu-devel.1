Received: from eggs.gnu.org ([209.51.188.92]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qRo-0006kR-2J
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1qRl-0006Nc-4w
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:40:19 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1qRj-0006Fl-UE
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:40:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id w2so16801329wrt.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 02:40:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13c59d63-1761-b61e-9cb9-039a3ef1be08@redhat.com>
Date: Thu, 7 Mar 2019 11:40:05 +0100
MIME-Version: 1.0
In-Reply-To: <9fb589af-a78e-6eeb-ca1c-a5049c5ac5ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/03/19 07:39, Thomas Huth wrote:
> On 06/03/2019 19.12, Paolo Bonzini wrote:
>> Hi all,
>>
>> lately I have been thinking of converting the QEMU build system to
>> Meson.  Meson is a relatively new build system that can replace
>> Autotools or hand-written Makefiles such as QEMU; as a die-hard
>> Autotools fan, I must say that Meson is by far better than anything else
>> that has ever tried to replace Autotools, and actually has the potential
>> to do so.
>>
>> Advantages of Meson that directly matter for QEMU include:[...]
> 
> I'm not objecting a new build system per se, but could you elaborate on
>  problems of the current QEMU build system that will be fixed by this
> change?

In order of importance:

- Make lacks introspection abilities; people want to be able to quickly
say "I don't have this security issue because I didn't compile this
file".  Make only gives you the build logs, which may not be easily
accessible to the end user.

- Makefile.objs unnesting does not apply throughout the tree, for
example it does not apply to tests.  We don't apply it there because it
it is hard to extend Makefile.objs to dozens of targets and it would
also be very very slow.  The result is lack of homogeneity between
places that use Makefile.objs and places that use Makefile.include.

- Makefile.objs unnesting is hard to understand---granted, you rarely
have to understand it because it mostly works, but we should consider
whether it is a local optimum.  For example, how many people know how to
add a dynamically-loadd module to Makefile.objs?

- The mix of recursive and non-recursive builds is hard to understand
and slow, because we do the the Makefile.objs unnesting 20-30 times
(once for every target).  We do spend time cleaning up warts left when
contributors just hacked something together and reviewers lacked the
expertise to notice that.

- Makefile errors (e.g. pointing to a nonexistent file) only show when
trying to build the file, so that some errors may go unnoticed if they
don't reproduce on your machine.  Meson always detects missing source
files, independent of whether your build uses them.

FWIW and just to give an idea, I placed a quick (and of course untested)
conversion of ui/Makefile.objs at the end of this message.

Paolo

[1] https://clang.llvm.org/docs/JSONCompilationDatabase.html

---
# This would be ui/meson.build:

vnc_sources = source_set.source_set()
vnc_sources.add([], files(
    'vnc.c',
    'vnc-auth-vencrypt.c',
    'vnc-enc-hextile.c',
    'vnc-enc-tight.c',
    'vnc-enc-zlib.c',
    'vnc-enc-zrle.c',
    'vnc-jobs.c',
    'vnc-palette.c',
    'vnc-ws.c'))
vnc_sources.add('CONFIG_VNC_SASL', files(
    'vnc-auth-sasl.c'))

common_obj.add([], files(
    'console.c',
    'cursor.c',
    'kbd-state.c',
    'keymaps.c',
    'input.c',
    'input-keymap.c',
    'input-legacy.c',
    'qemu-pixman.c'))
common_obj.add('CONFIG_LINUX', files(
    'input-linux.c'))
common_obj.add('CONFIG_SPICE', files(
    'spice-core.c',
    'spice-input.c',
    'spice-display.c'))
common_obj.add('CONFIG_COCOA', files(
    'cocoa.c'))
common_obj.add_all('CONFIG_VNC', vnc_sources)
common_obj.add('CONFIG_VNC',
    if_false: files('vnc-stubs.c'))

if opengl.found()
    common_obj.add([], files(
        'console-gl.c',
        'egl-helpers.c',
        'egl-context.c',
        'shader.c'), dependencies: opengl)
    common_obj.add('CONFIG_OPENGL_DMABUF', files(
        'egl-headless.c'))
endif

if sdl.found()
    sdl_sources = source_set.source_set()
    sdl_sources.add([], files(
        'sdl2.c',
        'sdl2-2d.c',
        'sdl2-input.c'), dependencies: sdl)
    sdl_sources.add('CONFIG_X11', files(
        'x_keymap.c'), dependencies: x11)
    sdl_sources.add('CONFIG_OPENGL', files(
        'sdl2-gl.c'), dependencies: opengl)
    modules += { 'ui-sdl': sdl_sources }
endif

if curses.found()
    curses_sources = source_set.source_set()
    curses_sources.add([], files(
        'curses.c'), dependencies: curses)
    modules += { 'ui-curses': curses_sources }
endif

if gtk.found()
    gtk_sources = source_set.source_set()
    gtk_sources.add([], files(
        'gtk.c'), dependencies: gtk)
    gtk_sources.add('CONFIG_X11', files(
        'x_keymap.c'), dependencies: x11)
    gtk_sources.add('CONFIG_OPENGL', files(
        'gtk-egl.c'), dependencies: opengl)
    gtk_sources.add('CONFIG_GTK_GL', files(
        'gtk-gl-area.c'))
    modules += { 'ui-gtk': gtk_sources }
fi
