Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA64C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A522922205
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dP6qnSdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A522922205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNQs-0004Sb-Ow
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNk-0000KB-1P
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59648
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jvNNh-00080p-07
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594742527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHmDT7E65idIBHLwDNNFjWnd9xmHGR5VIecK7Ss0mic=;
 b=dP6qnSdT0dabL/oMyfX7kKGH2BCU7QJ0tF8o8OIfLZ4FhdMjSIBmCBJUVHVSXYQiXfqoM2
 DXEYGhdOeHiVMKA9CIX8ZpL856w/FkXjBVr9uM4qUms1DVmSMsmjN2MQm0XACtIkBXHfhh
 A56poPR/1amNDKQzkuMNh4Umi4LmnSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-yFusaVE6Pu6n4RVxFnIn3Q-1; Tue, 14 Jul 2020 12:01:34 -0400
X-MC-Unique: yFusaVE6Pu6n4RVxFnIn3Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3878015CB;
 Tue, 14 Jul 2020 16:01:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D43D96FDD1;
 Tue, 14 Jul 2020 16:01:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5130B1267F16; Tue, 14 Jul 2020 18:01:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 04/11] hw/arm: Add NPCM730 and NPCM750 SoC models
References: <20200709003608.3834629-1-hskinnemoen@google.com>
 <20200709003608.3834629-5-hskinnemoen@google.com>
 <3ec30463-03f8-98e9-9a14-01b0bb698c9b@kaod.org>
 <CAFQmdRYQxMz_qSr4i_cyqRPEGuq7At=VEOGvsupR3=W7pE3q=g@mail.gmail.com>
 <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org>
Date: Tue, 14 Jul 2020 18:01:29 +0200
In-Reply-To: <7c978e82-8890-9ba4-096a-92d7cff60b0a@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 14 Jul 2020 13:37:48
 +0200")
Message-ID: <877dv63x2e.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> +Markus
>
> On 7/14/20 2:44 AM, Havard Skinnemoen wrote:
>> On Mon, Jul 13, 2020 at 8:02 AM C=C3=A9dric Le Goater <clg@kaod.org> wro=
te:
>>>
>>> On 7/9/20 2:36 AM, Havard Skinnemoen wrote:
>>>> The Nuvoton NPCM7xx SoC family are used to implement Baseboard
>>>> Management Controllers in servers. While the family includes four SoCs=
,
>>>> this patch implements limited support for two of them: NPCM730 (target=
ed
>>>> for Data Center applications) and NPCM750 (targeted for Enterprise
>>>> applications).
>>>>
>>>> This patch includes little more than the bare minimum needed to boot a
>>>> Linux kernel built with NPCM7xx support in direct-kernel mode:
>>>>
>>>>   - Two Cortex-A9 CPU cores with built-in periperhals.
>>>>   - Global Configuration Registers.
>>>>   - Clock Management.
>>>>   - 3 Timer Modules with 5 timers each.
>>>>   - 4 serial ports.
>>>>
>>>> The chips themselves have a lot more features, some of which will be
>>>> added to the model at a later stage.
>>>>
>>>> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
>>>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>>> ---
> ...
>
>>>> +static void npcm7xx_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    NPCM7xxState *s =3D NPCM7XX(dev);
>>>> +    NPCM7xxClass *nc =3D NPCM7XX_GET_CLASS(s);
>>>> +    int i;
>>>> +
>>>> +    /* CPUs */
>>>> +    for (i =3D 0; i < nc->num_cpus; i++) {
>>>> +        object_property_set_int(OBJECT(&s->cpu[i]),
>>>> +                                arm_cpu_mp_affinity(i, NPCM7XX_MAX_NU=
M_CPUS),
>>>> +                                "mp-affinity", &error_abort);
>>>> +        object_property_set_int(OBJECT(&s->cpu[i]), NPCM7XX_GIC_CPU_I=
F_ADDR,
>>>> +                                "reset-cbar", &error_abort);
>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), true,
>>>> +                                 "reset-hivecs", &error_abort);
>>>> +
>>>> +        /* Disable security extensions. */
>>>> +        object_property_set_bool(OBJECT(&s->cpu[i]), false, "has_el3"=
,
>>>> +                                 &error_abort);
>>>> +
>>>> +        qdev_realize(DEVICE(&s->cpu[i]), NULL, &error_abort);
>>>
>>> I would check the error:
>>>
>>>         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
>>>             return;
>>>         }
>>>
>>> same for the sysbus_realize() below.
>>=20
>> Hmm, I used to propagate these errors until Philippe told me not to
>> (or at least that's how I understood it).
>
> It was before Markus simplification API were merged, you had to
> propagate after each call, since this is a non hot-pluggable SoC
> I suggested to use &error_abort to simplify.
>
>> I'll be happy to do it
>> either way (and the new API makes it really easy to propagate errors),
>> but I worry that I don't fully understand when to propagate errors and
>> when not to.
>
> Markus explained it on the mailing list recently (as I found the doc
> not obvious). I can't find the thread. I suppose once the work result
> after the "Questionable aspects of QEMU Error's design" discussion is
> merged, the documentation will be clarified.

The Error API evolved recently.  Please peruse the big comment in
include/qapi/error.h.  If still unsure, don't hesitate to ask here.

> My rule of thumb so far is:
> - programming error (can't happen) -> &error_abort

Correct.  Quote the big comment:

 * Call a function aborting on errors:
 *     foo(arg, &error_abort);
 * This is more concise and fails more nicely than
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     assert(!err); // don't do this

> - everything triggerable by user or management layer (via QMP command)
>   -> &error_fatal, as we can't risk loose the user data, we need to
>   shutdown gracefully.

Quote the big comment:

 * Call a function treating errors as fatal:
 *     foo(arg, &error_fatal);
 * This is more concise than
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) { // don't do this
 *         error_report_err(err);
 *         exit(1);
 *     }

Terminating the process is generally fine during initial startup,
i.e. before the guest runs.

It's generally not fine once the guest runs.  Errors need to be handled
more gracefully then.  A QMP command, for instance, should fail cleanly,
propagating the error to the monitor core, which then sends it to the
QMP client, and loops to process the next command.

>> It makes sense to me to propagate errors from *_realize() and
>> error_abort on failure to set simple properties, but I'd like to know
>> if Philippe is on board with that.

Realize methods must not use &error_fatal.  Instead, they should clean
up and fail.

"Clean up" is the part we often neglect.  The big advantage of
&error_fatal is that you don't have to bother :)

Questions?

[...]


