Received: from eggs.gnu.org ([2001:4830:134:3::10]:38528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elIf2-0006lQ-7u
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elIey-00053h-6C
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 13:17:04 -0500
Date: Mon, 12 Feb 2018 19:16:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212191655.27662101.cohuck@redhat.com>
In-Reply-To: <85636569-9a27-738f-0b86-86b6eef57805@redhat.com>
References: <20180209122543.25755-1-borntraeger@de.ibm.com>
	<85636569-9a27-738f-0b86-86b6eef57805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On Mon, 12 Feb 2018 11:51:37 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/09/2018 06:25 AM, Christian Borntraeger wrote:
> > This patch is the s390 implementation of guest crash information,
> > similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> > property") and the related commits. We will detect several crash
> > reasons, with the "disabled wait" being the most important one, since
> > this is used by all s390 guests as a "panic like" notification.
> >   
> ...
> > 
> > Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > ---  
> 
> > +##
> > +# @GuestPanicInformationS390:
> > +#
> > +# S390 specific guest panic information (PSW)
> > +#
> > +# @core: core id of the CPU that crashed
> > +# @psw-mask: control fields of guest PSW
> > +# @psw-addr: guest instruction address
> > +# @reason: guest crash reason in human readable form  
> 
> This description is stale, now that it is an enum (and thus also 
> machine-readable).  I'd shorten it to just
> 
> # @reason: guest crash reason

Agreed, folded in.

> 
> > +#
> > +# Since: 2.12
> > +##
> > +{'struct': 'GuestPanicInformationS390',
> > + 'data': { 'core': 'uint32',
> > +           'psw-mask': 'uint64',
> > +           'psw-addr': 'uint64',
> > +           'reason': 'S390CrashReason' } }  
> 
> > +static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
> > +{
> > +    GuestPanicInformation *panic_info;
> > +    S390CPU *cpu = S390_CPU(cs);
> > +
> > +    cpu_synchronize_state(cs);
> > +    panic_info = g_malloc0(sizeof(GuestPanicInformation));
> > +
> > +    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
> > +#if !defined(CONFIG_USER_ONLY)
> > +    panic_info->u.s390.core = cpu->env.core_id;
> > +#else
> > +    panic_info->u.s390.core = 0; /* sane default for non system emulation */  
> 
> Redundant assignment thanks to the g_malloc0() above, but the comment 
> makes it explicit why you did that, so I can live with it.

I actually prefer it this way, as it preempts questions about user-only
handling.

> 
> With the qapi comment tweak,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
