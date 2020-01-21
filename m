Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6149BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC5D24653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 16:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsFxAw8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC5D24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itws0-0007bI-6W
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 11:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1itwql-0006bM-3z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1itwqg-00048J-IM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:57:58 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1itwqg-00045p-90
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 11:57:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id q10so4031282wrm.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 08:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fN0ryjCvS62aHna8Psftg0duSV144Fd0/MsYIJxeavs=;
 b=nsFxAw8HlZhZQ0IEbKDrsbYKLnBklVAtdFGCJbJ0mG7KbppjfUQ1ZtsVJM/xRJyusC
 olYwJQAoXA5QrA31+fKUYsIw/2oCum+RnqI7D1uN+S0gFC7NA08GFZicfUKCqGt1HI6D
 MOYS2WG2O0SI/51CHpKw5+FGTLR1DZnMNHl0kfFkW7zC84qvNPN62C5VXKCWoiPgrD6L
 44K0AkrORECWrtRIzP+1ElYGLth/i/jTiHsSwuH94teORGYdwSiyNkqy2RXSks2XmObS
 OOrHaQPE4G918jjIGhLqswROOFEQ6QT4co/ZipdH7Q1BRja37f5H1lDOZTZSNevZPUKI
 GHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fN0ryjCvS62aHna8Psftg0duSV144Fd0/MsYIJxeavs=;
 b=kTSOEew7Oz9N7dbLm929ckjEtPWAbC1A5ZMthowdiVPnDNsAH/d0BxFimflNv4dLzA
 zS3ye4P6AfxXydWmBPXAHbpnuzcp533OD5Z6T4q2dCwM4Iioj2GppIxkx8K1xDpLeNgE
 zlnZ7EzoVybsh22NJUsk2eJG8hmhIK3sDVYXG0IzybwlyaThv8N8nz9NL4rRtaoGnfDq
 1mqw/R11SKgUiNL9J+8WhYd1z9/Yg0NFObHOpBSE9QE9mtt1HCirDZgpB2COPyYv1YBO
 iFEzJhJuJTDiTLsoye2KtNtE0tnFpfiUF+EOSyrWSVxKoFCiY+tXyNnn0CaoRlYWtHOx
 +H9A==
X-Gm-Message-State: APjAAAUi0Xnxc7ojYKbiGLpDSbsPZvUPAc2kBCcHXqdNmI2RRLks4hLt
 PQhcoSIZbTzncLnsFQlI+bv6ico5sO8=
X-Google-Smtp-Source: APXvYqz49n5GNfYdSsR0eecYRf4o0tjjYpkw9ybeLrNSX8dqHl7uYOHUEV6X5c3ku9uCQ5U0Hv15BQ==
X-Received: by 2002:a5d:4204:: with SMTP id n4mr6113865wrq.123.1579625870868; 
 Tue, 21 Jan 2020 08:57:50 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t125sm4731052wmf.17.2020.01.21.08.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 08:57:49 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C44761FF87;
 Tue, 21 Jan 2020 16:57:48 +0000 (GMT)
References: <1579536554-30701-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579536554-30701-2-git-send-email-Filip.Bozuta@rt-rk.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Subject: Re: [PATCH 1/2] tests/tcg/multiarch: Add tests for implemented rtc
 ioctls
In-reply-to: <1579536554-30701-2-git-send-email-Filip.Bozuta@rt-rk.com>
Date: Tue, 21 Jan 2020 16:57:48 +0000
Message-ID: <877e1k21df.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Filip Bozuta <Filip.Bozuta@rt-rk.com> writes:

> This patch adds tests for following 22 implemented rtc ioctls:
>
> * RTC_AIE_ON     * RTC_ALM_SET      * RTC_WKALM_SET
> * RTC_AIE_OFF    * RTC_ALM_READ     * RTC_WKALM_RD
> * RTC_UIE_ON     * RTC_RD_TIME      * RTC_PLL_GET
> * RTC_UIE_OFF    * RTC_SET_TIME     * RTC_PLL_SET
> * RTC_PIE_ON     * RTC_IRQP_READ    * RTC_VL_READ
> * RTC_PIE_OFF    * RTC_IRQP_SET     * RTC_VL_CLR
> * RTC_WIE_ON     * RTC_EPOCH_READ
> * RTC_WIE_OFF    * RTC_EPOCH_SET
>
> Names and descriptions of these ioctls can be found in patches that
> implement them.
>
> Test folder for these ioctl tests is located at
> "tests/tcg/multiarch/rtc-ioctl-tests/"

There is a lot of repetition in these tests - any particular reason not
to just roll up the tests into a single executable with shared setup and
test code?

> Tests for individual ioctls are located in separate folders. These
> folders are arranged by the same way these ioctls are implemented
> in patches. These test files are simple programs that use these ioctls
> to set/read or turn on/off some rtc features.

The default handling of check-tcg won't pick up tests in
sub-directories:

  MULTIARCH_SRCS   =3D$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))

so I'm guessing it's not actually run in check-tcg.

> Besides tests for individual ioctls, a global rtc ioctl test was
> added at "tests/tcg/multiarch/rtc-ioctl-tests/GlobalTest/rtc-test.c"
> This test file was downloaded from linux kernel and is located at
> "linux/drivers/rtc/rtc-test.c".
> This file was modified a little bit so that it doesn't have styling
> problems identified by "scripts/checkpatch.pl".

This raises an interesting philosophical point about if we should be
porting tests for the linux source tree into QEMU.

> It is used to further test functionalities of some rtc ioctls by
> running rtc clock at different frequencies.
>
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  .../Alarm-time-test/ReadAlarm/getAlarm.c           |  33 +++
>  .../Alarm-time-test/ReadTime/getTime.c             |  35 ++++
>  .../Alarm-time-test/SetAlarm/setAlarm.c            |  31 +++
>  .../Alarm-time-test/SetTime/setTime.c              |  33 +++
>  .../AlarmInterrupt/Disable/disableAlarmInterrupt.c |  29 +++
>  .../AlarmInterrupt/Enable/enableAlarmInterrupt.c   |  29 +++
>  .../Disable/disablePeriodicInterrupt.c             |  30 +++
>  .../Enable/enablePeriodicInterrupt.c               |  29 +++
>  .../Disable/disableUpdateInterrupt.c               |  29 +++
>  .../UpdateInterrupt/Enable/enableUpdateInterrupt.c |  29 +++
>  .../Disable/disableWatchdogInterrupt.c             |  30 +++
>  .../Enable/enableWatchdogInterrupt.c               |  31 +++
>  .../rtc-ioctl-tests/GlobalTest/rtc-test.c          | 227 +++++++++++++++=
++++++
>  .../ReadEpoch/getEpoch.c                           |  32 +++
>  .../ReadPeriodicInterrupt/getPeriodicInterrupt.c   |  31 +++
>  .../SetEpoch/setEpoch.c                            |  32 +++
>  .../SetPeriodicInterrupt/setPeriodicInterrupt.c    |  31 +++
>  .../ReadPllCorrection/getPllCorrection.c           |  35 ++++
>  .../SetPllCorrection/setPllCorrection.c            |  32 +++
>  .../ClearVoltageLow/clearVoltageLow.c              |  32 +++
>  .../ReadVoltageLow/getVoltageLow.c                 |  32 +++
>  .../ReadWakeupAlarm/getWakeupAlarm.c               |  36 ++++
>  .../SetWakeupAlarm/setWakeupAlarm.c                |  34 +++

I can't say I'm keen about having a bunch of camelCased and PascalCased
filenames and directories.
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadAlarm/getAl=
arm.c
> @@ -0,0 +1,33 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/ReadTime/getTim=
e.c
> @@ -0,0 +1,35 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetAlarm/setAla=
rm.c
> @@ -0,0 +1,31 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Alarm-time-test/SetTime/setTime=
.c
> @@ -0,0 +1,33 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/capability.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/Di=
sable/disableAlarmInterrupt.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/AlarmInterrupt/En=
able/enableAlarmInterrupt.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt=
/Disable/disablePeriodicInterrupt.c
> @@ -0,0 +1,30 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/PeriodicInterrupt=
/Enable/enablePeriodicInterrupt.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/D=
isable/disableUpdateInterrupt.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/UpdateInterrupt/E=
nable/enableUpdateInterrupt.c
> @@ -0,0 +1,29 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt=
/Disable/disableWatchdogInterrupt.c
> @@ -0,0 +1,30 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Features-test/WatchdogInterrupt=
/Enable/enableWatchdogInterrupt.c
> @@ -0,0 +1,31 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/R=
eadEpoch/getEpoch.c
> @@ -0,0 +1,32 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/R=
eadPeriodicInterrupt/getPeriodicInterrupt.c
> @@ -0,0 +1,31 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
> +
> +    unsigned long interrupt_rate;
> +
> +    if (ioctl(fd, RTC_IRQP_READ, &interrupt_rate) =3D=3D ERROR) {
> +        perror("ioctl");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/S=
etEpoch/setEpoch.c
> @@ -0,0 +1,32 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Periodic-interrupt-epoch-test/S=
etPeriodicInterrupt/setPeriodicInterrupt.c
> @@ -0,0 +1,31 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/ReadPllCorr=
ection/getPllCorrection.c
> @@ -0,0 +1,35 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Pll-correction-test/SetPllCorre=
ction/setPllCorrection.c
> @@ -0,0 +1,32 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc0", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ClearVoltageLo=
w/clearVoltageLow.c
> @@ -0,0 +1,32 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Voltage-low-test/ReadVoltageLow=
/getVoltageLow.c
> @@ -0,0 +1,32 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <linux/ioctl.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/proc/driver/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/ReadWakeupAla=
rm/getWakeupAlarm.c
> @@ -0,0 +1,36 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDWR | O_NONBLOCK);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>
> --- /dev/null
> +++ b/tests/tcg/multiarch/rtc-ioctl-tests/Wakeup-alarm-test/SetWakeupAlar=
m/setWakeupAlarm.c
> @@ -0,0 +1,34 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/rtc.h>
> +#include <fcntl.h>
> +#include <linux/input.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +
> +#define ERROR -1
> +
> +int main()
> +{
> +
> +    int fd =3D open("/dev/rtc", O_RDONLY);
> +
> +    if (fd =3D=3D ERROR) {
> +        perror("open");
> +        return -1;
> +    }
<snip>

By all means introduce the patches in multiple steps but I think a
single test file would be preferable and you could then share all the
setup logic (not that there is much).

--=20
Alex Benn=C3=A9e

