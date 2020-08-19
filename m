Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00579207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 20:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4HH9cye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00579207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8UMI-0002tn-5a
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 16:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ULa-0002N8-MV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:06:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8ULY-0005bE-7o
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 16:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597867565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LNEo8CBejPcYcaSDR4Q+0FOl5DFXVMlySPmB3pX3Yo=;
 b=F4HH9cyehnH/I3mbpkEO4QUGmjXY8q+AjRRsExAbY1aY22QQj4jD75K/DaToYI4Iy4mDgl
 4zKkBluJofdkpTMzvOlFm9m8f4HdCFm5vAUaZlt/Vb9S4Z50P6RLKVfjPp/E9IlCI2s5Aa
 oXuTauiIHBO4BregB/e2Ky102eBQ5hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-8tjLlhgfOQWyx246TC81rQ-1; Wed, 19 Aug 2020 16:06:00 -0400
X-MC-Unique: 8tjLlhgfOQWyx246TC81rQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A02981854FEA;
 Wed, 19 Aug 2020 20:05:59 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3619560BEC;
 Wed, 19 Aug 2020 20:05:59 +0000 (UTC)
Subject: Re: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-10-kwolf@redhat.com>
 <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cf3f6122-7cc0-0323-4aa5-9df3482a2f35@redhat.com>
Date: Wed, 19 Aug 2020 15:05:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 16:00:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 7:56 AM, Max Reitz wrote:
> On 13.08.20 18:29, Kevin Wolf wrote:
>> qemu-nbd allows use of writethrough cache modes, which mean that write
>> requests made through NBD will cause a flush before they complete.
>> Expose the same functionality in block-export-add.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---

>> +++ b/qapi/block-export.json
>> @@ -167,10 +167,15 @@
>>   # Describes a block export, i.e. how single node should be exported on an
>>   # external interface.
>>   #
>> +# @writethrough: If true, caches are flushed after every write request to the
>> +#                export before completion is signalled. (since: 5.2;
>> +#                default: false)
>> +#
>>   # Since: 4.2
>>   ##
>>   { 'union': 'BlockExportOptions',
>> -  'base': { 'type': 'BlockExportType' },
>> +  'base': { 'type': 'BlockExportType',
>> +            '*writethrough': 'bool' },
>>     'discriminator': 'type',
>>     'data': {
>>         'nbd': 'BlockExportOptionsNbd'
> 
> Hm.  I find it weird to have @writethrough in the base but @device in
> the specialized class.
> 
> I think everything that will be common to all block exports should be in
> the base, and that probably includes a node-name.  I’m aware that will
> make things more tedious in the code, but perhaps it would be a nicer
> interface in the end.  Or is the real problem that that would create
> problems in the storage daemon’s command line interface, because then
> the specialized (legacy) NBD interface would no longer be compatible
> with the new generalized block export interface?
> 
> Anyway, @writable might be a similar story.  A @read-only may make sense
> in general, I think.

And maybe even auto-read-only.  As for @writable vs. @read-only, that's 
a choice of spelling, but we don't want both; there's also the question 
of which default is saner (having to opt-in to allowing writes is more 
verbose than defaulting to allowing writes when possible, but arguably 
saner as it is less risk of unintended writes when you forgot to specify 
the option; @auto-read-only can help in choosing nicer defaults).

> 
> Basically, I think that the export code should be separate from the code
> setting up the BlockBackend that should be exported, so all options
> regarding that BB should be common; and those options are @node-name,
> @writethrough, and @read-only.  (And perhaps other things like
> @resizable, too, even though that isn’t something to consider for NBD.)

NBD isn't resizable yet, but extending the protocol to let it become so 
is on my TODO list.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


