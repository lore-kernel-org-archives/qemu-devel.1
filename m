Received: from eggs.gnu.org ([208.118.235.92]:46851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfP4O-0000tV-3F
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gfP4I-0002SN-IG
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:59:22 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gfP4H-0002R1-0n
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:59:18 -0500
Received: by mail-wr1-f54.google.com with SMTP id j2so36654890wrw.1
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 04:59:16 -0800 (PST)
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9FwFg9zsg3xLhOs9C=XJHjAo+ACd1=g22YtPaax6N0YQ@mail.gmail.com>
	<42d8a1b8-6c33-8e22-b5d9-35f42f6b928e@redhat.com>
	<CAFEAcA9UqiaiKa_4EWfBHbRS0H=trHfJiArHOJkW6=vKoGvRpQ@mail.gmail.com>
	<bc564647-0550-df53-7a17-7760489b8c45@redhat.com>
	<CAFEAcA9tiqHEiCdUXWcD+SvzUzZPG4sTqiTSR57N=qYM49eykw@mail.gmail.com>
	<d8bb4435-7b69-04e9-2b4a-4cfdd439ecea@redhat.com>
	<CAFEAcA9QKYc89Fknmz-MGSGv11eSTuvNYjsf+-sqsAGT=ZYQ3g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ce7ff3a-4c7f-460c-feba-d5873b491b01@redhat.com>
Date: Fri, 4 Jan 2019 13:59:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9QKYc89Fknmz-MGSGv11eSTuvNYjsf+-sqsAGT=ZYQ3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v4 00/35] Misc patches for 2018-12-21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 04/01/19 12:31, Peter Maydell wrote:
> I'll give this a go, but I think this will not necessarily be
> sufficient if some program invoked by make sets the O_NONBLOCK flag,
> and then make later in the same run tries to output and gets EINTR.
> Perhaps it would be better to put it in the test harness that
> invokes test binaries, so as to clear the flag as soon
> as possible? It could also then in theory print a warning
> if a test case had put stdin/stdout into non-blocking mode.

Aha, you gave me the clue I needed. :)  gtester redirected stdin/out/err
to /dev/null.

In the new harness, stdout is piped into tap-driver.pl, but everything
else is left in place.  Leaving stderr should be safe, while stdin is
the most likely culprit.  Adding </dev/null to the test invocation
should fix it; I'll send a new pull request either today or next Monday.

> (The semantics of O_NONBLOCK here seem to me to be completely
> broken. But they are what they are...)

Yes, and F_SETFL is not the only "interesting" fcntl in this respect;
fortunately QEMU is not using F_SETOWN anymore!

Paolo
