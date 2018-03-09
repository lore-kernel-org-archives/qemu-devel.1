Received: from eggs.gnu.org ([2001:4830:134:3::10]:51658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOgx-0003OD-Pw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOgt-00080K-SO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:32:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euOgt-00080C-N4
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:32:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA1894068030
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 20:32:29 +0000 (UTC)
Received: from [10.10.125.187] (ovpn-125-187.rdu2.redhat.com [10.10.125.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 69EBA2026DFD
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 20:32:25 +0000 (UTC)
References: <1520626818-93348-1-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60334b81-a1d3-a319-bdb7-b6558bd956e4@redhat.com>
Date: Fri, 9 Mar 2018 14:32:24 -0600
MIME-Version: 1.0
In-Reply-To: <1520626818-93348-1-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix isa string logic bug,
 use popcount to count bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 03/09/2018 02:20 PM, Michael Clark wrote:
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael Clark <mjc@sifive.com>
> ---
>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4851890..f0d6d1d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -391,7 +391,7 @@ static const TypeInfo riscv_cpu_type_info = {
>   char *riscv_isa_string(RISCVCPU *cpu)
>   {
>       int i;
> -    size_t maxlen = 5 + ctz32(cpu->env.misa);
> +    size_t maxlen = 5 + __builtin_popcountll(cpu->env.misa);

I'd rather you used ctpop64() from host-utils.h, so we have a 
centralized place to change things just once in case we have to tweak 
the use of __builtin_popcount when targetting a different compiler.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
