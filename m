Received: from eggs.gnu.org ([2001:4830:134:3::10]:46482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTleZ-00025L-HZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gTleV-0003Vw-TV
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gTleM-0003Oy-MZ
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:40:30 -0500
Received: by mail-wr1-x442.google.com with SMTP id r10so11548259wrs.10
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:40:22 -0800 (PST)
References: <20181130215221.20554-1-richard.henderson@linaro.org>
	<20181130215221.20554-12-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181130215221.20554-12-richard.henderson@linaro.org>
Date: Mon, 03 Dec 2018 10:40:20 +0000
Message-ID: <871s6y51wr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 11/16] tcg: Return success from
 patch_reloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> This will move the assert for success from within (subroutines of)
> patch_reloc into the callers.  It will also let new code do something
> different when a relocation is out of range.
>
> For the moment, all backends are trivially converted to return true.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tcg/aarch64/tcg-target.inc.c | 3 ++-
>  tcg/arm/tcg-target.inc.c     | 3 ++-
>  tcg/i386/tcg-target.inc.c    | 3 ++-
>  tcg/mips/tcg-target.inc.c    | 3 ++-
>  tcg/ppc/tcg-target.inc.c     | 3 ++-
>  tcg/s390/tcg-target.inc.c    | 3 ++-
>  tcg/sparc/tcg-target.inc.c   | 5 +++--
>  tcg/tcg.c                    | 8 +++++---
>  tcg/tci/tcg-target.inc.c     | 3 ++-
>  9 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index 28de0226fb..16f08c59c4 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -94,7 +94,7 @@ static inline void reloc_pc19(tcg_insn_unit *code_ptr, =
tcg_insn_unit *target)
>      *code_ptr =3D deposit32(*code_ptr, 5, 19, offset);
>  }
>
> -static inline void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                                 intptr_t value, intptr_t addend)
>  {
>      tcg_debug_assert(addend =3D=3D 0);
> @@ -109,6 +109,7 @@ static inline void patch_reloc(tcg_insn_unit *code_pt=
r, int type,
>      default:
>          tcg_abort();
>      }
> +    return true;
>  }
>
>  #define TCG_CT_CONST_AIMM 0x100
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 1651f00281..deefa20fbf 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -193,7 +193,7 @@ static inline void reloc_pc24(tcg_insn_unit *code_ptr=
, tcg_insn_unit *target)
>      *code_ptr =3D (*code_ptr & ~0xffffff) | (offset & 0xffffff);
>  }
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      tcg_debug_assert(addend =3D=3D 0);
> @@ -229,6 +229,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      } else {
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>
>  #define TCG_CT_CONST_ARM  0x100
> diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
> index 436195894b..5c88f1f36b 100644
> --- a/tcg/i386/tcg-target.inc.c
> +++ b/tcg/i386/tcg-target.inc.c
> @@ -167,7 +167,7 @@ static bool have_lzcnt;
>
>  static tcg_insn_unit *tb_ret_addr;
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      value +=3D addend;
> @@ -191,6 +191,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      default:
>          tcg_abort();
>      }
> +    return true;
>  }
>
>  #if TCG_TARGET_REG_BITS =3D=3D 64
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index e21cb1ae28..a06ff257fa 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -168,12 +168,13 @@ static inline void reloc_26(tcg_insn_unit *pc, tcg_=
insn_unit *target)
>      *pc =3D deposit32(*pc, 0, 26, reloc_26_val(pc, target));
>  }
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      tcg_debug_assert(type =3D=3D R_MIPS_PC16);
>      tcg_debug_assert(addend =3D=3D 0);
>      reloc_pc16(code_ptr, (tcg_insn_unit *)value);
> +    return true;
>  }
>
>  #define TCG_CT_CONST_ZERO 0x100
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 2e2a22f579..860b0d36e1 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -513,7 +513,7 @@ static const uint32_t tcg_to_isel[] =3D {
>      [TCG_COND_GTU] =3D ISEL | BC_(7, CR_GT),
>  };
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      tcg_insn_unit *target;
> @@ -548,6 +548,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      default:
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>
>  static void tcg_out_mem_long(TCGContext *s, int opi, int opx, TCGReg rt,
> diff --git a/tcg/s390/tcg-target.inc.c b/tcg/s390/tcg-target.inc.c
> index 96c344142e..68a4c60394 100644
> --- a/tcg/s390/tcg-target.inc.c
> +++ b/tcg/s390/tcg-target.inc.c
> @@ -366,7 +366,7 @@ static void * const qemu_st_helpers[16] =3D {
>  static tcg_insn_unit *tb_ret_addr;
>  uint64_t s390_facilities;
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      intptr_t pcrel2;
> @@ -393,6 +393,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      default:
>          g_assert_not_reached();
>      }
> +    return true;
>  }
>
>  /* parse target specific constraints */
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index 671a04c54b..cadda770c4 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -291,7 +291,7 @@ static inline int check_fit_i32(int32_t val, unsigned=
 int bits)
>  # define check_fit_ptr  check_fit_i32
>  #endif
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      uint32_t insn =3D *code_ptr;
> @@ -328,12 +328,13 @@ static void patch_reloc(tcg_insn_unit *code_ptr, in=
t type,
>          /* Note that we're abusing this reloc type for our own needs.  */
>          code_ptr[0] =3D deposit32(code_ptr[0], 0, 22, value >> 10);
>          code_ptr[1] =3D deposit32(code_ptr[1], 0, 10, value);
> -        return;
> +        return true;
>      default:
>          g_assert_not_reached();
>      }
>
>      *code_ptr =3D insn;
> +    return true;
>  }
>
>  /* parse target specific constraints */
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e85133ef05..54f1272187 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -66,7 +66,7 @@
>  static void tcg_target_init(TCGContext *s);
>  static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode);
>  static void tcg_target_qemu_prologue(TCGContext *s);
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend);
>
>  /* The CIE and FDE header definitions will be common to all hosts.  */
> @@ -268,7 +268,8 @@ static void tcg_out_reloc(TCGContext *s, tcg_insn_uni=
t *code_ptr, int type,
>          /* FIXME: This may break relocations on RISC targets that
>             modify instruction fields in place.  The caller may not have
>             written the initial value.  */
> -        patch_reloc(code_ptr, type, l->u.value, addend);
> +        bool ok =3D patch_reloc(code_ptr, type, l->u.value, addend);
> +        tcg_debug_assert(ok);
>      } else {
>          /* add a new relocation entry */
>          r =3D tcg_malloc(sizeof(TCGRelocation));
> @@ -288,7 +289,8 @@ static void tcg_out_label(TCGContext *s, TCGLabel *l,=
 tcg_insn_unit *ptr)
>      tcg_debug_assert(!l->has_value);
>
>      for (r =3D l->u.first_reloc; r !=3D NULL; r =3D r->next) {
> -        patch_reloc(r->ptr, r->type, value, r->addend);
> +        bool ok =3D patch_reloc(r->ptr, r->type, value, r->addend);
> +        tcg_debug_assert(ok);
>      }
>
>      l->has_value =3D 1;
> diff --git a/tcg/tci/tcg-target.inc.c b/tcg/tci/tcg-target.inc.c
> index 62ed097254..0015a98485 100644
> --- a/tcg/tci/tcg-target.inc.c
> +++ b/tcg/tci/tcg-target.inc.c
> @@ -369,7 +369,7 @@ static const char *const tcg_target_reg_names[TCG_TAR=
GET_NB_REGS] =3D {
>  };
>  #endif
>
> -static void patch_reloc(tcg_insn_unit *code_ptr, int type,
> +static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
>                          intptr_t value, intptr_t addend)
>  {
>      /* tcg_out_reloc always uses the same type, addend. */
> @@ -381,6 +381,7 @@ static void patch_reloc(tcg_insn_unit *code_ptr, int =
type,
>      } else {
>          tcg_patch64(code_ptr, value);
>      }
> +    return true;
>  }
>
>  /* Parse target specific constraints. */


--
Alex Benn=C3=A9e
