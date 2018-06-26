Received: from eggs.gnu.org ([2001:4830:134:3::10]:50608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXnPW-0008Sy-Vc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fXnPT-00037B-3P
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:49:31 -0400
References: <20180626123830.18282-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5411ab83-7866-f834-79ff-b3ad5b29c536@redhat.com>
Date: Tue, 26 Jun 2018 14:49:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180626123830.18282-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/cpumodel: default enable bpb and
 ppa15 for z196 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

s/s390/s390x

I can't think of a scenario where this would be harmful. Migration with
compat machines will still work correctly. -cpu qemu is not affected, so
TCG will also continue to work just fine.

Reviewed-by: David Hildenbrand <david@redhat.com>

On 26.06.2018 14:38, Christian Borntraeger wrote:
> Most systems and host kernels provide the necessary building blocks for
> bpb and ppa15. We can reverse the logic and default enable those
> features, while still allowing to disable it via cpu model.
> 
> So let us add bpb and ppa15 to z196 and later default CPU model for the
> qemu 3.0 machine. (like -cpu z13).  Older machine types (e.g.
> s390-ccw-virtio-2.12) will retain the old value and not provide those
> bits in the default model.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c  | 2 ++
>  target/s390x/gen-features.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 7ae5fb38dd..f8f58c8acb 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -824,6 +824,8 @@ DEFINE_CCW_MACHINE(3_0, "3.0", true);
>  static void ccw_machine_2_12_instance_options(MachineState *machine)
>  {
>      ccw_machine_3_0_instance_options(machine);
> +    s390_cpudef_featoff_greater(11, 1, S390_FEAT_PPA15);
> +    s390_cpudef_featoff_greater(11, 1, S390_FEAT_BPB);
>  }
>  
>  static void ccw_machine_2_12_class_options(MachineClass *mc)
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 6c1c636140..5af042c003 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -513,6 +513,8 @@ static uint16_t default_GEN11_GA1[] = {
>      S390_FEAT_IPTE_RANGE,
>      S390_FEAT_ACCESS_EXCEPTION_FS_INDICATION,
>      S390_FEAT_GROUP_MSA_EXT_4,
> +    S390_FEAT_PPA15,
> +    S390_FEAT_BPB,
>  };
>  
>  #define default_GEN11_GA2 EmptyFeat
> 


-- 

Thanks,

David / dhildenb
