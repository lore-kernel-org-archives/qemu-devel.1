Received: from eggs.gnu.org ([209.51.188.92]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdx9-00016j-9a
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:54:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpdjD-0003im-Hq
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:39:53 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Fri, 01 Feb 2019 19:39:44 +0100
In-Reply-To: <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	(Andrey Shinkevich's message of "Thu, 31 Jan 2019 16:46:44 +0300")
Message-ID: <87pnsbxsi7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> In the 'Format specific information' section of the 'qemu-img info'
> command output, the supplemental information about existing QCOW2
> bitmaps will be shown, such as a bitmap name, flags and granularity:
>
> image: /vz/vmprivate/VM1/harddisk.hdd
> file format: qcow2
> virtual size: 64G (68719476736 bytes)
> disk size: 3.0M
> cluster_size: 1048576
> Format specific information:
>     compat: 1.1
>     lazy refcounts: true
>     bitmaps:
>         [0]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up1
>             unknown flags: 4
>             granularity: 65536
>         [1]:
>             flags:
>                 [0]: in-use
>                 [1]: auto
>             name: back-up2
>             unknown flags: 8
>             granularity: 65536
>     refcount bits: 16
>     corrupt: false
>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 91685be..271e0df 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -69,6 +69,8 @@
>  # @encrypt: details about encryption parameters; only set if image
>  #           is encrypted (since 2.10)
>  #
> +# @bitmaps: A list of qcow2 bitmap details (since 4.0)
> +#
>  # Since: 1.7
>  ##
>  { 'struct': 'ImageInfoSpecificQCow2',
> @@ -77,7 +79,8 @@
>        '*lazy-refcounts': 'bool',
>        '*corrupt': 'bool',
>        'refcount-bits': 'int',
> -      '*encrypt': 'ImageInfoSpecificQCow2Encryption'
> +      '*encrypt': 'ImageInfoSpecificQCow2Encryption',
> +      '*bitmaps': ['Qcow2BitmapInfo']
>    } }
>  
>  ##
> @@ -454,6 +457,41 @@
>             'status': 'DirtyBitmapStatus'} }
>  
>  ##
> +# @Qcow2BitmapInfoFlags:
> +#
> +# An enumeration of flags that a bitmap can report to the user.
> +#
> +# @in-use: The bitmap was not saved correctly and may be inconsistent.

I doubt the casual reader could guess the meaning from the name.  What
about @dirty?

> +#
> +# @auto: The bitmap must reflect all changes of the virtual disk by any
> +#        application that would write to this qcow2 file.
> +#
> +# Since: 4.0
> +##
> +{ 'enum': 'Qcow2BitmapInfoFlags',
> +  'data': ['in-use', 'auto'] }
> +
> +##
> +# @Qcow2BitmapInfo:
> +#
> +# Qcow2 bitmap information.
> +#
> +# @name: the name of the bitmap
> +#
> +# @granularity: granularity of the bitmap in bytes
> +#
> +# @flags: recognized flags of the bitmap
> +#
> +# @unknown-flags: any remaining flags not recognized by the current qemu version

Intended use cases for @unknown-flags?

> +#
> +# Since: 4.0
> +##
> +{ 'struct': 'Qcow2BitmapInfo',
> +  'data': {'name': 'str', 'granularity': 'uint32',
> +           'flags': ['Qcow2BitmapInfoFlags'],
> +           '*unknown-flags': 'uint32' } }
> +
> +##
>  # @BlockLatencyHistogramInfo:
>  #
>  # Block latency histogram.
