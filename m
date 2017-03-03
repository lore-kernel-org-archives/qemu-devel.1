Received: from eggs.gnu.org ([2001:4830:134:3::10]:36673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnaW-0007O5-6U
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cjnaV-00050x-Do
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:49:40 -0500
Date: Fri, 3 Mar 2017 14:49:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170303134930.GE14351@noname.redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-8-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488491046-2549-8-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/15] sheepdog: Report errors in
 pseudo-filename more usefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Am 02.03.2017 um 22:43 hat Markus Armbruster geschrieben:
> Errors in the pseudo-filename are all reported with the same laconic
> "Can't parse filename" message.
> 
> Add real error reporting, such as:
> 
>     $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepdog:///
>     qemu-system-x86_64: --drive driver=sheepdog,filename=sheepdog:///: missing file path in URI
>     $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepgod:///vdi
>     qemu-system-x86_64: --drive driver=sheepdog,filename=sheepgod:///vdi: URI scheme must be 'sheepdog', 'sheepdog+tcp', or 'sheepdog+unix'
>     $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepdog+unix:///vdi?socke=sheepdog.sock
>     qemu-system-x86_64: --drive driver=sheepdog,filename=sheepdog+unix:///vdi?socke=sheepdog.sock: unexpected query parameters
> 
> The code to translate legacy syntax to URI fails to escape URI
> meta-characters.  The new error messages are misleading then.  Replace
> them by the old "Can't parse filename" message.  "Internal error"
> would be more honest.  Anyway, no worse than before.  Also add a FIXME
> comment.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> @@ -1451,12 +1480,12 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
>      memset(tag, 0, sizeof(tag));
>  
>      if (strstr(filename, "://")) {
> -        ret = sd_parse_uri(s, filename, vdi, &snapid, tag);
> +        sd_parse_uri(s, filename, vdi, &snapid, tag, &local_err);
>      } else {
> -        ret = parse_vdiname(s, filename, vdi, &snapid, tag);
> +        parse_vdiname(s, filename, vdi, &snapid, tag, &local_err);
>      }
> -    if (ret < 0) {
> -        error_setg(errp, "Can't parse filename");
> +    if (local_err) {
> +        error_propagate(errp, local_err);
>          goto out_no_fd;
>      }

I have to take my R-b back, ret isn't set here any more:

block/sheepdog.c: In function 'sd_open':
block/sheepdog.c:1451:9: error: 'ret' may be used uninitialized in this function [-Werror=maybe-uninitialized]
     int ret, fd;

Kevin
