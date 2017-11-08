Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCGvL-00040D-7X
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCGvG-00076B-9Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:21:07 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  8 Nov 2017 00:20:52 -0300
Message-Id: <20171108032052.20029-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] Makefile: simpler/faster "make help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Using obscure black magic introduced in eaa2ddbb767 :)

In an out-of-tree directory, running "../configure && make help" will generate
some required files (.mak), then clone some submodules, compile at least
the capstone submodule, generate QMP and Trace files, and finally display
the help.

On an outdated computer (Sun Blade workstation), running "make help" took
more than 5h :) With this patch it took roughly 37min.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

before:

$ make help
  GEN     config-host.h
  CC      cs.o
  CC      utils.o
  CC      SStream.o
  CC      MCInstrDesc.o
  CC      MCRegisterInfo.o
  CC      arch/ARM/ARMDisassembler.o
  CC      arch/ARM/ARMInstPrinter.o
  CC      arch/ARM/ARMMapping.o
  CC      arch/ARM/ARMModule.o
  CC      arch/AArch64/AArch64BaseInfo.o
  CC      arch/AArch64/AArch64Disassembler.o
  CC      arch/AArch64/AArch64InstPrinter.o
  CC      arch/AArch64/AArch64Mapping.o
  CC      arch/AArch64/AArch64Module.o
  CC      arch/Mips/MipsDisassembler.o
  CC      arch/Mips/MipsInstPrinter.o
  CC      arch/Mips/MipsMapping.o
  CC      arch/Mips/MipsModule.o
  CC      arch/PowerPC/PPCDisassembler.o
  CC      arch/PowerPC/PPCInstPrinter.o
  CC      arch/PowerPC/PPCMapping.o
  CC      arch/PowerPC/PPCModule.o
  CC      arch/Sparc/SparcDisassembler.o
  CC      arch/Sparc/SparcInstPrinter.o
  CC      arch/Sparc/SparcMapping.o
  CC      arch/Sparc/SparcModule.o
  CC      arch/SystemZ/SystemZDisassembler.o
  CC      arch/SystemZ/SystemZInstPrinter.o
  CC      arch/SystemZ/SystemZMapping.o
  CC      arch/SystemZ/SystemZModule.o
  CC      arch/SystemZ/SystemZMCTargetDesc.o
  CC      arch/X86/X86DisassemblerDecoder.o
  CC      arch/X86/X86Disassembler.o
  CC      arch/X86/X86IntelInstPrinter.o
  CC      arch/X86/X86ATTInstPrinter.o
  CC      arch/X86/X86Mapping.o
  CC      arch/X86/X86Module.o
  CC      arch/XCore/XCoreDisassembler.o
  CC      arch/XCore/XCoreInstPrinter.o
  CC      arch/XCore/XCoreMapping.o
  CC      arch/XCore/XCoreModule.o
  CC      MCInst.o
  AR      libcapstone.a
ar: creating capstone/libcapstone.a
  GEN     trace/generated-tcg-tracers.h
  GEN     trace/generated-helpers-wrappers.h
  GEN     trace/generated-helpers.h
  GEN     trace/generated-helpers.c
  GEN     module_block.h
make[1]: 'capstone/libcapstone.a' is up to date.
Generic targets:
  all             - Build all
  dir/file.o      - Build specified target only
  install         - Install QEMU, documentation and tools
  ctags/TAGS      - Generate tags file for editors
  cscope          - Generate cscope index
[...]

after:

$ make help
Generic targets:
  all             - Build all
  dir/file.o      - Build specified target only
  install         - Install QEMU, documentation and tools
  ctags/TAGS      - Generate tags file for editors
  cscope          - Generate cscope index
[...]

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0496c5057a..7850ca5928 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ BUILD_DIR=$(CURDIR)
 # Before including a proper config-host.mak, assume we are in the source tree
 SRC_PATH=.
 
-UNCHECKED_GOALS := %clean TAGS cscope ctags docker docker-%
+UNCHECKED_GOALS := %clean TAGS cscope ctags docker docker-% help
 
 # All following code might depend on configuration variables
 ifneq ($(wildcard config-host.mak),)
-- 
2.15.0
