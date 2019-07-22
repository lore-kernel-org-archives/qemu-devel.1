Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ACFC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DD020665
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 12:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DD020665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpXOI-0002wT-J3
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 08:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1hpXO8-0002Wn-UA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1hpXO7-0003ZY-0W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 08:25:56 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:50798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1hpXO2-0003TU-52; Mon, 22 Jul 2019 08:25:50 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 6656543146;
 Mon, 22 Jul 2019 14:17:57 +0200 (CEST)
Date: Mon, 22 Jul 2019 14:17:55 +0200
From: Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190722121755.xpx2qni53e6pha7t@nora.maurer-it.com>
References: <20190709232550.10724-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709232550.10724-1-jsnow@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.186.127.180
Subject: Re: [Qemu-devel] [PATCH v4 00/18] bitmaps: introduce 'bitmap' sync
 mode
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 09, 2019 at 07:25:32PM -0400, John Snow wrote:
> This series adds a new "BITMAP" sync mode that is meant to replace the
> existing "INCREMENTAL" sync mode.
> 
> This mode can have its behavior modified by issuing any of three bitmap sync
> modes, passed as arguments to the job.
> 
> The three bitmap sync modes are:
> - ON-SUCCESS: This is an alias for the old incremental mode. The bitmap is
>               conditionally synchronized based on the return code of the job
>               upon completion.
> - NEVER: This is, effectively, the differential backup mode. It never clears
>          the bitmap, as the name suggests.
> - ALWAYS: Here is the new, exciting thing. The bitmap is always synchronized,
>           even on failure. On success, this is identical to incremental, but
>           on failure it clears only the bits that were copied successfully.
>           This can be used to "resume" incremental backups from later points
>           in times.
> 
> I wrote this series by accident on my way to implement incremental mode
> for mirror, but this happened first -- the problem is that Mirror mode
> uses its existing modes in a very particular way; and this was the best
> way to add bitmap support into the mirror job properly.
> 
> [...]
> 
> Future work:
> [..]
>  - Add these modes to Mirror. (Done*, but needs tests.)

are these mirror patches available somehwere for testing in combination
with this series? your bitmaps branch does not seem to contain them ;)

we've been experimenting with Ma Haocong's patch (v4 from February) to add
"incremental"/differential sync to drive-mirror recently with positive
results so far, and this sounds like it is another attempt at getting
this properly integrated into Qemu.


