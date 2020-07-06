Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55950C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F94E20702
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPuhzCtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F94E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXKn-0000jT-Cc
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsXK9-00006c-82
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:02:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsXJD-00049r-8d
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:02:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594065706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wW7p4SO7ayt8ijVP5CH0Kw2uhl7RKOMy7Wr19duA0gI=;
 b=DPuhzCtcN8z0j0a2e/Dpjrt/JIv6r6R0vUTOcsVKsYMTZFN0x76+Yy/er66FZLvXY5Kj1i
 p2PyVpv0nmM92iqB+fxP0r2CDiVevsc/5bAf7o6nWjaJ0PIDHfwFqUJNapYltvs3+rczg4
 Zccq5GnquguVeA687Ce1yfz2xZJNj3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-Ia7-MbJyM5K2KnHdD2MtLg-1; Mon, 06 Jul 2020 16:01:42 -0400
X-MC-Unique: Ia7-MbJyM5K2KnHdD2MtLg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 478C21005510;
 Mon,  6 Jul 2020 20:01:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B216C10013D9;
 Mon,  6 Jul 2020 20:01:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4000D1132FD2; Mon,  6 Jul 2020 22:01:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v3 06/44] qemu-option: Check return value instead of @err
 where convenient
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-7-armbru@redhat.com>
 <20200706175917.460e4817@bahia.lan>
Date: Mon, 06 Jul 2020 22:01:38 +0200
In-Reply-To: <20200706175917.460e4817@bahia.lan> (Greg Kurz's message of "Mon, 
 6 Jul 2020 17:59:17 +0200")
Message-ID: <871rloct0d.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:22:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greg Kurz <groug@kaod.org> writes:

> On Mon,  6 Jul 2020 10:09:12 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Convert uses like
>> 
>>     opts = qemu_opts_create(..., &err);
>>     if (err) {
>>         ...
>>     }
>> 
>> to
>> 
>>     opts = qemu_opts_create(..., &err);
>
> The patch doesn't strictly do that since it also converts &err to errp.

Yes, and that's actually why I do it.  I'll change the commit message to
say so:

   to
   
       opts = qemu_opts_create(..., errp);

> This is okay because most of the changes also drop the associated
> error_propagate(), with the exception of block/parallels.c for which
> I had to check how local_err is used. As already noted by Vladimir
> earlier this generates an harmless "no-op error_propagate", but it
> could be worth mentioning that in the changelog for future reviews :)

Yes, error_propagate() becomes a no-op for one out of three error paths
through it.  There's similar "partial no-opification" elsewhere in this
series, notably in PATCH 36.

Concrete suggestions for improving the commit message further are
welcome!

>>     if (!opts) {
>>         ...
>>     }
>> 
>> Eliminate error_propagate() that are now unnecessary.  Delete @err
>> that are now unused.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  block/parallels.c  |  4 ++--
>>  blockdev.c         |  5 ++---
>>  qdev-monitor.c     |  5 ++---
>>  util/qemu-config.c | 10 ++++------
>>  util/qemu-option.c | 12 ++++--------
>
> Maybe some other potential candidates ?
>
> chardev/char.c:
>
>    opts = qemu_opts_create(qemu_find_opts("chardev"), label, 1, &local_err);
>     if (local_err) {
>         error_report_err(local_err);
>         return NULL;
>     }
>
> monitor/hmp-cmds.c:
>
>     opts = qemu_opts_from_qdict(qemu_find_opts("netdev"), qdict, &err);
>     if (err) {
>         goto out;
>     }
>
>
>     opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
>     if (err) {
>         goto end;
>     }

Don't fit my clarified commit message, because I can't replace &err by
errp there.

I found these:

  diff --git a/block/blkdebug.c b/block/blkdebug.c
  index 7194bc7f06..471b597dfe 100644
  --- a/block/blkdebug.c
  +++ b/block/blkdebug.c
  @@ -294,17 +294,13 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,

       d.s = s;
       d.action = ACTION_INJECT_ERROR;
  -    qemu_opts_foreach(&inject_error_opts, add_rule, &d, &local_err);
  -    if (local_err) {
  -        error_propagate(errp, local_err);
  +    if (qemu_opts_foreach(&inject_error_opts, add_rule, &d, errp)) {
           ret = -EINVAL;
           goto fail;
       }

       d.action = ACTION_SET_STATE;
  -    qemu_opts_foreach(&set_state_opts, add_rule, &d, &local_err);
  -    if (local_err) {
  -        error_propagate(errp, local_err);
  +    if (qemu_opts_foreach(&set_state_opts, add_rule, &d, errp)) {
           ret = -EINVAL;
           goto fail;
       }

However, I really need to get a pull request out...  Can patch them
later.

> With or without the extra changes:
>
> Reviewed-by: Greg Kurz <groug@kaod.org>

Thanks!


