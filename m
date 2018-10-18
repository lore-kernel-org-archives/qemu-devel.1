Received: from eggs.gnu.org ([2001:4830:134:3::10]:46843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCyzR-0001Dz-Rc
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 23:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCyzR-0000Xn-2C
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 23:28:49 -0400
References: <20181018031723.23459-1-maozhongyi@cmss.chinamobile.com>
	<20181018031723.23459-2-maozhongyi@cmss.chinamobile.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c46fe8e5-e31d-478b-d2fa-e51740f1aa32@redhat.com>
Date: Wed, 17 Oct 2018 22:28:41 -0500
MIME-Version: 1.0
In-Reply-To: <20181018031723.23459-2-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu-iotests: Modern shellscripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 10/17/18 10:17 PM, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete ``
> and modern $(); It would be nice to convert to using $()
> everywhere.
> 
> `pwd` and `basename $0` are in 231 files under directory
> tests/qemu-iotests, so replaced it with the following:
> 
> sed -i 's/`pwd`/$(pwd)/g' $(git grep -l "\`pwd\`")

No. Instead, I'd rather a separate patch that does:

s/`pwd`/$PWD/
s/\$(pwd)/$PWD/

since POSIX requires $PWD to be sane, and thus save us a wasted forked 
process.

> sed -i 's/`basename $0`/$(basename $0)/g' $(git grep -l "basename \$0")
> 
> A small amount of the rest is manually modified.
> 
> Cc: kwolf@redhat.com
> Cc: mreitz@redhat.com
> Cc: qemu-block@nongnu.org
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---

> +++ b/tests/qemu-iotests/001
> @@ -21,10 +21,10 @@
>   # creator
>   owner=hch@lst.de
>   
> -seq=`basename $0`
> +seq=$(basename $0)
>   echo "QA output created by $seq"
>   
> -here=`pwd`
> +here=$(pwd)
>   status=1	# failure is the default!

At one point, someone (Jeff?) proposed a cleanup patch that got rid of a 
lot of cruft in iotests, including the fact that scripts that don't use 
$seq don't need to assign seq=$(basename $0).  We should probably revive 
that rather than just making pointless churn on stuff that is garbage 
anyways.  But I don't have time to look up a URL to that older series at 
the moment.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
