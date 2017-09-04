Received: from eggs.gnu.org ([2001:4830:134:3::10]:57222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1douNK-0005D5-J6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1douNG-00035x-18
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:37:26 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37689)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1douNF-00035H-Qa
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:37:21 -0400
Received: by mail-wm0-x235.google.com with SMTP id u26so6282975wma.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 09:37:21 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 17:36:59 +0100
Message-ID: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qdev_get_machine() can return something non-NULL but
 not TYPE_MACHINE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

I just got bitten by qdev_get_machine()'s behaviour on the user-only
emulators, where it can return something that isn't NULL and isn't
an instance of TYPE_MACHINE either.

It looks like maybe this can happen in some cases in softmmu too,
judging by the way that qdev_get_hotplug_handler() does an
object_dynamic_cast() check that it really got back a TYPE_MACHINE.

Is this intentional? Does anything rely on qdev_get_machine()
returning something odd like this?

In the code I have which ran into this I can just make it do an
object_dynamic_cast() check like the hotplug_handler code does,
but if the current implementation is intentional we should
probably document that this is what you're supposed to do.

thanks
-- PMM
