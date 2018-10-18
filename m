Received: from eggs.gnu.org ([2001:4830:134:3::10]:36881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Mm-0008Aj-EP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gD9Mj-0000ko-TP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gD9Mg-0000dH-33
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:33:30 -0400
References: <20181018134401.44471-1-r.bolshakov@yadro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0013d078-d3e3-b9c5-aff4-658570469c94@redhat.com>
Date: Thu, 18 Oct 2018 16:33:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181018134401.44471-1-r.bolshakov@yadro.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: hvf: Fix register refs if REX is
 present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 18/10/2018 15:44, Roman Bolshakov wrote:
> According to Intel(R)64 and IA-32 Architectures Software Developer's
> Manual, the following one-byte registers should be fetched when REX
> prefix is present (sorted by reg encoding index):
> AL, CL, DL, BL, SPL, BPL, SIL, DIL, R8L - R15L
> 
> The first 8 are fetched if REX.R is zero, the last 8 if non-zero.
> 
> The following registers should be fetched for instructions without REX
> prefix (also sorted by reg encoding index):
> AL, CL, DL, BL, AH, CH, DH, BH
> 
> Current emulation code doesn't handle accesses to SPL, BPL, SIL, DIL
> when REX is present, thefore an instruction 40883e "mov %dil,(%rsi)" is
> decoded as "mov %bh,(%rsi)".
> 
> That caused an infinite loop in vp_reset:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03293.html
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>

Queued, thanks.

Paolo

>  target/i386/hvf/x86_decode.c | 67 ++++++++++++++++++++----------------
>  target/i386/hvf/x86_decode.h |  6 ++--
>  2 files changed, 42 insertions(+), 31 deletions(-)
> 
> diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
> index 2d7540fe7c..2e33b69541 100644
> --- a/target/i386/hvf/x86_decode.c
> +++ b/target/i386/hvf/x86_decode.c
> @@ -113,7 +113,8 @@ static void decode_modrm_reg(CPUX86State *env, struct x86_decode *decode,
>  {
>      op->type = X86_VAR_REG;
>      op->reg = decode->modrm.reg;
> -    op->ptr = get_reg_ref(env, op->reg, decode->rex.r, decode->operand_size);
> +    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.r,
> +                          decode->operand_size);
>  }
>  
>  static void decode_rax(CPUX86State *env, struct x86_decode *decode,
> @@ -121,7 +122,8 @@ static void decode_rax(CPUX86State *env, struct x86_decode *decode,
>  {
>      op->type = X86_VAR_REG;
>      op->reg = R_EAX;
> -    op->ptr = get_reg_ref(env, op->reg, 0, decode->operand_size);
> +    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, 0,
> +                          decode->operand_size);
>  }
>  
>  static inline void decode_immediate(CPUX86State *env, struct x86_decode *decode,
> @@ -263,16 +265,16 @@ static void decode_incgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0x40;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_decgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0x48;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_incgroup2(CPUX86State *env, struct x86_decode *decode)
> @@ -288,16 +290,16 @@ static void decode_pushgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0x50;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_popgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0x58;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_jxx(CPUX86State *env, struct x86_decode *decode)
> @@ -378,16 +380,16 @@ static void decode_xchgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0x90;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_movgroup(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0xb8;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>      decode_immediate(env, decode, &decode->op[1], decode->operand_size);
>  }
>  
> @@ -402,8 +404,8 @@ static void decode_movgroup8(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[0] - 0xb0;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>      decode_immediate(env, decode, &decode->op[1], decode->operand_size);
>  }
>  
> @@ -412,7 +414,8 @@ static void decode_rcx(CPUX86State *env, struct x86_decode *decode,
>  {
>      op->type = X86_VAR_REG;
>      op->reg = R_ECX;
> -    op->ptr = get_reg_ref(env, op->reg, decode->rex.b, decode->operand_size);
> +    op->ptr = get_reg_ref(env, op->reg, decode->rex.rex, decode->rex.b,
> +                          decode->operand_size);
>  }
>  
>  struct decode_tbl {
> @@ -639,8 +642,8 @@ static void decode_bswap(CPUX86State *env, struct x86_decode *decode)
>  {
>      decode->op[0].type = X86_VAR_REG;
>      decode->op[0].reg = decode->opcode[1] - 0xc8;
> -    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.b,
> -                                    decode->operand_size);
> +    decode->op[0].ptr = get_reg_ref(env, decode->op[0].reg, decode->rex.rex,
> +                                    decode->rex.b, decode->operand_size);
>  }
>  
>  static void decode_d9_4(CPUX86State *env, struct x86_decode *decode)
> @@ -1686,7 +1689,8 @@ calc_addr:
>      }
>  }
>  
> -target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
> +target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
> +                         int size)
>  {
>      target_ulong ptr = 0;
>      int which = 0;
> @@ -1698,7 +1702,7 @@ target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
>  
>      switch (size) {
>      case 1:
> -        if (is_extended || reg < 4) {
> +        if (is_extended || reg < 4 || rex) {
>              which = 1;
>              ptr = (target_ulong)&RL(env, reg);
>          } else {
> @@ -1714,10 +1718,11 @@ target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size)
>      return ptr;
>  }
>  
> -target_ulong get_reg_val(CPUX86State *env, int reg, int is_extended, int size)
> +target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
> +                         int size)
>  {
>      target_ulong val = 0;
> -    memcpy(&val, (void *)get_reg_ref(env, reg, is_extended, size), size);
> +    memcpy(&val, (void *)get_reg_ref(env, reg, rex, is_extended, size), size);
>      return val;
>  }
>  
> @@ -1739,7 +1744,8 @@ static target_ulong get_sib_val(CPUX86State *env, struct x86_decode *decode,
>          if (base_reg == R_ESP || base_reg == R_EBP) {
>              *sel = R_SS;
>          }
> -        base = get_reg_val(env, decode->sib.base, decode->rex.b, addr_size);
> +        base = get_reg_val(env, decode->sib.base, decode->rex.rex,
> +                           decode->rex.b, addr_size);
>      }
>  
>      if (decode->rex.x) {
> @@ -1747,7 +1753,8 @@ static target_ulong get_sib_val(CPUX86State *env, struct x86_decode *decode,
>      }
>  
>      if (index_reg != R_ESP) {
> -        scaled_index = get_reg_val(env, index_reg, decode->rex.x, addr_size) <<
> +        scaled_index = get_reg_val(env, index_reg, decode->rex.rex,
> +                                   decode->rex.x, addr_size) <<
>                                     decode->sib.scale;
>      }
>      return base + scaled_index;
> @@ -1776,7 +1783,8 @@ void calc_modrm_operand32(CPUX86State *env, struct x86_decode *decode,
>          if (decode->modrm.rm == R_EBP || decode->modrm.rm == R_ESP) {
>              seg = R_SS;
>          }
> -        ptr += get_reg_val(env, decode->modrm.rm, decode->rex.b, addr_size);
> +        ptr += get_reg_val(env, decode->modrm.rm, decode->rex.rex,
> +                           decode->rex.b, addr_size);
>      }
>  
>      if (X86_DECODE_CMD_LEA == decode->cmd) {
> @@ -1805,7 +1813,8 @@ void calc_modrm_operand64(CPUX86State *env, struct x86_decode *decode,
>      } else if (0 == mod && 5 == rm) {
>          ptr = RIP(env) + decode->len + (int32_t) offset;
>      } else {
> -        ptr = get_reg_val(env, src, decode->rex.b, 8) + (int64_t) offset;
> +        ptr = get_reg_val(env, src, decode->rex.rex, decode->rex.b, 8) +
> +              (int64_t) offset;
>      }
>  
>      if (X86_DECODE_CMD_LEA == decode->cmd) {
> @@ -1822,8 +1831,8 @@ void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
>      if (3 == decode->modrm.mod) {
>          op->reg = decode->modrm.reg;
>          op->type = X86_VAR_REG;
> -        op->ptr = get_reg_ref(env, decode->modrm.rm, decode->rex.b,
> -                              decode->operand_size);
> +        op->ptr = get_reg_ref(env, decode->modrm.rm, decode->rex.rex,
> +                              decode->rex.b, decode->operand_size);
>          return;
>      }
>  
> diff --git a/target/i386/hvf/x86_decode.h b/target/i386/hvf/x86_decode.h
> index 5ab6f31fa5..ef4bcab310 100644
> --- a/target/i386/hvf/x86_decode.h
> +++ b/target/i386/hvf/x86_decode.h
> @@ -303,8 +303,10 @@ uint64_t sign(uint64_t val, int size);
>  
>  uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
>  
> -target_ulong get_reg_ref(CPUX86State *env, int reg, int is_extended, int size);
> -target_ulong get_reg_val(CPUX86State *env, int reg, int is_extended, int size);
> +target_ulong get_reg_ref(CPUX86State *env, int reg, int rex, int is_extended,
> +                         int size);
> +target_ulong get_reg_val(CPUX86State *env, int reg, int rex, int is_extended,
> +                         int size);
>  void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
>                          struct x86_decode_op *op);
>  target_ulong decode_linear_addr(CPUX86State *env, struct x86_decode *decode,
> 
