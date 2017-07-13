Received: from eggs.gnu.org ([2001:4830:134:3::10]:35651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVfXs-0005sb-4r
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVfXr-00044G-8D
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:56:48 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVfXr-00043Q-0R
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:56:47 -0400
Received: by mail-wr0-x22b.google.com with SMTP id y28so2717427wrd.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:56:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493271996-23607-8-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
	<1493271996-23607-8-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 15:56:25 +0100
Message-ID: <CAFEAcA8jRjEDRv0hmG1U3H=kCdBX=NoVNqCo7giCVkiwiBo+Lw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 7/8] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Vinzenz Feenstra <vfeenstr@redhat.com>

On 27 April 2017 at 06:46, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> From: Vinzenz Feenstra <vfeenstr@redhat.com>
>
> A command that will list all currently logged in users, and the time
> since when they are logged in.
>
> Examples:
>
> virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
> {"return":[{"login-time":1490622289.903835,"user":"root"}]}
>
> virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'
> {"return":[{"login-time":1490351044.670552,"domain":"LADIDA",
> "user":"Administrator"}]}
>
> Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
> * make g_hash_table_contains compat func inline to avoid
>   unused warnings
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 915df9e..ba06be4 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -15,6 +15,7 @@
>  #include <sys/ioctl.h>
>  #include <sys/wait.h>
>  #include <dirent.h>
> +#include <utmpx.h>

Hi. I've just noticed that this breaks the build on OpenBSD,
which doesn't have utmpx.h or the functions it provides.
OpenBSD is currently close to falling off our list of
hosts we care about, but still it would be nice if we
could do a configure check for utmpx.h and have a fallback
'unsupported' code path for hosts where it doesn't exist.

thanks
-- PMM
