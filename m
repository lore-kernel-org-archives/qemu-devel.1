Received: from eggs.gnu.org ([209.51.188.92]:48014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwrAe-0007Bu-15
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwrAa-00012C-9J
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:25:59 -0500
References: <20190221134101.13903-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e297b7f6-e964-74a1-e14c-e6cd10674209@redhat.com>
Date: Thu, 21 Feb 2019 17:25:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190221134101.13903-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/cdrom-test: only include isapc cdrom
 test when g_test_slow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com

On 21/02/2019 14.41, Alex Benn=C3=A9e wrote:
> We are seeing instability on our CI runs which has been there since
> the test was introduced. I suspect it triggers more on Travis due to
> their heavy load.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/cdrom-test.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
> index 14bd981336..05611da648 100644
> --- a/tests/cdrom-test.c
> +++ b/tests/cdrom-test.c
> @@ -132,8 +132,14 @@ static void add_x86_tests(void)
>      qtest_add_data_func("cdrom/boot/virtio-scsi",
>                          "-device virtio-scsi -device scsi-cd,drive=3Dc=
dr "
>                          "-blockdev file,node-name=3Dcdr,filename=3D", =
test_cdboot);
> -    qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
> -                        "-drive if=3Dide,media=3Dcdrom,file=3D", test_=
cdboot);
> +    /*
> +     * Unstable CI test under load
> +     * See https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg05=
509.html
> +     */
> +    if (g_test_slow()) {
> +        qtest_add_data_func("cdrom/boot/isapc", "-M isapc "
> +                            "-drive if=3Dide,media=3Dcdrom,file=3D", t=
est_cdboot);
> +    }
>      qtest_add_data_func("cdrom/boot/am53c974",
>                          "-device am53c974 -device scsi-cd,drive=3Dcd1 =
"
>                          "-drive if=3Dnone,id=3Dcd1,format=3Draw,file=3D=
", test_cdboot);
>=20

Acked-by: Thomas Huth <thuth@redhat.com>

Which tree should this go through? qtest? Block? Your test tree?

At least I don't have much in the qtest queue right now and did not plan
a pull request soon. Let me know if you want me to queue it.
