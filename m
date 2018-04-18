Received: from eggs.gnu.org ([2001:4830:134:3::10]:38426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f8kBi-0002Ij-6g
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f8kBe-00053K-WF
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:19:42 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f8kBe-00052r-L8
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 06:19:38 -0400
References: <20180418064152.24606.71975.stgit@pasha-VirtualBox>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <95c7f9c0-ed26-2376-533d-0649ab36d80b@vivier.eu>
Date: Wed, 18 Apr 2018 12:19:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180418064152.24606.71975.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] m68k: fix subx mem, mem instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru

Le 18/04/2018 à 08:41, Pavel Dovgalyuk a écrit :
> This patch fixes decrement of the pointers for subx mem, mem instructions.
> Without the patch pointers are decremented by OS_* constant value instead of
> retrieving the corresponding data size and using it as a decrement.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  target/m68k/translate.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 6beaf9e..e407ba2 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -3166,11 +3166,11 @@ DISAS_INSN(subx_mem)
>      opsize = insn_opsize(insn);
>  
>      addr_src = AREG(insn, 0);
> -    tcg_gen_subi_i32(addr_src, addr_src, opsize);
> +    tcg_gen_subi_i32(addr_src, addr_src, opsize_bytes(opsize));
>      src = gen_load(s, opsize, addr_src, 1, IS_USER(s));
>  
>      addr_dest = AREG(insn, 9);
> -    tcg_gen_subi_i32(addr_dest, addr_dest, opsize);
> +    tcg_gen_subi_i32(addr_dest, addr_dest, opsize_bytes(opsize));
>      dest = gen_load(s, opsize, addr_dest, 1, IS_USER(s));
>  
>      gen_subx(s, src, dest, opsize);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
