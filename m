Received: from eggs.gnu.org ([2001:4830:134:3::10]:36465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNSH-0001Pv-Nt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTNSG-0004gs-KS
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:18:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fTNSG-0004gj-EE
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:18:04 -0400
Date: Thu, 14 Jun 2018 09:18:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614081800.GH6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180612184616.90838-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180612184616.90838-1-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>

On Tue, Jun 12, 2018 at 09:47:11PM +0300, Michael S. Tsirkin wrote:
> This adds ability to expose host CPU power management capabilities to
> guests. For intel guests, this is sufficient for guest to enable
> low power CPU power management. For AMD guests it isn't sufficient,
> deeper C-states are entered using System-IO.
> 
> mwait based power management is tied closely to specifics of CPUID,
> making migration challenging. At this point only the non-migrateable
> -cpu host is supported.
> 
> With this patch applied, VM latency is within the noise of
> baremetal for some benchmarks.
> 
> perf bench sched pipe results:
> Before:
>     6.452 sec
> After:
>     4.382 sec
> Baremetal:
>     4.136 sec
> 
> Michael S. Tsirkin (2):
>   kvm: support -realtime cpu-pm=on|off

IMHO this really shouldn't be under the -realtime flag. I don't think
the -realtime flag should ever have been introduced, and we certainly
shouldn't add more stuff under it.

"-realtime" is referring to a very specific use case, while the
properties listed under it are all general purpose features. Real
time guests just happen to be one possible use case, but it is
valid to use them for non-real time guests.

IOW, I think we should just have this as an option under -cpu or
some other *functionally* named option, not a option named after
a specific usage scenario.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
