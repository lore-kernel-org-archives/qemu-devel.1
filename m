Received: from eggs.gnu.org ([209.51.188.92]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJfNt-0004IW-Dl
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJfNs-0000ww-2U
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJfNr-0000wA-Qr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:29:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so19546006otk.12
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190424140643.62457-1-liq3ea@163.com>
	<2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
In-Reply-To: <2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 25 Apr 2019 22:29:18 +0800
Message-ID: <CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=A5=
=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=9A

> On 24/04/2019 16.06, Li Qiang wrote:
> > In the disscuss of adding reboot timeout test case:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
> >
> > Philippe suggested we should uses the only related option for one
> > specific test. However currently we uses one QTestState for all the
> > test cases. In order to achieve Philippe's idea, I split the test case
> > for its own QTestState. As this patchset has changed a lot, I don't bum=
p
> > the version.
> >
> > Change since v1:
> > Add a patch to store the reboot_timeout as little endian
> > Fix the endian issue per Thomas's review
>
> The test still aborts on a big endian host:
>
> $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-test
> /x86_64/fw_cfg/signature: OK
> /x86_64/fw_cfg/id: OK
> /x86_64/fw_cfg/uuid: OK
> /x86_64/fw_cfg/ram_size: OK
> /x86_64/fw_cfg/nographic: OK
> /x86_64/fw_cfg/nb_cpus: OK
> /x86_64/fw_cfg/max_cpus: OK
> /x86_64/fw_cfg/numa: OK
> /x86_64/fw_cfg/boot_menu: OK
> /x86_64/fw_cfg/reboot_timeout: **
>
> ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cfg_reboot_t=
imeout:
> assertion failed (reboot_timeout =3D=3D 15): (251658240 =3D=3D 15)
> Aborted
>
> 251658240 is 0x0F000000, i.e. a byte-swapped 0xf =3D 15 ... i.e. you stil=
l
> got an endianess issue somewhere in the code.
>


Hmmmm,

I have thought a long time, still can't point where is wrong.

Let's from the result:
0x0f000000 in the big endian laid as this:
low ---> high
0x0f 00 00 00

As I have swapped before the compare so it is read as this:
low ---> high
00 00 00 0x0f

However from the store side:
the 15 in big endian is:
low ---> high
00 00 00 0x0f

But Before I store it, I convert it to little endian, so following should
be stored:
low ---> high
0x0f 00 00 00

Do you apply the patch 3 and recompile the qemu binary?
If it is, I may need your help as I have no big endian host device.

You can debug and  inspect the memory layout and point out where is wrong.

Thanks,
Li Qiang







>
>  Thomas
>
