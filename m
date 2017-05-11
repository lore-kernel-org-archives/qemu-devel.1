Received: from eggs.gnu.org ([2001:4830:134:3::10]:34253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8q5F-0006Lp-MU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8q5E-0001WR-R5
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8q5E-0001UZ-I9
	for qemu-devel@nongnu.org; Thu, 11 May 2017 11:32:52 -0400
References: <1494502528-12670-1-git-send-email-pbonzini@redhat.com>
	<20170511145312.GA822@morn.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <618febcf-af6d-5fc6-0274-4f64c53f9763@redhat.com>
Date: Thu, 11 May 2017 17:32:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170511145312.GA822@morn.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/i386: enable A20 automatically in
 system management mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin O'Connor <kevin@koconnor.net>
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com



On 11/05/2017 16:53, Kevin O'Connor wrote:
> On Thu, May 11, 2017 at 01:35:28PM +0200, Paolo Bonzini wrote:
>> Ignore env->a20_mask when running in system management mode.
>=20
> Thanks Paolo.  I don't think this patch will help SeaBIOS though.  The
> SeaBIOS SMM handler doesn't do much - it doesn't even access ram above
> 1MiB.  See SeaBIOS' code in src/fw/smm.c:handle_smi().
>=20
> Instead, the SeaBIOS code does a cpu state backup/restore to switch
> into 32bit mode.  I thought the A20 state would be part of that cpu
> backup/restore.  However, looking at the Intel SDM docs now, it's not
> really clear to me how the processor "inhibits" A20 when in SMM mode -
> does it save/restore that state on SMI/RSM or does it have special
> logic to ignore A20 while in SMM mode?

There isn't any documented place for A20 in the state save map (I checked
AMD's BIOS/Kernel Developer Guide which is pretty comprehensive), so I
think the latter is more plausible.  What I'm doing in this patch is
ignoring A20 while in SMM mode.

Then you would have to add an A20 save/restore in handle_smi; since=20
CALL32SMM_ENTERID should not nest, I think you can just do this:

diff --git a/src/fw/smm.c b/src/fw/smm.c
index 95f6ba7..711dae3 100644
--- a/src/fw/smm.c
+++ b/src/fw/smm.c
@@ -54,7 +54,8 @@ struct smm_layout {
     struct smm_state backup2;
     u8 stack[0x7c00];
     u64 codeentry;
-    u8 pad_8008[0x7df8];
+    u8 a20;
+    u8 pad_8009[0x7df7];
     struct smm_state cpu;
 };
=20
@@ -102,10 +103,13 @@ handle_smi(u16 cs)
                 memcpy(&smm->cpu, &smm->backup1, sizeof(smm->cpu));
                 memcpy(&smm->cpu.i32.eax, regs, sizeof(regs));
                 smm->cpu.i32.eip =3D regs[3];
+                // Enable a20 and backup its previous state
+                smm->a20 =3D set_a20(1);
             } else if (smm->cpu.i32.ecx =3D=3D CALL32SMM_RETURNID) {
                 dprintf(9, "smm cpu ret %x esp=3D%x\n", regs[3], regs[4]=
);
                 memcpy(&smm->cpu, &smm->backup2, sizeof(smm->cpu));
                 memcpy(&smm->cpu.i32.eax, regs, sizeof(regs));
+                set_a20(smm->a20);
                 smm->cpu.i32.eip =3D regs[3];
             }
         } else if (rev =3D=3D SMM_REV_I64) {


Paolo
