Received: from eggs.gnu.org ([209.51.188.92]:60789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hC01R-00045e-15
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBzos-0001tj-QJ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:42:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBzos-0001nV-JJ
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 06:42:06 -0400
Received: by mail-oi1-x241.google.com with SMTP id j132so1483525oib.2
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 03:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <1554194900-22817-1-git-send-email-like.xu@linux.intel.com>
	<871s2kejg1.fsf@dusky.pond.sub.org>
	<e72befe5-c931-5c80-6769-12e1a8e7d4fa@linux.intel.com>
	<20190402174749.71da1efe@redhat.com>
	<871s2k8jxo.fsf@dusky.pond.sub.org>
	<CAFEAcA8ogWn50wWBttM2QpfQoZ8UYnXfG3NSkuSc8j8WOWt6FA@mail.gmail.com>
	<20190404120533.427a2beb@redhat.com>
In-Reply-To: <20190404120533.427a2beb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2019 17:41:54 +0700
Message-ID: <CAFEAcA_Z5YDLW9HWx-FcL_qNefTsg6WSKayrNSDsEv2fZHgn3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] vl.c: make current_machine as
 non-global variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 4 Apr 2019 at 17:05, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 2 Apr 2019 23:23:42 +0700
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > One wrinkle to watch out for is code paths that are used in the
> > linux-user emulator, where there is no machine at all... For instance
> > cpu_common_realizefn() handles this case by explicitly checking
> > whether the thing it gets back from qdev_get_machine() is a
> > TYPE_MACHINE or not.
> this one can be solved by adding 'ignore_memory_transaction_failures'
> property to the CPU class where it applies (I'm not sure why it's
> in generic cpu code instead of ARM only) and then setting compat
> property in affected boards code.

It is not arm-specific, it just happens that all the current users
are arm boards. It is a generic thing that can apply to
any CPU for any target architecture, but only if the board
requests it. The current code seemed a reasonable way to
implement this that didn't involve having to write too much
invasive plumbing code to get the behaviour to apply in the
cases where it needed to be applied, but if there's a better
way to do this I'm happy to review/test patches.

thanks
-- PMM
