Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC287C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A572076E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+EX/GDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A572076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKN21-0004Wo-6e
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKN0g-0003fH-1q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKN0d-0005kN-RS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600699299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M+QTei+cUD51jWAH7pl3J79j1CfMlkPTZPcXSVjF2BU=;
 b=F+EX/GDPW9AjcqUG7fTLzD+gIHu5ipFQRGZatP8Os+2mu+9D+G0y+H9ZSdqKmM4irNrIzu
 RnpJ92qV4CDz6tYEcoZH6nLFZftI/9NcW3UqPw5nrBa1nO8NBOxm7mBFr2a3yAZ4tW2Rd/
 857QeWdGt5cqJvIA7ClyCCjHYIeU3kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-vTMqU_U5NFCC57W_LcEtaw-1; Mon, 21 Sep 2020 10:41:22 -0400
X-MC-Unique: vTMqU_U5NFCC57W_LcEtaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C9E41084C86;
 Mon, 21 Sep 2020 14:41:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A13D28545;
 Mon, 21 Sep 2020 14:41:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A23671132E9A; Mon, 21 Sep 2020 16:41:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 5/8] qapi: Implement deprecated-output=hide for QMP
 introspection
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-6-armbru@redhat.com>
 <8680f11b-e26d-0c64-57eb-0b0e5aae330e@redhat.com>
Date: Mon, 21 Sep 2020 16:41:19 +0200
In-Reply-To: <8680f11b-e26d-0c64-57eb-0b0e5aae330e@redhat.com> (Eric Blake's
 message of "Mon, 14 Sep 2020 10:43:33 -0500")
Message-ID: <87h7rr19bk.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@gmail.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 9/14/20 3:47 AM, Markus Armbruster wrote:
>> This policy suppresses deprecated bits in output, and thus permits
>> "testing the future".  Implement it for QMP command query-qmp-schema:
>> suppress information on deprecated commands, events and object type
>> members, i.e. anything that has the special feature flag "deprecated".
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   qapi/introspect.json                 |   2 +-
>>   monitor/monitor-internal.h           |   3 -
>>   monitor/misc.c                       |   2 -
>>   monitor/qmp-cmds-control.c           | 100 +++++++++++++++++++++++----
>>   storage-daemon/qemu-storage-daemon.c |   2 -
>>   5 files changed, 89 insertions(+), 20 deletions(-)
>> diff --git a/qapi/introspect.json b/qapi/introspect.json
>> index 944bb87a20..39bd303778 100644
>> --- a/qapi/introspect.json
>> +++ b/qapi/introspect.json
>> @@ -49,7 +49,7 @@
>>   ##
>>   { 'command': 'query-qmp-schema',
>>     'returns': [ 'SchemaInfo' ],
>> -  'gen': false }                # just to simplify qmp_query_json()
>> +  'allow-preconfig': true }
>
> Interesting change. Dropping 'gen':false is explained below...
>
>> @@ -153,17 +157,89 @@ EventInfoList *qmp_query_events(Error **errp)
>>       return ev_list;
>>   }
>>   -/*
>> - * Minor hack: generated marshalling suppressed for this command
>> - * ('gen': false in the schema) so we can parse the JSON string
>> - * directly into QObject instead of first parsing it with
>> - * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
>> - * to QObject with generated output marshallers, every time.  Instead,
>> - * we do it in test-qobject-input-visitor.c, just to make sure
>> - * qapi-gen.py's output actually conforms to the schema.
>> - */
>> -void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
>> -                                 Error **errp)
>> +static void *split_off_generic_list(void *list,
>> +                                    bool (*splitp)(void *elt),
>> +                                    void **part)
>
> ...but adding 'allow-preconfig':true, while it makes sense, seems a
> bit unrelated.

It's not, actually: query-qmp-schema has always worked in preconfig
state.  Current master:

    $ upstream-qemu -nodefaults -S -display none -qmp stdio -preconfig
    {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
    {"execute": "qmp_capabilities"}
    {"return": {}}
    {"execute": "query-qmp-schema"}
    {"return": [{"name": "query-status", ...}}
    {"execute": "query-block"}
    {"error": {"class": "GenericError", "desc": "The command 'query-block' isn't permitted in 'preconfig' state"}}

We better keep it working there.

>                 Worth a better commit message?

Yes.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!


