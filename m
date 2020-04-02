Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D85C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBC32063A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9+AwPF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBC32063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvyO-00027m-Ul
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51422)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bharata.rao@gmail.com>) id 1jJvxa-0001YW-DV
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bharata.rao@gmail.com>) id 1jJvxZ-0000aR-9P
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:16:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bharata.rao@gmail.com>)
 id 1jJvxW-0000IJ-1o; Thu, 02 Apr 2020 05:16:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id j17so3202179wru.13;
 Thu, 02 Apr 2020 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iAhtxVtaOds6eK1YH4pS9WVZaNOsJiu1o5+S01e/E4o=;
 b=Q9+AwPF6u/Pc1/7MLTUdfDnQ0H9ejTMCIJv45qfpFafyMRrEguMCcM1rZ0L/Zc7p+s
 oyl7oAawQ1CEN1RYm0eMqkAFCM73w5YsZ3FS3rMSh8Vd9lEmD28Gg8SSIyF9hUuCi6Re
 /FMbXYt56EV7cps9YiFQ8Opb7QXSirWnSrKIV2bnRop/9iV7MthDqrzOUzH+FH3/f/OX
 vz2kR2he06ummjXSfn0XnwLX7F5gabj/Es8TAg9BGWMbx8RRIOjh5+5TVOCh3Ho2IFHG
 u2XJnkBPZWN/iQGK3S9sOQ+yb1Ey/3PfDu4+qKlpF43W6d6SB+wCYSb3mhYlhAQbrEte
 HWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iAhtxVtaOds6eK1YH4pS9WVZaNOsJiu1o5+S01e/E4o=;
 b=Ic9p2UxDnB27+hM0MdXvd7+Jky0Xy5p68AI8iguNv+FJiT4/T4FlHM/fU37I/fYbsc
 OL7gNkkKY3OKX5RkEbg7sT+VhbT34wu6mg4Brrb8RPu7Vi/a/AqU5dwP7ueuY7rNyErY
 f7f4p4BNGv9KsAIDxx8ENlVGd0EVRkMV4UEEW5O3e34eosVN5UzcpIP3XgbIi4CBdsRP
 3SyX+EFhQHFSvSmuK9JW5ei78adSb6gFKghJB/twBIOJepnvrc+QzelNBUanRNfrB6aK
 UyL+h8dN+K0x+PZOfQ9KN9g24jRk0ql97VF2hjkO3R3L94cB/1vd3vJgvuPEJXI/Es7H
 ZYMw==
X-Gm-Message-State: AGi0PuaJhPRTs21+vfrPVMv7c45luIa96mC4aQFdw+QtAU+ah+ahVW4R
 qWDQLxSwgXHlo3AOmrK2wheEUvS1KheVoQGtOPo=
X-Google-Smtp-Source: APiQypJ3rxa+z2fsndWOX60AnFEaTG85k8T1fndG5w2dcXgKQrXmoAms+pikOWIJtcK2hqe96vdwjLUdUbI79XWBJ/s=
X-Received: by 2002:adf:f1c2:: with SMTP id z2mr2609375wro.40.1585818980633;
 Thu, 02 Apr 2020 02:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200306002202.176732-1-leonardo@linux.ibm.com>
 <20200310023943.GH660117@umbus.fritz.box>
In-Reply-To: <20200310023943.GH660117@umbus.fritz.box>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Thu, 2 Apr 2020 14:46:09 +0530
Message-ID: <CAGZKiBpO4HxrE06dT39sj95_qcTvQK_g5Ev5TKC5T9wimphM_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] ppc/spapr: Add hotplugged flag on DIMM LMBs on
 drmem_v2
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Leonardo Bras <leonardo@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Bharata B Rao <bharata.rao@in.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 8:24 AM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Thu, Mar 05, 2020 at 09:22:02PM -0300, Leonardo Bras wrote:
> > On reboot, all memory that was previously added using object_add and
> > device_add is placed in this DIMM area.
> >
> > The new SPAPR_LMB_FLAGS_HOTPLUGGED flag helps Linux to put this memory in
> > the correct memory zone, so no unmovable allocations are made there,
> > allowing the object to be easily hot-removed by device_del and
> > object_del.
> >
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> >
> > ---
> > The new flag was already proposed on Power Architecture documentation,
> > and it's waiting for approval.
> >
> > I would like to get your comments on this change, but it's still not
> > ready for being merged.
>
> This looks reasonable to me - at the very least it doesn't look like
> it could do much harm.

Looks good to me, also tested with PowerKVM guests.

Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/

