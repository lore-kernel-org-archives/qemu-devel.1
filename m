Received: from eggs.gnu.org ([209.51.188.92]:58030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs3lW-0007M2-S5
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gs3lV-0008T0-Or
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:52:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gs3lV-0008Se-JG
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:52:13 -0500
Date: Fri, 8 Feb 2019 11:52:02 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190208115202.6c88dd89.cohuck@redhat.com>
In-Reply-To: <20190207180012.27303-4-crosa@redhat.com>
References: <20190207180012.27303-1-crosa@redhat.com>
	<20190207180012.27303-4-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/3] Add "boot_linux" acceptance test
 for x86_64 and pc machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>, Caio Carrara <ccarrara@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu,  7 Feb 2019 13:00:12 -0500
Cleber Rosa <crosa@redhat.com> wrote:


> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
> new file mode 100644
> index 0000000000..927fac2959
> --- /dev/null
> +++ b/tests/acceptance/boot_linux.py
> @@ -0,0 +1,51 @@
> +# Functional test that boots a complete Linux system via a cloud image
> +#
> +# Copyright (c) 2018-2019 Red Hat, Inc.
> +#
> +# Author:
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado_qemu import Test
> +
> +from avocado.utils import cloudinit
> +from avocado.utils import network
> +from avocado.utils import vmimage
> +
> +
> +class BootLinux(Test):
> +    """
> +    Boots a Linux system, checking for a successful initialization
> +
> +    :avocado: enable
> +    """
> +
> +    timeout = 600
> +
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=arch:x86_64
> +        :avocado: tags=machine:pc
> +        """
> +        self.vm.set_machine('pc')
> +        self.vm.add_args('-m', '1024')
> +        boot = vmimage.get('fedora', arch='x86_64', version='29',
> +                           cache_dir=self.cache_dirs[0],

Somewhat related: I looked at
https://avocado-framework.readthedocs.io/en/67.0/api/utils/avocado.utils.html#module-avocado.utils.vmimage
to find out how caching works, but could not find it... does it match
the checksum?

I think we want to make this benign for people on a slow and/or
data-capped network connection. 'make check-acceptance' downloading
tons of stuff might come as a bad surprise, and it's probably best to
avoid doing more of that than strictly necessary.

> +                           snapshot_dir=self.workdir)
> +        self.vm.add_args('-drive', 'file=%s' % boot.path)
> +
> +        cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
> +        phone_home_port = network.find_free_port()
> +        cloudinit.iso(cloudinit_iso, self.name,
> +                      # QEMU's hard coded usermode router address
> +                      phone_home_host='10.0.2.2',
> +                      phone_home_port=phone_home_port)
> +        self.vm.add_args('-drive', 'file=%s' % cloudinit_iso)
> +
> +        self.vm.launch()
> +        self.log.info('VM launched, waiting for boot confirmation from guest')
> +        cloudinit.wait_for_phone_home(('0.0.0.0', phone_home_port), self.name)
