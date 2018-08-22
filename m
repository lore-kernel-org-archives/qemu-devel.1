Received: from eggs.gnu.org ([2001:4830:134:3::10]:48973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fsVUf-0005NB-Gi
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fsVUe-0002Rl-02
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:56:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fsVUd-0002Rb-Qk
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 11:56:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7MFq7S3074049
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 11:56:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m18dbqh47-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 11:56:22 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Aug 2018 16:56:16 +0100
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
	<153452570408.13804.6971118770752634964.stgit@gimli.home>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Aug 2018 17:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <153452570408.13804.6971118770752634964.stgit@gimli.home>
Content-Language: en-US
Message-Id: <482037fb-60d0-eb3b-a798-4ce5f478bd69@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 1/4] balloon: Allow multiple inhibit users
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

This breaks qemu-io test for me.

#0  0x000003ff98f3e2d4 in raise () at /lib64/libc.so.6
#1  0x000003ff98f239a8 in abort () at /lib64/libc.so.6
#2  0x000003ff98f3632e in __assert_fail_base () at /lib64/libc.so.6
#3  0x000003ff98f363ac in  () at /lib64/libc.so.6
#4  0x000000000108301a in qemu_balloon_inhibit (state=state@entry=false) at /home/cborntra/REPOS/qemu/balloon.c:56
#5  0x00000000012026f2 in postcopy_ram_incoming_cleanup (mis=mis@entry=0x163bc5c0) at /home/cborntra/REPOS/qemu/migration/postcopy-ram.c:542
#6  0x00000000011eed5e in process_incoming_migration_co (opaque=<optimized out>) at /home/cborntra/REPOS/qemu/migration/migration.c:407
#7  0x0000000001374000 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at /home/cborntra/REPOS/qemu/util/coroutine-ucontext.c:116
#8  0x000003ff98f53c02 in __makecontext_ret () at /lib64/libc.so.6

Cant see right now whats wrong.

On 08/17/2018 07:08 PM, Alex Williamson wrote:
> A simple true/false internal state does not allow multiple users.  Fix
> this within the existing interface by converting to a counter, so long
> as the counter is elevated, ballooning is inhibited.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  balloon.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/balloon.c b/balloon.c
> index 6bf0a9681377..931987983858 100644
> --- a/balloon.c
> +++ b/balloon.c
> @@ -26,6 +26,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
> +#include "qemu/atomic.h"
>  #include "exec/cpu-common.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/balloon.h"
> @@ -37,16 +38,22 @@
>  static QEMUBalloonEvent *balloon_event_fn;
>  static QEMUBalloonStatus *balloon_stat_fn;
>  static void *balloon_opaque;
> -static bool balloon_inhibited;
> +static int balloon_inhibit_count;
>  
>  bool qemu_balloon_is_inhibited(void)
>  {
> -    return balloon_inhibited;
> +    return atomic_read(&balloon_inhibit_count) > 0;
>  }
>  
>  void qemu_balloon_inhibit(bool state)
>  {
> -    balloon_inhibited = state;
> +    if (state) {
> +        atomic_inc(&balloon_inhibit_count);
> +    } else {
> +        atomic_dec(&balloon_inhibit_count);
> +    }
> +
> +    assert(atomic_read(&balloon_inhibit_count) >= 0);
>  }
>  
>  static bool have_balloon(Error **errp)
> 
> 
