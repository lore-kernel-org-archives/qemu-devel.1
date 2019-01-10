Received: from eggs.gnu.org ([209.51.188.92]:41772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghepK-0002CC-MS
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghepI-0007c5-OZ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:13:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghepG-0007Qa-9F
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:13:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so12436093wrx.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:12:50 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <84d3ca9d-0038-b74c-e9a5-da9a7f91bdc9@redhat.com>
Date: Thu, 10 Jan 2019 19:12:48 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 02/19] tests: run ldconfig after
 installing extra software
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Fam Zheng <fam@euphon.net>

On 1/10/19 6:44 PM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The docker file builds and installs software into /usr/local but does
> not run ldconfig. As a result QEMU links to libvirglrenderer.so, but
> then crashes in "make check" unable to find the library.

Wow.

> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index 47a30adbdb..954fcf9606 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -36,5 +36,7 @@ RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
>  RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install

Daniel do you mind if we call ldconfig after each 'make install'? So if
one takes this as template the 'fix' is include and he won't run into
the same mistake:

RUN ... && make install && ldconfig

-- >8 --
@@ -25,14 +25,14 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libepoxy-dev \
         libgbm-dev
 RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git
/usr/src/virglrenderer
-RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx
--disable-tests && make install
+RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx
--disable-tests && make install && ldconfig

 # netmap
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         linux-headers-amd64
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
-RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps
--kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
+RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps
--kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install &&
ldconfig
 ENV QEMU_CONFIGURE_OPTS --enable-netmap
---

Regardless if Dan agree to change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
>  
> +RUN ldconfig
> +
>  # gcrypt
>  ENV QEMU_CONFIGURE_OPTS $QEMU_CONFIGURE_OPTS --enable-gcrypt
> 
