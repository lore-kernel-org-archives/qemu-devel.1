Received: from eggs.gnu.org ([2001:4830:134:3::10]:32804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6XQ-0007ww-UZ
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eK6XM-0002WL-0G
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:52:49 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:42749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eK6XL-0002VY-Om
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 12:52:43 -0500
Received: by mail-wm0-x242.google.com with SMTP id l141so8063689wmg.1
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 09:52:43 -0800 (PST)
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-8-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <93989767-eceb-149b-e96f-309870d2a065@linaro.org>
Date: Wed, 29 Nov 2017 17:52:40 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-8-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 07/15] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
> +void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
> +{
> +    /* KVM will handle the interrupt automatically, TCG has to exit the TB */
> +    #ifdef CONFIG_TCG
> +    if (tcg_enabled()) {
> +        if (ra) {
> +            cpu_restore_state(CPU(cpu), ra);
> +        }
> +        cpu_loop_exit(CPU(cpu));
> +    }

In addition to everything else,

  cpu_loop_exit_restore(CPU(cpu), ra);


r~
