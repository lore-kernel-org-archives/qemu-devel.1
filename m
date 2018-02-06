Received: from eggs.gnu.org ([2001:4830:134:3::10]:38696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5EO-0000MO-Hi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ej5EJ-0002Nw-Mu
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:32:24 -0500
References: <20180206074622.157812-1-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4181f0ff-5a2d-bdaa-9e40-ae3cb6f4417c@redhat.com>
Date: Tue, 6 Feb 2018 09:31:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180206074622.157812-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 1/1] s390x/cpu: expose the guest crash
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>

On 02/06/2018 01:46 AM, Christian Borntraeger wrote:
> This patch is the s390 implementation of guest crash information,
> similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
> property") and the related commits. We will detect several crash
> reasons, with the "disabled wait" being the most important one, since
> this is used by all s390 guests as a "panic like" notification.
> 

> 
> Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   qapi/run-state.json   | 27 ++++++++++++++++++++++--
>   target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   target/s390x/cpu.h    | 11 ++++++++++
>   target/s390x/helper.c |  5 ++++-
>   target/s390x/kvm.c    | 15 +++++++-------
>   vl.c                  |  6 ++++++
>   6 files changed, 110 insertions(+), 11 deletions(-)
> 

> 
>  ##
>  # @GuestPanicInformation:
>  #
>  # Information about a guest panic
>  #
> +# @type: Crash type that defines the hypervisor specific information
> +#
>  # Since: 2.9
>  ##
>  {'union': 'GuestPanicInformation',
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
> - 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
> +           's390': 'GuestPanicInformationS390' } }
>  

The qapi type has only integers (that the caller will presumably know 
how to decode if it cares) and a human readable string.  Meanwhile,...

> 
> +/* Crash cases. */
> +enum crash_reasons {

Doesn't seem to match our usual coding conventions of CamelCase for 
names in the enum/struct/union namespace.

> +    CRASH_REASON_UNKNOWN,  /* default value of 0 on reset */
> +    CRASH_REASON_PGM,
> +    CRASH_REASON_EXT,
> +    CRASH_REASON_WAITPSW,
> +    CRASH_REASON_OPEREXC,

...you have an internal enum for decoding some of those integer values 
into specific human readable strings, but don't expose the enum over 
QAPI.  Are we sure that's the interface we want to go with?  As long as 
you are okay with that, then I can live with the interface change; I 
just want to make sure that you are certain that the machine-based 
consumer of the QMP command does not need to decode crash_reasons 
because you left it as an internal enum.

> +
> +static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
> +                                         const char *name, void *opaque,
> +                                         Error **errp)

Indentation is off.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
