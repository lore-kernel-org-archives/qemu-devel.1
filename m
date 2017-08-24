Received: from eggs.gnu.org ([2001:4830:134:3::10]:53304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dkr4y-0007z2-7t
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1dkr4s-00012d-9M
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:17:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36261
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1dkr4s-00012F-3D
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:17:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7OCAQvL041973
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 08:17:37 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chvsm666s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 08:17:37 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 24 Aug 2017 13:17:35 +0100
Date: Thu, 24 Aug 2017 14:17:32 +0200
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
In-Reply-To: <1503576029-24264-1-git-send-email-thuth@redhat.com>
References: <1503576029-24264-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170824141732.7236d50a@p-imbrenda.boeblingen.de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] s390x/s390-stattrib: Mark the
 storage attribute as not user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>

On Thu, 24 Aug 2017 14:00:29 +0200
Thomas Huth <thuth@redhat.com> wrote:

> The storage attribute devices are only meant to be instantiated one
> time, internally. They can not be used by the user, so mark them with
> user_creatable = false.
> 
> Suggested-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

> ---
>  hw/s390x/s390-stattrib-kvm.c | 4 ++++
>  hw/s390x/s390-stattrib.c     | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/s390x/s390-stattrib-kvm.c
> b/hw/s390x/s390-stattrib-kvm.c index ff3f89f..bc0274d 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -163,6 +163,7 @@ static int
> kvm_s390_stattrib_get_active(S390StAttribState *sa) static void
> kvm_s390_stattrib_class_init(ObjectClass *oc, void *data) {
>      S390StAttribClass *sac = S390_STATTRIB_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> 
>      sac->get_stattr = kvm_s390_stattrib_get_stattr;
>      sac->peek_stattr = kvm_s390_stattrib_peek_stattr;
> @@ -171,6 +172,9 @@ static void
> kvm_s390_stattrib_class_init(ObjectClass *oc, void *data)
> sac->get_dirtycount = kvm_s390_stattrib_get_dirtycount;
> sac->synchronize = kvm_s390_stattrib_synchronize; sac->get_active =
> kvm_s390_stattrib_get_active; +
> +    /* Reason: Can only be instantiated one time (internally) */
> +    dc->user_creatable = false;
>  }
> 
>  static const TypeInfo kvm_s390_stattrib_info = {
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index d14923f..f75548e 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -306,6 +306,7 @@ static int qemu_s390_get_active(S390StAttribState
> *sa) static void qemu_s390_stattrib_class_init(ObjectClass *oc, void
> *data) {
>      S390StAttribClass *sa_cl = S390_STATTRIB_CLASS(oc);
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> 
>      sa_cl->synchronize = qemu_s390_synchronize_stub;
>      sa_cl->get_stattr = qemu_s390_get_stattr_stub;
> @@ -314,6 +315,9 @@ static void
> qemu_s390_stattrib_class_init(ObjectClass *oc, void *data)
> sa_cl->set_migrationmode = qemu_s390_set_migrationmode_stub;
> sa_cl->get_dirtycount = qemu_s390_get_dirtycount_stub;
> sa_cl->get_active = qemu_s390_get_active; +
> +    /* Reason: Can only be instantiated one time (internally) */
> +    dc->user_creatable = false;
>  }
> 
>  static const TypeInfo qemu_s390_stattrib_info = {
