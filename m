Received: from eggs.gnu.org ([2001:4830:134:3::10]:48264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1fnAfk-0001Hl-0b
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1fnAfg-0004lc-Kf
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:41:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1fnAfg-0004ei-AJ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:41:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w77Md7R0099772
	for <qemu-devel@nongnu.org>; Tue, 7 Aug 2018 18:41:41 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2kqgm7r27j-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 18:41:41 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Tue, 7 Aug 2018 16:41:40 -0600
References: <1530312483-23864-1-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Tue, 7 Aug 2018 18:41:29 -0400
MIME-Version: 1.0
In-Reply-To: <1530312483-23864-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <4305b179-bcaa-9373-5b5c-41cd79122d5c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

Ping

On 06/29/2018 06:47 PM, Tony Krowiak wrote:
> From: Tony Krowiak <akrowiak@linux.ibm.com>
>
> This patch series is the QEMU counterpart to the KVM/kernel support for
> guest dedicated crypto adapters. The KVM/kernel model is built on the
> VFIO mediated device framework and provides the infrastructure for
> granting exclusive guest access to crypto devices installed on the linux
> host. This patch series introduces a new QEMU command line option, QEMU
> object model and CPU model features to exploit the KVM/kernel model.
>
> See the detailed specifications for AP virtualization provided by this
> patch set in docs/vfio-ap.txt for a more complete discussion of the
> design introduced by this patch series.
>
> Note: This series implements the minimal viable product (MVP) and does not
>        provide support for hot plug/unplug or migration. The goal
>        of the MVP model is to solidify a base upon which these additional
>        features will be built.
>
> --
> v5 => v6 Change log:
> ===================
> * Added reset handling fo vfio-ap device
> * Added a bridge/bus to AP device object model - thanks to Halil Pasic
>
> v4 => v5 Change log:
> ===================
> * Added MAINTAINERS entries for VFIO AP
> * Added explanation for why we are only supporting zEC12 and newer CPU
>    models.
> * Changed CPU model feature qci=on|off to apqci=on|off
> * Misc. minor changes
>
> v3 => v4 Change log:
> ===================
> * Made vfio-ap device unpluggable for now
> * Renamed command line CPU model feature for QCI: qci=on -> apqci=on
> * Removed call to KVM_S390_VM_CRYPTO_INTERPRET_AP ioctl - ioctl was
>    removed from kernel and AP instruction interpretation is set from the
>    VFIO device driver
> * Added check to ensure only one vfio-ap device can be configured per
>    guest
> * Removed AP instruction interception handlers: AP instructions will be
>    interpreted by default if AP facilities are installed to handle the case
>    where feature ap=on and no vfio-ap device is configured for the guest.
>
>
> Tony Krowiak (5):
>    linux-headers: linux header updates for AP support
>    s390x/cpumodel: Set up CPU model for AP device support
>    s390x/ap: base Adjunct Processor (AP) object model
>    s390x/vfio: ap: Introduce VFIO AP device
>    s390: doc: detailed specifications for AP virtualization
>
>   MAINTAINERS                       |   14 +
>   default-configs/s390x-softmmu.mak |    1 +
>   docs/vfio-ap.txt                  |  649 +++++++++++++++++++++++++++++++++++++
>   hw/s390x/Makefile.objs            |    2 +
>   hw/s390x/ap-bridge.c              |   76 +++++
>   hw/s390x/ap-device.c              |   39 +++
>   hw/s390x/s390-virtio-ccw.c        |    4 +
>   hw/vfio/Makefile.objs             |    1 +
>   hw/vfio/ap.c                      |  183 +++++++++++
>   include/hw/s390x/ap-bridge.h      |   37 +++
>   include/hw/s390x/ap-device.h      |   38 +++
>   include/hw/vfio/vfio-common.h     |    1 +
>   linux-headers/asm-s390/kvm.h      |    2 +
>   linux-headers/linux/vfio.h        |    2 +
>   target/s390x/cpu_features.c       |    3 +
>   target/s390x/cpu_features_def.h   |    3 +
>   target/s390x/cpu_models.c         |    2 +
>   target/s390x/gen-features.c       |    3 +
>   target/s390x/kvm.c                |    1 +
>   19 files changed, 1061 insertions(+), 0 deletions(-)
>   create mode 100644 docs/vfio-ap.txt
>   create mode 100644 hw/s390x/ap-bridge.c
>   create mode 100644 hw/s390x/ap-device.c
>   create mode 100644 hw/vfio/ap.c
>   create mode 100644 include/hw/s390x/ap-bridge.h
>   create mode 100644 include/hw/s390x/ap-device.h
>
