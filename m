Received: from eggs.gnu.org ([2001:4830:134:3::10]:42684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnldO-0003LG-31
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnldK-0001t7-75
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:33:02 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnldJ-0001sD-TP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:32:58 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t189so62649145wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:32:57 -0700 (PDT)
Date: Tue, 14 Mar 2017 13:32:54 +0100
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Message-ID: <20170314123254.GB21475@vader>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
	<d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>

On Tue, Mar 14, 2017 at 01=13=15PM +0100, Paolo Bonzini wrote:
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
> 
> I think there should be a list (as small as possible) of features that
> are sacrificed by "-sandbox on".

Can you give an example of such a list?

> 
> > The QEMU bridge helper  requires setuid privs, hence
> > elevated privileges needs to be permitted by default.
> 
> QEMU itself should not be getting additional privileges, only the helper
> and in turn the helper or ifup scripts can be limited through MAC.  The
> issue is that seccomp persists across execve.
> 
> Currently, unprivileged users are only allowed to install seccomp
> filters if no_new_privs is set.  Would it make sense if seccomp filters
> without no_new_privs succeeded, except that the filter would not persist
> across execve of binaries with setuid, setgid or file capabilities?

Yes, it does make sense. Using seccomp_attr_set() and the flag
SCMP_FLTATR_CTL_NNP we can disable NO_NEW_PRIVS. 

> 
> Then the spawn option could be a tri-state with the choice of allow,
> deny and no_new_privs:
> 
> - elevateprivileges=allow,spawn=allow: legacy for old kernels
> - elevateprivileges=deny,spawn=allow: can run privileged helpers
> - elevateprivileges=deny,spawn=deny: cannot run helpers at all
> - elevateprivileges=deny,spawn=no_new_privs: can run unprivileged
> helpers only

I think it does look interesting to me this model.

-- 
Eduardo Otubo
ProfitBricks GmbH
