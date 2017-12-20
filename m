Received: from eggs.gnu.org ([2001:4830:134:3::10]:54809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRbyl-0002hv-DG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRbyi-0001EC-Dc
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:52:03 -0500
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-17-kwolf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <974e7f62-412a-21e8-d502-a0e7a99015cc@redhat.com>
Date: Wed, 20 Dec 2017 11:51:27 +0100
MIME-Version: 1.0
In-Reply-To: <20171220103412.13048-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/19] block: Allow graph changes in
 subtree drained section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org

On 20/12/2017 11:34, Kevin Wolf wrote:
>      .inherit_options = bdrv_inherited_options,
>      .drained_begin   = bdrv_child_cb_drained_begin,
>      .drained_end     = bdrv_child_cb_drained_end,
> +    .attach          = bdrv_child_cb_attach,
> +    .detach          = bdrv_child_cb_detach,
>      .inactivate      = bdrv_child_cb_inactivate,
>  };
>  
> @@ -911,6 +933,8 @@ const BdrvChildRole child_format = {
>      .inherit_options = bdrv_inherited_fmt_options,
>      .drained_begin   = bdrv_child_cb_drained_begin,
>      .drained_end     = bdrv_child_cb_drained_end,
> +    .attach          = bdrv_child_cb_attach,
> +    .detach          = bdrv_child_cb_detach,
>      .inactivate      = bdrv_child_cb_inactivate,

Is there any case of a BdrvChildRole that doesn't want these callbacks?
Maybe the functions should be called after ->attach and before ->detach
(e.g. bdrv_{,un}apply_subtree_drain), rather than modifying the
BdrvChildRole implementations.

Then they can be put in block/io.c, and bdrv_do_drained_* can remain
static.  (I would also consider extracting block/drain.c, but it is
painful to do it now that you have this nice series---so let's do it after).

Paolo
