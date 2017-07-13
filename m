Received: from eggs.gnu.org ([2001:4830:134:3::10]:50627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVdqN-0007F3-OP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:07:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVdqJ-00061r-8o
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:07:47 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVdqJ-0005sA-3h
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:07:43 -0400
Received: by mail-qt0-x22a.google.com with SMTP id r30so37115636qtc.0
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:07:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
Message-ID: <1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
Date: Thu, 13 Jul 2017 10:07:16 -0300
MIME-Version: 1.0
In-Reply-To: <1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 04/07/2017 04:21 PM, Philippe Mathieu-Daudé wrote:
> Hi Dave,
> 
> On 04/07/2017 11:38 AM, Dr. David Alan Gilbert wrote:
>> Hi,
>>    Fedora 26 has gcc 7.0.1 which has the normal compliment
>> of new fussy warnings; so far I've posted :
>>
>> tests/check-qdict: Fix missing brackets
>> slirp/smb: Replace constant strings by glib string
>>
>> that fix one actual mistake and work around something it's being
>> fussy over.
>>
>> But I've also got a pile of hacks, attached below that I'm
>> not too sure what I'll do with them yet, but they're attached

ping ... What do we do with them?

>> for anyone else trying to build.  Note they're smoke-only-tested.
>>
>> I also have gcc bug https://gcc.gnu.org/bugzilla/show_bug.cgi?id=80346
>> filed for what I reckon is a couple of overly pessimistic warnings.
>>
>> Enjoy,
>>
>> Dave
>>
>> From 15353ce59e35e1d85927138982241491ea65cee2 Mon Sep 17 00:00:00 2001
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Date: Thu, 6 Apr 2017 15:44:50 +0100
>> Subject: [HACK!] Hacks for f26 build
>>
>> ---
>>  block/blkdebug.c         | 4 ++--
>>  block/blkverify.c        | 4 ++--
>>  hw/usb/bus.c             | 5 +++--
>>  include/qemu/iov.h       | 4 ++--
>>  tests/bios-tables-test.c | 2 +-
>>  5 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 67e8024e36..34c645d095 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -689,9 +689,9 @@ static void 
>> blkdebug_refresh_filename(BlockDriverState *bs, QDict *options)
>>      }
>>
>>      if (!force_json && bs->file->bs->exact_filename[0]) {
>> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>> +        g_assert_cmpint(snprintf(bs->exact_filename, 
>> sizeof(bs->exact_filename),
>>                   "blkdebug:%s:%s", s->config_file ?: "",
>> -                 bs->file->bs->exact_filename);
>> +                 bs->file->bs->exact_filename), <, 
>> sizeof(bs->exact_filename));
> 
> I'm not sure this works as expected if you compile with CPPFLAGS 
> +=-DG_DISABLE_ASSERT.
> 
> I added in me docker TODO "also build with -DG_DISABLE_ASSERT".
> 
>>      }
>>
>>      opts = qdict_new();
>> diff --git a/block/blkverify.c b/block/blkverify.c
>> index 9a1e21c6ad..d038947a5a 100644
>> --- a/block/blkverify.c
>> +++ b/block/blkverify.c
>> @@ -305,10 +305,10 @@ static void 
>> blkverify_refresh_filename(BlockDriverState *bs, QDict *options)
>>      if (bs->file->bs->exact_filename[0]
>>          && s->test_file->bs->exact_filename[0])
>>      {
>> -        snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>> +        g_assert_cmpint(snprintf(bs->exact_filename, 
>> sizeof(bs->exact_filename),
>>                   "blkverify:%s:%s",
>>                   bs->file->bs->exact_filename,
>> -                 s->test_file->bs->exact_filename);
>> +                 s->test_file->bs->exact_filename), <, 
>> sizeof(bs->exact_filename));
>>      }
>>  }
>>
>> diff --git a/hw/usb/bus.c b/hw/usb/bus.c
>> index 24f1608b4b..6023f3b419 100644
>> --- a/hw/usb/bus.c
>> +++ b/hw/usb/bus.c
>> @@ -8,6 +8,7 @@
>>  #include "monitor/monitor.h"
>>  #include "trace.h"
>>  #include "qemu/cutils.h"
>> +#include <glib.h>
>>
>>  static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int 
>> indent);
>>
>> @@ -407,8 +408,8 @@ void usb_register_companion(const char *masterbus, 
>> USBPort *ports[],
>>  void usb_port_location(USBPort *downstream, USBPort *upstream, int 
>> portnr)
>>  {
>>      if (upstream) {
>> -        snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>> -                 upstream->path, portnr);
>> +        g_assert_cmpint(snprintf(downstream->path, 
>> sizeof(downstream->path), "%s.%d",
>> +                 upstream->path, portnr), <, sizeof(downstream->path));
>>          downstream->hubcount = upstream->hubcount + 1;
>>      } else {
>>          snprintf(downstream->path, sizeof(downstream->path), "%d", 
>> portnr);
>> diff --git a/include/qemu/iov.h b/include/qemu/iov.h
>> index bd9fd55b0a..ebb0221140 100644
>> --- a/include/qemu/iov.h
>> +++ b/include/qemu/iov.h
>> @@ -46,7 +46,7 @@ static inline size_t
>>  iov_from_buf(const struct iovec *iov, unsigned int iov_cnt,
>>               size_t offset, const void *buf, size_t bytes)
>>  {
>> -    if (__builtin_constant_p(bytes) && iov_cnt &&
>> +    if (__builtin_constant_p(bytes) && iov_cnt && bytes <= INT_MAX &&
>>          offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
>>          memcpy(iov[0].iov_base + offset, buf, bytes);
>>          return bytes;
>> @@ -59,7 +59,7 @@ static inline size_t
>>  iov_to_buf(const struct iovec *iov, const unsigned int iov_cnt,
>>             size_t offset, void *buf, size_t bytes)
>>  {
>> -    if (__builtin_constant_p(bytes) && iov_cnt &&
>> +    if (__builtin_constant_p(bytes) && iov_cnt && bytes <= INT_MAX &&
>>          offset <= iov[0].iov_len && bytes <= iov[0].iov_len - offset) {
>>          memcpy(buf, iov[0].iov_base + offset, bytes);
>>          return bytes;
>> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>> index 88dbf97853..c55de4f65b 100644
>> --- a/tests/bios-tables-test.c
>> +++ b/tests/bios-tables-test.c
>> @@ -98,7 +98,7 @@ static void test_acpi_rsdt_table(test_data *data)
>>      AcpiRsdtDescriptorRev1 *rsdt_table = &data->rsdt_table;
>>      uint32_t addr = data->rsdp_table.rsdt_physical_address;
>>      uint32_t *tables;
>> -    int tables_nr;
>> +    unsigned int tables_nr;
> 
> Personally I prefer size_t here.
> 
>>      uint8_t checksum;
>>
>>      /* read the header */
>>
> 
> regards,
> Phil.
