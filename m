Received: from eggs.gnu.org ([209.51.188.92]:60275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6IF-0007CV-6T
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJ6IE-0003PI-07
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:12614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJ6ID-0003Lx-Mw
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 21:01:45 -0400
Date: Wed, 24 Apr 2019 09:01:05 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190424010105.GA12824@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-2-richardw.yang@linux.intel.com>
	<20190423092518.GD32465@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423092518.GD32465@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, yi.z.zhang@linux.intel.com, Haozhong Zhang <haozhong.zhang@intel.com>

On Tue, Apr 23, 2019 at 10:25:18AM +0100, Stefan Hajnoczi wrote:
[...]
>> +#ifdef CONFIG_LINUX
>> +#include <linux/mman.h>
>> +#else  /* !CONFIG_LINUX */
>> +#define MAP_SYNC              0x0
>> +#define MAP_SHARED_VALIDATE   0x0
>> +#endif /* CONFIG_LINUX */
>
>MAP_SHARED_VALIDATE is is from 2017:
>
>  commit 1c9725974074a047f6080eecc62c50a8e840d050
>  Author: Dan Williams <dan.j.williams@intel.com>
>  Date:   Wed Nov 1 16:36:30 2017 +0100
>
>    mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mmap flags
>
>This code fails to compile on Linux hosts with pre-4.15 headers.
>

Ok, qemu build will fail on pre-4.15 linux.

>Instead you could use the following (even on Linux!):
>
>  #ifndef MAP_SYNC
>  #define MAP_SYNC 0
>  #endif
>  #ifndef MAP_SHARED_VALIDATE
>  #define MAP_SHARED_VALIDATE 0
>  #endif
>
>Either way:

You mean replace the above code to:

#ifdef CONFIG_LINUX
#include <linux/mman.h>
#endif /* CONFIG_LINUX */

#ifndef MAP_SYNC
#define MAP_SYNC 0
#endif
#ifndef MAP_SHARED_VALIDATE
#define MAP_SHARED_VALIDATE 0
#endif

>
>Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



-- 
Wei Yang
Help you, Help me
