Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36348C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 06:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0320771
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 06:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUiJbGya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrFaH-0004Q3-9M
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 02:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFZi-0003wN-1w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 02:53:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59364
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jrFZg-0008C1-8W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 02:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593759207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zYxeqmF2/5JBd2IAUu6tiJ0tzpOvzlwoNAZdS9P9kvI=;
 b=WUiJbGyaolxvM4nqTcyKo+f3K6XoCKrqPFm5bAD70zp6nOULCaNR6hy3DSgRB3dWRYrMrg
 VVqVKj3AahNy9qX3ONtbDIqKqnAE6HEoF4ImSmVCAaJBozXQeX8w7BzeguxuoVrvjyAKSF
 H1u7UJ5wDpsDPEE7/DaO7mz9J22I5jU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ealTKZwnM2-QZCL0p8VpkA-1; Fri, 03 Jul 2020 02:53:24 -0400
X-MC-Unique: ealTKZwnM2-QZCL0p8VpkA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0168BFC0;
 Fri,  3 Jul 2020 06:53:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D8274D9E6;
 Fri,  3 Jul 2020 06:53:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEA691138648; Fri,  3 Jul 2020 08:53:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 33/44] error: Avoid unnecessary error_propagate() after
 error_setg()
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-34-armbru@redhat.com>
 <78109b04-cc8f-8265-477c-f240bc16e346@redhat.com>
Date: Fri, 03 Jul 2020 08:53:20 +0200
In-Reply-To: <78109b04-cc8f-8265-477c-f240bc16e346@redhat.com> (Eric Blake's
 message of "Thu, 2 Jul 2020 12:43:12 -0500")
Message-ID: <87k0zlxf6n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 7/2/20 10:49 AM, Markus Armbruster wrote:
>> Replace
>>
>>      error_setg(&err, ...);
>>      error_propagate(errp, err);
>>
>> by
>>
>>      error_setg(errp, ...);
>>
>
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
>
>> +++ b/backends/cryptodev.c
>> @@ -158,16 +158,15 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *name,
>>       uint32_t value;
>>         if (!visit_type_uint32(v, name, &value, &local_err)) {
>> -        goto out;
>> +        error_propagate(errp, local_err);
>> +        return;
>>       }
>
> Looks like this error_propgate is spurious if you just use
>  if (!visit_type_uint32(..., errp)) {
>
> Oh - that's not the pattern you flagged, and a later patch then
> addresses it.  It might help if the commit message for this patch
> mentions that further cleanups are still forthcoming.

Perhaps:

    In some places, the transformation results in obviously unnecessary
    error_propagate().  The next few commits will eliminate them.

>> +++ b/backends/hostmem-file.c
>> @@ -114,18 +114,16 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
>>       uint64_t val;
>>         if (host_memory_backend_mr_inited(backend)) {
>> -        error_setg(&local_err, "cannot change property '%s' of %s",
>> -                   name, object_get_typename(o));
>> -        goto out;
>> +        error_setg(errp, "cannot change property '%s' of %s", name,
>> +                   object_get_typename(o));
>> +        return;
>>       }
>>         if (!visit_type_size(v, name, &val, &local_err)) {
>> -        goto out;
>> +        error_propagate(errp, local_err);
>> +        return;
>>       }
>
> Another case where the first 'if' matches the subject of this patch,
> and the second 'if' can avoid local_err but that the change will be
> done in a later patch.  And several more later on, but this is how far
> it took me to realize that you intentionally saved them for later.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


