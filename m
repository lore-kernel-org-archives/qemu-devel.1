Received: from eggs.gnu.org ([2001:4830:134:3::10]:53883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YZQ-0007Yx-Ci
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d6YZN-0000FB-5B
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:36 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d6YZM-0000Ev-VR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:26:33 -0400
Received: by mail-wr0-x236.google.com with SMTP id l9so19677391wre.1
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 01:26:32 -0700 (PDT)
References: <20170505032340.26467-1-famz@redhat.com>
	<20170505032340.26467-4-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170505032340.26467-4-famz@redhat.com>
Date: Fri, 05 May 2017 09:27:11 +0100
Message-ID: <8737cjogio.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/5] docker: Use unconfined security profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org


Fam Zheng <famz@redhat.com> writes:

> Some by default blocked syscalls are required to run tests for example
> userfaultfd.

Is there any way the tests could DoS the host? I guess you could achieve
the same running the iotests directly from make but it does seem we
should confine the docker guest as much as possible.

>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/Makefile.include | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 0ed8c3d..09d157c 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -127,6 +127,7 @@ docker-run: docker-qemu-src
>  	$(call quiet-command,						\
>  		$(SRC_PATH)/tests/docker/docker.py run 			\
>  			$(if $(NOUSER),,-u $(shell id -u)) -t 		\
> +			--security-opt seccomp=unconfined		\
>  			$(if $V,,--rm) 					\
>  			$(if $(DEBUG),-i,--net=none) 			\
>  			-e TARGET_LIST=$(TARGET_LIST) 			\


--
Alex Bennée
