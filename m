Received: from eggs.gnu.org ([2001:4830:134:3::10]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYsSP-00051X-Aa
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYsSK-0005eU-Dd
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:52:41 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60604)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eYsSK-0005d6-1C
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 06:52:36 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171220100205.16625.84632.stgit@pasha-VirtualBox>	<003c01d38923$1c5157f0$54f407d0$@ru>
	<87efmz1ddp.fsf@secure.laptop>
In-Reply-To: <87efmz1ddp.fsf@secure.laptop>
Date: Tue, 9 Jan 2018 14:52:33 +0300
Message-ID: <004301d38940$56013bb0$0203b310$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v2] hpet: recover timer offset correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, mst@redhat.com, dgilbert@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

> From: Juan Quintela [mailto:quintela@redhat.com]
> >> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> >> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >> ---
> >>  hw/timer/hpet.c |   32 ++++++++++++++++++++++++++++++--
> >>  1 file changed, 30 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> >> index 577371b..4904a60 100644
> >> --- a/hw/timer/hpet.c
> >> +++ b/hw/timer/hpet.c
> >> @@ -70,6 +70,7 @@ typedef struct HPETState {
> >>
> >>      MemoryRegion iomem;
> >>      uint64_t hpet_offset;
> >> +    bool hpet_offset_loaded;
> >>      qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
> >>      uint32_t flags;
> >>      uint8_t rtc_irq_level;
> >> @@ -221,7 +222,9 @@ static int hpet_pre_save(void *opaque)
> >>      HPETState *s = opaque;
> >>
> >>      /* save current counter value */
> >> -    s->hpet_counter = hpet_get_ticks(s);
> >> +    if (hpet_enabled(s)) {
> >> +        s->hpet_counter = hpet_get_ticks(s);
> 
> Why do we want to save it only when hpet is enabled?  We used to save it always.

Because it may be read by the guest.
Therefore hpet_counter should not be affected by the events not caused by the guest.

> 
> >> +    }
> >>
> >>      return 0;
> >>  }
> >> @@ -232,6 +235,8 @@ static int hpet_pre_load(void *opaque)
> >>
> >>      /* version 1 only supports 3, later versions will load the actual value */
> >>      s->num_timers = HPET_MIN_TIMERS;
> >> +    /* for checking whether the hpet_offset section is loaded */
> >> +    s->hpet_offset_loaded = false;
> 
> This is made false everytime that we start incoming migration.

Right.

> 
> >>      return 0;
> >>  }
> >>
> >> @@ -252,7 +257,10 @@ static int hpet_post_load(void *opaque, int version_id)
> >>      HPETState *s = opaque;
> >>
> >>      /* Recalculate the offset between the main counter and guest time */
> >> -    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >> +    if (!s->hpet_offset_loaded) {
> >> +        s->hpet_offset = ticks_to_ns(s->hpet_counter)
> >> +                        - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >> +    }
> 
> So, at this point it is going to always be false.

No, because post load (below) sets it to true.

> >> +static int hpet_offset_post_load(void *opaque, int version_id)
> >> +{
> >> +    HPETState *s = opaque;
> >> +
> >> +    s->hpet_offset_loaded = true;
> >> +    return 0;
> >> +}
> >> +
> >>  static bool hpet_rtc_irq_level_needed(void *opaque)
> >>  {
> >>      HPETState *s = opaque;
> >> @@ -285,6 +301,17 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
> >>      }
> >>  };
> >>
> >> +static const VMStateDescription vmstate_hpet_offset = {
> >> +    .name = "hpet/offset",
> >> +    .version_id = 1,
> >> +    .minimum_version_id = 1,
> >> +    .post_load = hpet_offset_post_load,
> 
> You are missing here a .needed function.  Se how

Because .needed is optional.

> - You want to transport hpet_offset just in the cases that hpet_is_enabled()?

No, we want to preserve backwards compatibility.

> I think that the following patch does what you want, no?  And it is a
> bit simpler.

It is simpler, but won't work for migrations from old version to the new one.
hpet_counter becomes invalid in such case.

> Head:     master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into
> staging
> Merge:    qemu/master Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request'
> into staging
> Tag:      v2.11.0 (454)
> 
> Unstaged changes (1)
> modified   hw/timer/hpet.c
> @@ -216,16 +216,6 @@ static void update_irq(struct HPETTimer *timer, int set)
>      }
>  }
> 
> -static int hpet_pre_save(void *opaque)
> -{
> -    HPETState *s = opaque;
> -
> -    /* save current counter value */
> -    s->hpet_counter = hpet_get_ticks(s);
> -
> -    return 0;
> -}
> -
>  static int hpet_pre_load(void *opaque)
>  {
>      HPETState *s = opaque;
> @@ -251,9 +241,6 @@ static int hpet_post_load(void *opaque, int version_id)
>  {
>      HPETState *s = opaque;
> 
> -    /* Recalculate the offset between the main counter and guest time */
> -    s->hpet_offset = ticks_to_ns(s->hpet_counter) - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -
>      /* Push number of timers into capability returned via HPET_ID */
>      s->capability &= ~HPET_ID_NUM_TIM_MASK;
>      s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
> @@ -285,6 +272,24 @@ static const VMStateDescription vmstate_hpet_rtc_irq_level = {
>      }
>  };
> 
> +static bool hpet_offset_needed(void *opaque)
> +{
> +    HPETState *s = opaque;
> +
> +    return hpet_enabled(s);
> +}
> +
> +static const VMStateDescription vmstate_hpet_offset = {
> +    .name = "hpet/offset",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = hpet_offset_needed,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT64(hpet_offset, HPETState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static const VMStateDescription vmstate_hpet_timer = {
>      .name = "hpet_timer",
>      .version_id = 1,
> @@ -320,6 +325,7 @@ static const VMStateDescription vmstate_hpet = {
>      },
>      .subsections = (const VMStateDescription*[]) {
>          &vmstate_hpet_rtc_irq_level,
> +        &vmstate_hpet_offset,
>          NULL
>      }
>  };
> 


Pavel Dovgalyuk
