Received: from eggs.gnu.org ([2001:4830:134:3::10]:35474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejn4P-0002nF-KG
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejn4K-000557-RC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:21:01 -0500
References: <20180208095752.23960-1-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f889c2c4-aae1-a7c1-7024-db0ace96b36a@redhat.com>
Date: Thu, 8 Feb 2018 08:20:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180208095752.23960-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>

On 02/08/2018 03:57 AM, Christian Borntraeger wrote:
> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
> 

> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---

> +##
> +# @GuestPanicInformationS390:
> +#
> +# S390 specific guest panic information (PSW)
> +#
> +# @core: core id of the CPU that crashed
> +# @psw-mask: control fields of guest PSW
> +# @psw-addr: guest instruction address
> +# @reason: guest crash reason in human readable form
> +#
> +# Since: 2.12
> +##
> +{'struct': 'GuestPanicInformationS390',
> + 'data': { 'core': 'uint32',

Should core be optional,...


> +static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
> +{
> +    GuestPanicInformation *panic_info;
> +    S390CPU *cpu = S390_CPU(cs);
> +
> +    cpu_synchronize_state(cs);
> +    panic_info = g_malloc0(sizeof(GuestPanicInformation));
> +
> +    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
> +#if !defined(CONFIG_USER_ONLY)
> +    panic_info->u.s390.core = cpu->env.core_id;
> +#endif

...given that it is only conditionally assigned?  If so, you'd also need 
to set panic_info->u.s390.has_core when you have a core id to expose.


> +
> +static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
> +                                        const char *name, void *opaque,
> +                                        Error **errp)
> +{
> +    CPUState *cs = CPU(obj);
> +    GuestPanicInformation *panic_info;
> +
> +    if (!cs->crash_occurred) {
> +        error_setg(errp, "No crash occured");

s/occured/occurred/

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
