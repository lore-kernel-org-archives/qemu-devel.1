Received: from eggs.gnu.org ([209.51.188.92]:34457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gotRi-0006nC-UU
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:14:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gotRh-0005OY-DN
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:14:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gotRh-0005Ms-4Z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 12:14:41 -0500
References: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <9b791496-fa11-a3e2-4dc4-1254da6589ba@redhat.com>
Date: Wed, 30 Jan 2019 15:14:23 -0200
MIME-Version: 1.0
In-Reply-To: <1548638112-31101-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Acceptance tests: use linux-3.6 and
 set vm memory to 4GiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>



On 01/27/2019 11:15 PM, Li Zhijian wrote:
> QEMU have already supported to load up to 4G initrd if the sepcified me=
mory is
> enough and XLF_CAN_BE_LOADED_ABOVE_4G is set by guest kernel
>
> linux-3.6 kernel shipped by Fedora-18 cannot support xldflags so that i=
t
> cannot support loading more than 2GiB initrd
>
> CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
> CC: Caio Carrara <ccarrara@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> V2: fix typos
> ---
>   tests/acceptance/linux_initrd.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

Note to maintainers: the patch 02 implements a test case for=20
https://www.mail-archive.com/qemu-devel@nongnu.org/msg588166.html which=20
is in Paolo's queue already.

- Wainer


>
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_=
initrd.py
> index 737355c..b283715 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -24,14 +24,16 @@ class LinuxInitrd(Test):
>  =20
>       timeout =3D 60
>  =20
> -    def test_with_2gib_file_should_exit_error_msg(self):
> +    def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self=
):
>           """
>           Pretends to boot QEMU with an initrd file with size of 2GiB
>           and expect it exits with error message.
> +        Fedora-18 shipped with linux-3.6 which have not supported xloa=
dflags
> +        cannot support more than 2GiB initrd.
>           """
> -        kernel_url =3D ('https://mirrors.kernel.org/fedora/releases/28=
/'
> -                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> -        kernel_hash =3D '238e083e114c48200f80d889f7e32eeb2793e02a'
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archiv=
e/fedora/li'
> +                      'nux/releases/18/Fedora/x86_64/os/images/pxeboot=
/vmlinuz')
> +        kernel_hash =3D '41464f68efe42b9991250bed86c7081d2ccdbb21'
>           kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
>           max_size =3D 2 * (1024 ** 3) - 1
>  =20
> @@ -39,8 +41,8 @@ class LinuxInitrd(Test):
>               initrd.seek(max_size)
>               initrd.write(b'\0')
>               initrd.flush()
> -            cmd =3D "%s -kernel %s -initrd %s" % (self.qemu_bin, kerne=
l_path,
> -                                                initrd.name)
> +            cmd =3D "%s -kernel %s -initrd %s -m 4096" % (
> +                  self.qemu_bin, kernel_path, initrd.name)
>               res =3D run(cmd, ignore_status=3DTrue)
>               self.assertEqual(res.exit_status, 1)
>               expected_msg =3D r'.*initrd is too large.*max: \d+, need =
%s.*' % (
