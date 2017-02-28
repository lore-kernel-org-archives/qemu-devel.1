Received: from eggs.gnu.org ([2001:4830:134:3::10]:41222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciir4-00017p-MC
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ciir3-0005pB-Py
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 09:34:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1488254329.git.jcody@redhat.com>
	<cover.1488254329.git.jcody@redhat.com>
	<64a3308bbe51f78ccd2a53b30e8ba576e979ac4f.1488254329.git.jcody@redhat.com>
Date: Tue, 28 Feb 2017 15:34:10 +0100
In-Reply-To: <64a3308bbe51f78ccd2a53b30e8ba576e979ac4f.1488254329.git.jcody@redhat.com>
	(Jeff Cody's message of "Mon, 27 Feb 2017 23:12:28 -0500")
Message-ID: <87shmyxu3h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 5/5] block/rbd: add support for
 'mon_host', 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org

Starting with just the QAPI schema.

Jeff Cody <jcody@redhat.com> writes:

> This adds support for three additional options that may be specified
> by QAPI in blockdev-add:
>
>     server: host, port
>     auth method: either 'cephx' or 'none'
>
> The "server" and "auth-supported" QAPI parameters are arrays.  To conform
> with the rados API, the array items are join as a single string with a ';'
> character as a delimiter when setting the configuration values.
>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f152953..5f74f92 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2666,6 +2666,28 @@
>              '*header-digest': 'IscsiHeaderDigest',
>              '*timeout': 'int' } }
>  
> +
> +##
> +# @RbdAuthSupport:
> +#
> +# An enumeration of RBD auth support
> +#
> +# Since: 2.9
> +##
> +{ 'enum': 'RbdAuthSupport',
> +  'data': [ 'cephx', 'none' ] }
> +
> +
> +##
> +# @RbdAuthMethod:
> +#
> +# An enumeration of rados auth_supported types
> +#
> +# Since: 2.9
> +##
> +{ 'struct': 'RbdAuthMethod',
> +  'data': { 'auth': 'RbdAuthSupport' } }
> +

Any particular reason for wrapping the enum in a struct?  Do you
envisage adding members to the struct?

>  ##
>  # @BlockdevOptionsRbd:
>  #
> @@ -2681,6 +2703,11 @@
>  #
>  # @user:               #optional Ceph id name.
>  #
> +# @server:             #optional Monitor host address and port.  This maps
> +#                      to the "mon_host" Ceph option.

Suggest something like "Monitor addresses", for consistency with how we
document *SocketAddress members elsewhere, and plural to hint at it
being a list, not just one.

> +#
> +# @auth-supported:     #optional Authentication supported.
> +#
>  # @password-secret:    #optional The ID of a QCryptoSecret object providing
>  #                      the password for the login.
>  #
> @@ -2692,6 +2719,8 @@
>              '*conf': 'str',
>              '*snapshot': 'str',
>              '*user': 'str',
> +            '*server': ['InetSocketAddress'],
> +            '*auth-supported': ['RbdAuthMethod'],
>              '*password-secret': 'str' } }
>  
>  ##
