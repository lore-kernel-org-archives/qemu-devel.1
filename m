Received: from eggs.gnu.org ([209.51.188.92]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwUry-0004HS-3D
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwUrw-0002jt-Gs
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:37:14 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwUrw-0002jM-7Z
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:37:12 -0500
Received: by mail-wr1-x442.google.com with SMTP id f14so26900352wrg.1
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 08:37:11 -0800 (PST)
References: <20190220104523.22059-1-pbonzini@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190220104523.22059-1-pbonzini@redhat.com>
Date: Wed, 20 Feb 2019 16:37:08 +0000
Message-ID: <87o9764dsb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] shippable: fix build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org


Paolo Bonzini <pbonzini@redhat.com> writes:

> It looks like something in netmap has changed and compilation fails:
>
>    install -D libnetmap.a //usr/local/lib/libnetmap.a
>    install: cannot stat libnetmap.a: No such file or directory
>
> Add an explicit "make" step to fix it.

I took an alternate approach as tracking another projects master seems
like a bad idea:

tests/docker: peg netmap code to a specific version

Tracking head is always going to be at the whims of the upstream.
Let's use a defined release so things don't magically change under us.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

1 file changed, 1 insertion(+)
tests/docker/dockerfiles/debian-amd64.docker | 1 +

modified   tests/docker/dockerfiles/debian-amd64.docker
@@ -33,6 +33,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         linux-headers-amd64
 RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
+RUN cd /usr/src/netmap && git checkout v11.3
 RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --kerne=
l-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
 ENV QEMU_CONFIGURE_OPTS --enable-netmap


<snip>

--
Alex Benn=C3=A9e
