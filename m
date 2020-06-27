Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4F2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33182145D
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 11:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9Un3IIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33182145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jp9SB-00024F-UI
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 07:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9RV-0001Zv-Kh
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:56:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jp9RS-0002Ee-UV
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 07:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593258978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sf/QpYfw+dw/Lir1B/GUsUn+npBoRRBc5P+g/KzKKNM=;
 b=M9Un3IIkX4mxWkEAR+nlMxGIoaKoYlCtO3EYRfgaSlnti+EFPdEpCl4dZIMgZDTT4bT0x6
 hsiWpmZ/a+msXjujIOmKra7QBxaxDfPfj3sLwv47g+s46cMU6/fSdOG2952DUA7gGg7C+H
 Aa/Cqx6Gx3zlPltcnNSwuDvO54aISBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-YdqN8BfPMoGdsTf9_dTn5A-1; Sat, 27 Jun 2020 07:56:16 -0400
X-MC-Unique: YdqN8BfPMoGdsTf9_dTn5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48047BFC0;
 Sat, 27 Jun 2020 11:56:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 275107C1FE;
 Sat, 27 Jun 2020 11:56:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C303F11384A6; Sat, 27 Jun 2020 13:56:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 08/46] error: Avoid unnecessary error_propagate() after
 error_setg()
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-9-armbru@redhat.com>
 <5e155834-78c3-4a64-834b-7d83328d7bed@virtuozzo.com>
Date: Sat, 27 Jun 2020 13:56:12 +0200
In-Reply-To: <5e155834-78c3-4a64-834b-7d83328d7bed@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 26 Jun 2020 21:22:11 +0300")
Message-ID: <87imfcracj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 07:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> 24.06.2020 19:43, Markus Armbruster wrote:
>> Replace
>>
>>      error_setg(&err, ...);
>>      error_propagate(errp, err);
>>
>> by
>>
>>      error_setg(errp, ...);
>>
>> Related pattern:
>>
>>      if (...) {
>>          error_setg(&err, ...);
>>          goto out;
>>      }
>>      ...
>>   out:
>>      error_propagate(errp, err);
>>      return;
>>
>> When all paths to label out are that way, replace by
>>
>>      if (...) {
>>          error_setg(errp, ...);
>>          return;
>>      }
>>
>> and delete the label along with the error_propagate().
>>
>> When we have at most one other path that actually needs to propagate,
>> and maybe one at the end that where propagation is unnecessary, e.g.
>>
>>      foo(..., &err);
>>      if (err) {
>>          goto out;
>>      }
>>      ...
>>      bar(..., &err);
>>   out:
>>      error_propagate(errp, err);
>>      return;
>>
>> move the error_propagate() to where it's needed, like
>>
>>      if (...) {
>>          foo(..., &err);
>>          error_propagate(errp, err);
>>          return;
>>      }
>>      ...
>>      bar(..., errp);
>>      return;
>>
>> and transform the error_setg() as above.
>>
>> Bonus: the elimination of gotos will make later patches in this series
>> easier to review.
>>
>> Candidates for conversion tracked down with this Coccinelle script:
>>
>>      @@
>>      identifier err, errp;
>>      expression list args;
>>      @@
>>      -    error_setg(&err, args);
>>      +    error_setg(errp, args);
>> 	 ... when != err
>> 	 error_propagate(errp, err);
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   backends/cryptodev.c        | 11 +++---
>>   backends/hostmem-file.c     | 19 +++-------
>>   backends/hostmem-memfd.c    | 15 ++++----
>>   backends/hostmem.c          | 27 ++++++--------
>>   block/throttle-groups.c     | 22 +++++------
>>   hw/hyperv/vmbus.c           |  5 +--
>>   hw/i386/pc.c                | 35 ++++++------------
>>   hw/mem/nvdimm.c             | 17 ++++-----
>>   hw/mem/pc-dimm.c            | 14 +++----
>>   hw/misc/aspeed_sdmc.c       |  3 +-
>>   hw/ppc/rs6000_mc.c          |  9 ++---
>>   hw/ppc/spapr.c              | 73 ++++++++++++++++---------------------
>>   hw/ppc/spapr_pci.c          | 14 +++----
>>   hw/s390x/ipl.c              | 23 +++++-------
>>   hw/s390x/sclp.c             | 12 ++----
>>   hw/xen/xen_pt_config_init.c |  3 +-
>>   iothread.c                  | 12 +++---
>>   net/colo-compare.c          | 20 ++++------
>>   net/dump.c                  | 10 ++---
>>   net/filter-buffer.c         | 10 ++---
>>   qga/commands-win32.c        | 16 +++-----
>>   21 files changed, 151 insertions(+), 219 deletions(-)
>>
>
> [..]
>
>> --- a/qga/commands-win32.c
>> +++ b/qga/commands-win32.c
>> @@ -282,9 +282,8 @@ static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,
>
> You forget to remove unused local_err variable

In my haste to get this series out for review, I took undadvisable
shortcuts on Error * variable cleanup.  Need to do better for v2.

>>         HANDLE thread = CreateThread(NULL, 0, func, opaque, 0,
>> NULL);
>>       if (!thread) {
>> -        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
>> +        error_setg(errp, QERR_QGA_COMMAND_FAILED,
>>                      "failed to dispatch asynchronous command");
>> -        error_propagate(errp, local_err);
>>       }
>>   }
>>   @@ -1274,31 +1273,28 @@ static void
>> check_suspend_mode(GuestSuspendMode mode, Error **errp)
>
> and here (I assume, you remove unused variables with help of compiler, but don't compile for win32 :)
>
>
> with these two local_err removed:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!

> Ohh, my brain is broken, I'd prefer to create such patches than to review them :)

Rrrrrevenge!  ;)

[...]


