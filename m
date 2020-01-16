Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE3EC32771
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740DA2081E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 02:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3c+c10d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740DA2081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iruf9-0001I0-Ji
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 21:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1irueP-0000qI-Oy
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1irueN-00072h-85
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:12:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1irueN-00072S-4Y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 21:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579140766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R00L1095O9nTh7G5P9B8iq6TBQuzC8FVdNaOmj8XKLY=;
 b=T3c+c10dNjeRAQuZHRmiP6islQBr3DneAO/x+7vbB1xIERAwB3vfSKvsn1ABs8gFb8XCKa
 M3EdcZiYPjIlE1xRzUHKsQG2n6n9u2GJ/cqtangAC/5haedutRSg5U6xmmKsEOE1kiG4Y/
 Bva3nNmB5RoopW4sKyFozoZvMetaFTQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-QtqKWarwNPCN0cMz4gHMEw-1; Wed, 15 Jan 2020 21:12:45 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so8670504wrh.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 18:12:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o8i9Kit7DYRlwxlU+urtgyZ7FiFo6jpa5xlnLV6maXA=;
 b=WvjSkv+4hsrHlyLhFzerhwn3wEokvRbUgQy0tPMuX5Fozgt9mFlX1DAWt8Oc02F+lA
 I2rc+Y1m7FXCkx/JaOPpV65gbMqQWp+NW3MJHRyW8LVjtjJiAeBYR5nJECgnikUdoA7C
 WoyzQ8GWiOu5+Cg+ca1fjrv01Onal2CS/dg5TnsCPqW5T0dKOVuKt2T/ukfp4ZQT1kR4
 UTaObNNVWVMdcaUwCjvbToj05TvKw9Pgp20QEyPhfDse2bE75kY1hMSWMngpTUpgDoph
 Js3yY4/l4eG1nJ4cBDHV8mHL48C4BXNM+4ZA+vhrBfSlV3PAk7fckfYjB/TPPM2VGEY7
 8/pA==
X-Gm-Message-State: APjAAAUea11Kg2Etj9wmwXg2PhJ+cHadX8R4mPv77hy73lwRzSkNgdUP
 D8PfQexLP86rm3v4JC2OtMZmeIV+q65KhcdlGQfUtggPnOj1nuGNjzNOigHIy+6jwLMcwzHC49K
 0G5QgJmiZ88VqFMA=
X-Received: by 2002:a1c:640a:: with SMTP id y10mr3432837wmb.14.1579140763979; 
 Wed, 15 Jan 2020 18:12:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZvm0TA8B1wtGMdt3yw3V7u0TbhJKi/486qxTIuJIVk7gqfCq2DGdq1nj53V2nAVlPdOqDdA==
X-Received: by 2002:a1c:640a:: with SMTP id y10mr3432812wmb.14.1579140763711; 
 Wed, 15 Jan 2020 18:12:43 -0800 (PST)
Received: from [192.168.1.24] (lfbn-mon-1-1519-115.w92-167.abo.wanadoo.fr.
 [92.167.83.115])
 by smtp.gmail.com with ESMTPSA id f12sm1632107wmf.28.2020.01.15.18.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 18:12:43 -0800 (PST)
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
 <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
Message-ID: <eb4b0a37-711d-9de7-8bca-86b0d2caad55@redhat.com>
Date: Thu, 16 Jan 2020 03:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
Content-Language: en-US
X-MC-Unique: QtqKWarwNPCN0cMz4gHMEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>, cohuck@redhat.com,
 mark.burton@greensocs.com, qemu-s390x@nongnu.org, edgari@xilinx.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/16/20 2:59 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/15/20 1:36 PM, Damien Hedde wrote:
>> This commit defines an interface allowing multi-phase reset. This aims
>> to solve a problem of the actual single-phase reset (built in
>> DeviceClass and BusClass): reset behavior is dependent on the order
>> in which reset handlers are called. In particular doing external
>> side-effect (like setting an qemu_irq) is problematic because receiving
>> object may not be reset yet.
>>
>> The Resettable interface divides the reset in 3 well defined phases.
>> To reset an object tree, all 1st phases are executed then all 2nd then
>> all 3rd. See the comments in include/hw/resettable.h for a more complete
>> description. The interface defines 3 phases to let the future
>> possibility of holding an object into reset for some time.
>>
>> The qdev/qbus reset in DeviceClass and BusClass will be modified in
>> following commits to use this interface. A mechanism is provided
>> to allow executing a transitional reset handler in place of the 2nd
>> phase which is executed in children-then-parent order inside a tree.
>> This will allow to transition devices and buses smoothly while
>> keeping the exact current qdev/qbus reset behavior for now.
>>
>> Documentation will be added in a following commit.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> v7 update: un-nest struct ResettablePhases
>> ---
>> =C2=A0 Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++++
>> =C2=A0 hw/core/resettable.c=C2=A0=C2=A0=C2=A0 | 238 ++++++++++++++++++++=
++++++++++++++++++++
>> =C2=A0 hw/core/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/core/trace-events=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +++
>> =C2=A0 5 files changed, 468 insertions(+)
>> =C2=A0 create mode 100644 include/hw/resettable.h
>> =C2=A0 create mode 100644 hw/core/resettable.c
>>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 7c1e50f9d6..9752d549b4 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -191,6 +191,7 @@ trace-events-subdirs +=3D migration
>> =C2=A0 trace-events-subdirs +=3D net
>> =C2=A0 trace-events-subdirs +=3D ui
>> =C2=A0 endif
>> +trace-events-subdirs +=3D hw/core
>=20
> TL;DR Duplicating this line breaks using the LTTng Userspace Tracer=20
> library (UST backend).
>=20
> Probably because you started this series before commit 26b8e6dc42b got=20
> merged, Jun 13 2019!
>=20
> Indeed Oct 02 2018...
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg564153.html
>=20
> The problem is you (correctly) sorted alphabetically while Alexey=20
> appended at the end.
>=20
>> =C2=A0 trace-events-subdirs +=3D hw/display
>> =C2=A0 trace-events-subdirs +=3D qapi
>> =C2=A0 trace-events-subdirs +=3D qom
[...]
>> diff --git a/hw/core/trace-events b/hw/core/trace-events
>> index a375aa88a4..a2e43f1120 100644
>> --- a/hw/core/trace-events
>> +++ b/hw/core/trace-events
>> @@ -9,3 +9,20 @@ qbus_reset(void *obj, const char *objtype) "obj=3D%p(%s=
)"
>> =C2=A0 qbus_reset_all(void *obj, const char *objtype) "obj=3D%p(%s)"
>> =C2=A0 qbus_reset_tree(void *obj, const char *objtype) "obj=3D%p(%s)"
>> =C2=A0 qdev_update_parent_bus(void *obj, const char *objtype, void *oldp=
,=20
>> const char *oldptype, void *newp, const char *newptype) "obj=3D%p(%s)=20
>> old_parent=3D%p(%s) new_parent=3D%p(%s)"
>> +
>> +# resettable.c
>> +resettable_reset(void *obj, int cold) "obj=3D%p cold=3D%d"
>> +resettable_reset_assert_begin(void *obj, int cold) "obj=3D%p cold=3D%d"
>> +resettable_reset_assert_end(void *obj) "obj=3D%p"
>> +resettable_reset_release_begin(void *obj, int cold) "obj=3D%p cold=3D%d=
"
>> +resettable_reset_release_end(void *obj) "obj=3D%p"
>> +resettable_phase_enter_begin(void *obj, const char *objtype, uint32_t=
=20
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_enter_exec(void *obj, const char *objtype, int type,=
=20
>> int has_method) "obj=3D%p(%s) type=3D%d method=3D%d"
>> +resettable_phase_enter_end(void *obj, const char *objtype, uint32_t=20
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_phase_hold_begin(void *obj, const char *objtype, uint32_t=20
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_hold_exec(void *obj, const char *objtype, int=20
>> has_method) "obj=3D%p(%s) method=3D%d"
>> +resettable_phase_hold_end(void *obj, const char *objtype, uint32_t=20
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_phase_exit_begin(void *obj, const char *objtype, uint32_t=20
>> count, int type) "obj=3D%p(%s) count=3D%" PRIu32 " type=3D%d"
>> +resettable_phase_exit_exec(void *obj, const char *objtype, int=20
>> has_method) "obj=3D%p(%s) method=3D%d"
>> +resettable_phase_exit_end(void *obj, const char *objtype, uint32_t=20
>> count) "obj=3D%p(%s) count=3D%" PRIu32
>> +resettable_transitional_function(void *obj, const char *objtype)=20
>> "obj=3D%p(%s)"
>=20
> Something here breaks ./configure --enable-trace-backends=3Dust:
>=20
>  =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace-ust-all.o
> In file included from trace-ust-all.h:13,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
> trace-ust-all.h:35151:1: error: redefinition of=20
> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99
> 35151 | TRACEPOINT_EVENT(
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> trace-ust-all.h:31791:1: note: previous definition of=20
> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99 was here
> 31791 | TRACEPOINT_EVENT(
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> ...
> ./trace-ust-all.h:35388:1: error: redefinition of=20
> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99
> 35388 | TRACEPOINT_EVENT(
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> ./trace-ust-all.h:32028:1: note: previous definition of=20
> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99 was here
> 32028 | TRACEPOINT_EVENT(
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> In file included from /usr/include/lttng/tracepoint-event.h:58,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.h:35401,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
>=20
> Indeed:
>=20
> 32028 TRACEPOINT_EVENT(
> 32029=C2=A0=C2=A0=C2=A0 qemu,
> 32030=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
> 32031=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
> 32032=C2=A0=C2=A0=C2=A0 TP_FIELDS(
> 32033=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *, o=
bj, obj)
> 32034=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, objty=
pe)
> 32035=C2=A0=C2=A0=C2=A0 )
> 32036 )
> 32037
> ...
> 35388 TRACEPOINT_EVENT(
> 35389=C2=A0=C2=A0=C2=A0 qemu,
> 35390=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
> 35391=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
> 35392=C2=A0=C2=A0=C2=A0 TP_FIELDS(
> 35393=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *, o=
bj, obj)
> 35394=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, objty=
pe)
> 35395=C2=A0=C2=A0=C2=A0 )
> 35396 )
> 35397
> 35398 #endif /* TRACE_ALL_GENERATED_UST_H */
>=20
> Ah! I was going to say "no clue what could be wrong, so Cc'ing Stefan"=20
> but got it:
>=20
> $ git grep hw/core Makefile.objs
> Makefile.objs:194:trace-events-subdirs +=3D hw/core
> Makefile.objs:207:trace-events-subdirs +=3D hw/core
>=20
> We might already have a 'uniq' makefile function to do:
>=20
> trace-events-subdirs =3D $(call uniq $(trace-events-subdirs))
>=20
> or maybe was it with $filter? I can't find it/remember, too tired.
>=20
> So the fix is:
>=20
> -- >8 --
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -191,7 +191,6 @@ trace-events-subdirs +=3D migration
>  =C2=A0trace-events-subdirs +=3D net
>  =C2=A0trace-events-subdirs +=3D ui
>  =C2=A0endif
> -trace-events-subdirs +=3D hw/core
>  =C2=A0trace-events-subdirs +=3D hw/display
>  =C2=A0trace-events-subdirs +=3D qapi
>  =C2=A0trace-events-subdirs +=3D qom
> ---

Forgot to add, with trace-events-subdirs fixed:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


