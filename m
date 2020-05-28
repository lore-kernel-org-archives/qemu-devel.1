Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC7CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 04:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4785207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 04:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4785207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeAR1-0008Lq-FV
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 00:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeAQ7-0007j5-4r
 for qemu-devel@nongnu.org; Thu, 28 May 2020 00:45:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:41537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jeAQ5-0002Rj-Aa
 for qemu-devel@nongnu.org; Thu, 28 May 2020 00:45:30 -0400
IronPort-SDR: e07cWSbTL7yPFIXcDU92ZbX1jk5KwMZa5SXZZC5O3P5sFH36CIipTLO6lGsqewLRSGk3+7JFKa
 /XlgQEgNY8mQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 21:45:24 -0700
IronPort-SDR: k9U+GXnKm/UEXTUM8iHE3EPY2FebuhwbwTIkLEZt66TdnZy9OaLLSl1bAIoFjFSQYwB5JzjBrN
 /mO2B49QsMWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; d="scan'208";a="468982754"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga005.fm.intel.com with ESMTP; 27 May 2020 21:45:22 -0700
Date: Thu, 28 May 2020 00:35:29 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 1/3] memory: drop guest writes to read-only ram device
 regions
Message-ID: <20200528043529.GA1378@joy-OptiPlex-7040>
References: <20200430080744.31232-1-yan.y.zhao@intel.com>
 <20200430080946.31286-1-yan.y.zhao@intel.com>
 <CAFEAcA-8NH_4ZV0J9urBZdQWmqOe-Nyy4y2gLAjTJ08MpfFY0g@mail.gmail.com>
 <9dd7f00b-1199-1097-80d4-1b700c0f28d6@redhat.com>
 <20200525011853.GB8867@joy-OptiPlex-7040>
 <f836eeb3-0655-2842-2e8a-b8a42710a765@redhat.com>
 <CAFEAcA9vG8RO1A3mSkHGN+ZMisDHzAu3QM5GfCkrDaK-A0Tw9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9vG8RO1A3mSkHGN+ZMisDHzAu3QM5GfCkrDaK-A0Tw9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=yan.y.zhao@intel.com;
 helo=mga17.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 00:45:24
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, xin.zeng@intel.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 10:26:35AM +0100, Peter Maydell wrote:
> On Mon, 25 May 2020 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Not all of them, only those that need to return MEMTX_ERROR.  I would
> > like some guidance from Peter as to whether (or when) reads from ROMs
> > should return MEMTX_ERROR.  This way, we can use that information to
> > device  what the read-only ram-device regions should do.
> 
> In general I think writes to ROMs (and indeed reads from ROMs) should
> not return MEMTX_ERROR. I think that in real hardware you could have
> a ROM that behaved either way; so our default behaviour should probably
> be to do what we've always done and not report a MEMTX_ERROR. (If we
> needed to I suppose we should implement a MEMTX_ERROR-reporting ROM,
> but to be honest there aren't really many real ROMs in systems these
> days: it's more often flash, whose response to writes is defined
> by the spec and is I think to ignore writes which aren't the
> magic "shift to program-the-flash-mode" sequence.)
>
then should I just drop the writes to read-only ram-device regions and
vfio regions without returning MEMTX_ERROR?
do you think it's good?

Thanks
Yan

