Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhXH3-0006Dv-Rv
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhXH0-0008D5-Nu
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:32:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhXH0-0008Cf-Fh
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:32:26 -0400
Date: Tue, 15 Aug 2017 10:32:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815103221.2446bc3d.cohuck@redhat.com>
In-Reply-To: <86e21c68-93ee-0311-643d-dde2c8589eea@redhat.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<f637c206-266c-d76f-852e-4800422838bb@redhat.com>
	<20170815090302.3f315027.cohuck@redhat.com>
	<222ec8ee-0e1e-ca24-142e-505867bfee27@redhat.com>
	<86e21c68-93ee-0311-643d-dde2c8589eea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On Tue, 15 Aug 2017 10:26:18 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15.08.2017 10:01, Thomas Huth wrote:
> > On 15.08.2017 09:03, Cornelia Huck wrote:  
> >> On Tue, 15 Aug 2017 07:02:10 +0200
> >> Thomas Huth <thuth@redhat.com> wrote:
> >>  
> >>> On 14.08.2017 22:44, Eric Farman wrote:  
> >>>> How often does one really do a "make clean" ?  Rather infrequently,
> >>>> as I only stumbled on this today.
> >>>>
> >>>> Perhaps I have missed the RM variable somewhere, as I see similar syntax
> >>>> in some of the tests/tcg/ Makefiles, but I don't see it being set here.
> >>>> My configure statement isn't terribly interesting, just enabling debug
> >>>> for an s390x target, and as such there's no RM variable in its output.
> >>>> I'll trust that Thomas will chime in with where it should have been.
> >>>> In the meantime, this does the trick for me.    
> >>>
> >>> RM is one of the variables that should be pre-initialized by Make, and
> >>> AFAIK should be used to increase portability (well, it's likely not
> >>> important for QEMU since we require a posix-shell like built environment
> >>> anyway).
> >>>
> >>> According to the info page of Make, chapter "10.3 Variables Used by
> >>> Implicit Rules":
> >>>
> >>> `RM'
> >>>      Command to remove a file; default `rm -f'.
> >>>
> >>> I've also checked it again and "make clean" works fine here (using GNU
> >>> Make 3.82). Which version of Make (and Linux distro) are you using?  
> >>
> >> Interesting. It fails for me with GNU Make 3.82 on my RHEL guest as
> >> well.
> >>  
> >>> Anyway, maybe I also simply missed something, so I'm certainly also fine
> >>> with the patch to revert it to "rm -f".  
> >>
> >> Given that other bios makefiles use rm -f as well, let's just change
> >> back until we figure out what's wrong.  
> > 
> > I just discovered that it fails for me as well when I do "make clean"
> > from the top directory. So far I was only doing "make clean" after doing
> > a "cd pc-bios/s390-ccw" first, and that works fine. Weird. Something
> > seems to unset the RM variable in our build system, but I fail to find
> > the spot where this happens...  
> 
> Ok, just found it: It's this line in rules.mak:
> 
> MAKEFLAGS += -rR
> 
> The parameter -R disables the built-in variables, so RM can indeed not
> work here. Sorry, I wasn't aware of that setting yet, so your patch is
> indeed the right fix here (or we should maybe define RM in rules.mak, too).

The other users are all in tests/tcg/.

Would there be value in using the built-in variables generally? (Well,
value that outweighs having to go through the qemu build system...)
