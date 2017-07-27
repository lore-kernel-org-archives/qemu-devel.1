Received: from eggs.gnu.org ([2001:4830:134:3::10]:58175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daosi-00021I-In
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daosf-0004pQ-9o
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:55:36 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:51201 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1daose-0004oK-TQ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 15:55:33 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
Date: Thu, 27 Jul 2017 22:55:14 +0300
In-Reply-To: <20170727152137.GW2555@redhat.com> (Daniel P. Berrange's message
	of "Thu, 27 Jul 2017 16:21:37 +0100")
Message-ID: <87mv7psli5.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Daniel P Berrange writes:

> On Thu, Jul 27, 2017 at 11:54:29AM +0100, Peter Maydell wrote:
>> On 27 July 2017 at 11:43, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > Maybe I'm missing something, but aren't all these things
>> > already possible via either the statically defined tracepoints
>> > QEMU exposes, or by placing dynamic tracepoints on arbitrary
>> > code locations using dtrace/systemtap/lttng-ust.
>> 
>> Last time I looked we didn't have tracepoints on most of
>> the events you'd be interested in.
>> 
>> That said, yes, I was going to ask if we could do this via
>> leveraging the tracepoint infrastructure and whatever scripting
>> facilities it provides. Are there any good worked examples of
>> this sort of thing? Can you do it as an ordinary non-root user?

> Do you have a particular thing you'd like to see an example of ?

> To dynamically probe a function which doesn't have a tracepoint
> defined you can do:

> probe process("/usr/bin/qemu-x86_64").function("helper_syscall") {
>   printf("syscall stasrt\n")
> }

> but getting access to the function args is not as easy as with
> pre-defined tracepoints.

> You can't typically run this as root, however, I don't think that's a
> huge issue, because most QEMU deployments are not running as your own
> user account anyway, so you can't directly interact with them no
> matter what.

> If the goal is to be easy to instrument without havig to rebuild
> QEMU, then I think using one of the existing trace backends is
> the best viable option, as those are already enabled by distros.
> I find it very unlikely that Fedora/RHEL would ever enable a
> trace backend that lets you load arbitrary code into the QEMU
> process, so you'd be back to having to rebuild QEMU again even
> with that approach.

My idea is to use the guest code tracing events to perform some complex analysis
of the executed guest code. E.g., tracing executed instructions to a file to
calculate SimPoints [1], analysing guest instructions and memory accesses to
track information flow or feeding that info to a processor simulator. In fact,
I've used my non-upstream version of QEMU+instrumentation to do the first two
and a few others.

My problem with dtrace is efficiency of the instrumentation code, and the lack
of APIs to perform a few more complex analysis like peek/poke on guest memory,
registers or even control event tracing states. I'm not proposing to have such
APIs on QEMU upstream (unless there's interest), but they are easy enough for me
to maintain for my particular needs if we're talking about the instrumentation
support in this series.

So Stefan, could you elaborate on your proposal of having to build the
instrumentation code into QEMU? I would prefer a dynamic library if we can craft
it in a way that ensures the proper license restrictions, but a "static library"
could work just as well for me (I initially had a branch with both solutions,
but it got too tedious to rebase).


Thanks,
  Lluis
