Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEHm-0001vn-Pf
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEHj-0002SN-LK
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 07:48:14 -0500
Date: Thu, 1 Feb 2018 13:48:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201134803.78ef2b65.cohuck@redhat.com>
In-Reply-To: <de34c0e5-002e-f461-bc4d-498548424177@redhat.com>
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
	<de34c0e5-002e-f461-bc4d-498548424177@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de

On Thu, 1 Feb 2018 13:42:52 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 31.01.2018 19:17, Cornelia Huck wrote:

> > +#ifndef CONFIG_USER_ONLY
> > +void HELPER(clp)(CPUS390XState *env, uint32_t r2)
> > +{
> > +    S390CPU *cpu = s390_env_get_cpu(env);
> > +    int r;
> > +
> > +    qemu_mutex_lock_iothread();
> > +    r = clp_service_call(cpu, r2, GETPC());
> > +    qemu_mutex_unlock_iothread();
> > +    if (r) {
> > +        s390_program_interrupt(env, PGM_OPERATION, 4, GETPC());
> > +    }  
> 
> We don't need the if (r) ... so I suggest dropping all these. (as I
> said, will be handled later via the generic flag checking in translation
> code). We can ignore any error from these functions.

I did not check the instruction implementations in detail... was the
error really only for the !CONFIG_PCI case?

(I really should know that...)

> A sane guest will newer trigger this. (if we have no CONFIG_PCI, the
> also the ZPCI feature will not be available)

Hopefully we can also handle non-sane guests correctly...

> 
> Makes the code even shorter :)
> 
