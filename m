Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBB8C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8CD20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GyyhkLsj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8CD20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3UW-0002hb-Cw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3TQ-0001NN-4q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43822
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3TM-0003c3-MV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593712687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SzibYZevdk34ih17ejqvkycn1uCmkpE7wIDk9bqvGU8=;
 b=GyyhkLsj4lOwNk2SHRtIWGNiK5wgUTT5RuGK3cH/CDYPt5UWOt5N4gU6KbhWAP5oxiSpcE
 5jB2wR7Gs39iuvf0anSZqiIO9ZRgdZZFForssjPPkTGCnlNjEvqVqyLMWF+NcfOGrTIr7l
 BhP4ccg32ypzp5StKZGV7eJMMjKALtU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-PVZ8zXt6P76Vsyu7ke9uaQ-1; Thu, 02 Jul 2020 13:58:01 -0400
X-MC-Unique: PVZ8zXt6P76Vsyu7ke9uaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185AF802ED4;
 Thu,  2 Jul 2020 17:58:00 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D4D41D1;
 Thu,  2 Jul 2020 17:57:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/6] migration: bring savevm/loadvm/delvm over to QMP
Date: Thu,  2 Jul 2020 18:57:48 +0100
Message-Id: <20200702175754.2211821-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When QMP was first introduced some 10+ years ago now, the snapshot=0D
related commands (savevm/loadvm/delvm) were not converted. This was=0D
primarily because their implementation causes blocking of the thread=0D
running the monitor commands. This was (and still is) considered=0D
undesirable behaviour both in HMP and QMP.=0D
=0D
In theory someone was supposed to fix this flaw at some point in the=0D
past 10 years and bring them into the QMP world. Sadly, thus far it=0D
hasn't happened as people always had more important things to work=0D
on. Enterprise apps were much more interested in external snapshots=0D
than internal snapshots as they have many more features.=0D
=0D
Meanwhile users still want to use internal snapshots as there is=0D
a certainly simplicity in having everything self-contained in one=0D
image, even though it has limitations. Thus the apps that end up=0D
executing the savevm/loadvm/delvm via the "human-monitor-command"=0D
QMP command.=0D
=0D
=0D
IOW, the problematic blocking behaviour that was one of the reasons=0D
for not having savevm/loadvm/delvm in QMP is experienced by applications=0D
regardless. By not portting the commands to QMP due to one design flaw,=0D
we've forced apps and users to suffer from other design flaws of HMP (=0D
bad error reporting, strong type checking of args, no introspection) for=0D
an additional 10 years. This feels rather sub-optimal :-(=0D
=0D
In practice users don't appear to care strongly about the fact that these=
=0D
commands block the VM while they run. I might have seen one bug report=0D
about it, but it certainly isn't something that comes up as a frequent=0D
topic except among us QEMU maintainers. Users do care about having=0D
access to the snapshot feature.=0D
=0D
Where I am seeing frequent complaints is wrt the use of OVMF combined=0D
with snapshots which has some serious pain points. This is getting worse=0D
as the push to ditch legacy BIOS in favour of UEFI gain momentum both=0D
across OS vendors and mgmt apps. Solving it requires new parameters to=0D
the commands, but doing this in HMP is super unappealing.=0D
=0D
=0D
=0D
After 10 years, I think it is time for us to be a little pragmatic about=0D
our handling of snapshots commands. My desire is that libvirt should never=
=0D
use "human-monitor-command" under any circumstances, because of the=0D
inherant flaws in HMP as a protocol for machine consumption. If there=0D
are flaws in QMP commands that's fine. If we fix them in future, we can=0D
deprecate the current QMP commands and remove them not too long after,=0D
without being locked in forever.=0D
=0D
=0D
Thus in this series I'm proposing a direct 1-1 mapping of the existing=0D
HMP commands for savevm/loadvm/delvm into QMP as a first step. This does=0D
not solve the blocking thread problem, but it does eliminate the error=0D
reporting, type checking and introspection problems inherant to HMP.=0D
We're winning on 3 out of the 4 long term problems.=0D
=0D
If someone can suggest a easy way to fix the thread blocking problem=0D
too, I'd be interested to hear it. If it involves a major refactoring=0D
then I think user are better served by unlocking what look like easy=0D
wins today.=0D
=0D
With a QMP variant, we reasonably deal with the problems related to OVMF:=
=0D
=0D
 - The logic to pick which disk to store the vmstate in is not=0D
   satsifactory.=0D
=0D
   The first block driver state cannot be assumed to be the root disk=0D
   image, it might be OVMF varstore and we don't want to store vmstate=0D
   in there.=0D
=0D
 - The logic to decide which disks must be snapshotted is hardwired=0D
   to all disks which are writable=0D
=0D
   Again with OVMF there might be a writable varstore, but this can be=0D
   raw rather than qcow2 format, and thus unable to be snapshotted.=0D
   While users might wish to snapshot their varstore, in some/many/most=0D
   cases it is entirely uneccessary. Users are blocked from snapshotting=0D
   their VM though due to this varstore.=0D
=0D
These are solved by adding two parameters to the commands. The first is=0D
a block device node name that identifies the image to store vmstate in,=0D
and the second is a list of node names to exclude from snapshots.=0D
=0D
In the block code I've only dealt with node names for block devices, as=0D
IIUC, this is all that libvirt should need in the -blockdev world it now=0D
lives in. IOW, I've made not attempt to cope with people wanting to use=0D
these QMP commands in combination with -drive args.=0D
=0D
I've done some minimal work in libvirt to start to make use of the new=0D
commands to validate their functionality, but this isn't finished yet.=0D
=0D
My ultimate goal is to make the GNOME Boxes maintainer happy again by=0D
having internal snapshots work with OVMF:=0D
=0D
  https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb=
5e=3D=0D
f45c5f64048f16a6e=0D
=0D
Daniel P. Berrang=3DC3=3DA9 (6):=0D
  migration: improve error reporting of block driver state name=0D
  migration: introduce savevm, loadvm, delvm QMP commands=0D
  block: add ability to filter out blockdevs during snapshot=0D
  block: allow specifying name of block device for vmstate storage=0D
  migration: support excluding block devs in QMP snapshot commands=0D
  migration: support picking vmstate disk in QMP snapshot commands=0D
=0D
 block/monitor/block-hmp-cmds.c |  4 +-=0D
 block/snapshot.c               | 68 +++++++++++++++++++------=0D
 include/block/snapshot.h       | 21 +++++---=0D
 include/migration/snapshot.h   | 10 +++-=0D
 migration/savevm.c             | 71 +++++++++++++++++++-------=0D
 monitor/hmp-cmds.c             | 20 ++------=0D
 qapi/migration.json            | 91 ++++++++++++++++++++++++++++++++++=0D
 replay/replay-snapshot.c       |  4 +-=0D
 softmmu/vl.c                   |  2 +-=0D
 9 files changed, 228 insertions(+), 63 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


