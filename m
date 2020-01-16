Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C83C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B952077B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="3JVgHpXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B952077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is0we-0007bS-Oj
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 03:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1is0u3-0006SR-0R
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1is0tz-0006ob-85
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:53:22 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:59574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1is0ty-0006nW-Mm; Thu, 16 Jan 2020 03:53:19 -0500
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0DE8696EF0;
 Thu, 16 Jan 2020 08:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1579164796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5IceCliV2lbMO7kG3HphU0YLo9JhsbNxMSaFmQXIDU=;
 b=3JVgHpXFJxxzN7wJvkorYbjmn+bcpFaFUs71TE2+rLuwWOYXumsCBDSzetTaQCGgD876bW
 Ju9vu+IvgLSGqA/uB431iPsFlliEmcDZVfRGtpreNVdbUx2+NO3zEUbpQa7OjRj8zwX+bX
 xePKw3fKzb2H2melludgGL+DC294MkY=
Subject: Re: [PATCH v7 03/11] hw/core: create Resettable QOM interface
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20200115123620.250132-1-damien.hedde@greensocs.com>
 <20200115123620.250132-4-damien.hedde@greensocs.com>
 <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <42e9a018-0070-205b-65ed-1d7a6a1b1ff5@greensocs.com>
Date: Thu, 16 Jan 2020 09:53:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <656ee01a-54ad-273f-e71e-873328428565@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1579164796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5IceCliV2lbMO7kG3HphU0YLo9JhsbNxMSaFmQXIDU=;
 b=qH8euC2K0S6jVJZzok8n/hRqT2uaHWvw685QaAyLKdLFmoE6y3h1is8ZwOY1/j58iw1PFq
 rgeKAHDA2fyIcVf2VyTJS2Le/WePMf95UZABixY+oWr5SYgUIWBB4UPuomt/kwWkzPXHB8
 3bPzA9oM4VpeJzNSvbxJZuHJhkdCWm0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1579164796; a=rsa-sha256; cv=none;
 b=5EcU/15nI28TKUkchNT3ygqAB3sE6Xw8sZf8CdDtz/LE/dEo6zvwdd6XXxBxuETRXmw08k
 +MFEhbGRaPe+ddtWM/nXzXRrfb5ullu4OHCkjYUERBNfHiu+WCxB1dV/AYR+kgHx4exh0J
 9MiIrGhBIALriauZp5UNfQXOhzWA4hE=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
>> side-effect (like setting an qemu_irq) is problematic because receivin=
g
>> object may not be reset yet.
>>
>> The Resettable interface divides the reset in 3 well defined phases.
>> To reset an object tree, all 1st phases are executed then all 2nd then
>> all 3rd. See the comments in include/hw/resettable.h for a more comple=
te
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
>> =C2=A0 include/hw/resettable.h | 211 +++++++++++++++++++++++++++++++++=
++
>> =C2=A0 hw/core/resettable.c=C2=A0=C2=A0=C2=A0 | 238 ++++++++++++++++++=
++++++++++++++++++++++
>> =C2=A0 hw/core/Makefile.objs=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 hw/core/trace-events=C2=A0=C2=A0=C2=A0 |=C2=A0 17 +++
>> =C2=A0 5 files changed, 468 insertions(+)
>> =C2=A0 create mode 100644 include/hw/resettable.h
>> =C2=A0 create mode 100644 hw/core/resettable.c
>>

>=20
> Something here breaks ./configure --enable-trace-backends=3Dust:
>=20
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace-ust-all.o
> In file included from trace-ust-all.h:13,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
> trace-ust-all.h:35151:1: error: redefinition of
> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99
> 35151 | TRACEPOINT_EVENT(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> trace-ust-all.h:31791:1: note: previous definition of
> =E2=80=98__tracepoint_cb_qemu___loader_write_rom=E2=80=99 was here
> 31791 | TRACEPOINT_EVENT(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> ...
> ./trace-ust-all.h:35388:1: error: redefinition of
> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99
> 35388 | TRACEPOINT_EVENT(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> ./trace-ust-all.h:32028:1: note: previous definition of
> =E2=80=98__tp_event_signature___qemu___resettable_transitional_function=
=E2=80=99 was here
> 32028 | TRACEPOINT_EVENT(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ^~~~~~~~~~~~~~~~
> In file included from /usr/include/lttng/tracepoint-event.h:58,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.h:35401,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 from trace-ust-all.c:13:
>=20
> Indeed:
>=20
> 32028 TRACEPOINT_EVENT(
> 32029=C2=A0=C2=A0=C2=A0 qemu,
> 32030=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
> 32031=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
> 32032=C2=A0=C2=A0=C2=A0 TP_FIELDS(
> 32033=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *,=
 obj, obj)
> 32034=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, obj=
type)
> 32035=C2=A0=C2=A0=C2=A0 )
> 32036 )
> 32037
> ...
> 35388 TRACEPOINT_EVENT(
> 35389=C2=A0=C2=A0=C2=A0 qemu,
> 35390=C2=A0=C2=A0=C2=A0 resettable_transitional_function,
> 35391=C2=A0=C2=A0=C2=A0 TP_ARGS(void *, obj, const char *, objtype),
> 35392=C2=A0=C2=A0=C2=A0 TP_FIELDS(
> 35393=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_integer_hex(void *,=
 obj, obj)
> 35394=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctf_string(objtype, obj=
type)
> 35395=C2=A0=C2=A0=C2=A0 )
> 35396 )
> 35397
> 35398 #endif /* TRACE_ALL_GENERATED_UST_H */
>=20
> Ah! I was going to say "no clue what could be wrong, so Cc'ing Stefan"
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

You can use $sort to remove duplicates in make.

>=20
> So the fix is:
>=20
> -- >8 --
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -191,7 +191,6 @@ trace-events-subdirs +=3D migration
> =C2=A0trace-events-subdirs +=3D net
> =C2=A0trace-events-subdirs +=3D ui
> =C2=A0endif
> -trace-events-subdirs +=3D hw/core
> =C2=A0trace-events-subdirs +=3D hw/display
> =C2=A0trace-events-subdirs +=3D qapi
> =C2=A0trace-events-subdirs +=3D qom
> ---
>=20

I'll remove the duplicate entry.
Thanks,

Damien

