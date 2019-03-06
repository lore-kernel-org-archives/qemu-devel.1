Received: from eggs.gnu.org ([209.51.188.92]:50832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1dmQ-000412-Hi
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h1dmL-0004id-KK
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:08:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h1dmL-0004ci-8D
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 16:08:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id w2so15009255wrt.11
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 13:08:36 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<CAMxuvaychZk+OG5dJ-2HhttNozxLwNx+Qqj1kjpQmFy5AzRx+g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90089441-926e-07aa-d42d-2b6c3b0dbd9e@redhat.com>
Date: Wed, 6 Mar 2019 22:08:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAMxuvaychZk+OG5dJ-2HhttNozxLwNx+Qqj1kjpQmFy5AzRx+g@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 06/03/19 19:50, Marc-André Lureau wrote:
>> Unlike Autoconf, meson.build files include both feature detection and
>> build rules.  Also unlike Autoconf, Meson must be present on the system
>> of whoever builds QEMU, which is why the last bullet above matters.
>> However, it is possible to keep a configure script, if only to provide
>> backwards command line compatibility and support a bundled copy of Meson.
> 
> Yes, we will probably have a transition period where both build-sys
> have to co-exist (same story with libslirp, which I proposed as
> meson-only first)
>
>> Of course a full conversion of QEMU's build system, including the 7k
>> lines configure script is not easy.  In addition, even though Meson
> 
> I don't think a complete transition in one go is feasible. Could we
> start with some basic things?
> 
> For example, we could quite easily start converting tools (qemu-img
> etc), some tests...

Tools use Makefile.objs just like everything else, on the other hand
tests and libqemu*.a may be a good start.  Also the generated files.

Co-existence as in being able to build with either one or the other is
complicated, and this is also why I did the ninja-to-make converter.
The idea is that configure would run "meson setup" just before exiting,
run ninja2make, and then the ninja rules would be included transparently
in the Makefile.

Even after a full transition to Meson, you'd do "../configure && ninja",
not "meson setup build && ninja -C build".  (Another possible thing to
do in preparation could be to deprecate in-tree builds).

>> supports extension modules that are written in Python, those are really
>> used only for namespacing purposes as the extensions need to live in the
> 
> I didn't know, I suppose meson doesn't want to support an internal API?

Yes.  Extensions need to know about all sorts of Meson innards,
especially if they do things such as defining custom "classes" for use
in meson.build.  They are not particularly easy to write if you haven't
previously hacked Meson, and given Meson's overall design philosophy,
module hackability is absolutely not part of the goals.

But I see no reason why the two extensions QEMU needs couldn't be
upstreamed; in fact the kconfig module was started two years ago (and
never completed, which is good because it wasn't a great API).  It's
ugly that until an extension is declared "stable" it prints a warning
when you run meson, but hopefully the Meson developers might declare
them stable as soon as QEMU is ready to switch.

>> - ability to use the currently in progress Kconfig declarations for
>> dependencies.  Meson developers have expressed that they would accept an
>> extension module that loads Kconfig-like declarations from a file; this
>> would also be useful to start using Meson only as a Make replacement
>> while keeping the current configure script[4], since we could slurp
> 
> (you meant [3])

No, it was supposed to be a "hidden gem" link to ninja2make, but then I
expanded more on the topic below and ended up not adding the link at all
as you noticed.

>>    if config.get('BAR') == 'y' and not config.has('FOO') then
>>      config.set('FOO', 'y')
>>    endif
>>    if config.get('FOO') == 'y' then
>>      if config.has('BAZ') and config.get('BAZ') != 'y' then
>>        error('FOO selects BAZ, but BAZ is disabled')
>>      endif
>>      config.set('BAZ', 'y')
>>    endif
>>
>> I have not tried doing this, but it seems feasible.
> 
> I am confused, I thought minikconf was generating a .mak (I am not
> very familiar with it, I am waiting for it to land!)

Yes.  But with Meson it would have to be done differently, you would
have a Kconfig->meson.build translator and then the kconfig logic is
executed at "meson setup" time.

>> - Meson generates a build.ninja file rather than a Makefile, which also
>> complicates a bit interoperability with the current system.  This is
>> perhaps minor, since in most cases the change is just s/make/ninja/ but
>> it may matter for day-to-day development.  For this I have prototyped a
>> converter (written in Python) from ninja back to Make, so that we could
> 
> wow, interesting, and no link? :)

https://gist.githubusercontent.com/bonzini/8ed6659a14213818675e1039fa27c221/raw/1c68b1ecdd94b2270ee1a779e0edfafb42e35896/ninja2make.py

The kind of thing where you're not sure whether to be proud or ashamed
of what you've just done. :)

>> To be clear, this is not something I am going to work anytime soon.
>> Still in my opinion it's a worthwhile exercise to think about it.  As I
>> will see in the next few weeks what the Meson maintainers' reaction will
>> be to some of the proposed extensions, I wanted to gauge the reactions
>> of you all as well. :)
> 
> I like meson better than anything else. It is still young, one can
> find quickly limitations & documentation could be better (if you
> compare it with make/autoconf/automake reference manual for ex). But I
> also believe it has the potential to improve the qemu build-sys and
> make it more readable & more modern (meson has some IDE integration
> stuff, multiple targets, and various niceties).
> 
> Do you have a WIP branch somewhere we could contribute to?

No branch at all, just some design ideas that are somewhat visible in my
Meson pull requests and in this thread.

> Alternatively, could we start small upstream, with the tools for
> example, and iterate there? (unless one bikeshed on our favorite
> build-sys - then let's work on it in a seperate branch)

FWIW I don't think there is any alternative, it's either Meson or what
we have now.  Autotools for example don't give enough benefit, you'd
have the complications of two nested configure scripts and you'd still
have to deal with Make complications _and_ Automake's added magic.

Autotools probably make more sense than Meson for pc-bios, which is a
complex multi-cross-compiler scenario.

Paolo
