Received: from eggs.gnu.org ([2001:4830:134:3::10]:39256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gNfc7-0002UA-Bb
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <asanchez@kryptoslogic.com>) id 1gNfc1-0005ND-B2
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:00:55 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <asanchez@kryptoslogic.com>)
	id 1gNfbz-0004m7-Iz
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:00:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id a11so17905171otr.10
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 07:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
	<1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
In-Reply-To: <1782562d-41c7-0cc7-94f3-fb7ff4b7bd40@redhat.com>
From: Alexandro Sanchez <asanchez@kryptoslogic.com>
Date: Fri, 16 Nov 2018 16:00:33 +0100
Message-ID: <CAA-NuGpjK30VMxb9+OojO4OXSV0yfR2gycpR9tpTxu=vAfTaTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Ning, Yu" <yu.ning@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Hey Paolo,

> What's the advantage of HAXM when Linux hosts can just run KVM?

For end-users, it's true that there's several disadvantages and barely any
advantages: There's some guests run only on HAXM, since it can handle MMIO
accesses using BMI instructions ...and that's about it. :-) The HAXM API
also offers protecting/unprotecting arbitrary chunks of guest memory, which
has some advantages over KVM_GET_DIRTY_LOG. It's used in [1], but has not
been upstreamed yet.

For developers, there's few advantages over KVM that make work slightly
easier/simpler:
- No need to recompile+install a kernel, but just build+load a kernel
module, which takes few seconds, e.g. [2]. I'm aware of your kvm-kmod
(really helpful!), but Linux updates require patching it, which in turn
makes it incompatible with older Linux releases.
- Automated building, testing (and soon nightly builds as well).
- Extensive emulator tests [3] (generic virtualization tests also on the
way).
- Inspired by Bareflank, support for 3rd party "extensions". [4]

Of course, I'm aware that KVM is much more mature/compatible/performant
that HAXM and many other alternatives. My point is that it might be a bit
more comfortable to work with HAXM (and we are trying to improve this
further every day).

Another point concerns what I feel is the raison d'etre for HAXM:

There seems to be an unnecessary fragmentation of hypervisor APIs: KVM
(Linux), HVF (Mac), WHPX (Windows), which resembles the fragmentation of
graphics APIs. Afaik, no cross-platform type-2 hypervisor exists aside from
HAXM and Bareflank. This is fine for QEMU, since all major accelerators are
implemented, but other smaller projects might suffer from this. Of course,
we could wrap all APIs under a single userland library, but aside from
adding another layer of abstraction/translation, the underlying problem
persists: Each new feature needs to be re-implemented inside each
hypervisor (and HVF/WHPX are closed-source!).

Type-2 hypervisors don't *need* to be tightly coupled to a specific kernel:
If you look at HAXM, a thin platform-specific layer exists, the rest is
shared code. I believe that's much more convenient.

Cheers,
Alexandro

[1]
https://android-review.googlesource.com/c/platform/external/qemu/+/643674/
[2] https://travis-ci.com/intel/haxm/builds/91615353
[3] https://github.com/intel/haxm/blob/master/tests/test_emulator.cpp
[4] https://github.com/intel/haxm/pull/121


On Fri, Nov 16, 2018 at 1:53 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 14/11/18 14:04, Alexandro Sanchez Bach wrote:
> > Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch
> includes
> > the corresponding userland changes.
> >
> > Since the Darwin userland backend is POSIX-compliant, the
> hax-darwin.{c,h}
> > files have been renamed to hax-posix.{c,h}. This prefix is consistent
> with
> > the naming used in the rest of QEMU.
>
> What's the advantage of HAXM when Linux hosts can just run KVM?  I guess
> avoiding bitrot?
>
> Paolo
>
