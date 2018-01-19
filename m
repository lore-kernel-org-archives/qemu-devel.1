Received: from eggs.gnu.org ([2001:4830:134:3::10]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVjL-0004Pa-Se
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:25:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVjH-0004ft-3M
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:25:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51350)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVjG-0004eb-R1
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:25:07 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084417.7100.69568.stgit@pasha-VirtualBox>
	<aca12788-c119-3046-ee8f-e7b3d4cc59bb@redhat.com>
	<002a01d3911d$dc13ca80$943b5f80$@ru>
	<8aa1900f-2663-43bd-dab5-001be0aede09@redhat.com>
In-Reply-To: <8aa1900f-2663-43bd-dab5-001be0aede09@redhat.com>
Date: Fri, 19 Jan 2018 15:25:10 +0300
Message-ID: <002b01d39120$8c88e880$a59ab980$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v4 13/23] cpus: only take BQL for
 sleeping threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> Sent: Friday, January 19, 2018 3:20 PM
> To: Pavel Dovgalyuk; 'Pavel Dovgalyuk'; qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; peter.maydell@linaro.org; boost.lists@gmail.com; quintela@redhat.com;
> jasowang@redhat.com; mst@redhat.com; zuban32s@gmail.com; maria.klimushenkova@ispras.ru;
> kraxel@redhat.com; alex.bennee@linaro.org
> Subject: Re: [RFC PATCH v4 13/23] cpus: only take BQL for sleeping threads
> 
> On 19/01/2018 13:05, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 19/01/2018 09:44, Pavel Dovgalyuk wrote:
> >>>      while (all_cpu_threads_idle()) {
> >>> +        qemu_mutex_lock_iothread();
> >>>          stop_tcg_kick_timer();
> >>>          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> >>> +        qemu_mutex_unlock_iothread();
> >>>      }
> >>
> >> cpu_has_work cannot be called outside BQL yet.  You first need to access
> >> cpu->interrupt_request with atomics.
> >>
> >> In general, testing the condition outside the mutex is a very dangerous
> >> pattern (and I'm usually the one who enjoys dangerous patterns).
> >
> > It means, that I'll have to fix all the has_work function to avoid races,
> > because x86_cpu_has_work may have them?
> 
> Why only x86_cpu_has_work?
> 
> Even reading cs->interrupt_request outside the mutex is unsafe.

All the vcpu function that access interrupt controller or peripheral state may be unsafe?
How can it work safely then?

Pavel Dovgalyuk
