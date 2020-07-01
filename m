Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3098EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28AE206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtIqfJ/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28AE206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqXsY-0004Et-7O
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 04:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXrk-0003Us-FR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:13:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jqXri-00010k-Qr
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 04:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593591189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MjAaM+6+ouia1UlBi8y3YGl261UN2GrNI4Yi6HExdss=;
 b=GtIqfJ/il9TAMwoJsa4K6heRn1KDwUTbYif/Tr5nkvmpbl7pHGY7jWHmnvwUw6lCpBdf6p
 VQHB+Wx0yJNjDhqaPiChk8b6jfLpTWf5L1xABQ6ZMjGSz/goBbjPtV59uOB0KKP6Y979DD
 AxtSGiIxjZMGwroKIJ8BEYGJSoDzLOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-dShzZQ7QOb-BvoHklDaBlg-1; Wed, 01 Jul 2020 04:13:08 -0400
X-MC-Unique: dShzZQ7QOb-BvoHklDaBlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134CF18FE861;
 Wed,  1 Jul 2020 08:13:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4AFEB3A7E;
 Wed,  1 Jul 2020 08:13:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5756411384A6; Wed,  1 Jul 2020 10:13:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 14/46] qemu-option: Factor out helper opt_create()
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-15-armbru@redhat.com>
 <eb4e324e-7028-8e86-5e5c-1063080017c6@virtuozzo.com>
Date: Wed, 01 Jul 2020 10:13:05 +0200
In-Reply-To: <eb4e324e-7028-8e86-5e5c-1063080017c6@virtuozzo.com> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 29 Jun 2020 13:09:11 +0300")
Message-ID: <87mu4jbqlq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
>> There is just one use so far.  The next commit will add more.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   util/qemu-option.c | 27 ++++++++++++++++++---------
>>   1 file changed, 18 insertions(+), 9 deletions(-)
>>
>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>> index d9293814b4..3cdf0c0800 100644
>> --- a/util/qemu-option.c
>> +++ b/util/qemu-option.c
>> @@ -502,6 +502,23 @@ int qemu_opt_unset(QemuOpts *opts, const char *name)
>>       }
>>   }
>>   +static QemuOpt *opt_create(QemuOpts *opts, const char *name, char
>> *value,
>> +                           bool prepend)
>> +{
>> +    QemuOpt *opt = g_malloc0(sizeof(*opt));
>
> I'd prefer g_new0(QemuOpt, 1)

I generally prefer g_new0() over g_malloc0(), too.  But the pattern

    lhs = g_malloc0(sizeof(*lhs))

is fine with me, provided sizeof(*lhs) is at least as readable as the
type of *lhs.  Looks like a wash here, so I'm refraining from messing
with the moved code.

> anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks!


