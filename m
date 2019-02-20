Received: from eggs.gnu.org ([209.51.188.92]:43574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwVWw-0006K5-A3
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwVWu-0005dY-Hc
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:19:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwVWt-0005bj-5j
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 12:19:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so26902898wrn.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:19:29 -0800 (PST)
References: <20190220104523.22059-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <48b1d514-d0e4-44fb-6cda-741cc71506eb@redhat.com>
Date: Wed, 20 Feb 2019 18:19:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190220104523.22059-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Hi Paolo,

Please also Cc reviewers :)

On 2/20/19 11:45 AM, Paolo Bonzini wrote:
> It looks like something in netmap has changed and compilation fails:

Partly my fault, I had the intention to add a git 'stable' tag for
reproducible builds [*] but forgot to add to my TODO list :/

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02028.html

> 
>    install -D libnetmap.a //usr/local/lib/libnetmap.a
>    install: cannot stat libnetmap.a: No such file or directory
> 
> Add an explicit "make" step to fix it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index 954fcf9606..df79f35a46 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -33,7 +33,7 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
>          linux-headers-amd64
>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap

So the fix would be:

- RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
+ RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
&& \
      git checkout v11.4

> -RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make install
> +RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kernel-dir=$(ls -d /usr/src/linux-headers-*-amd64) && make && make install

Your change doesn't hurt.

>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
>  
>  RUN ldconfig
> 

Regards,

Phil.
