Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A0C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E66E20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 13:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnzwXnPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E66E20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDT5J-00062b-H3
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 09:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDT4j-0005VR-Ja
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:45:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDT4h-0004gj-9z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 09:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599054318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+MPsbofg30OLOlchA9jxow2R8EzQAAlztB9M04RxP4=;
 b=TnzwXnPmvVuc05NPa1kidKBJcsZa/En2cYQyzwiVH6ia2qN0PH0pmSqEak4nmGx/mGFFJY
 VElROd47c7D0ukAP8BZ/wZhkf91n+eqGp8FFq4y2OStbXb6ZanBc8MU2O03ip8tWemCMQ7
 oegOu4WvcQSmeq7/dGv3soOU8IeuFPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-A0wrBHelMgWcyhYGf3wcjQ-1; Wed, 02 Sep 2020 09:45:07 -0400
X-MC-Unique: A0wrBHelMgWcyhYGf3wcjQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A626D873117;
 Wed,  2 Sep 2020 13:45:06 +0000 (UTC)
Received: from redhat.com (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9F44672C6;
 Wed,  2 Sep 2020 13:45:05 +0000 (UTC)
Date: Wed, 2 Sep 2020 14:45:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] 9pfs: log warning if msize <= 8192
Message-ID: <20200902134503.GJ403297@redhat.com>
References: <E1kDR8W-0001s4-Sr@lizzy.crudebyte.com>
 <20200902122547.GH403297@redhat.com> <399764553.t4N7NBxW8t@silver>
 <20200902153934.5a2d7f86@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20200902153934.5a2d7f86@bahia.lan>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 03:39:34PM +0200, Greg Kurz wrote:
> On Wed, 02 Sep 2020 14:52:33 +0200
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> 
> > On Mittwoch, 2. September 2020 14:25:47 CEST Daniel P. Berrangé wrote:
> > > On Wed, Sep 02, 2020 at 01:22:49PM +0200, Christian Schoenebeck wrote:
> > > > It is essential to choose a reasonable high value for 'msize' to avoid
> > > > severe degraded file I/O performance. This parameter has to be chosen
> > > > on client/guest side, and a Linux client defaults to an 'msize' of only
> > > > 8192 if the user did not explicitly specify a value for 'msize'.
> > > > 
> > > > Unfortunately many users are not aware that they should specify an
> > > > appropriate value for 'msize' to avoid severe performance issues, so
> > > > log a performance warning on host side in that case to make it more
> > > > clear.
> > > 
> > > What is a more reasonable "msize" value to pick instead of 8k ?
> > > ie at what msize is I/O not several degraded ?
> > 
> > A good value depends on the file I/O potential of the underlying storage on 
> > host side, and then you still would need to trade off between performance 
> > profit and additional RAM costs, i.e. with growing msize (RAM occupation), 
> > performance still increases, but performance delta will shrink continuously.
> > 
> > So in practice you might e.g. choose anything between 10MiB ... >100MiB for a 
> > SATA spindle disk storage, and a much higher value for anything PCIe based 
> > flash storage. So a user probably should benchmark and decide what's 
> > reasonable for the intended use case.
> > 
> > > If there a reason that Linux can't pick a better default ?
> > 
> > I was not involved when that default value was picked on Linux side, so I 
> > don't know why exactly this value (8192) had been chosen as default 'msize' 
> > years ago.
> > 
> 
> The original size back in 2005 was 9000:
> 
> [greg@bahia kernel-linus]$ git show 9e82cf6a802a7 | grep 9000
> +	v9ses->maxdata = 9000;
> +	if (v9ses->maxdata != 9000)
> 
> which was later converted to 8192.
> 
> I couldn't find any hint on why such a small size was chosen.
> 
> Maybe you can try to contact 9pfs father ?
> 
> Eric Van Hensbergen <ericvh@gmail.com>
> 
> > It certainly (sh/c)ould be higher, as it is already close to the theoreticaly 
> > minimum msize of 4096. However how should a Linux guest automatically pick a 
> > reasonable msize if it does not have any knowlege of host's storage features?
> > 
> > But even if this will be addressed on Linux kernel side, I still think users 
> > of old kernels should be made aware of this issue, as it is not obvious to the 
> > user.
> > 
> 
> I tend to agree. Until linux decides of a better default, we should only
> warn the user if they decide to go below the current one.

To be clear, I'm not objecting to warning - just that the proposed warning
doesn't give any useful information about what is considered to be a
sensible alternative size, and nor does the commit message.

Just like to see the commit message provide the background info above,
and ideally have the warning message at least give the user a suggestion
that is in the sensible order of magnitude they should be looking at.

eg tell them to aim for 1 MB (or whatever value) as a starting point to
tuning.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


