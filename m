Received: from eggs.gnu.org ([2001:4830:134:3::10]:45607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cejG3-0003dF-HB
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:11:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cejG2-0003Wx-CX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:11:35 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:36550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cejG2-0003WE-5c
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:11:34 -0500
Received: by mail-wm0-x229.google.com with SMTP id c85so16156762wmi.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 06:11:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170217140505.GB11399@redhat.com>
References: <1487334159-19664-1-git-send-email-peter.maydell@linaro.org>
	<20170217140505.GB11399@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 14:11:12 +0000
Message-ID: <CAFEAcA8g6H5rHSc=bLOjx2tn+=WDSvevnPc3LokMUDuarqxZPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] bcm2835_rng: Use qcrypto_random_bytes()
 rather than rand()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Marcin Chojnacki <marcinch7@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 17 February 2017 at 14:05, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Fri, Feb 17, 2017 at 12:22:39PM +0000, Peter Maydell wrote:
>> We should probably improve crypto/random-platform.c to use
>> getentropy() if available, which would fix the "BSD or OSX
>> host and not using gcrypt or gnutls" case which I think is
>> the most likely cause of qcrypto_random_bytes() failing.
>
> randopm-platform.c currentl uses /dev/urandom or /dev/random,
> so that should work when GNUTLS/gcrypt are both disabled at
> build time.

Ah, and OSX and the BSDs have those devices. (I had
mistakenly assumed they were a linuxism.)

> What would fail, is uses it from a chroot with an empty /dev
> of course.

Yes; replacing the rand() in linux-user/main.c would require
this I think (unless we're willing to fall back to rand ;-))

thanks
-- PMM
