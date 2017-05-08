Received: from eggs.gnu.org ([2001:4830:134:3::10]:41134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gLw-0003D0-KF
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1d7gLt-0000TL-Dz
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:57:20 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:32963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1d7gLt-0000TB-82
	for qemu-devel@nongnu.org; Mon, 08 May 2017 06:57:17 -0400
Received: by mail-wm0-x234.google.com with SMTP id n198so16088048wmg.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 03:57:17 -0700 (PDT)
References: <20170508045715.21770-1-f4bug@amsat.org>
	<20170508045715.21770-4-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170508045715.21770-4-f4bug@amsat.org>
Date: Mon, 08 May 2017 11:58:00 +0100
Message-ID: <87a86naa4n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 03/23] shippable: ignore SSL
 verification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> shippable logs:
> --------------
> git_sync
> - ssh-agent bash -c 'ssh-add /tmp/ssh/01_deploy; git clone https://github.com/philmd/qemu.git /root/src/github.com/philmd/qemu'
> Identity added: /tmp/ssh/01_deploy (rsa w/o comment)
> Cloning into '/root/src/github.com/philmd/qemu'...
> fatal: unable to access 'https://github.com/philmd/qemu.git/': Problem with the SSL CA cert (path? access rights?)
> retrying 1 of 3 times...

I've not seen this before but which git_sync stage is it. The host or
the container? If it is the container that probably just means we are
missing the CA Cert package.

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .shippable.yml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/.shippable.yml b/.shippable.yml
> index 5170486ff9..b661e667b3 100644
> --- a/.shippable.yml
> +++ b/.shippable.yml
> @@ -2,6 +2,10 @@ language: c
>  env:
>    global:
>      - LC_ALL=C
> +    # sometimes Shippable fails to clone from github (git_sync stage):
> +    # "Problem with the SSL CA cert (path? access rights?)"
> +    # for now disable SSL verification.
> +    - GIT_SSL_NO_VERIFY=1
>    matrix:
>      - IMAGE=debian-armhf-cross
>        TARGET_LIST=arm-softmmu,arm-linux-user


--
Alex Bennée
