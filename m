Received: from eggs.gnu.org ([2001:4830:134:3::10]:51594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnm5l-0003zt-Fw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnm5h-0000qq-O1
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:02:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33116)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnm5h-0000pT-E5
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:02:17 -0400
Date: Tue, 14 Mar 2017 13:02:13 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314130213.GP2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
	<d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
	<20170314123254.GB21475@vader>
	<b27ec1df-6c32-0084-1991-283cb2b8f689@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b27ec1df-6c32-0084-1991-283cb2b8f689@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] seccomp: add elevateprivileges
 argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>

On Tue, Mar 14, 2017 at 01:48:59PM +0100, Paolo Bonzini wrote:
> 
> 
> On 14/03/2017 13:32, Eduardo Otubo wrote:
> > On Tue, Mar 14, 2017 at 01=13=15PM +0100, Paolo Bonzini wrote:
> >>
> >>
> >> On 14/03/2017 12:52, Daniel P. Berrange wrote:
> >>>>>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> >>>>> -    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
> >>>>> -    "                              obsolete: Allow obsolete system calls",
> >>>>> +    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
> >>>>> +    "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
> >>>>> +    "                               obsolete: Allow obsolete system calls\n" \
> >>>>> +    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
> >>>> Why allow these by default?
> >>> The goal is that '-sandbox on' should not break *any* QEMU feature. It
> >>> needs to be a safe thing that people can unconditionally turn on without
> >>> thinking about it.
> >>
> >> Sure, but what advantages would it provide if the default blacklist does
> >> not block anything meaningful?  At the very least, spawn=deny should
> >> default elevateprivileges to deny too.
> >>
> >> I think there should be a list (as small as possible) of features that
> >> are sacrificed by "-sandbox on".
> > 
> > Can you give an example of such a list?
> 
> Well, anything that makes "-sandbox on" more than security theater...  I
> would consider it a necessary evil, not a good thing to have such a list.

> Due to NO_NEW_PRIVS, I think non-migration fork/exec should be on the
> list, but hopefully nothing else.

The current semantics of '-sandbox on' are that it is documented to not
break any valid QEMU features. By blocking fork/exec, we make a semantic
change to the existing behaviour of '-sandbox on'. So any application
which has been using '-sandbox on' historically, is at risk of being
broken when upgrading to QEMU 2.10. It would force the application to
generate a different CLI for new QEMU - ie to avoid being broken they
would have to now  add elevateprivs=allow, spawn=allow. I think we have
to maintain semantic compat with existing usage, which means that
'-sandbox on' has to remain security theatre.

So if we want a default config to be more restrictive, then I think you
realistically have to turn the default parameter into a tri-state
instead of bool, ie allow '-sandbox default' as an alternative to
'-sandbox on' that was slightly stronger by blocking fork/exec.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
