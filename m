Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D50C47427
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A4420717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ax4H/3E4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A4420717
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwJS-0005zW-Ou
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 12:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kMwIJ-0005Bp-HM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:46:31 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:20936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1kMwIB-00029w-Tr
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 12:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1601311583;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pgEaqq+CBlTcMwrROWQP+HayKleatnE5rPFt7OlemsE=;
 b=ax4H/3E49FExSbSAwMqPUWbZRa3jFuFBafb2IeiaZhRdKTXLA1sX5cnj
 EbiI3zwGiAOtsF6IHmGaa92nX5lMLiGwYyXLu5wQW1iN73w5DcCWwtSU7
 vVNxQ0k7lpDFX2h757EsME6J+GkB2PneRsNMUQ4wNLesyXTD1mcGjXZKZ Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: BbqX7TfiB8N6jxlIspyBkGNS1sU67eiiwDJM35JBhzg4XolsCDIGhWsFLrrOnVYqjvk/DmWmi0
 A9lfwbp+iU+wVtRMsG1Dzz/T2CNAT596A5gTiDaii+TZl5+w6KlrhQYrVfewJT88pKRl71AbKp
 w9W6gRa70sFIKsToa5bkbohwD9RW+QP73rogu4W1LUVBBMCVboeggvUI+HviPDT8RM71sdbONe
 x6UC/4JyuTdH9ZkLArrTQ9sGyTimyILIXURrG4njDLzko4dyr1sG1fEFJ3ji6qDZvH8rWHG/DY
 bWs=
X-SBRS: None
X-MesageID: 28781791
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,313,1596513600"; d="scan'208";a="28781791"
Date: Mon, 28 Sep 2020 17:46:18 +0100
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
CC: Dov Murik <dovmurik@linux.vnet.ibm.com>, <sstabellini@kernel.org>,
 <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Paul Durrant
 <paul@xen.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] migration: Truncate state file in xen-save-devices-state
Message-ID: <20200928164618.GK2024@perard.uk.xensource.com>
References: <20200921094830.114028-1-dovmurik@linux.vnet.ibm.com>
 <20200921111723.GF3221@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200921111723.GF3221@work-vm>
Received-SPF: pass client-ip=216.71.155.144;
 envelope-from=anthony.perard@citrix.com; helo=esa4.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 12:46:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

On Mon, Sep 21, 2020 at 12:17:23PM +0100, Dr. David Alan Gilbert wrote:
> * Dov Murik (dovmurik@linux.vnet.ibm.com) wrote:
> > When running the xen-save-devices-state QMP command, if the filename
> > already exists it will be truncated before dumping the devices' state
> > into it.
> > 
> > Signed-off-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> > ---
> >  migration/savevm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 304d98ff78..e1b26672cc 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2803,7 +2803,8 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
> >      vm_stop(RUN_STATE_SAVE_VM);
> >      global_state_store_running();
> >  
> > -    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT, 0660, errp);
> > +    ioc = qio_channel_file_new_path(filename, O_WRONLY | O_CREAT | O_TRUNC,
> > +                                    0660, errp);
> >      if (!ioc) {
> >          goto the_end;
> >      }

Hi Marek,

Do you know if the above patch is going to work in a linux stubdomain?
Can we truncate the "save file" which seems to be stubdomain's console 1?

Cheers,

-- 
Anthony PERARD

