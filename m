Received: from eggs.gnu.org ([2001:4830:134:3::10]:51686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqOSf-0004db-Up
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqOSb-0000yD-SF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:01:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45684 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqOSb-0000y7-Nz
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 16:01:33 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<82b093e763e784aea8f8a4e589318b25146a3a24.1534409363.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <abbc398b-0ded-5531-aba5-bd95200c937c@redhat.com>
Date: Thu, 16 Aug 2018 15:01:31 -0500
MIME-Version: 1.0
In-Reply-To: <82b093e763e784aea8f8a4e589318b25146a3a24.1534409363.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 6/7] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

On 08/16/2018 04:01 AM, Simon Ruderich wrote:
> Adapted patch from Baojun Wang [1] with the following commit message:
> 
>      I found this could be useful to have qemu-softmmu as a cross
>      debugger (launch with -s -S command line option), then if we can
>      have a command to load guest physical memory, we can use cross gdb
>      to do some target debug which gdb cannot do directly.
> 
> This patch contains only the qmp changes of the original patch.
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

> +    }
> +    if (!has_size) {
> +        struct stat s;
> +        if (fstat(fd, &s)) {
> +            error_setg_errno(errp, errno, "could not fstat fd to get size");
> +            goto exit;
> +        }
> +        size = s.st_size;
> +    }

This works for regular files, but not for block devices.

Do we have a helper function for easily determining the size of an 
arbitrary fd (whether file or block device)?  If not, should we?  As 
there are multiple spots in the code that grab this sort of information.

Otherwise looks okay to me.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
