Received: from eggs.gnu.org ([209.51.188.92]:50620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1sZb-000146-OH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1sZa-0005MI-Qn
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:56:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:39770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1sZa-0005Kr-H6
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:56:30 -0500
Received: by mail-wr1-x435.google.com with SMTP id l12so851626wrp.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 04:56:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
Date: Thu, 7 Mar 2019 13:56:26 +0100
MIME-Version: 1.0
In-Reply-To: <87r2bigarf.fsf@zen.linaroharston>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 07/03/19 12:54, Alex Bennée wrote:
> 
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> Hi all,
>>
>> lately I have been thinking of converting the QEMU build system to
>> Meson.  Meson is a relatively new build system that can replace
>> Autotools or hand-written Makefiles such as QEMU; as a die-hard
>> Autotools fan, I must say that Meson is by far better than anything else
>> that has ever tried to replace Autotools, and actually has the potential
>> to do so.
> 
> I'm confused by the description of QEMU's build system as Autotools.

It's not Autotools.  However, *I* am an Autotools fan and therefore have
always looked with suspicion at Autoconf replacements such as CMake or
SCons.  Meson is the first one which not only has pleasantly surprised
me, but also I would consider an improvement for QEMU (Autotools
wouldn't be enough of an improvement to suggest it).

> . We certainly don't currently have a M4 DSL that vomits out an
> impenetrable sets of Makefiles from a set of templates.> The configure script is
> certainly large but portable and readable POSIX shell.

Technically, the M4 DSL spits out shell, not Makefiles (Autoconf can be
used with hand-written Makefiles).  Still,

    if test "$sdl_image" != "no" ; then
        if $pkg_config SDL2_image --exists; then
            if test "$static" = "yes"; then
                sdl_image_libs=$($pkg_config SDL2_image --libs --static
2>/dev/null)
            else
                sdl_image_libs=$($pkg_config SDL2_image --libs 2>/dev/null)
            fi
            sdl_image_cflags=$($pkg_config SDL2_image --cflags 2>/dev/null)
            sdl_image=yes

            sdl_cflags="$sdl_cflags $sdl_image_cflags"
            sdl_libs="$sdl_libs $sdl_image_libs"
        else
            if test "$sdl_image" = "yes" ; then
                feature_not_found "sdl_image" "Install SDL Image devel"
            else
                sdl_image=no
            fi
        fi
    fi

is a bit more verbose than

    sdl_image = dependency('SDL2_image',
                           static: get_option('static'),
                           required: get_option('sdl_image')):

We are used to cut-and-paste, it doesn't mean it's the best way to
approach the problem.

> Finally there is a lot to be said for following the de-facto standard
> ./configure && make pattern.

At the same time, we don't follow the standard fully, for example
--extra-cflags or --cc are QEMU-isms, --srcdir is replaced by
--search-path, and so on.

In any case, this wouldn't change; as you suggest below, configure could
remain as a front-end (well, in-srcdir builds are not supported by
Meson, so "../configure && ninja" perhaps).

>> - ease of distributing a full copy of Meson to support distros that ship
>> an older version (no dependencies apart from Python 3.5).  At 40000
>> lines of Python, Meson is relatively small.
> 
> I suspect needing Python 3.5 means it will take a while before all our
> build hosts will have it.

Which ones don't?  (This is the information I might be missing and why I
have started the thread). RHEL7 has it in software collections, OS X in
Homebrew.   RHEL6 is not a supported host anymore.

> However I have watched many build-systems appear over the years, often
> with wonderful stories and ambitions to avoid all the mistakes and cruft
> of "legacy" make systems only for them to run into their own
> complexities. As someone who builds lots of random software my heart
> tends to sink when I come across a non-standard system because it
> becomes another thing I have to learn just to build something. If we do
> decide to shift I would strongly encourage the front end to still be
> configure/make just to keep the initial learning curve for people
> checking out the QEMU source code for the first time.

I agree.  Again,

Paolo
