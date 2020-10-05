Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEFB205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoXqPLgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEFB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPKuk-0001hv-Vh
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 03:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPKtl-0001CG-1a
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43380)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kPKti-0008GI-PS
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 03:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601882821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XBux1vVKLRxoX59ByWau/wYMcf6fvz6wWBxGRdovDs=;
 b=HoXqPLgXrhVh6UEGCaQxGkQ8XHAfwtDEUgWs1vDUaBu3fUKq5uij/5TAgjUwYydbtsWjl3
 DY5sRrsWnz+tBgzuhSJzO1k7vMsueGTtNGlKRVyOd3NqGFbS5vYoAaLFH1R1NN2LvPuz6e
 Jh4s1aGPOc8eWL1jakGsl6RbMC3r588=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-v5bmZgLQNNe7aRqW2FLkmg-1; Mon, 05 Oct 2020 03:26:58 -0400
X-MC-Unique: v5bmZgLQNNe7aRqW2FLkmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCD5EE75F;
 Mon,  5 Oct 2020 07:26:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 51BAA5D9CD;
 Mon,  5 Oct 2020 07:26:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A91AB10C7796; Mon,  5 Oct 2020 09:26:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 10/10] migration: introduce snapshot-{save, load,
 delete} QMP commands
References: <20201002162747.3123597-1-berrange@redhat.com>
 <20201002162747.3123597-11-berrange@redhat.com>
 <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com>
Date: Mon, 05 Oct 2020 09:26:54 +0200
In-Reply-To: <ef01ef63-7b95-88c2-5d31-103d29f9f64f@redhat.com> (Eric Blake's
 message of "Fri, 2 Oct 2020 14:46:07 -0500")
Message-ID: <87a6x1cev5.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 01:25:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.745,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, "Denis V.
 Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/2/20 11:27 AM, Daniel P. Berrang=C3=A9 wrote:
>> savevm, loadvm and delvm are some of the few HMP commands that have neve=
r
>> been converted to use QMP. The reasons for the lack of conversion are
>> that they blocked execution of the event thread, and the semantics
>> around choice of disks were ill-defined.
>>=20
>> Despite this downside, however, libvirt and applications using libvirt
>> have used these commands for as long as QMP has existed, via the
>> "human-monitor-command" passthrough command. IOW, while it is clearly
>> desirable to be able to fix the problems, they are not a blocker to
>> all real world usage.
>>=20
>> Meanwhile there is a need for other features which involve adding new
>> parameters to the commands. This is possible with HMP passthrough, but
>> it provides no reliable way for apps to introspect features, so using
>> QAPI modelling is highly desirable.
>>=20
>> This patch thus introduces new snapshot-{load,save,delete} commands to
>> QMP that are intended to replace the old HMP counterparts. The new
>> commands are given different names, because they will be using the new
>> QEMU job framework and thus will have diverging behaviour from the HMP
>> originals. It would thus be misleading to keep the same name.
>>=20
>> While this design uses the generic job framework, the current impl is
>> still blocking. The intention that the blocking problem is fixed later.
>> None the less applications using these new commands should assume that
>> they are asynchronous and thus wait for the job status change event to
>> indicate completion.
>>=20
>> In addition to using the job framework, the new commands require the
>> caller to be explicit about all the block device nodes used in the
>> snapshot operations, with no built-in default heuristics in use.
>>=20
>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> ---
>
>> +++ b/qapi/job.json
>> @@ -22,10 +22,17 @@
>>  #
>>  # @amend: image options amend job type, see "x-blockdev-amend" (since 5=
.1)
>>  #
>> +# @snapshot-load: snapshot load job type, see "snapshot-load" (since 5.=
2)
>> +#
>> +# @snapshot-save: snapshot save job type, see "snapshot-save" (since 5.=
2)
>> +#
>> +# @snapshot-delete: snapshot delete job type, see "snapshot-delete" (si=
nce 5.2)
>> +#
>>  # Since: 1.7
>>  ##
>>  { 'enum': 'JobType',
>> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
>> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
>> +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
>> =20
>>  ##
>>  # @JobStatus:
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 7f5e6fd681..d2bd551ad9 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1787,3 +1787,123 @@
>>  # Since: 5.2
>>  ##
>>  { 'command': 'query-dirty-rate', 'returns': 'DirtyRateInfo' }
>> +
>> +##
>> +# @snapshot-save:
>> +#
>> +# Save a VM snapshot
>> +#
>> +# @job-id: identifier for the newly created job
>> +# @tag: name of the snapshot to create
>> +# @devices: list of block device node names to save a snapshot to
>> +# @vmstate: block device node name to save vmstate to
>
> Here, you document vmstate last,...
>
>> +#
>> +# Applications should not assume that the snapshot save is complete
>> +# when this command returns. The job commands / events must be used
>> +# to determine completion and to fetch details of any errors that arise=
.
>> +#
>> +# Note that the VM CPUs will be paused during the time it takes to
>> +# save the snapshot

End the sentence with a period, please.

> "will be", or "may be"?  As you stated above, we may be able to lift the
> synchronous limitations down the road, while still maintaining the
> present interface of using this command to start the job and waiting on
> the job id until it is finished, at which point the CPUs might not need
> to be paused as much.

Could also add a sentence like "This may change in the future".

>> +#
>> +# It is strongly recommended that @devices contain all writable
>> +# block device nodes if a consistent snapshot is required.
>> +#
>> +# If @tag already exists, an error will be reported
>> +#
>> +# Returns: nothing
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "snapshot-save",
>> +#      "data": {
>> +#         "job-id": "snapsave0",
>> +#         "tag": "my-snap",
>> +#         "vmstate": "disk0",
>> +#         "devices": ["disk0", "disk1"]
>
> ...here vmstate occurs before devices.  I don't know if our doc
> generator cares about inconsistent ordering.

It does not.  It's questionable style, though.  Easy enough to tidy up.

>> +#      }
>> +#    }
>> +# <- { "return": { } }
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'command': 'snapshot-save',
>> +  'data': { 'job-id': 'str',
>> +            'tag': 'str',
>> +            'vmstate': 'str',
>> +            'devices': ['str'] } }
>> +
>> +##
>> +# @snapshot-load:
>> +#
>> +# Load a VM snapshot
>> +#
>> +# @job-id: identifier for the newly created job
>> +# @tag: name of the snapshot to load.
>> +# @devices: list of block device node names to load a snapshot from
>> +# @vmstate: block device node name to load vmstate from
>> +#
>> +# Applications should not assume that the snapshot save is complete
>> +# when this command returns. The job commands / events must be used
>> +# to determine completion and to fetch details of any errors that arise=
.
>
> s/save/load/
>
>> +#
>> +# Note that the VM CPUs will be paused during the time it takes to
>> +# save the snapshot

End the sentence with a period, please.

> s/save/load/
>
> But while pausing CPUs during save is annoying, pausing CPUs during
> restore makes sense (after all, executing on stale data that will still
> be updated during the restore is just wasted execution).
>
>
>> +#
>> +# It is strongly recommended that @devices contain all writable
>> +# block device nodes that can have changed since the original
>> +# @snapshot-save command execution.
>> +#
>> +# Returns: nothing
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "snapshot-load",
>> +#      "data": {
>> +#         "job-id": "snapload0",
>> +#         "tag": "my-snap",
>> +#         "vmstate": "disk0",
>> +#         "devices": ["disk0", "disk1"]
>> +#      }
>> +#    }
>> +# <- { "return": { } }
>> +#
>> +# Since: 5.2
>> +##
>> +{ 'command': 'snapshot-load',
>> +  'data': { 'job-id': 'str',
>> +            'tag': 'str',
>> +            'vmstate': 'str',
>> +            'devices': ['str'] } }
>> +
>> +##
>> +# @snapshot-delete:
>> +#
>> +# Delete a VM snapshot
>> +#
>> +# @job-id: identifier for the newly created job
>> +# @tag: name of the snapshot to delete.
>> +# @devices: list of block device node names to delete a snapshot from
>> +#
>> +# Applications should not assume that the snapshot save is complete
>> +# when this command returns. The job commands / events must be used
>> +# to determine completion and to fetch details of any errors that arise=
.
>
> Do we have a query- command handy to easily learn which snapshot names
> are even available to attempt deletion on?  If not, that's worth a
> separate patch.

Oh, I missed that one.  It's the QMP equivalent to "info snapshots", and
it is required to finish the job.  Since we're at v5, I'd be okay with a
follow-up patch, as long as it is done for 5.2.

>> +#
>> +# Returns: nothing
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "snapshot-delete",
>> +#      "data": {
>> +#         "job-id": "snapdelete0",
>> +#         "tag": "my-snap",
>> +#         "devices": ["disk0", "disk1"]
>> +#      }
>> +#    }
>> +# <- { "return": { } }
>> +#
>> +# Since: 5.2
>> +##

With the doc comment nits addressed, and with new command
query-snapshots either included or promised for later in 5.2:
Acked-by: Markus Armbruster <armbru@redhat.com>

>
>> +++ b/tests/qemu-iotests/group
>> @@ -291,6 +291,7 @@
>>  277 rw quick
>>  279 rw backing quick
>>  280 rw migration quick
>> +310 rw quick
>>  281 rw quick
>>  282 rw img quick
>>  283 auto quick
>
> What's wrong with sorted order? I get the renumbering to appease a merge
> conflict, but it also requires rearrangement ;)


