Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598CDC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:54:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BCC217A0
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 05:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsQcXUga"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BCC217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXHwR-0007hE-Qb
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 01:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXHvV-0006xS-JH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXHvT-00042I-R6
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 01:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603778022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2W3qZ0C2SbjIe9+FWXPEvARr5Aomjj6xFpFQl76K4Q=;
 b=JsQcXUgalIb/c3ge61sgoUuhtPcPF6gxcjbZqDCOhH2IRBNwUXiBOp4dHeXCKpmHmCMhOh
 UuZP33hpmU3absooKXZn7UTBVwiwXf87TTuXcKbaYZCfk4+FIHY/dk+5ic2MoTdDvXg9XN
 mmji66kcc4kagICp6tN9JuAvIzHxCY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-xL7suzlnPUisOIFdCfyGBg-1; Tue, 27 Oct 2020 01:53:37 -0400
X-MC-Unique: xL7suzlnPUisOIFdCfyGBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDF291009E20;
 Tue, 27 Oct 2020 05:53:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-126.ams2.redhat.com [10.36.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD30C10013C4;
 Tue, 27 Oct 2020 05:53:08 +0000 (UTC)
Subject: Re: [PATCH v6 11/11] qapi: Use QAPI_LIST_ADD() where possible
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20201027050556.269064-1-eblake@redhat.com>
 <20201027050556.269064-12-eblake@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c7bb1341-bdbf-8ef5-4933-0e8580babdce@redhat.com>
Date: Tue, 27 Oct 2020 06:53:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201027050556.269064-12-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, pkrempa@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, rjones@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, armbru@redhat.com,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:S390 KVM CPUs" <qemu-s390x@nongnu.org>,
 "open list:GLUSTER" <integration@gluster.org>, stefanha@redhat.com,
 Richard Henderson <rth@twiddle.net>, kwolf@redhat.com,
 vsementsov@virtuozzo.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/2020 06.05, Eric Blake wrote:
> Anywhere we create a list of just one item or by prepending items
> (typically because order doesn't matter), we can use the now-public
> macro.  But places where we must keep the list in order by appending
> remain open-coded.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/devel/writing-qmp-commands.txt | 13 +++------
>  hw/net/rocker/rocker_fp.h           |  2 +-
>  block/gluster.c                     | 19 +++++--------
>  chardev/char.c                      | 21 +++++++--------
>  hw/core/machine.c                   |  6 +----
>  hw/net/rocker/rocker.c              |  8 +++---
>  hw/net/rocker/rocker_fp.c           | 14 +++++-----
>  hw/net/virtio-net.c                 | 21 +++++----------
>  migration/migration.c               |  7 ++---
>  migration/postcopy-ram.c            |  7 ++---
>  monitor/hmp-cmds.c                  | 11 ++++----
>  qemu-img.c                          |  5 ++--
>  qga/commands-posix.c                | 13 +++------
>  qga/commands-win32.c                | 17 +++---------
>  qga/commands.c                      |  6 +----
>  qom/qom-qmp-cmds.c                  | 29 ++++++--------------
>  target/arm/helper.c                 |  6 +----
>  target/arm/monitor.c                | 13 ++-------
>  target/i386/cpu.c                   |  6 +----
>  target/mips/helper.c                |  6 +----
>  target/s390x/cpu_models.c           | 12 ++-------
>  tests/test-clone-visitor.c          |  7 ++---
>  tests/test-qobject-output-visitor.c | 42 ++++++++++++++---------------
>  tests/test-visitor-serialization.c  |  5 +---
>  trace/qmp.c                         | 22 +++++++--------
>  ui/vnc.c                            | 21 +++++----------
>  util/qemu-config.c                  | 14 +++-------
>  target/ppc/translate_init.c.inc     | 12 ++-------
>  28 files changed, 119 insertions(+), 246 deletions(-)
> 
> diff --git a/docs/devel/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> index 46a6c48683f5..3e11eeaa1893 100644
> --- a/docs/devel/writing-qmp-commands.txt
> +++ b/docs/devel/writing-qmp-commands.txt
> @@ -531,15 +531,10 @@ TimerAlarmMethodList *qmp_query_alarm_methods(Error **errp)
>      bool current = true;
> 
>      for (p = alarm_timers; p->name; p++) {
> -        TimerAlarmMethodList *info = g_malloc0(sizeof(*info));
> -        info->value = g_malloc0(sizeof(*info->value));
> -        info->value->method_name = g_strdup(p->name);
> -        info->value->current = current;
> -
> -        current = false;
> -
> -        info->next = method_list;
> -        method_list = info;
> +	TimerAlarmMethod *value = g_new0(TimerAlarmMethod, 1);

White space damage - please replace the TAB with spaces.

> +        value->method_name = g_strdup(p->name);
> +        value->current = current;
> +        QAPI_LIST_ADD(method_list, value);
>      }

 Thomas


