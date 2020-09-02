Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22BBC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F552078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlaN5SRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F552078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDQbz-0001jD-Cr
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDQaq-0008LN-RP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:06:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32825
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDQan-0000nV-I4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599044776;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=omEauztTDzQYwwx2S9luNF00J47sxulejhiU5nrqvkQ=;
 b=hlaN5SRMxkXPK04PUMyiYUuGNP4SE4clnaPU1BgVuDolHJfzt8k6LqeWUJGtApkucxuaWl
 CBXM7YQTlH6mKFJK/gqD0rBgcT4+aKe2Q7TQne8sG6Qcv7p5eNIM7nLIZjAhpJxiw8AByo
 zJ/cVDA4tzEg2ie61+NnEffMB1yq6Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-f_DhLpChPnmG3E6OfnBSyg-1; Wed, 02 Sep 2020 07:06:02 -0400
X-MC-Unique: f_DhLpChPnmG3E6OfnBSyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5698100746C;
 Wed,  2 Sep 2020 11:06:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBF1B10013BD;
 Wed,  2 Sep 2020 11:05:57 +0000 (UTC)
Date: Wed, 2 Sep 2020 12:05:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
Message-ID: <20200902110554.GF403297@redhat.com>
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
 <87d035tw74.fsf@dusky.pond.sub.org>
 <20200901164732.GZ345480@redhat.com>
 <873640msui.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <873640msui.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 02, 2020 at 11:27:17AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, Sep 01, 2020 at 04:20:47PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > savevm, loadvm and delvm are some of the few HMP commands that have never
> >> > been converted to use QMP. The primary reason for this lack of conversion
> >> > is that they block execution of the thread for as long as they run.
> >> 
> >> Nope.  The primary reason is that the HMP interface is bonkers.
> >
> > I don't think that's very helpful description. The HMP interface has
> > some limitations, but it isn't bonkers - it just doesn't cope with
> > all the use cases we want. Many people use it succesfully without
> > issue
> 
> It's non-bonkers for the case it was designed for: one disk backed by
> QCOW2, plus maybe a CD-ROM.  The user is responsible for ensuring the
> CD-ROM's media at loadvm time matches the one at savevm time.  The user
> is further responsible for ensuring the guest-visible configuration
> matches the one at savevm time.  No worse than migration.

It is fine for multiple writable disks too, if they're all qcow2 backed.

> It becomes useless as soon as you have writable non-QCOW2 block devices.
> "Stop machine, take external snapshots, savevm, restart machine" should
> work, but doesn't.

External snapshots can be made to work today if you're willing to pause
the VM CPUs while you take the external snapshots, and run the migration
to capture VM state. The main reason apps like Boxes / Virt-manager don't
use external snapshots is that they require more complicated decision
making. For each type of storage you're dealing with you have a potentially
different way to manage the external snapshot. Boxes took the view that it
would only support qcow2 to avoid making those decisions. virt-manager has
support for all types of storage and simply doesn't want to add the complex
logic to deal with non-qcow2. 

> It becomes bonkers as soon as you have more than one QCOW2: which one
> receives the system state?  It depends on the order in which they got
> configured or some craziness like that.  Undocumented of course.

Saying it is the first configured disk was not that crazy. This has been
a pretty well defined semantic historically, as disks are usually added
to QEMU in a predictable order, because that in turn controls how QEMU
assigns addresses, and thus the order in which guest OS detect them.

The introduction of use of the block layer for UEFI storage really
threw a spanner in the works from QEMU's side. Even then the semantics
aren't bad from a app's POV - first disk is still well defined as a
concept, as UEFI vars isn't really considered a disk from an app POV.

> Therefore, the commit message's claim "the primary reason for this lack
> of conversion is that they block execution of the thread for as long as
> they run" is factually wrong.

That part of the commit message is referring to the original reason for
not porting loadvm/savevm when QMP was first created 10+ years ago, which
was primarily due to its blocking nature. The issues around disk selection
post-date that. I'll modify it to describe both issues


> >> > +#
> >> > +# Applications should not assume that the snapshot save is complete
> >> > +# when this command returns.
> >> 
> >> Is it complete then with the current code?  I'm asking because such
> >> properties have a way to sneakily become de facto ABI.  We may not be
> >> able to do anything about that now, other than documenting "don't do
> >> that" like you did, but I'd like to understand the state of affairs all
> >> the same.
> >
> > Yes, the actual snapshot is synchronous with return of the command.
> 
> Are there any failure modes where the command succeeds, and query-jobs
> shows the error?

As implemented in this series, the commands always succeed with the
errors only ever reported via query-jobs. So for error detection
you are already forced to use  the job framework.

If you want to see some examples, take a look at the very last patch
in the series which introduces I/O test 310. The test covers various
success and failure scenarios, so you can see the behaviour we are
currently generating with this series.


> >> > +#
> >> > +# If @vmstate is not specified, then the first valid block
> >> > +# device will be used for vmstate.
> >> 
> >> Why is this useful for QMP?
> >
> > Both of these makes QEMU just "do the right thing" with the majority
> > of QEMU guest configurations with no special knowledge needed by
> > the mgmt app.
> >
> > It makes it possible for all existing apps to immediately stop using
> > the loadvm/savevm commands via HMP passthrough, and convert to the
> > QMP commands.
> 
> I appreciate your concern for easy migration from HMP savevm/loadvm to
> QMP.  I'm unwilling to permanently screw up the QMP interface for it,
> though.
> 
> > Without this, applications will need to first convert to use -blockdev
> > before they can use the load-snapshot/save-snapshot commands, because
> > the devices are specified exclusively using blockdev node names, not
> > the legacy drive IDs.
> 
> Not true.  *Every* block node has a node name.  If the user doesn't
> specify one, the system makes one up.  query-named-block-nodes shows
> it.  So does query-block.

query-named-block-nodes isn't friendly as a way to lookup node names,
as it doesn't include the "id" value for the original -drive, so
correlating block nodes to drives is not straightforward.  query-block
does seem a bit better in respect.

So if an app is currently using loadvm/savevm with human_monitor_command,
and is using -drive, they have to go through a mapping process to figure
out node names. Not especially friendly if they were happy with the
current choice of disks QEMU makes by default. 

> >                       I didn't want to make blockdev a mandatory
> > dependancy unless apps want to opt-in to the fine grained control
> > over disk choices
> 
> I guess I could accept defaulting @devices to all capable ones.  That's
> what the "historical default logic for picking devices" does.  The
> documentation should be improved to actually explain what the default
> does, though.
> 
> I object to defaulting @vmstate to "first valid block device".  I don't
> think requiring applications be explicit on where the vmstate needs to
> go is too much of a burden.  If you assure me it is, I'll reconsider.

Both parameters have the same issue wrt needing to have the blockdev
node names. So once you have to specify one parameter, you might as
well specify both. IOW, either we make both optional with defaults, or
both mandatory with no default. I don't think it makes sense to mix.


> >> > +#
> >> > +# If @devices is not specified, or is an empty list, then the
> >> > +# historical default logic for picking devices will be used.
> >> 
> >> Why is this useful for QMP?
> >> 
> >> > +#
> >> > +# If @vmstate is not specified, then the first valid block
> >> > +# device will be used for vmstate.
> >> 
> >> Why is this useful for QMP?
> >> 
> >> A more useful default could be "if exactly one the block devices being
> >> restored contains a vmstate, use that".
> >
> > I feel it is more important to be symetric with save-snapshot.  ie if you
> > supply or omit the same args for save-snapshot and load-snapshot, you
> > know both will work, or neither will work. You dont get into a situation
> > where you can succesfully save the snapshot, but not restore it.
> 
> For a value of "successful".
> 
> loadvm is unsafe unless guest-visible configuration and block device
> contents match.
> 
> loadvm can make block device contents match for the block devices that
> were snapshot by savevm.  For any others, it's the user's
> responsibility.

Yep, this is likely another thing that should be documented for the QMP
commands. The VM frontend config must be identical across load/save
otherwise VM state will fail to restore. DIsk backends should be the
same too unless you're specifying an explicit list of node names.

> If you have the exact same set of QCOW2 as you had at savevm time, and
> didn't mess them up meanwhile, then exactly one of them has the vmstate
> named @tag.  This is the sane way to use savem/loadvm.

Yep.

> But you can also use it in other ways, and some of them even work.
> 
> If you remove QCOW2s other than the one holding the vmstate from the
> set, you still got exactly one vmstate.  Aside: for safe loadvm, you
> must replace these QCOW2s, and their replacements must provide the same
> contents.
> 
> If you remove the one holding the vmstate, you got exactly no vmstate,
> and loadvm won't work regardless of default.  D'oh!
> 
> If you add QCOW2s that don't have a vmstate named @tag, you still got
> exactly one vmstate.  Aside: for safe loadvm, these guys must replace
> non-QCOW2s, and they must provide the same contents.  Guests are more
> likely to survive sneak addition of hardware than sneak removal,
> however.
> 
> If you add QCOW2s that have a vmstage named @tag, you got multiple
> vmstates.  This is the only situation where your lax "default to first
> vmstate found, else error" makes loadvm "work" where "default to the
> only vmstate if is exactly one, else error" doesn't.
> 
> In my opinion, having the system silently pick one of the multiple
> vmstates named @tag is as dangerous as it is unhelpful.  Even if you can
> "control" the pick by ordering your command line and / or monitor
> commands the right way.

I think it would be reasonable to make the existance of multiple
vmstates on different disks be a hard error both for QMP and for
the existing HMP commands, if not specifying an explicit device,
as its almostly certainly a admin/mgmt app screw up. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


