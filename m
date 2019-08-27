Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7FAC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDA0206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8qRLah+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDA0206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2X3i-0002Bb-5r
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1i2X2C-0001DE-C5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1i2X2A-0000aN-LX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:41:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1i2X2A-0000Zr-5a
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:40:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id l2so14340819oil.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hcR6YGHKWqdse/gboZA+/hEJJEu2phk8w40HKMGuUw8=;
 b=j8qRLah+RCHfQ1yLOoEZZn/I4A76qcsJS7OxeaWA5OxQaCO3RCYrjqVIR6SoKZbFPY
 w5IIiRm6b15UeGNgqHyDKo48No0I5uK/VasSgvOs58F9ybFSiukHgYvA6BUNO28WlzQT
 nTjF1Fgc0ErIgDz/O2gZWZGyhVVuaIjhKN384kqxhtl1vWSuq/dBATBo+Ndngv92Up9Z
 H4V1BUMoCb2yrSei2EwygcqnlHbIyeyYYItjjr7CdRlzUUseL/093urlvXnEItCwvWKK
 b0h4J6tnF4+XpX4+vcmMfMKskk3jpxEhEhwEuOaJxHO3hcE6WeXK3yF6D/IyPNx9cp9d
 YuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hcR6YGHKWqdse/gboZA+/hEJJEu2phk8w40HKMGuUw8=;
 b=SH3Ya5VEuNOssni5yrbA3vHqwPGCrAYQIqhs+Jmp8A9Omz8aFSbXH55Z8dKuDYuw1l
 JpzucJQMWfXBnJvUau1i0gleLAK53VZio1BKIzG2xjhsWZweYEbM7lx38MbHu23a4REt
 qYob4yNbeP306vufSZKCndjxbTpuicaxlMz2QSfms7uxxqOTaE6Dkic7M0tK4mNYMdJt
 p+cd2LcD0hwAyLhaYMYK6jz4/6nPuS5hfU/Q4TXelvmZJ6RgVUeWDYw+dO3DtgpTezts
 IQ+Dfs3LVSBj+BSdMhbNtWCTKneu95Mj8i8AkedGH5o1gKaOoFE05alcErcteA2AkJKQ
 0Xlw==
X-Gm-Message-State: APjAAAVr9RFYTsT7u1RO5Y91r0VDhe1jnatur9l2NSObj72lEri6jRnd
 QQeFwW79BE6GfsfinAdEupAUI98EalkavdMju8U=
X-Google-Smtp-Source: APXvYqwdOczJNndXpSUk0cK28SipVVJPY2jO8BPPHHxelnEcsiX3RIkS5At1R3HlWgE/Ax2LVwJnoRGhprhDineDoPw=
X-Received: by 2002:aca:1a08:: with SMTP id a8mr14979849oia.150.1566895257288; 
 Tue, 27 Aug 2019 01:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190827080209.2365-1-fangying1@huawei.com>
In-Reply-To: <20190827080209.2365-1-fangying1@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 27 Aug 2019 16:40:21 +0800
Message-ID: <CAKXe6SJfkeY=pOiw4_46ZPCFTwfZ=-R++b-i+ePfxYKRSk=Qcw@mail.gmail.com>
To: Ying Fang <fangying1@huawei.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] xhci: Fix memory leak in xhci_address_slot
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
Cc: lcf.lichaofeng@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Qemu Developers <qemu-devel@nongnu.org>, zhouyibo3@huawei.com,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ying Fang <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:03=E5=86=99=E9=81=93=EF=BC=9A

> Address Sanitizer shows memory leak in xhci_address_slot
> hw/usb/hcd-xhci.c:2156 and the stack is as bellow:
>
> Direct leak of 64 byte(s) in 4 object(s) allocated from:
>     #0 0xffff91c6f5ab in realloc (/lib64/libasan.so.4+0xd35ab)
>     #1 0xffff91987243 in g_realloc (/lib64/libglib-2.0.so.0+0x57243)
>     #2 0xaaaab0b26a1f in qemu_iovec_add util/iov.c:296
>     #3 0xaaaab07e5ce3 in xhci_address_slot hw/usb/hcd-xhci.c:2156
>     #4 0xaaaab07e5ce3 in xhci_process_commands hw/usb/hcd-xhci.c:2493
>     #5 0xaaaab00058d7 in memory_region_write_accessor qemu/memory.c:507
>     #6 0xaaaab0000d87 in access_with_adjusted_size memory.c:573
>     #7 0xaaaab000abcf in memory_region_dispatch_write memory.c:1516
>     #8 0xaaaaaff59947 in flatview_write_continue exec.c:3367
>     #9 0xaaaaaff59c33 in flatview_write exec.c:3406
>     #10 0xaaaaaff63b3b in address_space_write exec.c:3496
>     #11 0xaaaab002f263 in kvm_cpu_exec accel/kvm/kvm-all.c:2288
>     #12 0xaaaaaffee427 in qemu_kvm_cpu_thread_fn cpus.c:1290
>     #13 0xaaaab0b1a943 in qemu_thread_start util/qemu-thread-posix.c:502
>     #14 0xffff908ce8bb in start_thread (/lib64/libpthread.so.0+0x78bb)
>     #15 0xffff908165cb in thread_start (/lib64/libc.so.6+0xd55cb)
>
> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Ying Fang <fangying1@huawei.com>
> ---
>  hw/usb/hcd-xhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index f578264948..471759cd4c 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -2161,6 +2161,7 @@ static TRBCCode xhci_address_slot(XHCIState *xhci,
> unsigned int slotid,
>                                    DeviceOutRequest | USB_REQ_SET_ADDRESS=
,
>                                    slotid, 0, 0, NULL);
>          assert(p.status !=3D USB_RET_ASYNC);
> +        usb_packet_cleanup(&p);
>      }
>
>
Looks good to me.

Reviewed-by: Li Qiang <liq3ea@gmail.com>



>      res =3D xhci_enable_ep(xhci, slotid, 1, octx+32, ep0_ctx);
> --
> 2.19.1
>
>
>
>
