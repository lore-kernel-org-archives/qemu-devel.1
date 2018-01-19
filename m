Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVDp-0007fZ-Uh
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:52:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVDl-0001db-Vp
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:52:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:46670)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ecVDl-0001dO-Ny
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 06:52:33 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
	<20180119084409.7100.23132.stgit@pasha-VirtualBox>
	<6abaddaf-96ee-d03c-0483-716f5317ed38@redhat.com>
In-Reply-To: <6abaddaf-96ee-d03c-0483-716f5317ed38@redhat.com>
Date: Fri, 19 Jan 2018 14:52:37 +0300
Message-ID: <002901d3911c$0062e7b0$0128b710$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v4 12/23] cpus: push BQL lock to
 qemu_*_wait_io_event
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

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 19/01/2018 09:44, Pavel Dovgalyuk wrote:
> >  static void qemu_wait_io_event(CPUState *cpu)
> >  {
> > +    qemu_mutex_lock_iothread();
> > +
> >      while (cpu_thread_is_idle(cpu)) {
> >          qemu_cond_wait(cpu->halt_cond, &qemu_global_mutex);
> >      }
> 
> This function locks the iothread and never unlocks it.  Please test your
> patches better.

Yes, there was kind of mess. Lock was inside the function and unlock outside,
that's why it worked for me.

Pavel Dovgalyuk
