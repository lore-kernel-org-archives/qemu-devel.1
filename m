Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D812C2BC0E
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027DE2067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yx3p7vsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027DE2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9SJ-00012O-Pm
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD9Rk-0000Tr-Iy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:47:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD9Ri-0002HT-KJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598978865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEWfEB0qV+V+7Zen+BunnLV1MeCxtgdsd5LdvoSwYaU=;
 b=Yx3p7vsNxOILgvVEljIsVm19thXey40X3B1vKNKtWQiJS+J75lL6w8F8YlKlNFe5SDuhkJ
 d0eZ4AqmZv0YkTfjm3A3czUuw4c8L+eDBRTYjWmsam+gmk+k9V2Ifv7qq1KPK1df+rVQf2
 K3WQM1VmJuANUpYXmSpunXMECw9L1gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-S15AhvdiPj-jJA225-APKA-1; Tue, 01 Sep 2020 12:47:39 -0400
X-MC-Unique: S15AhvdiPj-jJA225-APKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C1961006710;
 Tue,  1 Sep 2020 16:47:38 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA6BB1002D60;
 Tue,  1 Sep 2020 16:47:34 +0000 (UTC)
Date: Tue, 1 Sep 2020 17:47:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
Message-ID: <20200901164732.GZ345480@redhat.com>
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
 <87d035tw74.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87d035tw74.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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

On Tue, Sep 01, 2020 at 04:20:47PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > savevm, loadvm and delvm are some of the few HMP commands that have never
> > been converted to use QMP. The primary reason for this lack of conversion
> > is that they block execution of the thread for as long as they run.
> 
> Nope.  The primary reason is that the HMP interface is bonkers.

I don't think that's very helpful description. The HMP interface has
some limitations, but it isn't bonkers - it just doesn't cope with
all the use cases we want. Many people use it succesfully without
issue

> > Despite this downside, however, libvirt and applications using libvirt
> > have used these commands for as long as QMP has existed, via the
> > "human-monitor-command" passthrough command. IOW, while it is clearly
> > desirable to be able to fix the blocking problem, this is not an
> > immediate obstacle to real world usage.
> >
> > Meanwhile there is a need for other features which involve adding new
> > parameters to the commands. This is possible with HMP passthrough, but
> > it provides no reliable way for apps to introspect features, so using
> > QAPI modelling is highly desirable.
> >
> > This patch thus introduces new snapshot-{load,save,delete} commands to
> > QMP that are intended to replace the old HMP counterparts. The new
> > commands are given different names, because they will be using the new
> > QEMU job framework and thus will have diverging behaviour from the HMP
> > originals. It would thus be misleading to keep the same name.
> >
> > While this design uses the generic job framework, the current impl is
> > still blocking. The intention that the blocking problem is fixed later.
> > None the less applications using these new commands should assume that
> > they are asynchronous and thus wait for the job status change event to
> > indicate completion.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> [...]
> > diff --git a/qapi/job.json b/qapi/job.json
> > index 280c2f76f1..51bee470f0 100644
> > --- a/qapi/job.json
> > +++ b/qapi/job.json
> > @@ -22,10 +22,17 @@
> >  #
> >  # @amend: image options amend job type, see "x-blockdev-amend" (since 5.1)
> >  #
> > +# @snapshot-load: snapshot load job type, see "loadvm" (since 5.2)
> 
> Do you mean 'see command @snapshot-load?

Yes, I guess so.

> 
> > +#
> > +# @snapshot-save: snapshot save job type, see "savevm" (since 5.2)
> 
> @snapshot-save?
> 
> > +#
> > +# @snapshot-delete: snapshot delete job type, see "delvm" (since 5.2)
> 
> @snapshot-delete?
> 
> > +#
> >  # Since: 1.7
> >  ##
> >  { 'enum': 'JobType',
> > -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
> > +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
> > +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
> >  
> >  ##
> >  # @JobStatus:
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 5f6b06172c..d70f627b77 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1720,3 +1720,138 @@
> >  ##
> >  { 'event': 'UNPLUG_PRIMARY',
> >    'data': { 'device-id': 'str' } }
> > +
> > +##
> > +# @snapshot-save:
> > +#
> > +# Save a VM snapshot
> > +#
> > +# @job-id: identifier for the newly created job
> > +# @tag: name of the snapshot to create. If it already
> > +# exists it will be replaced.
> 
> Sounds a bit dangerous.  Require a force flag for such an overwrite?
> Not sure.

Yes, replacing is quite likely to be a mistake.

"@force" could mean many things, so "replace-existing: bool" is
probably a clearer name.

> 
> > +# @devices: list of block device node names to save a snapshot to
> > +# @vmstate: block device node name to save vmstate to
> 
> Worth mentioning that omitting writable block devices is probably a bad
> idea?

Sure

> > +#
> > +# Applications should not assume that the snapshot save is complete
> > +# when this command returns.
> 
> Is it complete then with the current code?  I'm asking because such
> properties have a way to sneakily become de facto ABI.  We may not be
> able to do anything about that now, other than documenting "don't do
> that" like you did, but I'd like to understand the state of affairs all
> the same.

Yes, the actual snapshot is synchronous with return of the command.

> 
> > +#                            Completion is indicated by the job
> > +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
> > +# job aborts, errors can be obtained via the 'query-jobs' command,
> > +# though.
> 
> Sure we want to these job basics here?

This ties in with the previous point. If feel if we don't document
the use of events here, then people are likely to blindly assume
synchronous completion. By explicitly telling them to wait for the
JOB_STATUS_CHANGE they are nudged towards a correct solution that
won't break if it becomes async later.

> 
> > +#         Note that at this time most vmstate procssing errors only
> 
> Typo: processing
> 
> Whatever a "vmstate processing error" is...
> 
> > +# get printed to stderr. This limitation will be fixed at a future
> > +# date.
> 
> Is that a promise?  ;)

I don't know when I'll have time, as I've not looked at just how
complex the conversion is. It is *highly* desirable to fix this
otherwise debugging failures is an exercise in extreme pain through
lack of useful information.

> 
> > +#
> > +# Note that the VM CPUs will be paused during the time it takes to
> > +# save the snapshot
> 
> End the sentence with a period, please.
> 
> > +#
> > +# If @devices is not specified, or is an empty list, then the
> > +# historical default logic for picking devices will be used.
> 
> Why is this useful for QMP?
> 
> > +#
> > +# If @vmstate is not specified, then the first valid block
> > +# device will be used for vmstate.
> 
> Why is this useful for QMP?

Both of these makes QEMU just "do the right thing" with the majority
of QEMU guest configurations with no special knowledge needed by
the mgmt app.

It makes it possible for all existing apps to immediately stop using
the loadvm/savevm commands via HMP passthrough, and convert to the
QMP commands.

Without this, applications will need to first convert to use -blockdev
before they can use the load-snapshot/save-snapshot commands, because
the devices are specified exclusively using blockdev node names, not
the legacy drive IDs. I didn't want to make blockdev a mandatory
dependancy unless apps want to opt-in to the fine grained control
over disk choices


> > +##
> > +# @snapshot-load:
> > +#
> > +# Load a VM snapshot
> > +#
> > +# @job-id: identifier for the newly created job
> > +# @tag: name of the snapshot to load.
> > +# @devices: list of block device node names to load a snapshot from
> > +# @vmstate: block device node name to load vmstate from
> 
> Worth mentioning that omitting block devices that may have changed since
> the save is probably a bad idea?

Yep.

> 
> > +#
> > +# Applications should not assume that the snapshot load is complete
> > +# when this command returns. Completion is indicated by the job
> > +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
> > +# job aborts, errors can be obtained via the 'query-jobs' command,
> > +# though. Note that at this time most vmstate procssing errors only
> > +# get printed to stderr. This limitation will be fixed at a future
> > +# date.
> 
> Comments on snapshot-load apply.
> 
> > +#
> > +# If @devices is not specified, or is an empty list, then the
> > +# historical default logic for picking devices will be used.
> 
> Why is this useful for QMP?
> 
> > +#
> > +# If @vmstate is not specified, then the first valid block
> > +# device will be used for vmstate.
> 
> Why is this useful for QMP?
> 
> A more useful default could be "if exactly one the block devices being
> restored contains a vmstate, use that".

I feel it is more important to be symetric with save-snapshot.  ie if you
supply or omit the same args for save-snapshot and load-snapshot, you
know both will work, or neither will work. You dont get into a situation
where you can succesfully save the snapshot, but not restore it.


> > +##
> > +# @snapshot-delete:
> > +#
> > +# Delete a VM snapshot
> > +#
> > +# @job-id: identifier for the newly created job
> > +# @tag: name of the snapshot to delete.
> > +# @devices: list of block device node names to delete a snapshot from
> > +#
> > +# Applications should not assume that the snapshot load is complete
> > +# when this command returns. Completion is indicated by the job
> > +# status. Clients can wait for the JOB_STATUS_CHANGE event.
> 
> Comments on snapshot-load apply.
> 
> One difference: no "If the job aborts, ..."  Intentional?

I guess it can abort if the file is corrupt perhaps. Generally
thogh if the named snapshot doesnt exist in the block device, it
is considered success, not an error.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


