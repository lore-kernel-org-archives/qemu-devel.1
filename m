Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99F0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D05220EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKRKpAn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D05220EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrDc-0000Sk-7p
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqdv-0005jM-3d
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kHqdt-00064t-AF
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600098224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGuK30Y0tLwAsPaAHiUd6VGMiIwoRbJMdLBs9EIPdCg=;
 b=MKRKpAn2XoWeZtkzWtei7ikB6h5YCie1YVZi9LbzKkhZJIssUJPDUb7s0VpXcM7Ved4GgS
 MGthnwU7qcbwyfKdzV/+GuBBDzdHEK+6pPovXapJ5+Ggiz5tzL1QAfTEsSoK5MhyirIMKf
 yBxVYzUxc+9DGeqod4E8iiX8lbjLBis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-8Vxr7zmrMzi5aXk_2myV4Q-1; Mon, 14 Sep 2020 11:43:35 -0400
X-MC-Unique: 8Vxr7zmrMzi5aXk_2myV4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92BD380EF84;
 Mon, 14 Sep 2020 15:43:34 +0000 (UTC)
Received: from [10.3.113.68] (ovpn-113-68.phx2.redhat.com [10.3.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 405B21002D46;
 Mon, 14 Sep 2020 15:43:34 +0000 (UTC)
Subject: Re: [PATCH v5 5/8] qapi: Implement deprecated-output=hide for QMP
 introspection
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200914084802.4185028-1-armbru@redhat.com>
 <20200914084802.4185028-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8680f11b-e26d-0c64-57eb-0b0e5aae330e@redhat.com>
Date: Mon, 14 Sep 2020 10:43:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914084802.4185028-6-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 3:47 AM, Markus Armbruster wrote:
> This policy suppresses deprecated bits in output, and thus permits
> "testing the future".  Implement it for QMP command query-qmp-schema:
> suppress information on deprecated commands, events and object type
> members, i.e. anything that has the special feature flag "deprecated".
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/introspect.json                 |   2 +-
>   monitor/monitor-internal.h           |   3 -
>   monitor/misc.c                       |   2 -
>   monitor/qmp-cmds-control.c           | 100 +++++++++++++++++++++++----
>   storage-daemon/qemu-storage-daemon.c |   2 -
>   5 files changed, 89 insertions(+), 20 deletions(-)
> 
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index 944bb87a20..39bd303778 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -49,7 +49,7 @@
>   ##
>   { 'command': 'query-qmp-schema',
>     'returns': [ 'SchemaInfo' ],
> -  'gen': false }                # just to simplify qmp_query_json()
> +  'allow-preconfig': true }

Interesting change. Dropping 'gen':false is explained below...

> @@ -153,17 +157,89 @@ EventInfoList *qmp_query_events(Error **errp)
>       return ev_list;
>   }
>   
> -/*
> - * Minor hack: generated marshalling suppressed for this command
> - * ('gen': false in the schema) so we can parse the JSON string
> - * directly into QObject instead of first parsing it with
> - * visit_type_SchemaInfoList() into a SchemaInfoList, then marshal it
> - * to QObject with generated output marshallers, every time.  Instead,
> - * we do it in test-qobject-input-visitor.c, just to make sure
> - * qapi-gen.py's output actually conforms to the schema.
> - */
> -void qmp_query_qmp_schema(QDict *qdict, QObject **ret_data,
> -                                 Error **errp)
> +static void *split_off_generic_list(void *list,
> +                                    bool (*splitp)(void *elt),
> +                                    void **part)

...but adding 'allow-preconfig':true, while it makes sense, seems a bit 
unrelated.  Worth a better commit message?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


