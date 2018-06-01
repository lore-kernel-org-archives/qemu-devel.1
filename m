Received: from eggs.gnu.org ([2001:4830:134:3::10]:53958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOnwe-0007Jl-BI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOnwd-0004Sk-EL
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:34:32 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:39594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOnwd-0004Rh-9W
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 13:34:31 -0400
Received: by mail-ot0-x233.google.com with SMTP id l12-v6so30185053oth.6
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 10:34:31 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Jun 2018 18:34:09 +0100
Message-ID: <CAFEAcA8Khsu3HTPbsJW-gBvbzrzJkb=z3tpmELwGyw3rQObJFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] unique (or otherwise) RAM block names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

I was going through trying to fix up various devices that currently
fail to register RAM blocks for migration, or register the RAM
block globally rather than locally, and I ran into something
unexpected.

We name RAM blocks in qemu_ram_set_idstr() like this:
  * if the user passed a device pointer, then call qdev_get_dev_path(),
    and if that returns non-NULL, use "path/name"
  * otherwise, use "name"

Unfortunately, it turns out that there's no guarantee that
qdev_get_dev_path() will return anything useful. If the device
isn't on a bus, or the bus's class doesn't implement the get_dev_path
method, then it'll return NULL.

In particular, this means that if you create what you expect to
be a local-to-this-device RAM memory region in a SysBusDevice,
then (because SysBus doesn't implement get_dev_path), there is
no per-device qualification added to the region name, and so the
code silently creates a globally-namespaced RAM region.
Trying to create multiple instances of the device therefore fails.

How can we make this work (preferably without breaking migration
compat for existing devices) ?

(Sysbus isn't the only bus that doesn't implement get_dev_path,
it's just the first one I found.)

thanks
-- PMM
