Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0PW-0005Fr-8h
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ep0Ow-0001jY-V1
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:36:22 -0500
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-16-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d6fd1420-a752-29fd-06be-ae92cf7add08@redhat.com>
Date: Thu, 22 Feb 2018 17:34:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180221135404.27598-16-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 15/36] file-posix: Support
 .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to file, which enables
> image creation over QMP.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   qapi/block-core.json | 20 +++++++++++++-
>   block/file-posix.c   | 77 +++++++++++++++++++++++++++++++++++++---------------
>   2 files changed, 74 insertions(+), 23 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 359195a1a3..0040795603 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3359,6 +3359,24 @@
>   { 'command': 'blockdev-del', 'data': { 'node-name': 'str' } }
>   
>   ##
> +# @BlockdevCreateOptionsFile:
> +#
> +# Driver specific image creation options for file.
> +#
> +# @filename         Filename for the new image file

Does this allow /dev/fdset magic filenames, for when libvirt has to 
pre-create a file and assign correct SELinux permissions, then hand the 
fd over the monitor, but where qemu then takes over the rest of the 
creation task?  What tasks remain in file-posix creation, you ask?...

> +# @size             Size of the virtual disk in bytes
> +# @preallocation    Preallocation mode for the new image (default: off)

...why, of course, a non-default preallocation.  It would be nice to 
hand a 0-byte fd to qemu, then let qemu uniformly truncate it to its 
desired size, using whatever preallocation strategy is supported, rather 
than having to have libvirt worry about preallocation in addition to 
SELinux labeling.  Especially once we get an async command variant 
working, where we can track progress, given that some forms of 
preallocation take a while.  And we may someday still reach the policy 
decision where we can block qemu from directly calling open().

> +# @nocow            Turn off copy-on-write (valid only on btrfs; default: off)
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsFile',
> +  'data': { 'filename':         'str',
> +            'size':             'size',
> +            '*preallocation':   'PreallocMode',
> +            '*nocow':           'bool' } }
> +

I think I asked earlier why size is mandatory at this layer, but I'm 
still okay with that.

Hmm, since "creating" a file can be a destructive operation (if size 
requires a downwards truncation, or even if we intentionally wipe the 
first sector so that any prior bits that resemble a different format are 
no longer visible, or if preallocation explicitly wipes the entire 
image...), do we want to have any safeguards in place so that creation 
is attempted only on a newly-opened BDS, or with a force flag if size 
does not match the current size, or so on?  That's more a question for 
the x-blockdev-create command though, so it doesn't stop review of this 
patch.


>   
> -    fd = qemu_open(filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
> +    /* Create file */
> +    fd = qemu_open(file_opts->filename, O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
>                      0644);

At any rate, qemu_open() means that we be supporting /dev/fdset magic on 
a passed-in fd.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
