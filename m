Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CFEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8F120663
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUhX6Z9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8F120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkiCG-0002YI-2S
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkiAB-0001ju-Ck
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:00:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39135
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jkiA9-00073M-4m
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592200804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w0kkXNv70dNbNxm04rf6lrnv8H1jBnCrcQ7MyuFajsg=;
 b=NUhX6Z9NzxYpLE2G4W0FmtpEVHyGP4yYvAoBXc1WtoRb7g8ulwVer6Dsev3gQtS/y5xCdh
 Gbordl1gDGPf3BH/BnCutchqH7Q+kiLvhqQgr+gAouMgv061/96FZbQYvIm+8SWcngZZfy
 xVzzmYL2zo0LqROPtN1iSNNSHQh9ANc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-F4Yi8A7tNlKzIsM83wd0Gg-1; Mon, 15 Jun 2020 01:59:57 -0400
X-MC-Unique: F4Yi8A7tNlKzIsM83wd0Gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAF9C108BD0A;
 Mon, 15 Jun 2020 05:59:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 275757FD05;
 Mon, 15 Jun 2020 05:59:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FFF71138648; Mon, 15 Jun 2020 07:59:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/5] hw/misc/led: Add LED_STATUS_CHANGED QAPI event
References: <20200609123425.6921-1-f4bug@amsat.org>
 <20200609123425.6921-3-f4bug@amsat.org>
 <8e5154ba-0d80-d6f3-0da0-c20072173d9a@redhat.com>
 <906c2a2e-f823-f132-dc7e-f050b69364e7@amsat.org>
Date: Mon, 15 Jun 2020 07:59:50 +0200
In-Reply-To: <906c2a2e-f823-f132-dc7e-f050b69364e7@amsat.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 12 Jun 2020 17:51:37
 +0200")
Message-ID: <87v9jsc1ih.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/14 22:37:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,
 =?utf-8?Q?C?= =?utf-8?Q?=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Eric,
>
> On 6/9/20 4:29 PM, Eric Blake wrote:
>> On 6/9/20 7:34 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Allow LED devices to emit STATUS_CHANGED events on a QMP chardev.
>>>
>>> QMP event examples:
>>>
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "timestamp": {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "seconds": 1591704274,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "microseconds": 520850
>>> =C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "event": "LED_STATUS_CHANGED",
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "data": {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "Green LED #0"=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "status": "on"
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> }
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "timestamp": {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "seconds": 1591704275,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "microseconds": 530912
>>> =C2=A0=C2=A0=C2=A0=C2=A0 },
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "event": "LED_STATUS_CHANGED",
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "data": {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name": "Green LED #0"=
,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "status": "off"
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> }
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>=20
>> The QAPI addition looks reasonable, however,
>>=20
>>> +++ b/hw/misc/led.c
>>> @@ -7,6 +7,7 @@
>>> =C2=A0=C2=A0 */
>>> =C2=A0 #include "qemu/osdep.h"
>>> =C2=A0 #include "qapi/error.h"
>>> +#include "qapi/qapi-events-led.h"
>>> =C2=A0 #include "hw/qdev-properties.h"
>>> =C2=A0 #include "hw/misc/led.h"
>>> =C2=A0 #include "hw/irq.h"
>>> @@ -19,6 +20,9 @@ static void led_set(void *opaque, int line, int
>>> new_state)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_led_set(s->name, s->current=
_state, new_state);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* FIXME QMP rate limite? */
>>=20
>> s/limite/limit/
>>=20
>> Yes, this is under guest control, so you MUST rate limit to avoid the
>> guest being able to DoS qemu by changing the LED so frequently as to
>> overwhelm the QMP connection with events.
>
> Commits f544d174dfc and 7f1e7b23d5 refers to the qmp-events.txt
> for documentation on rate-limiting QMP events, but I can't find
> it in the codebase. Two files matches 'qmp-events' but don't have
> documentation: qapi/qmp-event.c and include/qapi/qmp-event.h.
>
> Last trace of it is in commit 231aaf3a8217. Apparently it was
> somehow split qapi/event.json, then later c09656f1d392 move it
> to qapi-schema.json, finally eb815e248f50 moved it to qapi/.
>
> Is the referred documentation now in docs/devel/qapi-code-gen.txt?
> There is only one occurence of 'limit' but it is unrelated to
> rate-limit.

Commit 231aaf3a8217 is part of Marc-Andr=C3=A9's herculean QAPI/QMP doc
reorganization: use only schema doc comments instead of spreading the
knowledge over schema and several other files, with duplicated contents,
confused readers, and annoyed writers.

Before the reorganization, docs/qmp-events.txt listed the QMP events,
and rate-limited events carried a

    Note: this event is rate-limited.

The reorganization moved this note into its event's doc comment.
Example:

    ##
    # @WATCHDOG:
    #
    # Emitted when the watchdog device's timer is expired
    #
    # @action: action that has been taken
    #
    # Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event=
 is
    #       followed respectively by the RESET, SHUTDOWN, or STOP events
    #
--> # Note: This event is rate-limited.
    #
    [...]
    ##
    { 'event': 'WATCHDOG',
      'data': { 'action': 'WatchdogAction' } }

The QMP *protocol* is still documented in docs/interop/qmp-spec.txt.
Relevant part:

    2.5 Asynchronous events
    -----------------------

    As a result of state changes, the Server may send messages unilaterally
    to the Client at any time, when not in the middle of any other
    response. They are called "asynchronous events".

    The format of asynchronous events is:

    { "event": json-string, "data": json-object,
      "timestamp": { "seconds": json-number, "microseconds": json-number } =
}

     Where,

    - The "event" member contains the event's name
    - The "data" member contains event specific data, which is defined in a
      per-event basis, it is optional
    - The "timestamp" member contains the exact time of when the event
      occurred in the Server. It is a fixed json-object with time in
      seconds and microseconds relative to the Unix Epoch (1 Jan 1970); if
      there is a failure to retrieve host time, both members of the
      timestamp will be set to -1.

    For a listing of supported asynchronous events, please, refer to the
    qmp-events.txt file.

    Some events are rate-limited to at most one per second.  If additional
    "similar" events arrive within one second, all but the last one are
    dropped, and the last one is delayed.  "Similar" normally means same
    event type.  See qmp-events.txt for details.

The reorganization neglected to update it for the removal of
qmp-events.txt.  Should point to
docs/interop/qemu-qmp-ref.{7,html,info,pdf,txt} now.

Event rate-limiting is defined in monitor_qapi_event_conf[].  To
rate-limit an event, add it to monitor_qapi_event_conf[], and also add
the "Note: This event is rate-limited." to its schema doc comment.

Doc bug: commit e2ae6159de "virtio-serial: report frontend connection
state via monitor" neglected to add the note.

Patches welcome!


