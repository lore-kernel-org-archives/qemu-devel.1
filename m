Received: from eggs.gnu.org ([209.51.188.92]:38112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3EK-0001JD-Ok
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:17:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3EJ-0008AD-PV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:17:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn3EJ-00089i-7I
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:17:15 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-14-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <33fa5dfc-23a4-aa40-1644-c5579870655f@redhat.com>
Date: Fri, 25 Jan 2019 16:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-14-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/52] hw/s390/Makefile.objs: Create new
 CONFIG_* variables for s390x boards and devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com

On 2019-01-25 11:06, Paolo Bonzini wrote:
> Make hw/s390x configurable and add new CONFIG_* to the default-configs/s390x*-softmmu.mak.
> This will be used to enable/disable vfio-ccw.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190123065618.3520-10-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/s390x-softmmu.mak | 1 +
>  hw/s390x/Makefile.objs            | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
> index 5eef375..8bb7e43 100644
> --- a/default-configs/s390x-softmmu.mak
> +++ b/default-configs/s390x-softmmu.mak
> @@ -8,3 +8,4 @@ CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
>  CONFIG_VFIO_CCW=$(CONFIG_LINUX)
>  CONFIG_WDT_DIAG288=y
>  CONFIG_VFIO_AP=$(CONFIG_LINUX)
> +CONFIG_S390_CCW_VIRTIO=y
> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
> index ca68806..a884aae 100644
> --- a/hw/s390x/Makefile.objs
> +++ b/hw/s390x/Makefile.objs
> @@ -1,3 +1,4 @@
> +ifeq ($(CONFIG_S390_CCW_VIRTIO),y)
>  obj-y += s390-virtio-hcall.o
>  obj-y += sclp.o
>  obj-y += event-facility.o
> @@ -33,3 +34,4 @@ obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
>  obj-y += s390-ccw.o
>  obj-y += ap-device.o
>  obj-y += ap-bridge.o
> +endif

That won't really work, a lot of code in target/s390x still depends on
the functions in these files here. I suggest to just disable the file
that defines the machine initially, i.e.:

obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o

We can still fine-tune this later.

 Thomas
