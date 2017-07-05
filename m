Received: from eggs.gnu.org ([2001:4830:134:3::10]:46477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSmg0-0007A8-9U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSmfz-0000Ai-0F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:57:16 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dSmfy-00009b-Mp
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:57:14 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so33451077wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 08:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87r2xwae1q.fsf@dusky.pond.sub.org>
References: <cover.1498761179.git.alistair.francis@xilinx.com>
	<0b14290d85eceaa145e0333c26826b14304e23e4.1498761179.git.alistair.francis@xilinx.com>
	<20170630085426.GA23259@redhat.com> <87ziclipgm.fsf@dusky.pond.sub.org>
	<20170703141537.GB955@redhat.com> <87r2xwae1q.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jul 2017 08:56:42 -0700
Message-ID: <CAKmqyKO9taJeQz+saFbByV9cUPPUUaNf9tHu9MqvhmsiURcjyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, philippe@mathieu-daude.net, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, Jul 3, 2017 at 11:53 PM, Markus Armbruster <armbru@redhat.com> wrote:
> "Daniel P. Berrange" <berrange@redhat.com> writes:
>
>> On Mon, Jul 03, 2017 at 04:07:21PM +0200, Markus Armbruster wrote:
>>> "Daniel P. Berrange" <berrange@redhat.com> writes:
>>>
>>> > On Thu, Jun 29, 2017 at 12:42:38PM -0700, Alistair Francis wrote:
>>> >> This patch removes the exisinting error_vreport() function and replaces it
>>> >> with a more generic vreport() function that takes an enum describing the
>>> >> information to be reported.
>>>
>>> Why remove error_vreport()?

I just thought that the name didn't make sense now that we are using
it for info and warning reports as well.

>>>
>>> >> As part of this change a report() function is added as well with the
>>> >> same capability.
>>> >>
>>> >> To maintain full compatibility the original error_report() function is
>>> >> maintained and no changes to the way errors are printed have been made.
>>> >>
>>> >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>>> >> ---
>>> >>
>>> >>  hw/virtio/virtio.c          |  2 +-
>>> >>  include/qemu/error-report.h | 10 +++++++++-
>>> >>  scripts/checkpatch.pl       |  3 ++-
>>> >>  util/qemu-error.c           | 33 ++++++++++++++++++++++++++++++---
>>> >>  4 files changed, 42 insertions(+), 6 deletions(-)
>>> >>
>>> >> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>>> >> index 464947f76d..bd3d26abb7 100644
>>> >> --- a/hw/virtio/virtio.c
>>> >> +++ b/hw/virtio/virtio.c
>>> >> @@ -2448,7 +2448,7 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>>> >>      va_list ap;
>>> >>
>>> >>      va_start(ap, fmt);
>>> >> -    error_vreport(fmt, ap);
>>> >> +    vreport(ERROR, fmt, ap);
>>> >>      va_end(ap);
>>> >>
>>> >>      if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>>> >> diff --git a/include/qemu/error-report.h b/include/qemu/error-report.h
>>> >> index 3001865896..39b554c3b9 100644
>>> >> --- a/include/qemu/error-report.h
>>> >> +++ b/include/qemu/error-report.h
>>> >> @@ -21,6 +21,12 @@ typedef struct Location {
>>> >>      struct Location *prev;
>>> >>  } Location;
>>> >>
>>> >> +typedef enum {
>>> >> +    ERROR,
>>> >> +    WARN,
>>> >> +    INFO,
>>> >> +} report_types;
>>> >
>>> > Woah, those are faaar to generic names to be used. There is way too much
>>> > chance of those clashing with definitions from headers we pull in - particularly
>>> > windows which pollutes its system headers with loads of generic names.
>>> >
>>> > I'd suggest  QMSG_ERROR, QMSG_WARN, QMSG_INFO
>>> >
>>> >> +
>>> >>  Location *loc_push_restore(Location *loc);
>>> >>  Location *loc_push_none(Location *loc);
>>> >>  Location *loc_pop(Location *loc);
>>> >> @@ -30,12 +36,14 @@ void loc_set_none(void);
>>> >>  void loc_set_cmdline(char **argv, int idx, int cnt);
>>> >>  void loc_set_file(const char *fname, int lno);
>>> >>
>>> >> +void vreport(report_types type, const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
>>> >> +void report(report_types type, const char *fmt, ...)  GCC_FMT_ATTR(2, 3);
>>> >
>>> > Those names are too generic too IMHO.  I'd suggest  qmsg_report, qmsg_vreport

Ok, I was trying to make them as short as possible to allow less line
wrapping, but I agree report() is too generic.

>>> >
>>> > As mentioned in the previous review, there should be wrappers which
>>> > call these with suitable enum to make usage less verbose. eg
>>> >
>>> >   qmsg_info(fmt, ....)  should call qmsg_report(QMSG_INFO, fmt, ...)
>>> >   qmsg_vinfo(fmt, ....)  should call qmsg_vreport(QMSG_INFO, fmt, ...)
>>> >
>>> > likewise, for other message levels
>>>
>>> We then have qmsg_warning() for warnings, and error_report() for errors.
>>> Ugh!
>>>
>>> If I had known back then what I know now, I wouldn't have used the
>>> error_ prefix.
>>>
>>> Naming things is hard.
>>>
>>> Ideas anyone?
>>
>> I guess implicit in my suggestion would be to switch to qmsg_error()
>> over some (long) period of time, but that would be a massive amount
>> of churn that would harm backporting.
>>
>> So perhaps, just have error_report warning_report, info_report, and
>> accept that the naming convention is slightly reversed from "normality"
>
> That's not half bad.
>
> The matching enum would be
>
>     typedef enum {
>         REPORT_TYPE_ERROR,
>         REPORT_TYPE_WARNING,
>         REPORT_TYPE_INFO,
>     } report_type;
>
> Note the typedef name is *singular*.  Compare
>
>     report_type rtype;
>
> to
>
>     report_types rtype;
>
> @rtype is *one* report type, not multiple.
>
> Let's stick report_type, report() and vreport() into qemu-error.c
> (static linkage) until we have a genuine need for them elsewhere.

Ok, I'll send out another version later today then.

Thanks,
Alistair
