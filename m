Received: from eggs.gnu.org ([2001:4830:134:3::10]:46441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnlt0-0005De-1i
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnlsw-0002lg-UK
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:49:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnlsw-0002lO-LQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 08:49:06 -0400
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
	<20170314113209.12025-4-eduardo.otubo@profitbricks.com>
	<e9b2bd2a-8409-7470-76bb-32f15fe6ce0e@redhat.com>
	<20170314115253.GL2652@redhat.com>
	<d8825eda-6613-71c9-9dd7-9239325e296b@redhat.com>
	<20170314123254.GB21475@vader>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b27ec1df-6c32-0084-1991-283cb2b8f689@redhat.com>
Date: Tue, 14 Mar 2017 13:48:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170314123254.GB21475@vader>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, Andy Lutomirski <luto@amacapital.net>



On 14/03/2017 13:32, Eduardo Otubo wrote:
> On Tue, Mar 14, 2017 at 01=13=15PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 14/03/2017 12:52, Daniel P. Berrange wrote:
>>>>>  DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
>>>>> -    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
>>>>> -    "                              obsolete: Allow obsolete system calls",
>>>>> +    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
>>>>> +    "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
>>>>> +    "                               obsolete: Allow obsolete system calls\n" \
>>>>> +    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
>>>> Why allow these by default?
>>> The goal is that '-sandbox on' should not break *any* QEMU feature. It
>>> needs to be a safe thing that people can unconditionally turn on without
>>> thinking about it.
>>
>> Sure, but what advantages would it provide if the default blacklist does
>> not block anything meaningful?  At the very least, spawn=deny should
>> default elevateprivileges to deny too.
>>
>> I think there should be a list (as small as possible) of features that
>> are sacrificed by "-sandbox on".
> 
> Can you give an example of such a list?

Well, anything that makes "-sandbox on" more than security theater...  I
would consider it a necessary evil, not a good thing to have such a list.

Due to NO_NEW_PRIVS, I think non-migration fork/exec should be on the
list, but hopefully nothing else.

>>> The QEMU bridge helper  requires setuid privs, hence
>>> elevated privileges needs to be permitted by default.
>>
>> QEMU itself should not be getting additional privileges, only the helper
>> and in turn the helper or ifup scripts can be limited through MAC.  The
>> issue is that seccomp persists across execve.
>>
>> Currently, unprivileged users are only allowed to install seccomp
>> filters if no_new_privs is set.  Would it make sense if seccomp filters
>> without no_new_privs succeeded, except that the filter would not persist
>> across execve of binaries with setuid, setgid or file capabilities?
> 
> Yes, it does make sense. Using seccomp_attr_set() and the flag
> SCMP_FLTATR_CTL_NNP we can disable NO_NEW_PRIVS. 

That however in turn requires CAP_SYS_ADMIN.  Without kernel changes,
it's not possible.

Paolo

>>
>> Then the spawn option could be a tri-state with the choice of allow,
>> deny and no_new_privs:
>>
>> - elevateprivileges=allow,spawn=allow: legacy for old kernels
>> - elevateprivileges=deny,spawn=allow: can run privileged helpers
>> - elevateprivileges=deny,spawn=deny: cannot run helpers at all
>> - elevateprivileges=deny,spawn=no_new_privs: can run unprivileged
>> helpers only
> 
> I think it does look interesting to me this model.
> 
