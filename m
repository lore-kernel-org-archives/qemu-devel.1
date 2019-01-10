Received: from eggs.gnu.org ([209.51.188.92]:37213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghebP-0007VH-0K
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghebO-0003an-80
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:58:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghebO-0003aY-1o
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 12:58:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id q18so12388320wrx.9
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 09:58:45 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <193e1ccf-21e0-8fe3-c933-887677e02034@redhat.com>
Date: Thu, 10 Jan 2019 18:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 06/19] tests: use in-place sed magic for
 enabling deb-src in travis image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, Fam Zheng <fam@euphon.net>

On 1/10/19 6:45 PM, Alex Bennée wrote:
> This avoids potential problems with duplicates.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/travis.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
> index 03ebfb0ef2..46cf367488 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -2,7 +2,7 @@ FROM travisci/ci-garnet:packer-1512502276-986baf0
>  ENV DEBIAN_FRONTEND noninteractive
>  ENV LANG en_US.UTF-8
>  ENV LC_ALL en_US.UTF-8
> -RUN cat /etc/apt/sources.list | sed "s/# deb-src/deb-src/" >> /etc/apt/sources.list
> +RUN sed -i "s/# deb-src/deb-src/" /etc/apt/sources.list

Good!

Do you mind fixing the other Debian Dockerfiles?

$ git grep 'sed "' tests/docker/
tests/docker/dockerfiles/debian-bootstrap.docker:20:RUN cat
/etc/apt/sources.list | sed "s/deb/deb-src/" >> /etc/apt/sources.list
tests/docker/dockerfiles/debian-sid.docker:21:RUN cat
/etc/apt/sources.list | sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
tests/docker/dockerfiles/debian8.docker:15:RUN cat /etc/apt/sources.list
| sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
tests/docker/dockerfiles/debian9.docker:13:RUN cat /etc/apt/sources.list
| sed "s/^deb\ /deb-src /" >> /etc/apt/sources.list
tests/docker/dockerfiles/travis.docker:5:RUN cat /etc/apt/sources.list |
sed "s/# deb-src/deb-src/" >> /etc/apt/sources.list

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  RUN apt-get update
>  RUN apt-get -y build-dep qemu
>  RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools gcovr
> 
