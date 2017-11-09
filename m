Received: from eggs.gnu.org ([2001:4830:134:3::10]:51758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCjST-000459-Rs
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eCjSP-0004ZH-Tb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:49:13 -0500
References: <20171108032052.20029-1-f4bug@amsat.org>
	<20171109063931.GE13786@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d0048bf1-671a-fad5-0931-4c52fea484e3@redhat.com>
Date: Thu, 9 Nov 2017 10:48:55 +0100
MIME-Version: 1.0
In-Reply-To: <20171109063931.GE13786@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 09/11/2017 07:40, Fam Zheng wrote:
> On Wed, 11/08 00:20, Philippe Mathieu-Daud=C3=A9 wrote:
>> Using obscure black magic introduced in eaa2ddbb767 :)
>=20
> That is a pretty boring one compared to the rest of our build system.
>=20
>>
>> In an out-of-tree directory, running "../configure && make help" will =
generate
>> some required files (.mak), then clone some submodules, compile at lea=
st
>> the capstone submodule, generate QMP and Trace files, and finally disp=
lay
>> the help.
>>
>> On an outdated computer (Sun Blade workstation), running "make help" t=
ook
>> more than 5h :) With this patch it took roughly 37min.
>>
>> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>
>> before:
>>
>> $ make help
>>   GEN     config-host.h
>>   CC      cs.o
>>   CC      utils.o
>>   CC      SStream.o
>>   CC      MCInstrDesc.o
>>   CC      MCRegisterInfo.o
>>   CC      arch/ARM/ARMDisassembler.o
>>   CC      arch/ARM/ARMInstPrinter.o
>>   CC      arch/ARM/ARMMapping.o
>>   CC      arch/ARM/ARMModule.o
>>   CC      arch/AArch64/AArch64BaseInfo.o
>>   CC      arch/AArch64/AArch64Disassembler.o
>>   CC      arch/AArch64/AArch64InstPrinter.o
>>   CC      arch/AArch64/AArch64Mapping.o
>>   CC      arch/AArch64/AArch64Module.o
>>   CC      arch/Mips/MipsDisassembler.o
>>   CC      arch/Mips/MipsInstPrinter.o
>>   CC      arch/Mips/MipsMapping.o
>>   CC      arch/Mips/MipsModule.o
>>   CC      arch/PowerPC/PPCDisassembler.o
>>   CC      arch/PowerPC/PPCInstPrinter.o
>>   CC      arch/PowerPC/PPCMapping.o
>>   CC      arch/PowerPC/PPCModule.o
>>   CC      arch/Sparc/SparcDisassembler.o
>>   CC      arch/Sparc/SparcInstPrinter.o
>>   CC      arch/Sparc/SparcMapping.o
>>   CC      arch/Sparc/SparcModule.o
>>   CC      arch/SystemZ/SystemZDisassembler.o
>>   CC      arch/SystemZ/SystemZInstPrinter.o
>>   CC      arch/SystemZ/SystemZMapping.o
>>   CC      arch/SystemZ/SystemZModule.o
>>   CC      arch/SystemZ/SystemZMCTargetDesc.o
>>   CC      arch/X86/X86DisassemblerDecoder.o
>>   CC      arch/X86/X86Disassembler.o
>>   CC      arch/X86/X86IntelInstPrinter.o
>>   CC      arch/X86/X86ATTInstPrinter.o
>>   CC      arch/X86/X86Mapping.o
>>   CC      arch/X86/X86Module.o
>>   CC      arch/XCore/XCoreDisassembler.o
>>   CC      arch/XCore/XCoreInstPrinter.o
>>   CC      arch/XCore/XCoreMapping.o
>>   CC      arch/XCore/XCoreModule.o
>>   CC      MCInst.o
>>   AR      libcapstone.a
>> ar: creating capstone/libcapstone.a
>>   GEN     trace/generated-tcg-tracers.h
>>   GEN     trace/generated-helpers-wrappers.h
>>   GEN     trace/generated-helpers.h
>>   GEN     trace/generated-helpers.c
>>   GEN     module_block.h
>> make[1]: 'capstone/libcapstone.a' is up to date.
>> Generic targets:
>>   all             - Build all
>>   dir/file.o      - Build specified target only
>>   install         - Install QEMU, documentation and tools
>>   ctags/TAGS      - Generate tags file for editors
>>   cscope          - Generate cscope index
>> [...]
>>
>> after:
>>
>> $ make help
>> Generic targets:
>>   all             - Build all
>>   dir/file.o      - Build specified target only
>>   install         - Install QEMU, documentation and tools
>>   ctags/TAGS      - Generate tags file for editors
>>   cscope          - Generate cscope index
>> [...]
>>
>>  Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 0496c5057a..7850ca5928 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -6,7 +6,7 @@ BUILD_DIR=3D$(CURDIR)
>>  # Before including a proper config-host.mak, assume we are in the sou=
rce tree
>>  SRC_PATH=3D.
>> =20
>> -UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-%
>> +UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
>> =20
>>  # All following code might depend on configuration variables
>>  ifneq ($(wildcard config-host.mak),)
>> --=20
>> 2.15.0
>>
>>
>=20
> I think there are more targets that can be added to this list (vm-test =
for one)
> but this is already an improvement:
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
>=20
> So who is the maintainer to merge this patch?

I can do it.

Paolo
