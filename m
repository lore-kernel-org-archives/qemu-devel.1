Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F177E20767
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aen2gWus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F177E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmK1-000794-PK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDmJJ-0006PA-Nu
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:17:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kDmJH-0006nc-2c
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599128256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I7yJ3YgT7JNMRs2hXdfIEzICKa+5o3dY+T3VIutHwfg=;
 b=Aen2gWusQrKhTeqN7XfiJIgysp86Nkvd4PxG/Yy5pGJ1F6whZ6iRe4bJzddURg2fWzbCqY
 KNwY9lMu9qxOBKjfKsB4KcrDwRMeF+91//2xX3XiTsIUMoO4baRwXFgof0gVktHKaG6AMa
 brtD6AeXV15lefiU8Pyz+VKlwvm1QnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-SmVXLapNNx-fO_-ij66Vqw-1; Thu, 03 Sep 2020 06:17:34 -0400
X-MC-Unique: SmVXLapNNx-fO_-ij66Vqw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19C3910ABDB1;
 Thu,  3 Sep 2020 10:17:33 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-183.ams2.redhat.com [10.36.114.183])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAC8F5D9CC;
 Thu,  3 Sep 2020 10:17:30 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:17:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
Message-ID: <20200903101729.GA8835@linux.fritz.box>
References: <20200827111606.1408275-1-berrange@redhat.com>
 <20200827111606.1408275-8-berrange@redhat.com>
 <87d035tw74.fsf@dusky.pond.sub.org>
 <20200901164732.GZ345480@redhat.com>
 <873640msui.fsf@dusky.pond.sub.org>
 <20200902110554.GF403297@redhat.com>
 <87blinp4xa.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87blinp4xa.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2020 um 11:48 hat Markus Armbruster geschrieben:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Sep 02, 2020 at 11:27:17AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Tue, Sep 01, 2020 at 04:20:47PM +0200, Markus Armbruster wrote:
> >> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> >> 
> >> >> > savevm, loadvm and delvm are some of the few HMP commands that have never
> >> >> > been converted to use QMP. The primary reason for this lack of conversion
> >> >> > is that they block execution of the thread for as long as they run.
> >> >> 
> >> >> Nope.  The primary reason is that the HMP interface is bonkers.
> >> >
> >> > I don't think that's very helpful description. The HMP interface has
> >> > some limitations, but it isn't bonkers - it just doesn't cope with
> >> > all the use cases we want. Many people use it succesfully without
> >> > issue
> >> 
> >> It's non-bonkers for the case it was designed for: one disk backed by
> >> QCOW2, plus maybe a CD-ROM.  The user is responsible for ensuring the
> >> CD-ROM's media at loadvm time matches the one at savevm time.  The user
> >> is further responsible for ensuring the guest-visible configuration
> >> matches the one at savevm time.  No worse than migration.
> >
> > It is fine for multiple writable disks too, if they're all qcow2 backed.
> >
> >> It becomes useless as soon as you have writable non-QCOW2 block devices.
> >> "Stop machine, take external snapshots, savevm, restart machine" should
> >> work, but doesn't.

This is because savevm can't snapshot all writable disks and fails in
this case, right? So the proposed alternative with a list of nodes to
create disk snapshots for would solve this.

> > External snapshots can be made to work today if you're willing to pause
> > the VM CPUs while you take the external snapshots, and run the migration
> > to capture VM state.
> 
> Yes.
> 
> Pausing is necessary because we don't have a way to take snapshots when
> migration completes.
> 
> Even if we had it, live migration to file would be a problematic way to
> capture VM state, because it doesn't update changing state in place.

It's also not the semantics you usally want for snapshots. You want to
take a snapshot of the state _now_, not of the state at some arbitrary
time in the future.

That's why I mentioned the post-copy semantics for live snapshots.

> savevm is not live either, of course.
> 
> My point is that savevm is "QCOW2 or bust" unnecessarily.  Your
> proposed QMP interface isn't.

Strictly speaking, not qcow2, but "block driver that supports
snapshots". Not that it matters in practice, but this happens to include
sheepdog.

It also means that we could implement a filter driver that saves the VM
state to an external file, which would allow saving the VM state even if
you use only raw images (of course, only useful if you have means to
snapshot the disk state externally or in combination with external
snapshots).

> > If you want to see some examples, take a look at the very last patch
> > in the series which introduces I/O test 310. The test covers various
> > success and failure scenarios, so you can see the behaviour we are
> > currently generating with this series.
> >
> >
> >> >> > +#
> >> >> > +# If @vmstate is not specified, then the first valid block
> >> >> > +# device will be used for vmstate.
> >> >> 
> >> >> Why is this useful for QMP?
> >> >
> >> > Both of these makes QEMU just "do the right thing" with the majority
> >> > of QEMU guest configurations with no special knowledge needed by
> >> > the mgmt app.
> >> >
> >> > It makes it possible for all existing apps to immediately stop using
> >> > the loadvm/savevm commands via HMP passthrough, and convert to the
> >> > QMP commands.
> >> 
> >> I appreciate your concern for easy migration from HMP savevm/loadvm to
> >> QMP.  I'm unwilling to permanently screw up the QMP interface for it,
> >> though.
> >> 
> >> > Without this, applications will need to first convert to use -blockdev
> >> > before they can use the load-snapshot/save-snapshot commands, because
> >> > the devices are specified exclusively using blockdev node names, not
> >> > the legacy drive IDs.
> >> 
> >> Not true.  *Every* block node has a node name.  If the user doesn't
> >> specify one, the system makes one up.  query-named-block-nodes shows
> >> it.  So does query-block.
> >
> > query-named-block-nodes isn't friendly as a way to lookup node names,
> > as it doesn't include the "id" value for the original -drive, so
> > correlating block nodes to drives is not straightforward.  query-block
> > does seem a bit better in respect.
> >
> > So if an app is currently using loadvm/savevm with human_monitor_command,
> > and is using -drive, they have to go through a mapping process to figure
> > out node names. Not especially friendly if they were happy with the
> > current choice of disks QEMU makes by default. 
> 
> I take "not especially friendly to clients converting from (bonkers) HMP
> commands" over "similarly bonkers" any day.  Okay, I'm exaggerating for
> effect, your proposed interface is much better even with this default.
> I do hate this default, though.
> 
> QMP is (meant to be) explicit and non-magic.
> 
> If having to map from drive ID to node-name really is too much of a
> burden, we can look for ways to make it easier, or we can make savem
> optionally accept drive IDs instead of node-names, like we do in several
> other places for backward compatibility.

Yes, letting commands accept both node-names and drive IDs is trivial
and we do it pretty much everywhere. Much better than randomly selecting
an image to save the VM state to.

But I'm not even sure if makign people switch to -blockdev would be a
bad thing. If they insist on bad interfaces, they can keep using HMP
'savevm', too...

Kevin


