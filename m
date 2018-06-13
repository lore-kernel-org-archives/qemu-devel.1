Received: from eggs.gnu.org ([2001:4830:134:3::10]:46593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT8ER-0005ce-KX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fT8EN-0006aK-Ep
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:02:47 -0400
References: <20180613154711.12977-1-dplotnikov@virtuozzo.com>
	<20180613154711.12977-3-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebef7765-3ea7-b575-69ec-29ae66be561f@redhat.com>
Date: Wed, 13 Jun 2018 11:02:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180613154711.12977-3-dplotnikov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 2/2] qmp: add block-set-copy-on-read
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, den@virtuozzo.com, rkagan@virtuozzo.com

On 06/13/2018 10:47 AM, Denis Plotnikov wrote:
> The command enables/disables copy-on-read mode for VM's disk while
> VM is running.
> 
> This is needed when using external disk readers to shape access pattern
> to the disk backend.
> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---

Deferring thoughts on the actual design for later; this is just a 
cursory implementation review for now.


> +++ b/qapi/block-core.json
> @@ -4701,6 +4701,26 @@
>   { 'command': 'block-set-write-threshold',
>     'data': { 'node-name': 'str', 'write-threshold': 'uint64' } }
>   
> +##
> +# @block-set-copy-on-read:
> +#
> +# Enables and disables the copy-on-read property of a block device.
> +#
> +# @device: device or graph node name on which copy-on-read must be set.
> +#
> +# Since: 2.12

We've missed the 2.12 release.  This should be since 3.0.

> +#
> +# Example:
> +#
> +# -> { "execute": "block-set-copy-on-read",
> +#      "arguments": { "device": "scsi0-0-0-0",
> +#                     "enable": true } }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'block-set-copy-on-read',
> +  'data': { 'device': 'str', 'enable': 'bool' } }

Missing documentation of @enable.

And just checking: is the current copy-on-read setting visible through 
an existing query-* command, or have you just introduced a write-only 
toggle?  If the state can be changed at runtime, then it needs to be 
easy to learn what the current state is.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
