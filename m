Received: from eggs.gnu.org ([2001:4830:134:3::10]:58911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczyJ-0007bt-Jj
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczyG-0002MV-De
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:14:55 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczyG-0002MN-8g
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 17:14:52 -0400
Received: by mail-qk0-x242.google.com with SMTP id y4-v6so12381016qka.5
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 14:14:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
	<878t6ke7qh.fsf@linaro.org>
	<CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
Date: Tue, 10 Jul 2018 18:14:47 -0300
MIME-Version: 1.0
In-Reply-To: <CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fix gdbserver_state pointer validation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stephane duverger <stephane.duverger@gmail.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org

On 07/10/2018 08:44 AM, stephane duverger wrote:
> Hi Alex,
> 
> There don't seem to be any other patches attached? I would NACK a patch
>> that isn't actually used in-tree.
> 
> 
> No there isn't ! I should have not been so prolix. Actually the patch
> corrects a
> possible null pointer dereference in the gdbserver code. That's all folks.
> 
> Below is how I discovered it and why it matters, imho, to be fixed
> (out of a pending issue).
> 
> This null deref does not happen in normal operation because of the way
> gdbserver is initialized. However what I was telling you, is that it may be
> really interesting to be able to take benefit of some gdb features
> internally
> without starting a gdbserver and the overhead of the gdb protocol when
> there is no need for a client/server interaction while debugging.

To reach gdb_set_stop_cpu() with gdbserver_state == NULL, you previously
entered gdb_vm_state_change() with and use CPUState *cpu =
gdbserver_state->c_cpu = NULL deref, which shouldn't happen.
Also in gdb_set_stop_cpu() you finally call cpu_single_step(cpu=crap)
which then deref crap->singlestep_enabled.

So I think this is not the correct fix.

Since this shouldn't happen, I'd add an assert(gdbserver_state) in
gdb_set_stop_cpu(), and clean gdb_vm_state_change()'s code flow to not
reach this.

> For instance, I developed a special purpose x86 board where I needed to
> break at some instructions, do some automation (snapshots, vm memory
> access, cpu analysis) and then resume the VM. Implementing a
> "vm_change_state handler" and dealing with RUN_STATE_DEBUG was
> perfect for my need.

I recommend you to use "configure --enable-sanitizers" to build your
special purpose board, that will show up those issues.

> The debug events (#BP, #DB) are tied to the gdbserver stub, at some point
> when "cpu_handle_guest_debug()" is called, a call to "gdb_set_stop_cpu()"
> triggers the NULL deref because the gdbserver is not initialized.
> 
> My little fix addresses this error and allows to make use of the following
> Qemu
> breakpoint functions without touching "cpus.c" or "exec.c":
> - cpu_breakpoint_remove/insert()
> - kvm_remove/insert_breakpoint()
> 
> Notice, that in the particular case of KVM, I had to async_run_on_cpu() my
> debug handler instead of directly executing it in the context of
> vm_change_state(). The vCPU started to significantly slow down
> (low irq rate), while this never happens with the TCG.
> 
> Is that more clear to you Alex ? (and hopefully lead to patch ACK :)
> 
> Regards,
> 
> stephane
> 
>> Signed-off-by: Stephane Duverger <stephane.duverger@gmail.com>
>>> ---
>>>  gdbstub.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index d6ab95006c..788fd625ab 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -1412,6 +1412,9 @@ static int gdb_handle_packet(GDBState *s, const
>> char *line_buf)
>>>
>>>  void gdb_set_stop_cpu(CPUState *cpu)
>>>  {
>>> +    if (!gdbserver_state) {
>>> +        return;
>>> +    }
>>>      gdbserver_state->c_cpu = cpu;
>>>      gdbserver_state->g_cpu = cpu;

I find it safer the opposite way, if (s) { s-> ... }

>>>  }

Regards,

Phil.
