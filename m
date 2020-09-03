Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68142C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0683A207EA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNVV6Cyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683A207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDlrK-0002yr-Qm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDlqm-0002S5-7B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kDlqh-000340-Fq
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 05:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599126486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qc1GZxGg5nL1Q8exnFuAmvxtOfFHp09I65f6LHjcfow=;
 b=UNVV6CyiiFaoQuPwGxr2NVk0jpB5vkGMrf8nVOvY39EzFK83qd/3Mg10sCts7oCH7H9sTD
 YoPFxWus+DINyx0JLGffX96HbkJx0sUs/I9W66HRMxfg9qtJuWj5LAtB3W2D0Csgu06AUT
 TjYCSOZ2dWXieBAlLKO8KxtrZixS6+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-d5BvfwjIPMaSY24H7dL78A-1; Thu, 03 Sep 2020 05:48:04 -0400
X-MC-Unique: d5BvfwjIPMaSY24H7dL78A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4042D18A226B;
 Thu,  3 Sep 2020 09:48:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE70B7EEC5;
 Thu,  3 Sep 2020 09:48:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44D61113865F; Thu,  3 Sep 2020 11:48:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
 <87d035tw74.fsf@dusky.pond.sub.org>
 <20200901164732.GZ345480@redhat.com>
 <873640msui.fsf@dusky.pond.sub.org>
 <20200902110554.GF403297@redhat.com>
Date: Thu, 03 Sep 2020 11:48:01 +0200
In-Reply-To: <20200902110554.GF403297@redhat.com> ("Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9=22's?=
 message of "Wed, 2 Sep 2020 12:05:54 +0100")
Message-ID: <87blinp4xa.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 02, 2020 at 11:27:17AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Sep 01, 2020 at 04:20:47PM +0200, Markus Armbruster wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >>=20
>> >> > savevm, loadvm and delvm are some of the few HMP commands that have=
 never
>> >> > been converted to use QMP. The primary reason for this lack of conv=
ersion
>> >> > is that they block execution of the thread for as long as they run.
>> >>=20
>> >> Nope.  The primary reason is that the HMP interface is bonkers.
>> >
>> > I don't think that's very helpful description. The HMP interface has
>> > some limitations, but it isn't bonkers - it just doesn't cope with
>> > all the use cases we want. Many people use it succesfully without
>> > issue
>>=20
>> It's non-bonkers for the case it was designed for: one disk backed by
>> QCOW2, plus maybe a CD-ROM.  The user is responsible for ensuring the
>> CD-ROM's media at loadvm time matches the one at savevm time.  The user
>> is further responsible for ensuring the guest-visible configuration
>> matches the one at savevm time.  No worse than migration.
>
> It is fine for multiple writable disks too, if they're all qcow2 backed.
>
>> It becomes useless as soon as you have writable non-QCOW2 block devices.
>> "Stop machine, take external snapshots, savevm, restart machine" should
>> work, but doesn't.
>
> External snapshots can be made to work today if you're willing to pause
> the VM CPUs while you take the external snapshots, and run the migration
> to capture VM state.

Yes.

Pausing is necessary because we don't have a way to take snapshots when
migration completes.

Even if we had it, live migration to file would be a problematic way to
capture VM state, because it doesn't update changing state in place.

savevm is not live either, of course.

My point is that savevm is "QCOW2 or bust" unnecessarily.  Your proposed
QMP interface isn't.

>                      The main reason apps like Boxes / Virt-manager don't
> use external snapshots is that they require more complicated decision
> making. For each type of storage you're dealing with you have a potential=
ly
> different way to manage the external snapshot. Boxes took the view that i=
t
> would only support qcow2 to avoid making those decisions. virt-manager ha=
s
> support for all types of storage and simply doesn't want to add the compl=
ex
> logic to deal with non-qcow2.=20
>
>> It becomes bonkers as soon as you have more than one QCOW2: which one
>> receives the system state?  It depends on the order in which they got
>> configured or some craziness like that.  Undocumented of course.
>
> Saying it is the first configured disk was not that crazy. This has been
> a pretty well defined semantic historically, as disks are usually added
> to QEMU in a predictable order, because that in turn controls how QEMU
> assigns addresses, and thus the order in which guest OS detect them.
>
> The introduction of use of the block layer for UEFI storage really
> threw a spanner in the works from QEMU's side. Even then the semantics
> aren't bad from a app's POV - first disk is still well defined as a
> concept, as UEFI vars isn't really considered a disk from an app POV.
>
>> Therefore, the commit message's claim "the primary reason for this lack
>> of conversion is that they block execution of the thread for as long as
>> they run" is factually wrong.
>
> That part of the commit message is referring to the original reason for
> not porting loadvm/savevm when QMP was first created 10+ years ago, which
> was primarily due to its blocking nature. The issues around disk selectio=
n
> post-date that. I'll modify it to describe both issues
>
>
>> >> > +#
>> >> > +# Applications should not assume that the snapshot save is complet=
e
>> >> > +# when this command returns.
>> >>=20
>> >> Is it complete then with the current code?  I'm asking because such
>> >> properties have a way to sneakily become de facto ABI.  We may not be
>> >> able to do anything about that now, other than documenting "don't do
>> >> that" like you did, but I'd like to understand the state of affairs a=
ll
>> >> the same.
>> >
>> > Yes, the actual snapshot is synchronous with return of the command.
>>=20
>> Are there any failure modes where the command succeeds, and query-jobs
>> shows the error?
>
> As implemented in this series, the commands always succeed with the
> errors only ever reported via query-jobs. So for error detection
> you are already forced to use  the job framework.

This is what I hoped for when I asked.  It makes misuse of the interface
unlikely to survive basic testing.  Pretty much eliminates the risk of
misuse becoming de facto ABI over time.

> If you want to see some examples, take a look at the very last patch
> in the series which introduces I/O test 310. The test covers various
> success and failure scenarios, so you can see the behaviour we are
> currently generating with this series.
>
>
>> >> > +#
>> >> > +# If @vmstate is not specified, then the first valid block
>> >> > +# device will be used for vmstate.
>> >>=20
>> >> Why is this useful for QMP?
>> >
>> > Both of these makes QEMU just "do the right thing" with the majority
>> > of QEMU guest configurations with no special knowledge needed by
>> > the mgmt app.
>> >
>> > It makes it possible for all existing apps to immediately stop using
>> > the loadvm/savevm commands via HMP passthrough, and convert to the
>> > QMP commands.
>>=20
>> I appreciate your concern for easy migration from HMP savevm/loadvm to
>> QMP.  I'm unwilling to permanently screw up the QMP interface for it,
>> though.
>>=20
>> > Without this, applications will need to first convert to use -blockdev
>> > before they can use the load-snapshot/save-snapshot commands, because
>> > the devices are specified exclusively using blockdev node names, not
>> > the legacy drive IDs.
>>=20
>> Not true.  *Every* block node has a node name.  If the user doesn't
>> specify one, the system makes one up.  query-named-block-nodes shows
>> it.  So does query-block.
>
> query-named-block-nodes isn't friendly as a way to lookup node names,
> as it doesn't include the "id" value for the original -drive, so
> correlating block nodes to drives is not straightforward.  query-block
> does seem a bit better in respect.
>
> So if an app is currently using loadvm/savevm with human_monitor_command,
> and is using -drive, they have to go through a mapping process to figure
> out node names. Not especially friendly if they were happy with the
> current choice of disks QEMU makes by default.=20

I take "not especially friendly to clients converting from (bonkers) HMP
commands" over "similarly bonkers" any day.  Okay, I'm exaggerating for
effect, your proposed interface is much better even with this default.
I do hate this default, though.

QMP is (meant to be) explicit and non-magic.

If having to map from drive ID to node-name really is too much of a
burden, we can look for ways to make it easier, or we can make savem
optionally accept drive IDs instead of node-names, like we do in several
other places for backward compatibility.

>> >                       I didn't want to make blockdev a mandatory
>> > dependancy unless apps want to opt-in to the fine grained control
>> > over disk choices
>>=20
>> I guess I could accept defaulting @devices to all capable ones.  That's
>> what the "historical default logic for picking devices" does.  The

Correction: to all writable ones.

>> documentation should be improved to actually explain what the default
>> does, though.
>>=20
>> I object to defaulting @vmstate to "first valid block device".  I don't
>> think requiring applications be explicit on where the vmstate needs to
>> go is too much of a burden.  If you assure me it is, I'll reconsider.
>
> Both parameters have the same issue wrt needing to have the blockdev
> node names. So once you have to specify one parameter, you might as
> well specify both. IOW, either we make both optional with defaults, or
> both mandatory with no default. I don't think it makes sense to mix.
>
>
>> >> > +#
>> >> > +# If @devices is not specified, or is an empty list, then the
>> >> > +# historical default logic for picking devices will be used.
>> >>=20
>> >> Why is this useful for QMP?
>> >>=20
>> >> > +#
>> >> > +# If @vmstate is not specified, then the first valid block
>> >> > +# device will be used for vmstate.
>> >>=20
>> >> Why is this useful for QMP?
>> >>=20
>> >> A more useful default could be "if exactly one the block devices bein=
g
>> >> restored contains a vmstate, use that".
>> >
>> > I feel it is more important to be symetric with save-snapshot.  ie if =
you
>> > supply or omit the same args for save-snapshot and load-snapshot, you
>> > know both will work, or neither will work. You dont get into a situati=
on
>> > where you can succesfully save the snapshot, but not restore it.
>>=20
>> For a value of "successful".
>>=20
>> loadvm is unsafe unless guest-visible configuration and block device
>> contents match.
>>=20
>> loadvm can make block device contents match for the block devices that
>> were snapshot by savevm.  For any others, it's the user's
>> responsibility.
>
> Yep, this is likely another thing that should be documented for the QMP
> commands. The VM frontend config must be identical across load/save
> otherwise VM state will fail to restore. DIsk backends should be the
> same too unless you're specifying an explicit list of node names.

Yes, please.

>> If you have the exact same set of QCOW2 as you had at savevm time, and
>> didn't mess them up meanwhile, then exactly one of them has the vmstate
>> named @tag.  This is the sane way to use savem/loadvm.
>
> Yep.
>
>> But you can also use it in other ways, and some of them even work.
>>=20
>> If you remove QCOW2s other than the one holding the vmstate from the
>> set, you still got exactly one vmstate.  Aside: for safe loadvm, you
>> must replace these QCOW2s, and their replacements must provide the same
>> contents.
>>=20
>> If you remove the one holding the vmstate, you got exactly no vmstate,
>> and loadvm won't work regardless of default.  D'oh!
>>=20
>> If you add QCOW2s that don't have a vmstate named @tag, you still got
>> exactly one vmstate.  Aside: for safe loadvm, these guys must replace
>> non-QCOW2s, and they must provide the same contents.  Guests are more
>> likely to survive sneak addition of hardware than sneak removal,
>> however.
>>=20
>> If you add QCOW2s that have a vmstage named @tag, you got multiple
>> vmstates.  This is the only situation where your lax "default to first
>> vmstate found, else error" makes loadvm "work" where "default to the
>> only vmstate if is exactly one, else error" doesn't.
>>=20
>> In my opinion, having the system silently pick one of the multiple
>> vmstates named @tag is as dangerous as it is unhelpful.  Even if you can
>> "control" the pick by ordering your command line and / or monitor
>> commands the right way.
>
> I think it would be reasonable to make the existance of multiple
> vmstates on different disks be a hard error both for QMP and for
> the existing HMP commands, if not specifying an explicit device,
> as its almostly certainly a admin/mgmt app screw up.=20

I consider this a no-brainer for QMP.  If you somehow manage to get
yourself into a situation where you have multiple VM states, and need to
use one of them, you can ask explicitly for the one you want.

HMP doesn't let you ask.  Hmm.  I think "no go, resolve the conflict
with QMP or offline" is better than "pray there is a right one, and pray
QEMU picks it", which is what we have now.


