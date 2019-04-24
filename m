Received: from eggs.gnu.org ([209.51.188.92]:53399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJPeE-00056A-Uy
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJPSj-00017Y-Vm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 17:29:55 -0400
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-5-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <f9dc291b-7ba2-c6b8-33aa-c8fa3c6d4950@redhat.com>
Date: Wed, 24 Apr 2019 18:29:43 -0300
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-5-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 4/6] cirrus / travis: Add gnu-sed and bash
 for macOS and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

Hello Thomas,

On 04/24/2019 07:37 AM, Thomas Huth wrote:
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .cirrus.yml | 4 ++--
>   .travis.yml | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)

It needs to get the Freebsd image [1] updated too, in order to `make 
BUILD_TARGET=check vm-build-freebsd` passes. Here it failed with:
---
env: bash: No such file or directory
gmake: *** [/var/tmp/qemu-test.6OlDFH/tests/Makefile.include:1101: 
check-tests/qemu-iotests-quick.sh] Error 1
gmake: *** Waiting for unfinished jobs....
---

I'm not sure about the netbsd and openbsd images, they might need bash 
and gnu-sed as well.

[1] http://download.patchew.org/freebsd-11.1-amd64.img.xz

- Wainer

>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 47ef5bc604..8326a3a4b1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>       cpu: 8
>       memory: 8G
>     install_script: pkg install -y
> -    bison curl cyrus-sasl git glib gmake gnutls
> +    bash bison curl cyrus-sasl git glib gmake gnutls gsed
>       nettle perl5 pixman pkgconf png usbredir
>     script:
>       - mkdir build
> @@ -20,7 +20,7 @@ macos_task:
>     osx_instance:
>       image: mojave-base
>     install_script:
> -    - brew install pkg-config python glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2
>     script:
>       - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
>       - gmake -j$(sysctl -n hw.ncpu)
> diff --git a/.travis.yml b/.travis.yml
> index 2e06aee9d0..ba94644192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ addons:
>       packages:
>         - glib
>         - pixman
> +      - gnu-sed
>   
>   
>   # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
