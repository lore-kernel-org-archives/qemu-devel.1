Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk6nI-0003Y8-RU
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk6nI-0003P0-0L
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:52:24 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk6nH-0003ML-PH
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:52:23 -0400
Received: by mail-wr0-x234.google.com with SMTP id p14so53185943wrg.1
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 03:52:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <329bff28-5804-2d39-7bd8-9336eaaf9d26@redhat.com>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
	<CAFEAcA-iuizr9eh3=ZkPPT+YxfWzvUFzbWB-aA_Mo5BiDkrzQQ@mail.gmail.com>
	<b1167424-0f05-aad7-f456-22ca0aee2000@redhat.com>
	<CAFEAcA8dJe5uB-tUoeF=dE_q8HG_LLAmLUHdfR0XZihGN5JFXA@mail.gmail.com>
	<329bff28-5804-2d39-7bd8-9336eaaf9d26@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 11:52:00 +0100
Message-ID: <CAFEAcA9LUgCEAnMxuk_4Pdn9_rUuzTdyqH66Sp-VZy9K0gz-_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170822
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On 22 August 2017 at 11:41, Laurent Vivier <lvivier@redhat.com> wrote:
> On 22/08/2017 11:53, Peter Maydell wrote:
>> On 22 August 2017 at 10:43, Laurent Vivier <lvivier@redhat.com> wrote:
>>> On 22/08/2017 11:34, Peter Maydell wrote:
>>>> I get a make check failure on ppc64 Linux:
>>>>
>>>> TEST: tests/postcopy-test... (pid=12468)
>>>>   /ppc64/postcopy:
>>>> Broken pipe
>>>> qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
>>>> FAIL
>>>> GTester: last random seed: R02Se5468e06f561627824306d95b0566d2b
>>>> (pid=13011)
>>>> FAIL: tests/postcopy-test
>
> The problem is in:
>
> bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
> {
>     CPUState *cs = CPU(cpu);
>
>     if (cap_ppc_pvr_compat) {
>         return false;
>     }
>
>     return !kvmppc_is_pr(cs->kvm_state);
> }
>
> It guesses !kvm pr means kvm_hv. That is not true, it can be TCG.
>
> This fixes the problem for me:
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2817,5 +2817,5 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
>          return false;
>      }
>
> -    return !kvmppc_is_pr(cs->kvm_state);
> +    return kvm_enabled() && !kvmppc_is_pr(cs->kvm_state);
>  }

Yep, fixes the failure for me too. David, can you respin your
pull request, please?

thanks
-- PMM
