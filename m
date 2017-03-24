Received: from eggs.gnu.org ([2001:4830:134:3::10]:44594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1crLgF-0000Fw-Ox
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1crLgC-0008Br-Le
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52370
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1crLgC-0008Bn-GA
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:38:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2O9ceAT112483
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 05:38:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29cg2rep11-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 05:38:43 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 24 Mar 2017 09:38:41 -0000
Date: Fri, 24 Mar 2017 10:38:37 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1490347615-19222-1-git-send-email-thuth@redhat.com>
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170324103837.60533aaf.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x/kvm: Fix problem when running
 with SELinux under z/VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 24 Mar 2017 10:26:55 +0100
Thomas Huth <thuth@redhat.com> wrote:

> When running QEMU with KVM under z/VM, the memory for the guest
> is allocated via legacy_s390_alloc() since the KVM_CAP_S390_COW
> extension is not supported on z/VM. legacy_s390_alloc() then uses
> mmap(... PROT_EXEC ...) for the guest memory - but this does not
> work when running with SELinux enabled, mmap() fails and QEMU aborts
> with the following error message:
> 
>  cannot set up guest memory 's390.ram': Permission denied
> 
> Looking at the other allocator function qemu_anon_ram_alloc(), it
> seems like PROT_EXEC is normally not needed for allocating the
> guest RAM, and indeed, the guest also starts successfully under
> z/VM when we remove the PROT_EXEC from the legacy_s390_alloc()
> function. So let's get rid of that flag here to be able to run
> with SELinux under z/VM, too.

The root cause of this is lack of ESOP in the host.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/kvm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ac47154..5167436 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -678,8 +678,7 @@ static void *legacy_s390_alloc(size_t size, uint64_t *align)
>  {
>      void *mem;
> 
> -    mem = mmap((void *) 0x800000000ULL, size,
> -               PROT_EXEC|PROT_READ|PROT_WRITE,
> +    mem = mmap((void *) 0x800000000ULL, size, PROT_READ | PROT_WRITE,
>                 MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>      return mem == MAP_FAILED ? NULL : mem;
>  }

Wouldn't it be better to adapt the SELinux rules?
