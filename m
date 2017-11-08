Received: from eggs.gnu.org ([2001:4830:134:3::10]:53431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eCNyP-0002t4-Sp
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:52:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eCNyL-0007XJ-0m
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 05:52:45 -0500
References: <20171108032052.20029-1-f4bug@amsat.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <c8ed664e-26ec-efb1-1b61-70d016bee400@redhat.com>
Date: Wed, 8 Nov 2017 11:52:30 +0100
MIME-Version: 1.0
In-Reply-To: <20171108032052.20029-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] Makefile: simpler/faster
 "make help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 08/11/2017 04:20, Philippe Mathieu-Daud=C3=A9 wrote:
> Using obscure black magic introduced in eaa2ddbb767 :)
>=20
> In an out-of-tree directory, running "../configure && make help" will g=
enerate
> some required files (.mak), then clone some submodules, compile at leas=
t
> the capstone submodule, generate QMP and Trace files, and finally displ=
ay
> the help.
>=20
> On an outdated computer (Sun Blade workstation), running "make help" to=
ok
> more than 5h :) With this patch it took roughly 37min.
>=20
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>=20
> before:
>=20
> $ make help
>   GEN     config-host.h
>   CC      cs.o
>   CC      utils.o
>   CC      SStream.o
>   CC      MCInstrDesc.o
>   CC      MCRegisterInfo.o
>   CC      arch/ARM/ARMDisassembler.o
>   CC      arch/ARM/ARMInstPrinter.o
>   CC      arch/ARM/ARMMapping.o
>   CC      arch/ARM/ARMModule.o
>   CC      arch/AArch64/AArch64BaseInfo.o
>   CC      arch/AArch64/AArch64Disassembler.o
>   CC      arch/AArch64/AArch64InstPrinter.o
>   CC      arch/AArch64/AArch64Mapping.o
>   CC      arch/AArch64/AArch64Module.o
>   CC      arch/Mips/MipsDisassembler.o
>   CC      arch/Mips/MipsInstPrinter.o
>   CC      arch/Mips/MipsMapping.o
>   CC      arch/Mips/MipsModule.o
>   CC      arch/PowerPC/PPCDisassembler.o
>   CC      arch/PowerPC/PPCInstPrinter.o
>   CC      arch/PowerPC/PPCMapping.o
>   CC      arch/PowerPC/PPCModule.o
>   CC      arch/Sparc/SparcDisassembler.o
>   CC      arch/Sparc/SparcInstPrinter.o
>   CC      arch/Sparc/SparcMapping.o
>   CC      arch/Sparc/SparcModule.o
>   CC      arch/SystemZ/SystemZDisassembler.o
>   CC      arch/SystemZ/SystemZInstPrinter.o
>   CC      arch/SystemZ/SystemZMapping.o
>   CC      arch/SystemZ/SystemZModule.o
>   CC      arch/SystemZ/SystemZMCTargetDesc.o
>   CC      arch/X86/X86DisassemblerDecoder.o
>   CC      arch/X86/X86Disassembler.o
>   CC      arch/X86/X86IntelInstPrinter.o
>   CC      arch/X86/X86ATTInstPrinter.o
>   CC      arch/X86/X86Mapping.o
>   CC      arch/X86/X86Module.o
>   CC      arch/XCore/XCoreDisassembler.o
>   CC      arch/XCore/XCoreInstPrinter.o
>   CC      arch/XCore/XCoreMapping.o
>   CC      arch/XCore/XCoreModule.o
>   CC      MCInst.o
>   AR      libcapstone.a
> ar: creating capstone/libcapstone.a
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     trace/generated-helpers.c
>   GEN     module_block.h
> make[1]: 'capstone/libcapstone.a' is up to date.
> Generic targets:
>   all             - Build all
>   dir/file.o      - Build specified target only
>   install         - Install QEMU, documentation and tools
>   ctags/TAGS      - Generate tags file for editors
>   cscope          - Generate cscope index
> [...]
>=20
> after:
>=20
> $ make help
> Generic targets:
>   all             - Build all
>   dir/file.o      - Build specified target only
>   install         - Install QEMU, documentation and tools
>   ctags/TAGS      - Generate tags file for editors
>   cscope          - Generate cscope index
> [...]
>=20
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index 0496c5057a..7850ca5928 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -6,7 +6,7 @@ BUILD_DIR=3D$(CURDIR)
>  # Before including a proper config-host.mak, assume we are in the sour=
ce tree
>  SRC_PATH=3D.
> =20
> -UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-%
> +UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
> =20
>  # All following code might depend on configuration variables
>  ifneq ($(wildcard config-host.mak),)
>=20

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
