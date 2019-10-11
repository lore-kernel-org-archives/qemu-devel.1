Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50472C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 229BE2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:02:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229BE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqoZ-0001JY-Qk
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iIqmw-000080-BX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iIqmu-0001B8-U8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:00:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iIqmu-0001AE-LH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 81ECA30A7B81;
 Fri, 11 Oct 2019 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7319A60872;
 Fri, 11 Oct 2019 09:00:38 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:00:36 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/2] qapi: Allow introspecting fix for savevm's
 cooperation with blockdev
Message-ID: <20191011090036.GA5158@localhost.localdomain>
References: <cover.1568989362.git.pkrempa@redhat.com>
 <992ea9ca130b4fb6dbf82726aa3b1d8040c16944.1568989362.git.pkrempa@redhat.com>
 <87r23w2rbp.fsf@dusky.pond.sub.org>
 <b15fdae1-1e70-fe13-701e-48a04d56c93f@redhat.com>
 <87a7ajuzpw.fsf@dusky.pond.sub.org>
 <20191010150733.GE7616@localhost.localdomain>
 <87r23jlsql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r23jlsql.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 11 Oct 2019 09:00:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.10.2019 um 08:08 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 02.10.2019 um 13:57 hat Markus Armbruster geschrieben:
> >> Eric Blake <eblake@redhat.com> writes:
> >> 
> >> > On 10/1/19 2:34 PM, Markus Armbruster wrote:
> >> >> Peter Krempa <pkrempa@redhat.com> writes:
> >> >>
> >> >>> savevm was buggy as it considered all monitor owned block device nodes
> >> >>
> >> >> Recommend "monitor-owned block device nodes" or "block device nodes
> >> >> owned by a monitor"
> >> >>
> >> >>> for snapshot. With introduction of -blockdev the common usage made all
> >> >>> nodes including protocol nodes monitor owned and thus considered for
> >> >>> snapshot.
> >> >>
> >> >> What exactly is / was the problem?
> >> >
> >> >
> >> > Old way: using QMP add_device, you create a drive backend with two BDS
> >> > (format and protocol) assigned to it; the drive backend has your given
> >> > name, and both BDS have a generated name (beginning with '#').  The
> >> > two BDS are not monitor-owned, rather, the drive is.
> >> >
> >> > New way: using QMP blockdev_add, you create the two BDS manually with
> >> > names of your choice, then plug that blockdev into an unnamed
> >> > blockbackend (the drive no longer needs a name, because you can get at
> >> > everything through the BDS name).  You _could_ do this in one step
> >> > (the QAPI allows self-recursion where you can define both the format
> >> > and protocol in one step), but it is easier to do in two steps (define
> >> > the protocol BDS first, then define the format BDS using a "string"
> >> > name of the protocol BDS instead of a { "driver":..., args... } object
> >> > of the protocol layer.  But by making two calls,  now both BDS are
> >> > monitor-owned.
> >> >
> >> > At snapshot-time, the code currently looks for all monitor-owned nodes
> >> > when deciding what to snapshot.  In the old way, this finds the named
> >> > drive, picks up its associated top-most node, and snapshots the format
> >> > layer.  In the new way, the drive is unnamed so it is skipped, while
> >> > there are two named BDS, but we don't want a snapshot of the protocol
> >> > layer.
> >> 
> >> So the problem is certain (common & sane) -blockdev use makes savevm
> >> create additional, unwanted snapshots.
> >
> > Actually, the most common protocol driver is file-posix, which doesn't
> > support snapshots, so usually the result was that savevm just fails
> > because it can't snapshot something that it (incorrectly) thinks it
> > should snapshot.
> 
> v3's commit message:
> 
>     qapi: Allow introspecting fix for savevm's cooperation with blockdev
>     
>     'savevm' was buggy as it considered all monitor-owned block device nodes
>     for snapshot. With introduction of -blockdev the common usage made all
>     nodes including protocol and backing file nodes monitor-owned and thus
>     considered for snapshot.
>     
>     This is a problem since the 'file' protocol nodes can't have internal
>     snapshots and it does not make sense to take snapshot of nodes
>     representing backing files.
>     
>     This was fixed by commit 05f4aced658a02b02 clients need to be able to
>     detect whether this fix is present.

Something is missing in this sentence. I think you lost the "but" from
the original message.

>     Since savevm does not have an QMP alternative, add the feature for the
>     'human-monitor-command' backdoor which is used to call this command in
>     modern use.
>     
>     Signed-off-by: Peter Krempa <pkrempa@redhat.com>
>  
> Kevin, is this explanation sufficiently correct & complete?

Looks good to me otherwise.

Kevin

