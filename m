Received: from eggs.gnu.org ([2001:4830:134:3::10]:47576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etdjz-0006Zn-BC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etdjv-0004ye-5x
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:24:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etdjv-0004yA-0h
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 13:24:35 -0500
Date: Wed, 7 Mar 2018 18:24:10 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180307182409.GI3089@work-vm>
References: <20180307165038.88640-1-brijesh.singh@amd.com>
	<20180307165038.88640-22-brijesh.singh@amd.com>
	<20180307172703.GH3089@work-vm>
	<6b8bf293-4a3c-5832-8617-a2b957f97a83@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b8bf293-4a3c-5832-8617-a2b957f97a83@amd.com>
Subject: Re: [Qemu-devel] [PATCH v11 21/28] sev/i386: add debug encrypt and
 decrypt commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Richard Henderson <rth@twiddle.net>

* Brijesh Singh (brijesh.singh@amd.com) wrote:
> 
> 
> On 03/07/2018 11:27 AM, Dr. David Alan Gilbert wrote:
> 
> [...]
> 
> > > +{
> > > +    SEVState *s = (SEVState *)handle;
> > > +
> > > +    /* If policy does not allow debug then no need to register ops */
> > > +    if (s->policy & SEV_POLICY_NODBG) {
> > > +        return;
> > > +    }
> > 
> > So what happens if someone tries to use a gdb or monitor command when
> > policy didn't allow debug?  Does it end up with an obvious error
> > somehow?
> > 
> 
> In those cases caller will get encrypted bytes, leading to unintelligible
> data. It can sometime translate into  obvious errors e.g caller tries to
> walk guest pagtable and it gets garbage and will have trouble dumping the
> pgtables etc. Many times qemu calls ldphys_* functions to access the data it
> may get tricky to report the errors.

So would it make sense to have something like:

sev_mem_cant_read(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
{
    error_report("SEV Guest policy does not allow debug access");

    return -EPERM;
}

void
sev_set_debug_ops(void *handle, MemoryRegion *mr)
{
    SEVState *s = (SEVState *)handle;

    /* If policy does not allow debug then no need to register ops */
    if (s->policy & SEV_POLICY_NODBG) {
        sev_ops.read = sev_mem_cant_read;
        sev_ops.write = sev_mem_cant_write;
    } else {
        sev_ops.read = sev_mem_read;
        sev_ops.write = sev_mem_write;
    }

Dave

> 
> -Brijesh
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
