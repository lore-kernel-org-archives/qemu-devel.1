Received: from eggs.gnu.org ([209.51.188.92]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqogV-00066l-AG
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:33:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqogU-0007sB-3R
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 19:33:55 -0500
References: <20190205001835.25660-1-philmd@redhat.com>
	<20190205001835.25660-9-philmd@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e68526b0-be93-ff63-8bda-bb2f3420e14e@redhat.com>
Date: Mon, 4 Feb 2019 19:33:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190205001835.25660-9-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] RFC iotests: Disable 236 and 238 on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Brad Smith <brad@comstyle.com>



On 2/4/19 7:18 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> These tests explode on OpenBSD:
>=20
>   $ gmake check-block
>   [...]
>   238                [17:16:09] [17:16:09] [failed, exit status 1] - ou=
tput mismatch (see 238.out.bad)
>   --- /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out    Tue Jan 29 17=
:09:03 2019
>   +++ /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out.bad        Tue J=
an 29 17:16:09 2019
>   @@ -1,6 +1,14 @@
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   +Traceback (most recent call last):
>   +  File "238", line 37, in <module>
>   +    vm.launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 295, in launch
>   +    self._launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 321, in _launch
>   +    self._post_launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 266, in _post_launch
>   +    self._qmp.accept()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/q=
mp.py", line 157, in accept
>   +    return self.__negotiate_capabilities()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/q=
mp.py", line 73, in __negotiate_capabilities
>   +    raise QMPConnectError
>   +qmp.qmp.QMPConnectError
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This might be due to these tests requiring KVM?...
> Maybe we need a has_kvm argument to iotests.verify_platform()?

Uhhh, 236 shouldn't be doing anything fancy. It does boot a VM, but so
does 237, 222, 219, 218, 216, ...

I actually don't know what this would be failing. Any chance to look at
the core dump QEMU is leaving behind?

> ---
>  tests/qemu-iotests/236 | 1 +
>  tests/qemu-iotests/238 | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
> index 79a6381f8e..b98df35ca4 100755
> --- a/tests/qemu-iotests/236
> +++ b/tests/qemu-iotests/236
> @@ -23,6 +23,7 @@ import iotests
>  from iotests import log
> =20
>  iotests.verify_image_format(supported_fmts=3D['generic'])
> +iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
>  size =3D 64 * 1024 * 1024
>  granularity =3D 64 * 1024
> =20
> diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> index f81ee1112f..c62ff9a6dc 100755
> --- a/tests/qemu-iotests/238
> +++ b/tests/qemu-iotests/238
> @@ -23,6 +23,8 @@ import os
>  import iotests
>  from iotests import log
> =20
> +iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
> +
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 's=
cripts'))
> =20
>  from qemu import QEMUMachine
>=20
