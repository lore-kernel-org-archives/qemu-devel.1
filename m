Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C223C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2954D2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cp0j0XQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2954D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdpc-00063W-Cb
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvdp1-0005WX-6K
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:35:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38363
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvdoy-0004sN-Qh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594805723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wgkYwopxwjScbqQg3bR+f7tZkTpVNp/UWEcHxJk8Ws=;
 b=cp0j0XQFzbp73ce1D1fx23baQqJPc8/rX5oX4IV8iwAA2oqsfkiyYmwHViG37J3/5Hm/Qy
 Tg7vJUwYxqVedPYkamKuErOCEsEM+Bweh29bq2MONd6kbudeOXp/znVKgioQokQUDDExnk
 EMHlD0RcjNbEtJeeRldOciNKt62V0k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-6-XJBxGGP_GFJNsdFtYFog-1; Wed, 15 Jul 2020 05:35:19 -0400
X-MC-Unique: 6-XJBxGGP_GFJNsdFtYFog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E44A1087;
 Wed, 15 Jul 2020 09:35:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3256B72E74;
 Wed, 15 Jul 2020 09:35:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B0F78105A45D; Wed, 15 Jul 2020 11:35:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Havard Skinnemoen <hskinnemoen@google.com>
Subject: Re: [PATCH v5 04/11] hw/arm: Add NPCM730 and NPCM750 SoC models
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-5-hskinnemoen@google.com>
 <3ec30463-03f8-98e9-9a14-01b0bb698c9b@kaod.org>
 <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
 <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org>
 <877dv63x2e.fsf@dusky.pond.sub.org>
 <11c410d4-b310-faf1-5116-2ab62270c3cb@amsat.org>
 <CAFQmdRZKnP=NCzoVtPz5LFXFKrboTFxY1EWxOD_w9CCFd-dYiA@mail.gmail.com>
Date: Wed, 15 Jul 2020 11:35:15 +0200
In-Reply-To: <CAFQmdRZKnP=NCzoVtPz5LFXFKrboTFxY1EWxOD_w9CCFd-dYiA@mail.gmail.com>
 (Havard Skinnemoen's message of "Tue, 14 Jul 2020 18:03:16 -0700")
Message-ID: <87blkhyvcc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 05:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Havard Skinnemoen <hskinnemoen@google.com> writes:

> On Tue, Jul 14, 2020 at 10:11 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>>
>> On 7/14/20 6:01 PM, Markus Armbruster wrote:
>> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>> >
>> >> +Markus
>> >>
>> >> On 7/14/20 2:44 AM, Havard Skinnemoen wrote:
>> >>> On Mon, Jul 13, 2020 at 8:02 AM C=C3=A9dric Le Goater <clg@kaod.org>=
 wrote:
>> >>>>
>> >>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>> >>>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>> >>>>> Management Controllers in servers. While the family includes four =
SoCs,
>> >>>>> this patch implements limited support for two of them: NPCM730 (ta=
rgeted
>> >>>>> for Data Center applications) and NPCM750 (targeted for Enterprise
>> >>>>> applications).
>> >>>>>
>> >>>>> This patch includes little more than the bare minimum needed to bo=
ot a
>> >>>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>> >>>>>
>> >>>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>> >>>>>   - Global Configuration Registers.
>> >>>>>   - Clock Management.
>> >>>>>   - 3 Timer Modules with 5 timers each.
>> >>>>>   - 4 serial ports.
>> >>>>>
>> >>>>> The chips themselves have a lot more features, some of which will =
be
>> >>>>> added to the model at a later stage.
>> >>>>>
>> >>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>> >>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>> >>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>> >>>>> ---
>> >> ...
>> >>
>> >>>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>> >>>>> +{
>> >>>>> +    NPCM7xxState *s =3D NPCM7XX(dev);
>> >>>>> +    NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
>> >>>>> +    int i;
>> >>>>> +
>> >>>>> +    /* CPUs */
>> >>>>> +    for (i =3D 0; i < nc->num_cpus; i++) {
>> >>>>> +        object_property_set_int(OBJECT(&s->cpu[i]),
>> >>>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MA=
X_NUM_CPUS),
>> >>>>> +                                "mp-affinity", &error_abort);
>> >>>>> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_C=
PU_IF_ADDR,
>> >>>>> +                                "reset-cbar", &error_abort);
>> >>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
>> >>>>> +                                 "reset-hivecs", &error_abort);
>> >>>>> +
>> >>>>> +        /* Disable security extensions. */
>> >>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_=
el3",
>> >>>>> +                                 &error_abort);
>> >>>>> +
>> >>>>> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>> >>>>
>> >>>> I would check the error:
>> >>>>
>> >>>>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>> >>>>             return;
>> >>>>         }
>> >>>>
>> >>>> same for the sysbus_realize() below.
>> >>>
>> >>> Hmm, I used to propagate these errors until Philippe told me not to
>> >>> (or at least that's how I understood it).
>> >>
>> >> It was before Markus simplification API were merged, you had to
>> >> propagate after each call, since this is a non hot-pluggable SoC
>> >> I suggested to use &error_abort to simplify.
>> >>
>> >>> I'll be happy to do it
>> >>> either way (and the new API makes it really easy to propagate errors=
),
>> >>> but I worry that I don't fully understand when to propagate errors a=
nd
>> >>> when not to.
>> >>
>> >> Markus explained it on the mailing list recently (as I found the doc
>> >> not obvious). I can't find the thread. I suppose once the work result
>> >> after the "Questionable aspects of QEMU Error's design" discussion is
>> >> merged, the documentation will be clarified.
>> >
>> > The Error API evolved recently.  Please peruse the big comment in
>> > include/qapi/error.h.  If still unsure, don't hesitate to ask here.
>> >
>> >> My rule of thumb so far is:
>> >> - programming error (can't happen) -> &error_abort
>> >
>> > Correct.  Quote the big comment:
>> >
>> >  * Call a function aborting on errors:
>> >  *     foo(arg, &error_abort);
>> >  * This is more concise and fails more nicely than
>> >  *     Error *err =3D NULL;
>> >  *     foo(arg, &err);
>> >  *     assert(!err); // don't do this
>> >
>> >> - everything triggerable by user or management layer (via QMP command=
)
>> >>   -> &error_fatal, as we can't risk loose the user data, we need to
>> >>   shutdown gracefully.
>> >
>> > Quote the big comment:
>> >
>> >  * Call a function treating errors as fatal:
>> >  *     foo(arg, &error_fatal);
>> >  * This is more concise than
>> >  *     Error *err =3D NULL;
>> >  *     foo(arg, &err);
>> >  *     if (err) { // don't do this
>> >  *         error_report_err(err);
>> >  *         exit(1);
>> >  *     }
>> >
>> > Terminating the process is generally fine during initial startup,
>> > i.e. before the guest runs.
>> >
>> > It's generally not fine once the guest runs.  Errors need to be handle=
d
>> > more gracefully then.  A QMP command, for instance, should fail cleanl=
y,
>> > propagating the error to the monitor core, which then sends it to the
>> > QMP client, and loops to process the next command.
>> >
>> >>> It makes sense to me to propagate errors from *_realize() and
>> >>> error_abort on failure to set simple properties, but I'd like to kno=
w
>> >>> if Philippe is on board with that.
>> >
>> > Realize methods must not use &error_fatal.  Instead, they should clean
>> > up and fail.
>> >
>> > "Clean up" is the part we often neglect.  The big advantage of
>> > &error_fatal is that you don't have to bother :)
>> >
>> > Questions?
>>
>> One on my side. So in this realize(), all &error_abort uses has
>> to be replaced by local_err + propagate ...:

Except for the ones where failure is a programming error.  For instance,
...

>> static void npcm7xx_realize(DeviceState *dev, Error **errp)
>> {
>>     NPCM7xxState *s =3D NPCM7XX(dev);
>>     NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
>>     int i;
>>
>>     /* CPUs */
>>     for (i =3D 0; i < nc->num_cpus; i++) {
>>         object_property_set_int(OBJECT(&s->cpu[i]),
>>                                 arm_cpu_mp_affinity(i,
>> NPCM7XX_MAX_NUM_CPUS),
>>                                 "mp-affinity", &error_abort);
>>         object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_IF_A=
DDR,
>>                                 "reset-cbar", &error_abort);
>>         object_property_set_bool(OBJECT(&s->cpu[i]), true,
>>                                  "reset-hivecs", &error_abort);

... object_property_set_bool() can fail only when

* No property with that name exists (programming error)

* The property is read-only (programming error)

* Its ->set() method fails

  The method is actually set_bool(), which fails only when

  - the device is already realized (programming errro)
  - visit_type_bool() fails (programming error)

Now, you may prefer not to know all that here, and instead propagate the
error.  I have two issues with that: it clutters the code, and the
impossible error path is untestable.

The common way to limit the clutter is of course skipping the cleanup ;)

You could also aim for the sour spot where the impossible error path is
wrong.  Extra points for making it subtly wrong, and tempting to copy to
a place where it's actually possible.

Bah, I'll take &error_abort, thank you very much.

>>
>>         /* Disable security extensions. */
>>         object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3",
>>                                  &error_abort);
>>
>>         qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>>     }
>>     [...]
>>
>> ... but the caller does:
>>
>> static void quanta_gsj_init(MachineState *machine)
>> {
>>     NPCM7xxState *soc;
>>
>>     soc =3D npcm7xx_create_soc(machine, QUANTA_GSJ_POWER_ON_STRAPS);
>>     npcm7xx_connect_dram(soc, machine->ram);
>>     qdev_realize(DEVICE(soc), NULL, &error_abort);
>>                                     ^^^^^^^^^^^^
>>     npcm7xx_load_kernel(machine, soc);
>> }

quanta_gsj_init() states "realizing this device can't fail".

The realize method states "this step can't fail" for a number of steps.

What's wrong with that?

>>
>> So we overload the code...
>>
>> My question: Do you confirm this is worth it to propagate?
>
> Here's my understanding. Please let me know if it sounds right.
>
> 1. Internal code failing to set simple properties to predefined values
> is a programming error, so error_abort is appropriate.

That would be my advice.

> 2. qdev_realize() may fail due to user input, so errors should be propaga=
ted.

In general, yes.  For a specific device, you may know it can't fail, and
then &error_abort may be okay.

> 3. machine init can't propagate errors any further, so all errors are
> fatal.

Basically yes.

A machine init may also choose to recover from an error.  Say create an
optional device, and if it doesn't work, just omit it.  Just an example
for illustration; it feels like a bad idea to me.

>        But if all realize() functions follow (1) and (2), only user
> errors are propagated, so error_fatal should be used to produce a nice
> error message rather than "Unexpected error, aborting!"

Yes.

> If any of this can ever be hot-plugged, then it means errors may
> propagate somewhere other than the machine init code, so it becomes
> extra important not to let bad user input crash the whole qemu
> process. I don't know if this is a concern when none of these devices
> can currently be hot-plugged.

Many, many devices neglect to clean up properly on error, and get away
with it only because all callers treat errors as fatal.

If you decide to take cleanup shortcuts, say because the cleanup is
untestable, consider adding a comment at least.

> For example, if the user tries to create a machine with 64 MB RAM, the
> gcr device will report an error because it can't represent less than
> 128 MB of memory. Currently, this is reported as
>
> $ ./arm-softmmu/qemu-system-arm -machine npcm750-evb -nographic -m 64
> Unexpected error in npcm7xx_gcr_realize() at
> /usr/local/google/home/hskinnemoen/qemu/for-upstream/hw/misc/npcm7xx_gcr.=
c:151:
> qemu-system-arm: npcm7xx_gcr: DRAM size 67108864 is too small (128 MiB mi=
nimum)
> Aborted
>
> But if I change npcm7xx_realize() to propagate errors from
> sysbus_realize(gcr), and change npcm750_evb_init() to use error_fatal
> instead of error_abort, I get
>
> $ ./arm-softmmu/qemu-system-arm -machine npcm750-evb -nographic -m 64
> qemu-system-arm: npcm7xx_gcr: DRAM size 67108864 is too small (128 MiB mi=
nimum)
>
> which seems less scary and more accurate.

Looks like a bug fix to me :)


