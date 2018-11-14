Received: from eggs.gnu.org ([2001:4830:134:3::10]:41617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMtMA-0006TF-W3
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:29:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMtM7-0002rw-2a
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMtM6-0002rV-MQ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 06:29:11 -0500
Date: Wed, 14 Nov 2018 11:29:01 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114112901.GH19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <154219299016.19470.9372139354280787961.stgit@wayrath>
	<cce56aa63fe36bca59f1f6a6872d43ea11435f25.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cce56aa63fe36bca59f1f6a6872d43ea11435f25.camel@suse.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Series short description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dario Faggioli <dfaggioli@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Nov 14, 2018 at 12:08:42PM +0100, Dario Faggioli wrote:
> Wow... Mmm, not sure what went wrong... Anyway, this is the cover
> letter I thought I had sent. Sorry :-/

No problem !

If you have not come across it before, "git-publish" is a great addon
tool for git to make sending patch series more pain-free

   https://github.com/stefanha/git-publish

QEMU git provides a config file for it, so you can just run "git-publish"
with no args and it will send a series containing all patches on your
currently checked out branch, automatically reading the MAINTAINERS file
to figure out who should be CC'd on the series.

The only global setup is for your $HOME/.gitconfig to contain a setting
for "smtpserver" under the "[sendemail]" group for outbound SMTP relay.

> --
> Hello everyone,
> 
> This is Dario, from SUSE, and this is the first time I touch QEMU. :-D

Welcome & thanks for your first patch(es) to QEMU.

I'll let others comment on the actual code you've sent...

> So, basically, while playing with an AMD EPYC box, we came across a weird
> performance regression between host and guest. It was happening with the
> STREAM benchmark, and we tracked it down to non-temporal stores _not_ being
> used, inside the guest.
> 
> More specifically, this was because the glibc version we were dealing with had
> heuristics for deciding whether or not to use NT instructions. Basically, it
> was checking is how big the L2 and L3 caches are, as compared to how many
> threads are actually sharing such caches.
> 
> Currently, as far as cache layout and size are concerned, we only have the
> following options:
> - no L3 cache,
> - emulated L3 cache, which means the default cache layout for the chosen CPU
>   is used,
> - host L3 cache info, which means the cache layout of the host is used.
> 
> Now, in our case, 'host-cache-info' made sense, because we were pinning vcpus
> as well as doing other optimizations. However, as the VM had _less_ vcpus than
> the host had pcpus, the result of the heuristics was to avoid non-temporal
> stores, causing the unexpectedly high drop in performance. And, as you can
> imagine, we could not fix things by using 'l3-cache=on' either.
> 
> This made us think this could be a general problem, and not only an issue for
> our benchmarks, and here it comes this series. :-)
> 
> Basically, while we can, of course, control the number of vcpus a guest has
> already --as well as how they are arranged within the guest topology-- we can't
> control how big are the caches the guest sees. And this is what this series
> tries to implement: giving the user the ability to tweak the actual size of the
> L2 and L3 caches, to deal with all those cases when the guest OS or userspace
> do check that, and behave differently depending on what they see.
> 
> Yes, this is not at all that common, but happens, and hece the feature can
> be considered useful, IMO. And yes, it is definitely something meant for those
> cases where one is carefully tuning and highly optimizing, with things like
> vcpu pinning, etc.
> 
> I've tested with many CPU models, and the cahce info from inside the guest
> looks consistent. I haven't re-run the benchmarks that triggered all this work,
> as I don't have the proper hardware handy right now, but I'm planning to
> (although, as said, this looks like a general problem to me).
> 
> I've got libvirt patches for exposing these new properties in the works, but
> of course they only make sense if/when this series is accepted.
> 
> As I said, it's my first submission, and it's RFC because there are a couple
> of things that I'm not sure I got right (details in the single patches).
> 
> Any comment or advice more than welcome. :-)
> 
> Thanks and Regards,
> Dario
> ---
> Dario Faggioli (3):
>       i386: add properties for customizing L2 and L3 cache sizes
>       i386: custom cache size in CPUID2 and CPUID4 descriptors
>       i386: custom cache size in AMD's CPUID descriptors too
> 
>  include/hw/i386/pc.h |    8 ++++++++
>  target/i386/cpu.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h    |    3 +++
>  3 files changed, 61 insertions(+)
> 
> -- 
> <<This happens because I choose it to happen!>> (Raistlin Majere)
> -----------------------------------------------------------------
> Dario Faggioli, Ph.D, http://about.me/dario.faggioli
> Software Engineer @ SUSE https://www.suse.com/



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
