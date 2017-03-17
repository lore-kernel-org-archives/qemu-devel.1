Received: from eggs.gnu.org ([2001:4830:134:3::10]:56775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotV9-0002d2-Fm
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cotV8-0001I6-EY
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:09:11 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cotV8-0001HN-8J
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:09:10 -0400
Received: by mail-wm0-x236.google.com with SMTP id n11so18347930wma.0
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 08:09:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170227164950.15062-2-pbonzini@redhat.com>
References: <20170227164950.15062-1-pbonzini@redhat.com>
	<20170227164950.15062-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 15:08:48 +0000
Message-ID: <CAFEAcA9Ec3e1CHDHRFKtfN7w3Fh4=GVuo8C-9mpwYnpYwFNNYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 06/17] cpus: remove ugly cast on
 sigbus_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2017 at 16:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The cast is there because sigbus_handler is invoked via sigfd_handler.
> But it feels just wrong to use struct qemu_signalfd_siginfo in the
> prototype of a function that is passed to sigaction.
>
> Instead, do a simple-minded conversion of qemu_signalfd_siginfo to
> siginfo_t.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> +    } else if (info->ssi_signo == SIGIO) {
> +        si.si_band = info->ssi_band;
> +    }

This doesn't build on OpenBSD:

In file included from /usr/include/sys/signal.h:107:0,
                 from /usr/include/signal.h:38,
                 from /root/qemu/include/qemu/osdep.h:86,
                 from /root/qemu/util/oslib-posix.c:29:
/root/qemu/util/oslib-posix.c: In function 'sigaction_invoke':
/root/qemu/util/oslib-posix.c:713:12: error: 'union <anonymous>' has
no member named '_file'
         si.si_band = info->ssi_band;
            ^

I dunno how much we care.

thanks
-- PMM
