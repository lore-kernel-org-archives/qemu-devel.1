Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B1C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E07207DE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RoRBxsWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E07207DE
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRpt-0006J6-4i
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTRoI-0005LB-5D
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:38:26 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:32012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kTRoF-0002TR-TH
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1602862703;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GTzravAnKnhxtLl9cPws+qnSmaTjDzSL5lAd3eS6BKo=;
 b=RoRBxsWCs6coIANgHyYtoq+x5VKSSWI14aA/s8TbjwmEqA0kP1zxY59P
 KcviCd4PbtUhTc5CC7PeTyXkGp5sFz9sara4kXLsxK8rneF47YEMluQwG
 Nj57TcCM4sSZaUumbncwHD/dgpLaN2d3nqIF0P1AdTkACm2rTAQ53ZOwZ k=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: wJ9MoMoAAlTEMN9xPetJhVcvwbURac+r3BOVHRnAPedrzcUqgyb1jssTnjrUu6GK62x4PdbINj
 5EkJ1MdR+QNdXDlnktt9DCpCCFO1yMyU/d79tkj51YWVd8ImatYQpYeGQZHZxcupfXpnhPi3bN
 1Ju1GtFm/kDuy2OauF4TfmZIFfQcVwdYN6NnYqKpC+FbE+AchvGFJjEtJYhp/myYg2NPZEjem5
 iEwxAP1SVZL9UhVha+35TvNBxJRhHgf0NcsYp3Qxj81adyCT+PuXTtPDcuOBBKwPYZenAP65tt
 6/o=
X-SBRS: 2.5
X-MesageID: 29429829
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,383,1596513600"; d="scan'208";a="29429829"
Date: Fri, 16 Oct 2020 16:37:08 +0100
To: Jason Andryuk <jandryuk@gmail.com>
CC: <qemu-devel@nongnu.org>, <dgilbert@redhat.com>,
 <xen-devel@lists.xenproject.org>, <paul@xen.org>, <sstabellini@kernel.org>,
 Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost
 <ehabkost@redhat.com>
Subject: Re: [PATCH] hw/xen: Set suppress-vmdesc for Xen machines
Message-ID: <20201016153708.GB3105841@perard.uk.xensource.com>
References: <20201013190506.3325-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013190506.3325-1-jandryuk@gmail.com>
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=anthony.perard@citrix.com; helo=esa6.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 11:38:21
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

On Tue, Oct 13, 2020 at 03:05:06PM -0400, Jason Andryuk wrote:
> xen-save-devices-state doesn't currently generate a vmdesc, so restore
> always triggers "Expected vmdescription section, but got 0".  This is
> not a problem when restore comes from a file.  However, when QEMU runs
> in a linux stubdom and comes over a console, EOF is not received.  This
> causes a delay restoring - though it does restore.
> 
> Setting suppress-vmdesc skips looking for the vmdesc during restore and
> avoids the wait.

suppress-vmdesc is only used during restore, right? So starting a guest
without it, saving the guest and restoring the guest with
suppress-vmdesc=on added will work as intended? (I'm checking that migration
across update of QEMU will work.)

Thanks,

-- 
Anthony PERARD

