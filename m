Received: from eggs.gnu.org ([2001:4830:134:3::10]:41550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1en2X7-0002BT-DH
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1en2X4-00043x-9P
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:28:05 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1en2X4-00043P-1Q
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 08:28:02 -0500
Received: by mail-wm0-x244.google.com with SMTP id t3so7665717wmc.2
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 05:28:01 -0800 (PST)
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
	<1487255507-106654-10-git-send-email-pbonzini@redhat.com>
	<3f632c5b-56b8-340c-02bd-f66abccd9473@web.de>
	<acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <acaf7f74-5a87-2bd5-a7f9-e40add3a7077@web.de>
Date: Sat, 17 Feb 2018 13:27:59 +0000
Message-ID: <87k1vb7nkw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 09/23] gdbstub: Fix vCont behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>


Jan Kiszka <jan.kiszka@web.de> writes:

> On 2018-02-17 09:56, Jan Kiszka wrote:
>> On 2017-02-16 15:31, Paolo Bonzini wrote:
>>> From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>>
>>> When GDB issues a "vCont", QEMU was not handling it correctly when
>>> multiple VCPUs are active.
>>> For vCont, for each thread (VCPU), it can be specified whether to
>>> single step, continue or stop that thread. The default is to stop a
>>> thread.
>>> However, when (for example) "vCont;s:2" is issued, all VCPUs continue
>>> to run, although all but VCPU nr 2 are to be stopped.
>>>
>>> This patch completely rewrites the vCont parsing code.
>>>
>>> Please note that this improvement only works in system emulation mode,
>>> when in userspace emulation mode the old behaviour is preserved.
>>>
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>> Message-Id: <1487092068-16562-3-git-send-email-imbrenda@linux.vnet.ibm.=
com>
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>> ---
>>>  gdbstub.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++------=
--------
>>>  1 file changed, 162 insertions(+), 47 deletions(-)
>>>
<snip>
>>
>> Seems like no one is doing guest debugging with kvm on x86 except me,
>> and I'm only doing it too infrequently now: This one broke that use case
>> for SMP guests long ago. How was it tested?
>>
>> To reproduce the bug: set up an x86-64 guest kernel with > 1 core, break
>> on some prominent syscall entry (e.g. sys_execve), continue the guest on
>> hit and it will quickly lock up, even after disabling the breakpoint
>> again. Kernel version doesn't matter (was my first guess), gdb is
>> 7.7.50.20140604-cvs (OpenSUSE) here.

I thought I fixed this with 5a6a1ad181c658b810041d852b290ac836965aca

FWIW I do periodically test ARM TCG and KVM guest debug using:

  tests/guest-debug/test-gdbstub.py

But we are missing a nice integration to get an appropriate guest image
to automate this process. If we can fix that we should be able to turn
on the test as part of make check.


--
Alex Benn=C3=A9e
