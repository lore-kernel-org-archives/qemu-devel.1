Received: from eggs.gnu.org ([2001:4830:134:3::10]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFREO-00078X-2U
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:57:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFREK-0004W7-Sg
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:57:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35556
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eFREK-0004UE-MP
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:57:48 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGKsoeh100769
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:57:44 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9gvekw5s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:57:44 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Nov 2017 20:57:42 -0000
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-3-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Nov 2017 21:57:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171116170526.12643-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e6289369-7e0f-7247-34b9-2f27df1c0edc@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 2/3] s390x/tcg: fix DIAG 308
 with > 1 VCPU (single threaded TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

Please change the subject. In busy times I tend to ignore tcg patches.
This code is clearly kvm and tcg.
So what about "s390x/diag:" as prefix?

On 11/16/2017 06:05 PM, David Hildenbrand wrote:
> Currently, single threaded TCG with > 1 VCPU gets stuck during IPL, when
> the bios tries to switch to the loaded kernel via DIAG 308.
> 
> pause_all_vcpus()/resume_all_vcpus() should not be called from a VCPU.
> 
> And there is also no need for it. run_on_cpu() will make sure that the
> CPUs exit KVM/TCG, where they get stopped. Once stopped, they will no
> longer run.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/diag.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index dbbb9e886f..52bc348808 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -27,7 +27,6 @@ static int modified_clear_reset(S390CPU *cpu)
>      S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
>      CPUState *t;
> 
> -    pause_all_vcpus();


I did this to prevent a "still running CPU to restart an already stopped one".
Are we sure that this can not happen?


>      cpu_synchronize_all_states();
>      CPU_FOREACH(t) {
>          run_on_cpu(t, s390_do_cpu_full_reset, RUN_ON_CPU_NULL);
> @@ -37,7 +36,6 @@ static int modified_clear_reset(S390CPU *cpu)
>      s390_crypto_reset();
>      scc->load_normal(CPU(cpu));
>      cpu_synchronize_all_post_reset();
> -    resume_all_vcpus();
>      return 0;
>  }
> 
> @@ -53,7 +51,6 @@ static int load_normal_reset(S390CPU *cpu)
>      S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
>      CPUState *t;
> 
> -    pause_all_vcpus();
>      cpu_synchronize_all_states();
>      CPU_FOREACH(t) {
>          run_on_cpu(t, s390_do_cpu_reset, RUN_ON_CPU_NULL);
> @@ -63,7 +60,6 @@ static int load_normal_reset(S390CPU *cpu)
>      scc->initial_cpu_reset(CPU(cpu));
>      scc->load_normal(CPU(cpu));
>      cpu_synchronize_all_post_reset();
> -    resume_all_vcpus();
>      return 0;
>  }
> 
