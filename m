Received: from eggs.gnu.org ([2001:4830:134:3::10]:59785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjrhx-0005nj-Vz
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjrhu-00005t-6m
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:13:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjrhu-000057-0w
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:13:34 -0500
Date: Fri, 3 Mar 2017 18:13:29 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170303181329.GO13631@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148856422757.9841.6298006998523421948.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fail local_statfs() earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Fri, Mar 03, 2017 at 07:03:47PM +0100, Greg Kurz wrote:
> If we cannot open the given path, we can return right away instead of
> passing -1 to fstatfs() and close(). This will make Coverity happy.
> 
> (Coverity issue CID1371729)
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index fe930300445a..ea9a1ced0394 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1053,6 +1053,9 @@ static int local_statfs(FsContext *s, V9fsPath *fs_path, struct statfs *stbuf)
>      int fd, ret;
>  
>      fd = local_open_nofollow(s, fs_path->data, O_RDONLY, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
>      ret = fstatfs(fd, stbuf);
>      close_preserve_errno(fd);
>      return ret;

Reviewed-by: Daniel P. berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
