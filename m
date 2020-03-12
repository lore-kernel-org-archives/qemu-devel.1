Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5434AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDAC20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 14:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZEh7AU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDAC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCOvH-000695-7k
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 10:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1jCOtk-00031I-8s
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1jCOth-0007oI-UL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:33:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41861
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1jCOth-0007nu-ON
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 10:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584023596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cfb7TTuVc9Nbz1RrInVDWas33/OQXlomUl20knSLEww=;
 b=dZEh7AU0zLD3phnGJ/eGG3rppiG5Bw1JA2J3Lt/uLbS7KNfEBjXcrVGKNCL9BBzUhzZiXi
 LCYT/pplZHCC9/hIEYFIlTe18GenZJuf2ltDWJo2PsURCDH4juTfxrJbW39S+NOOk99Xc8
 yFCiMSriHibAYLVxy1xGPSS7SMLRb+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-eSKJgQzdNRaWEqVD3ggCLA-1; Thu, 12 Mar 2020 10:33:15 -0400
X-MC-Unique: eSKJgQzdNRaWEqVD3ggCLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 420FB189F762;
 Thu, 12 Mar 2020 14:33:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C17319C6A;
 Thu, 12 Mar 2020 14:33:08 +0000 (UTC)
Message-ID: <c2d1cbfdf24c0673d257329393b065635bb6f8f4.camel@redhat.com>
Subject: Re: [PATCH v2 00/14] LUKS: encryption slot management using amend
 interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 12 Mar 2020 16:33:07 +0200
In-Reply-To: <bd526fff-5719-c056-e1cc-722c4e49c82b@redhat.com>
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <bd526fff-5719-c056-e1cc-722c4e49c82b@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2020-03-12 at 06:56 -0500, Eric Blake wrote:
> On 3/8/20 10:18 AM, Maxim Levitsky wrote:
> > Hi!
> > Here is the updated series of my patches, incorporating all the feedback I received.
> > 
> > Patches are strictly divided by topic to 3 groups, and each group depends on former groups.
> > 
> > * Patches 1,2 implement qcrypto generic amend interface, including definition
> >    of structs used in crypto.json and implement this in luks crypto driver
> >    Nothing is exposed to the user at this stage
> > 
> > * Patches 3-9 use the code from patches 1,2 to implement qemu-img amend based encryption slot management
> >    for luks and for qcow2, and add a bunch of iotests to cover that.
> > 
> > * Patches 10-13 add x-blockdev-amend (I'll drop the -x prefix if you like), and wire it
> >    to luks and qcow2 driver to implement qmp based encryption slot management also using
> >    the code from patches 1,2, and also add a bunch of iotests to cover this.
> >   tests/qemu-iotests/284.out       |   6 +-
> >   tests/qemu-iotests/300           | 207 ++++++++++++++++
> 
> Any reason why you skipped straight to test 300, rather than using an 
> available slot like 290?  (Admittedly, our process for reserving slots 
> is not very high-tech: manually scan the list for what other patches out 
> there have claimed a slot, and be prepared to renumber when rebasing)
The only reason I used these slots is that I know sadly that I'll have to resend and
rebase this patchset for a while, and every time a test with the number I use is added,
this causes relatively hard to fix conflict (or at least I don't know how to fix these conflicts effectively)

Thus I used safe numbers, but at the rate this task progresses I won't be surprised that when this is merged,
these will be test numbers to use...

TL;DR - these are placeholders, and once the patch set is blesssed for merging upstream I'll update this next
available numbers.

Best regards,
	Maxim Levitsky


