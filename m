Received: from eggs.gnu.org ([2001:4830:134:3::10]:54998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxcsu-0001VR-1E
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:13:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cxcss-00076a-MX
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:13:48 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Apr 2017 18:13:30 +0100
Message-Id: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/9] arm: Implement M profile exception
 return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On M profile, return from exceptions happen when code in Handler mode
executes one of the following function call return instructions:
     * POP or LDM which loads the PC
     * LDR to PC
     * BX register
and the new PC value is 0xFFxxxxxx.
    
QEMU tries to implement this by not treating the instruction
specially but then catching the attempt to execute from the magic
address value.  This is not ideal, because:
 * there are guest visible differences from the architecturally
   specified behaviour (for instance jumping to 0xFFxxxxxx via a
   different instruction should not cause an exception return but it
   will in the QEMU implementation)
 * we have to account for it in various places (like refusing to take
   an interrupt if the PC is at a magic value, and making sure that
   the MPU doesn't deny execution at the magic value addresses)
    
Drop these hacks, and instead implement exception return the way the
architecture specifies -- by having the relevant instructions check
for the magic value and raise the 'do an exception return' QEMU
internal exception immediately.

I realised when I was looking at the MPU patches that the current
mechanism was a bit awkward and needed still more workarounds in
code that really shouldn't have to care about exception-return.
And it turns out that implementing it properly doesn't actually
have very much runtime cost at all.

NB: this is technically speaking a migration compatibility break,
if you were unlucky enough to migrate just after an exception
return when the PC value was one of the magic values, since the
new QEMU will not treat this as "now do exception return".
However we don't guarantee migration compatibility for M profile,
so that's OK.
    
The effect on the generated code is minor:
    
     bx lr, old code (and new code for Thread mode):
      TCG:
       mov_i32 tmp5,r14
       movi_i32 tmp6,$0xfffffffffffffffe
       and_i32 pc,tmp5,tmp6
       movi_i32 tmp6,$0x1
       and_i32 tmp5,tmp5,tmp6
       st_i32 tmp5,env,$0x218
       exit_tb $0x0
      x86_64 generated code:
       0x7f2aabe87019:  mov    %ebx,%ebp
       0x7f2aabe8701b:  and    $0xfffffffffffffffe,%ebp
       0x7f2aabe8701e:  mov    %ebp,0x3c(%r14)
       0x7f2aabe87022:  and    $0x1,%ebx
       0x7f2aabe87025:  mov    %ebx,0x218(%r14)
       0x7f2aabe8702c:  xor    %eax,%eax
       0x7f2aabe8702e:  jmpq   0x7f2aabe7c016
    
     bx lr, new code when in Handler mode:
      TCG:
       mov_i32 tmp5,r14
       movi_i32 tmp6,$0xfffffffffffffffe
       and_i32 pc,tmp5,tmp6
       movi_i32 tmp6,$0x1
       and_i32 tmp5,tmp5,tmp6
       st_i32 tmp5,env,$0x218
       movi_i32 tmp5,$0xffffffffff000000
       brcond_i32 pc,tmp5,geu,$L1
       exit_tb $0x0
       set_label $L1
       movi_i32 tmp5,$0x8
       call exception_internal,$0x0,$0,env,tmp5
      x86_64 generated code:
       0x7fe8fa1264e3:  mov    %ebp,%ebx
       0x7fe8fa1264e5:  and    $0xfffffffffffffffe,%ebx
       0x7fe8fa1264e8:  mov    %ebx,0x3c(%r14)
       0x7fe8fa1264ec:  and    $0x1,%ebp
       0x7fe8fa1264ef:  mov    %ebp,0x218(%r14)
       0x7fe8fa1264f6:  cmp    $0xff000000,%ebx
       0x7fe8fa1264fc:  jae    0x7fe8fa126509
       0x7fe8fa126502:  xor    %eax,%eax
       0x7fe8fa126504:  jmpq   0x7fe8fa122016
       0x7fe8fa126509:  mov    %r14,%rdi
       0x7fe8fa12650c:  mov    $0x8,%esi
       0x7fe8fa126511:  mov    $0x56095dbeccf5,%r10
       0x7fe8fa12651b:  callq  *%r10
    
which is a difference of one cmp/branch-not-taken. This will
be lost in the noise of having to exit generated code and
look up the next TB anyway.
    
Patches 1 and 2 are minor bug fixes which remove code paths that
incorrectly called gen_bx(), so we don't have to consider them when
looking at which gen_bx() calls need to be changed to call
gen_bx_excret().  Patches 3 to 6 are minor preliminary refactorings;
patch 7 adds the 'in handler mode' bit to the TB flags; patch 8
is the meat of the series; finally patch 9 removes the old mechanism.

Changes v1->v2:
 * Abstract out "are we singlestepping" test to utility function
   (new patch 6)
 * track Handler state in TB flags and use it to determine when
   to allow exception-return, not the incorrect IS_USER test I had
   in v1
 * add a brief comment about bx vs blx in patch 8

thanks
-- PMM

Peter Maydell (9):
  arm: Don't implement BXJ on M-profile CPUs
  arm: Thumb shift operations should not permit interworking branches
  arm: Factor out "generate right kind of step exception"
  arm: Move gen_set_condexec() and gen_set_pc_im() up in the file
  arm: Move condition-failed codepath generation out of if()
  arm: Abstract out "are we singlestepping" test to utility function
  arm: Track M profile handler mode state in TB flags
  arm: Implement M profile exception return properly
  arm: Remove workarounds for old M-profile exception return
    implementation

 target/arm/cpu.h       |   9 +++
 target/arm/translate.h |   5 ++
 target/arm/cpu.c       |  43 +-----------
 target/arm/translate.c | 181 +++++++++++++++++++++++++++++++++----------------
 4 files changed, 138 insertions(+), 100 deletions(-)

-- 
2.7.4
