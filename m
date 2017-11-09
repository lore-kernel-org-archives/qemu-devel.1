Received: from eggs.gnu.org ([2001:4830:134:3::10]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCgW8-00029V-FJ
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCgW4-0006kG-HX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 01:40:48 -0500
Date: Thu, 9 Nov 2017 14:40:38 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171109063931.GE13786@lemon>
References: <20171108032052.20029-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171108032052.20029-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: simpler/faster "make help"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 11/08 00:20, Philippe Mathieu-Daud=E9 wrote:
> Using obscure black magic introduced in eaa2ddbb767 :)

That is a pretty boring one compared to the rest of our build system.

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
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
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
> --=20
> 2.15.0
>=20
>=20

I think there are more targets that can be added to this list (vm-test fo=
r one)
but this is already an improvement:

Reviewed-by: Fam Zheng <famz@redhat.com>

So who is the maintainer to merge this patch?

Fam
