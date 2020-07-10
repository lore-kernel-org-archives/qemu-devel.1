Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B29EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D8820767
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DA97nfLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D8820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpoM-00008T-By
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtpnl-0007xT-9z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:58:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtpnj-0007tM-QD
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594375118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Gm+P7rBOALP1rvl2Sw/8E/oT1guiMg/+ajKjgnJ5jM=;
 b=DA97nfLuk3YJ7dSYylPlKSCrg+pdkOHVBG24/+M0D9Y2vuY9X9crHrr6f/v7xhrp42W9LL
 qOwVxAgLrJpNBPm2ZXT37sj56/uVZIONFx/6bKOVzKVaIEsOpeGsnjj585IcwlMM+nl9YG
 EI+/xrI0oXa7z2FsSRv90e8KFTQldZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-3axDkCoCNziUqVpkp_1ReQ-1; Fri, 10 Jul 2020 05:58:35 -0400
X-MC-Unique: 3axDkCoCNziUqVpkp_1ReQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0E15800C64;
 Fri, 10 Jul 2020 09:58:33 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-57.ams2.redhat.com [10.36.114.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4F7B7EF8D;
 Fri, 10 Jul 2020 09:58:28 +0000 (UTC)
Date: Fri, 10 Jul 2020 11:58:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
Message-ID: <20200710095827.GD6641@linux.fritz.box>
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair23@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.07.2020 um 16:15 hat Peter Maydell geschrieben:
> On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
> >
> > On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> > > So I manually copy & pasted the change into hw/sd/sd.c to test it.
> > > It looks like the check works, but my concern is that with this change,
> > > we will be getting this error on 'off-the-shelf' images as well.
> > > For example, the latest Raspbian image size also isn't a power of two:
> > >
> > > $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> > > ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> > > WARNING: Image format was not specified for
> > > '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> > > probing guessed raw.
> > >          Automatically detecting the format is dangerous for raw images,
> > > write operations on block 0 will be restricted.
> > >          Specify the 'raw' format explicitly to remove the restrictions.
> > > qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2 GiB)
> > >
> > > If we do decide that the change is needed, I would like to propose that
> > > we also give the user some instructions
> > > on how to fix it, maybe some 'dd' command?
> >
> > On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
> > This is not in the default Darwin packages.
> > On Windows I have no clue.
> 
> dd/truncate etc won't work if the image file is not raw (eg if
> it's qcow2). The only chance you have of something that's actually
> generic would probably involve "qemu-img resize". But I'm a bit
> wary of having an error message that recommends that, because
> what if we got it wrong?

What is your concern that we might get wrong? The suggestion is always
extending the size rather than shrinking, so it should be harmless and
easy to undo. (Hm, we should finally make --shrink mandatory for
shrinking. We've printed a deprecation warning for almost three years.)

Kevin


