Received: from eggs.gnu.org ([2001:4830:134:3::10]:55852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duKCO-0007pU-8D
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duKCI-0002f1-9c
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:12:32 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:49087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1duKCH-0002e2-Vy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:12:26 -0400
Received: by mail-wr0-x234.google.com with SMTP id 108so282903wra.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:12:25 -0700 (PDT)
References: <20170919072719.11815-1-famz@redhat.com>
	<20170919072719.11815-7-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170919072719.11815-7-famz@redhat.com>
Date: Tue, 19 Sep 2017 16:12:24 +0100
Message-ID: <874lryen8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v9 06/13] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?utf-8?Q?Mathieu?= =?utf-8?Q?-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>


Fam Zheng <famz@redhat.com> writes:

> This adds a 32bit guest.
>
> The official LTS cloud image is downloaded and initialized with
> cloud-init.
>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/ubuntu.i386 | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100755 tests/vm/ubuntu.i386
>
> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
> new file mode 100755
> index 0000000000..e70dcb89ce
> --- /dev/null
> +++ b/tests/vm/ubuntu.i386
> @@ -0,0 +1,88 @@
> +#!/usr/bin/env python
> +#
> +# Ubuntu i386 image
> +#
> +# Copyright 2017 Red Hat Inc.
> +#
> +# Authors:
> +#  Fam Zheng <famz@redhat.com>
> +#
> +# This code is licensed under the GPL version 2 or later.  See
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

Could we also do something about locales in this setup. The build gives
a lot of noise like:

    perl: warning: Falling back to a fallback locale ("en_US.UTF-8").
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
            LANGUAGE = (unset),
            LC_ALL = "en_GB.UTF-8",
            LC_TIME = "en_US.UTF-8",
            LC_CTYPE = "en_GB.UTF-8",
            LC_MONETARY = "en_US.UTF-8",
            LC_COLLATE = "C",
            LC_ADDRESS = "en_US.UTF-8",
            LC_TELEPHONE = "en_US.UTF-8",
            LC_NAME = "en_US.UTF-8",
            LC_MEASUREMENT = "en_US.UTF-8",
            LC_IDENTIFICATION = "en_US.UTF-8",
            LC_NUMERIC = "en_US.UTF-8",
            LC_PAPER = "en_US.UTF-8",
            LANG = "en_US.UTF-8"
        are supported and installed on your system.


> +        self.ssh_root("poweroff")
> +        self.wait()
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +        return 0
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(UbuntuX86VM))


--
Alex Bennée
