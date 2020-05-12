Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD60C2D0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF68206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9dmorY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF68206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYX0z-0000Yb-E7
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYWbf-0000Pq-BN
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:14:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYWbd-0005g5-NZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589296444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5wiUc2l2p2I4KBYisG8yzreKxd4kWV/4FHMmDvH7f1M=;
 b=S9dmorY1PdMN/tHMXBoHV93I6pLZ07R7EyL0723dOzIzloX0wDjfJNxMzF1EyvOZCpVNoc
 5pU+hEq4ZSmDSXIdnR7fkU+3ve54OyGKK6c0O5kVsqm4CggOX69UKLMnlR49GTnYTih7w2
 cH7+sIc5KK1j6T6CgtbdpxknH35Vh54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-afJwMYafPiSZeUyQWYh37w-1; Tue, 12 May 2020 11:13:48 -0400
X-MC-Unique: afJwMYafPiSZeUyQWYh37w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD5581937FC4
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 15:13:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-112.ams2.redhat.com [10.36.112.112])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C55EE5D782;
 Tue, 12 May 2020 15:13:45 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] net: Drop the NetLegacy structure, always use
 Netdev instead
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20200512123149.30207-1-thuth@redhat.com>
 <20200512123149.30207-3-thuth@redhat.com>
 <3a2bcb19-5ba3-0023-8733-d945ee40aeeb@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ef4bd3f7-c023-d4c8-b4b6-2b8abe9e1cdb@redhat.com>
Date: Tue, 12 May 2020 17:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3a2bcb19-5ba3-0023-8733-d945ee40aeeb@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:02:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020 16.32, Eric Blake wrote:
> On 5/12/20 7:31 AM, Thomas Huth wrote:
>> Now that the "name" parameter is gone, there is hardly any difference
>> between NetLegacy and Netdev anymore. Drop NetLegacy and always use
>> Netdev to simplify the code quite a bit.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
> 
>> +++ b/net/net.c
>> @@ -967,13 +967,14 @@ static int (* const
>> net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
>>     static int net_client_init1(const void *object, bool is_netdev,
>> Error **errp)
> 
> Why do we still need the 'is_netdev' parameter?

Yes. See net_init_client(), it uses "false" here.

>  If all callers are
> passing in a netdev, then either this parameter needs to be renamed to
> capture the actual difference between callers, or it can be dropped
> altogether.

Don't think of the "Netdev" structure when you're looking at
"is_netdev", rather think about the "-netdev" comand line parameter.
"is_netdev" is used to distinguish between "-netdev" and "-net".

>>   {
>> -    Netdev legacy = {0};
>> -    const Netdev *netdev;
>> +    const Netdev *netdev = object;
>>       NetClientState *peer = NULL;
>>         if (is_netdev) {
>> -        netdev = object;
>> -
>> +        if (!netdev->has_id) {
>> +            error_setg(errp, QERR_MISSING_PARAMETER, "id");
>> +            return -1;
>> +        }
> 
> You wouldn't need this if 'id' remained mandatory.

It's still required for "-net" - see my reply to patch 1/2.

>> @@ -981,56 +982,11 @@ static int net_client_init1(const void *object,
>> bool is_netdev, Error **errp)
>>               return -1;
>>           }
>>       } else {
>> -        const NetLegacy *net = object;
>> -        const NetLegacyOptions *opts = net->opts;
>> -        legacy.id = net->id;
>> -        netdev = &legacy;
>> -
>> -        /* Map the old options to the new flat type */
>> -        switch (opts->type) {
>> -        case NET_LEGACY_OPTIONS_TYPE_NONE:
>> +        if (netdev->type == NET_CLIENT_DRIVER_NONE) {
>>               return 0; /* nothing to do */
> 
> 
>> -
>> -        if (!net_client_init_fun[netdev->type]) {
>> +        if (netdev->type == NET_CLIENT_DRIVER_HUBPORT ||
>> +            !net_client_init_fun[netdev->type]) {
>>               error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "type",
>>                          "a net backend type (maybe it is not compiled "
>>                          "into this binary)");
> 
> So maybe we still want this legacy-handling code, but renaming
> 'is_netdev' to 'legacy_handling' may make more sense.

Hmm, maybe renaming would be good indeed to avoid confusion here... I'll
think about it.

>> @@ -1039,7 +995,7 @@ static int net_client_init1(const void *object,
>> bool is_netdev, Error **errp)
>>             /* Do not add to a hub if it's a nic with a netdev=
>> parameter. */
>>           if (netdev->type != NET_CLIENT_DRIVER_NIC ||
>> -            !opts->u.nic.has_netdev) {
>> +            !netdev->u.nic.has_netdev) {
>>               peer = net_hub_add_port(0, NULL, NULL);
>>           }
>>       }
>> @@ -1143,21 +1099,13 @@ static int net_client_init(QemuOpts *opts,
>> bool is_netdev, Error **errp)
>>           }
>>       }
>>   -    if (is_netdev) {
>> -        visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
>> -    } else {
>> -        visit_type_NetLegacy(v, NULL, (NetLegacy **)&object, &err);
>> -    }
>> +    visit_type_Netdev(v, NULL, (Netdev **)&object, &err);
> 
> Why do we need to cast?  If all callers are passing a Netdev, can't we
> just give 'object' the correct type to begin with?

Agreed, it should be possible to use Netdev* instead of void* for
"object" now. I'll change that in v3.

>> +++ b/qapi/net.json
>> @@ -453,7 +453,7 @@
>>   #        'l2tpv3' - since 2.1
>>   ##
>>   { 'union': 'Netdev',
>> -  'base': { 'id': 'str', 'type': 'NetClientDriver' },
>> +  'base': { '*id': 'str', 'type': 'NetClientDriver' },
> 
> I don't think we need to make 'id' optional.

It's required for "-net" now.

>>     'discriminator': 'type',
>>     'data': {
>>       'nic':      'NetLegacyNicOptions',
>> @@ -467,52 +467,6 @@
>>       'netmap':   'NetdevNetmapOptions',
>>       'vhost-user': 'NetdevVhostUserOptions' } }
>>   -##
>> -# @NetLegacy:
>> -#
>> -# Captures the configuration of a network device; legacy.
>> -#
>> -# @id: identifier for monitor commands
>> -#
>> -# @opts: device type specific properties (legacy)
>> -#
>> -# Since: 1.2
>> -##
>> -{ 'struct': 'NetLegacy',
>> -  'data': {
>> -    '*id':   'str',
>> -    'opts':  'NetLegacyOptions' } }
>> -
>> -##
>> -# @NetLegacyOptionsType:
>> -#
>> -# Since: 1.2
>> -##
>> -{ 'enum': 'NetLegacyOptionsType',
>> -  'data': ['none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
>> -           'bridge', 'netmap', 'vhost-user'] }
> 
> NetLegacyOptionsType differs from NetClientDriver only by missing
> 'hubport', which your code above special-cased, so on that front, the
> simplification makes sense.

Thanks for your review!

 Thomas


