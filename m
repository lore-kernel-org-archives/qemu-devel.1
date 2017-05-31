Received: from eggs.gnu.org ([2001:4830:134:3::10]:46438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG89z-0004os-I2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:15:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dG89u-0002hd-QU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:15:55 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dG89u-0002h0-Ip
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:15:50 -0400
Received: by mail-wm0-x235.google.com with SMTP id n195so1750791wmg.1
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 11:15:50 -0700 (PDT)
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
	<20170531183324.03bf98fe@bahia.lan>
	<20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
	<20170531190629.1cd2089d@bahia.lan>
	<20170531194046.6d6eed0f@p-imbrenda.boeblingen.de.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170531194046.6d6eed0f@p-imbrenda.boeblingen.de.ibm.com>
Date: Wed, 31 May 2017 19:16:05 +0100
Message-ID: <87r2z4sxi2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org


Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> writes:

> On Wed, 31 May 2017 19:06:29 +0200
> Greg Kurz <groug@kaod.org> wrote:
>
>> On Wed, 31 May 2017 18:51:06 +0200
>> Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
>> [...]
>> > > >
>> > > > This is strange. cpu_index() is defined as:
>> > > >
>> > > > static inline int cpu_index(CPUState *cpu)
>> > > > {
>> > > > #if defined(CONFIG_USER_ONLY)
>> > > >     return cpu->host_tid;
>> > > > #else
>> > > >     return cpu->cpu_index + 1;
>> > > > #endif
>> > > > }
>> > > >
>> > > > therefore it shouldn't return 0 under any circumstance,
>> > > > and
>> > >
>> > > I think it is 0 for first_cpu in user mode.
>> >
>> > in linux-user/syscall.c:
>> >
>> > info->tid = gettid();
>> > cpu->host_tid = info->tid;
>> >
>> > kernel thread-ids are system-wide unique and can't be 0
>> >
>>
>> This is correct but these lines are in clone_func(). This gets called
>> for all threads but the "main" thread which I believe to be
>> associated to first_cpu.
>
> then IMHO that is a bug and it needs to be corrected. the host_tid
> should be, well, the host tid, and not 0, which is never a valid
> tid for Linux.
>
> the current behaviour is simply the easiest for the "any CPU" case.
> Picking the last CPU or a random one would still be correct, and in
> that case there would be no way to explicitly address the first CPU.

OK I'll include a fix in the next iteration.

--
Alex Bennée
