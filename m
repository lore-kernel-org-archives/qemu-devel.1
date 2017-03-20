Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpxBT-0007sO-Ex
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cpxBQ-0004je-86
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cpxBP-0004j8-VC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:17:12 -0400
Date: Mon, 20 Mar 2017 13:17:03 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170320131703.GN3792@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, Jani Kokkonen <jani.kokkonen@huawei.com>, Alberto Garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

On Mon, Mar 20, 2017 at 09:07:20AM -0400, Pradeep Jagadeesh wrote:

> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 8819281..e4e3478 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1637,6 +1637,34 @@ ETEXI
>      },
>  
>  STEXI
> +@item 9p_passwd @var{device} @var{password}
> +@findex 9p_passwd
> +Set the encrypted device @var{device} password to @var{password}
> +ETEXI
> +
> +    {
> +        .name       = "fs9p_set_io_throttle",
> +        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
> +        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
> +        .help       = "change I/O throttle limits for a block drive",
> +        .cmd        = hmp_9pfs_set_io_throttle,
> +    },
> +
> +STEXI
> +@item fs9p_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> +@findex 9pfs_set_io_throttle
> +Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> +ETEXI
> +
> +    {
> +        .name       = "set_password",
> +        .args_type  = "protocol:s,password:s,connected:s?",
> +        .params     = "protocol password action-if-connected",
> +        .help       = "set spice/vnc password",
> +        .cmd        = hmp_set_password,
> +    },
> +
> +STEXI

This looks all mangled wrt password related stuff


> diff --git a/qapi/9pfs.json b/qapi/9pfs.json
> new file mode 100644
> index 0000000..c068474
> --- /dev/null
> +++ b/qapi/9pfs.json
> @@ -0,0 +1,169 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# == QAPI 9p definitions
> +##
> +
> +# QAPI common definitions
> +{ 'include': 'common.json' }
> +
> +##
> +# @fs9p_set_io_throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) device

Is this supposed to be generic for any fsdev impl, or specific to the
9p impl only ? Without knowing more, I'd expect us to really be designing
something generic, and not tied to just the 9p impl. IOW,  having '9p' in
the name of the QAPI commands feels wrong - use of 'fsdev' feels like the
better naming. Same applies to the HMP commands.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
