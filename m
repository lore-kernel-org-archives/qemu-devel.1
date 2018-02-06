Received: from eggs.gnu.org ([2001:4830:134:3::10]:35464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizsn-0002Cr-2p
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eizsg-0002HG-Uw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:49:45 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:35246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eizsg-0002Gt-PL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:49:38 -0500
Received: by mail-oi0-x22e.google.com with SMTP id e15so892785oiy.2
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 01:49:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA543B64@DGGEMA505-MBX.china.huawei.com>
References: <1517492876-28428-1-git-send-email-arei.gonglei@huawei.com>
	<d2f644da-e6c8-da3a-55e4-13ae69c44fc4@redhat.com>
	<CAFEAcA_6wg6aS_g0mGcNyjC57BVoU+pxdaRU3buM5J6b3XNW-Q@mail.gmail.com>
	<fa226f5f-77c4-7167-29c6-9baf08737239@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA543B64@DGGEMA505-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 09:49:17 +0000
Message-ID: <CAFEAcA_-j5baz-iy16TfzwcUgze1Fs9Fx=uKTkHJKuJ=hpjdqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] rtc: placing RTC memory region outside BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 6 February 2018 at 08:24, Gonglei (Arei) <arei.gonglei@huawei.com> wrote:
> So, taking BQL is necessary, and what we can do is trying our best to narrow
> down the process of locking ? For example, do the following wrapping:
>
> static void rtc_rasie_irq(RTCState *s)
> {
>     qemu_mutex_lock_iothread();
>     qemu_irq_raise(s->irq);
>     qemu_mutex_unlock_iothread();
> }
>
> static void rtc_lower_irq(RTCState *s)
> {
>     qemu_mutex_lock_iothread();
>     qemu_irq_lower(s->irq);
>     qemu_mutex_unlock_iothread();
> }

If you do that you'll also need to be careful about not calling
those functions from contexts where you already hold the iothread
mutex (eg timer callbacks), since you can't lock a mutex you
already have locked.

thanks
-- PMM
