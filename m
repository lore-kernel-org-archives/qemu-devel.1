Received: from eggs.gnu.org ([2001:4830:134:3::10]:35217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhKDn-0004ZQ-P9
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dhKDm-0006C8-Jj
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:36:15 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:37197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dhKDm-0006Bs-BV
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:36:14 -0400
Received: by mail-wm0-x241.google.com with SMTP id t138so15348946wmt.4
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 11:36:14 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <87a832cqzz.fsf@dusky.pond.sub.org>
References: <cover.1501084908.git.alistair.francis@xilinx.com>
	<08f16288223244deeccbdc6e4d2fced5d379504d.1501084908.git.alistair.francis@xilinx.com>
	<87a832cqzz.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 14 Aug 2017 11:35:42 -0700
Message-ID: <CAKmqyKNwwxZ=TxPn0HApPt=YRtdX=kKGRKduK_+pM6XM=p0M5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/5] Convert remaining error_report() to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Mon, Aug 14, 2017 at 4:45 AM, Markus Armbruster <armbru@redhat.com> wrote:
> Alistair Francis <alistair.francis@xilinx.com> writes:
>
>> In a previous patch (3dc6f8693694a649a9c83f1e2746565b47683923) we
>> converted uses of error_report("warning:"... to use warn_report()
>> instead. This was to help standardise on a single method of printing
>> warnings to the user.
>>
>> There appears to have been some cases that slipped through in patch sets
>> applied around the same time, this patch catches the few remaining
>> cases.
>>
>> All of the warnings were changed using this command:
>>   find ./* -type f -exec sed -i \
>>     's|error_report(".*warning[,:] |warn_report("|Ig' {} +
>>
>> Indentation fixed up manually afterwards.
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>
>>  block/qcow2.c      | 10 +++++-----
>>  target/s390x/kvm.c |  4 ++--
>>  trace/control.c    |  4 ++--
>>  3 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 90efa4477b..e6c6be0822 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -302,11 +302,11 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>              }
>>
>>              if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) {
>> -                error_report("WARNING: a program lacking bitmap support "
>> -                             "modified this file, so all bitmaps are now "
>> -                             "considered inconsistent. Some clusters may be "
>> -                             "leaked, run 'qemu-img check -r' on the image "
>> -                             "file to fix.");
>> +                warn_report("a program lacking bitmap support "
>> +                            "modified this file, so all bitmaps are now "
>> +                            "considered inconsistent. Some clusters may be "
>> +                            "leaked, run 'qemu-img check -r' on the image "
>> +                            "file to fix.");
>
> This message is awfully long.  What about splitting it while we're there:
>
>                    warn_report("a program lacking bitmap support "
>                                "modified this file, so all bitmaps are now "
>                                "considered inconsistent");
>                    error_printf("Some clusters may be "leaked, "
>                                 "run 'qemu-img check -r' on the image "
>                                 "file to fix.");
>
>>                  if (need_update_header != NULL) {
>>                      /* Updating is needed to drop invalid bitmap extension. */
>>                      *need_update_header = true;
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c4c5791d27..1084923adb 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -222,8 +222,8 @@ static void kvm_s390_enable_cmma(void)
>>      };
>>
>>      if (mem_path) {
>> -        error_report("Warning: CMM will not be enabled because it is not "
>> -                     "compatible to hugetlbfs.");
>> +        warn_report("CMM will not be enabled because it is not "
>> +                    "compatible to hugetlbfs.");
>
> Not a native speaker, but here goes anyway: "compatible with".
>
>>          return;
>>      }
>>      rc = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>> diff --git a/trace/control.c b/trace/control.c
>> index 82d8989c4d..2769934bec 100644
>> --- a/trace/control.c
>> +++ b/trace/control.c
>> @@ -72,8 +72,8 @@ void trace_event_register_group(TraceEvent **events)
>>          if (likely(next_vcpu_id < CPU_TRACE_DSTATE_MAX_EVENTS)) {
>>              events[i]->vcpu_id = next_vcpu_id++;
>>          } else {
>> -            error_report("WARNING: too many vcpu trace events; dropping '%s'",
>> -                         events[i]->name);
>> +            warn_report("too many vcpu trace events; dropping '%s'",
>> +                        events[i]->name);
>>          }
>>      }
>>      event_groups = g_renew(TraceEventGroup, event_groups, nevent_groups + 1);
>
> The nits I picked predate your patch, so:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks, I fixed up the changes you mentioned as well.

Thanks,
Alistair
