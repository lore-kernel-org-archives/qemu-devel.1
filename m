Received: from eggs.gnu.org ([2001:4830:134:3::10]:46322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMGRE-0002S0-D6
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMGDg-0003i6-Bb
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:41:53 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMGDf-0003gL-Uw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:41:52 -0500
Received: by mail-ot1-x343.google.com with SMTP id w25so8003505otm.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 09:41:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181112173830.GH2293@work-vm>
References: <20181107155405.24013-1-minyard@acm.org>
	<20181107155405.24013-4-minyard@acm.org>
	<CAFEAcA9hp0VzN484uugfc4kzh3pSDMn3PU+ozfc_XPT5P-QsBw@mail.gmail.com>
	<25d95354-e536-dff6-0936-7e8d951108a5@mvista.com>
	<CAFEAcA9D4=KgmGqJbUceD_bxO11CBTDH7G3-54kn25nfi1XPJA@mail.gmail.com>
	<a05885c2-ae1e-ffa3-78d1-d43af3293be7@acm.org>
	<CAFEAcA-9hgF_FRHYDFaNiH=6VBC6ZcLn03m-GWBaNfvYGTQw=A@mail.gmail.com>
	<94a4be73-e870-d82c-0ace-4be17bf95413@mvista.com>
	<CAFEAcA9=UK2P7J_8yvvf38Jvyr-v96uvjVEY-oBcOS-VF5DFZg@mail.gmail.com>
	<20181112173830.GH2293@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:41:30 +0000
Message-ID: <CAFEAcA-JXGhGdW0i3sp+pyJiQ9-YDP5CUF=M_HnvmO+cQZebxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/3] i2c: Add vmstate handling to the smbus
 eeprom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>, Corey Minyard <minyard@acm.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 12 November 2018 at 17:38, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Peter Maydell (peter.maydell@linaro.org) wrote:
>> That would require us to support backing it properly with a block
>> device, like the pflash flash devices, I think. (This would
>> be the long term way to be able to dump the pointer property,
>> in favour of a block backend property.)
>
> There's a number of separate questions:
>
> a) Can the guest write to the EEPROM or are we just treating it as a
> ROM?
> b) If a guest writes to the EEPROM and then resets does the data stay
> there [I'd expect so, it's an EEPROM]
> c) It the guest writes to the EEPROM and then quits qemu and restarts
> does the data stay there?
> d) If the guest is migrated does it keep the data it's written - I'd say
> it must because otherwise it would get confused.
>
> (c) is where it starts looking like a pflash - which does get a bit
> messy.

My view is that the answers to b and c should always be the same:
resetting QEMU with a system reset should look the same as if
you stopped QEMU and restarted it. (Our only kind of system
reset is an emulation of a hard powercycle.)

In this case, the answer to "a" is currently "yes, it can write to it",
though whether any guest takes advantage of that is a different
question.

thanks
-- PMM
