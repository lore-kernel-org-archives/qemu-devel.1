Received: from eggs.gnu.org ([2001:4830:134:3::10]:49717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrxM-00020j-I2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:50:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrxH-0002JF-Qd
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:50:19 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:34144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrxH-0002IS-Kw
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:50:15 -0400
Received: by mail-qt0-x231.google.com with SMTP id u11so5445635qtu.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 12:50:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170831064302.14427-1-famz@redhat.com>
	<20170831064302.14427-6-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2f969c4b-7568-5692-2763-21d1259981e9@amsat.org>
Date: Fri, 1 Sep 2017 16:50:10 -0300
MIME-Version: 1.0
In-Reply-To: <20170831064302.14427-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/12] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Hi Fam,

On 08/31/2017 03:42 AM, Fam Zheng wrote:
> This adds a 32bit guest.
> 
> The official LTS cloud image is downloaded and initialized with
> cloud-init.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/vm/ubuntu.i386 | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100755 tests/vm/ubuntu.i386
> 
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> new file mode 100755
> index 0000000000..1a55856d9c
> --- /dev/null
> +++ b/tests/vm/ubuntu.i386
> @@ -0,0 +1,88 @@
> +#!/usr/bin/env python
> +#
> +# Ubuntu i386 image
> +#
> +# Copyright (C) 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2.  See
> +# the COPYING file in the top-level directory.
> +#
> +
> +import os
> +import sys
> +import subprocess
> +import basevm
> +import time
> +
> +class UbuntuX86VM(basevm.BaseVM):
> +    name = "ubuntu.i386"
> +    BUILD_SCRIPT = """
> +        set -e;
> +        cd $(mktemp -d);
> +        sudo chmod a+r /dev/vdb;
> +        tar -xf /dev/vdb;
> +        ./configure {configure_opts};
> +        make -j{jobs};
> +        make check;
> +    """
> +
> +    def _gen_cloud_init_iso(self):
> +        cidir = self._tmpdir
> +        mdata = open(os.path.join(cidir, "meta-data"), "w")
> +        mdata.writelines(["instance-id: ubuntu-vm-0\n",
> +                         "local-hostname: ubuntu-guest\n"])
> +        mdata.close()
> +        udata = open(os.path.join(cidir, "user-data"), "w")
> +        udata.writelines(["#cloud-config\n",
> +                          "chpasswd:\n",
> +                          "  list: |\n",
> +                          "    root:%s\n" % self.ROOT_PASS,
> +                          "    %s:%s\n" % (self.GUEST_USER, self.GUEST_PASS),
> +                          "  expire: False\n",
> +                          "users:\n",
> +                          "  - name: %s\n" % self.GUEST_USER,
> +                          "    sudo: ALL=(ALL) NOPASSWD:ALL\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % basevm.SSH_PUB_KEY,
> +                          "  - name: root\n",
> +                          "    ssh-authorized-keys:\n",
> +                          "    - %s\n" % basevm.SSH_PUB_KEY])
> +        udata.close()
> +        subprocess.check_call(["genisoimage", "-output", "cloud-init.iso",
> +                               "-volid", "cidata", "-joliet", "-rock",
> +                               "user-data", "meta-data"],
> +                               cwd=cidir,
> +                               stdin=self._devnull, stdout=self._stdout,
> +                               stderr=self._stdout)
> +        return os.path.join(cidir, "cloud-init.iso")
> +
> +    def build_image(self, img):
> +        cimg = self._download_with_cache("https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server-cloudimg-i386-disk1.img")
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp])
> +        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])

I'd rather test a 32bit cpu, not 64bit cpu in 32bit mode.

I first tested with "-cpu pentium2" which worked, I then find it easier 
this way:

if /dev/kvm: "kvm32"
else: "qemu32"

What do you think?

> +        self.wait_ssh()
> +        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> +        self.ssh_root_check("apt-get update")
> +        self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
> +        # Don't check the status in case the guest hang up too quickly
> +        self.ssh_root("sync && reboot")
> +        time.sleep(5)
> +        self.wait_ssh()
> +        # The previous update sometimes doesn't survive a reboot, so do it again
> +        self.ssh_root_check("apt-get update")
> +        self.ssh_root_check("apt-get build-dep -y qemu")
> +        self.ssh_root_check("apt-get install -y libfdt-dev")
> +        self.ssh_root("poweroff")
> +        self.wait()
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +        return 0
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(UbuntuX86VM))
> 
