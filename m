Received: from eggs.gnu.org ([2001:4830:134:3::10]:47892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ep6xI-0002cN-Ai
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1ep6so-0004dV-Vr
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:35:40 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2322 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1ep6so-0004Rp-2l
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 01:31:02 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Fri, 23 Feb 2018 06:30:50 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA561C77@DGGEMA505-MBX.china.huawei.com>
References: <1518425871-145512-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1518425871-145512-1-git-send-email-arei.gonglei@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] rtc: placing RTC memory region outside
 BQL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>

Ping...


Regards,
-Gonglei


> -----Original Message-----
> From: Gonglei (Arei)
> Sent: Monday, February 12, 2018 4:58 PM
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; Huangweidong (C); peter.maydell@linaro.org;
> Gonglei (Arei)
> Subject: [PATCH v3] rtc: placing RTC memory region outside BQL
>=20
> As windows guest use rtc as the clock source device,
> and access rtc frequently. Let's move the rtc memory
> region outside BQL to decrease overhead for windows guests.
> Meanwhile, adding a new lock to avoid different vCPUs
> access the RTC together.
>=20
> I tested PCMark 8 (https://www.futuremark.com/benchmarks/pcmark)
> in win7 guest and got the below results:
>=20
> Guest: 2U2G
>=20
> Before applying the patch:
>=20
> Your Work 2.0 score:                     2000
> Web Browsing - JunglePin                 0.334s
> Web Browsing - Amazonia                  0.132s
> Writing                                  3.59s
> Spreadsheet                              70.13s
> Video Chat v2/Video Chat playback 1 v2   22.8 fps
> Video Chat v2/Video Chat encoding v2     307.0 ms
> Benchmark duration                       1h 35min 46s
>=20
> After applying the patch:
>=20
> Your Work 2.0 score:                     2040
> Web Browsing - JunglePin                 0.345s
> Web Browsing - Amazonia                  0.132s
> Writing                                  3.56s
> Spreadsheet                              67.83s
> Video Chat v2/Video Chat playback 1 v2   28.7 fps
> Video Chat v2/Video Chat encoding v2     324.7 ms
> Benchmark duration                       1h 32min 5s
>=20
> Test results show that optimization is effective under
> stressful situations.
>=20
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---
> v3->v2:
>  a) fix a typo, 's/rasie/raise/' [Peter]
>  b) change commit message [Peter]
>=20
> v2->v1:
>  a)Adding a new lock to avoid different vCPUs
>    access the RTC together. [Paolo]
>  b)Taking the BQL before raising the outbound IRQ line. [Peter]
>  c)Don't hold BQL if it was holden. [Peter]
>=20
>  hw/timer/mc146818rtc.c | 55
> ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 35a05a6..f0a2a62 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -85,6 +85,7 @@ typedef struct RTCState {
>      uint16_t irq_reinject_on_ack_count;
>      uint32_t irq_coalesced;
>      uint32_t period;
> +    QemuMutex rtc_lock;
>      QEMUTimer *coalesced_timer;
>      Notifier clock_reset_notifier;
>      LostTickPolicy lost_tick_policy;
> @@ -125,6 +126,36 @@ static void rtc_coalesced_timer_update(RTCState *s)
>      }
>  }
>=20
> +static void rtc_raise_irq(RTCState *s)
> +{
> +    bool unlocked =3D !qemu_mutex_iothread_locked();
> +
> +    if (unlocked) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
> +    qemu_irq_raise(s->irq);
> +
> +    if (unlocked) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +}
> +
> +static void rtc_lower_irq(RTCState *s)
> +{
> +    bool unlocked =3D !qemu_mutex_iothread_locked();
> +
> +    if (unlocked) {
> +        qemu_mutex_lock_iothread();
> +    }
> +
> +    qemu_irq_lower(s->irq);
> +
> +    if (unlocked) {
> +        qemu_mutex_unlock_iothread();
> +    }
> +}
> +
>  static QLIST_HEAD(, RTCState) rtc_devices =3D
>      QLIST_HEAD_INITIALIZER(rtc_devices);
>=20
> @@ -141,7 +172,7 @@ void qmp_rtc_reset_reinjection(Error **errp)
>  static bool rtc_policy_slew_deliver_irq(RTCState *s)
>  {
>      apic_reset_irq_delivered();
> -    qemu_irq_raise(s->irq);
> +    rtc_raise_irq(s);
>      return apic_get_irq_delivered();
>  }
>=20
> @@ -277,8 +308,9 @@ static void rtc_periodic_timer(void *opaque)
>                  DPRINTF_C("cmos: coalesced irqs increased to %d\n",
>                            s->irq_coalesced);
>              }
> -        } else
> -            qemu_irq_raise(s->irq);
> +        } else {
> +            rtc_raise_irq(s);
> +        }
>      }
>  }
>=20
> @@ -459,7 +491,7 @@ static void rtc_update_timer(void *opaque)
>      s->cmos_data[RTC_REG_C] |=3D irqs;
>      if ((new_irqs & s->cmos_data[RTC_REG_B]) !=3D 0) {
>          s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
> -        qemu_irq_raise(s->irq);
> +        rtc_raise_irq(s);
>      }
>      check_update_timer(s);
>  }
> @@ -471,6 +503,7 @@ static void cmos_ioport_write(void *opaque, hwaddr
> addr,
>      uint32_t old_period;
>      bool update_periodic_timer;
>=20
> +    qemu_mutex_lock(&s->rtc_lock);
>      if ((addr & 1) =3D=3D 0) {
>          s->cmos_index =3D data & 0x7f;
>      } else {
> @@ -560,10 +593,10 @@ static void cmos_ioport_write(void *opaque,
> hwaddr addr,
>               * becomes enabled, raise an interrupt immediately.  */
>              if (data & s->cmos_data[RTC_REG_C] & REG_C_MASK) {
>                  s->cmos_data[RTC_REG_C] |=3D REG_C_IRQF;
> -                qemu_irq_raise(s->irq);
> +                rtc_raise_irq(s);
>              } else {
>                  s->cmos_data[RTC_REG_C] &=3D ~REG_C_IRQF;
> -                qemu_irq_lower(s->irq);
> +                rtc_lower_irq(s);
>              }
>              s->cmos_data[RTC_REG_B] =3D data;
>=20
> @@ -583,6 +616,7 @@ static void cmos_ioport_write(void *opaque, hwaddr
> addr,
>              break;
>          }
>      }
> +    qemu_mutex_unlock(&s->rtc_lock);
>  }
>=20
>  static inline int rtc_to_bcd(RTCState *s, int a)
> @@ -710,6 +744,7 @@ static uint64_t cmos_ioport_read(void *opaque,
> hwaddr addr,
>      if ((addr & 1) =3D=3D 0) {
>          return 0xff;
>      } else {
> +        qemu_mutex_lock(&s->rtc_lock);
>          switch(s->cmos_index) {
>  	case RTC_IBM_PS2_CENTURY_BYTE:
>              s->cmos_index =3D RTC_CENTURY;
> @@ -737,7 +772,7 @@ static uint64_t cmos_ioport_read(void *opaque,
> hwaddr addr,
>              break;
>          case RTC_REG_C:
>              ret =3D s->cmos_data[s->cmos_index];
> -            qemu_irq_lower(s->irq);
> +            rtc_lower_irq(s);
>              s->cmos_data[RTC_REG_C] =3D 0x00;
>              if (ret & (REG_C_UF | REG_C_AF)) {
>                  check_update_timer(s);
> @@ -762,6 +797,7 @@ static uint64_t cmos_ioport_read(void *opaque,
> hwaddr addr,
>          }
>          CMOS_DPRINTF("cmos: read index=3D0x%02x val=3D0x%02x\n",
>                       s->cmos_index, ret);
> +        qemu_mutex_unlock(&s->rtc_lock);
>          return ret;
>      }
>  }
> @@ -909,7 +945,7 @@ static void rtc_reset(void *opaque)
>      s->cmos_data[RTC_REG_C] &=3D ~(REG_C_UF | REG_C_IRQF | REG_C_PF
> | REG_C_AF);
>      check_update_timer(s);
>=20
> -    qemu_irq_lower(s->irq);
> +    rtc_lower_irq(s);
>=20
>      if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
>          s->irq_coalesced =3D 0;
> @@ -960,6 +996,8 @@ static void rtc_realizefn(DeviceState *dev, Error
> **errp)
>=20
>      rtc_set_date_from_host(isadev);
>=20
> +    qemu_mutex_init(&s->rtc_lock);
> +
>      switch (s->lost_tick_policy) {
>  #ifdef TARGET_I386
>      case LOST_TICK_POLICY_SLEW:
> @@ -986,6 +1024,7 @@ static void rtc_realizefn(DeviceState *dev, Error
> **errp)
>      qemu_register_suspend_notifier(&s->suspend_notifier);
>=20
>      memory_region_init_io(&s->io, OBJECT(s), &cmos_ops, s, "rtc", 2);
> +    memory_region_clear_global_locking(&s->io);
>      isa_register_ioport(isadev, &s->io, base);
>=20
>      qdev_set_legacy_instance_id(dev, base, 3);
> --
> 1.8.3.1
>=20
