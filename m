Received: from eggs.gnu.org ([2001:4830:134:3::10]:35135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fdWzv-0001JC-RL
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fdWzu-0002S8-Ex
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:30:47 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:43592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephane.duverger@gmail.com>)
	id 1fdWzu-0002Q5-5P
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 04:30:46 -0400
Received: by mail-oi0-x243.google.com with SMTP id b15-v6so54254655oib.10
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 01:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
	<878t6ke7qh.fsf@linaro.org>
	<CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
	<52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
	<CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
	<89df2b98-0c84-3bb5-1d8d-dceab6c3ad63@amsat.org>
In-Reply-To: <89df2b98-0c84-3bb5-1d8d-dceab6c3ad63@amsat.org>
From: stephane duverger <stephane.duverger@gmail.com>
Date: Thu, 12 Jul 2018 10:30:33 +0200
Message-ID: <CAGF1vyG32+ixEZmFUUiKQt4ztZ=M8-+Pz-b60Vcpbe=Jzm0Pmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

Hi Phil,

Well, at least we agree the gdb stub code is not straightforward.
>
> And apparently without seeing the bigger picture about how you are using
> this, I am missing something.


Sorry for that, i will try to explain it clearly.
This is something rather simple indeed:

1 - during MachineState init, install a BP1 at an "OS_ready" location
2 - handle BP1 hit (thanks to vm_state_change())
3 - delete BP1 and save the VM
4 - inject some generated code
5 - install BP2 at injected code end
6 - resume the VM
7 - handle BP2 hit and restore the VM
8 - go to 4

So as you may guess, I didn't need a full gdbstub with a gdbclient
to do that. I just wanted to install breakpoints and handle them
internally. To be fast, no overhead with the gdb protocol.

I didn't find something ready to use in Qemu API, but if there exists
something to do it, I would be glad to know. By the time, I decided to
make use of the GDB breakpoint type. It was a perfect candidate,
but unfortunately any time cpu_handle_guest_debug() is called,
gdb_set_stop_cpu() is systematically called too.

That was my issue. As gdbserver is not up and running,
gdbserver_state is NULL and Qemu segfaults.

Out of this gdb centric function call, the standard Qemu vm stop
notification process seems perfect to me:
- qemu_system_debug_request
- do_vm_stop
- vm_state_notify
- and then my "vm_state_change_handler" is called

So that's why I thought it would be great to be able
to install breakpoints with either
cpu_breakpoint_insert() or kvm_insert_breakpoint().

What could have been done to be pragmatic:
1 - implement a new breakpoint type for internal purpose ?
2 - implement a gdbserver_enabled state ?
3 - check for the gdbserver_state NULL pointer case and return ?

The point 3 was the most simple, tied to only one gdb function,
didn't touch anything else and actually "secured" that
gdb_set_stop_cpu() function.

This is indeed a personal subjective suggestion, not part of QEMU Coding
> standard. Rational is, if in the future someone needs to modify
> gdb_set_stop_cpu(), it would be easier/safer for him.
>

I do understand that point. So what do we do right now :
1 - ACK the patch as is ?
2 - do you want a new patch with:
    - a gdbserver_enabled state
    - a safe execution condition in gdb_set_stop_cpu()
    - an abort() in it if something is wrong

Regards,

stephane
