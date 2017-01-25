Received: from eggs.gnu.org ([2001:4830:134:3::10]:53751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWLVc-0003gM-Et
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:13:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWLVY-0007iV-Fz
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:13:00 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38256)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cWLVY-0007i0-8u
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:56 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170124071654.4572.41407.stgit@PASHA-ISP>
	<20170124071713.4572.36636.stgit@PASHA-ISP>
	<96675d3f-9d53-bde1-f6da-7cb0b1f41316@redhat.com>
In-Reply-To: <96675d3f-9d53-bde1-f6da-7cb0b1f41316@redhat.com>
Date: Wed, 25 Jan 2017 14:12:57 +0300
Message-ID: <000501d276fb$fbcde7d0$f369b770$@ru>
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
> On 24/01/2017 08:17, Pavel Dovgalyuk wrote:
> > @@ -451,6 +451,10 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
> >  #ifndef CONFIG_USER_ONLY
> >      } else if (replay_has_exception()
> >                 && cpu->icount_decr.u16.low + cpu->icount_extra == 0) {
> > +        /* Break the execution loop in case of running out of TB cache.
> > +           This is needed to make flushing of the TB cache, because
> > +           real flush is queued to be executed outside the cpu loop. */
> > +        cpu->exception_index = EXCP_INTERRUPT;
> >          /* try to cause an exception pending in the log */
> >          cpu_exec_nocache(cpu, 1, tb_find(cpu, NULL, 0), true);
> >          *ret = -1;
> 
> Why is replay_has_exception() related to be running out of TB cache?

It doesn't.
Calling tb_find when there is not space in cache causes tb_flush and cpu_loop_exit.
But execution loop will continue, because there is no reason to break it
(like setting exception_index).

Pavel Dovgalyuk
