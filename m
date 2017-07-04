Received: from eggs.gnu.org ([2001:4830:134:3::10]:59812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOrB-0000iW-8j
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dSOr6-0000eu-DX
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:31:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dSOr6-0000ek-6O
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:31:08 -0400
Date: Tue, 4 Jul 2017 16:31:03 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170704163103.4d6670a9@dhcp-192-215.str.redhat.com>
In-Reply-To: <1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
References: <1499177279-131407-1-git-send-email-borntraeger@de.ibm.com>
	<1499177279-131407-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] s390x: fix error propagation in
 kvm-flic's realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Halil Pasic <pasic@linux.vnet.ibm.com>

On Tue,  4 Jul 2017 16:07:55 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> 
> From the moment it was introduced by commit a2875e6f98 ("s390x/kvm:
> implement floating-interrupt controller device", 2013-07-16) the kvm-flic
> is not making realize fail properly in case it's impossible to create the
> KVM device which basically serves as a backend and is absolutely
> essential for having an operational kvm-flic.
> 
> Let's fix this by making sure we do proper error propagation in realize.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes: a2875e6f98 "s390x/kvm: implement floating-interrupt controller device"
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/intc/s390_flic_kvm.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 

(...)

>      cd.type = KVM_DEV_TYPE_FLIC;
>      ret = kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd);
>      if (ret < 0) {
> -        trace_flic_create_device(errno);
> -        return;
> +        error_setg_errno(&errp_local, errno, "Creating the KVM device failed");
> +        trace_flic_no_device_api(errno);

Err... this should still be trace_flic_create_device(), no?

> +        goto fail;
>      }
>      flic_state->fd = cd.fd;
