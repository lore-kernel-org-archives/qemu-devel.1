Received: from eggs.gnu.org ([2001:4830:134:3::10]:49627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emIa2-00011z-N1
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:24:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emIa1-0003qM-Jj
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 07:24:02 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-31-f4bug@amsat.org>
	<20180215110016.GB23170@ts.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd9024d9-be99-653a-2e88-2d2d21f47dbd@amsat.org>
Date: Thu, 15 Feb 2018 09:23:52 -0300
MIME-Version: 1.0
In-Reply-To: <20180215110016.GB23170@ts.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH 30/30] xen: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alan.Robinson@ts.fujitsu.com
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On 02/15/2018 08:00 AM, Alan Robinson wrote:
> Hi Philippe,
> 
> On Thu, Feb 15, 2018 at 01:29:00AM -0300, Philippe Mathieu-Daudé wrote:
>> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> Subject: [Xen-devel] [PATCH 30/30] xen: use the BYTE-based definitions
>> List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
>>
>> It ease code review, unit is explicit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/block/xen_disk.c        |  4 ++--
>>  hw/xenpv/xen_domainbuild.c | 10 +++++-----
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/xen_disk.c b/hw/block/xen_disk.c
>> index f74fcd42d1..557005b5e5 100644
>> --- a/hw/block/xen_disk.c
>> +++ b/hw/block/xen_disk.c
>> @@ -1153,9 +1153,9 @@ static int blk_connect(struct XenDevice *xendev)
>>      }
>>  
>>      xen_pv_printf(xendev, 1, "type \"%s\", fileproto \"%s\", filename \"%s\","
>> -                  " size %" PRId64 " (%" PRId64 " MB)\n",
>> +                  " size %" PRId64 " (%llu MB)\n",
>>                    blkdev->type, blkdev->fileproto, blkdev->filename,
>> -                  blkdev->file_size, blkdev->file_size >> 20);
>> +                  blkdev->file_size, blkdev->file_size / M_BYTE);
>>  
>>      /* Fill in number of sector size and number of sectors */
>>      xenstore_write_be_int(&blkdev->xendev, "sector-size", blkdev->file_blk);
>> diff --git a/hw/xenpv/xen_domainbuild.c b/hw/xenpv/xen_domainbuild.c
>> index 027f76fad1..083fb80ee5 100644
>> --- a/hw/xenpv/xen_domainbuild.c
>> +++ b/hw/xenpv/xen_domainbuild.c
>> @@ -75,9 +75,9 @@ int xenstore_domain_init1(const char *kernel, const char *ramdisk,
>>      xenstore_write_str(dom, "vm",     vm);
>>  
>>      /* memory */
>> -    xenstore_write_int(dom, "memory/target", ram_size >> 10);  // kB
>> -    xenstore_write_int(vm, "memory",         ram_size >> 20);  // MB
>> -    xenstore_write_int(vm, "maxmem",         ram_size >> 20);  // MB
>> +    xenstore_write_int(dom, "memory/target", ram_size * K_BYTE);
>> +    xenstore_write_int(vm, "memory",         ram_size * M_BYTE);
>> +    xenstore_write_int(vm, "maxmem",         ram_size * M_BYTE);
> 
> These changes looks wrong, surely it must be 'ram_size / K_BYTE'...

Oops... Thanks for noticing this mistake!

Can I add your R-b tag once fixed? Respin will be:

+    xenstore_write_int(dom, "memory/target", ram_size / K_BYTE);
+    xenstore_write_int(vm, "memory",         ram_size / M_BYTE);
+    xenstore_write_int(vm, "maxmem",         ram_size / M_BYTE);

Regards,

Phil.

> 
> Alan
> 
