Received: from eggs.gnu.org ([209.51.188.92]:54458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLbMb-0006IY-KF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hLbMZ-0003mO-MM
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:37 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hLbMX-0003hK-KG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 18:36:33 -0400
Received: by mail-ed1-x544.google.com with SMTP id g57so7112118edc.12
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 15:36:21 -0700 (PDT)
Date: Tue, 30 Apr 2019 22:36:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190430223618.lyl3ribm7gg5haa5@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190426003652.32633-1-richardw.yang@linux.intel.com>
	<20190426003652.32633-2-richardw.yang@linux.intel.com>
	<20190430204636.GK28722@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430204636.GK28722@habkost.net>
Subject: Re: [Qemu-devel] [PATCH v15 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com, Haozhong Zhang <haozhong.zhang@intel.com>, qemu-devel@nongnu.org, yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com

On Tue, Apr 30, 2019 at 05:46:36PM -0300, Eduardo Habkost wrote:
>Hi,
>
>On Fri, Apr 26, 2019 at 08:36:51AM +0800, Wei Yang wrote:
>> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>> 
>> When a file supporting DAX is used as vNVDIMM backend, mmap it with
>> MAP_SYNC flag in addition which can ensure file system metadata
>> synced in each guest writes to the backend file, without other QEMU
>> actions (e.g., periodic fsync() by QEMU).
>> 
>> Current, We have below different possible use cases:
>> 
>> 1. pmem=on is set, shared=on is set, MAP_SYNC supported:
>>    a: backend is a dax supporting file.
>>     - MAP_SYNC will active.
>>    b: backend is not a dax supporting file.
>>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
>> 
>> 2. The rest of cases:
>>    - we will never pass the MAP_SYNC to mmap2
>> 
>> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> [ehabkost: Rebased patch to latest code on master]
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Tested-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> 
>> ---
>> v15: fix compile issue on pre-linux4.15
>> v14: rebase on top of current upstream
>
>Note that v14 was already merged, so the build fix would need to
>be submitted separately.  However:
>

Sure, I would spin a separate patch.

>[...]
>> +#ifdef CONFIG_LINUX
>> +#include <linux/mman.h>
>> +#endif /* CONFIG_LINUX */
>> +
>> +#ifndef MAP_SYNC
>> +#define MAP_SYNC 0
>> +#endif
>> +#ifndef MAP_SHARED_VALIDATE
>> +#define MAP_SHARED_VALIDATE 0
>> +#endif
>
>Why would we need this, if we added copies of mman.h to
>linux-headers?

This is reported by Stefan.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg612168.html

>
>-- 
>Eduardo

-- 
Wei Yang
Help you, Help me
