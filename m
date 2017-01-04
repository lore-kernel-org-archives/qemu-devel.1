Received: from eggs.gnu.org ([2001:4830:134:3::10]:55201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cOjnB-0002YP-GO
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cOjnA-0006Xa-In
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:31:41 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cOjnA-0006XO-Dc
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 06:31:40 -0500
Received: by mail-oi0-x243.google.com with SMTP id u15so74211941oie.3
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:31:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_nARKG5MHrsj4aAQNYfFyEGT-4TzU=MLi1E+zvsK7b=g@mail.gmail.com>
References: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
	<1481882024-10016-5-git-send-email-ashijeetacharya@gmail.com>
	<CAFEAcA_nARKG5MHrsj4aAQNYfFyEGT-4TzU=MLi1E+zvsK7b=g@mail.gmail.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 4 Jan 2017 17:01:39 +0530
Message-ID: <CAC2QTZZL3yxYuwQYsuWJzAfPuw8jNvP94U4Cn5cPTm3-osv8tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 4/4] migration: Fail migration blocker
 for --only-migratble
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Dec 16, 2016 at 5:03 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 16 December 2016 at 09:53, Ashijeet Acharya
> <ashijeetacharya@gmail.com> wrote:
>> migrate_add_blocker should rightly fail if the '--only-migratable'
>> option was specified and the device in use should not be able to
>> perform the action which results in an unmigratable VM.
>>
>> Make migrate_add_blocker return -EACCES in this case.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>
>> diff --git a/block/qcow.c b/block/qcow.c
>> index 11526a1..7e5003ac 100644
>> --- a/block/qcow.c
>> +++ b/block/qcow.c
>> @@ -253,8 +253,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
>>                 "does not support live migration",
>>                 bdrv_get_device_or_node_name(bs));
>>      ret = migrate_add_blocker(s->migration_blocker, errp);
>> -    if (ret < 0) {
>> -        error_free(s->migration_blocker);
>> +    if (ret) {
>> +        if (ret == -EACCES) {
>> +            error_append_hint(errp, "Cannot use a node with qcow format as "
>> +                              "it does not support live migration");
>> +        }
>>          goto fail;
>>      }
>
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -1102,6 +1102,7 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>      VirtIOGPU *g = VIRTIO_GPU(qdev);
>>      bool have_virgl;
>>      int i;
>> +    int ret;
>>
>>      if (g->conf.max_outputs > VIRTIO_GPU_MAX_SCANOUTS) {
>>          error_setg(errp, "invalid max_outputs > %d", VIRTIO_GPU_MAX_SCANOUTS);
>> @@ -1120,8 +1121,12 @@ static void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>>
>>      if (virtio_gpu_virgl_enabled(g->conf)) {
>>          error_setg(&g->migration_blocker, "virgl is not yet migratable");
>> -        if (migrate_add_blocker(g->migration_blocker, errp) < 0) {
>> -            error_free(g->migration_blocker);
>> +        ret = migrate_add_blocker(g->migration_blocker, errp);
>> +        if (ret) {
>> +            if (ret == -EACCES) {
>> +                error_append_hint(errp, "Cannot use virgl as it does not "
>> +                                  "support live migration yet");
>> +            }
>>              return;
>>          }
>>      }
>> diff --git a/hw/intc/arm_gic_kvm.c b/hw/intc/arm_gic_kvm.c
>> index 3614daa..b40ad5f 100644
>> --- a/hw/intc/arm_gic_kvm.c
>> +++ b/hw/intc/arm_gic_kvm.c
>> @@ -514,8 +514,11 @@ static void kvm_arm_gic_realize(DeviceState *dev, Error **errp)
>>          error_setg(&s->migration_blocker, "This operating system kernel does "
>>                                            "not support vGICv2 migration");
>>          ret = migrate_add_blocker(s->migration_blocker, errp);
>> -        if (ret < 0) {
>> -            error_free(s->migration_blocker);
>> +        if (ret) {
>> +            if (ret == -EACCES) {
>> +                error_append_hint(errp, "Failed to realize vGICv2 as its"
>> +                                  " migrataion is not implemented yet");
>> +            }
>>              return;
>>          }
>>      }
>
> So if you look at these diff hunks you can see that we effectively
> end up duplicating the "why doesn't this device let you migrate"
> user message -- once in the error_setg(&s->migration_blocker, ...)
> and once with the error_append_hint() call.

Maybe changing the error message in error_setg(&s->migration_blocker, ...) to:
"Trying to add migration blocker but will fail if --only-migratable is
specified"
or something like that do the trick?

>
> Is there some way we can get migrate_add_blocker() to automatically
> incorporate the message when it's failing for the only-migratable case?
> (It's already being passed the errp.)

Sorry! I am not sure how I can use that but if you have something more
I am ready to work on it to fix this.

> That would avoid this duplication of the messages, and should also
> mean we don't need to modify the callers at all.

Right. I also thought so while writing this patch but wasn't able to
come up with a solution.

Ashijeet
>
> If the error messages come out looking a bit strangely worded we
> could edit the text in the callers so it works in both situations
> when it will be used.
>
> thanks
> -- PMM
