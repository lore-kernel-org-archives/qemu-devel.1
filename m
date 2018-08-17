Received: from eggs.gnu.org ([2001:4830:134:3::10]:51499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqajd-0007Ff-FK
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fqajc-0004MO-Gq
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 05:07:57 -0400
Date: Fri, 17 Aug 2018 10:07:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180817090747.GB11124@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <2e8b4754-2f83-d263-f562-b753aea90d42@virtuozzo.com>
	<d5e88645-e43f-1d3c-6dd1-e20e04733d4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5e88645-e43f-1d3c-6dd1-e20e04733d4f@redhat.com>
Subject: Re: [Qemu-devel] nbd oldstyle negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, nbd list <nbd@other.debian.org>

On Thu, Aug 16, 2018 at 02:56:10PM -0500, Eric Blake wrote:
> On 08/16/2018 02:02 PM, Vladimir Sementsov-Ogievskiy wrote:
> > Hi Eric!
> > 
> > There is a small problem with our qemu-nbd cmdline interface: people
> > forget to use option -x or don't know about it and face into problems
> > with old protocol version. One of may colleagues after such situation
> > (because of this option, he could not use utility nbd-client, which
> > doesn't support old version) asked me to add comments about version
> > selection by -x option into --help of qemu-nbd. And really, it's not an
> > obvious interface solution...
> > 
> > Now I think, should not we use new version by default? Or, even drop old
> > version support at all? Anybody uses it?
> 
> nbdkit 1.3 switched its default to newstyle (Jan 2018):
> https://github.com/libguestfs/nbdkit/commit/b2a8aecc
> https://github.com/libguestfs/nbdkit/commit/8158e773
> 
> and you are correct that nbd 3.10 dropped oldstyle long ago (Mar 2015):
> https://github.com/NetworkBlockDevice/nbd/commit/36940193
> 
> oldstyle is severely lacking in features (it can't do TLS or efficient
> sparse file handling, for example).  Do we need a formal qemu deprecation
> period (where you still get oldstyle if -x was not used, but a nice big
> warning) before flipping the default in 3.2/3.3 [1], or are we okay flipping
> it in 3.1?
> 
> [1] Okay, I know that our new equally-arbitrary policy on when to bump qemu
> version number components means that we'll probably see 3.1 in 2018 then 4.0
> in 2019, rather than 3.2.
> 
> And, if we switch the default now (which I am in favor of), do we want to
> add a -o switch to still make it possible to select oldstyle for a couple
> more releases in case someone was relying on it?  Then again, if you have to
> amend your script to use -o to keep things from breaking, why not just amend
> your setup to use newstyle?
> 
> My personal preference: completely drop oldstyle support from qemu, for 3.1,
> with no deprecation period. Do so by making '-x ""' the default for any
> qemu-nbd command line that did not otherwise specify an export name.  If
> someone still needs interoperability, they can use nbdkit in the middle,
> which will still support oldstyle, and provides a plugin for connecting:

So the key question is if the server switches to newstyle with "" export
name, what versions of qemu client will cease to work. Originally the QEMU
client would refuse to use new style protocol if not export name was given.

I fixed that in

commit 69b49502d8b7b582af79fac5bef7b7ccc2dc9c1e
Author: Daniel P. Berrange <berrange@redhat.com>
Date:   Wed Feb 10 18:41:10 2016 +0000

    nbd: use "" as a default export name if none provided
    

So if we mandate new style in the server then we break compat with any
QEMU client that is < 2.6.0

I think that is acceptable as this point in time, as that'll be about
3 years old by time 3.1 comes out.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
