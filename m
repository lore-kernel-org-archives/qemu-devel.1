Received: from eggs.gnu.org ([2001:4830:134:3::10]:44682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPF0N-0008UL-8S
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPF0M-0000TA-5G
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:51:23 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:35001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPF0M-0000T6-0M
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 15:51:22 -0500
Received: by mail-ua0-x236.google.com with SMTP id y9so58756538uae.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 12:51:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6206996c-51ad-d561-f98a-f39702c3c826@tribudubois.net>
References: <20170103211705.27876-1-jcd@tribudubois.net>
	<CAFEAcA91iJ_8MeKmMp7_fDfdc+aKLHHs4--CyYh=0FQP+SmxLw@mail.gmail.com>
	<ea377760-4e9e-a5c7-2d2d-ccf8112b23c7@gmail.com>
	<6206996c-51ad-d561-f98a-f39702c3c826@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 20:51:00 +0000
Message-ID: <CAFEAcA9CT4iJHBLA1re6VabfwdFxfKcZQjx1JcTiu0mDvqHOcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] [m25p80] Abort in case we overrun the
 internal data buffer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Cc: "mar.krzeminski" <mar.krzeminski@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 5 January 2017 at 20:18, Jean-Christophe DUBOIS <jcd@tribudubois.net> wr=
ote:
> Le 05/01/2017 =C3=A0 21:04, mar.krzeminski a =C3=A9crit :
>> Peter Maydell wrote:
>>> If these are "can't happen unless some other part of QEMU
>>> is buggy" cases, then we can just assert():

>>> (If they're "could happen if the guest does something wrong"
>>> cases, we shouldn't just abort(), but if I'm reading the previous
>>> mail thread correctly, that's not the situation here.)
>
>> Indeed this case is about error in Qemu itself, but the same situation c=
ould
>> be generated from the guest (guest deasert CS only once).
>> IMHO we should reset m26p80 state in such case:
>> s->len =3D 0;
>> s->pos =3D 0;
>> s->state =3D STATE_IDLE;
>> This will be a bit closer to real HW behaviour too.

> So what would be the preferred behavior?
>
> Asserting (and ending Qemu)
> Resetting (and hiding the misbehavior).

If the guest can trigger this behaviour, then we should
not assert or abort or otherwise cause QEMU to exit.
The preferred behaviour is:
 * act like the real hardware does in this situation
   (whatever that is)
 * if this is something that only broken guest code would
   do, log it with qemu_log_mask(LOG_GUEST_ERROR, ...)

thanks
-- PMM
