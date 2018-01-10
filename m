Received: from eggs.gnu.org ([2001:4830:134:3::10]:57607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZKbU-0007ZZ-9K
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZKbQ-0004PF-A6
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:55:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZKbQ-0004Or-38
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 12:55:52 -0500
Date: Wed, 10 Jan 2018 17:55:45 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180110175544.GD2451@work-vm>
References: <20180110134846.12940.99993.stgit@pasha-VirtualBox>
	<029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029858e0-c6e5-939d-d79e-c7ad7e5069a1@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] cpu: flush TB cache when loading VMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, quintela@redhat.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com

* Richard Henderson (richard.henderson@linaro.org) wrote:
> On 01/10/2018 05:48 AM, Pavel Dovgalyuk wrote:
> > Flushing TB cache is required because TBs key in the cache may match
> > different code which existed in the previous state.
> > 
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> > ---
> >  exec.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/exec.c b/exec.c
> > index 4722e52..ff31e71 100644
> > --- a/exec.c
> > +++ b/exec.c
> > @@ -622,6 +622,7 @@ static int cpu_common_post_load(void *opaque, int version_id)
> >         version_id is increased. */
> >      cpu->interrupt_request &= ~0x01;
> >      tlb_flush(cpu);
> > +    tb_flush(cpu);
> 
> I'm not necessarily objecting, but what do you mean by "may match different code"?
> 
> What this patch suggests is that the inputs to the computation of TB->FLAGS are
> different for some unspecified reason.  Without further explanation, to me this
> suggests a bug in vmstate save/restore.
> 
> What is the observed problem here?

Is this a case where you're repeatedly running 'loadvm' to revert to a
previous snapshot (or I guess the debug stuff); so you've been running
and translating code and then reload state ?

Dave

> 
> r~
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
