Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E32C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1553F2071B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 08:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gInQjsjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1553F2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBa2y-0006K4-AT
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 04:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kBa1w-0005oK-T4
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:46:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kBa1v-000828-56
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 04:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598604394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTd/+A91XeCln6fSejuPZc73HQeIpM0qRNQX77lYw/A=;
 b=gInQjsjgurzzNde+/xTnvQpSgeDxoOAFNu3vuWzU+HZBC/gNElW7IQ+67hSINHwu8SCTUk
 Oe9RnVYLLaXZDOsylVXoAC5PQzhi836p8CO4RCw7IZz2+E19SOuUuzHRAFB0zpiE+xUcp7
 7eSwkOL2aHdOZ7Bps3rMILiKisvCGpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-drXTqYBXO9-qzzyWQvrc5Q-1; Fri, 28 Aug 2020 04:46:32 -0400
X-MC-Unique: drXTqYBXO9-qzzyWQvrc5Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29CD2E75D;
 Fri, 28 Aug 2020 08:46:31 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-145.ams2.redhat.com [10.36.113.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E907C74E1E;
 Fri, 28 Aug 2020 08:46:28 +0000 (UTC)
Date: Fri, 28 Aug 2020 10:46:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
Message-ID: <20200828084627.GA10263@linux.fritz.box>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <877dtls8ux.fsf@dusky.pond.sub.org>
 <20200826182824.GA190807@redhat.com>
 <20200826183425.GA191632@redhat.com>
 <87zh6gmjq1.fsf@dusky.pond.sub.org>
 <20200827131301.GA5520@linux.fritz.box>
 <87sgc747hb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgc747hb.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 00:28:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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

Am 28.08.2020 um 08:20 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 27.08.2020 um 13:06 hat Markus Armbruster geschrieben:
> >> Daniel P. BerrangÃƒÂ© <berrange@redhat.com> writes:
> >> 
> >> > On Wed, Aug 26, 2020 at 07:28:24PM +0100, Daniel P. BerrangÃƒÂ© wrote:
> >> >> On Wed, Aug 26, 2020 at 05:52:06PM +0200, Markus Armbruster wrote:
> >> >> > Open questions:
> >> >> > 
> >> >> > * Do we want the QMP command to delete existing snapshots with
> >> >> >   conflicting tag / ID, like HMP savevm does?  Or do we want it to fail
> >> >> >   the transaction?
> >> >> 
> >> >> The intent is for the QMP commands to operate exclusively on
> >> >> 'tags', and never consider "ID".
> >> >
> >> > I forgot that even HMP ignores "ID" now and works exclusively in terms
> >> > of tags since:
> >> >
> >> >
> >> >   commit 6ca080453ea403959ccde661030ca16264acc181
> >> >   Author: Daniel Henrique Barboza <danielhb413@gmail.com>
> >> >   Date:   Wed Nov 7 11:09:58 2018 -0200
> >> >
> >> >     block/snapshot.c: eliminate use of ID input in snapshot operations
> >> 
> >> Almost a year after I sent the memo I quoted.  It's an incompatible
> >> change, but nobody complained, and I'm glad we got this issue out of the
> >> way.
> >
> > FWIW, I would have ignored any complaint about incompatible changes in
> > HMP. It's not supposed to be a stable API, but UI.
> 
> The iffy part is actually the loss of ability to access snapshots that
> lack a name.  Complaints about that would have been valid, I think.
> Fortunately, there have been none.

'loadvm ""' should do the trick for these. The same way as you have to
use with 'savevm' to create them in non-prehistoric versions of QEMU.
We stopped creating snapshots with empty names by default in 0.14, so
they are probably not very relevant any more. (Versioned machine types
go back "only" to 1.0, so good luck loading a snapshot from an older
version. And I wouldn't bet money either on a 1.0 snapshot still working
with that machine type...)

Kevin


