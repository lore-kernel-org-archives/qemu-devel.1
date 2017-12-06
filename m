Received: from eggs.gnu.org ([2001:4830:134:3::10]:38099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eMVvG-0000rD-9I
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:23:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1eMVvD-00038I-3a
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:23:22 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1eMVvC-00037L-U7
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:23:19 -0500
Received: by mail-ua0-f193.google.com with SMTP id l2so2356825uak.2
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 01:23:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a4c7740fd7e8cb93d86ea525e6e84999@ispras.ru>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127343314.6888.13289325558071964830.stgit@Misha-PC.lan02.inno>
	<CABdb734UbAZTT47XeGCKzrP=Qb5ko9ioWU1kyzZ6UUMTko9RBA@mail.gmail.com>
	<a4c7740fd7e8cb93d86ea525e6e84999@ispras.ru>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 6 Dec 2017 10:23:16 +0100
Message-ID: <CABdb735La9XqoQBgnf+OE-cZqOxv5teTnd6ce7O1nk_U9X4V3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 35/45] windbg: debug exception
 subscribing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Wed, Dec 6, 2017 at 8:29 AM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-29 10:13:
>
>> On Tue, Nov 21, 2017 at 3:10 PM, Mihail Abakumov
>> <mikhail.abakumov@ispras.ru> wrote:
>>>
>>> Added handler registration of gdb debug exception. Its exception also c=
an
>>> be used for windbg.
>>>
>>> Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
>>> Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
>>> Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
>>> ---
>>>  cpus.c                  |   18 +++++++++++++++++-
>>>  gdbstub.c               |    4 ++++
>>>  include/sysemu/sysemu.h |    2 ++
>>>  windbgstub.c            |   16 ++++++++++++----
>>>  4 files changed, 35 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 9bed61eefc..212553b7e3 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -77,6 +77,8 @@ int64_t max_advance;
>>>  static QEMUTimer *throttle_timer;
>>>  static unsigned int throttle_percentage;
>>>
>>> +static void (*excp_debug_handler)(CPUState *cpu);
>>> +
>>>  #define CPU_THROTTLE_PCT_MIN 1
>>>  #define CPU_THROTTLE_PCT_MAX 99
>>>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>>> @@ -960,9 +962,23 @@ static bool cpu_can_run(CPUState *cpu)
>>>      return true;
>>>  }
>>>
>>> +bool register_excp_debug_handler(void (*handler)(CPUState *cpu))
>>> +{
>>> +    if (excp_debug_handler =3D=3D NULL) {
>>> +        excp_debug_handler =3D handler;
>>> +        return true;
>>> +    } else {
>>> +        error_report("ERROR: Something debugger already using");
>>
>>
>> So I take it that -windbg and -gdb cannot be used at the same time.
>> Should it be handled in a more explicit way with a more user-friendly
>> error?
>>
>> Right now I get this error, which is more like an implementation
>> detail (could the debug handler be refactored into a multicast event
>> in the future?) and does not even make sense as a sentence.
>
>
> Yes. I have added a more user-friendly error. "Something debugger is
> already in use. '-gdb' and '-windbg' cannot be used at the same time".
> Or what do you mean under the explicit way? How to do it better?

Yes, "'-gdb' and '-windbg' cannot be used at the same time" would be
nicer. By being more explicit I mean issuing the error from the code
that parses the options.

In other words, I can imagine an implementation of
register_excp_debug_handler() that allows registering multiple
handlers. But running windbg and gdb at the same would probably still
not be a good idea.

Maybe I'm nit-picking and it's ok for the error to stay here.
Wondering what other reviewers think.

>>
>>> +        return false;
>>> +    }
>>> +}
>>> +
>>>  static void cpu_handle_guest_debug(CPUState *cpu)
>>>  {
>>> -    gdb_set_stop_cpu(cpu);
>>> +    if (excp_debug_handler !=3D NULL) {
>>> +        excp_debug_handler(cpu);
>>> +    }
>>> +
>>>      qemu_system_debug_request();
>>>      cpu->stopped =3D true;
>>>  }
>>> diff --git a/gdbstub.c b/gdbstub.c
>>> index 2a94030d3b..8c76f54117 100644
>>> --- a/gdbstub.c
>>> +++ b/gdbstub.c
>>> @@ -2006,6 +2006,10 @@ int gdbserver_start(const char *device)
>>>      s->mon_chr =3D mon_chr;
>>>      s->current_syscall_cb =3D NULL;
>>>
>>> +    if (!register_excp_debug_handler(gdb_set_stop_cpu)) {
>>> +        exit(1);
>>> +    }
>>> +
>>>      return 0;
>>>  }
>>>
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index b21369672a..34588c99b4 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -193,6 +193,8 @@ QemuOpts *qemu_get_machine_opts(void);
>>>
>>>  bool defaults_enabled(void);
>>>
>>> +bool register_excp_debug_handler(void (*handler)(CPUState *cpu));
>>> +
>>>  extern QemuOptsList qemu_legacy_drive_opts;
>>>  extern QemuOptsList qemu_common_drive_opts;
>>>  extern QemuOptsList qemu_drive_opts;
>>> diff --git a/windbgstub.c b/windbgstub.c
>>> index 489abe6d6c..b33f412659 100755
>>> --- a/windbgstub.c
>>> +++ b/windbgstub.c
>>> @@ -115,16 +115,20 @@ static void windbg_send_control_packet(uint16_t
>>> type)
>>>      windbg_state->ctrl_packet_id ^=3D 1;
>>>  }
>>>
>>> -static void windbg_vm_stop(void)
>>> +static void windbg_bp_handler(CPUState *cpu)
>>>  {
>>> -    CPUState *cpu =3D qemu_get_cpu(0);
>>> -    vm_stop(RUN_STATE_PAUSED);
>>> -
>>>      SizedBuf buf =3D kd_gen_exception_sc(cpu);
>>>      windbg_send_data_packet(buf.data, buf.size,
>>> PACKET_TYPE_KD_STATE_CHANGE64);
>>>      SBUF_FREE(buf);
>>>  }
>>>
>>> +static void windbg_vm_stop(void)
>>> +{
>>> +    CPUState *cpu =3D qemu_get_cpu(0);
>>> +    vm_stop(RUN_STATE_PAUSED);
>>> +    windbg_bp_handler(cpu);
>>> +}
>>> +
>>>  static void windbg_process_manipulate_packet(ParsingContext *ctx)
>>>  {
>>>      CPUState *cpu;
>>> @@ -432,6 +436,10 @@ int windbg_server_start(const char *device)
>>>
>>>      qemu_register_reset(windbg_handle_reset, NULL);
>>>
>>> +    if (!register_excp_debug_handler(windbg_bp_handler)) {
>>> +        exit(1);
>>> +    }
>>> +
>>>      atexit(windbg_exit);
>>>      return 0;
>>>  }
>>>
>
