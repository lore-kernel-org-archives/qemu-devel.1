Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D83C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:27:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597132187F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIcje9jK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597132187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i491t-0007fS-Ds
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i490l-00079p-OE
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i490j-0006eM-Fh
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:26:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i490j-0006dn-7U
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:26:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id n2so9366976wmk.4
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=jHQxqB+ODojOU3iI7E1aOuFRrV975NLoVP/4Zo7NLoA=;
 b=tIcje9jK2GqbDYnaBmYfcpxLDj3Jd+utNGbuUZKn+AphlyxdV3DAiPApKfv6WVJchQ
 kAiajUlfd0nbiZ6gBmIQrXW74D7hj2mquaPB0egLSSyDHwGPHfeotVMumb1UVC4MAWNV
 9sDyvhU4ayo10Sjs4ozus62z3fbpojiEkCZHpWUMOW+Sc2N9SmQjgPbU3+W+MQxwqDan
 42zxyV3ANcc4w2CzEUeV0nla0vVb653SDgrQRmaU58X4iyKwbSMYnXh5x3VNzj6rzD/Y
 fDvq79uFnNk0y57oPC643ZIkAXYIC8+4dKjrWVBuTpwxXRqpqug/V0Plc77iuBnUD8aR
 6vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jHQxqB+ODojOU3iI7E1aOuFRrV975NLoVP/4Zo7NLoA=;
 b=McMLkFcAKt+D5srp9AGnl/gFlLM+4riTgY1iWTccDyJuUf2gKqZushi3bs42R0OkGJ
 kJKM7+afZElP9NQpdushHw5pJheKRxEXXSk2ujHK33w5nLNBsIXrYjZrUK+hG0bWHVT2
 APxIuydNI0mqCFMIaGwljwNQ3IirztICdQk60MCmVZE6qvVAX5o4Qo6VCCgQRM+TppeW
 8YC9vICTBPZ8Qd9HBNeoRGMp3XVmcA0SxBAm03mRNqk5fgI6FsySr9uHuuKuj5sRTm3+
 f7xcfxyHNDmPsrGhwW1404+6TmoWaR8bQVActwDo5DDnP44MWCLTxhPcJsjFaNE6kdsC
 K30Q==
X-Gm-Message-State: APjAAAVI+w4YYQVt98FowcF9Ru3WAkJSlnw8R+48cIaF1JBIVy1/KURO
 5/6/Q5XsrImrR1iQHxm2UHrU1pxd0u8=
X-Google-Smtp-Source: APXvYqyESEXqYIUHnoXf6NfDb3qcjG3NW6O8Qvj+VfLQMSqluA/pMjEWV06XcOyrq+/m5WYJB3D6TA==
X-Received: by 2002:a1c:d183:: with SMTP id i125mr11927403wmg.1.1567279567501; 
 Sat, 31 Aug 2019 12:26:07 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id a141sm25478303wmd.0.2019.08.31.12.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:26:06 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, berrange@redhat.com,
 thuth@redhat.com, philmd@redhat.com, pbonzini@redhat.com, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20190818132107.18181-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <00299ddb-dbf9-6ea2-fde6-dd66956867ad@gmail.com>
Date: Sat, 31 Aug 2019 22:26:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190818132107.18181-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 0/2] rdma: Utilize ibv_reg_mr_iova for
 memory registration
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

Nice work on kernel side !
Thanks,
Marcel

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


