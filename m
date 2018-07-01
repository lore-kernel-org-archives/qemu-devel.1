Received: from eggs.gnu.org ([2001:4830:134:3::10]:35931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1fZhXB-0007gh-72
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1fZhX8-00017V-8s
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:57:17 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:44612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1fZhX8-000162-0g
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 14:57:14 -0400
Received: by mail-qt0-x243.google.com with SMTP id b15-v6so2231642qtp.11
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 11:57:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180617084025.29198-1-doug16k@gmail.com>
References: <20180617084025.29198-1-doug16k@gmail.com>
From: Doug Gale <doug16k@gmail.com>
Date: Sun, 1 Jul 2018 14:57:12 -0400
Message-ID: <CAEfK_47iCSHfoBmdF_qG8W=mNTtp8Unt32Vg5twBdF+VJi6fEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] i386/monitor.c: make addresses canonical
 for "info mem" and "info tlb"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Doug Gale <doug16k@gmail.com>

On Sun, Jun 17, 2018 at 4:40 AM, Doug Gale <doug16k@gmail.com> wrote:

> Correct the output of the "info mem" and "info tlb" monitor commands to
> correctly show canonical addresses.
>
> In 48-bit addressing mode, the upper 16 bits of linear addresses are
> equal to bit 47. In 57-bit addressing mode (LA57), the upper 7 bits of
> linear addresses are equal to bit 56.
>
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
>  target/i386/monitor.c | 76 +++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
>
> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index a890b3c2ab..99c97a63e2 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -35,21 +35,28 @@
>  #include "sev_i386.h"
>  #include "qapi/qapi-commands-misc.h"
>
> -
> -static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> -                      hwaddr pte, hwaddr mask)
> +/* Perform linear address sign extension */
> +static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
>  {
>  #ifdef TARGET_X86_64
>      if (env->cr[4] & CR4_LA57_MASK) {
>          if (addr & (1ULL << 56)) {
> -            addr |=3D -1LL << 57;
> +            addr |=3D (hwaddr)-(1LL << 57);
>          }
>      } else {
>          if (addr & (1ULL << 47)) {
> -            addr |=3D -1LL << 48;
> +            addr |=3D (hwaddr)-(1LL << 48);
>          }
>      }
>  #endif
> +    return addr;
> +}
> +
> +static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
> +                      hwaddr pte, hwaddr mask)
> +{
> +    addr =3D addr_canonical(env, addr);
> +
>      monitor_printf(mon, TARGET_FMT_plx ": " TARGET_FMT_plx
>                     " %c%c%c%c%c%c%c%c%c\n",
>                     addr,
> @@ -243,8 +250,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
>      }
>  }
>
> -static void mem_print(Monitor *mon, hwaddr *pstart,
> -                      int *plast_prot,
> +static void mem_print(Monitor *mon, CPUArchState *env,
> +                      hwaddr *pstart, int *plast_prot,
>                        hwaddr end, int prot)
>  {
>      int prot1;
> @@ -253,7 +260,9 @@ static void mem_print(Monitor *mon, hwaddr *pstart,
>          if (*pstart !=3D -1) {
>              monitor_printf(mon, TARGET_FMT_plx "-" TARGET_FMT_plx " "
>                             TARGET_FMT_plx " %c%c%c\n",
> -                           *pstart, end, end - *pstart,
> +                           addr_canonical(env, *pstart),
> +                           addr_canonical(env, end),
> +                           addr_canonical(env, end - *pstart),
>                             prot1 & PG_USER_MASK ? 'u' : '-',
>                             'r',
>                             prot1 & PG_RW_MASK ? 'w' : '-');
> @@ -283,7 +292,7 @@ static void mem_info_32(Monitor *mon, CPUArchState
> *env)
>          if (pde & PG_PRESENT_MASK) {
>              if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
>                  prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
> PG_PRESENT_MASK);
> -                mem_print(mon, &start, &last_prot, end, prot);
> +                mem_print(mon, env, &start, &last_prot, end, prot);
>              } else {
>                  for(l2 =3D 0; l2 < 1024; l2++) {
>                      cpu_physical_memory_read((pde & ~0xfff) + l2 * 4,
> &pte, 4);
> @@ -295,16 +304,16 @@ static void mem_info_32(Monitor *mon, CPUArchState
> *env)
>                      } else {
>                          prot =3D 0;
>                      }
> -                    mem_print(mon, &start, &last_prot, end, prot);
> +                    mem_print(mon, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot =3D 0;
> -            mem_print(mon, &start, &last_prot, end, prot);
> +            mem_print(mon, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, 0);
> +    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
>  }
>
>  static void mem_info_pae32(Monitor *mon, CPUArchState *env)
> @@ -332,7 +341,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState
> *env)
>                      if (pde & PG_PSE_MASK) {
>                          prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
>                                        PG_PRESENT_MASK);
> -                        mem_print(mon, &start, &last_prot, end, prot);
> +                        mem_print(mon, env, &start, &last_prot, end,
> prot);
>                      } else {
>                          pt_addr =3D pde & 0x3fffffffff000ULL;
>                          for (l3 =3D 0; l3 < 512; l3++) {
> @@ -345,21 +354,21 @@ static void mem_info_pae32(Monitor *mon,
> CPUArchState *env)
>                              } else {
>                                  prot =3D 0;
>                              }
> -                            mem_print(mon, &start, &last_prot, end, prot=
);
> +                            mem_print(mon, env, &start, &last_prot, end,
> prot);
>                          }
>                      }
>                  } else {
>                      prot =3D 0;
> -                    mem_print(mon, &start, &last_prot, end, prot);
> +                    mem_print(mon, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot =3D 0;
> -            mem_print(mon, &start, &last_prot, end, prot);
> +            mem_print(mon, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, 0);
> +    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
>  }
>
>
> @@ -389,7 +398,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState
> *env)
>                          prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
>                                         PG_PRESENT_MASK);
>                          prot &=3D pml4e;
> -                        mem_print(mon, &start, &last_prot, end, prot);
> +                        mem_print(mon, env, &start, &last_prot, end,
> prot);
>                      } else {
>                          pd_addr =3D pdpe & 0x3fffffffff000ULL;
>                          for (l3 =3D 0; l3 < 512; l3++) {
> @@ -401,7 +410,8 @@ static void mem_info_la48(Monitor *mon, CPUArchState
> *env)
>                                      prot =3D pde & (PG_USER_MASK |
> PG_RW_MASK |
>                                                    PG_PRESENT_MASK);
>                                      prot &=3D pml4e & pdpe;
> -                                    mem_print(mon, &start, &last_prot,
> end, prot);
> +                                    mem_print(mon, env, &start,
> +                                              &last_prot, end, prot);
>                                  } else {
>                                      pt_addr =3D pde & 0x3fffffffff000ULL=
;
>                                      for (l4 =3D 0; l4 < 512; l4++) {
> @@ -418,27 +428,29 @@ static void mem_info_la48(Monitor *mon, CPUArchStat=
e
> *env)
>                                          } else {
>                                              prot =3D 0;
>                                          }
> -                                        mem_print(mon, &start,
> &last_prot, end, prot);
> +                                        mem_print(mon, env, &start,
> +                                                  &last_prot, end, prot)=
;
>                                      }
>                                  }
>                              } else {
>                                  prot =3D 0;
> -                                mem_print(mon, &start, &last_prot, end,
> prot);
> +                                mem_print(mon, env, &start,
> +                                          &last_prot, end, prot);
>                              }
>                          }
>                      }
>                  } else {
>                      prot =3D 0;
> -                    mem_print(mon, &start, &last_prot, end, prot);
> +                    mem_print(mon, env, &start, &last_prot, end, prot);
>                  }
>              }
>          } else {
>              prot =3D 0;
> -            mem_print(mon, &start, &last_prot, end, prot);
> +            mem_print(mon, env, &start, &last_prot, end, prot);
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, &start, &last_prot, (hwaddr)1 << 48, 0);
> +    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
>  }
>
>  static void mem_info_la57(Monitor *mon, CPUArchState *env)
> @@ -457,7 +469,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>          end =3D l0 << 48;
>          if (!(pml5e & PG_PRESENT_MASK)) {
>              prot =3D 0;
> -            mem_print(mon, &start, &last_prot, end, prot);
> +            mem_print(mon, env, &start, &last_prot, end, prot);
>              continue;
>          }
>
> @@ -468,7 +480,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>              end =3D (l0 << 48) + (l1 << 39);
>              if (!(pml4e & PG_PRESENT_MASK)) {
>                  prot =3D 0;
> -                mem_print(mon, &start, &last_prot, end, prot);
> +                mem_print(mon, env, &start, &last_prot, end, prot);
>                  continue;
>              }
>
> @@ -479,7 +491,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>                  end =3D (l0 << 48) + (l1 << 39) + (l2 << 30);
>                  if (pdpe & PG_PRESENT_MASK) {
>                      prot =3D 0;
> -                    mem_print(mon, &start, &last_prot, end, prot);
> +                    mem_print(mon, env, &start, &last_prot, end, prot);
>                      continue;
>                  }
>
> @@ -487,7 +499,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>                      prot =3D pdpe & (PG_USER_MASK | PG_RW_MASK |
>                              PG_PRESENT_MASK);
>                      prot &=3D pml5e & pml4e;
> -                    mem_print(mon, &start, &last_prot, end, prot);
> +                    mem_print(mon, env, &start, &last_prot, end, prot);
>                      continue;
>                  }
>
> @@ -498,7 +510,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>                      end =3D (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 <=
<
> 21);
>                      if (pde & PG_PRESENT_MASK) {
>                          prot =3D 0;
> -                        mem_print(mon, &start, &last_prot, end, prot);
> +                        mem_print(mon, env, &start, &last_prot, end,
> prot);
>                          continue;
>                      }
>
> @@ -506,7 +518,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState
> *env)
>                          prot =3D pde & (PG_USER_MASK | PG_RW_MASK |
>                                  PG_PRESENT_MASK);
>                          prot &=3D pml5e & pml4e & pdpe;
> -                        mem_print(mon, &start, &last_prot, end, prot);
> +                        mem_print(mon, env, &start, &last_prot, end,
> prot);
>                          continue;
>                      }
>
> @@ -523,14 +535,14 @@ static void mem_info_la57(Monitor *mon, CPUArchStat=
e
> *env)
>                          } else {
>                              prot =3D 0;
>                          }
> -                        mem_print(mon, &start, &last_prot, end, prot);
> +                        mem_print(mon, env, &start, &last_prot, end,
> prot);
>                      }
>                  }
>              }
>          }
>      }
>      /* Flush last range */
> -    mem_print(mon, &start, &last_prot, (hwaddr)1 << 57, 0);
> +    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
>  }
>  #endif /* TARGET_X86_64 */
>
> --
> 2.17.1
>
>
=E2=80=8BPing.=E2=80=8B
