Received: from eggs.gnu.org ([2001:4830:134:3::10]:53671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDzl5-0000Mi-TX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDzl5-0000wh-1m
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:57:55 -0400
References: <20180502202051.15493-1-mreitz@redhat.com>
	<20180502202051.15493-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b81d302d-f419-7e20-d6c5-cd11b878e7ff@redhat.com>
Date: Wed, 2 May 2018 16:57:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180502202051.15493-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qemu-io: Use purely string blockdev
 options
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
> Currently, qemu-io only uses string-valued blockdev options (as all are
> converted directly from QemuOpts) -- with one exception: -U adds the
> force-share option as a boolean.  This in itself is already a bit
> questionable, but a real issue is that it also assumes the value already
> existing in the options QDict would be a boolean, which is wrong.
> 
> That has the following effect:
> 
> $ ./qemu-io -r -U --image-opts \
>      driver=file,filename=/dev/null,force-share=off
> [1]    15200 segmentation fault (core dumped)  ./qemu-io -r -U
> --image-opts driver=file,filename=/dev/null,force-share=off
> 
> Since @opts is converted from QemuOpts, the value must be a string, and
> we have to compare it as such.  Consequently, it makes sense to also set
> it as a string instead of a boolean.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-io.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

The curse of poor typing in QemuOpts keeps on giving ;)
Adding Markus, so he's aware of yet another wart that his command-line 
cleanups may need to visit.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
