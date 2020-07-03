Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52188C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCC0207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI9UyWNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCC0207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOgp-0004xO-8x
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOWQ-0002L9-66
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:26:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrOWO-0006Qv-HK
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593793599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yCHvlfOEuzdgAP12BR+hu1uOB7Z73C1zIKR4bkcgp0o=;
 b=gI9UyWNmPuzA1Pzi3VLeb3eZ1eXIHFcpusp1pvaygTnGDH794YYpgxFAOCM0FjMyfTgidZ
 uCtRzFcqc7BcalwX/zDnWaJLou0cFwNV+Fz90kIhXlRH/mFa+33zs7p1CLzfHQC/B7v5JR
 jCjK9x8enafohEh7N2pR5MZm9RsxOzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-6rkuh1snO5ejV4q1pBCqfw-1; Fri, 03 Jul 2020 12:26:36 -0400
X-MC-Unique: 6rkuh1snO5ejV4q1pBCqfw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29CA718FF661;
 Fri,  3 Jul 2020 16:26:35 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D47011002397;
 Fri,  3 Jul 2020 16:26:32 +0000 (UTC)
Date: Fri, 3 Jul 2020 17:26:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200703162630.GJ6641@work-vm>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
 <20200702182452.GP1888119@redhat.com>
 <20200703154933.GE6641@work-vm>
 <20200703160235.GM2213227@redhat.com>
 <20200703161012.GH6641@work-vm>
 <20200703162417.GA3255981@angien.pipo.sk>
MIME-Version: 1.0
In-Reply-To: <20200703162417.GA3255981@angien.pipo.sk>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Krempa (pkrempa@redhat.com) wrote:
> On Fri, Jul 03, 2020 at 17:10:12 +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > On Fri, Jul 03, 2020 at 04:49:33PM +0100, Dr. David Alan Gilbert wrote:
> > > > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > > > On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> > > > > > On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:
> 
> [...]
> 
> > > > Remind me, what was the problem with just making a block: migration
> > > > channel, and then we can migrate to it?
> > > 
> > > migration only does vmstate, not disks. The current blockdev commands
> > > are all related to external snapshots, nothing for internal snapshots
> > > AFAIK. So we still need commands to load/save internal snapshots of
> > > the disk data in the qcow2 files.
> > > 
> > > So we could look at loadvm/savevm conceptually as a syntax sugar above
> > > a migration transport that targets disk images, and blockdev QMP command
> > > that can do internal snapshots. Neither of these exist though and feel
> > > like a significantly larger amount of work than using existing functionality
> > > that is currently working.
> > 
> > I think that's what we should aim for; adding this wrapper isn't gaining
> > that much without moving a bit towards that; so I would stick with the
> > x- for now.
> 
> Relying on the HMP variants is IMO even worse. Error handling is
> terrible there. I'd vote even for a straight wrapper without any logic
> at this point. IMO it's just necessary to document that it's an
> intermediate solution which WILL be deprecated and removed as soon as a
> suitable replacement is in place.
> 
> Not doing anything is the argument we hear for multiple years now and
> savevm/delvm/loadvm are now the only 3 commands used via the HMP wrapper
> in libvirt.
> 
> Since deprecation is now a thing I think we can add a disposable
> inteface. In the end HMP will or will not need to remain anyways and the
> deprecation there is IMO less clear.

Only if we come up with a list of what we actually need to do to
properly fix it; I'm not suggesting we actually need to do the work, but
we should figure out what we need to do.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


