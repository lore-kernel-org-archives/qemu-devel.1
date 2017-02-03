Received: from eggs.gnu.org ([2001:4830:134:3::10]:56567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZbFm-0002ku-IK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZbFk-0004IJ-07
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:38:06 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:6111 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZbFj-0004Fu-Ic
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:38:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1486116298-25046-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1486116298-25046-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486116298-25046-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 03 Feb 2017 11:38:01 +0100
Message-ID: <w51o9yjwody.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2 v15] throttle: factor out duplicate code
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

On Fri 03 Feb 2017 11:04:58 AM CET, Pradeep Jagadeesh wrote:

> This patch removes the redundant throttle code that was present in
> block and fsdev device files. Now the common code is moved to a single
> file.

Here it says that this patch moves common code to a separate file,
however:

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 920eb05..22a6a99 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3532,7 +3532,6 @@ out:
>          if (s->ops && s->ops->cleanup && s->ctx.private) {
>              s->ops->cleanup(&s->ctx);
>          }
> -        fsdev_throttle_cleanup(s->ctx.fst);
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
>          v9fs_path_free(&path);
> @@ -3545,6 +3544,7 @@ void v9fs_device_unrealize_common(V9fsState *s, Error **errp)
>      if (s->ops->cleanup) {
>          s->ops->cleanup(&s->ctx);
>      }
> +    fsdev_throttle_cleanup(s->ctx.fst);
>      g_free(s->tag);
>      g_free(s->ctx.fs_root);
>  }

This doesn't belong here. In patch 1 you add a fsdev_throttle_cleanup()
in v9fs_device_realize_common(), and in patch 2 you remove it from there
and put it in v9fs_device_unrealize_common().

It looks like you wanted to fix patch 1 but added the fix to patch 2
instead.

Berto
