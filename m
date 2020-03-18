Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA25C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A8420767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 12:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ff8rtexA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A8420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEXpV-0006Qh-QJ
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 08:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEXos-0005uO-5M
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEXor-00045u-0l
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:29:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEXoq-00044i-Sp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 08:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584534548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6kRlif+9fbvVELRU+LIohPI1B8DoiSlPPDKa33IbgM=;
 b=ff8rtexArxYbsEzCn8oMQ+fxi6oAHFCsfeRHtN/u4yfa6lFhFfymwNRWYqyC8Mwmt9XHOi
 +CISLOJlGu5wzEudM3os1eilEXwHMzCpv++yewm8xNTgWlgNaCCpWo2lFVggGuIhFtgi5/
 ifVekTOGpCx2XBOm2vhAh2ipb69zADg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-TSyVCPA-P_-TS9ni66WYrQ-1; Wed, 18 Mar 2020 08:29:05 -0400
X-MC-Unique: TSyVCPA-P_-TS9ni66WYrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 21A42189D6C0;
 Wed, 18 Mar 2020 12:29:04 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDDF719756;
 Wed, 18 Mar 2020 12:29:03 +0000 (UTC)
Subject: Re: [PATCH v4 29/34] qapi: Implement deprecated-output=hide for QMP
 events
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-30-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c8b780c9-8a82-bea2-61b5-14aab90f476d@redhat.com>
Date: Wed, 18 Mar 2020 07:29:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-30-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 6:54 AM, Markus Armbruster wrote:
> This policy suppresses deprecated bits in output, and thus permits
> "testing the future".  Implement it for QMP events: suppress
> deprecated ones.
> 
> No QMP event is deprecated right now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -140,6 +141,23 @@ static void test_event_d(TestEventData *data,
>       qobject_unref(data->expect);
>   }
>   
> +static void test_event_deprecated(TestEventData *data, const void *unused)
> +{
> +    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATURES1' }");
> +
> +    memset(&compat_policy, 0, sizeof(compat_policy));
> +
> +    qapi_event_send_test_event_features1();
> +    g_assert(data->emitted);
> +
> +    compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;

Umm, did you forget to set compat_policy.has_deprecated_output = true?

(proof that we really want QAPI defaults to be working, to get rid of 
pointless has_* members...)

> +    data->emitted = false;
> +    qapi_event_send_test_event_features1();
> +    g_assert(!data->emitted);
> +
> +    qobject_unref(data->expect);
> +}
> +

> +++ b/scripts/qapi/events.py
> @@ -61,7 +61,8 @@ def gen_param_var(typ):
>       return ret
>   
>   
> -def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
> +def gen_event_send(name, arg_type, features, boxed,
> +                   event_enum_name, event_emit):
>       # FIXME: Our declaration of local variables (and of 'errp' in the
>       # parameter list) can collide with exploded members of the event's
>       # data type passed in as parameters.  If this collision ever hits in
> @@ -86,6 +87,14 @@ def gen_event_send(name, arg_type, boxed, event_enum_name, event_emit):
>           if not boxed:
>               ret += gen_param_var(arg_type)
>   
> +    if 'deprecated' in [f.name for f in features]:
> +        ret += mcgen('''
> +
> +    if (compat_policy.deprecated_output == COMPAT_POLICY_OUTPUT_HIDE) {
> +        return;

Here, you took the shortcut that if we always 0-initialize, 
deprecated_output will never be true except when has_deprecated_output 
is also true.  But the test above violated that rule of thumb.

Otherwise, this patch makes sense.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


