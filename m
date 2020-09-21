Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA9C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372382084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CNjnSjp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372382084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQX9-00006o-8S
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKQMY-0001JX-6x
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:16:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kKQMT-0004ef-S2
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 14:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600712183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I/FA9Z3pFEvQxsQFSG4eQP/Zuh8tRsaSm/UUC3w95Xs=;
 b=CNjnSjp9GEaLHv6GfCkdPHUT/bD2ZfKHETmhVETUe6NpU0NW5aSFQs4pb7YvGILDPm5I1L
 M6zYJeMc6AUp7c4PNu3ReCxMpoJ4djU7+I++o1xK5A6DPk5SyY2Y/r2nUntb3gET6ec+RI
 oda5RLTIa6tphQzzfJcFKpZIREziWes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-Ipv0WHjgNvSQjH_vnxS7ww-1; Mon, 21 Sep 2020 14:16:19 -0400
X-MC-Unique: Ipv0WHjgNvSQjH_vnxS7ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CF48192C8A6;
 Mon, 21 Sep 2020 18:16:18 +0000 (UTC)
Received: from [10.3.113.127] (ovpn-113-127.phx2.redhat.com [10.3.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76B2B5D9CD;
 Mon, 21 Sep 2020 18:16:17 +0000 (UTC)
Subject: Re: [PATCH v4 9/9] migration: introduce snapshot-{save, load, delete}
 QMP commands
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200915113523.2520317-1-berrange@redhat.com>
 <20200915113523.2520317-10-berrange@redhat.com>
 <87tuvyt9sf.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0b8eef3d-db87-f82b-798d-2a0cb7ec1198@redhat.com>
Date: Mon, 21 Sep 2020 13:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87tuvyt9sf.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 3:17 AM, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> savevm, loadvm and delvm are some of the few HMP commands that have never
>> been converted to use QMP. The reasons for the lack of conversion are
>> that they blocked execution of the event thread, and the semantics
>> around choice of disks were ill-defined.
>>
>> Despite this downside, however, libvirt and applications using libvirt
>> have used these commands for as long as QMP has existed, via the
>> "human-monitor-command" passthrough command. IOW, while it is clearly
>> desirable to be able to fix the problems, they are not a blocker to
>> all real world usage.
>>
>> Meanwhile there is a need for other features which involve adding new
>> parameters to the commands. This is possible with HMP passthrough, but
>> it provides no reliable way for apps to introspect features, so using
>> QAPI modelling is highly desirable.
>>
>> This patch thus introduces new snapshot-{load,save,delete} commands to
>> QMP that are intended to replace the old HMP counterparts. The new
>> commands are given different names, because they will be using the new
>> QEMU job framework and thus will have diverging behaviour from the HMP
>> originals. It would thus be misleading to keep the same name.
>>
>> While this design uses the generic job framework, the current impl is
>> still blocking. The intention that the blocking problem is fixed later.
>> None the less applications using these new commands should assume that
>> they are asynchronous and thus wait for the job status change event to
>> indicate completion.
>>
>> In addition to using the job framework, the new commands require the
>> caller to be explicit about all the block device nodes used in the
>> snapshot operations, with no built-in default heuristics in use.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> [...]
>> diff --git a/qapi/job.json b/qapi/job.json
>> index 280c2f76f1..b2cbb4fead 100644
>> --- a/qapi/job.json
>> +++ b/qapi/job.json
>> @@ -22,10 +22,17 @@
>>   #
>>   # @amend: image options amend job type, see "x-blockdev-amend" (since 5.1)
>>   #
>> +# @snapshot-load: snapshot load job type, see "snapshot-load" (since 5.2)
>> +#
>> +# @snapshot-save: snapshot save job type, see "snapshot-save" (since 5.2)
>> +#
>> +# @snapshot-delete: snapshot delete job type, see "snapshot-delete" (since 5.2)
>> +#
>>   # Since: 1.7
>>   ##
>>   { 'enum': 'JobType',
>> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
>> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
>> +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
>>   
>>   ##
>>   # @JobStatus:
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 675f70bb67..b584c0be31 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1720,3 +1720,123 @@
>>   ##
>>   { 'event': 'UNPLUG_PRIMARY',
>>     'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @snapshot-save:
>> +#
>> +# Save a VM snapshot
>> +#
>> +# @job-id: identifier for the newly created job
>> +# @tag: name of the snapshot to create
>> +# @devices: list of block device node names to save a snapshot to
> 
> Looks like you dropped the idea to also accept drive IDs.  Is that for
> good, or would you like to add it later?

Is it necessary?  Several of our newer block interfaces have required 
node names, rather than permitting alternation.  If we rewrite the 
existing HMP commands to operate on top of the new QMP command, it is 
still possible for HMP to support drive names even when QMP does not.  I 
don't think the complexity of worrying about drive names is worth it; 
after all, the QMP command is new enough that the only libvirt that will 
use it is also a libvirt that knows how to use -blockdev, and thus node 
names are sufficient.

Yes, we can add drive ids later if I turn out to be wrong, but for now, 
I'm hoping their exclusion is intentional.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


