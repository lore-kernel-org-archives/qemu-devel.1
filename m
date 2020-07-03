Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515DBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF231206E2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RVTmQzX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF231206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOf6-0001N4-Or
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jrOUI-0007VA-Mr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:24:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27340
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jrOUG-0005uM-I4
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593793467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwpAli+hqkPMsAqMmQR6raQr7RVd1/GK/liBKuxiSiM=;
 b=RVTmQzX3+i6viQJckTDNvVyE60bsjwFqiLHwqwzUwpP/uVMIYhtMnKjEjfoLk76Qo7ct/2
 xQOSeVhNTFCTt3Yknhrj+Yr0SL9W8PDcE234FNHFnfar8TaoP9w7wDOeQWFH3u/5kU+2aA
 S38s3XGOgvQbAn688FguONUf/sQpi4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-FfMjii8KPHe4hbc2CNXZQQ-1; Fri, 03 Jul 2020 12:24:25 -0400
X-MC-Unique: FfMjii8KPHe4hbc2CNXZQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94FFB8015CB;
 Fri,  3 Jul 2020 16:24:24 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BE9A4AC;
 Fri,  3 Jul 2020 16:24:20 +0000 (UTC)
Date: Fri, 3 Jul 2020 18:24:17 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 2/6] migration: introduce savevm, loadvm, delvm QMP
 commands
Message-ID: <20200703162417.GA3255981@angien.pipo.sk>
References: <20200702175754.2211821-1-berrange@redhat.com>
 <20200702175754.2211821-3-berrange@redhat.com>
 <fcff0e8b-fd60-2897-0553-49ab24a9b7fa@redhat.com>
 <20200702182452.GP1888119@redhat.com>
 <20200703154933.GE6641@work-vm>
 <20200703160235.GM2213227@redhat.com>
 <20200703161012.GH6641@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200703161012.GH6641@work-vm>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
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

On Fri, Jul 03, 2020 at 17:10:12 +0100, Dr. David Alan Gilbert wrote:
> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > On Fri, Jul 03, 2020 at 04:49:33PM +0100, Dr. David Alan Gilbert wrote:
> > > * Daniel P. Berrangé (berrange@redhat.com) wrote:
> > > > On Thu, Jul 02, 2020 at 01:12:52PM -0500, Eric Blake wrote:
> > > > > On 7/2/20 12:57 PM, Daniel P. Berrangé wrote:

[...]

> > > Remind me, what was the problem with just making a block: migration
> > > channel, and then we can migrate to it?
> > 
> > migration only does vmstate, not disks. The current blockdev commands
> > are all related to external snapshots, nothing for internal snapshots
> > AFAIK. So we still need commands to load/save internal snapshots of
> > the disk data in the qcow2 files.
> > 
> > So we could look at loadvm/savevm conceptually as a syntax sugar above
> > a migration transport that targets disk images, and blockdev QMP command
> > that can do internal snapshots. Neither of these exist though and feel
> > like a significantly larger amount of work than using existing functionality
> > that is currently working.
> 
> I think that's what we should aim for; adding this wrapper isn't gaining
> that much without moving a bit towards that; so I would stick with the
> x- for now.

Relying on the HMP variants is IMO even worse. Error handling is
terrible there. I'd vote even for a straight wrapper without any logic
at this point. IMO it's just necessary to document that it's an
intermediate solution which WILL be deprecated and removed as soon as a
suitable replacement is in place.

Not doing anything is the argument we hear for multiple years now and
savevm/delvm/loadvm are now the only 3 commands used via the HMP wrapper
in libvirt.

Since deprecation is now a thing I think we can add a disposable
inteface. In the end HMP will or will not need to remain anyways and the
deprecation there is IMO less clear.


