Received: from eggs.gnu.org ([2001:4830:134:3::10]:53839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi0z0-0004kh-QG
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:20:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fi0yz-0005CV-DS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 13:20:22 -0400
References: <20180724170217.10247-1-lbloch@janustech.com>
	<20180724170217.10247-2-lbloch@janustech.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97a6a52e-6fad-086c-c966-32a16464e918@redhat.com>
Date: Tue, 24 Jul 2018 12:20:14 -0500
MIME-Version: 1.0
In-Reply-To: <20180724170217.10247-2-lbloch@janustech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: Introduce an option for
 sufficient L2 cache for the entire image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Leonid Bloch <lbloch@janustech.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 07/24/2018 12:02 PM, Leonid Bloch wrote:
> An option "l2-cache-full" is introduced to automatically set the qcow2
> L2 cache to a sufficient value for covering the entire image. The memory
> overhead when using this option is not big (1 MB for each 8 GB of
> virtual image size with the default cluster size) and it can noticeably
> improve performance when using large images with frequent I/O.
> Previously, for this functionality the correct L2 cache size needed to
> be calculated manually or with a script, and then this size needed to be
> passed to the "l2-cache-size" option. Now it is sufficient to just pass
> the boolean "l2-cache-full" option.
> 
> Additionally, the documentation for the related options is fixed, and a
> small grammar fix is made in the immediate proximity of the changes.

Is it worth splitting the small grammar fix:


>       if (combined_cache_size_set) {
>           if (l2_cache_size_set && refcount_cache_size_set) {
>               error_setg(errp, QCOW2_OPT_CACHE_SIZE ", " QCOW2_OPT_L2_CACHE_SIZE
>                          " and " QCOW2_OPT_REFCOUNT_CACHE_SIZE " may not be set "
> -                       "the same time");
> +                       "at the same time");

into a standalone patch for application in 3.0, while the rest of this 
patch waits for 3.1?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
