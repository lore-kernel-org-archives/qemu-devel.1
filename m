Received: from eggs.gnu.org ([209.51.188.92]:47780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJCNp-0005hs-U6
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hJCN1-0006Vd-Dw
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:31:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hJCN1-0006To-60
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:31:07 -0400
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6dd699b1-f24d-743b-343e-f1df6c8672b9@redhat.com>
Date: Wed, 24 Apr 2019 09:30:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On 24/04/2019 03.16, Li Qiang wrote:
>=20
> Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> =E4=BA=8E2019=E5=
=B9=B44=E6=9C=8824=E6=97=A5
> =E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     On 20/04/2019 12.00, Li Qiang wrote:
>     > Signed-off-by: Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>>
>     > ---
>     >=C2=A0 tests/fw_cfg-test.c | 19 +++++++++++++++++++
>     >=C2=A0 1 file changed, 19 insertions(+)
>     >
>     > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
>     > index c22503619f..9f75dbb5f4 100644
>     > --- a/tests/fw_cfg-test.c
>     > +++ b/tests/fw_cfg-test.c
>     > @@ -174,6 +174,24 @@ static void test_fw_cfg_boot_menu(void)
>     >=C2=A0 =C2=A0 =C2=A0 qtest_quit(s);
>     >=C2=A0 }
>     >=C2=A0
>     > +static void test_fw_cfg_reboot_timeout(void)
>     > +{
>     > +=C2=A0 =C2=A0 QFWCFG *fw_cfg;
>     > +=C2=A0 =C2=A0 QTestState *s;
>     > +=C2=A0 =C2=A0 uint32_t reboot_timeout =3D 0;
>     > +=C2=A0 =C2=A0 size_t filesize;
>     > +
>     > +=C2=A0 =C2=A0 s =3D qtest_init("-boot reboot-timeout=3D15");
>     > +=C2=A0 =C2=A0 fw_cfg =3D pc_fw_cfg_init(s);
>     > +
>     > +=C2=A0 =C2=A0 filesize =3D qfw_cfg_get_file(fw_cfg, "etc/boot-fa=
il-wait",
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&reboot_timeout, sizeof(reboot_timeout));
>     > +=C2=A0 =C2=A0 g_assert_cmpint(filesize, =3D=3D, sizeof(reboot_ti=
meout));
>     > +=C2=A0 =C2=A0 g_assert_cmpint(reboot_timeout, =3D=3D, 15);
>=20
>     Is this endianess-safe? Or do you need to byteswap reboot_timeout i=
f the
>     host and guest endianess does not match?
>=20
> Good question!
>=20
> IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
> So there is no need
> to consider the file's endianess. If when the file entry is stored
> without considering endianess,
> it will be ok to ignore the endianess. So for this patch, the
> 'reboot_timeout' is ok as when we stored=C2=A0
> it we don't consider endianess. But for 'splash-time', when we stored
> it=C2=A0 we convert it to little endian
> so when we fetches it, we should also convert it from little endian to
> cpu-endian.

I just gave these patches a try on a big endian host, and the test fails
indeed:

$ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-test
/x86_64/fw_cfg/signature: OK
/x86_64/fw_cfg/id: OK
/x86_64/fw_cfg/uuid: OK
/x86_64/fw_cfg/ram_size: OK
/x86_64/fw_cfg/nographic: OK
/x86_64/fw_cfg/nb_cpus: OK
/x86_64/fw_cfg/max_cpus: OK
/x86_64/fw_cfg/numa: OK
/x86_64/fw_cfg/boot_menu: OK
/x86_64/fw_cfg/reboot_timeout: **
ERROR:tests/fw_cfg-test.c:190:test_fw_cfg_reboot_timeout: assertion
failed (reboot_timeout =3D=3D 15): (0 =3D=3D 15)
Aborted

=3D> it also fails for reboot_timeout already, not only for splash_time.

> So I think we can have following choose:
>=20
> 1. Don't consider the endianess, this is ok when emaulated target and
> host target has the same endianess.

Sorry, but that's not a real choice. qtests must also work when you e.g.
run qemu-system-x86_64 on a big endian host.

 Thomas
