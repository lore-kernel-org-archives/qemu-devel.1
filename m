Received: from eggs.gnu.org ([2001:4830:134:3::10]:34033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDFi1-0007N5-SW
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gDFhx-0006p1-OS
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:19:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gDFhx-0006m9-Bg
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:19:53 -0400
References: <20181018162057.19348-1-wainersm@redhat.com>
	<0b3ebfae-e868-daee-31bb-601bd562cc28@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <5e300fc1-8afd-665d-06da-dd7a76c49590@redhat.com>
Date: Thu, 18 Oct 2018 17:19:41 -0400
MIME-Version: 1.0
In-Reply-To: <0b3ebfae-e868-daee-31bb-601bd562cc28@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: add Linux initrd
 checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Cc: ccarrara@redhat.com, ehabkost@redhat.com, lizhijian@cn.fujitsu.com



On 10/18/18 12:44 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 18/10/2018 18:20, Wainer dos Santos Moschetta wrote:
>> QEMU used to exits with a not accurate error message when
>> an initrd >=3D 2GB was passed. That was fixed on patch:
>>
>> 	commit f3839fda5771596152b75dd1e1a6d050e6e6e380
>> 	Author: Li Zhijian <lizhijian@cn.fujitsu.com>
>> 	Date:   Thu Sep 13 18:07:13 2018 +0800
>>
>>     	change get_image_size return type to int64_t
>>
>> This change adds a regression test for that fix. It starts
>> QEMU with a 2GB dummy initrd, and check it evaluates the file
>> size correctly and prints accurate message.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>>  tests/acceptance/linux_initrd.py | 47 +++++++++++++++++++++++++++++++=
+
>>  1 file changed, 47 insertions(+)
>>  create mode 100644 tests/acceptance/linux_initrd.py
>>
>> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux=
_initrd.py
>> new file mode 100644
>> index 0000000000..7d9e5862cd
>> --- /dev/null
>> +++ b/tests/acceptance/linux_initrd.py
>> @@ -0,0 +1,47 @@
>> +# Linux initrd acceptance test.
>> +#
>> +# Copyright (c) 2018 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Wainer dos Santos Moschetta <wainersm@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import tempfile
>> +
>> +from avocado_qemu import Test
>> +from avocado.utils.process import run
>> +
>> +
>> +class LinuxInitrd(Test):
>> +    """
>> +    Checks QEMU evaluates correctly the initrd file passed as -initrd=
 option.
>> +
>> +    :avocado: enable
>> +    :avocado: tags=3Dx86_64
>=20
> I'll let Cleber check if he wants we use 'tags=3Darch:x86_64' here.
>=20

Yes, I have no objections.  Like I said elsewhere, most good standards
are born like this.

- Cleber.

> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>=20
>> +    """
>> +
>> +    timeout =3D 60
>> +
>> +    def test_with_2GB_file_should_exit_error_msg(self):
>> +        """
>> +        Pretends to boot QEMU with an initrd file with size of 2GB
>> +        and expect it exits with error message.
>> +        Regression test for bug fixed on commit f3839fda5771596152.
>> +        """
>> +        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/2=
8/'
>> +                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
>> +        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
>> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
>> +
>> +        with tempfile.NamedTemporaryFile() as initrd:
>> +            initrd.seek(2048*(1024**2) -1)
>> +            initrd.write(b'\0')
>> +            initrd.flush()
>> +            cmd =3D "%s -kernel %s -initrd %s" % (self.qemu_bin, kern=
el_path,
>> +                                                initrd.name)
>> +            res =3D run(cmd, ignore_status=3DTrue)
>> +            self.assertNotEqual(res.exit_status, 0)
>> +            expected_msg =3D r'.*initrd is too large.*max: \d+, need =
\d+.*'
>> +            self.assertRegex(res.stderr_text, expected_msg)
>>

--=20
Cleber Rosa
[ Sr Software Engineer - Virtualization Team - Red Hat ]
[ Avocado Test Framework - avocado-framework.github.io ]
[  7ABB 96EB 8B46 B94D 5E0F  E9BB 657E 8D33 A5F2 09F3  ]
