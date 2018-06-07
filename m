Received: from eggs.gnu.org ([2001:4830:134:3::10]:51666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQzi5-0000xt-Fs
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQzi4-0004ru-HP
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:32:33 -0400
References: <1528382429-13478-1-git-send-email-ari@tuxera.com>
	<1528382429-13478-3-git-send-email-ari@tuxera.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <337a4d38-397e-a251-b387-27034140d94d@redhat.com>
Date: Thu, 7 Jun 2018 13:32:24 -0500
MIME-Version: 1.0
In-Reply-To: <1528382429-13478-3-git-send-email-ari@tuxera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/10] block: Add blklogwrites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ari Sundholm <ari@tuxera.com>, qemu-devel@nongnu.org
Cc: Aapo Vienamo <aapo@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 06/07/2018 09:40 AM, Ari Sundholm wrote:
> From: Aapo Vienamo <aapo@tuxera.com>
> 
> Implements a block device write logging system, similar to Linux kernel
> device mapper dm-log-writes. The write operations that are performed
> on a block device are logged to a file or another block device. The
> write log format is identical to the dm-log-writes format. Currently,
> log markers are not supported.
> 
> This functionality can be used for crash consistency and fs consistency
> testing. By implementing it in qemu, tests utilizing write logs can be
> be used to test non-Linux drivers and older kernels.
> 
> The implementation is based on the blkverify and blkdebug block drivers.
> 
> Signed-off-by: Aapo Vienamo <aapo@tuxera.com>
> Signed-off-by: Ari Sundholm <ari@tuxera.com>
> ---

> +++ b/qapi/block-core.json
> @@ -2429,12 +2429,12 @@
>   # Since: 2.9
>   ##
>   { 'enum': 'BlockdevDriver',

Missing a comment:

# @blklogwrites: Since 3.0

> -  'data': [ 'blkdebug', 'blkverify', 'bochs', 'cloop', 'copy-on-read',
> -            'dmg', 'file', 'ftp', 'ftps', 'gluster', 'host_cdrom',
> -            'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
> -            'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
> -            'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> -            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> +  'data': [ 'blkdebug', 'blklogwrites', 'blkverify', 'bochs', 'cloop',
> +            'copy-on-read', 'dmg', 'file', 'ftp', 'ftps', 'gluster',
> +            'host_cdrom', 'host_device', 'http', 'https', 'iscsi', 'luks',
> +            'nbd', 'nfs', 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',
> +            'qcow2', 'qed', 'quorum', 'raw', 'rbd', 'replication', 'sheepdog',
> +            'ssh', 'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
>   
>   ##
>   # @BlockdevOptionsFile:
> @@ -2949,6 +2949,21 @@
>               '*set-state': ['BlkdebugSetStateOptions'] } }
>   
>   ##
> +# @BlockdevOptionsBlklogwrites:
> +#
> +# Driver specific block device options for blklogwrites.
> +#
> +# @raw:     block device
> +#
> +# @log:     block device used to log writes on @raw
> +#
> +# Since: foo

s/foo/3.0/

> +##
> +{ 'struct': 'BlockdevOptionsBlklogwrites',
> +  'data': { 'raw': 'BlockdevRef',
> +            'log': 'BlockdevRef' } }
> +
> +##
>   # @BlockdevOptionsBlkverify:
>   #
>   # Driver specific block device options for blkverify.
> @@ -3443,6 +3458,7 @@
>     'discriminator': 'driver',
>     'data': {
>         'blkdebug':   'BlockdevOptionsBlkdebug',
> +      'blklogwrites': 'BlockdevOptionsBlklogwrites',
>         'blkverify':  'BlockdevOptionsBlkverify',
>         'bochs':      'BlockdevOptionsGenericFormat',
>         'cloop':      'BlockdevOptionsGenericFormat',
> @@ -3971,6 +3987,7 @@
>     'discriminator': 'driver',
>     'data': {
>         'blkdebug':       'BlockdevCreateNotSupported',
> +      'blklogwrites':   'BlockdevCreateNotSupported',
>         'blkverify':      'BlockdevCreateNotSupported',
>         'bochs':          'BlockdevCreateNotSupported',
>         'cloop':          'BlockdevCreateNotSupported',
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
