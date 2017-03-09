Received: from eggs.gnu.org ([2001:4830:134:3::10]:51715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cm0Us-0000Wi-SW
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cm0Up-0000XM-IJ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:00:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53235
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cm0Up-0000Vh-5S
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:00:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29FwoLb141302
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 11:00:54 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2938su4rux-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 11:00:53 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 16:00:51 -0000
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-3-dgilbert@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 9 Mar 2017 17:00:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170309132216.23482-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <1584ce47-ec53-efc7-b790-5288252121ed@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] postcopy: Check for shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com
Cc: lvivier@redhat.com, pbonzini@redhat.com



On 03/09/2017 02:22 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Postcopy doesn't support migration of RAM shared with another process
> yet (we've got a bunch of things to understand).
> Check for the case and don't allow postcopy to be enabled.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/postcopy-ram.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index effbeb6..dc80dbb 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -95,6 +95,19 @@ static bool ufd_version_check(int ufd)
>      return true;
>  }
> 
> +/* Callback from postcopy_ram_supported_by_host block iterator.
> + */
> +static int test_range_shared(const char *block_name, void *host_addr,
> +                             ram_addr_t offset, ram_addr_t length, void *opaque)
> +{
> +    if (qemu_ram_is_shared(qemu_ram_block_by_name(block_name))) {
> +        error_report("Postcopy on shared RAM (%s) is not yet supported",
> +                     block_name);
> +        return 1;
> +    }
> +    return 0;
> +}
> +

Hm, this stuff with the iterator seemed a bit strange (too complicated)
first, but I'm not familiar with this code. I have no idea why is
RAMBlockIterFunc
 
typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
    ram_addr_t offset, ram_addr_t length, void *opaque)

and not 

typedef int (RAMBlockIterFunc)(RAMBlock *block, void *opaque).

The reason does not seem to be abstraction.

>  /*
>   * Note: This has the side effect of munlock'ing all of RAM, that's
>   * normally fine since if the postcopy succeeds it gets turned back on at the
> @@ -127,6 +140,11 @@ bool postcopy_ram_supported_by_host(void)
>          goto out;
>      }
> 
> +    /* We don't support postcopy with shared RAM yet */
> +    if (qemu_ram_foreach_block(test_range_shared, NULL)) {
> +        goto out;
> +    }
> +

But using ram_list directly does not seem to be a good alternative to me,
and I do not see a third alternative.

So besides some cosmetic stuff I have nothing to add. Cosmetic stuff is:
* why range instead of block in test_range_shared
* I think we could move this up so that we can return directly
and do not acquire resources which need cleanup

Regardless of the cosmetics:
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>


>      /*
>       * userfault and mlock don't go together; we'll put it back later if
>       * it was enabled.
> 
