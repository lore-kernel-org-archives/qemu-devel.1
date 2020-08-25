Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50764C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:08:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6602068E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 10:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="H+1jNWzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6602068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAVsj-0007ca-AQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAVs5-00072e-IB
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:08:05 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1kAVs2-0003AU-GW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 06:08:05 -0400
Received: by mail-wm1-x344.google.com with SMTP id s20so1834052wmj.1
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tckjd+QUu/Bv2pA5Uamz22Rt64XOK+nD0dwnQuEvkmU=;
 b=H+1jNWzEreU1N+Ff12Q4HgwFBm/eHj+lwULnF3muv5UpK98uYM1nhUflWpYEk38RYs
 sdocDZN7dp8mzs/zDtY5J2KJ0uGyUbMy8IUq6j/Y+ZMkgZDgDuGZzGI8dqIMMFNnjDxv
 AjHIwkEdFnXyq+1GkpyI988MyaMJjVgKAb63k1ZjS8diLxs6tQIEk9YJcOl7FhJbZ620
 moTELh1uaKehEJsGrnyF0oV/xFK2usUnl21wWpP/SSJ3C4O8+13d48lFcz/VIlUd4mGX
 CM5oZ4AvnGPBQS1kKgoA6d9GywuR0u90+PBIqHN5cjYRNOREvWc8by4nB4kMgu6/jaeL
 PDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tckjd+QUu/Bv2pA5Uamz22Rt64XOK+nD0dwnQuEvkmU=;
 b=dYwNH1A5ghu6qkbPXx9axrJ3wdOJbr7lSg/0Ma37fHRZn2leatlgQudtVplm6nkkwT
 YOQNRjmBa3QTASoioem8N9kQx9l9220FJspL+199YnGVPf4WTxhwgJdKRJ4dfQprooY5
 aLYwrEAbXlV1fyvnt4mlaA8cI/FTYhOfvuExF4xvWpvfFJbuOcegjG5JguOJ8VADp4Jh
 vg7n6XVIHIECybjOyKDFExXa+5Q0cbA7i5s1yj5NlPUQLOA6mVv+QjBf/twCMFd8HIaS
 IavdhQDvpSuPwMGFbXjvPC2ACzRtAngn8M3kZxrn10iX4rHpIWNiJHl2eyKNuuVxAudj
 Q5qA==
X-Gm-Message-State: AOAM532+yj9AQKzq2kEF3gJLz3Ok0TAtC7b7l4VHD08oSG8Ev0h45dc+
 2qTYka82cqp/ygFP8lJ/YIgR/Q==
X-Google-Smtp-Source: ABdhPJzPDlgSJV0swikSU500A9/yNl6R1fLMzawEhJE7hGdaIia2n3BiAbaoXN9BEJPPu8Xs8Zc/dg==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr1394300wmf.10.1598350080468; 
 Tue, 25 Aug 2020 03:08:00 -0700 (PDT)
Received: from xora-monster ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id v16sm4971206wmj.14.2020.08.25.03.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 03:07:59 -0700 (PDT)
Date: Tue, 25 Aug 2020 11:07:57 +0100
From: Graeme Gregory <graeme@nuviainc.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [EXTERNAL] Re: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded
 controller
Message-ID: <20200825100757.r54ba26kmavntqrb@xora-monster>
References: <20200820133201.80577-1-graeme@nuviainc.com>
 <CAFEAcA_9WRk0Dr97wpDHacsjy2qpmBBq=kp6hOQTvUOvpWF0zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_9WRk0Dr97wpDHacsjy2qpmBBq=kp6hOQTvUOvpWF0zw@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 03:59:38PM +0100, Peter Maydell wrote:
> On Thu, 20 Aug 2020 at 14:32, Graeme Gregory <graeme@nuviainc.com> wrote:
> >
> > A difference between sbsa platform and the virt platform is PSCI is
> > handled by ARM-TF in the sbsa platform. This means that the PSCI code
> > there needs to communicate some of the platform power changes down
> > to the qemu code for things like shutdown/reset control.
> >
> > Space has been left to extend the EC if we find other use cases in
> > future where ARM-TF and qemu need to communicate.
> >
> > Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> > ---
> >  hw/arm/sbsa-ref.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >
> > diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> > index f030a416fd..c8743fc1d0 100644
> > --- a/hw/arm/sbsa-ref.c
> > +++ b/hw/arm/sbsa-ref.c
> > @@ -41,6 +41,7 @@
> >  #include "hw/usb.h"
> >  #include "hw/char/pl011.h"
> >  #include "net/net.h"
> > +#include "migration/vmstate.h"
> >
> >  #define RAMLIMIT_GB 8192
> >  #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
> > @@ -62,6 +63,7 @@ enum {
> >      SBSA_CPUPERIPHS,
> >      SBSA_GIC_DIST,
> >      SBSA_GIC_REDIST,
> > +    SBSA_SECURE_EC,
> >      SBSA_SMMU,
> >      SBSA_UART,
> >      SBSA_RTC,
> > @@ -98,6 +100,14 @@ typedef struct {
> >  #define SBSA_MACHINE(obj) \
> >      OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
> >
> > +typedef struct {
> > +    SysBusDevice parent_obj;
> > +    MemoryRegion iomem;
> > +} SECUREECState;
> 
> Could you put the definition of the device in its own .c file,
> please (hw/misc/ seems like the right place). We generally
> prefer to keep the board and individual device models
> separate. (Some older code in the tree still has devices
> lurking in source files, but new stuff generally follows
> the rules.)
> 
Yes, certainly!

> > +enum sbsa_secure_ec_powerstates {
> > +    SBSA_SECURE_EC_CMD_NULL,
> > +    SBSA_SECURE_EC_CMD_POWEROFF,
> > +    SBSA_SECURE_EC_CMD_REBOOT,
> 
> The last two are clear enough, but what's a null power state for?
> 
My personal dislike of sending 0 to hardware as its harder to spot
when using scopes/logic analyzers. I can remove it if you wish and
explicitly number the states.

> > +static uint64_t secure_ec_read(void *opaque, hwaddr offset, unsigned size)
> > +{
> > +    /* No use for this currently */
> > +    return 0;
> > +}
> > +
> > +static void secure_ec_write(void *opaque, hwaddr offset,
> > +                     uint64_t value, unsigned size)
> > +{
> > +    if (offset == 0) { /* PSCI machine power command register */
> > +        switch (value) {
> > +        case SBSA_SECURE_EC_CMD_NULL:
> > +            break;
> > +        case SBSA_SECURE_EC_CMD_POWEROFF:
> > +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +            break;
> > +        case SBSA_SECURE_EC_CMD_REBOOT:
> > +            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> > +            break;
> > +        default:
> > +            error_report("sbsa-ref: ERROR Unkown power command");
> 
> "unknown".
> 
> We prefer qemu_log_mask(LOG_GUEST_ERROR, ...) for logging this
> kind of "guest code did something wrong" situation.
> (you could also do that for attempting to read this w/o register
> if you liked).
> 
Excellent that is much better, Ill make that change.

> > +        }
> > +    } else {
> > +        error_report("sbsa-ref: unknown EC register");
> 
> similarly here
> 
> > +    }
> > +}
> > +
> > +static const MemoryRegionOps secure_ec_ops = {
> > +    .read = secure_ec_read,
> > +    .write = secure_ec_write,
> > +    .endianness = DEVICE_NATIVE_ENDIAN,
> 
> Consider explicitly specifying the permitted access size
> by setting .valid.min_access_size and .valid.max_access_size
> (restricting guests to only doing 32-bit writes will make
> life easier when you come to add registers later...)
> 
That was my original intent so i will do this.

> > +};
> > +
> > +static void secure_ec_init(Object *obj)
> > +{
> > +    SECUREECState *s = SECURE_EC(obj);
> > +    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
> > +
> > +    memory_region_init_io(&s->iomem, obj, &secure_ec_ops, s, "secure-ec",
> > +                            0x1000);
> 
> Minor indent error here.
> 
Will fix, just FYI checkpatch does not pick this up currently.

> > +    sysbus_init_mmio(dev, &s->iomem);
> > +}
> > +
> > +static void create_secure_ec(MemoryRegion *mem)
> > +{
> > +    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
> > +    DeviceState *dev = qdev_create(NULL, TYPE_SECURE_EC);
> > +    SysBusDevice *s = SYS_BUS_DEVICE(dev);
> > +
> > +    memory_region_add_subregion(mem, base,
> > +                                sysbus_mmio_get_region(s, 0));
> > +}
> > +
> >  static void sbsa_ref_init(MachineState *machine)
> >  {
> >      unsigned int smp_cpus = machine->smp.cpus;
> > @@ -708,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
> >
> >      create_pcie(sms);
> >
> > +    create_secure_ec(secure_sysmem);
> > +
> >      sms->bootinfo.ram_size = machine->ram_size;
> >      sms->bootinfo.nb_cpus = smp_cpus;
> >      sms->bootinfo.board_id = -1;
> > @@ -798,8 +870,31 @@ static const TypeInfo sbsa_ref_info = {
> >      .instance_size = sizeof(SBSAMachineState),
> >  };
> >
> > +static const VMStateDescription vmstate_secure_ec_info = {
> > +    .name = "sbsa-secure-ec",
> > +    .version_id = 0,
> > +    .minimum_version_id = 0,
> > +};
> 
> If you don't have any internal state in a device (as in
> this case), then you don't need to set dc->vmsd at all.
> Just have a comment in the class init saying
>     /* No vmstate or reset required: device has no internal state */
> 
Thanks, that is cleaner, Ill do this.

Thanks for the review, Ill get right on v2.

Graeme


