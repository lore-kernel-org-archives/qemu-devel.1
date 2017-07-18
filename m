Received: from eggs.gnu.org ([2001:4830:134:3::10]:48033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXYbn-0003Rd-8l
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dXYbi-0000sn-Ce
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:56:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36558
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dXYbi-0000sP-5c
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 15:56:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6IJsI8h007657
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:56:33 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bsm69cvf0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:56:32 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 18 Jul 2017 13:56:32 -0600
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-5-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 18 Jul 2017 21:56:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <5f8a2315-9224-f20c-7524-11f9a8ac8efd@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v2 4/9] s390x/pci: do not advertise pci
 on non-pci builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com

On 07/18/2017 04:24 PM, Cornelia Huck wrote:
> Only set the zpci and aen feature bits on builds that actually
> support pci.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/s390x/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 831492f9a2..880eccd58a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2685,8 +2685,10 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>      }
> 
>      /* set zpci and aen facilities */
> +#ifdef CONFIG_PCI
>      set_bit(S390_FEAT_ZPCI, model->features);
>      set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
> +#endif
> 
>      if (s390_known_cpu_type(cpu_type)) {
>          /* we want the exact model, even if some features are missing */
> 

Not strictly necessary but do you also want to ifdef this

 kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);

call?

If not you could actually even allow AEN but not PCI for !CONFIG_PCI.
