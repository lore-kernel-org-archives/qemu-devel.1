Received: from eggs.gnu.org ([2001:4830:134:3::10]:50588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcUz-0000MI-ST
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ddcTu-0007FY-SU
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1ddcTu-0007AO-Ez
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:17:34 -0400
References: <20170804112946.5247-1-cohuck@redhat.com>
	<20170804112946.5247-8-cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <234d7d0e-c5ae-44b8-76f5-d94f4f918ac4@redhat.com>
Date: Fri, 4 Aug 2017 15:17:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170804112946.5247-8-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 7/9] s390x/pci: fence off instructions
 for non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 04.08.2017 13:29, Cornelia Huck wrote:
> If a guest running on a machine without zpci issues a pci instruction,
> throw them an exception.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 54 +++++++++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index bc62bba5b7..9de165d8b1 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1191,7 +1191,11 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
>  {
>      uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
>  
> -    return clp_service_call(cpu, r2);
> +    if (s390_has_feat(S390_FEAT_ZPCI)) {
> +        return clp_service_call(cpu, r2);
> +    } else {
> +        return -1;
> +    }

I am a fan of dropping these else case and returning directly. But that
is just my opinion.

(applies to all changes in this patch)


-- 

Thanks,

David
