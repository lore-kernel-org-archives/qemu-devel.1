Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E50BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698422083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFcVt9bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698422083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0lSm-0002rr-N7
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 08:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0lS2-0002QX-2z
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:44:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k0lRz-0003Oz-8D
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596026689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAFB52aqfi9usVu1yHgCger1QfIbDupEGl2VkylmD4U=;
 b=CFcVt9bJwyeIiYZhQyuqQAnSfrB12eEkJJBkiDtaCRL9eL4VXC7LbkdId+H2FJJiFLhx8+
 XOie6lLgAybqaKNUhfoB/yaRVcug7tYn3TjokF0xQkBfKiNx5kfhj+m3OMGOkD1XPeNEjC
 cbKf+5frvVFpBLBP4uvVGNQWB9qF2JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-ZcBUi_sOPQe_vpZfRA-yIA-1; Wed, 29 Jul 2020 08:44:47 -0400
X-MC-Unique: ZcBUi_sOPQe_vpZfRA-yIA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0667F58
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2020 12:44:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CEF075559;
 Wed, 29 Jul 2020 12:44:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DAEA71132FD2; Wed, 29 Jul 2020 14:44:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: Missing qapi_free_Type in error case for qapi generated code?
References: <ly4kprhd8e.fsf@redhat.com>
 <fe8f0bd6-ed47-08b8-d7c9-fc40c32b0bb2@redhat.com>
 <87eeouafe0.fsf@dusky.pond.sub.org> <lyy2n2g10n.fsf@redhat.com>
Date: Wed, 29 Jul 2020 14:44:41 +0200
In-Reply-To: <lyy2n2g10n.fsf@redhat.com> (Christophe de Dinechin's message of
 "Wed, 29 Jul 2020 10:48:24 +0200")
Message-ID: <877dum7ao6.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.74; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 03:32:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Christophe de Dinechin <dinechin@redhat.com> writes:

> On 2020-07-29 at 10:34 CEST, Markus Armbruster wrote...
>> Eric Blake <eblake@redhat.com> writes:
>>
>>> On 7/28/20 10:26 AM, Christophe de Dinechin wrote:
>>>> The qapi generated code for qmp_marshal_query_spice seems to be missing a
>>>> resource deallocation for "retval". For example, for SpiceInfo:
>>>>
>>>
>>>>      retval = qmp_query_spice(&err);
>>>>      error_propagate(errp, err);
>>>>      if (err) {
>>>> /* retval not freed here */
>>>
>>> Because it should be NULL here.  Returning an error AND an object is
>>> frowned on.
>>
>> It's forbidden, actually.  The QMP handler must either succeed and
>> return a value, or fail cleanly.
>
> OK. Then I guess Eric's suggestion to add an assert is the correct
> approach, with the caveat you identified.

I'm not sure it's worth the trouble, but I'm of course happy to review a
patch.

>> Since it has to return a value even when it fails, it returns an error
>> value then.  "Cleanly" means the error value does not require cleanup.
>>
>> The generated marshalling function relies on this: it *ignores* the
>> error value.
>>
>>>> /* Missing: qapi_free_SpiceInfo(retval); */
>>>>          goto out;
>>>>      }
>>>>
>>>>      qmp_marshal_output_SpiceInfo(retval, ret, errp);
>>>
>>> And here, retval was non-NULL, but is cleaned as a side-effect of
>>> qmp_marshal_output_SpiceInfo.
>>>
>>>>
>>>> out:
>>>
>>> So no matter how you get to the label, retval is no longer valid
>>> memory that can be leaked.
>>>
>>>>      visit_free(v);
>>>>      v = qapi_dealloc_visitor_new();
>>>>      visit_start_struct(v, NULL, NULL, 0, NULL);
>>>>      visit_end_struct(v, NULL);
>>>>      visit_free(v);
>>>> }
>>>> #endif /* defined(CONFIG_SPICE) */
>>>>
>>>> Questions:
>>>>
>>>> - Is the query code supposed to always return NULL in case of error?
>>>
>>> Yes.  If not, that is a bug in qmp_query_spice.
>>
>> Correct.
>>
>>>> In the
>>>>    case of hmp_info_spice, there is no check for info==NULL, so on the
>>
>> I'm blind.  Where?
>
> In hmp_info_spice, there is this code:
>
>     info = qmp_query_spice(NULL);
>
>     if (!info->enabled) {
>         monitor_printf(mon, "Server: disabled\n");
>         goto out;
>     }
>
> I guess this code relies on qmp_query_spice never returning an error.
> Why is that a safe assumption?

It's safe only because qmp_query_spice() never fails.

Of course, when you don't expect failure, you should *not* ignore it!
Pass &error_abort.  If you're right, you're no worse off, and if you're
wrong, you get your error pointed out clearly and reliably.

> This came to my attention because I wanted to return an error and a NULL
> value for modular spice if the module is not available.

Then you get to adjust the caller accordingly.

[...]


