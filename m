Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0596C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9EC20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkT3eq2n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9EC20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB8v-0006Ew-KU
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kEB8H-0005IR-Ob
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kEB8G-0007Rh-1l
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599223674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODE061p/rgVWXyf2GOclXK/BUKYFk7OAFgyjOJUm7oc=;
 b=OkT3eq2n9l1zmoa9AipAA5e+nWWmQ0FtQyx7p5LLN0Fq9CGERQTXbUG9LYvnkdNO/Nh8jg
 +eErg1QHg7+axtKc1ZXQlEeu3Den+ElUgPvcNcx90PWxObAXaK5AaMdoHDlNuACRqXrUIp
 YVHycSYLyvM2qWn8i14xiHDrnmT/GZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-VWHWXS2XP7eyRmrJ_tFQpw-1; Fri, 04 Sep 2020 08:47:50 -0400
X-MC-Unique: VWHWXS2XP7eyRmrJ_tFQpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEDA2185A0C2;
 Fri,  4 Sep 2020 12:47:49 +0000 (UTC)
Received: from [10.3.112.149] (ovpn-112-149.phx2.redhat.com [10.3.112.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2391C10013D7;
 Fri,  4 Sep 2020 12:47:46 +0000 (UTC)
Subject: Re: [PATCH v7 1/8] Introduce yank feature
To: Lukas Straub <lukasstraub2@web.de>, Markus Armbruster <armbru@redhat.com>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <0092d4fe5f64078a18db3790c46c508416dbdb6b.1596528468.git.lukasstraub2@web.de>
 <871rjs9ser.fsf@dusky.pond.sub.org> <20200904141312.185a20d5@luklap>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <d661eb62-4a83-93b2-7bfe-8a10b3e581ff@redhat.com>
Date: Fri, 4 Sep 2020 07:47:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904141312.185a20d5@luklap>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:46:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 7:33 AM, Lukas Straub wrote:

>>> +##
>>> +# @YankInstances:
>>> +#
>>> +# @instances: List of yank instances.
>>> +#
>>> +# Yank instances are named after the following schema:
>>> +# "blockdev:<node-name>", "chardev:<chardev-name>" and "migration"
>>> +#
>>> +# Since: 5.1
>>> +##
>>> +{ 'struct': 'YankInstances', 'data': {'instances': ['str'] } }
>>
>> I'm afraid this is a problematic QMP interface.
>>
>> By making YankInstances a struct, you keep the door open to adding more
>> members, which is good.
>>
>> But by making its 'instances' member a ['str'], you close the door to
>> using anything but a single string for the individual instances.  Not so
>> good.
>>
>> The single string encodes information which QMP client will need to
>> parse from the string.  We frown on that in QMP.  Use QAPI complex types
>> capabilities for structured data.
>>
>> Could you use something like this instead?
>>
>> { 'enum': 'YankInstanceType',
>>    'data': { 'block-node', 'chardev', 'migration' } }
>>
>> { 'struct': 'YankInstanceBlockNode',
>>    'data': { 'node-name': 'str' } }
>>
>> { 'struct': 'YankInstanceChardev',
>>    'data' { 'label': 'str' } }
>>
>> { 'union': 'YankInstance',
>>    'base': { 'type': 'YankInstanceType' },
>>    'discriminator': 'type',
>>    'data': {
>>        'block-node': 'YankInstanceBlockNode',
>>        'chardev': 'YankInstanceChardev' } }
>>
>> { 'command': 'yank',
>>    'data': { 'instances': ['YankInstance'] },
>>    'allow-oob': true }
> 
> This proposal looks good to me. Does everyone agree?

Yes; this is also more introspectible, so that if we add more yank 
instances down the road, or even more optional features to existing yank 
instances, it becomes easier to detect whether a particular qemu has 
those additions.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


