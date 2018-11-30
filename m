Received: from eggs.gnu.org ([2001:4830:134:3::10]:60663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSr6Z-00018P-6e
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gSr6Y-0002wY-7i
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:17:47 -0500
Date: Fri, 30 Nov 2018 22:17:35 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181130221735.GY27120@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-2-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130220344.3350618-2-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/14] qemu-nbd: Use program name in error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, nsoffer@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Fri, Nov 30, 2018 at 04:03:30PM -0600, Eric Blake wrote:
> This changes output from:
> 
> $ qemu-nbd nosuch
> Failed to blk_new_open 'nosuch': Could not open 'nosuch': No such file or directory
> 
> to something more consistent with qemu-img and qemu:
> 
> $ qemu-nbd nosuch
> qemu-nbd: Failed to blk_new_open 'nosuch': Could not open 'nosuch': No such file or directory
> 
> Update the lone affected test to match.  (Hmm - is it sad that we don't
> do much testing of expected failures?)
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.c                 | 1 +
>  tests/qemu-iotests/233.out | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index ca7109652e5..e169b839ece 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -571,6 +571,7 @@ int main(int argc, char **argv)
>  #endif
> 
>      module_call_init(MODULE_INIT_TRACE);
> +    error_set_progname(argv[0]);
>      qcrypto_init(&error_fatal);
> 
>      module_call_init(MODULE_INIT_QOM);
> diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
> index 94acd9b9479..5f416721b03 100644
> --- a/tests/qemu-iotests/233.out
> +++ b/tests/qemu-iotests/233.out
> @@ -27,7 +27,7 @@ virtual size: 64M (67108864 bytes)
>  disk size: unavailable
> 
>  == check TLS with different CA fails ==
> -option negotiation failed: Verify failed: No certificate was found.
> +qemu-nbd: option negotiation failed: Verify failed: No certificate was found.
>  qemu-img: Could not open 'driver=nbd,host=127.0.0.1,port=PORT,tls-creds=tls0': The certificate hasn't got a known issuer
> 
>  == perform I/O over TLS ==

Same as done in qemu (vl.c) and qemu-img.c, so:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
Fedora Windows cross-compiler. Compile Windows programs, test, and
build Windows installers. Over 100 libraries supported.
http://fedoraproject.org/wiki/MinGW
