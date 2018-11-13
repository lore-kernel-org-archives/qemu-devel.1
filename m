Received: from eggs.gnu.org ([2001:4830:134:3::10]:51308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMeia-0007XA-Lj
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:51:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMeVC-0005vi-K0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:37:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMeV6-0005u6-Gg
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 14:37:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so436522wru.4
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 11:37:26 -0800 (PST)
References: <20181113184641.4492-1-peter.maydell@linaro.org>
	<20181113184641.4492-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <163db126-4441-3e4a-2dd0-1334c6ef4fb9@redhat.com>
Date: Tue, 13 Nov 2018 20:37:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181113184641.4492-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] scripts/coverity-scan: Add Docker
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13/11/18 19:46, Peter Maydell wrote:
> Add support for running the Coverity Scan tools inside a Docker
> container rather than directly on the host system.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   scripts/coverity-scan/coverity-scan.docker | 120 +++++++++++++++++++++
>   scripts/coverity-scan/run-coverity-scan    |  58 ++++++++++
>   2 files changed, 178 insertions(+)
>   create mode 100644 scripts/coverity-scan/coverity-scan.docker
> 
> diff --git a/scripts/coverity-scan/coverity-scan.docker b/scripts/coverity-scan/coverity-scan.docker
> new file mode 100644
> index 00000000000..81f69459954
> --- /dev/null
> +++ b/scripts/coverity-scan/coverity-scan.docker
> @@ -0,0 +1,120 @@
> +# syntax=docker/dockerfile:1.0.0-experimental
> +#
> +# Docker setup for running the "Coverity Scan" tools over the source
> +# tree and uploading them to the website, as per
> +# https://scan.coverity.com/projects/qemu/builds/new
> +# We do this on a fixed config (currently Fedora 28 with a known
> +# set of dependencies and a configure command that enables a specific
> +# set of options) so that random changes don't result in our accidentally
> +# dropping some files from the scan.
> +# The work of actually doing the build is handled by the
> +# run-coverity-scan script.
> +
> +
> +FROM fedora:28
> +ENV PACKAGES \
> +    alsa-lib-devel \
> +    bc \
> +    bison \
> +    bluez-libs-devel \
> +    brlapi-devel \
> +    bzip2 \
> +    bzip2-devel \
> +    ccache \
> +    clang \
> +    curl \
> +    cyrus-sasl-devel \
> +    device-mapper-multipath-devel \
> +    findutils \
> +    flex \
> +    gcc \
> +    gcc-c++ \
> +    gettext \
> +    git \
> +    glib2-devel \
> +    glusterfs-api-devel \
> +    gnutls-devel \
> +    gtk3-devel \
> +    hostname \
> +    libaio-devel \
> +    libasan \
> +    libattr-devel \
> +    libcap-devel \
> +    libcap-ng-devel \
> +    libcurl-devel \
> +    libepoxy-devel \
> +    libfdt-devel \
> +    libgbm-devel \
> +    libiscsi-devel \
> +    libjpeg-devel \
> +    libnfs-devel \
> +    libpng-devel \
> +    librbd-devel \
> +    libseccomp-devel \
> +    libssh2-devel \
> +    libubsan \
> +    libudev-devel \
> +    libusbx-devel \
> +    libxml2-devel \
> +    llvm \
> +    lzo-devel \
> +    make \
> +    mingw32-bzip2 \
> +    mingw32-curl \
> +    mingw32-glib2 \
> +    mingw32-gmp \
> +    mingw32-gnutls \
> +    mingw32-gtk3 \
> +    mingw32-libjpeg-turbo \
> +    mingw32-libpng \
> +    mingw32-libssh2 \
> +    mingw32-libtasn1 \
> +    mingw32-nettle \
> +    mingw32-pixman \
> +    mingw32-pkg-config \
> +    mingw32-SDL2 \
> +    mingw64-bzip2 \
> +    mingw64-curl \
> +    mingw64-glib2 \
> +    mingw64-gmp \
> +    mingw64-gnutls \
> +    mingw64-gtk3 \
> +    mingw64-libjpeg-turbo \
> +    mingw64-libpng \
> +    mingw64-libssh2 \
> +    mingw64-libtasn1 \
> +    mingw64-nettle \
> +    mingw64-pixman \
> +    mingw64-pkg-config \
> +    mingw64-SDL2 \
> +    ncurses-devel \
> +    nettle-devel \
> +    nss-devel \
> +    numactl-devel \
> +    perl \
> +    pixman-devel \
> +    pulseaudio-libs-devel \
> +    python3 \
> +    PyYAML \
> +    rdma-core-devel \
> +    SDL2-devel \
> +    snappy-devel \
> +    sparse \
> +    spice-server-devel \
> +    systemtap-sdt-devel \
> +    tar \
> +    usbredir-devel \
> +    virglrenderer-devel \
> +    vte3-devel \
> +    wget \
> +    which \
> +    xen-devel \
> +    xfsprogs-devel \
> +    zlib-devel
> +ENV QEMU_CONFIGURE_OPTS --python=/usr/bin/python3
> +
> +RUN dnf install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> +ENV COVERITY_TOOL_BASE=/coverity-tools
> +COPY run-coverity-scan run-coverity-scan
> +RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan --update-tools-only --tokenfile /run/secrets/coverity.token

Calling "make docket-image-fedora" you can reduce this script to:

-- >8 --
FROM qemu:fedora
ENV PACKAGES \
     $PACKAGES \
     alsa-lib-devel \
     curl \
     cyrus-sasl-devel \
     libepoxy-devel \
     libgbm-devel \
     libiscsi-devel \
     libnfs-devel \
     libseccomp-devel \
     libudev-devel \
     pulseaudio-libs-devel \
     rdma-core-devel \
     wget \
     xfsprogs-devel

RUN dnf install -y $PACKAGES
RUN rpm -q $PACKAGES | sort > /packages.txt
ENV COVERITY_TOOL_BASE=/coverity-tools
COPY run-coverity-scan run-coverity-scan
RUN --mount=type=secret,id=coverity.token,required ./run-coverity-scan 
--update-tools-only --tokenfile /run/secrets/coverity.token
---

sharing a big docker layer.
