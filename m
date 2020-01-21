Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128F5C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F8422522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQ0CJnVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F8422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itp3O-0001gw-2M
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:38:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1itp2i-00016c-1o
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1itp2c-0003QF-MK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:37:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1itp2c-0003PY-IR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579595861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mx1oWDti0mG/lXA04pi/ny7HIJG78uVgLgYIwIYQ/pg=;
 b=dQ0CJnVMf9eTNaJ6TNOThIl4ZMWlI2QK+b9LMisKoySxOLCR3fDUYmCfpL4OZfxss2KfHI
 vNrDrW3nUxfytH03q9RkNWEYpqYhdenDBiX9s5fIPKWLd0msmIWDCmZzHhszOXm1uFa6Eb
 lAQYNkCVP17nGsPJSKlkUU2J9bDsbik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-xQwn-lYbMEaDnNO1tzdD_A-1; Tue, 21 Jan 2020 03:37:40 -0500
X-MC-Unique: xQwn-lYbMEaDnNO1tzdD_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E630E800D54;
 Tue, 21 Jan 2020 08:37:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F376260CD3;
 Tue, 21 Jan 2020 08:37:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74B711138600; Tue, 21 Jan 2020 09:37:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH 2/2] pvpanic: implement crashloaded event handling
References: <20200110100634.491936-1-pizhenwei@bytedance.com>
 <20200110100634.491936-3-pizhenwei@bytedance.com>
Date: Tue, 21 Jan 2020 09:37:34 +0100
In-Reply-To: <20200110100634.491936-3-pizhenwei@bytedance.com> (zhenwei pi's
 message of "Fri, 10 Jan 2020 18:06:34 +0800")
Message-ID: <878sm1i4s1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: yelu@bytedance.com, libvir-list@redhat.com, gregkh@linuxfoundation.org,
 qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, mprivozn@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

zhenwei pi <pizhenwei@bytedance.com> writes:

> Handle bit 1 write, then post event to monitor.
>
> Suggested by Paolo, declear a new event, using GUEST_PANICKED could
> cause upper layers to react by shutting down or rebooting the guest.
>
> In advance for extention, add GuestPanicInformation in event message.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/misc/pvpanic.c         | 11 +++++++++--
>  include/sysemu/runstate.h |  1 +
>  qapi/run-state.json       | 22 +++++++++++++++++++++-
>  vl.c                      | 12 ++++++++++++
>  4 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> index d65ac86478..4ebda7872a 100644
> --- a/hw/misc/pvpanic.c
> +++ b/hw/misc/pvpanic.c
> @@ -21,11 +21,13 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/pvpanic.h"
>  
> -/* The bit of supported pv event */
> +/* The bit of supported pv event, TODO: include uapi header and remove this */
>  #define PVPANIC_F_PANICKED      0
> +#define PVPANIC_F_CRASHLOADED   1
>  
>  /* The pv event value */
>  #define PVPANIC_PANICKED        (1 << PVPANIC_F_PANICKED)
> +#define PVPANIC_CRASHLOADED     (1 << PVPANIC_F_CRASHLOADED)
>  
>  #define ISA_PVPANIC_DEVICE(obj)    \
>      OBJECT_CHECK(PVPanicState, (obj), TYPE_PVPANIC)
> @@ -34,7 +36,7 @@ static void handle_event(int event)
>  {
>      static bool logged;
>  
> -    if (event & ~PVPANIC_PANICKED && !logged) {
> +    if (event & ~(PVPANIC_PANICKED | PVPANIC_CRASHLOADED) && !logged) {
>          qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
>          logged = true;
>      }
> @@ -43,6 +45,11 @@ static void handle_event(int event)
>          qemu_system_guest_panicked(NULL);
>          return;
>      }
> +
> +    if (event & PVPANIC_CRASHLOADED) {
> +        qemu_system_guest_crashloaded(NULL);
> +        return;
> +    }
>  }

Okay.  Possible simplification:

   static void handle_event(int event)
   {
       static bool logged;

       if (event & PVPANIC_PANICKED) {
           qemu_system_guest_panicked(NULL);
           return;
       }

       if (event & PVPANIC_CRASHLOADED) {
           qemu_system_guest_crashloaded(NULL);
           return;
       }

       if (!logged) {
           qemu_log_mask(LOG_GUEST_ERROR, "pvpanic: unknown event %#x.\n", event);
           logged = true;
       }
   }

>  
>  #include "hw/isa/isa.h"
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 0b41555609..f760094858 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -63,6 +63,7 @@ ShutdownCause qemu_reset_requested_get(void);
>  void qemu_system_killed(int signal, pid_t pid);
>  void qemu_system_reset(ShutdownCause reason);
>  void qemu_system_guest_panicked(GuestPanicInformation *info);
> +void qemu_system_guest_crashloaded(GuestPanicInformation *info);
>  
>  #endif
>  
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index d7477cd715..b7a91f3125 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -357,6 +357,26 @@
   ##
   # @GUEST_PANICKED:
   #
   # Emitted when guest OS panic is detected
   #
   # @action: action that has been taken, currently always "pause"

Not this patch's problem, but here goes anyway: 'currently always
"pause"' is wrong since 864111f422 "vl: exit qemu on guest panic if
-no-shutdown is not set".  See [*] below.

   #
   # @info: information about a panic (since 2.9)
   #
   # Since: 1.5
   #
   # Example:
   #
   # <- { "event": "GUEST_PANICKED",
   #      "data": { "action": "pause" } }
   #
   ##
   { 'event': 'GUEST_PANICKED',
>    'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
>  
>  ##
> +# @GUEST_CRASHLOADED:
> +#
> +# Emitted when guest OS crash loaded is detected
> +#
> +# @action: action that has been taken, currently always "run"
> +#
> +# @info: information about a panic (since 2.9)
> +#
> +# Since: 5.0
> +#
> +# Example:
> +#
> +# <- { "event": "GUEST_CRASHLOADED",
> +#      "data": { "action": "run" } }
> +#
> +##
> +{ 'event': 'GUEST_CRASHLOADED',
> +  'data': { 'action': 'GuestPanicAction', '*info': 'GuestPanicInformation' } }
> +
> +##
>  # @GuestPanicAction:
>  #
>  # An enumeration of the actions taken when guest OS panic is detected
> @@ -366,7 +386,7 @@
>  # Since: 2.1 (poweroff since 2.8)
>  ##
>  { 'enum': 'GuestPanicAction',
> -  'data': [ 'pause', 'poweroff' ] }
> +  'data': [ 'pause', 'poweroff', 'run' ] }

We now have

    event               action
    GUEST_PANICKED      pause
    GUEST_PANICKED      poweroff
    GUEST_CRASHLOADED   run

Why have two events?

If there's a reason for two, why have their actions mixed up in a single
enum?

>  
>  ##
>  # @GuestPanicInformationType:
> diff --git a/vl.c b/vl.c
> index 86474a55c9..5b1b2ef095 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1468,6 +1468,18 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
   void qemu_system_guest_panicked(GuestPanicInformation *info)
   {
       qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");

       if (current_cpu) {
           current_cpu->crash_occurred = true;
       }
       qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
                                      !!info, info);
       vm_stop(RUN_STATE_GUEST_PANICKED);
       if (!no_shutdown) {

[*] Here, we send event GUEST_PANICKED with action "poweroff":

           qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
                                          !!info, info);
           qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_PANIC);
       }

Note that we send *two* GUEST_PANICKED events for the same guest panic,
one with action "pause", and a second one with action "poweroff".
Doesn't feel right to me.

Not this patch's problem, of course.

       if (info) {
           if (info->type == GUEST_PANIC_INFORMATION_TYPE_HYPER_V) {
               qemu_log_mask(LOG_GUEST_ERROR, "\nHV crash parameters: (%#"PRIx64
                             " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
                             info->u.hyper_v.arg1,
                             info->u.hyper_v.arg2,
                             info->u.hyper_v.arg3,
                             info->u.hyper_v.arg4,
                             info->u.hyper_v.arg5);
           } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_S390) {
               qemu_log_mask(LOG_GUEST_ERROR, " on cpu %d: %s\n"
                             "PSW: 0x%016" PRIx64 " 0x%016" PRIx64"\n",
                             info->u.s390.core,
                             S390CrashReason_str(info->u.s390.reason),
                             info->u.s390.psw_mask,
                             info->u.s390.psw_addr);
           }
           qapi_free_GuestPanicInformation(info);
>      }
>  }
>  
> +void qemu_system_guest_crashloaded(GuestPanicInformation *info)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
> +
> +    qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN,
> +                                   !!info, info);
> +
> +    if (info) {
> +        qapi_free_GuestPanicInformation(info);
> +    }
> +}
> +
>  void qemu_system_reset_request(ShutdownCause reason)
>  {
>      if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {


