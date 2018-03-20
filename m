Received: from eggs.gnu.org ([2001:4830:134:3::10]:37364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLvV-0002hM-Bz
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyLvU-0006fT-Bt
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:24:01 -0400
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2a80ab7f-0942-95a3-9d2d-8739b7b805ee@redhat.com>
Date: Tue, 20 Mar 2018 13:23:46 -0500
MIME-Version: 1.0
In-Reply-To: <20180320173632.25480-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 03/12] qemu-iotests: Test vdi
 image creation with QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, den@openvz.org, jcody@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On 03/20/2018 12:36 PM, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/211     | 256 +++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/211.out |  98 +++++++++++++++++
>   tests/qemu-iotests/group   |   1 +
>   3 files changed, 355 insertions(+)
>   create mode 100755 tests/qemu-iotests/211
>   create mode 100644 tests/qemu-iotests/211.out
> 

> +
> +# creator
> +owner=kwolf@redhat.com
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +status=1	# failure is the default!

More of the useless boilerplate we've been meaning to clean up.  Oh well.


> +# TODO Negative image sizes aren't handled correctly, but this is a problem
> +# with QAPI's implementation of the 'size' type and affects other commands as
> +# well. Once this is fixed, we may want to add a test case here.
> +
> +# 1. 2^64 - 512
> +# 2. 2^63 = 8 EB (qemu-img enforces image sizes less than this)
> +# 3. 2^63 - 512 (generally valid, but with the crypto header the file will
> +#                exceed 63 bits)
> +# 4. 0x1fffff8000000 (maximum image size for VDI)
> +# 5. (one byte more than maximum image size for VDI)

You list 5 cases...

> +
> +run_qemu -blockdev driver=file,filename="$TEST_IMG",node-name=node0 <<EOF
> +{ "execute": "qmp_capabilities" }
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 18446744073709551104
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 9223372036854775808
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 9223372036854775296
> +  }
> +}
> +{ "execute": "x-blockdev-create",
> +  "arguments": {
> +      "driver": "$IMGFMT",
> +      "file": "node0",
> +      "size": 562949819203585
> +  }

...but only four x-blockdev-create.  Why?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
