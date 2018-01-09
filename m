Received: from eggs.gnu.org ([2001:4830:134:3::10]:41911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYteB-0004kK-V9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYte8-0007xy-Nm
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:08:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYte8-0007xW-Ec
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:08:52 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <004301d38940$56013bb0$0203b310$@ru> (Pavel Dovgalyuk's message
	of "Tue, 9 Jan 2018 14:52:33 +0300")
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>
	<003c01d38923$1c5157f0$54f407d0$@ru> <87efmz1ddp.fsf@secure.laptop>
	<004301d38940$56013bb0$0203b310$@ru>
Reply-To: quintela@redhat.com
Date: Tue, 09 Jan 2018 14:08:46 +0100
Message-ID: <87zi5nyyap.fsf@secure.laptop>
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
>> From: Juan Quintela [mailto:quintela@redhat.com]

>> >>      return 0;
>> >>  }
>> >>
>> >> @@ -252,7 +257,10 @@ static int hpet_post_load(void *opaque, int version_id)
>> >>      HPETState *s = opaque;
>> >>
>> >>      /* Recalculate the offset between the main counter and guest time */
>> >> -    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> >> +    if (!s->hpet_offset_loaded) {
>> >> +        s->hpet_offset = ticks_to_ns(s->hpet_counter)
>> >> +                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> >> +    }
>> 
>> So, at this point it is going to always be false.
>
> No, because post load (below) sets it to true.
>
>> >> +static int hpet_offset_post_load(void *opaque, int version_id)
>> >> +{
>> >> +    HPETState *s = opaque;
>> >> +
>> >> +    s->hpet_offset_loaded = true;
>> >> +    return 0;
>> >> +}
>> >> +
>> >>  static bool hpet_rtc_irq_level_needed(void *opaque)
>> >>  {
>> >>      HPETState *s = opaque;
>> >> @@ -285,6 +301,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
>> >>      }
>> >>  };
>> >>
>> >> +static const VMStateDescription vmstate_hpet_offset = {
>> >> +    .name = "hpet/offset",
>> >> +    .version_id = 1,
>> >> +    .minimum_version_id = 1,
>> >> +    .post_load = hpet_offset_post_load,
>> 
>> You are missing here a .needed function.  Se how
>
> Because .needed is optional.

If you *don't* use a needed function then please just increase the
version.  You are just breaking compatibility anyways.  The whole point
of subsections is that they are optional.  If they are mandatory (this
case), then they bring no advantage at all.

>
>> - You want to transport hpet_offset just in the cases that hpet_is_enabled()?
>
> No, we want to preserve backwards compatibility.

So, let me understand this again.

old qemu -> new qemu

   what do you want to do here. i.e.
   new->hpet_counter = .... old->hpet_counter...
   new->hpet_offset = ... old->hpet_offset...

   You can use whatever you want.

new qemu -> old qemu
   right now, you break it always

   we *always* sent the subsection.  Is there any case where it makes
   sense to migrate to the old version.


>> I think that the following patch does what you want, no?  And it is a
>> bit simpler.
>
> It is simpler, but won't work for migrations from old version to the new one.
> hpet_counter becomes invalid in such case.

What value do you want hpet_offset to have when migrating from old
versions?

My version does:

new -> new (hpet_enabled)
   dst->hpet_counter = src->hpet_counter
   dst->hpet_offset = src->hpet_offset

new -> new ( ! hpet_enabled)
   dst->hpet_counter = src->hpet_counter
   dst->hpet_offset = <undefined really>

new -> old (hpet_enabled)
   breaks migration

new -> old ( ! hpet_enabled)
   dst->hpet_counter = src->hpet_counter
   dst->hpet_offset = <undefined really>

old -> old
   dst->hpet_counter= src->hpet_get_tick();
   dst->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);


Your version does:

new -> new (hpet_enabled)
   dst->hpet_counter = hpet_get_ticks(s) /* on source */
   dst->hpet_offset = src->hpet_offset

new -> new ( ! hpet_enabled)
   dst->hpet_counter = src->hpet_counter
   dst->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);

new -> old
   breaks always migration independently of hpet_enabled

old -> old
   dst->hpet_counter= src->hpet_get_tick();
   dst->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);

So, what are the values that we want to have here really?

What dave is asked for your previous version is that you disable the
section for old machine types.  Look at how to use DEFINE_PROP_* for
this use case. 

Later, Juan.

>> Head:     master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into
>> staging
>> Merge:    qemu/master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request'
>> into staging
>> Tag:      v2.11.0 (454)
>> 
>> Unstaged changes (1)
>> modified   hw/timer/hpet.c
>> @@ -216,16 +216,6 @@ static void update_irq(struct HPETTimer *timer, int set)
>>      }
>>  }
>> 
>> -static int hpet_pre_save(void *opaque)
>> -{
>> -    HPETState *s = opaque;
>> -
>> -    /* save current counter value */
>> -    s->hpet_counter = hpet_get_ticks(s);
>> -
>> -    return 0;
>> -}
>> -
>>  static int hpet_pre_load(void *opaque)
>>  {
>>      HPETState *s = opaque;
>> @@ -251,9 +241,6 @@ static int hpet_post_load(void *opaque, int version_id)
>>  {
>>      HPETState *s = opaque;
>> 
>> -    /* Recalculate the offset between the main counter and guest time */
>> -    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> -
>>      /* Push number of timers into capability returned via HPET_ID */
>>      s->capability &= ~HPET_ID_NUM_TIM_MASK;
>>      s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
>> @@ -285,6 +272,24 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
>>      }
>>  };
>> 
>> +static bool hpet_offset_needed(void *opaque)
>> +{
>> +    HPETState *s = opaque;
>> +
>> +    return hpet_enabled(s);
>> +}
>> +
>> +static const VMStateDescription vmstate_hpet_offset = {
>> +    .name = "hpet/offset",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .needed = hpet_offset_needed,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT64(hpet_offset, HPETState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  static const VMStateDescription vmstate_hpet_timer = {
>>      .name = "hpet_timer",
>>      .version_id = 1,
>> @@ -320,6 +325,7 @@ static const VMStateDescription vmstate_hpet = {
>>      },
>>      .subsections = (const VMStateDescription*[]) {
>>          &vmstate_hpet_rtc_irq_level,
>> +        &vmstate_hpet_offset,
>>          NULL
>>      }
>>  };
>> 
>
>
> Pavel Dovgalyuk
