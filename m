Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:26:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F2D206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 06:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F2D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeBzc-0000Mi-NJ
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 02:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeBya-0007ae-2d
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:25:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:56942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeByW-0002DN-Qb
 for qemu-devel@nongnu.org; Thu, 28 May 2020 02:25:10 -0400
IronPort-SDR: 3heAl5P/EwIJvE+AwpnT3Wvuy+etmVsvdLxXy13yUxnon6Q7aYZWUN6/4e7A4gPE+fthLTCBK9
 UQkSW1Zl1nQw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 23:25:06 -0700
IronPort-SDR: qL0T7noB9UY7PX/VMOCTKl/M+fXvOaePPK+FseXED/0Al7pYK0lYW/xRBt/f5BMUcWke3tF9CA
 Yo7Uu8gHIckw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="310818881"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by FMSMGA003.fm.intel.com with ESMTP; 27 May 2020 23:25:04 -0700
Date: Thu, 28 May 2020 02:15:11 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200528061511.GC1378@joy-OptiPlex-7040>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <CAFEAcA9vG8RO1A3mSkHGN+ZMisDHzAu3QM5GfCkrDaK-A0Tw9w@mail.gmail.com>
 <20200528043529.GA1378@joy-OptiPlex-7040>
 <bec3aa98-2df2-f1e9-3188-b7c0e395c934@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bec3aa98-2df2-f1e9-3188-b7c0e395c934@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=yan.y.zhao@intel.com;
 helo=mga04.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:25:06
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 28, 2020 at 07:10:46AM +0200, Paolo Bonzini wrote:
> On 28/05/20 06:35, Yan Zhao wrote:
> > On Tue, May 26, 2020 at 10:26:35AM +0100, Peter Maydell wrote:
> >> On Mon, 25 May 2020 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>> Not all of them, only those that need to return MEMTX_ERROR.  I would
> >>> like some guidance from Peter as to whether (or when) reads from ROMs
> >>> should return MEMTX_ERROR.  This way, we can use that information to
> >>> device  what the read-only ram-device regions should do.
> >>
> >> In general I think writes to ROMs (and indeed reads from ROMs) should
> >> not return MEMTX_ERROR. I think that in real hardware you could have
> >> a ROM that behaved either way; so our default behaviour should probably
> >> be to do what we've always done and not report a MEMTX_ERROR. (If we
> >> needed to I suppose we should implement a MEMTX_ERROR-reporting ROM,
> >> but to be honest there aren't really many real ROMs in systems these
> >> days: it's more often flash, whose response to writes is defined
> >> by the spec and is I think to ignore writes which aren't the
> >> magic "shift to program-the-flash-mode" sequence.)
> >>
> > then should I just drop the writes to read-only ram-device regions and
> > vfio regions without returning MEMTX_ERROR?
> > do you think it's good?
> 
> I am not really sure, I have to think more about it.  I think read-only
> RAMD regions are slightly different because the guest can expect "magic"
> behavior from RAMD regions (e.g. registers that trigger I/O on writes)
> that are simply not there for ROM.  So I'm still inclined to queue your
> v6 patch series.
> 
ok. thank you Paolo. :) 

