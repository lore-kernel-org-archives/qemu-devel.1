Received: from eggs.gnu.org ([209.51.188.92]:44618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gromG-0003Et-1h
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:52:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gromE-0002oq-VJ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:51:59 -0500
References: <20190205001835.25660-1-philmd@redhat.com>
	<20190205001835.25660-2-philmd@redhat.com>
	<99509706-b027-bf45-b17b-e9f66943f86c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <adf3d864-936d-d53d-ce26-1a5c75e88264@redhat.com>
Date: Thu, 7 Feb 2019 19:51:53 +0100
MIME-Version: 1.0
In-Reply-To: <99509706-b027-bf45-b17b-e9f66943f86c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/8] ahci-test: Add dependency to
 qemu-img tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

On 2019-02-07 17:50, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/5/19 1:18 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since the ahci-test uses qemu-img, add a dependency to build it
>> before using it.
>> This fixes:
>>
>>   $ gmake check-qtest V=3D1
>>   QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=
=3Dqemu-img tests/ahci-test
>>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No=
 such file or directory)
>>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !er=
r)
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Slighly related is when vm-tests expect qemu-img available:
>> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg08415.html
>>
>>   $ make vm-build-ubuntu.i386
>>   Traceback (most recent call last):
>>     File "source/qemu/tests/vm/basevm.py", line 236, in main
>>       return vm.build_image(args.image)
>>     File "tests/vm/ubuntu.i386", line 67, in build_image
>>       subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
>>   OSError: [Errno 2] No such file or directory
>>   tests/vm/Makefile.include:23: recipe for target 'tests/vm/ubuntu.i38=
6.img' failed
>>   make: *** [tests/vm/ubuntu.i386.img] Error 2
>>
>> A better fix would be checking those tools via ./configure...
>> ---
>>  tests/Makefile.include | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 75ad9c0dd3..679656b64a 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -708,7 +708,7 @@ tests/prom-env-test$(EXESUF): tests/prom-env-test.=
o $(libqos-obj-y)
>>  tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
>>  tests/fdc-test$(EXESUF): tests/fdc-test.o
>>  tests/ide-test$(EXESUF): tests/ide-test.o $(libqos-pc-obj-y)
>> -tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y)
>> +tests/ahci-test$(EXESUF): tests/ahci-test.o $(libqos-pc-obj-y) qemu-i=
mg$(EXESUF)
>=20
> In [*] Cleber noticed if we configure using --disable-tools, qemu-img i=
s
> still built by when running "make check-block" due to this rule.
>=20
> I think this is OK because
> - at least a test requires it, so this test will run (which is what
>   we want)
> - while the tool is available in the build directory, it still won't
>   be installed by "make install"

I guess you could also introduce a CONFIG_TOOLS switch and only run the
ahci test for CONFIG_TOOLS=3Dy ? ... not that important, but in case you
respin the series, maybe worth a try.

 Thomas
