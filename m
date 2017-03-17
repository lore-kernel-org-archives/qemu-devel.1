Received: from eggs.gnu.org ([2001:4830:134:3::10]:49262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cot5w-0002lG-Q0
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cot5t-0007yp-2y
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:43:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cot5s-0007yc-R1
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:43:05 -0400
Date: Fri, 17 Mar 2017 14:43:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170317144300.GK8050@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148976155089.11859.11860739290129101204.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148976155089.11859.11860739290129101204.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On Fri, Mar 17, 2017 at 03:39:10PM +0100, Greg Kurz wrote:
> Replies from the virtfs proxy are made up of a fixed-size header (8 bytes)
> and a payload of variable size (maximum 64kb). When receiving a reply,
> the proxy backend first reads the whole header and then unmarshals it.
> If the header is okay, it then does the same operation with the payload.
> 
> Since the proxy backend uses a pre-allocated buffer which has enough room
> for a header and the maximum payload size, marshalling should never fail
> with fixed size arguments. Any error here is likely to result from a more
> serious corruption in QEMU and we'd better dump core right away.
> 
> This patch adds error checks where they are missing and converts the
> associated error paths into assertions.
> 
> Note that we don't want to use sizeof() in the checks since the value
> we want to use depends on the format rather than the size of the buffer.
> Short marshal formats can be handled with numerical values. Size macros
> are introduced for bigger ones (ProxyStat and ProxyStatFS).
> 
> This should also address Coverity's complaints CID 1348519 and CID 1348520,
> about not always checking the return value of proxy_unmarshal().
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - added PROXY_STAT_SZ and PROXY_STATFS_SZ macros
>     - updated changelog
> ---
>  hw/9pfs/9p-proxy.c |   24 +++++++++++++-----------
>  hw/9pfs/9p-proxy.h |   10 ++++++++--
>  2 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index f4aa7a9d70f8..363bea66035e 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>          return retval;
>      }
>      reply->iov_len = PROXY_HDR_SZ;
> -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> +    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> +    assert(retval == 8);
>      /*
>       * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
>       * return -ENOBUFS
> @@ -194,15 +195,14 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>      if (header.type == T_ERROR) {
>          int ret;
>          ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> -        if (ret < 0) {
> -            *status = ret;
> -        }
> +        assert(ret == 4);
>          return 0;
>      }
>  
>      switch (type) {
>      case T_LSTAT: {
>          ProxyStat prstat;
> +        QEMU_BUILD_BUG_ON(sizeof(prstat) != PROXY_STAT_SZ);

I'd just put this assert at the struct declaration

..snip...

> diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
> index b84301d001b0..918c45016a3c 100644
> --- a/hw/9pfs/9p-proxy.h
> +++ b/hw/9pfs/9p-proxy.h
> @@ -79,7 +79,10 @@ typedef struct {
>      uint64_t st_mtim_nsec;
>      uint64_t st_ctim_sec;
>      uint64_t st_ctim_nsec;
> -} ProxyStat;
> +} QEMU_PACKED ProxyStat;
> +
> +#define PROXY_STAT_SZ \
> +    (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8)

eg.

  QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=
      (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8));


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
