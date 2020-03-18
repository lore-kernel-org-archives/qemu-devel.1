Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCB5C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CB020757
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 15:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CD1AvMoN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CB020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEaVg-0003jg-84
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 11:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jEaUo-00035M-LZ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jEaUn-0007L9-DF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:20:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jEaUn-0007IX-8d
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 11:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584544836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzmSfbQJXaIrVogFGnxFJK9NBa7y/YdFSCvkwfRlwnk=;
 b=CD1AvMoNmvjFvO9SS7yR9C94IyozUS8UZbVmtjS9b0swyPsiGa8CQ+cvTQMyZ8x0sk72ey
 6LkdN0S61nrpqCHp+TiI2dd00LxkFFdVZkti7F12psxLDR6s/IhSI0NWEwSn8N/eqMHqbj
 RdDTfinvpaP7P98MPdOC+cmHsSP0hCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-LE5UAA7UNgawBwT_SHSkpg-1; Wed, 18 Mar 2020 11:20:19 -0400
X-MC-Unique: LE5UAA7UNgawBwT_SHSkpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C304318A8C95;
 Wed, 18 Mar 2020 15:20:17 +0000 (UTC)
Received: from [10.3.112.193] (ovpn-112-193.phx2.redhat.com [10.3.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 19E283B0;
 Wed, 18 Mar 2020 15:20:17 +0000 (UTC)
Subject: Re: [PATCH v4 30/34] qapi: Implement deprecated-output=hide for QMP
 event data
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200317115459.31821-1-armbru@redhat.com>
 <20200317115459.31821-31-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b746eff-9e7f-6ff7-c3f2-64b6c27f2b20@redhat.com>
Date: Wed, 18 Mar 2020 10:20:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317115459.31821-31-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
> "testing the future".  Implement it for QMP event data: suppress
> deprecated members.
> 
> No QMP event data is deprecated right now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +static void test_event_deprecated_data(TestEventData *data, const void *unused)
> +{
> +    memset(&compat_policy, 0, sizeof(compat_policy));
> +
> +    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATURES0',"
> +                                           " 'data': { 'foo': 42 } }");
> +    qapi_event_send_test_event_features0(42);
> +    g_assert(data->emitted);
> +
> +    qobject_unref(data->expect);
> +
> +    compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;

Again, playing fast-and-loose with compat_policy.has_deprecated_output.


> +++ b/scripts/qapi/events.py
> @@ -104,7 +104,7 @@ def gen_event_send(name, arg_type, features, boxed,
>   
>       if have_args:
>           ret += mcgen('''
> -    v = qobject_output_visitor_new(&obj);
> +    v = qobject_output_visitor_new_qmp(&obj);
>   ''')
>           if not arg_type.is_implicit():
>               ret += mcgen('''
> @@ -123,7 +123,11 @@ def gen_event_send(name, arg_type, features, boxed,
>           ret += mcgen('''
>   
>       visit_complete(v, &obj);
> -    qdict_put_obj(qmp, "data", obj);
> +    if (qdict_size(qobject_to(QDict, obj))) {
> +        qdict_put_obj(qmp, "data", obj);
> +    } else {
> +        qobject_unref(obj);
> +    }

So you'd rather omit data altogether than emit "data":{} when all 
deprecated members disappear.  Fair enough; both approaches work.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


