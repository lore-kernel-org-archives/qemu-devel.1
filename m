Received: from eggs.gnu.org ([2001:4830:134:3::10]:44804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crLh9-0000o9-1H
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1crLh5-0008KR-Ts
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:39:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1crLh5-0008K5-KP
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 05:39:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2O9ce9c091214
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 05:39:36 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29cwbtskvg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 05:39:36 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Mar 2017 03:39:35 -0600
References: <1490347615-19222-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Mar 2017 10:39:29 +0100
MIME-Version: 1.0
In-Reply-To: <1490347615-19222-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Message-Id: <f3b0b14e-4ea1-6c4e-f9c6-cb86e78c6104@de.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

On 03/24/2017 10:26 AM, Thomas Huth wrote:
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

Older z/VM versions do not provide the enhanced suppression on protection
facility, which would result in guest failures as soon as the kernel
starts dirty pages tracking by write protecting the pages via the page
table. Some kernel release back (last time I checked) the PROT_EXEC was 
necessary to prevent the dirty pages tracking from taking place. So this
patch would break KVM in that case.

Newer z/VMs (e.g. 6.3) do provide ESOP. SO the question is,
why is KVM_CAP_S390_COW not set?


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
> 
