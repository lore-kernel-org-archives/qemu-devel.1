Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6686E20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 12:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZroHUwXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6686E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqykd-0005ag-MY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 08:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqyjx-0004vc-8t
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:54:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqyju-0003uc-MK
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sjIR17RXyrp9rt77O9z67JZAZOIw0bB/tG2j/Aq/3M8=;
 b=ZroHUwXD9Nj2Y1qlD41P4RX0lcKILZ1FwDhenibH4TwMPNJgiGNqsnpPdNcT3ndvtoAK1q
 4Cy6KcfBEF+s1wIZ4Thwf9E6leXYzEhVospYcbIj3fhWvljOcrb3+Mig4DvOpd7mhckB0V
 WgBK2iIBu6PygjPnOWf3pcpwf/J22qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-M9os4lUqMzW6F8ZvvrnewA-1; Thu, 02 Jul 2020 08:54:49 -0400
X-MC-Unique: M9os4lUqMzW6F8ZvvrnewA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D058BD306;
 Thu,  2 Jul 2020 12:54:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CB9060CD3;
 Thu,  2 Jul 2020 12:54:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EE3F511384A6; Thu,  2 Jul 2020 14:54:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 07/46] error: Avoid more error_propagate() when error is
 not used here
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-8-armbru@redhat.com>
 <aa48ada1-2712-e658-6c36-440b402b046a@virtuozzo.com>
 <878sg8r9bp.fsf@dusky.pond.sub.org>
Date: Thu, 02 Jul 2020 14:54:46 +0200
In-Reply-To: <878sg8r9bp.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Sat, 27 Jun 2020 14:18:18 +0200")
Message-ID: <877dvm9iw9.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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

Markus Armbruster <armbru@redhat.com> writes:

> Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:
>
>> 24.06.2020 19:43, Markus Armbruster wrote:
>>> When all we do with an Error we receive into a local variable is
>>> propagating to somewhere else, we can just as well receive it there
>>> right away.  The previous commit did that for simple cases with
>>> Coccinelle.  Do it for a few more manually.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>   blockdev.c     |  5 +----
>>>   hw/core/numa.c | 44 ++++++++++++++------------------------------
>>>   qdev-monitor.c | 11 ++++-------
>>>   3 files changed, 19 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/blockdev.c b/blockdev.c
>>> index b66863c42a..73736a4eaf 100644
>>> --- a/blockdev.c
>>> +++ b/blockdev.c
>>> @@ -1009,13 +1009,10 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
>>>       }
>>>         /* Actual block device init: Functionality shared with
>>> blockdev-add */
>>> -    blk = blockdev_init(filename, bs_opts, &local_err);
>>> +    blk = blockdev_init(filename, bs_opts, errp);
>>>       bs_opts = NULL;
>>>       if (!blk) {
>>> -        error_propagate(errp, local_err);
>>>           goto fail;
>>> -    } else {
>>> -        assert(!local_err);
>>>       }
>>>         /* Create legacy DriveInfo */
>>> diff --git a/hw/core/numa.c b/hw/core/numa.c
>>> index 5f81900f88..aa8c6be210 100644
>>> --- a/hw/core/numa.c
>>> +++ b/hw/core/numa.c
>>> @@ -449,40 +449,33 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
>>>     void set_numa_options(MachineState *ms, NumaOptions *object,
>>> Error **errp)
>>>   {
>>> -    Error *err = NULL;
>>> -
>>>       if (!ms->numa_state) {
>>>           error_setg(errp, "NUMA is not supported by this machine-type");
>>> -        goto end;
>>> +        return;
>>>       }
>>>         switch (object->type) {
>>>       case NUMA_OPTIONS_TYPE_NODE:
>>> -        parse_numa_node(ms, &object->u.node, &err);
>>> -        if (err) {
>>> -            goto end;
>>> -        }
>>> +        parse_numa_node(ms, &object->u.node, errp);
>>>           break;
>>
>> Could we use return here and and for other "break" operators here, to stress, that we
>> are not going to do something more in case of failure (as well as in case of
>> success)? To prevent the future addition of some code after the switch without
>> handling the error carefully here.
>
> Can do.

Second thoughts: I'd prefer not to mess with it now.

The sane way to add code after the switch is to make the
parse_numa_FOO() return bool, then bail out like this:

             if (!parse_numa_node(ms, &object->u.node, errp)) {
                 return;
             }

Too much for me right now.  I'm having a hard time getting this ready in
time of the freeze.  We can always improve on top.

[...]


