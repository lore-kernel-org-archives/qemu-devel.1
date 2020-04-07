Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5606FC2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D272063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MN+yEalD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D272063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmdH-0002PA-7p
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLmcR-0001YQ-AI
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joao.m.martins@oracle.com>) id 1jLmcP-000694-E2
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <joao.m.martins@oracle.com>)
 id 1jLmcP-00067s-3u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:42:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037Bd7qL115647;
 Tue, 7 Apr 2020 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=YRo9ruS0XM/bGch8RjkbhA1iyvf0i1x+ecNA5LR0spQ=;
 b=MN+yEalDKPABTiAkHMjIAvdIA6gyIZfqLhwpxK96wPujHd74FdQ4iem0R8u2oGw1UpUb
 /o/BQF1zwYAHh6OLzr+K7YeKe/xFZRgV7UlUTV16Oqn4NRdFBcdA/HD3nzeG7PG4ANYZ
 8AiG1YEuleFWck6nrJJQndyvwamAv0tGbu2Yr+gfWBZH2m8hMeWCFnUlLnPGuu+//cwC
 AZyKZOJ378SHUzdVS63NlR9ASjwHX6GV9BJb3CRxOIKSvNZ6vuIMJ+NiuBAMkf07eaSt
 QNGUo1WOzileFUdp9xVxc+QrO7jJwIdOm6GXzt92WgOOGvc+b12wJaA9aOnaWXtemlZV zw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 306jvn49gt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 11:42:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037BcaUb166873;
 Tue, 7 Apr 2020 11:42:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 30839t3cap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Apr 2020 11:42:07 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037Bg63Q021400;
 Tue, 7 Apr 2020 11:42:06 GMT
Received: from [10.175.215.143] (/10.175.215.143)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 07 Apr 2020 04:42:05 -0700
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: Dan Williams <dan.j.williams@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <2c45ec7c-f3ea-2962-47a6-9330f0a2f146@intel.com>
 <64ba0e18-2fa3-f5bd-7711-1d91f1dc74da@redhat.com>
 <CAPcyv4iOi+5RJgkEWuJpn8JjOMrNCh4Uk1Ag=Fo=i+iFf1TkFA@mail.gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <e21684a9-5832-7adb-923e-fdd9bff1f620@oracle.com>
Date: Tue, 7 Apr 2020 12:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iOi+5RJgkEWuJpn8JjOMrNCh4Uk1Ag=Fo=i+iFf1TkFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/7/20 9:16 AM, Dan Williams wrote:
> On Tue, Apr 7, 2020 at 1:08 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 07/04/20 09:29, Liu, Jingqi wrote:
>>> Ping.
>>>
>>> Any comments are appreciated.
>>>
>>> Hi Paolo, Richard,
>>>
>>> Any comments about this ?
>>
>> I was hoping to get a review from someone else because I have no way to
>> test it.  But I've now queued the patch, thanks.
> 

FWIW, I tested it (and didn't work) . Later found something odd wrt to the
device path.

Paolo if it helps your future testing, you can have a device-dax with something
like this:

   efi_fake_mem=4G@16G:0x40000 # creates a dax0.0 device with sz 4G, 2M aligned

But it requires dax_hmem which is v5.5+. Or alternatively use memmap=4G!16G (and
using ndctl create-namespace -r 0 -a <align>) and it creates pmem legacy device.


> Does qemu run tests in a nested VM? The difficult aspect of testing
> devdax is that you need to boot your kernel with a special option or
> have existing memory ranges assigned to the device. Although, Joao had
> thoughts about allowing dynamic creation of device-dax instance by hot
> unplugging memory.
> 

The idea was to get feature parity with hugetlbfs where you can assign a number
of 2M/1G pages at runtime. Thus giving a more flexible manner of assigning
memory to hmem.

This means we would create dax regions -- which can be sub-divided into dax
devices -- dynamically by hotunpluging a memory%u device first and then
reassigning it to dax_hmem driver (and thus marking it as 'soft-reserved').
Which could be given back to system-ram via dax_kmem. Naturally this assumes you
can hot-unplug the memory block before assigning it to dax_hmem, which might be
rather unpredictable. via kernel cmdline still is, though, the most
deterministic manner of assigning memory say at a bigger page granularities
(e.g. 1G).

But this is hotunplug-assign-to-hmem is still on paper, I haven't yet prototyped
this to see where it all falls apart.

>>> On 4/1/2020 11:13 AM, Liu, Jingqi wrote:
>>>> If the backend file is devdax pmem character device, the alignment
>>>> specified by the option 'align=NUM' in the '-object memory-backend-file'
>>>> needs to match the alignment requirement of the devdax pmem character
>>>> device.
>>>>
>>>> This patch fetches the devdax pmem file 'align', so that we can compare
>>>> it with the NUM of 'align=NUM'.
>>>> The NUM needs to be larger than or equal to the devdax pmem file 'align'.
>>>>
>>>> It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
>>>> when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.
>>>>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
>>>> ---
>>>>   exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>>>>   1 file changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/exec.c b/exec.c
>>>> index de9d949902..8221abffec 100644
>>>> --- a/exec.c
>>>> +++ b/exec.c
>>>> @@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
>>>>       return size;
>>>>   }
>>>>   +static int64_t get_file_align(int fd)
>>>> +{
>>>> +    int64_t align = -1;
>>>> +#if defined(__linux__)
>>>> +    struct stat st;
>>>> +
>>>> +    if (fstat(fd, &st) < 0) {
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    /* Special handling for devdax character devices */
>>>> +    if (S_ISCHR(st.st_mode)) {
>>>> +        g_autofree char *subsystem_path = NULL;
>>>> +        g_autofree char *subsystem = NULL;
>>>> +
>>>> +        subsystem_path =
>>>> g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
>>>> +                                         major(st.st_rdev),
>>>> minor(st.st_rdev));
>>>> +        subsystem = g_file_read_link(subsystem_path, NULL);
>>>> +
>>>> +        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
>>>> +            g_autofree char *align_path = NULL;
>>>> +            g_autofree char *align_str = NULL;
>>>> +
>>>> +            align_path =
>>>> g_strdup_printf("/sys/dev/char/%d:%d/device/align",
>>>> +                                    major(st.st_rdev),
>>>> minor(st.st_rdev));
>>>> +
>>>> +            if (g_file_get_contents(align_path, &align_str, NULL,
>>>> NULL)) {
>>>> +                return g_ascii_strtoll(align_str, NULL, 0);
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +#endif /* defined(__linux__) */
>>>> +
>>>> +    return align;
>>>> +}
>>>> +
>>>>   static int file_ram_open(const char *path,
>>>>                            const char *region_name,
>>>>                            bool *created,
>>>> @@ -2275,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
>>>> size, MemoryRegion *mr,
>>>>   {
>>>>       RAMBlock *new_block;
>>>>       Error *local_err = NULL;
>>>> -    int64_t file_size;
>>>> +    int64_t file_size, file_align;
>>>>         /* Just support these ram flags by now. */
>>>>       assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
>>>> @@ -2311,6 +2347,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t
>>>> size, MemoryRegion *mr,
>>>>           return NULL;
>>>>       }
>>>>   +    file_align = get_file_align(fd);
>>>> +    if (file_align > 0 && mr && file_align > mr->align) {
>>>> +        error_setg(errp, "backing store align 0x%" PRIx64
>>>> +                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
>>>> +                   file_align, mr->align);
>>>> +        return NULL;
> 
> Is there any downside to just making the alignment value be the max of
> the device-dax instance align and the command line option? Why force
> someone to debug the option unnecessarily?
> 
+1

Perhaps we can auto-detect that @align was not set and then we would set the max
align value. But if user has set a value over command line we would validate it
like Jingqi is doing above. Roughly, something like this just as a suggestion:

@@ -2354,11 +2354,16 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size,
MemoryRegion *mr,
     }

     file_align = get_file_align(fd);
-    if (file_align > 0 && mr && file_align > mr->align) {
-        error_setg(errp, "backing store align 0x%" PRIx64
-                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
-                   file_align, mr->align);
-        return NULL;
+    if (file_align > 0 && mr) {
+        /* auto detect alignment if none is specified */
+        if (!mr->align)
+            mr->align = file_align;
+        if (file_align > mr->align) {
+            error_setg(errp, "backing store align 0x%" PRIx64
+                       " is larger than 'align' option 0x" RAM_ADDR_FMT,
+                       file_align, mr->align);
+            return NULL;
+        }
     }



