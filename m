Received: from eggs.gnu.org ([2001:4830:134:3::10]:57720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUcE-0002vX-O9
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erUcD-0001Np-Fg
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 15:15:46 -0500
References: <20180301011413.11531-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <588236fe-472d-a028-a448-e2a6aba84697@redhat.com>
Date: Thu, 1 Mar 2018 14:15:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180301011413.11531-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] iotests: Skip test for ENOMEM error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

On 02/28/2018 07:14 PM, Fam Zheng wrote:
> The AFL image is to exercise the code validating image size, which
> doesn't work on 32 bit or when out of memory (there is a large
> allocation before the interesting point). So check that and skip the
> test, instead of faking the result.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>   tests/qemu-iotests/059 | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
> index 40f89eae18..530bbbe6ce 100755
> --- a/tests/qemu-iotests/059
> +++ b/tests/qemu-iotests/059
> @@ -152,9 +152,8 @@ done
>   echo
>   echo "=== Testing afl image with a very large capacity ==="
>   _use_sample_img afl9.vmdk.bz2
> -# The sed makes this test pass on machines with little RAM
> -# (and also with 32 bit builds)
> -_img_info | sed -e 's/Cannot allocate memory/Invalid argument/'
> +_img_info | grep -q 'Cannot allocate memory' && _notrun "Insufficent memory, skipped test"
> +_img_info
>   _cleanup_test_img
>   
>   # success, all done
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
