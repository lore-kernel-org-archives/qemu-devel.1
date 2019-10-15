Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86CDECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FB520872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astrobotic-com.20150623.gappssmtp.com header.i=@astrobotic-com.20150623.gappssmtp.com header.b="kMLTkYpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FB520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astrobotic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ6U-0000UU-2T
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKQ4x-0006we-3T
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKQ4u-0002vn-7P
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:53:46 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e]:36737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joshua.shaffer@astrobotic.com>)
 id 1iKQ4t-0002ta-OQ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:53:44 -0400
Received: by mail-lj1-x22e.google.com with SMTP id v24so21009023ljj.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=astrobotic-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=QFw9ZK1IuYPMV1Qi9BZnVxVEraLWxMWCKCsoCgv7moM=;
 b=kMLTkYpHY8dFnP4Z3K6K182oTqw+bSaC4NdktUwmcgFNHyQggX/bnI1zy7YM8SeTc5
 Zrk+BtMZvFncKJAHrdhibgq+piLTj+gTU5cqXQ/LPqAUt/I5O1vBhimztcH+Hi3RT29l
 dyUKmoYnPnD/ppKJ892znwGh/ncrYPfWTLzmwuVNGv2u+RLNFjfNsKJyTB0sbylhTOKT
 a3L9NNZFDs5qqYRgGna54SkDy/i/Ewi9vkMn42Bcc8XEDrfAez1wZTQm3lkz9UqEd3KA
 G2PcpeNy2akScF82/d8b7abp8qwmPDC6Q2srL8FNrMN8PJKjLd5xXGUllO4OWFHcoPXn
 XNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=QFw9ZK1IuYPMV1Qi9BZnVxVEraLWxMWCKCsoCgv7moM=;
 b=X88UQfi7SLeyghSjbFD5OBmrVKsXzwWrx9LK6rtkkwF5hsxVYggsoPo2f4ogjhB2OI
 qLw0zHFdmsgT2Hpt2E4D0hTv2aUK0Va6vtK2w9XVCQLTIDyQcU20lV4mFrKcBiwq8FXb
 tqmER0I6eyFkKQ18PM2xJu26oOjcj5Jcxr3812AvHBmgBGwSmZNmzjnqWrdUXfVo2tOz
 IsiZU6HkoyfVBKNgxdb+hV1Mw0JDIb829Ef/cQfdXm3Tx8A5Bo9Mu6n0/e8LSuHAQXPS
 X5wrpAScsXHxPFB1yxp97sTIn+PRvChVeMGr36ZeKHHx8Xj9hmhqLjZhrXhg3qHOkupJ
 zAtw==
X-Gm-Message-State: APjAAAVai+h52HjhR7K+z41jNOtFDA7IK6GQoR3BvIMXeP31idBFRXGX
 DUQFnxpnThew9hVxye44ZyOnUDROvk3LhAYn2ZQih0XxBDw/w7QtZ6OOC2bAubV/5j7o6VQZv0F
 PvyVpr8ZPih7UKH9QHzhYebzDFTw=
X-Google-Smtp-Source: APXvYqytFbexqWxeyP7rDIoQmJV/zW994/cSzOouh7o3UcocWAaGumAZM4F1FanWXwKe2qtTRsoB3ZnQdW+qY6p0Hx0=
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr23613954lja.24.1571158421480; 
 Tue, 15 Oct 2019 09:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
In-Reply-To: <CAPJW7GKLH3pkrGQQj_OaAy0UecUJttsHOJp35+CcpZvm9cM2WQ@mail.gmail.com>
From: Joshua Shaffer <joshua.shaffer@astrobotic.com>
Date: Tue, 15 Oct 2019 12:53:29 -0400
Message-ID: <CAPJW7GKKU3=uNV_f=Qq2hq=Z3qiX=WfP_0_oOozxu6nBjY0Tow@mail.gmail.com>
Subject: Re: LEON3 networking
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::22e
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

Hello,

I've been using the LEON3 port of qemu, and am wondering if anyone has
touched the networking setup for such since the thread here:
https://lists.rtems.org/pipermail/users/2014-September/028224.html


On Tue, Oct 15, 2019 at 9:17 AM Joshua Shaffer
<joshua.shaffer@astrobotic.com> wrote:
>
> Hello,
>
> I've been using the LEON3 port of qemu, and am wondering if anyone has touched the networking setup for such since the thread here: https://lists.rtems.org/pipermail/users/2014-September/028224.html
>
> Joshua Shaffer

-- 
Notice: This message is intended solely for use of the individual or entity 
to which it is addressed and may contain information that is proprietary, 
privileged, company confidential and/or exempt from disclosure under 
applicable law. If the reader is not the intended recipient or agent 
responsible for delivering the message to the intended recipient, you are 
hereby notified that any dissemination, distribution or copying of this 
communication is strictly prohibited. This communication may also contain 
data subject to the International Traffic in Arms Regulations or U.S. 
Export Administration Regulations and cannot be disseminated, distributed 
or copied to foreign nationals, residing in the U.S. or abroad, without the 
prior approval of the U.S. Department of State or appropriate export 
licensing authority. If you have received this communication in error, 
please notify the sender by reply e-mail or collect telephone call and 
delete or destroy all copies of this email message, any physical copies 
made of this e-mail message and/or any file attachment(s).

