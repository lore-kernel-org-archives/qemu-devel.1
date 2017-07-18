Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dXT89-0000NG-LB
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:05:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dXT85-0005es-6r
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:05:41 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dXT84-0005dt-P2
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:05:36 -0400
Received: by mail-io0-x244.google.com with SMTP id k71so2003280iod.3
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 07:05:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <77a5aebb06185f4de234d720d220fa57@walle.cc>
Date: Tue, 18 Jul 2017 10:05:30 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <E77EBB69-E9FB-4F7E-A927-0A2D718593A7@gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
	<4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
	<78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
	<77a5aebb06185f4de234d720d220fa57@walle.cc>
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Walle <michael@walle.cc>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>


> On Jul 18, 2017, at 7:44 AM, Michael Walle <michael@walle.cc> wrote:
>=20
> Am 2017-07-17 17:18, schrieb Programmingkid:
>>> On Jul 17, 2017, at 10:56 AM, Programmingkid =
<programmingkidx@gmail.com> wrote:
>>>> On Jul 17, 2017, at 1:40 AM, Michael Walle <michael@walle.cc> =
wrote:
>>>> Am 2017-07-09 17:39, schrieb Programmingkid:
>>>>> I just made a documentation page for the LatticeMicro32 target. I =
need
>>>>> to know its current status, how much of this system is =
implemented,
>>>>> what software runs on it. If anyone could supply more information =
that
>>>>> would be appreciated. Pictures of this target running would be =
great
>>>>> as well. Thanks.
>>>>> Here is the page: =
http://wiki.qemu.org/Documentation/Platforms/LatticeMico32
>>>> Hi,
>>>> thank you for your efforts. I have to admit that the current status =
is unknown.
>>>> I've just compiled the latest head and it looks like the BQL is =
missing for the interrupt helpers. I'll post a patch soon. With the =
patch, the basic stuff is working but there seems to be an issue with =
OpenGL.
>>>> You can read the quickstart instructions at:
>>>> http://milkymist.walle.cc/README.qemu
>>>> The flash image isn't working because it will boot right into the =
visualization mode, which is using the OpenGL stuff. The "-kernel =
flickernoise" method is working though. You can get the flickernoise =
binary at:
>>>> http://milkymist.walle.cc/updates/current/flickernoise
>>>> Besides the milkymist emulation, there is plain lm32 emulation =
based on the Lattice reference design which should be ok, because the =
tests are working (=EF=BF=BCmake -C tests/tcg/lm32 check)
>>>> -michael
>>> Thank you for all this information. It has been added to the wiki =
page.
>> I just tried qemu-system-lm32 and it crashed.
>> Command-line: qemu-system-lm32 -M milkymist -kernel flickernoise
>> Error message: audio: Failed to create voice `mm_ac97.in'
>> **
>> ERROR: /accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion =
failed:
>> (qemu_mutex_iothread_locked())
>> Abort trap: 6
>> Host: Mac OS 10.12.5
>=20
> As I said before, I guess the BQL is missing here. Try the following =
patch:
>=20
> diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
> index 2177c8ad12..93b8d09794 100644
> --- a/target/lm32/op_helper.c
> +++ b/target/lm32/op_helper.c
> @@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t =
dc)
>=20
> void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
> {
> +    qemu_mutex_lock_iothread();
>     lm32_pic_set_im(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
> }
>=20
> void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
> {
> +    qemu_mutex_lock_iothread();
>     lm32_pic_set_ip(env->pic_state, im);
> +    qemu_mutex_unlock_iothread();
> }
>=20
> void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)
>=20
>=20
>=20
> -michael
>=20

Thank you very much for the patch. It fixed the problem. Now I can take =
a picture of the screen and add it to the wiki page.=20
