Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11397C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F4C20718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KIoVwB+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F4C20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqNX-00047b-2l
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqMi-0003Yk-Nc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibqMh-0008Q6-P6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:24:08 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibqMh-0008PY-KY
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:24:07 -0500
Received: by mail-oi1-x244.google.com with SMTP id b8so576126oiy.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=N6tE3Gl+YL/gnN9cI/JoRh0/ptDCZUGoGmUrLUqtfPA=;
 b=KIoVwB+g2xZRTRyivQl3lHKbHqDW7+fKT8JSbn9ycCIo5oC/NPXK98bIBiUDDtDmza
 CoLmCMwYaDlZMdg9wSmfCPNXy7UgAG4OUuggUlpiFbj3DZ689stO+gTD5I4pj4xea15t
 AB0ilFOUVV9UKBw/o5jiyrMKzPHp2W8Y4OHxM6j1dm3uFVJd14rpbrTsVetvVhOb7RVJ
 qN3E8lvvNc6DTa1LaUWkIpjx5iafhUyPevmaZIC8pTOg5dhlEMB0WHXW6WrQwDwlr6eE
 yD6/71+fz9AjiqA1MIVaqWd06m2BPuScvbh5hggXw+ia9dQCg/4q84kAX4Ov+hHkvmKp
 GR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N6tE3Gl+YL/gnN9cI/JoRh0/ptDCZUGoGmUrLUqtfPA=;
 b=CAduqrnLVjs2Pkt4t9h6a7Ah8Ysr0oN5HGkIrzTS0n9c4HMyOIsoKIeTPY+b+WyBbX
 1WHofotKDdevMNy3rwKbGfrv37pmI41/F/z/P8QVEMRbrYFjHHeWIH+Y5yTsg1yWcM17
 EWOxjflwO7ckfbBFjyWETkgUeDY1pm/YiH/rB1M7MsG0AuWMvrYuzB/PZQpTFoXc8D8D
 v9xmx4C6H70tkK4w4cZR0mcwmuQkHqltfYz7+DbUaAIDuPilE7JjYBLvLJKdYkLDHor2
 Bhjf4TZae2SBqxDXDFSl9nFUEJWLdkIy3PfU2sdL+VOqHZ+k/DzZQFaMjvJxIJc9Ysuo
 568A==
X-Gm-Message-State: APjAAAVY+RZnqhnV9yFXZblyQyMzvRq18AU/UOhlDaJoHvXZIYY/Oxex
 rsC5oZrAvC2LcxavuZD/veahFrIFxV/xrICAownvHQ==
X-Google-Smtp-Source: APXvYqw0vqAYx40bDkI5iYCYuymZq09hHslD8P+AVC8IjBFIdxz6qxqVUAusAje5nsc//jcgd/17CJBqsVxWqeUeD6o=
X-Received: by 2002:aca:f484:: with SMTP id s126mr349470oih.48.1575311046960; 
 Mon, 02 Dec 2019 10:24:06 -0800 (PST)
MIME-Version: 1.0
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-5-zhengxiang9@huawei.com>
In-Reply-To: <20191111014048.21296-5-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 18:23:56 +0000
Message-ID: <CAFEAcA8Bve1TF0VdDJExx9AoWbhNPivSYzg=CVba_EbdRoaECQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v21 4/6] KVM: Move hwpoison page related functions
 into kvm-all.c
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 Nov 2019 at 01:44, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> kvm_hwpoison_page_add() and kvm_unpoison_all() will both be used by X86
> and ARM platforms, so moving them into "accel/kvm/kvm-all.c" to avoid
> duplicate code.
>
> For architectures that don't use the poison-list functionality the
> reset handler will harmlessly do nothing, so let's register the
> kvm_unpoison_all() function in the generic kvm_init() function.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

