Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesPH-0005pU-Mu
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesPD-0002CP-LC
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:34:31 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fesPD-0002C5-Dx
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 21:34:27 -0400
Received: by mail-vk0-x242.google.com with SMTP id l143-v6so13488072vke.1
	for <qemu-devel@nongnu.org>; Sun, 15 Jul 2018 18:34:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712012829.20231-1-famz@redhat.com>
	<20180712012829.20231-5-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b36d6fb7-a6fb-ffaf-43fe-736f80f3e9f3@amsat.org>
Date: Sun, 15 Jul 2018 22:34:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180712012829.20231-5-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/4] tests: Add centos VM testing
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

On 07/11/2018 10:28 PM, Fam Zheng wrote:
> This one does docker testing in the VM. It is intended to replace the
> native docker testing on patchew testers.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/Makefile.include |  3 +-
>  tests/vm/centos           | 84 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+), 1 deletion(-)
>  create mode 100755 tests/vm/centos
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5daa2a3b73..af19b7a4e6 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,7 +2,7 @@
>  
>  .PHONY: vm-build-all

Can we have a vm-clean-all rule too?

>  
> -IMAGES := ubuntu.i386 freebsd netbsd openbsd
> +IMAGES := ubuntu.i386 freebsd netbsd openbsd centos
>  IMAGE_FILES := $(patsubst %, tests/vm/%.img, $(IMAGES))
>  
>  .PRECIOUS: $(IMAGE_FILES)
> @@ -14,6 +14,7 @@ vm-test:
>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
>  	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
>  	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
> +	@echo "  vm-build-centos                 - Build QEMU in CentOS VM, with Docker"
>  
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  
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

Not related to this patch, but I noticed when building out-of-tree (i.e.
different ./configure options, or applying on different branches) we
create the vm image in each out-of-tree directory, and never clean them
(I ran out of disk space).

Since we use the same vm image, shouldn't we use the cache dir to store it?

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
