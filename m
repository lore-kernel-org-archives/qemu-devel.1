Received: from eggs.gnu.org ([2001:4830:134:3::10]:47894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fd9vO-0004IA-4Q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephane.duverger@gmail.com>) id 1fd9vN-00078c-9B
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:52:34 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephane.duverger@gmail.com>)
	id 1fd9vN-000782-0w
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 03:52:33 -0400
Received: by mail-oi0-x22b.google.com with SMTP id k81-v6so47584044oib.4
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 00:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180709125452.7utyomtsxr6xaxdi@vm.localdomain>
	<878t6ke7qh.fsf@linaro.org>
	<CAGF1vyGaPwZ9nBFJYJjJQPG8g8Ahdf1Y8USGnRr=-6DibJxxHg@mail.gmail.com>
	<52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
In-Reply-To: <52a7f5d4-7264-9411-98a4-9f59e813e9d3@amsat.org>
From: stephane duverger <stephane.duverger@gmail.com>
Date: Wed, 11 Jul 2018 09:52:20 +0200
Message-ID: <CAGF1vyEEez4v+N2VZVULsiaR7_cdn-u0Z1RZ3Y+P-9q2NBV4aw@mail.gmail.com>
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

To reach gdb_set_stop_cpu() with gdbserver_state == NULL, you previously
> entered gdb_vm_state_change() with and use CPUState *cpu =
> gdbserver_state->c_cpu = NULL deref, which shouldn't happen.
> Also in gdb_set_stop_cpu() you finally call cpu_single_step(cpu=crap)
> which then deref crap->singlestep_enabled.
>
> So I think this is not the correct fix.
>

I think you are wrong. You can enter gdb_vm_state_change() only if it has
been registered through qemu_add_vm_change_state_handler(). And this
happens in gdbserver_start() which is called only when you start the
gdbserver stub.

This is exactly what we don't want to do here: use qemu breakpoints and
debug events forwarding without the need to enable a gdb stub.

There might be an historical reason that vCPU debug events are always
forwarded to the gdbserver (from cpu_handle_guest_debug()) but this
should not be mandatory.

One could consider a check to the gdbserver state right before:

if (gdbserver_enabled())
    gdb_set_stop_cpu(cpu);

As found in other part of qemu code: kvm_enabled, hax_enabled, ...


> Since this shouldn't happen, I'd add an assert(gdbserver_state) in
> gdb_set_stop_cpu(), and clean gdb_vm_state_change()'s code flow to not
> reach this.
>

Correct if you previously add the gdbserver_enabled() check. Else this
would abort the qemu instance each time a debug event is triggered
and forwarded to a vm_change_state handler.

>>>  void gdb_set_stop_cpu(CPUState *cpu)
> >>>  {
> >>> +    if (!gdbserver_state) {
> >>> +        return;
> >>> +    }
> >>>      gdbserver_state->c_cpu = cpu;
> >>>      gdbserver_state->g_cpu = cpu;
>
> I find it safer the opposite way, if (s) { s-> ... }
>

Sincerely, this argument is subjective. If it's part of Qemu coding
standard,
i would agree. Again there is a lot of situations in the Qemu code where
exit conditions are checked first and then lead to a return, preventing an
unneeded level of indentation. Seriously, we are talking about a 2 lines
function.

stephane
