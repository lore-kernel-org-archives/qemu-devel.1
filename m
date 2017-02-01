Received: from eggs.gnu.org ([2001:4830:134:3::10]:37957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYwWs-0001xJ-GN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYwWn-0000j2-RC
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:09:02 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:34297 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cYwWn-0000ia-Bi
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 10:08:57 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1485249848-13854-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1485249848-13854-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1485249848-13854-2-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Wed, 01 Feb 2017 16:08:36 +0100
Message-ID: <w51a8a6rlsb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2 v14] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

Hello, and sorry for being late reviewing these patches :)

On Tue 24 Jan 2017 10:24:07 AM CET, Pradeep Jagadeesh <pradeepkiruvale@gmail.com> wrote:

> This patchset adds the io throttle support for the 9p-local driver.
> For now this functionality can be used only through qemu cli options.
> QMP interface and support to other 9p drivers need further extensions.
> To make it simple for other 9p drivers, the throttle code has been put
> in separate files.

Compared to the previous patch that I reviewed, you removed the
fsdev_throttle_cleanup() call from v9fs_device_unrealize_common(). Why
did you do that?

I miss the list of changes in the cover letter.

> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3520,6 +3520,10 @@ int v9fs_device_realize_common(V9fsState *s, Error **errp)
>          error_setg(errp, "share path %s is not a directory", fse->path);
>          goto out;
>      }
> +
> +    s->ctx.fst = &fse->fst;
> +    fsdev_throttle_init(s->ctx.fst);
> +
>      v9fs_path_free(&path);
>  
>      rc = 0;
> @@ -3528,6 +3532,7 @@ out:
>          if (s->ops && s->ops->cleanup && s->ctx.private) {
>              s->ops->cleanup(&s->ctx);
>          }
> +        fsdev_throttle_cleanup(s->ctx.fst);
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
>          v9fs_path_free(&path);

You also added the fsdev_throttle_cleanup() here, but look at the code:

       fsdev_throttle_init(s->ctx.fst);

       v9fs_path_free(&path);

       rc = 0;
   out:
       if (rc) {
           /* ... */
           fsdev_throttle_cleanup(s->ctx.fst);
           /* ... */
       }

If rc != 0 you don't need to do the clean up, because there was never an
initialization.

Berto
