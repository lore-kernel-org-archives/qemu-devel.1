Received: from eggs.gnu.org ([2001:4830:134:3::10]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdGzc-0000TH-Hy
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdGzZ-000215-3a
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:25:24 -0400
Received: from mail-qk0-x230.google.com ([2607:f8b0:400d:c09::230]:35529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdGzY-00020t-U9
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 11:25:21 -0400
Received: by mail-qk0-x230.google.com with SMTP id u21-v6so13808615qku.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 08:25:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180711141829.17406-1-famz@redhat.com>
	<20180711141829.17406-5-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e33c8796-a9ac-705e-2277-5efd0ac1e1ce@amsat.org>
Date: Wed, 11 Jul 2018 12:25:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180711141829.17406-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] tests: Add centos VM testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi Fam,

On 07/11/2018 11:18 AM, Fam Zheng wrote:
> This one does docker testing in the VM. It is intended to replace the
> native docker testing on patchew testers.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/Makefile.include |  2 +-
>  tests/vm/centos           | 84 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100755 tests/vm/centos
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5daa2a3b73..e492cd73e5 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,7 +2,7 @@
>  
>  .PHONY: vm-build-all
>  
> -IMAGES := ubuntu.i386 freebsd netbsd openbsd
> +IMAGES := ubuntu.i386 freebsd netbsd openbsd centos

You missed to add an entry to the vm-test rule.

>  IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
>  
>  .PRECIOUS: $(IMAGE_FILES)
> diff --git a/tests/vm/centos b/tests/vm/centos
> new file mode 100755
> index 0000000000..afd560c564
> --- /dev/null
> +++ b/tests/vm/centos
> @@ -0,0 +1,84 @@
> +#!/usr/bin/env python
> +#
> +# CentOS image
> +#
> +# Copyright 2018 Red Hat Inc.
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
> +class CentosVM(basevm.BaseVM):
> +    name = "centos"
> +    BUILD_SCRIPT = """
> +        set -e;
> +        cd $(mktemp -d);
> +        export SRC_ARCHIVE=/dev/vdb;
> +        sudo chmod a+r $SRC_ARCHIVE;
> +        tar -xf $SRC_ARCHIVE;
> +        make docker-test-block@centos7 V={verbose} J={jobs};
> +        make docker-test-quick@centos7 V={verbose} J={jobs};
> +        make docker-test-mingw@fedora V={verbose} J={jobs};
> +    """
> +
> +    def _gen_cloud_init_iso(self):
> +        cidir = self._tmpdir
> +        mdata = open(os.path.join(cidir, "meta-data"), "w")
> +        mdata.writelines(["instance-id: centos-vm-0\n",
> +                          "local-hostname: centos-guest\n"])
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
> +                          "    - %s\n" % basevm.SSH_PUB_KEY,
> +                          "locale: en_US.UTF-8\n"])
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
> +        cimg = self._download_with_cache("https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1802.qcow2.xz")
> +        img_tmp = img + ".tmp"
> +        subprocess.check_call(["cp", "-f", cimg, img_tmp + ".xz"])
> +        subprocess.check_call(["xz", "-df", img_tmp + ".xz"])
> +        subprocess.check_call(["qemu-img", "resize", img_tmp, "50G"])
> +        self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
> +        self.wait_ssh()
> +        self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
> +        self.ssh_root_check("yum update -y")
> +        self.ssh_root_check("yum install -y docker make git")
> +        self.ssh_root_check("systemctl enable docker")
> +        self.ssh_root("poweroff")
> +        self.wait()
> +        if os.path.exists(img):
> +            os.remove(img)
> +        os.rename(img_tmp, img)
> +        return 0
> +
> +if __name__ == "__main__":
> +    sys.exit(basevm.main(CentosVM))
> 
