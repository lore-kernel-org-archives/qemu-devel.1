Received: from eggs.gnu.org ([2001:4830:134:3::10]:33999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwQm-0007eh-Vn
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwQl-0003BK-UV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:24:44 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-8-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <563e34b7-2b97-da1a-9e38-784608197b89@redhat.com>
Date: Wed, 2 May 2018 13:24:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-8-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/7] iotests: Rework 113
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/21/2018 11:54 AM, Max Reitz wrote:
> This test case has been broken since 398e6ad014df261d (roughly half a
> year).  qemu-img amend requires its output image to be R/W, so it opens
> it as such; the node is then turned into an read-only node automatically
> which is now accompanied by a warning, however.  This warning has not
> been part of the reference output.
> 

> The reason nobody has noticed the breakage until now of course is the
> fact that nobody runs the iotests for nbd+bochs.  There actually was
> never any reason to set the protocol to "nbd" but because that was
> technically correct; functionally it made no difference.  So that is the
> first thing we are going to change: Make the protocol "file" instead so
> that people might actually notice breakage here.

There's probably several tests that fail with an explicit pairing of nbd 
as protocol + explicit format (I'm guilty of usually testing either the 
format './check -qcow2' or the protocol './check -nbd', and not 
combining the two).

> So with this test now being a raw test, we can rework the amend test
> case to use raw instead.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/113     | 19 +++++++++----------
>   tests/qemu-iotests/113.out |  7 ++++---
>   2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tests/qemu-iotests/113 b/tests/qemu-iotests/113
> index 19b68b2727..4e09810905 100755
> --- a/tests/qemu-iotests/113
> +++ b/tests/qemu-iotests/113
> @@ -38,16 +38,17 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>   . ./common.rc
>   . ./common.filter
>   
> -# We can only test one format here because we need its sample file
> -_supported_fmt bochs
> -_supported_proto nbd
> +# Some of these test cases use bochs, but others do use raw, so this
> +# is only half a lie.
> +_supported_fmt raw
> +_supported_proto file

Naive question - can we pass a list to _supported_fmt/_supported_proto, 
in which case the test runs under both elements of the list?  That is, 
I'm wondering if:

_supported_fmt raw bochs
_supported_proto file nbd

gives us any additional coverage (theoretically 4 times the testing 
possibilities - but if the rest of the test hard-codes a particular 
format or protocol then it might not actually execute a different 
combination).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
