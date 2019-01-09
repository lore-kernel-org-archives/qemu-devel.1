Received: from eggs.gnu.org ([209.51.188.92]:33917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gh9Nn-000086-Ho
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gh9Nm-0002p0-O6
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:38:39 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:40103)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gh9Nm-0002js-E9
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:38:38 -0500
References: <20190108184900.9654-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4d3ee63a-12c1-a3b3-c76f-15b8ed6b43a6@vivier.eu>
Date: Wed, 9 Jan 2019 09:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190108184900.9654-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: make pwrite64/pread64(fd, NULL,
 0, offset) return 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 08/01/2019 à 19:49, Peter Maydell a écrit :
> Linux returns success if pwrite64() or pread64() are called with a
> zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.
> 
> This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
> for the write syscall, and long before that in 38d840e6790c29f59
> for the read syscall.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1810433
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I chose to fix this by setting p to NULL and falling through
> to the normal-case codepath rather than having a call to
> pread/pwrite in the special-case if like 58cfa6c2e6eb5,
> because here the normal-case is a bit more complicated as
> it has the target_offset64() call in it.
> 38d840e6790c29f59 has "just return 0" for the NULL buffer
> case, but we can't do that here as that would not get the
> "negative offset should return -EINVAL" case write.
> ---
>  linux-user/syscall.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
