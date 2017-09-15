Received: from eggs.gnu.org ([2001:4830:134:3::10]:53019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dsmk0-0001pX-R8
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1dsmju-0003KO-TI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 05:16:52 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <27d3e43e-3a25-859e-170a-951fd0044edf@virtuozzo.com>
Date: Fri, 15 Sep 2017 12:16:35 +0300
MIME-Version: 1.0
In-Reply-To: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/4] Add shrink image for qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

On 17.08.2017 12:15, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this allows
> us to reduce the virtual image size and free up space on the disk without
> copying the image. Image can be fragmented and shrink is done by punching holes
> in the image file.
> 
> # ./qemu-img create -f qcow2 image.qcow2 4G
> Formatting 'image.qcow2', fmt=qcow2 size=4294967296 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
> 
> # ./qemu-io -c "write -P 0x22 0 1G" image.qcow2
> wrote 1073741824/1073741824 bytes at offset 0
> 1 GiB, 1 ops; 0:00:04.59 (222.886 MiB/sec and 0.2177 ops/sec)
> 
> # ./qemu-img resize image.qcow2 512M
> warning: qemu-img: Shrinking an image will delete all data beyond the shrunken image's end. Before performing such an operation, make sure there is no important data there.
> error: qemu-img: Use the --shrink option to perform a shrink operation.
> 
> # ./qemu-img resize --shrink image.qcow2 128M
> Image resized.
> 
> # ./qemu-img info image.qcow2
> image: image.qcow2
> file format: qcow2
> virtual size: 128M (134217728 bytes)
> disk size: 128M
> cluster_size: 65536
> Format specific information:
>      compat: 1.1
>      lazy refcounts: false
>      refcount bits: 16
>      corrupt: false
> 
> # du -h image.qcow2
> 129M    image.qcow2

ping


Hi guys, I would like to ask is there any plans to take this small patch
series? :) And thanks for the review.
