Received: from eggs.gnu.org ([2001:4830:134:3::10]:54588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gG30c-0007Rs-7p
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gG30Y-0002Nn-8T
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gG30S-0002Gq-Lh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:34 -0400
Date: Fri, 26 Oct 2018 15:22:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181026142216.GB493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <87mur0ls8o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87mur0ls8o.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Minutes of KVM Forum BoF on deprecating stuff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Andrea Bolognani <abologna@redhat.com>, Christophe de Dinechin <cdupontd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laine Stump <laine@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Pino Toscano <ptoscano@redhat.com>, Thomas Huth <thuth@redhat.com>


On Fri, Oct 26, 2018 at 04:03:51PM +0200, Markus Armbruster wrote:
> This is from my (imperfect) notes, corrections welcome.
> 
> Motivation: QEMU contains stuff of dubious value, which gets in the way
> in various (sometimes painful and expensive) ways.
>
> Deprecation is the marking of an external interface as "we intend to
> remove this, you should stop using it" (preferably with advice on what
> to use instead).  We have a deprecation policy to guide us through this
> process.


Something I meant to bring up but forgot is about the classification
of devices, especially with a view towards security. It is not directly
about deprecation, but it is somewhat related as it is related  to the
state of maintainence and quality level

We've got alot of devices, but only a subset are written and maintained
to a level where we'd consider them robust wrt malcious guests. Other
devices are only suitable for friendly guest environments. We should
clearly document which are the devices that we consider to provide
a secure boundary to guests, so users can make suitably informed choices.
I'd guess this means all virtio devices, and then few of the emulated
devices that are commonly used & maintained in a KVM environment.

This would be useful for distros/vendors/users who wish to limit their
potential attack surface once we have a KConfig system for fine grained
disablement of features.

> Topics we covered, reordered for readability:
> 
> * Dropping features inconveniences their users.  Keeping them impedes
>   forward movement, and thus inconveniences other users.  We need to
>   engage with the tradeoffs.
> 
> * The cost of keeping both old and new for a deprecation grace period
>   (currently two releases) can be painfully high.  Tradeoff again.
>   However, there's rough consensus not to mess with the deprecation
>   policy right now.
> 
> * When something has been broken for the customary deprecation grace
>   period, removing it without going through the deprecation process
>   should be okay.
> 
> * We may have to deprecate interfaces, but we may also have a need to
>   deprecate guarantees interfaces provide.  Worse when the guarantees
>   are tacit.  No good answers.  Let's attack less thorny problems first.
> 
> * One obvious class of candidates for removal is machines we don't know
>   how to boot, or can't boot, say because we lack required firmware
>   and/or OS.
> 
>   Of course, "can boot" should be an automated test.  As a first step
>   towards that, we should at least document how to boot each machine.
>   We're going to ask machine maintainers to do that.
> 
> * We need to communicate "you're using something that is deprecated".
>   How?  Right now, we print a deprecation message.  Okay when humans use
>   QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>   software stack, the message will likely end up in a log file that is
>   effectively write-only.
>  
>   - The one way to get people read log files is crashing their
>     application.  A command line option --future could make QEMU crash
>     right after printing a deprecation message.  This could help with
>     finding use of deprecated features in a testing environment.
> 
>   - A less destructive way to grab people's attention is to make things
>     run really, really slow: have QEMU go to sleep for a while after
>     printing a deprecation message.
>     
>   - We can also pass the buck to the next layer up: emit a QMP event.
> 
>     Sadly, by the time the next layer connects to QMP, plenty of stuff
>     already happened.  We'd have to buffer deprecation events somehow.
> 
>     What would libvirt do with such an event?  Log it, taint the domain,
>     emit a (libvirt) event to pass it on to the next layer up.
> 
>   - A completely different idea is to have a configuratin linter.  To
>     support doing this at the libvirt level, QEMU could expose "is
>     deprecated" in interface introspection.  Feels feasible for QMP,
>     where we already have sufficiently expressive introspection.  For
>     CLI, we'd first have to provide that (but we want that anyway).
> 
>   - We might also want to dispay deprecation messages in QEMU's GUI
>     somehow, or on serial consoles.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
