Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FE1C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AFE4206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 17:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFE4206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOG8-00019S-C0
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 13:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWOFU-0000Py-Ei
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:54:24 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:33674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWOFT-0007mk-CK
 for qemu-devel@nongnu.org; Wed, 06 May 2020 13:54:24 -0400
Received: from player718.ha.ovh.net (unknown [10.108.42.215])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5D9B4165077
 for <qemu-devel@nongnu.org>; Wed,  6 May 2020 19:54:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id A0E64120156A0;
 Wed,  6 May 2020 17:54:17 +0000 (UTC)
Date: Wed, 6 May 2020 19:54:15 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH] 9pfs: Fix potential deadlock of QEMU mainloop
Message-ID: <20200506195415.4cc48810@bahia.lan>
In-Reply-To: <3204505.kZXhZKLjgj@silver>
References: <158826201391.1344781.9403916162733181811.stgit@bahia.lan>
 <4216293.sUgoX00Q1d@silver> <3204505.kZXhZKLjgj@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17999198861922113856
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeekgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedukedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.43.140; envelope-from=groug@kaod.org;
 helo=5.mo179.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 13:54:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 06 May 2020 15:36:16 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Mittwoch, 6. Mai 2020 15:05:23 CEST Christian Schoenebeck wrote:
> > > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > > index 9e046f7acb51..ac84ae804496 100644
> > > --- a/hw/9pfs/9p.c
> > > +++ b/hw/9pfs/9p.c
> > > @@ -2170,7 +2170,7 @@ static int coroutine_fn
> > > v9fs_do_readdir_with_stat(V9fsPDU *pdu, int32_t count = 0;
> > > 
> > >      struct stat stbuf;
> > >      off_t saved_dir_pos;
> > > 
> > > -    struct dirent *dent;
> > > +    struct dirent dent;
> 
> One more: since this dirent structure is now on the stack, it should better be 
> initialized for safety reasons.
> 

I don't think so, for two reasons:
- I can't think of an initializer that would make sense for a dirent
- if a future change introduces a branch where dent could be used
  uninitialized, I'd rather give a chance to the compiler to bark

> Best regards,
> Christian Schoenebeck
> 
> 

