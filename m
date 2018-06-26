Received: from eggs.gnu.org ([2001:4830:134:3::10]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXoTg-0001DB-7P
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXoTc-00047o-Vu
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:57:52 -0400
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:41092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXoTc-0003vl-Ln
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 09:57:48 -0400
Received: from player168.ha.ovh.net (unknown [10.109.108.34])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id F28271BF496
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 15:57:46 +0200 (CEST)
Date: Tue, 26 Jun 2018 15:57:43 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180626155743.0c4472e3@bahia.lan>
In-Reply-To: <7cdeccb2d0f1b5543c07f40bb053769744ae9777.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<7cdeccb2d0f1b5543c07f40bb053769744ae9777.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/13] 9p: darwin: Compatibility for
 f/l*xattr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Sat, 16 Jun 2018 20:56:53 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> On darwin `fgetxattr` takes two extra optional arguments,
> and the l* variants are not defined (in favor of an extra
> flag to the regular variants.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  Makefile                    |  6 ++++++
>  fsdev/virtfs-proxy-helper.c |  9 +++++----
>  hw/9pfs/9p-local.c          | 12 ++++++++----
>  hw/9pfs/9p-util.h           | 17 +++++++++++++++++
>  4 files changed, 36 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e46f2b6..046e553 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -545,7 +545,13 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
>  qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
>  
>  fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
> +ifdef CONFIG_DARWIN
> +fsdev/virtfs-proxy-helper$(EXESUF): hw/9pfs/9p-util-darwin.o
> +endif
> +ifdef CONFIG_LINUX
> +fsdev/virtfs-proxy-helper$(EXESUF): hw/9pfs/9p-util-linux.o
>  fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
> +endif
>  
>  scsi/qemu-pr-helper$(EXESUF): scsi/qemu-pr-helper.o scsi/utils.o $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
>  ifdef CONFIG_MPATH
> diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
> index 3bc1269..a26f8b8 100644
> --- a/fsdev/virtfs-proxy-helper.c
> +++ b/fsdev/virtfs-proxy-helper.c
> @@ -28,6 +28,7 @@
>  #include "qemu/statfs.h"
>  #include "9p-iov-marshal.h"
>  #include "hw/9pfs/9p-proxy.h"
> +#include "hw/9pfs/9p-util.h"
>  #include "fsdev/9p-iov-marshal.h"
>  
>  #define PROGNAME "virtfs-proxy-helper"
> @@ -459,7 +460,7 @@ static int do_getxattr(int type, struct iovec *iovec, struct iovec *out_iovec)
>          v9fs_string_init(&name);
>          retval = proxy_unmarshal(iovec, offset, "s", &name);
>          if (retval > 0) {
> -            retval = lgetxattr(path.data, name.data, xattr.data, size);
> +            retval = qemu_lgetxattr(path.data, name.data, xattr.data, size);
>              if (retval < 0) {
>                  retval = -errno;
>              } else {
> @@ -469,7 +470,7 @@ static int do_getxattr(int type, struct iovec *iovec, struct iovec *out_iovec)
>          v9fs_string_free(&name);
>          break;
>      case T_LLISTXATTR:
> -        retval = llistxattr(path.data, xattr.data, size);
> +        retval = qemu_llistxattr(path.data, xattr.data, size);
>          if (retval < 0) {
>              retval = -errno;
>          } else {
> @@ -1000,7 +1001,7 @@ static int process_requests(int sock)
>              retval = proxy_unmarshal(&in_iovec, PROXY_HDR_SZ, "sssdd", &path,
>                                       &name, &value, &size, &flags);
>              if (retval > 0) {
> -                retval = lsetxattr(path.data,
> +                retval = qemu_lsetxattr(path.data,
>                                     name.data, value.data, size, flags);
>                  if (retval < 0) {
>                      retval = -errno;
> @@ -1016,7 +1017,7 @@ static int process_requests(int sock)
>              retval = proxy_unmarshal(&in_iovec,
>                                       PROXY_HDR_SZ, "ss", &path, &name);
>              if (retval > 0) {
> -                retval = lremovexattr(path.data, name.data);
> +                retval = qemu_lremovexattr(path.data, name.data);
>                  if (retval < 0) {
>                      retval = -errno;
>                  }
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 98d4073..768ef6f 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -776,16 +776,20 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
>          mode_t tmp_mode;
>          dev_t tmp_dev;
>  
> -        if (fgetxattr(fd, "user.virtfs.uid", &tmp_uid, sizeof(uid_t)) > 0) {
> +        if (qemu_fgetxattr(fd, "user.virtfs.uid",
> +                           &tmp_uid, sizeof(uid_t)) > 0) {
>              stbuf->st_uid = le32_to_cpu(tmp_uid);
>          }
> -        if (fgetxattr(fd, "user.virtfs.gid", &tmp_gid, sizeof(gid_t)) > 0) {
> +        if (qemu_fgetxattr(fd, "user.virtfs.gid",
> +                           &tmp_gid, sizeof(gid_t)) > 0) {
>              stbuf->st_gid = le32_to_cpu(tmp_gid);
>          }
> -        if (fgetxattr(fd, "user.virtfs.mode", &tmp_mode, sizeof(mode_t)) > 0) {
> +        if (qemu_fgetxattr(fd, "user.virtfs.mode",
> +                           &tmp_mode, sizeof(mode_t)) > 0) {
>              stbuf->st_mode = le32_to_cpu(tmp_mode);
>          }
> -        if (fgetxattr(fd, "user.virtfs.rdev", &tmp_dev, sizeof(dev_t)) > 0) {
> +        if (qemu_fgetxattr(fd, "user.virtfs.rdev",
> +                           &tmp_dev, sizeof(dev_t)) > 0) {
>              stbuf->st_rdev = le64_to_cpu(tmp_dev);
>          }
>      } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index 79ed6b2..50a03c7 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -19,6 +19,23 @@
>  #define O_PATH_9P_UTIL 0
>  #endif
>  
> +#ifdef CONFIG_DARWIN
> +#define qemu_fgetxattr(...) fgetxattr(__VA_ARGS__, 0, 0)
> +#define qemu_lgetxattr(...) getxattr(__VA_ARGS__, 0, XATTR_NOFOLLOW)
> +#define qemu_llistxattr(...) listxattr(__VA_ARGS__, XATTR_NOFOLLOW)
> +#define qemu_lremovexattr(...) removexattr(__VA_ARGS__, XATTR_NOFOLLOW)
> +static inline int qemu_lsetxattr(const char *path, const char *name,
> +                                 const void *value, size_t size, int flags) {
> +    return setxattr(path, name, value, size, 0, flags | XATTR_NOFOLLOW);
> +}
> +#else
> +#define qemu_fgetxattr fgetxattr
> +#define qemu_lgetxattr lgetxattr
> +#define qemu_llistxattr llistxattr
> +#define qemu_lremovexattr lremovexattr
> +#define qemu_lsetxattr lsetxattr
> +#endif
> +
>  static inline void close_preserve_errno(int fd)
>  {
>      int serrno = errno;
