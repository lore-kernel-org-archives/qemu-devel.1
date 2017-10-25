Received: from eggs.gnu.org ([2001:4830:134:3::10]:45945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1e7QBV-0002YC-Hs
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.vnet.ibm.com>) id 1e7QBR-0007MD-F1
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:13:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.vnet.ibm.com>)
	id 1e7QBR-0007L4-6P
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:13:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9PIAX27073747
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 14:13:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dtxfnurf7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 14:13:34 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.vnet.ibm.com>;
	Wed, 25 Oct 2017 12:13:34 -0600
Reply-To: jjherne@linux.vnet.ibm.com
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 14:13:30 -0400
MIME-Version: 1.0
In-Reply-To: <20171020145437.18549-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c76678f3-70df-e963-12b8-208c5c2a1578@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH/QEMU] s390x/kvm: use cpu_model_available
 for guarded storage on compat machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Jiri Denemark <jdenemar@redhat.com>

On 10/20/2017 10:54 AM, Christian Borntraeger wrote:
> Starting a guest with
>     <os>
>      <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>    </os>
>    <cpu mode='host-model'/>
> 
> on an IBM z14 results in
> 
> "qemu-system-s390x: Some features requested in the CPU model are not
> available in the configuration: gs"
> 
> This is because guarded storage is fenced for compat machines that did not have
> guarded storage support, but libvirt expands the cpu model according to the
> latest available machine.
> 
> While this prevents future migration abort (by not starting the guest at all),
> not being able to start a "host-model" guest is very much unexpected.  As it
> turns out, even if we would modify libvirt to not expand the cpu model to
> contain "gs" for compat machines, it cannot guarantee that a migration will
> succeed. For example if the kernel changes its features (or the user has
> nested=1 on one host but not on the other) the migration will fail
> nevertheless.  So instead of fencing "gs" for machines <= 2.9 lets allow it for
> all machine types that support the CPU model. This will make "host-model"
> runnable all the time, while relying on the CPU model to reject invalid
> migration attempts.
...
> -    if (gs_allowed()) {
> +    if (cpu_model_allowed()) {
>           if (kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0) == 0) {
>               cap_gs = 1;

Ok, honestly, I dislike this idea because it means we are effectively 
lying now. We will happily accept a +gs cpu model with a 2.9 compat 
machine when the point of compat machines is to mimick the older version 
of Qemu which does not support GS.  Yes, model checking will prevent the 
worst side effects, namely, exploding migrations.

I'd far prefer a solution that makes host-model dependent on the machine 
type. But I understand some of the backlash on that idea. Still, it 
seems like the cleanest approach even if it will be more work.

With all of that said, I know we want this fixed and your patch seems to 
fix the problem. So if you need an R-b...

Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>

Can we have a new tag? :-D
Reviewed-by-with-reservations: Jason J. Herne <jjherne@linux.vnet.ibm.com>

-- 
-- Jason J. Herne (jjherne@linux.vnet.ibm.com)
