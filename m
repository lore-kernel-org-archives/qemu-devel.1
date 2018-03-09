Received: from eggs.gnu.org ([2001:4830:134:3::10]:51823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOhk-0003zB-Iq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1euOhg-0008Fm-L7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:33:28 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1euOhg-0008Fb-Gq
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:33:24 -0500
References: <1520626818-93348-1-git-send-email-mjc@sifive.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f02255ad-f0f9-9e7e-8ae7-6c588e41126a@redhat.com>
Date: Fri, 9 Mar 2018 14:33:23 -0600
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
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt <palmer@sifive.com>

[resend, this time with proper cc's]

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
>       char *isa_string = g_new0(char, maxlen);
>       snprintf(isa_string, maxlen, "rv%d", TARGET_LONG_BITS);
>       for (i = 0; i < sizeof(riscv_exts); i++) {

I'd rather you used ctpop64() from host-utils.h, so we have a 
centralized place to change things just once in case we have to tweak 
the use of __builtin_popcount when targetting a different compiler.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
