Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1edgu8-0007Rw-QR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1edgu7-0003P1-QX
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:33:12 -0500
Date: Mon, 22 Jan 2018 16:33:01 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180122183301.GA31237@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<CAFEAcA-UO5Y_ACSZ2EEQEzgy30wdfEm3u8wUrBrXWaQaE_v+Kw@mail.gmail.com>
	<20171209010811.GJ3037@localhost.localdomain>
	<CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9oG=+mJ+jSGTM_z54S09gjHoFowDkOvofdkhJd+g3=Cw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/6] arm: support -cpu max (and
 gic-version=max)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Mon, Jan 22, 2018 at 06:06:26PM +0000, Peter Maydell wrote:
> On 9 December 2017 at 01:08, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Thu, Dec 07, 2017 at 07:37:31PM +0000, Peter Maydell wrote:
> >> On 7 December 2017 at 18:14, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> > This patchset adds support for '-cpu max' to Arm, along the lines
> >> > of the existing support we have for x86 targets:
> >> >
> >> >  * under KVM, -cpu max is the same as -cpu host
> >> >  * under TCG, -cpu max means "emulate with as many features as
> >> >    possible"
> >>
> >> Forgot to mention: -cpu max for qemu-system-aarch64 will
> >> be a 64-bit cpu, and for qemu-system-arm it will be a 32-bit
> >> cpu. (This differs from all the other TCG CPU types, which
> >> behave the same for the 32-bit and 64-bit binaries. I think
> >> it is the same way that x86 -cpu max works, though.)
> >
> > Are they going to be represented by two different QOM type names?
> >
> > (In the case of x86, all the CPU classes have different names on
> > qemu-system-x86_64 and qemu-system-i386).
> 
> (Just pulling this thread up from before Christmas...)
> 
> I guess a better way to approach this would be to ask: how is
> x86 implementing -cpu max, ie what is the required view of things
> that I need to provide for target/arm in order to have QEMU
> behave the same way x86 does? Did we write any user-facing
> documentation for this feature?

About QOM type names:

On x86, all CPU models are resolved to "<model>-<suffix>", and
i386 and x86_64 have different suffixes.  So the QOM type name is
"max-x86_64-cpu" on qemu-system-x86_64, and "max-i386-cpu" on
qemu-system-i386.

About the implementation:

On x86, the most important differences between CPU models are on
(boolean) CPUID feature flags.  "max" just set all feature flags
to *get_supported_cpuid(...), meaning all features supported by
the host will be enabled.  The other fields (e.g. CPU
vendor/family/model IDs) depend on the accelerator: on TCG we use
constant values, on KVM we use the host CPU values).

About how it should behave:

An important expectation about "max" is about the
query-cpu-model-expansion return value.  Having a property set to
true on the return value of "query-cpu-model-expansion model=max"
means the corresponding feature is supported on the current host
and can be enabled on the command-line.

The most important user-facing documentation related to "max" is
the query-cpu-model-* QMP docs.  It probably needs to be updated
to contain more specific details about how "max" behaves.
Probably we could have automated tests to confirm if some
expectations are really fulfilled.


> 
> (The code in this patchset makes '-cpu max' give the same
> QOM type name for both qemu-system-arm and qemu-system-aarch64,
> with different behaviour depending on the binary. If that means
> we don't provide the same behaviour as x86 then I can change that,
> but I'm not sure where the difference is exposed to the user?)

This is not how the QOM names work on x86, but I don't think QOM
type names choices have important user-visible side-effects
today.  Choosing unique QOM type names is more important to make
the code future-proof for when we merge QEMU binaries, than to
make user-visible behavior consistent.

-- 
Eduardo
