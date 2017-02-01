Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYwmm-0000sv-FK
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:25:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYwml-0004K3-BL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:25:28 -0500
Received: from mail-ua0-x22b.google.com ([2607:f8b0:400c:c08::22b]:32794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYwml-0004Jj-7o
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:25:27 -0500
Received: by mail-ua0-x22b.google.com with SMTP id i68so297943494uad.0
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 07:25:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130235210.GA4681@tungsten.ozlabs.ibm.com>
References: <587D4171.6@linux.intel.com> <587D4329.5020702@linux.intel.com>
	<20170130235210.GA4681@tungsten.ozlabs.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Feb 2017 15:25:05 +0000
Message-ID: <CAFEAcA-FPmqw0pt7kT=eHR_osfFbZNhrDdGAb87VxUWD_XXSNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-pcc 2.8.0 linux-user segfaults
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 30 January 2017 at 23:52, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
>> On 01/16/2017 03:56 PM, An=C3=ADbal Lim=C3=B3n wrote:
>> > I'm trying to upgrade qemu to 2.8.0 in Openembedded-core and segfaults
>> > in qemu-ppc when is executing:

> I've recently encountered a similar problem and I've posted a fix. If
> you'd like to try it, it's here:
>
> https://lists.gnu.org/archive/html/qemu-ppc/2017-01/msg00413.html

Hmm, I missed that patch (it doesn't seem to have made it
to the qemu-devel list), but it isn't correct, I'm afraid.
In the patch for handling TARGET_USER_ESIGRETURN you must
not change the nip register, because we will have just
set it from the signal context that the guest provided
to the sigreturn syscall. (The patch as it stands will
cause us to reexecute an instruction after return from
a signal handler, which isn't going to go very well).

David, can you drop that patch from your ppc queue, please?

(I think the change is good otherwise but I couldn't
seem to find the bit in the ppc linux kernel that
corresponds to moving the NIP value around.)

thanks
-- PMM
