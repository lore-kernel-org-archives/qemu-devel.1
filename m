Received: from eggs.gnu.org ([2001:4830:134:3::10]:47942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etEWU-0005jb-3v
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etEWT-0002KV-4P
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:02 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:52065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etEWS-0002Ji-Tg
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 10:29:01 -0500
Received: by mail-wm0-x22c.google.com with SMTP id h21so23544834wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 07:29:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306132701.ezej6d7pysp6roxb@sirius.home.kraxel.org>
References: <20180306074053.22856-1-kraxel@redhat.com>
	<CAJ+F1CK5MsZ5=-z2yWznBcHjZqskHSdiyYxC30azEcQ9AXrRLg@mail.gmail.com>
	<20180306114232.v5gtwxald4mmelab@sirius.home.kraxel.org>
	<CAJ+F1CJo28aN6mwihp8UTwq4jtgz21BxT+U7F-jGu7fyhefBkA@mail.gmail.com>
	<20180306132701.ezej6d7pysp6roxb@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Mar 2018 16:28:58 +0100
Message-ID: <CAJ+F1C+N4_RV=brsQ3XDE9TMA=s8GNVXC1B9K5S+83xz+-yWiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] audio: modularize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Mar 6, 2018 at 2:27 PM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> >> /home/elmarco/src/qemu/build/x86_64-softmmu/../audio-pa.so: undefined
>> >> symbol: audio_pt_unlock_and_signal
>
>> Fresh directory, cleaned ccache. That didn't help. fwiw, I am
>> compiling on f27, gcc (GCC) 7.3.1 20180130. I'll investigate further
>> if you can't reproduce.
>
> Hmm, working fine here (both rhel-7 and fedora-27 testbuild container, de=
fault
> build flags).
>
> The symbol in question should be provided by qemu:
>
> kraxel@fedora-64bit ~/projects/qemu/build/fedora# objdump -x audio-pa.so =
| grep audio_pt_unlock_and_signal
> 0000000000000000         *UND*  0000000000000000              audio_pt_un=
lock_and_signal
> kraxel@fedora-64bit ~/projects/qemu/build/fedora# objdump -x x86_64-softm=
mu/qemu-system-x86_64 | grep audio_pt_unlock_and_signal
> 00000000004735f0 g     F .text  0000000000000067              audio_pt_un=
lock_and_signal
>
> Possibly your linker throws it away, thinking there is no user because of=
 the
> modular drivers?

It's not that, but it works if I build qemu with -rdynamic. dlopen(3):

External  references in the shared object are resolved using the
shared objects in that object's dependency list and any other objects
previously opened with the RTLD_GLOBAL flag.  If the executable
       was linked with the flag "-rdynamic" (or, synonymously,
"--export-dynamic"), then the global symbols in the executable will
also be used to resolve references in a dynamically loaded shared
object.

(If I understand right, there is some magic rules.mk
process-archive-undefs to make sure the used symbols from modules are
always linked in)

Could it be that -rdynamic / --export-dynamic is assumed in our build
system since modules have been added?

yes, it's pulled from /usr/lib64/pkgconfig/gmodule-2.0.pc, but glib
upstream built with meson doesn't have the flag anymore. That's
probably worth fixing in glib:
https://bugzilla.gnome.org/show_bug.cgi?id=3D794123

We should switch to using gmodule-export-2.0.pc (since 2.6), which is
also broken in meson build.  I'll send a patch for that.

--=20
Marc-Andr=C3=A9 Lureau
