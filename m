Received: from eggs.gnu.org ([2001:4830:134:3::10]:33879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f62VD-0003Mc-Ie
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f62VA-0005lQ-Cq
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:40332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f62VA-0005kn-6e
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 19:16:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f62V7-0005q5-W3
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 23:16:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4504F2E8193
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 23:16:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Apr 2018 23:03:04 -0000
From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
Reply-To: Bug 1760262 <1760262@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152246970464.28900.5033274314150943057.malonedeb@chaenomeles.canonical.com>
	<152336793910.29767.12550515606452232759.malone@chaenomeles.canonical.com>
Message-Id: <CAEg67G=XmPK09NRDmMAki2KG8tUK+-GHtopaS3=ACEQD=HnUHg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1760262] Re: cmsdk-apb-uart doesn't appear to
 clear interrupt flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Tue, Apr 10, 2018 at 11:45 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
>
> Thanks for the bug report; I've submitted this patch (which is similar to=
 but not quite the same as your fix):
> https://patchwork.ozlabs.org/patch/896715/
>
> Hopefully this will get into 2.12, but we're quite close to release now
> so it will depend on whether we need to spin an extra release candidate
> for some other reason.

Thanks for looking into it.

Patrick

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1760262

Title:
  cmsdk-apb-uart doesn't appear to clear interrupt flags

Status in QEMU:
  In Progress

Bug description:
  I have been writing a small operating system and using QEMU emulating
  the mps2-an385 board for some of my testing.

  During development of the uart driver I observed some odd behaviour
  with the TX interrupt -- writing a '1' to bit 0 of the INTCLEAR
  register doesn't clear the TX interrupt flag, and the interrupt fires
  continuously.

  It's possible that I have an error somewhere in my code, but after
  inspecting the QEMU source it does appear to be a QEMU bug. I applied
  the following patch and it solved my issue:

  From 9875839c144fa60a3772f16ae44d32685f9328aa Mon Sep 17 00:00:00 2001
  From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
  Date: Sat, 31 Mar 2018 15:10:28 +1100
  Subject: [PATCH] hw/char/cmsdk-apb-uart: fix clearing of interrupt flags

  ---
   hw/char/cmsdk-apb-uart.c | 1 +
   1 file changed, 1 insertion(+)

  diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
  index 1ad1e14295..64991bd9d7 100644
  --- a/hw/char/cmsdk-apb-uart.c
  +++ b/hw/char/cmsdk-apb-uart.c
  @@ -274,6 +274,7 @@ static void uart_write(void *opaque, hwaddr offset, u=
int64_t value,
            * is then reflected into the intstatus value by the update func=
tion).
            */
           s->state &=3D ~(value & (R_INTSTATUS_TXO_MASK | R_INTSTATUS_RXO_=
MASK));
  +        s->intstatus &=3D ~(value & ~(R_INTSTATUS_TXO_MASK | R_INTSTATUS=
_RXO_MASK));
           cmsdk_apb_uart_update(s);
           break;
       case A_BAUDDIV:
  -- =

  2.16.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1760262/+subscriptions
