Received: from eggs.gnu.org ([2001:4830:134:3::10]:54554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDznu-0001u5-WE
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDznu-0002AQ-6Y
	for qemu-devel@nongnu.org; Wed, 02 May 2018 18:00:51 -0400
References: <20180502202051.15493-1-mreitz@redhat.com>
	<20180502202051.15493-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eeef06be-6c71-df6a-6aeb-8a7c23316dee@redhat.com>
Date: Wed, 2 May 2018 17:00:42 -0500
MIME-Version: 1.0
In-Reply-To: <20180502202051.15493-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use only string options in
 img_open_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 05/02/2018 03:20 PM, Max Reitz wrote:
> img_open_opts() takes a QemuOpts and converts them to a QDict, so all
> values therein are strings.  Then it may try to call qdict_get_bool(),
> however, which will fail with a segmentation fault every time:

I have no idea if it's worth fixing qdict_get_bool() to at least not 
segfault when called on a non-bool Dict member (but what should it 
return, true or false? or should it abort() for at least a cleaner 
failure than a segfault?)

But in the meantime, your fix is correct.

> 
> $ ./qemu-img info -U --image-opts \
>      driver=file,filename=/dev/null,force-share=off
> [1]    27869 segmentation fault (core dumped)  ./qemu-img info -U
> --image-opts driver=file,filename=/dev/null,force-share=off
> 
> Fix this by using qdict_get_str() and comparing the value as a string.
> Also, when adding a force-share value to the QDict, add it as a string
> so it fits the rest of the dict.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
