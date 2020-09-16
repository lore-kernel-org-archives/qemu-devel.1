Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F3BC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A2922208
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JySLZBeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A2922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVzB-0004l7-74
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIVs6-0004Lc-Fa
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:45:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIVs0-0007bt-Ne
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZ6xbRV1GTtHNDCIw9kuM66RQZbsbxqKTULj56XzQng=;
 b=JySLZBebfmFuwO1dK6Qx2T2opt/OG8rR7HsKgUs9/xnLKYPI6yyEwI5JvylYOk531JPQ3Z
 1Zn6rdsC4lVht2LJOL/eQP2KnMvKES++uvSfu+/oThlAi3eXdKdbLimoPSoeAMqDXr+rcB
 NPFY3+ZYgg8ngJ6BZsJDdxYTB2/ip7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-pjMH5JgoN6uUeG7ENSRRrg-1; Wed, 16 Sep 2020 07:44:59 -0400
X-MC-Unique: pjMH5JgoN6uUeG7ENSRRrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DE6380B702;
 Wed, 16 Sep 2020 11:44:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDC1260CCC;
 Wed, 16 Sep 2020 11:44:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3187D113864A; Wed, 16 Sep 2020 13:44:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 9/9] migration: introduce snapshot-{save, load,
 delete} QMP commands
References: <20200915113523.2520317-1-berrange@redhat.com>
 <20200915113523.2520317-10-berrange@redhat.com>
 <87tuvyt9sf.fsf@dusky.pond.sub.org>
 <20200916082751.GC1535709@redhat.com>
Date: Wed, 16 Sep 2020 13:44:56 +0200
In-Reply-To: <20200916082751.GC1535709@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Wed, 16 Sep 2020 09:27:51 +0100")
Message-ID: <87h7ryoshz.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 06:27:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

> On Wed, Sep 16, 2020 at 10:17:52AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > savevm, loadvm and delvm are some of the few HMP commands that have ne=
ver
>> > been converted to use QMP. The reasons for the lack of conversion are
>> > that they blocked execution of the event thread, and the semantics
>> > around choice of disks were ill-defined.
>> >
>> > Despite this downside, however, libvirt and applications using libvirt
>> > have used these commands for as long as QMP has existed, via the
>> > "human-monitor-command" passthrough command. IOW, while it is clearly
>> > desirable to be able to fix the problems, they are not a blocker to
>> > all real world usage.
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
>> > In addition to using the job framework, the new commands require the
>> > caller to be explicit about all the block device nodes used in the
>> > snapshot operations, with no built-in default heuristics in use.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> [...]
>> > diff --git a/qapi/job.json b/qapi/job.json
>> > index 280c2f76f1..b2cbb4fead 100644
>> > --- a/qapi/job.json
>> > +++ b/qapi/job.json
>> > @@ -22,10 +22,17 @@
>> >  #
>> >  # @amend: image options amend job type, see "x-blockdev-amend" (since=
 5.1)
>> >  #
>> > +# @snapshot-load: snapshot load job type, see "snapshot-load" (since =
5.2)
>> > +#
>> > +# @snapshot-save: snapshot save job type, see "snapshot-save" (since =
5.2)
>> > +#
>> > +# @snapshot-delete: snapshot delete job type, see "snapshot-delete" (=
since 5.2)
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
>> > index 675f70bb67..b584c0be31 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1720,3 +1720,123 @@
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
>> > +# @tag: name of the snapshot to create
>> > +# @devices: list of block device node names to save a snapshot to
>>=20
>> Looks like you dropped the idea to also accept drive IDs.  Is that for
>> good, or would you like to add it later?
>
> I'm still kind of on the fence, but if general opinion is that we should
> accept drive IDs, I'll add it.

I'm fine with accepting only node names.  But unless we're fairly
certain node names will do, we should try to pick an interface that can
be extended to drive IDs painlessly.

> I wonder what the other blockdev-* APIs accept - some consistency between
> APIs is desirable.

The common pattern appears to be

    # Either @device or @node-name must be set but not both.
    #
    # @device: the name of the device to get the image resized
    #
    # @node-name: graph node name to get the image resized (Since 2.0)
    #
    [...]
                '*device': 'str',
                '*node-name': 'str',

For snapshot-save & friends, I can see two reasonably consistent ways:

1. Have two optional lists, must specify exactly one of them.

2. Change the list element from 'str' to a struct with the two optional
members, must specify exactly one.

The second way lets you mix drive IDs and node-names freely.  Do we want
to?

If yes, we can still use a variation of the first way: accept *both*
lists.

Permitting mixing makes it possible to specify the same device twice.
Could be silently accepted, or made a hard error.  Matter of taste.


