Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E71C010A2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8998821929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 11:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy3GwtZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8998821929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRwwG-0001tJ-JH
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 06:23:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iRwvW-0001Ps-8p
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1iRwvV-0003Jp-6F
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:23:10 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1iRwvU-0003Fr-Tk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 06:23:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id m17so11175156wmi.5
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 03:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=crDAW9MOspwxI0vnxDiCfFKjwWJ6ptnzUT2Vk51l6dI=;
 b=uy3GwtZhbioGlZRkvKjQRm9Pk4naa7IciJCjUPdAYIE8CJjZG1BLzgcYSgxQwStDB7
 0QqPqzpGO2knXNCipgPrP8ZeMACZe04wGMl8FZv3zEMLsR66bEcO6MvQtkl+lYC9mdo9
 HWxhik2lvXpdRhW1PxLMhtQuYMS+nzKcgarSxsiKPHfUA65k8NcVUfHl+T2yGd2cM5LZ
 W1RkcIW/UgiuvT9EDSr5Qpbzh+EMZ3G3jdGYakC/Xt+giwaGu04PZUNa8iZrJfZlbSmt
 sRzdu/E/6+VYwBQr7jumsbs2vkIxlify4wR0VDLeXcLc9/2hXW2LAiZUBqRjwJjKL48O
 DY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=crDAW9MOspwxI0vnxDiCfFKjwWJ6ptnzUT2Vk51l6dI=;
 b=MKobGhggsziohGOPl9ym/+W9zvmn0ICrmKeoPwuEKfUe7bkCGp5N79jHAmutndoqHC
 zV2GagTuPCr777Z2ByTI35XawYOv1OpTOBQngPsboiRM1T184MWZCoh5nR495NH6jMhk
 GFOchVJDkD73RfzLuo3aANtD8LVGx/34LlIAJ4UNr9dI25KgsYVvZwtTPxRXH7fHnKWp
 bgpcA/8eH4RUXAgo9iqvsvaN66xsEgZOzZYBWLXsAjAZ6PDfAnZLs3Xtbozd9Blfj+3w
 hklfTYiRx0KsYrmxRLW8y53YFoghpS0tQ4mVg7sEue6tfstfpLf8V5IvAfWtFKkfVUiu
 uc9g==
X-Gm-Message-State: APjAAAX4tr1ZghclfCtDeoKgdrkn1Wsjb3rFsLQeDPP7u86OEH1foDTi
 I0A+E+Z4d1ia6HDv1fkcvDhyZ9sv
X-Google-Smtp-Source: APXvYqxcQRWhYKVXE8mrmHidWTPv3w9kdJt5GmE6F/E3UTqXBYx36RBfmuvmZjN/7SmDnPnJcdn44g==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr3937636wmb.40.1572952986777; 
 Tue, 05 Nov 2019 03:23:06 -0800 (PST)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id j14sm25446985wrj.35.2019.11.05.03.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Nov 2019 03:23:05 -0800 (PST)
Subject: Re: [PATCH 0/2] rdma: Utilize ibv_reg_mr_iova for memory registration
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <29dd5f61-e11d-6563-cacc-899040bb4021@gmail.com>
Date: Tue, 5 Nov 2019 13:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190818132107.18181-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Hi Yuval,

On 8/18/19 4:21 PM, Yuval Shaia wrote:
> The virtual address that is provided by the guest in post_send and
> post_recv operations is related to the guest address space. This
> address
> space is unknown to the HCA resides on host so extra step in these
> operations is needed to adjust the address to host virtual address.
>
> This step, which is done in data-path affects performances.
>
> An enhanced verion of MR registration introduced here
> https://patchwork.kernel.org/patch/11044467/ can be used so that the
> guest virtual address space for this MR is known to the HCA in host.
>
> This will save the data-path adjustment.
>
> patch #1 deals with what is needed to detect if the library installed in
> the host supports this function
> patch #2 enhance the data-path ops by utilizing the new function
>
> Yuval Shaia (2):
>    configure: Check if we can use ibv_reg_mr_iova
>    hw/rdma: Utilize ibv_reg_mr_iova for memory registration
>
>   configure                 | 28 ++++++++++++++++++++++++++++
>   hw/rdma/rdma_backend.c    | 13 +++++++++++++
>   hw/rdma/rdma_backend.h    |  5 +++++
>   hw/rdma/rdma_rm.c         |  5 +++++
>   hw/rdma/vmw/pvrdma_main.c |  6 ++++++
>   5 files changed, 57 insertions(+)
>


Can you please rebase on master and add to the patchset your other patches?

Thanks,
Marcel

