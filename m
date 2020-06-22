Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D623EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F35620706
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 08:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUxNmAjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F35620706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHpw-0006eI-U7
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 04:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHp3-0005mG-BS
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:28:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnHp1-0000Ct-Hg
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592814534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UtIxRQ0OtZg4J2FeJFBduVGKO1L83MOQ9nry/9hLCHg=;
 b=NUxNmAjLeKcga35b3bZoNai81TyTbtgCi5uwVZNdXa2ZZzRMJu1dCr+/vH51XZGkAxNNiX
 zOB6brZA1gXhc8HsicSaVpEJfRU868exgOeWGSbhWT7G7vBPaQJBYp1XAx3TF6cBbKrSdO
 xQHz5P0rUKdAuYWuK5+OVDZHKc2ZfTY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-5k-IeD78OoqQnzIvM6mzbQ-1; Mon, 22 Jun 2020 04:28:53 -0400
X-MC-Unique: 5k-IeD78OoqQnzIvM6mzbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2862C835B52
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 08:28:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EAE87166E;
 Mon, 22 Jun 2020 08:28:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 16D7C113846D; Mon, 22 Jun 2020 10:28:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: qemu-pr-helper -v suppresses errors, isn't that weird?
References: <87imfpszvr.fsf@dusky.pond.sub.org>
 <4a56a2cb-0025-cefc-68a0-37a14641b7b1@redhat.com>
Date: Mon, 22 Jun 2020 10:28:49 +0200
In-Reply-To: <4a56a2cb-0025-cefc-68a0-37a14641b7b1@redhat.com> (Paolo
 Bonzini's message of "Thu, 18 Jun 2020 14:15:21 +0200")
Message-ID: <877dvzpkqm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/06/20 07:32, Markus Armbruster wrote:
>> prh_co_entry() reports reports errors reading requests / writing
>> responses only when @verbose (command line -v); relevant code appended
>> for you convenience.
>> 
>> Sure these are *errors*?  The program recovers and continues, and this
>> is deemed normal enough to inform the user only when he specifically
>> asks for it.  Yet when we inform, we format it as an error.  Should we
>> tune it down to warnings?
>
> They are errors, but they're errors in the client rather than in
> qemu-pr-helper.c itself.

The error message makes it look like the error was in qemu-pr-helper.

Also, continuing after reporting an error as if nothing happened smells
suspiciously.  Even when it's not wrong, it's prone to catch a wary
reader's eye.

What do you think about something like

    warn_reportf_err(local_err, "client trouble: ");

Yes, "client trouble" isn't so hot, but I lack the understanding to do
better.

> Paolo
>
>> 
>> static void coroutine_fn prh_co_entry(void *opaque)
>> {
>>     [...]
>>     while (atomic_read(&state) == RUNNING) {
>>         [...]
>>         sz = prh_read_request(client, &req, &resp, &local_err);
>>         if (sz < 0) {
>>             break;
>>         }
>>         [...]
>>         if (prh_write_response(client, &req, &resp, &local_err) < 0) {
>>             break;
>>         }
>>     }
>>     if (local_err) {
>>         if (verbose == 0) {
>>             error_free(local_err);
>>         } else {
>>             error_report_err(local_err);
>>         }
>>     }
>> 
>> out:
>>     qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
>>     object_unref(OBJECT(client->ioc));
>>     g_free(client);
>> }
>> 


