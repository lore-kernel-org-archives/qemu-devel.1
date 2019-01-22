Received: from eggs.gnu.org ([209.51.188.92]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glkrs-0001uL-CE
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1glkrr-0007C2-89
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:28:44 -0500
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f]:54714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1glkrp-00079e-9R
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 20:28:42 -0500
Received: by mail-it1-x12f.google.com with SMTP id i145so19163197ita.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 17:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20190120071337.55595-1-liq3ea@163.com>
	<20190120071337.55595-3-liq3ea@163.com>
	<2e1e9b39-ed96-452a-de4b-9b7337702a89@redhat.com>
In-Reply-To: <2e1e9b39-ed96-452a-de4b-9b7337702a89@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 22 Jan 2019 09:28:03 +0800
Message-ID: <CAKXe6SJfThHvzuWKSqNDz79KcRfyzor16sFg1N8CxCFnaJPYTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Laszlo Ersek <lersek@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=885:38=E5=86=99=E9=81=93=EF=BC=9A

> On 01/20/19 08:13, Li Qiang wrote:
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/fw_cfg-test.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> > index 1c5103fe1c..c28e6c3fb5 100644
> > --- a/tests/fw_cfg-test.c
> > +++ b/tests/fw_cfg-test.c
> > @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
> >      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), =3D=3D,
> boot_menu);
> >  }
> >
> > +static void test_fw_cfg_reboot_timeout(void)
> > +{
> > +    uint32_t reboot_timeout;
> > +
> > +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> > +                     &reboot_timeout, sizeof(reboot_timeout));
> > +    g_assert_cmpint(reboot_timeout, =3D=3D, 15);
> > +}
> > +
>
> You don't check the return status of qfw_cfg_get_file(), before reading
> "reboot_timeout". If the qfw_cfg_get_file() fails (returning 0), then
> the comparison will refer to an indeterminate value. Also, it's
> theoretically possible for qfw_cfg_get_file() to overwrite only part of
> the "reboot_timeout" object.
>
>
Right. I will change in the next revision.



> So I think we need the function to transfer exactly (sizeof
> reboot_timeout) bytes.
>
>
What does this mean? check the  return of 'qfw_cfg_get_file' if it is
sizeof(reboot_timeout)?



> BTW, this reminds me, qfw_cfg_get_file() seems to return the number of
> bytes that would be necessary for transferring the entire file. That
> looks like a good idea, but it should be documented. Please add some
> docs on top of qfw_cfg_get_file().
>
>
The docs like "return 0 means failed and non-zero means successful but
the caller need check the exactly size to avoid partially file size" ?

Thanks,
Li Qiang


> >  int main(int argc, char **argv)
> >  {
> >      QTestState *s;
> > @@ -106,7 +115,8 @@ int main(int argc, char **argv)
> >
> >      g_test_init(&argc, &argv, NULL);
> >
> > -    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> > +    s =3D qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 "
> > +                   "-boot reboot-timeout=3D15");
> >
> >      fw_cfg =3D pc_fw_cfg_init(s);
> >
> > @@ -125,6 +135,7 @@ int main(int argc, char **argv)
> >      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
> >      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
> >      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> > +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout=
);
> >
> >      ret =3D g_test_run();
> >
> >
>
> Looks OK otherwise.
>
> Thanks
> Laszlo
>
