Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFBAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:46:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277782084C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="O4H/5Lxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277782084C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSru-0006Ki-O2
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTSqO-0005k7-LP
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:44:40 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:8806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTSqK-0003la-IE
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 12:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1602866677;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u08QdlcJJBMJaElC7SvikJOEk5yIS2EAg8zpnJLFXd4=;
 b=O4H/5LxfU7ccBHHIXZSkY/To0EruoRN3CSDTDJqVAz3WZSo+bRi4W7ME
 AiyFrs63ktnWHc7Yfcyb0OkKC5NWguZtmaXKcxd46yld47RIjN0X94APr
 ih36E9kGMue9+vwPIQylVhwF/swceQOIGdzGznpPLERVUpffYsbfbayUB Y=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: WgHsbEoe6SMytCQFC/Bb7MyLDZKoBfgiml7Myu5P3GO8+SSZCVv9f94vxxL//Uz0ahMvORq8ej
 Xbw4/AibDK5n9lB1lJSvb8c7uXs5624j+XV0ygdCMQEXg4cn84fzeJGIyQGz9FsCKORxxOGAeP
 RgWH6EZk7i7rysmc5JhwdkX3v4V+D5aaWt5XFG8fz836GGlZ8J2lnY8u4BAbElY1Zk1rCRZN8K
 cuoyuL4oaOifOkpc+m274eyZldmn/N1vhlPEb8dcAap055OFe3EjwII5QWRXQTf6ajsDDUxh+f
 saQ=
X-SBRS: 2.5
X-MesageID: 29522942
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,383,1596513600"; d="scan'208";a="29522942"
Date: Fri, 16 Oct 2020 17:44:28 +0100
To: Jason Andryuk <jandryuk@gmail.com>
CC: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, xen-devel <xen-devel@lists.xenproject.org>, "Paul
 Durrant" <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>, Marek
 =?iso-8859-1?Q?Marczykowski-G=F3recki?= <marmarek@invisiblethingslab.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] hw/xen: Set suppress-vmdesc for Xen machines
Message-ID: <20201016164428.GC3105841@perard.uk.xensource.com>
References: <20201013190506.3325-1-jandryuk@gmail.com>
 <20201016153708.GB3105841@perard.uk.xensource.com>
 <CAKf6xpssB-FGwiEhLqV8OFjBGuP4LKYh+9Pj_Bj7p5U2CJSw=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKf6xpssB-FGwiEhLqV8OFjBGuP4LKYh+9Pj_Bj7p5U2CJSw=g@mail.gmail.com>
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=anthony.perard@citrix.com; helo=esa1.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 12:44:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Anthony PERARD <anthony.perard@citrix.com>
From: Anthony PERARD via <qemu-devel@nongnu.org>

On Fri, Oct 16, 2020 at 12:01:47PM -0400, Jason Andryuk wrote:
> On Fri, Oct 16, 2020 at 11:38 AM Anthony PERARD
> <anthony.perard@citrix.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 03:05:06PM -0400, Jason Andryuk wrote:
> > > xen-save-devices-state doesn't currently generate a vmdesc, so restore
> > > always triggers "Expected vmdescription section, but got 0".  This is
> > > not a problem when restore comes from a file.  However, when QEMU runs
> > > in a linux stubdom and comes over a console, EOF is not received.  This
> > > causes a delay restoring - though it does restore.
> > >
> > > Setting suppress-vmdesc skips looking for the vmdesc during restore and
> > > avoids the wait.
> >
> > suppress-vmdesc is only used during restore, right? So starting a guest
> > without it, saving the guest and restoring the guest with
> > suppress-vmdesc=on added will work as intended? (I'm checking that migration
> > across update of QEMU will work.)
> 
> vmdesc is a json description of the migration stream that comes after
> the QEMU migration stream.  For our purposes, <migration
> stream><vmdesc json blob>.  Normal QEMU savevm will generate it,
> unless suppress-vmdesc is set.  QEMU restore will read it because:
> "Try to read in the VMDESC section as well, so that dumping tools that
> intercept our migration stream have the chance to see it."
> 
> Xen save does not go through savevm, but instead
> xen-save-devices-state, which is a subset of the QEMU savevm.  It
> skips RAM since that is read out through Xen interfaces.  Xen uses
> xen-load-devices-state to restore device state.  That goes through the
> common qemu_loadvm_state which tries to read the vmdesc stream.
> 
> For Xen, yes, suppress-vmdesc only matters for the restore case, and
> it suppresses the attempt to read the vmdesc.  I think every Xen
> restore currently has "Expected vmdescription section, but got -1" in
> the -dm.log since the vmdesc is missing.  I have not tested restoring
> across this change, but since it just controls reading and discarding
> the vmdesc stream, I don't think it will break migration across
> update.

Thanks for the explanation.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Do you think you could send a patch for libxl as well? Since libxl in
some cases may use the "pc machine instead of "xenfv". I can send the
patch otherwise.

Cheers,

-- 
Anthony PERARD

