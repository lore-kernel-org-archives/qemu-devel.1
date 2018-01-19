Received: from eggs.gnu.org ([2001:4830:134:3::10]:39284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecWbG-0000Uh-7R
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecWbC-000378-1z
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:20:54 -0500
Received: from mail.ispras.ru ([83.149.199.45]:58414)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecWbB-00036Y-PU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:20:49 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084417.7100.69568.stgit@pasha-VirtualBox>
	<aca12788-c119-3046-ee8f-e7b3d4cc59bb@redhat.com>
	<002a01d3911d$dc13ca80$943b5f80$@ru>
	<8aa1900f-2663-43bd-dab5-001be0aede09@redhat.com>
	<002b01d39120$8c88e880$a59ab980$@ru>
	<f7c459df-c68f-3995-4183-45da91e688a3@redhat.com>
	<002c01d39122$2de5d930$89b18b90$@ru>
In-Reply-To: <002c01d39122$2de5d930$89b18b90$@ru>
Date: Fri, 19 Jan 2018 16:20:52 +0300
Message-ID: <002d01d39128$54aa1b70$fdfe5250$@ru>
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
To: 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:dovgaluk@ispras.ru]
> Sent: Friday, January 19, 2018 3:37 PM
> To: 'Paolo Bonzini'; 'Pavel Dovgalyuk'; qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; peter.maydell@linaro.org; boost.lists@gmail.com; quintela@redhat.com;
> jasowang@redhat.com; mst@redhat.com; zuban32s@gmail.com; maria.klimushenkova@ispras.ru;
> kraxel@redhat.com; alex.bennee@linaro.org
> Subject: RE: [RFC PATCH v4 13/23] cpus: only take BQL for sleeping threads
> 
> > From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> > Sent: Friday, January 19, 2018 3:26 PM
> > To: Pavel Dovgalyuk; 'Pavel Dovgalyuk'; qemu-devel@nongnu.org
> > Cc: kwolf@redhat.com; peter.maydell@linaro.org; boost.lists@gmail.com; quintela@redhat.com;
> > jasowang@redhat.com; mst@redhat.com; zuban32s@gmail.com; maria.klimushenkova@ispras.ru;
> > kraxel@redhat.com; alex.bennee@linaro.org
> > Subject: Re: [RFC PATCH v4 13/23] cpus: only take BQL for sleeping threads
> >
> > On 19/01/2018 13:25, Pavel Dovgalyuk wrote:
> > >>> It means, that I'll have to fix all the has_work function to avoid races,
> > >>> because x86_cpu_has_work may have them?
> > >> Why only x86_cpu_has_work?
> > >>
> > >> Even reading cs->interrupt_request outside the mutex is unsafe.
> > > All the vcpu function that access interrupt controller or peripheral state may be unsafe?
> > > How can it work safely then?
> >
> > They do it inside the big QEMU lock.
> 
> Right. Without these patches.

Ah, I forgot about unlocking in tcg_cpu_exec.
Now I see, that vcpu is taking the lock when trying to access the peripherals.

Therefore, I have to fix all *_cpu_has_work, right?

> They are within the replay lock. And BQL is not covering vcpu execution with these patches.
> Therefore RR will be ok and regular execution may encounter races?
> It means that I missed something in Alex ideas, because he prepared the initial patches.
> 
> > But here you're calling cpu_has_work (via all_cpu_threads_idle) outside the lock.
> 
> Yes, I see, but what we have to do?


Pavel Dovgalyuk
