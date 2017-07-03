Received: from eggs.gnu.org ([2001:4830:134:3::10]:34664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dS20h-0007Qw-My
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dS20d-0006MZ-N2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:07:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dS20d-0006Ls-EK
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 10:07:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
	<0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
	<20170630085426.GA23259@redhat.com>
Date: Mon, 03 Jul 2017 16:07:21 +0200
In-Reply-To: <20170630085426.GA23259@redhat.com> (Daniel P. Berrange's message
	of "Fri, 30 Jun 2017 09:54:26 +0100")
Message-ID: <87ziclipgm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 2/3] qemu-error: Implement a more generic
 error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, alistair23@gmail.com, qemu-devel@nongnu.org, philippe@mathieu-daude.net

"Daniel P. Berrange" <berrange@redhat.com> writes:

> On Thu, Jun 29, 2017 at 12:42:38PM -0700, Alistair Francis wrote:
>> This patch removes the exisinting error_vreport() function and replaces it
>> with a more generic vreport() function that takes an enum describing the
>> information to be reported.

Why remove error_vreport()?

>> As part of this change a report() function is added as well with the
>> same capability.
>> 
>> To maintain full compatibility the original error_report() function is
>> maintained and no changes to the way errors are printed have been made.
>> 
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>> 
>>  hw/virtio/virtio.c          |  2 +-
>>  include/qemu/error-report.h | 10 +++++++++-
>>  scripts/checkpatch.pl       |  3 ++-
>>  util/qemu-error.c           | 33 ++++++++++++++++++++++++++++++---
>>  4 files changed, 42 insertions(+), 6 deletions(-)
>> 
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 464947f76d..bd3d26abb7 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2448,7 +2448,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>>      va_list ap;
>>  
>>      va_start(ap, fmt);
>> -    error_vreport(fmt, ap);
>> +    vreport(ERROR, fmt, ap);
>>      va_end(ap);
>>  
>>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>> index 3001865896..39b554c3b9 100644
>> --- a/include/qemu/error-report.h
>> +++ b/include/qemu/error-report.h
>> @@ -21,6 +21,12 @@ typedef struct Location {
>>      struct Location *prev;
>>  } Location;
>>  
>> +typedef enum {
>> +    ERROR,
>> +    WARN,
>> +    INFO,
>> +} report_types;
>
> Woah, those are faaar to generic names to be used. There is way too much
> chance of those clashing with definitions from headers we pull in - particularly
> windows which pollutes its system headers with loads of generic names.
>
> I'd suggest  QMSG_ERROR, QMSG_WARN, QMSG_INFO
>
>> +
>>  Location *loc_push_restore(Location *loc);
>>  Location *loc_push_none(Location *loc);
>>  Location *loc_pop(Location *loc);
>> @@ -30,12 +36,14 @@ void loc_set_none(void);
>>  void loc_set_cmdline(char **argv, int idx, int cnt);
>>  void loc_set_file(const char *fname, int lno);
>>  
>> +void vreport(report_types type, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
>> +void report(report_types type, const char *fmt, ...)  GCC_FMT_ATTR(2, 3);
>
> Those names are too generic too IMHO.  I'd suggest  qmsg_report, qmsg_vreport
>
> As mentioned in the previous review, there should be wrappers which
> call these with suitable enum to make usage less verbose. eg
>
>   qmsg_info(fmt, ....)  should call qmsg_report(QMSG_INFO, fmt, ...)
>   qmsg_vinfo(fmt, ....)  should call qmsg_vreport(QMSG_INFO, fmt, ...)
>
> likewise, for other message levels

We then have qmsg_warning() for warnings, and error_report() for errors.
Ugh!

If I had known back then what I know now, I wouldn't have used the
error_ prefix.

Naming things is hard.

Ideas anyone?

>>  void error_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>>  void error_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>>  void error_vprintf_unless_qmp(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>>  void error_printf_unless_qmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>>  void error_set_progname(const char *argv0);
>> -void error_vreport(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
>>  void error_report(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
>>  const char *error_get_progname(void);
>>  extern bool enable_timestamp_msg;
>
> Regards,
> Daniel
