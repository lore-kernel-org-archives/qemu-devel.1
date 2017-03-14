Received: from eggs.gnu.org ([2001:4830:134:3::10]:36505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnlKO-00034f-7r
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnlKJ-0001x0-BW
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnlKJ-0001wr-5E
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:13:19 -0400
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
Date: Tue, 14 Mar 2017 13:13:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170314115253.GL2652@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Otubo <eduardo.otubo@profitbricks.com>, qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>



On 14/03/2017 12:52, Daniel P. Berrange wrote:
>>>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
>>> -    "-sandbox on[,obsolete=3Dallow]  Enable seccomp mode 2 system ca=
ll filter (default 'off').\n" \
>>> -    "                              obsolete: Allow obsolete system c=
alls",
>>> +    "-sandbox on[,obsolete=3Dallow][,elevateprivileges=3Ddeny]\n" \
>>> +    "                               Enable seccomp mode 2 system cal=
l filter (default 'off').\n" \
>>> +    "                               obsolete: Allow obsolete system =
calls\n" \
>>> +    "                               elevateprivileges: avoids Qemu p=
rocess to elevate its privileges by blacklisting all set*uid|gid system c=
alls",
>> Why allow these by default?
> The goal is that '-sandbox on' should not break *any* QEMU feature. It
> needs to be a safe thing that people can unconditionally turn on withou=
t
> thinking about it.

Sure, but what advantages would it provide if the default blacklist does
not block anything meaningful?  At the very least, spawn=3Ddeny should
default elevateprivileges to deny too.

I think there should be a list (as small as possible) of features that
are sacrificed by "-sandbox on".

> The QEMU bridge helper  requires setuid privs, hence
> elevated privileges needs to be permitted by default.

QEMU itself should not be getting additional privileges, only the helper
and in turn the helper or ifup scripts can be limited through MAC.  The
issue is that seccomp persists across execve.

Currently, unprivileged users are only allowed to install seccomp
filters if no_new_privs is set.  Would it make sense if seccomp filters
without no_new_privs succeeded, except that the filter would not persist
across execve of binaries with setuid, setgid or file capabilities?

Then the spawn option could be a tri-state with the choice of allow,
deny and no_new_privs:

- elevateprivileges=3Dallow,spawn=3Dallow: legacy for old kernels
- elevateprivileges=3Ddeny,spawn=3Dallow: can run privileged helpers
- elevateprivileges=3Ddeny,spawn=3Ddeny: cannot run helpers at all
- elevateprivileges=3Ddeny,spawn=3Dno_new_privs: can run unprivileged
helpers only

Paolo

> Similarly I could
> see the qemu ifup  scripts, or migrate 'exec' command wanting to elevat=
e
> privs via setuid binaries if QEMU was running unprivileged.
