Received: from eggs.gnu.org ([2001:4830:134:3::10]:39637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDQb-0004yl-NV
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 09:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEDHy-0003Ev-Tg
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:57:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEDHy-0003Ej-Lc
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 08:57:02 -0400
Received: by mail-wm1-x32b.google.com with SMTP id 193-v6so7637982wme.3
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 05:57:02 -0700 (PDT)
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-11-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5c09eee5-1d26-37ff-f4c7-2262c307c40c@linaro.org>
Date: Sun, 21 Oct 2018 13:56:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181019010625.25294-11-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 10/56] ppc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> @@ -1088,11 +1088,13 @@ static target_ulong h_cede(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>  
>      env->msr |= (1ULL << MSR_EE);
>      hreg_compute_hflags(env);
> +    cpu_mutex_lock(cs);
>      if (!cpu_has_work(cs)) {
> -        cs->halted = 1;
> +        cpu_halted_set(cs, 1);
>          cs->exception_index = EXCP_HLT;
>          cs->exit_request = 1;
>      }
> +    cpu_mutex_unlock(cs);
>      return H_SUCCESS;

Why does this one get extra locking?


r~
