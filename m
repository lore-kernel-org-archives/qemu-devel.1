Received: from eggs.gnu.org ([208.118.235.92]:42751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUC9r-0004e2-WD
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUC9q-0006Rl-DV
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:58:43 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:38067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUBx2-0005FG-VI
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 09:45:29 -0500
Received: by mail-ot1-x32d.google.com with SMTP id e12so15378532otl.5
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 06:45:27 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Dec 2018 14:45:15 +0000
Message-ID: <CAFEAcA8rx-ZzHfb5ABcGBHOWDcDwxOejxp_SW9LLuOf1-_cxdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] hax_enabled() cannot be called in vl.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, "Daniel P. Berrange" <berrange@redhat.com>

In vl.c we do this:

    if (hax_enabled()) {
        hax_sync_vcpus();
    }

But hax_enabled() varies depending on CONFIG_HAX: if that is
not defined then it is "#define hax_enabled() (0)", otherwise
it is a function. And CONFIG_HAX is a per-target configuration
define, only set for i386-softmmu and x86_64-softmmu.

Unfortunately, Makefile.objs puts vl.o in common-obj-y, meaning it
is built once and used for each target. So we can't use anything
here that has a target-specific definition.


My guess is that this is why this travis job has failed:
 https://travis-ci.org/qemu/qemu/jobs/463302115

Undefined symbols for architecture x86_64:
  "_hax_enabled", referenced from:
      _qemu_main in vl.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make[1]: *** [qemu-system-m68k] Error 1

(though it is a little odd that it has only just happened,
given that the code has been this way for some time AFAIK;
this may be a new config at the Travis end or a new target
we added to our Travis config.)


I'm not sure what the best fix is here -- perhaps following
how xen_enabled() works, where it is always defined as an
(inline) function which returns the xen_allowed bool.

kvm_enabled() does a similar thing to what hax_enabled() does,
but this works out OK because it takes care to avoid
providing the #define-to-0 implementation except in the
case where it is building a target-specific file for a
target where KVM is not enabled; for common files it
will provide the function prototype which will end up
linking to a stub implementation. So we could handle hax
like that too.

thanks
-- PMM
