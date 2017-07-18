Received: from eggs.gnu.org ([2001:4830:134:3::10]:41506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dXQvr-0007FR-4X
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1dXQvq-0006Jz-4B
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:44:51 -0400
Received: from ssl.serverraum.org ([2a01:4f8:130:84d6::1:2]:51128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1dXQvp-0006JY-QR
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:44:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 18 Jul 2017 13:44:48 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
References: <038DD9E8-EB5A-4575-BAF9-ED62D31700E0@gmail.com>
	<d29a9fe675f1faa36f8cb0fdb1b90aea@walle.cc>
	<4FE60F15-93AE-49AA-A909-66D8B9D058B8@gmail.com>
	<78CE661B-5A4B-4F93-A1FA-819F5CC4C02B@gmail.com>
Message-ID: <77a5aebb06185f4de234d720d220fa57@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] New documentation for the LatticeMicro32 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Am 2017-07-17 17:18, schrieb Programmingkid:
>> On Jul 17, 2017, at 10:56 AM, Programmingkid=20
>> <programmingkidx@gmail.com> wrote:
>>=20
>>=20
>>> On Jul 17, 2017, at 1:40 AM, Michael Walle <michael@walle.cc> wrote:
>>>=20
>>> Am 2017-07-09 17:39, schrieb Programmingkid:
>>>> I just made a documentation page for the LatticeMicro32 target. I=20
>>>> need
>>>> to know its current status, how much of this system is implemented,
>>>> what software runs on it. If anyone could supply more information=20
>>>> that
>>>> would be appreciated. Pictures of this target running would be great
>>>> as well. Thanks.
>>>> Here is the page:=20
>>>> http://wiki.qemu.org/Documentation/Platforms/LatticeMico32
>>>=20
>>> Hi,
>>>=20
>>> thank you for your efforts. I have to admit that the current status=20
>>> is unknown.
>>>=20
>>> I've just compiled the latest head and it looks like the BQL is=20
>>> missing for the interrupt helpers. I'll post a patch soon. With the=20
>>> patch, the basic stuff is working but there seems to be an issue with=
=20
>>> OpenGL.
>>>=20
>>> You can read the quickstart instructions at:
>>> http://milkymist.walle.cc/README.qemu
>>>=20
>>> The flash image isn't working because it will boot right into the=20
>>> visualization mode, which is using the OpenGL stuff. The "-kernel=20
>>> flickernoise" method is working though. You can get the flickernoise=20
>>> binary at:
>>> http://milkymist.walle.cc/updates/current/flickernoise
>>>=20
>>> Besides the milkymist emulation, there is plain lm32 emulation based=20
>>> on the Lattice reference design which should be ok, because the tests=
=20
>>> are working (=EF=BF=BCmake -C tests/tcg/lm32 check)
>>>=20
>>> -michael
>>=20
>> Thank you for all this information. It has been added to the wiki=20
>> page.
>>=20
>=20
> I just tried qemu-system-lm32 and it crashed.
>=20
> Command-line: qemu-system-lm32 -M milkymist -kernel flickernoise
>=20
> Error message: audio: Failed to create voice `mm_ac97.in'
> **
> ERROR: /accel/tcg/tcg-all.c:42:tcg_handle_interrupt: assertion failed:
> (qemu_mutex_iothread_locked())
> Abort trap: 6
>=20
> Host: Mac OS 10.12.5

As I said before, I guess the BQL is missing here. Try the following=20
patch:

diff --git a/target/lm32/op_helper.c b/target/lm32/op_helper.c
index 2177c8ad12..93b8d09794 100644
--- a/target/lm32/op_helper.c
+++ b/target/lm32/op_helper.c
@@ -102,12 +102,16 @@ void HELPER(wcsr_dc)(CPULM32State *env, uint32_t=20
dc)

  void HELPER(wcsr_im)(CPULM32State *env, uint32_t im)
  {
+    qemu_mutex_lock_iothread();
      lm32_pic_set_im(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
  }

  void HELPER(wcsr_ip)(CPULM32State *env, uint32_t im)
  {
+    qemu_mutex_lock_iothread();
      lm32_pic_set_ip(env->pic_state, im);
+    qemu_mutex_unlock_iothread();
  }

  void HELPER(wcsr_jtx)(CPULM32State *env, uint32_t jtx)



-michael
