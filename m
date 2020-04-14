Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8AC352B6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1721F20575
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOVXGakY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1721F20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOFop-0004N2-6j
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 03:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jOFnn-0003Y2-AF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jOFnl-0001iG-60
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:16:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33623
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jOFnk-0001hv-UN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586848568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIxxP2P7bDv0LyJOEFsSl+b26dNwRkjroj5o9XBzADA=;
 b=YOVXGakYD9mcV0Ttd8589I0jllkvEtp1HrOx+AMQNsfc9XGNqm0/PWsfr7HLmbytc5IOY/
 X6EqRt86x6sKBHdcHAmSMh+sjd4BEYJpLRim6gq9czEhNbvl1wirdIFuXNon2VkVv1ZdID
 lWD9j7HgC9X4hxXKHI7w9kiPwq4z/yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-VXY0blHTPYSvQf01L1nR-A-1; Tue, 14 Apr 2020 03:16:06 -0400
X-MC-Unique: VXY0blHTPYSvQf01L1nR-A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F046E108838D;
 Tue, 14 Apr 2020 07:16:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-20.ams2.redhat.com
 [10.36.113.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 352DC1000325;
 Tue, 14 Apr 2020 07:16:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9B7E11385C8; Tue, 14 Apr 2020 09:15:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Subject: Re: [PATCH v9 5/9] docs/clocks: add device's clock documentation
References: <20200406135251.157596-1-damien.hedde@greensocs.com>
 <20200406135251.157596-6-damien.hedde@greensocs.com>
 <87pncjzxwc.fsf@dusky.pond.sub.org>
 <f5556e5f-ee75-10cb-53f3-b249de8a5147@greensocs.com>
Date: Tue, 14 Apr 2020 09:15:59 +0200
In-Reply-To: <f5556e5f-ee75-10cb-53f3-b249de8a5147@greensocs.com> (Damien
 Hedde's message of "Wed, 8 Apr 2020 12:06:10 +0200")
Message-ID: <87sgh6zgeo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org,
 berrange@redhat.com, ehabkost@redhat.com, alistair@alistair23.me,
 mark.burton@greensocs.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, philmd@redhat.com, edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Damien Hedde <damien.hedde@greensocs.com> writes:

> On 4/7/20 7:07 AM, Markus Armbruster wrote:
>> Damien Hedde <damien.hedde@greensocs.com> writes:
>>=20
>>> Add the documentation about the clock inputs and outputs in devices.
>>>
>>> This is based on the original work of Frederic Konrad.
>>>
>>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> ---
>>> v9:
>>>  + fix a few typos (Alistair)
>>>
>>> v8:
>>>  + fix list indentation
>>>  + reduce title size
>>>
>>> v7:
>>>  + update ClockIn/Out types
>>>  + switch to rst format
>>> ---
>>>  docs/devel/clocks.rst | 360 ++++++++++++++++++++++++++++++++++++++++++
>>>  docs/devel/index.rst  |   1 +
>>>  2 files changed, 361 insertions(+)
>>>  create mode 100644 docs/devel/clocks.rst
>>>
>>> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
>>> new file mode 100644
>>> index 0000000000..ead9f55561
>>> --- /dev/null
>>> +++ b/docs/devel/clocks.rst
>>> @@ -0,0 +1,360 @@
>>> +Modeling a clock tree in QEMU
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>>> +
>>> +What are clocks
>>> +---------------
>>> +
>>> +Clocks are QOM objects developed for the purpose of modeling the
>>> +distribution of clocks in QEMU.
>>> +
>>> +They allow us to model the clock distribution of a platform and detect
>>> +configuration errors in the clock tree such as badly configured PLL, c=
lock
>>> +source selection or disabled clock.
>>> +
>>> +The object is *Clock* and its QOM name is ``CLOCK``.
>>=20
>> PATCH 1 has
>>=20
>>     #define TYPE_CLOCK "clock"
>>=20
>> Ignorant question: how is this related to *Clock* and ``CLOCK``?
>>=20
>> [...]
>>=20
>
> Hi Markus,
>
>
> *Clock* refer to the C type
>> typedef struct Clock Clock;

Okay.

> I think I've put ``CLOCK`` in uppercase because, in practical, we only
> use the upper case macro.

True for internal code, not true at external interfaces.

>> #define TYPE_CLOCK "clock"
>> #define CLOCK(obj) OBJECT_CHECK(Clock, (obj), TYPE_CLOCK)
>
> I'm not sure what is the right terminology here. Maybe I can replace by
> the following:
>
>> The QOM name of a clock is ``"clock"`` (or the macro ``TYPE_CLOCK``).
> The C type object is *Clock*.

Better.

Maybe (in C, the macro ``TYPE_CLOCK'') or (C macro ``TYPE_CLOCK'').
Your choice :)


