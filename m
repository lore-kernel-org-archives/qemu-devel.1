Received: from eggs.gnu.org ([2001:4830:134:3::10]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cZMdq-0000AO-9n
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cZMdm-0006Wy-CL
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:01:58 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:48894
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cZMdm-0006Vq-5P
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:01:54 -0500
From: Stefan Weil <sw@weilnetz.de>
References: <1485893872-26524-1-git-send-email-mst@redhat.com>
	<CAFEAcA9zEaATTwGLNCB=X_mhqjapC-0jxPpv8OjDt=zqaFBnjA@mail.gmail.com>
	<CAFEAcA_SCHQ06uON3pEgpt2ku4HO2C-fUTHr7TZAVmZ1PEq09Q@mail.gmail.com>
Message-ID: <0be14960-0364-fc89-33f0-5ff2d1f8d781@weilnetz.de>
Date: Thu, 2 Feb 2017 20:01:45 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_SCHQ06uON3pEgpt2ku4HO2C-fUTHr7TZAVmZ1PEq09Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v5 00/22] virtio, vhost, pci: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Am 02.02.2017 um 17:25 schrieb Peter Maydell:
> On 2 February 2017 at 13:56, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>> On 31 January 2017 at 20:18, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>>> virtio, vhost, pci: fixes, features
>>>
>>> generic pci root port support
>>> disable shpc by default
>>> safer version of ARRAY_SIZE and QEMU_BUILD_BUG_ON
>>> fixes and cleanups all over the place
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>> Applied, thanks.
>
> ...travis builds now fail for the --enable-tcg-interpreter config:
> https://travis-ci.org/qemu/qemu/jobs/197648661
>
> In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c: In function =E2=80=
=98tcg_out_op=E2=80=99:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:117: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:569:255: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> In file included from /home/travis/build/qemu/qemu/tcg/tcg.c:255:0:
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:115: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
> /home/travis/build/qemu/qemu/tcg/tci/tcg-target.inc.c:578:255: error:
> negative width in bit-field =E2=80=98<anonymous>=E2=80=99
>
> These look to be because we were trying to use ARRAY_SIZE()
> on a non-array, which was previously undetected. The use is
> only in an assert() so fairly harmless.
>
> Would somebody who cares about TCI like to provide a fix?
>
> thanks
> -- PMM



Other architectures either no longer use an assertion or
use tcg_debug_assert(s->tb_jmp_insn_offset !=3D NULL), see
tcg/aarch64/tcg-target.inc.c and tcg/ppc/tcg-target.inc.c.

As the majority thinks that there is no longer a need for
an assertion here, I think that is the best solution for
TCI, too.

I'll send a patch.

Regards
Stefan
