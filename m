Received: from eggs.gnu.org ([209.51.188.92]:46868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghjhk-00049i-GR
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghjhi-0007UI-Dj
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:25:40 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghjhi-0007Sd-1d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 18:25:38 -0500
Received: by mail-wm1-f43.google.com with SMTP id y8so647628wmi.4
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 15:25:37 -0800 (PST)
References: <CAJSP0QUV39fK4L8MwQ-rGiR0ejUm0HCyKFqARh-SKRTuDPKOXg@mail.gmail.com>
	<jpgsgy0aaw6.fsf@linux.bootlegged.copy>
	<CACT4Y+YWVfg_PVh0=CTCgM9BRyCmKZB9N+_DBimaNKPE=y6r5Q@mail.gmail.com>
	<CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4af7025-fa8c-1078-62de-f77a11a79fc0@redhat.com>
Date: Fri, 11 Jan 2019 00:25:32 +0100
MIME-Version: 1.0
In-Reply-To: <CABiizEQ-O-Ro9cH3xqzZUB=c5k+oYJ-gdR7ssfbbn5kU_8GcAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Internship idea: virtio-blk oss-fuzz support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Moroz <mmoroz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Oliver Chang <ochang@google.com>, Jonathan Metzman <metzman@google.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Bandan Das <bsd@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Andrey Konovalov <andreyknvl@google.com>, Kostya Serebryany <kcc@google.com>

On 10/01/19 17:07, Max Moroz via Qemu-devel wrote:
> +Oliver and Jonathan
> 
> I'm a little confused. Do you want to fuzz QEMU or to fuzz something else
> using QEMU? In case of the latter, there was some discussion on OSS-Fuzz
> and (I think) even a build support was (sort of) added:
> https://github.com/google/oss-fuzz/issues/1754

We want to fuzz QEMU.

The input is a sequence of operations on a PCI device or on guest
memory, and you try and crash QEMU by passing it crazy operations.

The qtest mode that Stefan mentioned provides something like a "JTAG
over ASCII" where a testcase can inject elementary I/O operations into
QEMU.  However, that is certainly too much for AFL to fuzz effectively;
it would have to "learn" the qtest protocol, how to drive the PCI host
bridge, how to setup a PCI device, and only then it would be able to
find bugs.  So one idea would be to build another layer on top of qtest,
that accepts higher-level operations and builds the qtest ASCII input
from those.

However, compared to LLVM/Clang that were the motivation for
libprotobuf-mutator, in our case the underlying operands to the
operations are still binary.  So it may also be possible to use the
usual AFL binary mutator, and encode the operations in a way that has
very high entropy.  This way AFL can just throw crap at the qtest input
generator, and the resulting input qtest will always represent some kind
of interaction with a PCI device.

Thanks,

Paolo

> In any case, it would probably be "integrate QEMU into OSS-Fuzz" and not
> vice versa, since OSS-Fuzz is an infrastructure and you can't integrate it
> into QEMU.
