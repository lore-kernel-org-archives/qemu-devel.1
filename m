Received: from eggs.gnu.org ([2001:4830:134:3::10]:41362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eii08-0002xT-EZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eii04-0003EK-DK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:44:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eii04-0003D1-41
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:44:04 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15EgQfT064903
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 09:44:02 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fxs1d0sw3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 09:44:02 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Feb 2018 14:44:00 -0000
References: <20180205141215.50207-1-borntraeger@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Feb 2018 15:43:55 +0100
MIME-Version: 1.0
In-Reply-To: <20180205141215.50207-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f90354e5-663a-b996-e031-3c2ca12732e5@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4] s390x/cpu: expose the guest crash
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>



On 02/05/2018 03:12 PM, Christian Borntraeger wrote:

[...]

> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index a1123ad621..71414cc324 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -77,6 +77,14 @@ typedef struct MchkQueue {
>      uint16_t type;
>  } MchkQueue;
> 
> +/* Crash cases. */
> +enum crash_reasons {
I should add a CRASH_REASON_UNKNOWN,


> +    CRASH_REASON_PGM,
> +    CRASH_REASON_EXT,
> +    CRASH_REASON_WAITPSW,
> +    CRASH_REASON_OPEREXC,
> +};


> +
>  struct CPUS390XState {
>      uint64_t regs[16];     /* GP registers */
>      /*
> @@ -102,6 +110,8 @@ struct CPUS390XState {
> 
>      PSW psw;
> 
> +    enum crash_reasons crash_reason;
> +

as this gets zeroed on reset.
If we ever get called from other code that does not set a crash reason we better
say "unknown"
