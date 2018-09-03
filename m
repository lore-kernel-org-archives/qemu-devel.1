Received: from eggs.gnu.org ([2001:4830:134:3::10]:51975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwqa9-0003Fr-SC
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fwqa6-0001S6-KB
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:16:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34756 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fwqa6-0001QT-Dm
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:15:58 -0400
Date: Mon, 3 Sep 2018 16:15:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180903151553.GJ14377@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1535987326-16222-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1535987326-16222-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Add a gitlab-ci file for Continuous
 Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Mon, Sep 03, 2018 at 05:08:46PM +0200, Thomas Huth wrote:
> This is very convenient for people who store their QEMU git trees on
> gitlab.com: Automatic CI pipelines are now run for each branch that is
> pushed to the server. Since the runtime of the jobs is limited to 1h
> we distribute the targets into multiple pipelines - this way the jobs
> finish within 30 minutes.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  In case somebody is interested, the result looks e.g. like this on gitlab:
>  https://gitlab.com/huth/qemu/pipelines/29255979
> 
>  .gitlab-ci.yml | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 .gitlab-ci.yml
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> new file mode 100644
> index 0000000..18a77bc
> --- /dev/null
> +++ b/.gitlab-ci.yml
> @@ -0,0 +1,48 @@
> +before_script:
> + - apt-get update -qq
> + - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev
> +
> +build-system1:
> + script:
> + - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
> +      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
> + - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
> +      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
> +      microblaze-softmmu mips-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu"
> + - make -j2
> + - make -j2 check

Hmm, we already have a problem with the travis CI bulds that we're stuck
on outdated Ubuntu.

We also already have a set of dockerfiles in tests/docker/ for various
build configs maintaniers are expected to use.

Both Travis and GitLab CI are capable of using docker images.

What's blocking us in both Travis & GitLab cases is that we're not
publishing the docker images for QEMU yet. If we can get that working,
then all the CI can use pre-build docker images, saving the time
for downloading the same DPKG files each time, as the docker images
would be cached by the CI system IIUC.

The other reason I think it would be desirable is to get more consistency
between the various build systems used in QEMU.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
