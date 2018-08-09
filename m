Received: from eggs.gnu.org ([2001:4830:134:3::10]:57102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fno5P-0002sc-La
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fno5M-00014v-GZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:46:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45372 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fno5M-00014Q-A7
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 12:46:52 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
	<851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42329ae3-cac6-8519-c8d8-0cfc4489d3c5@redhat.com>
Date: Thu, 9 Aug 2018 11:46:50 -0500
MIME-Version: 1.0
In-Reply-To: <851d095cd457109e4a22a2e5ecd36ccbdacbf48b.1526916378.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

On 05/21/2018 10:36 AM, Simon Ruderich wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
> 
>      I found this could be useful to have qemu-softmmu as a cross
>      debugger (launch with -s -S command line option), then if we can
>      have a command to load guest physical memory, we can use cross gdb
>      to do some target debug which gdb cannot do directly.
> 
> pmemload is necessary to directly write physical memory which is not
> possible with gdb alone as it uses only logical addresses.
> 
> The QAPI for pmemload uses "val" as parameter name for the physical
> address. This name is not very descriptive but is consistent with the
> existing pmemsave. Changing the parameter name of pmemsave is not
> possible without breaking the existing API.
> 
> [1]: https://lists.gnu.org/archive/html/qemu-trivial/2014-04/msg00074.html
> 
> Based-on-patch-by: Baojun Wang <wangbj@gmail.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>   cpus.c          | 41 +++++++++++++++++++++++++++++++++++++++++
>   hmp-commands.hx | 14 ++++++++++++++
>   hmp.c           | 12 ++++++++++++
>   hmp.h           |  1 +
>   qapi/misc.json  | 20 ++++++++++++++++++++
>   5 files changed, 88 insertions(+)

I haven't closely reviewed this, but a quick note:


> +++ b/qapi/misc.json
> @@ -1219,6 +1219,26 @@
>   { 'command': 'pmemsave',
>     'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
>   
> +##
> +# @pmemload:
> +#
> +# Load a portion of guest physical memory from a file.
> +#
> +# @val: the physical address of the guest to start from
> +#
> +# @size: the size of memory region to load
> +#
> +# @offset: the offset in the file to start from
> +#
> +# @filename: the file to load the memory from as binary data
> +#
> +# Returns: Nothing on success
> +#
> +# Since: 2.13

There was no 2.13 release, and this feature has missed the 3.0 
deadlines, so it would need to say 'Since: 3.1'

> +##
> +{ 'command': 'pmemload',
> +  'data': {'val': 'int', 'size': 'int', 'offset': 'int', 'filename': 'str'} }
> +
>   ##
>   # @cont:
>   #
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
