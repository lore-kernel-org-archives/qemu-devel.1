Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9EEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47FF62072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1w42fLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FF62072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDP3j-0008WU-Eh
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDP38-0007zQ-Nl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:27:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30750
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDP35-0003zh-FA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599038842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x19Vq7teU7ixNL3zXNW3G3tHzQoqF+XZNIVcBHIlLfo=;
 b=X1w42fLqSijDYpvTvnN9PgSEnsEX8+3P6fLl6uYE+IIfc72kqCUha6hcOJGnfT7w5Ynid9
 KE0AN2Hlph/OKOzPrSgp/dBz5gbvaaZ1F2I5QSBNW78ocsNvNjMY5If7Js7+YHP9cCqfeR
 4DV3pHaQqWpe4bmTLMhvnLv+SjuS//M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-nbVqJ_OHMB6YCxnCula3nA-1; Wed, 02 Sep 2020 05:27:20 -0400
X-MC-Unique: nbVqJ_OHMB6YCxnCula3nA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546111074646;
 Wed,  2 Sep 2020 09:27:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D524D78B3E;
 Wed,  2 Sep 2020 09:27:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 527C9113C418; Wed,  2 Sep 2020 11:27:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
 <87d035tw74.fsf@dusky.pond.sub.org>
 <20200901164732.GZ345480@redhat.com>
Date: Wed, 02 Sep 2020 11:27:17 +0200
In-Reply-To: <20200901164732.GZ345480@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Tue, 1 Sep 2020 17:47:32 +0100")
Message-ID: <873640msui.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:26:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 01, 2020 at 04:20:47PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > savevm, loadvm and delvm are some of the few HMP commands that have ne=
ver
>> > been converted to use QMP. The primary reason for this lack of convers=
ion
>> > is that they block execution of the thread for as long as they run.
>>=20
>> Nope.  The primary reason is that the HMP interface is bonkers.
>
> I don't think that's very helpful description. The HMP interface has
> some limitations, but it isn't bonkers - it just doesn't cope with
> all the use cases we want. Many people use it succesfully without
> issue

It's non-bonkers for the case it was designed for: one disk backed by
QCOW2, plus maybe a CD-ROM.  The user is responsible for ensuring the
CD-ROM's media at loadvm time matches the one at savevm time.  The user
is further responsible for ensuring the guest-visible configuration
matches the one at savevm time.  No worse than migration.

It becomes useless as soon as you have writable non-QCOW2 block devices.
"Stop machine, take external snapshots, savevm, restart machine" should
work, but doesn't.

It becomes bonkers as soon as you have more than one QCOW2: which one
receives the system state?  It depends on the order in which they got
configured or some craziness like that.  Undocumented of course.

But "bonkers" is opinion, and we don't have to agree on opinions, only
on facts.

Fact: I did not reject attempts to bring savevm & friends to QMP because
they block.  I'm not rejecting your attempt because they block.

Fact: I did reject attempts because I considered their QMP interface
bonkers.  I do not consider your proposed interface bonkers (some
defaults I find dubious, but I'm sure we'll figure out what to do
there).

Therefore, the commit message's claim "the primary reason for this lack
of conversion is that they block execution of the thread for as long as
they run" is factually wrong.

If you'd rather not write "because they are bonkers", that's fine; I'm
confident we can find phrasing you like that is also correct.

>> > Despite this downside, however, libvirt and applications using libvirt
>> > have used these commands for as long as QMP has existed, via the
>> > "human-monitor-command" passthrough command. IOW, while it is clearly
>> > desirable to be able to fix the blocking problem, this is not an
>> > immediate obstacle to real world usage.
>> >
>> > Meanwhile there is a need for other features which involve adding new
>> > parameters to the commands. This is possible with HMP passthrough, but
>> > it provides no reliable way for apps to introspect features, so using
>> > QAPI modelling is highly desirable.
>> >
>> > This patch thus introduces new snapshot-{load,save,delete} commands to
>> > QMP that are intended to replace the old HMP counterparts. The new
>> > commands are given different names, because they will be using the new
>> > QEMU job framework and thus will have diverging behaviour from the HMP
>> > originals. It would thus be misleading to keep the same name.
>> >
>> > While this design uses the generic job framework, the current impl is
>> > still blocking. The intention that the blocking problem is fixed later=
.
>> > None the less applications using these new commands should assume that
>> > they are asynchronous and thus wait for the job status change event to
>> > indicate completion.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> [...]
>> > diff --git a/qapi/job.json b/qapi/job.json
>> > index 280c2f76f1..51bee470f0 100644
>> > --- a/qapi/job.json
>> > +++ b/qapi/job.json
>> > @@ -22,10 +22,17 @@
>> >  #
>> >  # @amend: image options amend job type, see "x-blockdev-amend" (since=
 5.1)
>> >  #
>> > +# @snapshot-load: snapshot load job type, see "loadvm" (since 5.2)
>>=20
>> Do you mean 'see command @snapshot-load?
>
> Yes, I guess so.

Please write it that way then.

>> > +#
>> > +# @snapshot-save: snapshot save job type, see "savevm" (since 5.2)
>>=20
>> @snapshot-save?
>>=20
>> > +#
>> > +# @snapshot-delete: snapshot delete job type, see "delvm" (since 5.2)
>>=20
>> @snapshot-delete?
>>=20
>> > +#
>> >  # Since: 1.7
>> >  ##
>> >  { 'enum': 'JobType',
>> > -  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend']=
 }
>> > +  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
>> > +           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
>> > =20
>> >  ##
>> >  # @JobStatus:
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 5f6b06172c..d70f627b77 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1720,3 +1720,138 @@
>> >  ##
>> >  { 'event': 'UNPLUG_PRIMARY',
>> >    'data': { 'device-id': 'str' } }
>> > +
>> > +##
>> > +# @snapshot-save:
>> > +#
>> > +# Save a VM snapshot
>> > +#
>> > +# @job-id: identifier for the newly created job
>> > +# @tag: name of the snapshot to create. If it already
>> > +# exists it will be replaced.
>>=20
>> Sounds a bit dangerous.  Require a force flag for such an overwrite?
>> Not sure.
>
> Yes, replacing is quite likely to be a mistake.
>
> "@force" could mean many things, so "replace-existing: bool" is
> probably a clearer name.

Yes.

>> > +# @devices: list of block device node names to save a snapshot to
>> > +# @vmstate: block device node name to save vmstate to
>>=20
>> Worth mentioning that omitting writable block devices is probably a bad
>> idea?
>
> Sure
>
>> > +#
>> > +# Applications should not assume that the snapshot save is complete
>> > +# when this command returns.
>>=20
>> Is it complete then with the current code?  I'm asking because such
>> properties have a way to sneakily become de facto ABI.  We may not be
>> able to do anything about that now, other than documenting "don't do
>> that" like you did, but I'd like to understand the state of affairs all
>> the same.
>
> Yes, the actual snapshot is synchronous with return of the command.

Are there any failure modes where the command succeeds, and query-jobs
shows the error?
>
>>=20
>> > +#                            Completion is indicated by the job
>> > +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
>> > +# job aborts, errors can be obtained via the 'query-jobs' command,
>> > +# though.
>>=20
>> Sure we want to these job basics here?
>
> This ties in with the previous point. If feel if we don't document
> the use of events here, then people are likely to blindly assume
> synchronous completion. By explicitly telling them to wait for the
> JOB_STATUS_CHANGE they are nudged towards a correct solution that
> won't break if it becomes async later.

No objection.

>>=20
>> > +#         Note that at this time most vmstate procssing errors only
>>=20
>> Typo: processing
>>=20
>> Whatever a "vmstate processing error" is...
>>=20
>> > +# get printed to stderr. This limitation will be fixed at a future
>> > +# date.
>>=20
>> Is that a promise?  ;)
>
> I don't know when I'll have time, as I've not looked at just how
> complex the conversion is. It is *highly* desirable to fix this
> otherwise debugging failures is an exercise in extreme pain through
> lack of useful information.
>
>>=20
>> > +#
>> > +# Note that the VM CPUs will be paused during the time it takes to
>> > +# save the snapshot
>>=20
>> End the sentence with a period, please.
>>=20
>> > +#
>> > +# If @devices is not specified, or is an empty list, then the
>> > +# historical default logic for picking devices will be used.
>>=20
>> Why is this useful for QMP?
>>=20
>> > +#
>> > +# If @vmstate is not specified, then the first valid block
>> > +# device will be used for vmstate.
>>=20
>> Why is this useful for QMP?
>
> Both of these makes QEMU just "do the right thing" with the majority
> of QEMU guest configurations with no special knowledge needed by
> the mgmt app.
>
> It makes it possible for all existing apps to immediately stop using
> the loadvm/savevm commands via HMP passthrough, and convert to the
> QMP commands.

I appreciate your concern for easy migration from HMP savevm/loadvm to
QMP.  I'm unwilling to permanently screw up the QMP interface for it,
though.

> Without this, applications will need to first convert to use -blockdev
> before they can use the load-snapshot/save-snapshot commands, because
> the devices are specified exclusively using blockdev node names, not
> the legacy drive IDs.

Not true.  *Every* block node has a node name.  If the user doesn't
specify one, the system makes one up.  query-named-block-nodes shows
it.  So does query-block.

>                       I didn't want to make blockdev a mandatory
> dependancy unless apps want to opt-in to the fine grained control
> over disk choices

I guess I could accept defaulting @devices to all capable ones.  That's
what the "historical default logic for picking devices" does.  The
documentation should be improved to actually explain what the default
does, though.

I object to defaulting @vmstate to "first valid block device".  I don't
think requiring applications be explicit on where the vmstate needs to
go is too much of a burden.  If you assure me it is, I'll reconsider.

>> > +##
>> > +# @snapshot-load:
>> > +#
>> > +# Load a VM snapshot
>> > +#
>> > +# @job-id: identifier for the newly created job
>> > +# @tag: name of the snapshot to load.
>> > +# @devices: list of block device node names to load a snapshot from
>> > +# @vmstate: block device node name to load vmstate from
>>=20
>> Worth mentioning that omitting block devices that may have changed since
>> the save is probably a bad idea?
>
> Yep.
>
>>=20
>> > +#
>> > +# Applications should not assume that the snapshot load is complete
>> > +# when this command returns. Completion is indicated by the job
>> > +# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
>> > +# job aborts, errors can be obtained via the 'query-jobs' command,
>> > +# though. Note that at this time most vmstate procssing errors only
>> > +# get printed to stderr. This limitation will be fixed at a future
>> > +# date.
>>=20
>> Comments on snapshot-load apply.
>>=20
>> > +#
>> > +# If @devices is not specified, or is an empty list, then the
>> > +# historical default logic for picking devices will be used.
>>=20
>> Why is this useful for QMP?
>>=20
>> > +#
>> > +# If @vmstate is not specified, then the first valid block
>> > +# device will be used for vmstate.
>>=20
>> Why is this useful for QMP?
>>=20
>> A more useful default could be "if exactly one the block devices being
>> restored contains a vmstate, use that".
>
> I feel it is more important to be symetric with save-snapshot.  ie if you
> supply or omit the same args for save-snapshot and load-snapshot, you
> know both will work, or neither will work. You dont get into a situation
> where you can succesfully save the snapshot, but not restore it.

For a value of "successful".

loadvm is unsafe unless guest-visible configuration and block device
contents match.

loadvm can make block device contents match for the block devices that
were snapshot by savevm.  For any others, it's the user's
responsibility.

If you have the exact same set of QCOW2 as you had at savevm time, and
didn't mess them up meanwhile, then exactly one of them has the vmstate
named @tag.  This is the sane way to use savem/loadvm.

But you can also use it in other ways, and some of them even work.

If you remove QCOW2s other than the one holding the vmstate from the
set, you still got exactly one vmstate.  Aside: for safe loadvm, you
must replace these QCOW2s, and their replacements must provide the same
contents.

If you remove the one holding the vmstate, you got exactly no vmstate,
and loadvm won't work regardless of default.  D'oh!

If you add QCOW2s that don't have a vmstate named @tag, you still got
exactly one vmstate.  Aside: for safe loadvm, these guys must replace
non-QCOW2s, and they must provide the same contents.  Guests are more
likely to survive sneak addition of hardware than sneak removal,
however.

If you add QCOW2s that have a vmstage named @tag, you got multiple
vmstates.  This is the only situation where your lax "default to first
vmstate found, else error" makes loadvm "work" where "default to the
only vmstate if is exactly one, else error" doesn't.

In my opinion, having the system silently pick one of the multiple
vmstates named @tag is as dangerous as it is unhelpful.  Even if you can
"control" the pick by ordering your command line and / or monitor
commands the right way.

>> > +##
>> > +# @snapshot-delete:
>> > +#
>> > +# Delete a VM snapshot
>> > +#
>> > +# @job-id: identifier for the newly created job
>> > +# @tag: name of the snapshot to delete.
>> > +# @devices: list of block device node names to delete a snapshot from
>> > +#
>> > +# Applications should not assume that the snapshot load is complete
>> > +# when this command returns. Completion is indicated by the job
>> > +# status. Clients can wait for the JOB_STATUS_CHANGE event.
>>=20
>> Comments on snapshot-load apply.
>>=20
>> One difference: no "If the job aborts, ..."  Intentional?
>
> I guess it can abort if the file is corrupt perhaps. Generally
> thogh if the named snapshot doesnt exist in the block device, it
> is considered success, not an error.

I'd keep the "applications should" admonishments exactly the same for
all three commands.  Suggestion, not demand.


