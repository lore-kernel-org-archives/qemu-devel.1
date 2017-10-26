Received: from eggs.gnu.org ([2001:4830:134:3::10]:54852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7dLt-0000wK-3i
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e7dLp-0007oo-TB
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:17:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e7dLp-0007nX-M3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:17:17 -0400
Date: Thu, 26 Oct 2017 10:17:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171026101709.7c7b47ff.cohuck@redhat.com>
In-Reply-To: <20171020145437.18549-1-borntraeger@de.ibm.com>
References: <20171020145437.18549-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Marc Hartmayer <mhartmay@linux.vnet.ibm.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

On Fri, 20 Oct 2017 16:54:37 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Starting a guest with
>    <os>
>     <type arch='s390x' machine='s390-ccw-virtio-2.9'>hvm</type>
>   </os>
>   <cpu mode='host-model'/>
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
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c         | 8 --------
>  include/hw/s390x/s390-virtio-ccw.h | 3 ---
>  target/s390x/kvm.c                 | 2 +-
>  3 files changed, 1 insertion(+), 12 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
