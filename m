Received: from eggs.gnu.org ([2001:4830:134:3::10]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWMfz-0004ur-Cz
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWMfw-0007HV-7N
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46310)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWMfv-0007HL-W9
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:27:44 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071713.4572.36636.stgit@PASHA-ISP>
	<96675d3f-9d53-bde1-f6da-7cb0b1f41316@redhat.com>
	<000501d276fb$fbcde7d0$f369b770$@ru>
	<1683a32c-4ea8-c343-e972-095593819121@redhat.com>
	<000601d276fe$e71b9140$b552b3c0$@ru>
	<10ac3f7d-6ae8-4657-7135-d9a05b5a3d39@redhat.com>
In-Reply-To: <10ac3f7d-6ae8-4657-7135-d9a05b5a3d39@redhat.com>
Date: Wed, 25 Jan 2017 15:27:45 +0300
Message-ID: <000901d27706$6f054090$4d0fc1b0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v7 03/14] replay: exception replay fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 25/01/2017 12:33, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 25/01/2017 12:12, Pavel Dovgalyuk wrote:
> >>>> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >>>> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> >>>>> @@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> >>>>>  #ifndef CONFIG_USER_ONLY
> >>>>>      } else if (replay_has_exception()
> >>>>>                 && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
> >>>>> +        /* Break the execution loop in case of running out of TB cache.
> >>>>> +           This is needed to make flushing of the TB cache, because
> >>>>> +           real flush is queued to be executed outside the cpu loop. */
> >>>>> +        cpu->exception_index = EXCP_INTERRUPT;
> >>>>>          /* try to cause an exception pending in the log */
> >>>>>          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
> >>>>>          *ret = -1;
> >>>>
> >>>> Why is replay_has_exception() related to be running out of TB cache?
> >>>
> >>> It doesn't.
> >>> Calling tb_find when there is not space in cache causes tb_flush and cpu_loop_exit.
> >>> But execution loop will continue, because there is no reason to break it
> >>> (like setting exception_index).
> >>
> >> What about setting cpu->exit_request?  queue_work_on_cpu calls
> >> qemu_cpu_kick.
> >
> > cpu->exit_request does not checked in this loop.
> > We have to add this checking somewhere then?
> 
> It's checked by cpu_handle_interrupt.  Are you not reaching
> cpu_handle_interrupt then?  Why?

Execution doesn't reach cpu_handle_interrupt, because tb_find 
calls cpu_loop_exit. And the execution loop enters cpu_handle_exception again and again.

Pavel Dovgalyuk
