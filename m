Received: from eggs.gnu.org ([2001:4830:134:3::10]:34782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcu97-0001at-3u
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fcu93-0000Kq-7h
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:01:41 -0400
Date: Tue, 10 Jul 2018 17:01:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180710170122.427ce3a4.cohuck@redhat.com>
In-Reply-To: <20180710143931.GQ1148@andariel.pipo.sk>
References: <20180703111949.GB24516@redhat.com>
	<20180703113229.GD3812@localhost.localdomain>
	<20180704150256.408d4a07.cohuck@redhat.com>
	<20180704133440.GE4334@localhost.localdomain>
	<CAFEAcA-RVBXBj=+nr_D=bexLP4Rwgs+xyjJQ8VoOM9aOOVUJ3A@mail.gmail.com>
	<20180706131103.4e713911.cohuck@redhat.com>
	<20180706145645.GB3939@localhost.localdomain>
	<20180709072953.GE7755@andariel.pipo.sk>
	<87k1q3ljgs.fsf@dusky.pond.sub.org>
	<20180710162208.7b1b5cdc.cohuck@redhat.com>
	<20180710143931.GQ1148@andariel.pipo.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 10 Jul 2018 16:39:31 +0200
Peter Krempa <pkrempa@redhat.com> wrote:

> On Tue, Jul 10, 2018 at 16:22:08 +0200, Cornelia Huck wrote:
> > On Tue, 10 Jul 2018 07:59:15 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >   
> > > In addition to actively pulling libvirt developers into review of
> > > deprecation patches, we should pursue the idea to optionally let QEMU
> > > fail on use of deprecated features, then have libvirt run its test suite
> > > that way.  
> > 
> > What about the following:
> > 
> > qemu_deprecated_option("old_option", "modern_option");  
> 
> I think this is too simplified. You can deprecate only a certain value
> for an option or even just a combination of values and options. The
> check will need to be programatic and error reporting probably can't be
> reasonably machine readable anyways.

Kevin's suggestion of using a simple message instead of this old/modern
option thing is actually better (and would cover more). My intention
behind printing a message (somewhere) was to make this friendly to
command line users as well.

> 
> > Which would then print (in normal operation)
> > 
> > "WARNING: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
> > 
> > to the monitor (or to stderr? to both?).
> > 
> > If you start QEMU with a -no-deprecated-options switch, it would print
> > 
> > "ERROR: 'old_option' is deprecated and will be removed; use 'modern_option' instead"
> > 
> > and do an exit(1).
> > 
> > Would that be workable?  
> 
> For delivering the warnings via monitor you'll need a store that will
> collect all the warnings and prepare them for delivery. You've got
> basically two options:
> 
> 1) monitor command to poll for deprecated options
> 2) event with deprecated options
> 
> Both require storing them since libvirt connects to the monitor only
> after the command line is processed.
> 
> Warnings printed to stderr are nearly useless because until something
> breaks nobody bothers to read the log files.

So, from that I gather that a hard failure would be the easiest for
libvirt to detect (and everything else would become complicated really
quickly), right?

If we fail with exit(1), can libvirt check any message that is logged
right before that?

> 
> To make any reasonable use of -no-deprecated-options we'd also need
> something that simulates qemu startup (no resources are touched in fact)
> so that we can run it against the testsuite. Otherwise the use will be
> limited to developers using it with the configuration they are
> currently testing.

Would that moan loudly that you should poke the libvirt developers if
some kind of testsuite failure is detected? Or am I misunderstanding?

Who is, in general, testing which libvirt version? I can think of:
- libvirt developers, which will probably run libvirt current git, but
  more likely a released QEMU?
- QEMU (and other related tools) developers, who will probably use QEMU
  current git, but a released libvirt
- normal (technical) users and (integration) testers, who will probably
  use released versions of libvirt and QEMU
