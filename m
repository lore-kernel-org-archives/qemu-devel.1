Received: from eggs.gnu.org ([209.51.188.92]:34442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM8ES-0006Zw-C0
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hM8EH-00030q-Tf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hM8E0-0002fA-D7
	for qemu-devel@nongnu.org; Thu, 02 May 2019 05:42:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2so1528527wmi.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 02:41:41 -0700 (PDT)
Date: Thu, 2 May 2019 11:41:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190502094058.lfe2i7gl5rm4zxul@steredhat>
References: <20190501145052.12579-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501145052.12579-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] sockets: avoid string truncation
 warnings when copying UNIX path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

On Wed, May 01, 2019 at 03:50:52PM +0100, Daniel P. Berrangé wrote:
> In file included from /usr/include/string.h:494,
>                  from include/qemu/osdep.h:101,
>                  from util/qemu-sockets.c:18:
> In function ‘strncpy’,
>     inlined from ‘unix_connect_saddr.isra.0’ at util/qemu-sockets.c:925:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘strncpy’,
>     inlined from ‘unix_listen_saddr.isra.0’ at util/qemu-sockets.c:880:5:
> /usr/include/bits/string_fortified.h:106:10: warning: ‘__builtin_strncpy’ specified bound 108 equals destination size [-Wstringop-truncation]
>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> We are already validating the UNIX socket path length earlier in
> the functions. If we save this string length when we first check
> it, then we can simply use memcpy instead of strcpy later, avoiding
> the gcc truncation warnings.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/qemu-sockets.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
