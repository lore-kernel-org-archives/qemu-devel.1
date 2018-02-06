Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej4Lh-00053i-1m
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:35:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej4Lg-0004ef-1Y
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:35:53 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej4Lf-0004eJ-SD
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:35:51 -0500
Received: by mail-oi0-x242.google.com with SMTP id 4so1449964ois.10
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 06:35:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517926039-86416-1-git-send-email-arei.gonglei@huawei.com>
References: <1517926039-86416-1-git-send-email-arei.gonglei@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 14:35:30 +0000
Message-ID: <CAFEAcA9eNYTOBrQ8f9VXodp+qMgQpBDfC58iC5OK+bpif7f=5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] rtc: placing RTC memory region outside
 BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On 6 February 2018 at 14:07, Gonglei <arei.gonglei@huawei.com> wrote:
> As windows guest use rtc as the clock source device,
> and access rtc frequently. Let's move the rtc memory
> region outside BQL to decrease overhead for windows guests.
> Meanwhile, adding a new lock to avoid different vCPUs
> access the RTC together.
>
> $ cat strace_c.sh
> strace -tt -p $1 -c -o result_$1.log &
> sleep $2
> pid=$(pidof strace)
> kill $pid
> cat result_$1.log
>
> Before appling this change:
> $ ./strace_c.sh 10528 30
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  93.87    0.119070          30      4000           ppoll
>   3.27    0.004148           2      2038           ioctl
>   2.66    0.003370           2      2014           futex
>   0.09    0.000113           1       106           read
>   0.09    0.000109           1       104           io_getevents
>   0.02    0.000029           1        30           poll
>   0.00    0.000000           0         1           write
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.126839                  8293           total
>
> After appling the change:
> $ ./strace_c.sh 23829 30
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  92.86    0.067441          16      4094           ppoll
>   4.85    0.003522           2      2136           ioctl
>   1.17    0.000850           4       189           futex
>   0.54    0.000395           2       202           read
>   0.52    0.000379           2       202           io_getevents
>   0.05    0.000037           1        30           poll
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.072624                  6853           total
>
> The futex call number decreases ~90.6% on an idle windows 7 guest.

These are the same figures as from v1 -- it would be interesting
to check whether the additional locking that v2 adds has affected
the results.

Does the patch improve performance in a more interesting use
case than "the guest is just idle" ?

> +static void rtc_rasie_irq(RTCState *s)

Typo: should be "raise".

thanks
-- PMM
