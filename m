Received: from eggs.gnu.org ([2001:4830:134:3::10]:60981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkpZL-0004G8-7R
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dkpZG-000807-Ad
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:40:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dkpZG-0007zg-1s
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:40:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OAeC5h145348
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 06:40:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chv0vm7uf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 06:40:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 11:40:49 +0100
References: <1503569328-22197-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 12:40:44 +0200
MIME-Version: 1.0
In-Reply-To: <1503569328-22197-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <dbb5d0ca-00b8-ede8-231f-a8d3732c48cd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/s390x/s390-skeys: Mark the
 storage key devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 08/24/2017 12:08 PM, Thomas Huth wrote:
> QEMU currently aborts if the user tries to create a skey device:
> 
> $ s390x-softmmu/qemu-system-s390x -nographic -device s390-skeys-qemu
> qemu-system-s390x: hw/s390x/s390-skeys.c:30: s390_get_skeys_device:
>  Assertion `ss' failed.
> Aborted (core dumped)
> 
> The storage key devices are only meant to be instantiated one time,
> internally. They can not be used by the user, so mark them with
> user_creatable = false.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-skeys-kvm.c | 4 ++++
>  hw/s390x/s390-skeys.c     | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
> index 131da56..dc54ed8 100644
> --- a/hw/s390x/s390-skeys-kvm.c
> +++ b/hw/s390x/s390-skeys-kvm.c
> @@ -54,10 +54,14 @@ static int kvm_s390_skeys_set(S390SKeysState *ss, uint64_t start_gfn,
>  static void kvm_s390_skeys_class_init(ObjectClass *oc, void *data)
>  {
>      S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> 
>      skeyclass->skeys_enabled = kvm_s390_skeys_enabled;
>      skeyclass->get_skeys = kvm_s390_skeys_get;
>      skeyclass->set_skeys = kvm_s390_skeys_set;
> +
> +    /* Reason: Internal device (only one skeys device for the whole memory) */
> +    dc->user_creatable = false;
>  }
> 
>  static const TypeInfo kvm_s390_skeys_info = {
> diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
> index c0de3b0..53ad5d3 100644
> --- a/hw/s390x/s390-skeys.c
> +++ b/hw/s390x/s390-skeys.c
> @@ -229,10 +229,14 @@ static int qemu_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
>  static void qemu_s390_skeys_class_init(ObjectClass *oc, void *data)
>  {
>      S390SKeysClass *skeyclass = S390_SKEYS_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> 
>      skeyclass->skeys_enabled = qemu_s390_skeys_enabled;
>      skeyclass->get_skeys = qemu_s390_skeys_get;
>      skeyclass->set_skeys = qemu_s390_skeys_set;
> +
> +    /* Reason: Internal device (only one skeys device for the whole memory) */
> +    dc->user_creatable = false;
>  }
> 
>  static const TypeInfo qemu_s390_skeys_info = {
> 

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
