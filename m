Received: from eggs.gnu.org ([2001:4830:134:3::10]:51426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtz09-0002fm-OO
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.dakinevich@gmail.com>) id 1dtz05-00010e-QM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:34:29 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:33151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.dakinevich@gmail.com>)
	id 1dtz05-0000yf-IP
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:34:25 -0400
Received: by mail-lf0-x244.google.com with SMTP id y15so600264lfd.0
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 09:34:24 -0700 (PDT)
References: <150574930075.27635.3945832472060840946.stgit@bahia>
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Message-ID: <34ed6b38-3531-80ba-d281-6c7634244bfb@gmail.com>
Date: Mon, 18 Sep 2017 19:34:21 +0300
MIME-Version: 1.0
In-Reply-To: <150574930075.27635.3945832472060840946.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix readdir() for 9p2000.u
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

Hi Greg,

I am also thinking about this... :-(

As I see, stat_to_v9stat() is also used for symbolic links resolving and
requires full path, not only d_name.

With your patch I have the following:

$ ln -s /usr usr
$ ls -l
ls: reading directory .: Invalid argument
total 0

On 09/18/2017 06:46 PM, Greg Kurz wrote:
> If the client is using 9p2000.u, the following occurs:
> 
> $ cd ${virtfs_shared_dir}
> $ mkdir -p a/b/c
> $ ls a/b
> ls: cannot access 'a/b/a': No such file or directory
> ls: cannot access 'a/b/b': No such file or directory
> a  b  c
> 
> instead of the expected:
> 
> $ ls a/b
> c
> 
> This is a regression introduced by commit f57f5878578a;
> local_name_to_path() now resolves ".." and "." in paths,
> and v9fs_do_readdir_with_stat()->stat_to_v9stat() then
> copies the basename of the resulting path to the response.
> With the example above, this means that "." and ".." are
> turned into "b" and "a" respectively...
> 
> Actually, the name we need to pass is the d_name field of
> the dirent.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> 
> Hi Jan,
> 
> I found this will testing your patches. I'd appreciate if you could
> review this. Then I'll push all these patches to 9p-next and send
> a pull request.
> 
> Thanks,
> 
> --
> Greg
> 
>  hw/9pfs/9p.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 0a37c8bd1361..0474e9e787c0 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1748,6 +1748,9 @@ static int coroutine_fn v9fs_do_readdir_with_stat(V9fsPDU *pdu,
>          if (err < 0) {
>              break;
>          }
> +        v9fs_path_free(&path);
> +
> +        v9fs_path_sprintf(&path, "%s", dent->d_name);
>          err = stat_to_v9stat(pdu, &path, &stbuf, &v9stat);
>          if (err < 0) {
>              break;
> 

-- 
Best regards
Jan Dakinevich
