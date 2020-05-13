Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A2CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:41:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCD720740
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjUDa0qV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD720740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmx3-00066M-W9
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYmwK-0005Tw-KS
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:40:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33128
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jYmwJ-0003yc-46
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589359228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=TGuN4ONGMOTJo+fnoMX4KEOUUWvWIxw3w2aVkSNdOl8=;
 b=OjUDa0qVyoZHLWd9VY4oGiC279wmpNeFSa82t1B53tNYjxBl6j017modKpfjutMyuUVqFV
 a6c2q022rmZDiC7RYcUkIjR3Oy7z2LMeAXPUgMN/oLUJ9uinXrQm1tWzmD8NGP+KD6eC9K
 YdGrEsh+ADCw+LwVHR5m1aQYnLj/VGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-RwEF8eb2N9eHce_bTuUauA-1; Wed, 13 May 2020 04:40:27 -0400
X-MC-Unique: RwEF8eb2N9eHce_bTuUauA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97E46100CCC0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 08:40:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-100.ams2.redhat.com [10.36.114.100])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB46510013D9;
 Wed, 13 May 2020 08:40:24 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] net: Drop the NetLegacy structure, always use
 Netdev instead
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20200512123149.30207-1-thuth@redhat.com>
 <20200512123149.30207-3-thuth@redhat.com>
 <3a2bcb19-5ba3-0023-8733-d945ee40aeeb@redhat.com>
 <ef4bd3f7-c023-d4c8-b4b6-2b8abe9e1cdb@redhat.com>
 <aaf3efdc-072f-4b55-8bff-402be55b604b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8be8273a-8837-8738-39ae-6ba74ec190ef@redhat.com>
Date: Wed, 13 May 2020 10:40:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <aaf3efdc-072f-4b55-8bff-402be55b604b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020 17.51, Eric Blake wrote:
> On 5/12/20 10:13 AM, Thomas Huth wrote:
> 
>>>> +++ b/qapi/net.json
>>>> @@ -453,7 +453,7 @@
>>>>    #        'l2tpv3' - since 2.1
>>>>    ##
>>>>    { 'union': 'Netdev',
>>>> -  'base': { 'id': 'str', 'type': 'NetClientDriver' },
>>>> +  'base': { '*id': 'str', 'type': 'NetClientDriver' },
>>>
>>> I don't think we need to make 'id' optional.
>>
>> It's required for "-net" now.
> 
> But does -net generate it's own id if one is not provided?  Can it still
> be mandatory in the QAPI type, and just figure out how to guarantee that
> the CLI parsing of -net provides a name early enough in the cycle to use
> the QAPI type without making the member optional there?

I guess it could be done - but we'd need to change the internal naming
scheme for this. Currently, the internal id / name is created with
assign_name() during qemu_net_client_setup() - which is the function
that is called from the individual network backends via
qemu_new_net_client() with a "model" string, e.g. net/slirp.c calls it
with model="user", net/tap.c calls it with model="bridge" etc.
The model string is then used in assign_name() to create the internal id
(aka. name in the NetClientState).

If we want to keep the "id" mandatory in the QAPI type, we have to
create the internal id before calling visit_type_Netdev() in
net_client_init(). But the "model" string information is not available
here yet, since this takes place before the init function of the backend
is called. Thus we'd need to come up with a different internal id string
here, e.g. something like "__org.qemu.net-xyz" like it is done in
net_param_nic() already. Do you think it is ok to change the internal
name / id here? I think it should be ok - if the users care about the id
of the netdevs, they should specify the ids on the command line and not
rely on some internal naming schemes... do you agree?

 Thomas


