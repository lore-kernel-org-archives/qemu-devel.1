Received: from eggs.gnu.org ([2001:4830:134:3::10]:34585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYs46-0003UV-AR
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYs41-0001cB-RJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:27:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYs41-0001bE-HW
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:27:29 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <003c01d38923$1c5157f0$54f407d0$@ru> (Pavel Dovgalyuk's message
	of "Tue, 9 Jan 2018 11:23:21 +0300")
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>
	<003c01d38923$1c5157f0$54f407d0$@ru>
Reply-To: quintela@redhat.com
Date: Tue, 09 Jan 2018 12:26:58 +0100
Message-ID: <87efmz1ddp.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

"Pavel Dovgalyuk" <dovgaluk@ispras.ru> wrote:
> Ping?
>
> Pavel Dovgalyuk
>
>> -----Original Message-----
>> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
>> Sent: Wednesday, December 20, 2017 1:02 PM
>> To: qemu-devel@nongnu.org
>> Cc: quintela@redhat.com; mst@redhat.com; dgilbert@redhat.com; maria.klimushenkova@ispras.ru;
>> dovgaluk@ispras.ru; pavel.dovgaluk@ispras.ru; pbonzini@redhat.com
>> Subject: [PATCH v2] hpet: recover timer offset correctly
>> 
>> HPET saves its state by calculating the current time and recovers timer
>> offset using this calculated value. But these calculations include
>> divisions and multiplications. Therefore the timer state cannot be recovered
>> precise enough.
>> This patch introduces saving of the original value of the offset to
>> preserve the determinism of the timer.

Hi

How have you tested this?


>> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
>> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> ---
>>  hw/timer/hpet.c |   32 ++++++++++++++++++++++++++++++--
>>  1 file changed, 30 insertions(+), 2 deletions(-)
>> 
>> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
>> index 577371b..4904a60 100644
>> --- a/hw/timer/hpet.c
>> +++ b/hw/timer/hpet.c
>> @@ -70,6 +70,7 @@ typedef struct HPETState {
>> 
>>      MemoryRegion iomem;
>>      uint64_t hpet_offset;
>> +    bool hpet_offset_loaded;
>>      qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
>>      uint32_t flags;
>>      uint8_t rtc_irq_level;
>> @@ -221,7 +222,9 @@ static int hpet_pre_save(void *opaque)
>>      HPETState *s = opaque;
>> 
>>      /* save current counter value */
>> -    s->hpet_counter = hpet_get_ticks(s);
>> +    if (hpet_enabled(s)) {
>> +        s->hpet_counter = hpet_get_ticks(s);

Why do we want to save it only when hpet is enabled?  We used to save it always.

>> +    }
>> 
>>      return 0;
>>  }
>> @@ -232,6 +235,8 @@ static int hpet_pre_load(void *opaque)
>> 
>>      /* version 1 only supports 3, later versions will load the actual value */
>>      s->num_timers = HPET_MIN_TIMERS;
>> +    /* for checking whether the hpet_offset section is loaded */
>> +    s->hpet_offset_loaded = false;

This is made false everytime that we start incoming migration.

>>      return 0;
>>  }
>> 
>> @@ -252,7 +257,10 @@ static int hpet_post_load(void *opaque, int version_id)
>>      HPETState *s = opaque;
>> 
>>      /* Recalculate the offset between the main counter and guest time */
>> -    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +    if (!s->hpet_offset_loaded) {
>> +        s->hpet_offset = ticks_to_ns(s->hpet_counter)
>> +                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +    }

So, at this point it is going to always be false.

>> 
>>      /* Push number of timers into capability returned via HPET_ID */
>>      s->capability &= ~HPET_ID_NUM_TIM_MASK;
>> @@ -267,6 +275,14 @@ static int hpet_post_load(void *opaque, int version_id)
>>      return 0;
>>  }
>> 
>> +static int hpet_offset_post_load(void *opaque, int version_id)
>> +{
>> +    HPETState *s = opaque;
>> +
>> +    s->hpet_offset_loaded = true;
>> +    return 0;
>> +}
>> +
>>  static bool hpet_rtc_irq_level_needed(void *opaque)
>>  {
>>      HPETState *s = opaque;
>> @@ -285,6 +301,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
>>      }
>>  };
>> 
>> +static const VMStateDescription vmstate_hpet_offset = {
>> +    .name = "hpet/offset",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = hpet_offset_post_load,

You are missing here a .needed function.  Se how
vmstate_hpet_rtc_irq_level_needed().
I am commeting from migration/vmstate point of view.  I don't understand
hpet well enough to comment about that.

Just to be sure that I am understanding what you want/need.

- You want to transport hpet_offset just in the cases that hpet_is_enabled()?

So your _needed() function needs to do something like
   return hpet_enabled();


So, we have two cases:
- hpet is enabled -> we need your changes, but then we can just have
hpet_counter directly



>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(hpet_offset, HPETState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_hpet_timer = {
>>      .name = "hpet_timer",
>>      .version_id = 1,
>> @@ -320,6 +347,7 @@ static const VMStateDescription vmstate_hpet = {
>>      },
>>      .subsections = (const VMStateDescription*[]) {
>>          &vmstate_hpet_rtc_irq_level,
>> +        &vmstate_hpet_offset,
>>          NULL
>>      }
>>  };

I think that the following patch does what you want, no?  And it is a
bit simpler.

Later, Juan.


Head:     master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into staging
Merge:    qemu/master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into staging
Tag:      v2.11.0 (454)

Unstaged changes (1)
modified   hw/timer/hpet.c
@@ -216,16 +216,6 @@ static void update_irq(struct HPETTimer *timer, int set)
     }
 }
 
-static int hpet_pre_save(void *opaque)
-{
-    HPETState *s = opaque;
-
-    /* save current counter value */
-    s->hpet_counter = hpet_get_ticks(s);
-
-    return 0;
-}
-
 static int hpet_pre_load(void *opaque)
 {
     HPETState *s = opaque;
@@ -251,9 +241,6 @@ static int hpet_post_load(void *opaque, int version_id)
 {
     HPETState *s = opaque;
 
-    /* Recalculate the offset between the main counter and guest time */
-    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-
     /* Push number of timers into capability returned via HPET_ID */
     s->capability &= ~HPET_ID_NUM_TIM_MASK;
     s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
@@ -285,6 +272,24 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
     }
 };
 
+static bool hpet_offset_needed(void *opaque)
+{
+    HPETState *s = opaque;
+
+    return hpet_enabled(s);
+}
+
+static const VMStateDescription vmstate_hpet_offset = {
+    .name = "hpet/offset",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = hpet_offset_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(hpet_offset, HPETState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_hpet_timer = {
     .name = "hpet_timer",
     .version_id = 1,
@@ -320,6 +325,7 @@ static const VMStateDescription vmstate_hpet = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_hpet_rtc_irq_level,
+        &vmstate_hpet_offset,
         NULL
     }
 };
