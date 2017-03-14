Received: from eggs.gnu.org ([2001:4830:134:3::10]:39512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnlVf-0005uK-Au
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cnlVb-0005qx-Iw
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:25:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cnlVb-0005qa-9q
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:24:59 -0400
Date: Tue, 14 Mar 2017 12:24:55 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170314122455.GM2652@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
	<d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
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
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>

On Tue, Mar 14, 2017 at 01:13:15PM +0100, Paolo Bonzini wrote:
> 
> 
> On 14/03/2017 12:52, Daniel P. Berrange wrote:
> >>>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
> >>> -    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
> >>> -    "                              obsolete: Allow obsolete system calls",
> >>> +    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
> >>> +    "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
> >>> +    "                               obsolete: Allow obsolete system calls\n" \
> >>> +    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
> >> Why allow these by default?
> > The goal is that '-sandbox on' should not break *any* QEMU feature. It
> > needs to be a safe thing that people can unconditionally turn on without
> > thinking about it.
> 
> Sure, but what advantages would it provide if the default blacklist does
> not block anything meaningful?  At the very least, spawn=deny should
> default elevateprivileges to deny too.

Yep, having spawn=deny imply elevateprivileges=deny is reasonable IMHO.

> I think there should be a list (as small as possible) of features that
> are sacrificed by "-sandbox on".

That breaks the key goal that '-sandbox on' should never break a valid
QEMU configuration, no matter how obscure, and would thus continue to
discourage people from turning it on by default.

Yes, a bare '-sandbox on' is very loose, but think of it as just being
a building block. 90% of the time the user or mgmt app would want to
turn on extra flags to lock it down more meaningfully, by explicitly
blocking ability to use feature they know won't be needed. 

> > The QEMU bridge helper  requires setuid privs, hence
> > elevated privileges needs to be permitted by default.
> 
> QEMU itself should not be getting additional privileges, only the helper
> and in turn the helper or ifup scripts can be limited through MAC.  The
> issue is that seccomp persists across execve.

That's true.

> Currently, unprivileged users are only allowed to install seccomp
> filters if no_new_privs is set.  Would it make sense if seccomp filters
> without no_new_privs succeeded, except that the filter would not persist
> across execve of binaries with setuid, setgid or file capabilities?
> 
> Then the spawn option could be a tri-state with the choice of allow,
> deny and no_new_privs:
> 
> - elevateprivileges=allow,spawn=allow: legacy for old kernels
> - elevateprivileges=deny,spawn=allow: can run privileged helpers
> - elevateprivileges=deny,spawn=deny: cannot run helpers at all
> - elevateprivileges=deny,spawn=no_new_privs: can run unprivileged
> helpers only

That could work, but I think that syntax is making it uneccessarily
complex to understand. I don't like how it introduces a semantic
dependancy between the elevateprivileges & spawn flags i.e. the
interpretation of elevateprivileges=deny, varies according to what
you set for spawn= option.

I'd be more inclined to make elevateprivileges be a tri-state instead
e.g.

  elevateprivileges=allow|deny|children

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
