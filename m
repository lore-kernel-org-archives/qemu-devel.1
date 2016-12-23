Received: from eggs.gnu.org ([2001:4830:134:3::10]:53934)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<373tdWAMKCiYFLGIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--dje.bounces.google.com>)
	id 1cKVaV-0002NN-E5
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<373tdWAMKCiYFLGIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--dje.bounces.google.com>)
	id 1cKVaU-0005Bv-Hh
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:33:07 -0500
Received: from mail-pg0-x24a.google.com ([2607:f8b0:400e:c05::24a]:33726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<373tdWAMKCiYFLGIQQING.EQOSGOW-FGXGNPQPIPW.QTI@flex--dje.bounces.google.com>)
	id 1cKVaU-0005B9-B1
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 14:33:06 -0500
Received: by mail-pg0-x24a.google.com with SMTP id o123so4902334pga.0
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 11:33:04 -0800 (PST)
MIME-Version: 1.0
Message-ID: <f403045e2f8a5b916c0544587499@google.com>
Date: Fri, 23 Dec 2016 19:33:03 +0000
From: Doug Evans <dje@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Subject: Re: [Qemu-devel] [PULL 24/25] target-i386: Fix eflags.TF/#DB
 handling of syscall/sysret insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini writes:
  > From: Doug Evans <dje@google.com>
  >
  > The syscall and sysret instructions behave a bit differently:
  > TF is checked after the instruction completes.
  > This allows the o/s to disable #DB at a syscall by adding TF to FMASK.
  > And then when the sysret is executed the #DB is taken "as if" the
  > syscall insn just completed.
  >
  > Signed-off-by: Doug Evans <dje@google.com>
  > Message-Id: <94eb2c0bfa1c6a9fec0543057483@google.com>
  > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
  > ---
  >  target/i386/bpt_helper.c |  7 +++++++
  >  target/i386/helper.h     |  1 +
  >  target/i386/translate.c  | 29 ++++++++++++++++++++++++-----
  >  3 files changed, 32 insertions(+), 5 deletions(-)
  >
  > ...
  > diff --git a/target/i386/translate.c b/target/i386/translate.c
  > index 324103c..59e11fc 100644
  > --- a/target/i386/translate.c
  > +++ b/target/i386/translate.c
  > @@ -6423,7 +6435,10 @@ static target_ulong disas_insn(CPUX86State *env,  
DisasContext *s,
  >                                        tcg_const_i32(s->pc -  
s->cs_base));
  >              set_cc_op(s, CC_OP_EFLAGS);
  >          }
  > -        gen_eob(s);
  > +        /* TF handling for the syscall insn is different. The TF bit is  
checked
  > +           after the syscall insn completes. This allows #DB to not be
  > +           generated after one has entered CPL0 if TF is set in FMASK.   
*/
  > +        gen_eob_worker(s, false, true);
  >          break;
  >      case 0xe8: /* call im */
  >          {
  > @@ -7115,7 +7130,11 @@ static target_ulong disas_insn(CPUX86State *env,  
DisasContext *s,
  >              if (s->lma) {
  >                  set_cc_op(s, CC_OP_EFLAGS);
  >              }
  > -            gen_eob(s);
  > +            /* TF handling for the sysret insn is different. The TF bit  
is
  > +               checked after the sysret insn completes. This allows #DB  
to be
  > +               generated "as if" the syscall insn in userspace has just
  > +               completed.  */
  > +            gen_eob_worker(s, false, true);
  >          }
  >          break;
  >  #endif

Hi. Just a heads up that this patch got applied wrong (patch does that some  
times).

The change to the "syscall" insn got applied to the "iret" instruction  
instead.

Working on a fix.
