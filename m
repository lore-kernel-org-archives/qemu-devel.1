Received: from eggs.gnu.org ([2001:4830:134:3::10]:57501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUE5J-0003af-Eg
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cUE5F-0001RB-HP
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52107)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cUE5F-0001Pf-85
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:53:01 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0JEpe5Y147407
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:52:59 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 282y7a8yq8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:52:58 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 19 Jan 2017 14:52:55 -0000
Date: Thu, 19 Jan 2017 15:52:50 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <0503ac26-e660-325c-8257-59227c41021d@redhat.com>
References: <20170116195452.23532-1-ehabkost@redhat.com>
	<0503ac26-e660-325c-8257-59227c41021d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170119155250.79a5f90c.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Support "-cpu host" on TCG too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Igor Mammedov <imammedo@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Tue, 17 Jan 2017 18:43:40 +0100
David Hildenbrand <david@redhat.com> wrote:

> Uncompiled and untested.

@Jason: have you given this a try?

> @Conny and Christian, feel free to pick up and modify if this makes
> sense
> 
>  From 4a2af1ca47421b68eb7677cd91af350dd9be4e0e Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 17 Jan 2017 18:34:45 +0100
> Subject: [PATCH] s390x/cpumodel: allow the "host" model also for tcg
> 
> Let's also allow the host model for tcg, therefore meaning
> "enable all features supported by the selected accelerator in the current
> host".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   qapi-schema.json          |  4 ++--
>   target/s390x/cpu-qom.h    |  1 -
>   target/s390x/cpu_models.c | 34 ++++++++--------------------------
>   3 files changed, 10 insertions(+), 29 deletions(-)

(...)

> -#ifdef CONFIG_KVM
>   static void s390_host_cpu_model_initfn(Object *obj)
>   {
> +    S390CPUModel *max_model;
>       S390CPU *cpu = S390_CPU(obj);
>       Error *err = NULL;
> 
> -    if (!kvm_enabled() || !kvm_s390_cpu_models_supported()) {
> +    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
>           return;
>       }
> 
> -    cpu->model = g_malloc0(sizeof(*cpu->model));
> -    kvm_s390_get_host_cpu_model(cpu->model, &err);
> -    if (err) {
> +    max_model = get_max_cpu_model(&err);
> +    if (err || !max_model) {

I think checking for !max_model is enough.

>           error_report_err(err);
> -        g_free(cpu->model);
>           /* fallback to unsupported cpu models */
> -        cpu->model = NULL;
> +        return;
>       }
> +    /* copy the host model so it can be modified */
> +    cpu->model = g_memdup(max_model, sizeof(*cpu->model));
>   }
> -#endif

(...)

This gives us the same as before on kvm and z900 for tcg, so this seems
reasonable to me.
