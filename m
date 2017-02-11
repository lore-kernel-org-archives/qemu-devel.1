Received: from eggs.gnu.org ([2001:4830:134:3::10]:52917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPFU-0005Mm-7h
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:25:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPFR-0003SA-3J
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:25:24 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34517)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ccPFQ-0003Rx-Vg
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 23:25:21 -0500
Received: by mail-qk0-x241.google.com with SMTP id e1so7566137qkh.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 20:25:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <148640163738.20116.15256467457494672940.stgit@bahia>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c5731fb9-3768-499b-d5ae-d1087f47619c@amsat.org>
Date: Sat, 11 Feb 2017 01:25:17 -0300
MIME-Version: 1.0
In-Reply-To: <148640163738.20116.15256467457494672940.stgit@bahia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Hi Greg,

On 02/06/2017 02:20 PM, Greg Kurz wrote:
> Replies from the virtfs proxy are made up of a fixed-size header (8 bytes)
> and a payload of variable size (maximum 64kb). When receiving a reply,
> the proxy backend first reads the whole header and then unmarshals it.
> If the header is okay, it then does the same operation with the payload.
>
> Since the proxy backend uses a pre-allocated buffer which has enough room
> for a header and the maximum payload size, marshalling should never fail
> with fixed size arguments. Let's make this clear with assertions.
>
> This should also address Coverity's complaints CID 1348519 and CID 1348520,
> about not always checking the return value of proxy_unmarshal().
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-proxy.c |   22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index f4aa7a9d70f8..4ad42a1ad158 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>          return retval;
>      }
>      reply->iov_len = PROXY_HDR_SZ;
> -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> +    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> +    assert(retval == 8);

I'd be more specific:

assert(retval == PROXY_HDR_SZ);

>      /*
>       * if response size > PROXY_MAX_IO_SZ, read the response but ignore it and
>       * return -ENOBUFS
> @@ -194,9 +195,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>      if (header.type == T_ERROR) {
>          int ret;
>          ret = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> -        if (ret < 0) {
> -            *status = ret;
> -        }
> +        assert(ret == 4);

assert(ret == sizeof(status));

>          return 0;
>      }
>
> @@ -213,6 +212,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>                                   &prstat.st_atim_sec, &prstat.st_atim_nsec,
>                                   &prstat.st_mtim_sec, &prstat.st_mtim_nsec,
>                                   &prstat.st_ctim_sec, &prstat.st_ctim_nsec);
> +        assert(retval == sizeof(prstat));
>          prstat_to_stat(response, &prstat);
>          break;
>      }
> @@ -225,6 +225,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>                                   &prstfs.f_files, &prstfs.f_ffree,
>                                   &prstfs.f_fsid[0], &prstfs.f_fsid[1],
>                                   &prstfs.f_namelen, &prstfs.f_frsize);
> +        assert(retval == sizeof(prstfs));
>          prstatfs_to_statfs(response, &prstfs);
>          break;
>      }
> @@ -246,7 +247,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, int type,
>          break;
>      }
>      case T_GETVERSION:
> -        proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
> +        retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
> +        assert(retval == 8);

assert(retval == PROXY_HDR_SZ);

>          break;
>      default:
>          return -1;
> @@ -274,18 +276,16 @@ static int v9fs_receive_status(V9fsProxy *proxy,
>          return retval;
>      }
>      reply->iov_len = PROXY_HDR_SZ;
> -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> -    if (header.size != sizeof(int)) {
> -        *status = -ENOBUFS;
> -        return 0;
> -    }
> +    retval = proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> +    assert(retval == 8);

same

>      retval = socket_read(proxy->sockfd,
>                           reply->iov_base + PROXY_HDR_SZ, header.size);
>      if (retval < 0) {
>          return retval;
>      }
>      reply->iov_len += header.size;
> -    proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> +    retval = proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> +    assert(retval == 4);

assert(ret == sizeof(status));

>      return 0;
>  }
>
>
>
