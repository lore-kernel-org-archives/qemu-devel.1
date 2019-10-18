Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FC7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5E1222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDonSJbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5E1222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWCu-0002D5-HZ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWBz-0001Ve-Qi
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLWBy-0007au-Cm
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:37:35 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLWBy-0007Zv-70
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:37:34 -0400
Received: by mail-ot1-x343.google.com with SMTP id 21so5615635otj.11
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q3Dgggzvmh33bgxoFL75y/5zguo8PaVi4JqFgwckaVI=;
 b=mDonSJbMtU2D/Iix8aA8+u2Ov059+VZg/xRm9n6lgXLIrqvdGqoeVE1cQKGHl2C4ad
 Pvrc0pdhqMIgBvNhNIynyG0k58IO8JEHeK/RgfYgQshFjtLUj1KhuOkSu33dQaG5PYfD
 vRmOXUNUtAYkpywon/HYXU3sA8oSeK+SWkO8rNxunXmLGU5LBKCLcgI1lhO4tt0kBhyJ
 XNiMayyzk1jvqq4G6hX2IaL6CW0JdpsTDhqp7sb/lY7UVbGMDatWn1pdEW18TiEfeox0
 5vofXHKQbixW+oZdKNFNwmleQkk/aJtzH6nnkWd3EoisCJ6YK1PxDnWSgwW2DDf2ejVE
 mkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q3Dgggzvmh33bgxoFL75y/5zguo8PaVi4JqFgwckaVI=;
 b=jX3TVJv370fP0Zr4uXbLtOd2ue/+TNu2RqCXSPlKhXFdRp5w80MjGc6yZo9nHzNHz2
 rZHGZqlAdqmIGizqH/4MEreJfURCscaLoHHHTy5p5xbZXc/cdceq210NpISyt/VCpodt
 AFcYtlFbIk8bfvCeQNIsM0Y0ek2ZzZYIEOfs+Cq+yGJTTW6w3hpkVm1waoSOs2KzEdoz
 yejAjZvgXng4jEOCk1wgItAZLkzHLNsI9koSkSCjhCMp+D6JRf8f232QEbZ1BsRttXtn
 6GYSvidVog7/FDvoQZuH5f4HuhZ9TKx8ZoGrfwiVPAtEVR/Zb2ese0zfCSNU1hCAfSnp
 mkoA==
X-Gm-Message-State: APjAAAUE5RBY6PiGJIFCUMVRTH+pWMXrPgbBLTy7MYr/38qidHZDCf2n
 4on2Xa38F0o4sg+Hgnf5UK3ZifDaYJ0QogT7ubyo4Q==
X-Google-Smtp-Source: APXvYqwSgb9gEHy5xr2wp00je0d7puch/tNiEX+KGkSGfE4oWiaXJJX/LP1+SBckdkg4Z6F+vp5bUf94vgc951g0lJU=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr8154761oto.221.1571420253150; 
 Fri, 18 Oct 2019 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-9-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 18:37:22 +0100
Message-ID: <CAFEAcA_vpmUn4+GZEmUpYw4rQyE2irwgBs9oSQvTrDcv-7Buog@mail.gmail.com>
Subject: Re: [PATCH 08/14] cris: replace PROP_PTR with PROP_LINK for interrupt
 vector
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Instead of using raw interrupt vector pointer, store the associated
> CPU with a link property.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

A link property is reasonable for a tightly coupled CPU and
interrupt-controller. But in this case the binding is not
actually very tight, and we can avoid it.

> @@ -298,7 +296,7 @@ void axisdev88_init(MachineState *machine)
>
>      dev =3D qdev_create(NULL, "etraxfs,pic");
>      /* FIXME: Is there a proper way to signal vectors to the CPU core?  =
*/
> -    qdev_prop_set_ptr(dev, "interrupt_vector", &env->interrupt_vector);
> +    object_property_set_link(OBJECT(dev), OBJECT(cpu), "cpu", &error_abo=
rt);

Rather than using a link property like this, we could
instead make use of the fact that a qemu_irq line is
actually capable of passing an arbitrary "int" value,
not merely a bool. To do this we would:

 * remove the FIXME comment and the ptr prop/link prop code here
 * remove the definition of the property from the PIC device

> @@ -79,9 +78,10 @@ static void pic_update(struct etrax_pic *fs)
>          }
>      }
>
> -    if (fs->interrupt_vector) {
> -        /* hack alert: ptr property */
> -        *(uint32_t*)(fs->interrupt_vector) =3D vector;
> +    if (fs->cpu) {
> +        /* hack alert: cpu link property */
> +        int32_t *int_vec =3D &fs->cpu->env.interrupt_vector;
> +        *int_vec =3D (uint32_t)vector;
>      }
>      qemu_set_irq(fs->parent_irq, !!vector);

 * here, instead of setting the CPU interrupt_vector field
   and passing !!vector to qemu_set_irq, we just pass "vector",
   so the other end gets the whole integer

 * in target/cris/cpu.c:cris_cpu_set_irq(), we add something like
   if (irq =3D=3D CRIS_CPU_IRQ) {
       /*
        * The PIC passes us the vector for the IRQ as the value it sends
        * over the qemu_irq line
        */
       cpu->interrupt_vector =3D value;
   }
   at the top of the function.

It would also be nice somewhere to have a comment documenting
that this is the semantics the CPU expects for its incoming
IRQ line. Unless anybody has a better place, then perhaps
in the part of target/cris/cpu.h that defines CRIS_CPU_IRQ.
(If the PIC followed the just-recently-invented qdev convention
of having a .h file with a comment defining the "QEMU interface"
to the device, as eg include/hw/misc/armsse-mhu.h, then that
comment would be a good place to note that its sysbus IRQ 0
has these value-is-the-vector semantics. But it doesn't.)

>  }
> @@ -164,7 +164,7 @@ static void etraxfs_pic_init(Object *obj)
>  }
>
>  static Property etraxfs_pic_properties[] =3D {
> -    DEFINE_PROP_PTR("interrupt_vector", struct etrax_pic, interrupt_vect=
or),
> +    DEFINE_PROP_LINK("cpu", struct etrax_pic, cpu, TYPE_CRIS_CPU, CRISCP=
U *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> @@ -173,10 +173,6 @@ static void etraxfs_pic_class_init(ObjectClass *klas=
s, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->props =3D etraxfs_pic_properties;
> -    /*
> -     * Note: pointer property "interrupt_vector" may remain null, thus
> -     * no need for dc->user_creatable =3D false;
> -     */
>  }

Incidentally this is a sysbus device, so it's not user
creatable anyway.

thanks
-- PMM

