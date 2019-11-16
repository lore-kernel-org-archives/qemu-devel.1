Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BEC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 21:00:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F922068D
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 21:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9CufxcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F922068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iW5Au-00060S-CB
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 16:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iW59u-0005X2-00
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 15:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iW59q-0006b0-G7
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 15:59:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39841
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iW59p-0006a7-AK
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 15:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573937938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcexYXMye2NnFexo31wiGC0wt/uh3UFTbqiV6YpWa2g=;
 b=J9CufxcA+/U4T8w5sJzXUo03DzpLB3KL6LRV66b0vHaHk4NvfJkN1Km8OeL9NNTVcK16iR
 vZyJGhYfsLkXxqW+29o0cgNZGJOd/PbtpTW6W0yLLLA6iWoAcF2I9kdkr7qYDGKJ3nlXAO
 /fyTsmD9Z+daT0mclj8ui3q8g2PRspQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-t37OfekGMjy00E3-AF9FHQ-1; Sat, 16 Nov 2019 15:58:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 907191883521;
 Sat, 16 Nov 2019 20:58:56 +0000 (UTC)
Received: from x1.home (ovpn-116-56.phx2.redhat.com [10.3.116.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7E1575E49;
 Sat, 16 Nov 2019 20:58:55 +0000 (UTC)
Date: Sat, 16 Nov 2019 13:58:55 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2] mc146818rtc: fix timer interrupt reinjection
Message-ID: <20191116135855.5e16bb7c@x1.home>
In-Reply-To: <20191010123008.GA19158@amt.cnet>
References: <20191010123008.GA19158@amt.cnet>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: t37OfekGMjy00E3-AF9FHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 09:30:08 -0300
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
> reinjection when there is no period change by the guest.
>=20
> In that case, old_period is 0, which ends up zeroing irq_coalesced
> (counter of reinjected interrupts).
>=20
> The consequence is Windows 7 is unable to synchronize time via NTP.
> Easily reproducible by playing a fullscreen video with cirrus and VNC.
>=20
> Fix by not updating s->irq_coalesced when old_period is 0.
>=20
> V2: reorganize code (Paolo Bonzini)
>=20
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

This causes a regression for me, my win10 VM with assigned GPU
experiences hangs and slowness with this.  Found via bisect, reverting
restores normal behavior.  libvirt uses this commandline:

/usr/local/bin/qemu-system-x86_64 \
-name guest=3DSteam-GeForce,debug-threads=3Don \
-S \
-object secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/do=
main-1-Steam-GeForce/master-key.aes \
-machine pc-i440fx-4.1,accel=3Dkvm,usb=3Doff,vmport=3Doff,dump-guest-core=
=3Doff \
-cpu host,hv-time,hv-relaxed,hv-vapic,hv-spinlocks=3D0x1fff,hv-vendor-id=3D=
KeenlyKVM,kvm=3Doff \
-drive file=3D/usr/share/edk2/ovmf/OVMF_CODE.fd,if=3Dpflash,format=3Draw,un=
it=3D0,readonly=3Don \
-drive file=3D/var/lib/libvirt/qemu/nvram/Steam_VARS.fd,if=3Dpflash,format=
=3Draw,unit=3D1 \
-m 4096 \
-mem-prealloc \
-mem-path /dev/hugepages/libvirt/qemu/1-Steam-GeForce \
-overcommit mem-lock=3Doff \
-smp 4,sockets=3D1,cores=3D2,threads=3D2 \
-uuid 2b417d4b-f25b-4522-a5be-e105f032f99c \
-display none \
-no-user-config \
-nodefaults \
-chardev socket,id=3Dcharmonitor,fd=3D38,server,nowait \
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol \
-rtc base=3Dlocaltime,driftfix=3Dslew \
-global kvm-pit.lost_tick_policy=3Ddelay \
-no-hpet \
-no-shutdown \
-boot menu=3Don,strict=3Don \
-device nec-usb-xhci,id=3Dusb,bus=3Dpci.0,addr=3D0x8 \
-device virtio-scsi-pci,id=3Dscsi0,num_queues=3D4,bus=3Dpci.0,addr=3D0x5 \
-drive file=3D/mnt/ssd/Steam.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-scsi=
0-0-0-0,cache=3Dnone \
-device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,device_id=3Dd=
rive-scsi0-0-0-0,drive=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2,w=
rite-cache=3Don \
-netdev tap,fd=3D40,id=3Dhostnet0,vhost=3Don,vhostfd=3D41 \
-device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:60:ef:ac,=
bus=3Dpci.0,addr=3D0x3 \
-device vfio-pci,host=3D0000:01:00.0,id=3Dhostdev0,bus=3Dpci.0,addr=3D0x4,r=
ombar=3D1 \
-device vfio-pci,host=3D0000:01:00.1,id=3Dhostdev1,bus=3Dpci.0,addr=3D0x6,r=
ombar=3D0 \
-S \
-debugcon file:/tmp/Steam-ovmf-debug.log \
-global isa-debugcon.iobase=3D0x402 \
-set device.hostdev0.x-pci-vendor-id=3D0x10de \
-trace events=3D/var/lib/libvirt/images/Steam-GeForce.events \
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny \
-msg timestamp=3Don

Thanks,
Alex

> diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
> index 6cb378751b..0e7cf97042 100644
> --- a/hw/timer/mc146818rtc.c
> +++ b/hw/timer/mc146818rtc.c
> @@ -203,24 +203,28 @@ periodic_timer_update(RTCState *s, int64_t current_=
time, uint32_t old_period)
> =20
>      period =3D rtc_periodic_clock_ticks(s);
> =20
> -    if (period) {
> -        /* compute 32 khz clock */
> -        cur_clock =3D
> -            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECON=
D);
> +    if (!period) {
> +        s->irq_coalesced =3D 0;
> +        timer_del(s->periodic_timer);
> +        return;
> +    }
> =20
> -        /*
> -        * if the periodic timer's update is due to period re-configurati=
on,
> -        * we should count the clock since last interrupt.
> -        */
> -        if (old_period) {
> -            int64_t last_periodic_clock, next_periodic_clock;
> -
> -            next_periodic_clock =3D muldiv64(s->next_periodic_time,
> -                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECO=
ND);
> -            last_periodic_clock =3D next_periodic_clock - old_period;
> -            lost_clock =3D cur_clock - last_periodic_clock;
> -            assert(lost_clock >=3D 0);
> -        }
> +    /* compute 32 khz clock */
> +    cur_clock =3D
> +        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +
> +    /*
> +     * if the periodic timer's update is due to period re-configuration,
> +     * we should count the clock since last interrupt.
> +     */
> +    if (old_period) {
> +        int64_t last_periodic_clock, next_periodic_clock;
> +
> +        next_periodic_clock =3D muldiv64(s->next_periodic_time,
> +                                RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
> +        last_periodic_clock =3D next_periodic_clock - old_period;
> +        lost_clock =3D cur_clock - last_periodic_clock;
> +        assert(lost_clock >=3D 0);
> =20
>          /*
>           * s->irq_coalesced can change for two reasons:
> @@ -251,22 +255,19 @@ periodic_timer_update(RTCState *s, int64_t current_=
time, uint32_t old_period)
>                  rtc_coalesced_timer_update(s);
>              }
>          } else {
> -           /*
> +            /*
>               * no way to compensate the interrupt if LOST_TICK_POLICY_SL=
EW
>               * is not used, we should make the time progress anyway.
>               */
>              lost_clock =3D MIN(lost_clock, period);
>          }
> +    }
> =20
> -        assert(lost_clock >=3D 0 && lost_clock <=3D period);
> +    assert(lost_clock >=3D 0 && lost_clock <=3D period);
> =20
> -        next_irq_clock =3D cur_clock + period - lost_clock;
> -        s->next_periodic_time =3D periodic_clock_to_ns(next_irq_clock) +=
 1;
> -        timer_mod(s->periodic_timer, s->next_periodic_time);
> -    } else {
> -        s->irq_coalesced =3D 0;
> -        timer_del(s->periodic_timer);
> -    }
> +    next_irq_clock =3D cur_clock + period - lost_clock;
> +    s->next_periodic_time =3D periodic_clock_to_ns(next_irq_clock) + 1;
> +    timer_mod(s->periodic_timer, s->next_periodic_time);
>  }
> =20
>  static void rtc_periodic_timer(void *opaque)
>=20
>=20


