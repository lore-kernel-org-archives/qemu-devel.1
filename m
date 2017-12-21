Received: from eggs.gnu.org ([2001:4830:134:3::10]:40969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5tT-0001xU-FP
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:49:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eS5sP-0006ZD-Qo
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eS5sM-0006U4-TW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 13:47:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12B7061D1F
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 18:47:24 +0000 (UTC)
References: <20171221155905.3793-1-berrange@redhat.com>
	<20171221155905.3793-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf30232b-8674-134a-38fa-0c6cb9f9af3e@redhat.com>
Date: Thu, 21 Dec 2017 12:47:17 -0600
MIME-Version: 1.0
In-Reply-To: <20171221155905.3793-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] io: move fd_is_socket() into common
 sockets code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 12/21/2017 09:59 AM, Daniel P. Berrange wrote:
> The fd_is_socket() helper method is useful in a few places, so put it in
> the common sockets code.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   include/qemu/sockets.h |  1 +
>   io/channel-util.c      | 13 -------------
>   util/qemu-sockets.c    | 13 +++++++++++++
>   3 files changed, 14 insertions(+), 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

But while you are touching this...

> +++ b/util/qemu-sockets.c
> @@ -91,6 +91,19 @@ NetworkAddressFamily inet_netfamily(int family)
>       return NETWORK_ADDRESS_FAMILY_UNKNOWN;
>   }
>   
> +bool fd_is_socket(int fd)
> +{
> +    int optval;
> +    socklen_t optlen;
> +    optlen = sizeof(optval);
> +    return qemu_getsockopt(fd,
> +                           SOL_SOCKET,
> +                           SO_TYPE,
> +                           (char *)&optval,

This cast is pointless (although you are just moving it from the old 
code).  qemu_getsockopt() already takes care of casting for mingw (where 
the signature is not POSIX-compliant), and on all other platforms, the 
argument is already prototyped as void*; and since void* accepts 
anything, you don't have to go through an intermediate char*.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
