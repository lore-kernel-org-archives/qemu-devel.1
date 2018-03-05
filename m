Received: from eggs.gnu.org ([2001:4830:134:3::10]:47250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esqXp-0007p4-EU
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1esqXm-0003Vj-3S
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1esqXl-0003VV-Tj
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 08:52:46 -0500
Date: Mon, 5 Mar 2018 13:52:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180305135232.GR17368@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
	<ca21f795-dae7-d6b5-44f1-ef8ba792ac04@redhat.com>
	<20180305110122.GD3131@work-vm>
	<20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
	<CAFEAcA8jse2AdCO8JgA7m99h8pwTRBCQ9aOi=-0QOG+pA9tk2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8jse2AdCO8JgA7m99h8pwTRBCQ9aOi=-0QOG+pA9tk2w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Mar 05, 2018 at 01:40:06PM +0000, Peter Maydell wrote:
> On 5 March 2018 at 13:36, Andrew Jones <drjones@redhat.com> wrote:
> > IMO, the makefile is the right approach. I wouldn't like to see AArch64
> > added with a script and then converted, along with x86, to a makefile at
> > some later time (probably never).
> 
> I'm not really enthusiastic about this approach of picking a cross
> compiler in the makefile rather than configure, though. The stuff
> we have at the moment that tries to build the x86 ROMs with whatever
> random host compiler we happen to be using is already a source
> of occasional brokenness. If we're going to try to build target
> code on a wider basis than just the x86 roms I'd like to see it
> done in a cleaner manner...

Seems like for each arch that we need a cross compiler for, we
ought to have configure args & a corresponding config.mak variable

eg

   configure \
   	--cross-cc-aarch64=aarch64-redhat-linux-gcc \
        --cross-cc-x86_64=x86_64-redhat-linux-gcc \

If the --cross-cc-$ARCH arg isn't given we can just autodetect
one, if present.

This would end up setting in config.mak

 CROSS_CC_X86_64=x86_64-redhat-linux-c++
 CROSS_CC_AARCH64=aarch64-redhat-linux-c++


If the --cross-cc-$ARCH  arg is not given, and we can't automatically
find a suitable compiler for that arch, then CC_$ARCH make variable
should be left undefined. Any rules using these cross-compilers should
automatically disable themselves, to ensure we don't suddenly force
all people building QEMU to install many cross compilers.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
