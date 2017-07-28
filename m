Received: from eggs.gnu.org ([2001:4830:134:3::10]:37925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7uf-0002hn-1H
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:14:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7uZ-0000Bq-V9
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:14:52 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:58199)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1db7uZ-0000Al-IE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 12:14:47 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
	<CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
	<20170727154535.GY2555@redhat.com>
	<20170728133430.GS12364@stefanha-x1.localdomain>
	<20170728135241.GP31495@redhat.com>
Date: Fri, 28 Jul 2017 19:14:33 +0300
In-Reply-To: <20170728135241.GP31495@redhat.com> (Daniel P. Berrange's message
	of "Fri, 28 Jul 2017 14:52:41 +0100")
Message-ID: <87pockles6.fsf@frigg.lan>
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@gmail.com>

Daniel P Berrange writes:

> On Fri, Jul 28, 2017 at 02:34:30PM +0100, Stefan Hajnoczi wrote:
>> On Thu, Jul 27, 2017 at 04:45:35PM +0100, Daniel P. Berrange wrote:
>> > On Thu, Jul 27, 2017 at 04:33:01PM +0100, Peter Maydell wrote:
>> > > On 27 July 2017 at 16:21, Daniel P. Berrange <berrange@redhat.com> wrote:
>> > > > On Thu, Jul 27, 2017 at 11:54:29AM +0100, Peter Maydell wrote:
>> > > >> That said, yes, I was going to ask if we could do this via
>> > > >> leveraging the tracepoint infrastructure and whatever scripting
>> > > >> facilities it provides. Are there any good worked examples of
>> > > >> this sort of thing? Can you do it as an ordinary non-root user?
>> > > >
>> > > > Do you have a particular thing you'd like to see an example of ?
>> > > >
>> > > > To dynamically probe a function which doesn't have a tracepoint
>> > > > defined you can do:
>> > > >
>> > > > probe process("/usr/bin/qemu-x86_64").function("helper_syscall") {
>> > > >   printf("syscall stasrt\n")
>> > > > }
>> > > >
>> > > > but getting access to the function args is not as easy as with
>> > > > pre-defined tracepoints.
>> > > 
>> > > How do I go about actually running that script? What I
>> > > have in mind by "worked example" is something like a blog
>> > > post that says "ok, here's a problem, we want to find out
>> > > what QEMU is doing in situation X, here's how you do this
>> > > with $TRACING_THINGY" and generally steps you through how
>> > > it works assuming you know nothing at all about whatever
>> > > the tracing facility you're using is.
>> > 
>> > Ok, so something like this example that I wrote for libvirt a
>> > while back then
>> > 
>> >   https://www.berrange.com/posts/2011/11/30/watching-the-libvirt-rpc-protocol-using-systemtap/
>> > 
>> > 
>> > > > You can't typically run this as root,
>> > > 
>> > > Do you mean "non-root" ?
>> > 
>> > Sigh, yes, of course.
>> > 
>> > > > however, I don't think that's a
>> > > > huge issue, because most QEMU deployments are not running as your own
>> > > > user account anyway, so you can't directly interact with them no
>> > > > matter what.
>> > > 
>> > > It is important, because almost all uses of TCG QEMU are
>> > > running it from the command line as non-root normal users,
>> > > especially if they're trying to debug what's going on with a
>> > > guest binary. So any tracing solution for this kind of usecase
>> > > must work without requiring root access, I think.
>> > 
>> > None of the Linux integrated tracing tools allow direct non-root access
>> > afaik. systemtap has ability to launch probes as non-root, via a privileged
>> > daemon, but it is restricted to probe scripts that the administrator has
>> > pre-defined.
>> 
>> One exception is gdb's static userspace probes support.  If you can run
>> gdb on QEMU then you can trace the same events as SystemTap.  I have
>> never tried this GDB feature:
>> 
>> https://sourceware.org/gdb/onlinedocs/gdb/Static-Probe-Points.html
>> 
>> It should work out of the box if your distro builds QEMU with the
>> 'dtrace' backend enabled.

> Wow, that's great to learn about. It does indeed work !

> If you knew alot about ptrace() you could probably build something
> that use ptrace() and these probe points to call your dynamic
> instrumentation code with reasonable low overheads.

I don't think so. Ptrace traps into the kernel and stops the process while a
separate process decides what to do. That's between 3 and 4 orders of magnitude
slower than calling an instrumentor function.


Cheers,
  Lluis
