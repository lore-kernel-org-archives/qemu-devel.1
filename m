Received: from eggs.gnu.org ([2001:4830:134:3::10]:39560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUi1-0001ck-W4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejUhz-0002rI-3D
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:44:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejUhy-0002r4-Tj
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:44:39 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w17IiNUD037556
	for <qemu-devel@nongnu.org>; Wed, 7 Feb 2018 13:44:38 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g03s3hafm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 13:44:37 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 7 Feb 2018 18:44:35 -0000
References: <20180207123833.211687-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 7 Feb 2018 19:44:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180207123833.211687-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b4c61e4f-4bbd-39d6-0e72-57e9ae1694fe@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v6] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>



On 02/07/2018 01:38 PM, Christian Borntraeger wrote:

> --- a/vl.c
> +++ b/vl.c
> @@ -1738,7 +1738,7 @@ void qemu_system_reset(ShutdownCause reason)
> 
>  void qemu_system_guest_panicked(GuestPanicInformation *info)
>  {
> -    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
> +    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
> 
>      if (current_cpu) {
>          current_cpu->crash_occurred = true;
> @@ -1754,13 +1754,21 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
> 
>      if (info) {
>          if (info->type == GUEST_PANIC_INFORMATION_TYPE_HYPER_V) {
> -            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
> +            qemu_log_mask(LOG_GUEST_ERROR, "\nHV crash parameters: (%#"PRIx64
>                            " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
>                            info->u.hyper_v.arg1,
>                            info->u.hyper_v.arg2,
>                            info->u.hyper_v.arg3,
>                            info->u.hyper_v.arg4,
>                            info->u.hyper_v.arg5);
> +        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_S390) {
> +            qemu_log_mask(LOG_GUEST_ERROR, " on cpu %d: %s\n"
> +                          "PSW: 0x%016" PRIx64 " 0x%016" PRIx64"\n",
> +                          info->u.s390.core,
> +                          qapi_enum_lookup(&S390CrashReason_lookup,
> +                                           info->u.s390.reason),

Question for the qapi people. Would you prefer S390CrashReason_str instead?

> +                          info->u.s390.psw_mask,
> +                          info->u.s390.psw_addr);
>          }
>          qapi_free_GuestPanicInformation(info);
>      }
> 
