Received: from eggs.gnu.org ([2001:4830:134:3::10]:45008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL8I-0000vd-RG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL8F-0002kK-Of
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:56:46 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:51817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1evL8F-0002jE-H9
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:56:43 -0400
Received: by mail-wm0-x244.google.com with SMTP id h21so15525104wmd.1
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 03:56:43 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <152084575964.24079.3708480492746701627.stgit@bahia.lan>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1e0d13df-55cb-809d-7c88-ae198e49ea60@amsat.org>
Date: Mon, 12 Mar 2018 11:56:41 +0100
MIME-Version: 1.0
In-Reply-To: <152084575964.24079.3708480492746701627.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] 9p: add trace event for v9fs_setattr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

On 03/12/2018 10:09 AM, Greg Kurz wrote:
> Don't print the tv_nsec part of atime and mtime, to stay below the 10
> argument limit of trace events.

If you really need it you can print it with trace_v9fs_setattr_return().

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/9pfs/9p.c         |    5 +++++
>  hw/9pfs/trace-events |    2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 64f3bb976c92..33825e16c150 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1196,6 +1196,10 @@ static void coroutine_fn v9fs_setattr(void *opaque)
>          goto out_nofid;
>      }
>  
> +    trace_v9fs_setattr(pdu->tag, pdu->id, fid,
> +                       v9iattr.valid, v9iattr.mode, v9iattr.uid, v9iattr.gid,
> +                       v9iattr.size, v9iattr.atime_sec, v9iattr.mtime_sec);
> +
>      fidp = get_fid(pdu, fid);
>      if (fidp == NULL) {
>          err = -EINVAL;
> @@ -1260,6 +1264,7 @@ static void coroutine_fn v9fs_setattr(void *opaque)
>          }
>      }
>      err = offset;
> +    trace_v9fs_setattr_return(pdu->tag, pdu->id);
>  out:
>      put_fid(pdu, fidp);
>  out_nofid:
> diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
> index 1aee350c42f1..881e4c4dd80b 100644
> --- a/hw/9pfs/trace-events
> +++ b/hw/9pfs/trace-events
> @@ -46,3 +46,5 @@ v9fs_xattrwalk_return(uint16_t tag, uint8_t id, int64_t size) "tag %d id %d size
>  v9fs_xattrcreate(uint16_t tag, uint8_t id, int32_t fid, char* name, uint64_t size, int flags) "tag %d id %d fid %d name %s size %"PRIu64" flags %d"
>  v9fs_readlink(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
>  v9fs_readlink_return(uint16_t tag, uint8_t id, char* target) "tag %d id %d name %s"
> +v9fs_setattr(uint16_t tag, uint8_t id, int32_t fid, int32_t valid, int32_t mode, int32_t uid, int32_t gid, int64_t size, int64_t atime_sec, int64_t mtime_sec) "tag %u id %u fid %d iattr={valid %d mode %d uid %d gid %d size %"PRId64" atime=%"PRId64" mtime=%"PRId64" }"
> +v9fs_setattr_return(uint16_t tag, uint8_t id) "tag %u id %u"
> 
> 
