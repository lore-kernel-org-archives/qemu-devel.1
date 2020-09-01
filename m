Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80634C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CEF32192A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPkNgMzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEF32192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7W7-0000Yj-61
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD79b-0002eK-Bl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kD79Z-0005G4-BJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 10:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598970052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=phv0FwmmyA13v/LpGk1n5wCz8C2BdrWVn2OVph/lSSo=;
 b=dPkNgMzOSy90j/sMhnRSUfl6K/imde+5cmYr8sFX4yeToyvdIYTF1QoxeIzgqJSxHStKH2
 qdDJdS/AS9UuwAM5Gw8Rj4F90c2UgPyxZvrvJb2nyNaaJaI8LcEecCkQJaHCG05eg3v02w
 1Gf31Z6x79XOEwF1jM8WAgTtfAFe80w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-WBylMePdMWau_g_OkoMkxg-1; Tue, 01 Sep 2020 10:20:50 -0400
X-MC-Unique: WBylMePdMWau_g_OkoMkxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F24918B9EA9;
 Tue,  1 Sep 2020 14:20:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CFB0819C66;
 Tue,  1 Sep 2020 14:20:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4D48C113C418; Tue,  1 Sep 2020 16:20:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
Date: Tue, 01 Sep 2020 16:20:47 +0200
In-Reply-To: <20200827111606.1408275-8-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 27 Aug 2020 12:16:06
 +0100")
Message-ID: <87d035tw74.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 01:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> savevm, loadvm and delvm are some of the few HMP commands that have never
> been converted to use QMP. The primary reason for this lack of conversion
> is that they block execution of the thread for as long as they run.

Nope.  The primary reason is that the HMP interface is bonkers.

> Despite this downside, however, libvirt and applications using libvirt
> have used these commands for as long as QMP has existed, via the
> "human-monitor-command" passthrough command. IOW, while it is clearly
> desirable to be able to fix the blocking problem, this is not an
> immediate obstacle to real world usage.
>
> Meanwhile there is a need for other features which involve adding new
> parameters to the commands. This is possible with HMP passthrough, but
> it provides no reliable way for apps to introspect features, so using
> QAPI modelling is highly desirable.
>
> This patch thus introduces new snapshot-{load,save,delete} commands to
> QMP that are intended to replace the old HMP counterparts. The new
> commands are given different names, because they will be using the new
> QEMU job framework and thus will have diverging behaviour from the HMP
> originals. It would thus be misleading to keep the same name.
>
> While this design uses the generic job framework, the current impl is
> still blocking. The intention that the blocking problem is fixed later.
> None the less applications using these new commands should assume that
> they are asynchronous and thus wait for the job status change event to
> indicate completion.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[...]
> diff --git a/qapi/job.json b/qapi/job.json
> index 280c2f76f1..51bee470f0 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -22,10 +22,17 @@
>  #
>  # @amend: image options amend job type, see "x-blockdev-amend" (since 5.=
1)
>  #
> +# @snapshot-load: snapshot load job type, see "loadvm" (since 5.2)

Do you mean 'see command @snapshot-load?

> +#
> +# @snapshot-save: snapshot save job type, see "savevm" (since 5.2)

@snapshot-save?

> +#
> +# @snapshot-delete: snapshot delete job type, see "delvm" (since 5.2)

@snapshot-delete?

> +#
>  # Since: 1.7
>  ##
>  { 'enum': 'JobType',
> -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
> +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
> =20
>  ##
>  # @JobStatus:
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 5f6b06172c..d70f627b77 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1720,3 +1720,138 @@
>  ##
>  { 'event': 'UNPLUG_PRIMARY',
>    'data': { 'device-id': 'str' } }
> +
> +##
> +# @snapshot-save:
> +#
> +# Save a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to create. If it already
> +# exists it will be replaced.

Sounds a bit dangerous.  Require a force flag for such an overwrite?
Not sure.

> +# @devices: list of block device node names to save a snapshot to
> +# @vmstate: block device node name to save vmstate to

Worth mentioning that omitting writable block devices is probably a bad
idea?

> +#
> +# Applications should not assume that the snapshot save is complete
> +# when this command returns.

Is it complete then with the current code?  I'm asking because such
properties have a way to sneakily become de facto ABI.  We may not be
able to do anything about that now, other than documenting "don't do
that" like you did, but I'd like to understand the state of affairs all
the same.

> +#                            Completion is indicated by the job
> +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
> +# job aborts, errors can be obtained via the 'query-jobs' command,
> +# though.

Sure we want to these job basics here?

> +#         Note that at this time most vmstate procssing errors only

Typo: processing

Whatever a "vmstate processing error" is...

> +# get printed to stderr. This limitation will be fixed at a future
> +# date.

Is that a promise?  ;)

> +#
> +# Note that the VM CPUs will be paused during the time it takes to
> +# save the snapshot

End the sentence with a period, please.

> +#
> +# If @devices is not specified, or is an empty list, then the
> +# historical default logic for picking devices will be used.

Why is this useful for QMP?

> +#
> +# If @vmstate is not specified, then the first valid block
> +# device will be used for vmstate.

Why is this useful for QMP?

> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-save",
> +#      "data": {
> +#         "job-id": "snapsave0",
> +#         "tag": "my-snap",
> +#         "vmstate": "disk0",
> +#         "devices": ["disk0", "disk1"]
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'snapshot-save',
> +  'data': { 'job-id': 'str',
> +            'tag': 'str',
> +            '*vmstate': 'str',
> +            '*devices': ['str'] } }
> +
> +##
> +# @snapshot-load:
> +#
> +# Load a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to load.
> +# @devices: list of block device node names to load a snapshot from
> +# @vmstate: block device node name to load vmstate from

Worth mentioning that omitting block devices that may have changed since
the save is probably a bad idea?

> +#
> +# Applications should not assume that the snapshot load is complete
> +# when this command returns. Completion is indicated by the job
> +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
> +# job aborts, errors can be obtained via the 'query-jobs' command,
> +# though. Note that at this time most vmstate procssing errors only
> +# get printed to stderr. This limitation will be fixed at a future
> +# date.

Comments on snapshot-load apply.

> +#
> +# If @devices is not specified, or is an empty list, then the
> +# historical default logic for picking devices will be used.

Why is this useful for QMP?

> +#
> +# If @vmstate is not specified, then the first valid block
> +# device will be used for vmstate.

Why is this useful for QMP?

A more useful default could be "if exactly one the block devices being
restored contains a vmstate, use that".

> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-load",
> +#      "data": {
> +#         "job-id": "snapload0",
> +#         "tag": "my-snap",
> +#         "vmstate": "disk0",
> +#         "devices": ["disk0", "disk1"]
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'snapshot-load',
> +  'data': { 'job-id': 'str',
> +            'tag': 'str',
> +            '*vmstate': 'str',
> +            '*devices': ['str'] } }
> +
> +##
> +# @snapshot-delete:
> +#
> +# Delete a VM snapshot
> +#
> +# @job-id: identifier for the newly created job
> +# @tag: name of the snapshot to delete.
> +# @devices: list of block device node names to delete a snapshot from
> +#
> +# Applications should not assume that the snapshot load is complete
> +# when this command returns. Completion is indicated by the job
> +# status. Clients can wait for the JOB_STATUS_CHANGE event.

Comments on snapshot-load apply.

One difference: no "If the job aborts, ..."  Intentional?

> +#
> +# Note that the VM CPUs will be paused during the time it takes to
> +# delete the snapshot
> +#
> +# If @devices is not specified, or is an empty list, then the
> +# historical default logic for picking devices will be used.

Why is this useful for QMP?

> +#
> +# Returns: nothing
> +#
> +# Example:
> +#
> +# -> { "execute": "snapshot-delete",
> +#      "data": {
> +#         "job-id": "snapdelete0",
> +#         "tag": "my-snap",
> +#         "devices": ["disk0", "disk1"]
> +#      }
> +#    }
> +# <- { "return": { } }
> +#
> +# Since: 5.2
> +##
> +{ 'command': 'snapshot-delete',
> +  'data': { 'job-id': 'str',
> +            'tag': 'str',
> +            '*devices': ['str'] } }
[...]


