Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58577C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218AC2067B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnv6e6QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 218AC2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXnC-0005L3-6G
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 10:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXix-0008M4-Jf
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:04:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1iUXis-0004Rx-Jq
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:04:55 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1iUXis-0004RN-Ef
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 10:04:50 -0500
Received: by mail-il1-x142.google.com with SMTP id a7so15368474ild.6
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aZGDbtndWOMKAw2Lgf48Y968nKr28g4QRlcQ3K84CR4=;
 b=gnv6e6QOO9WGrFVtjijJXSFUy0kQxny2NLkBhluHZp0rzQo/VzSMNgxEJh/wC3QaAA
 Iz/ewoAOO2C2oE880U+pXsQ6A4fRa/hKNifdUJAa/ITBIANiQIoLYptB6q/JiZ3S0rZM
 8SHJc/mx7PWWUp81DuZpcKhZ5VKmvmIjC6RXS8kBO6uTl98hzb0H2kyaDfR9vo99INA/
 W2gLmItkY/8WcLYnnYWqH+ZiHNTo1wSXs/OU+qPDWD+XqF027a8bRgYNBJzV9/nLua4B
 aoqaM3Fu3Wa5wm9ydkNuje7lk9PbqPB33OP4/l8v8WwsbfCWq5kop/Xc7pLrVhMLJFo0
 0lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aZGDbtndWOMKAw2Lgf48Y968nKr28g4QRlcQ3K84CR4=;
 b=A1zeMwnEPx+kpyjBfGLRrqQWgs1EYTFXE/4QzRWlQ+Lo43O21o06nQBZX0P6+l3wep
 ZL2SldWOky69UoWE2wJTR27nyczcVIs3A43TNSl4IYT++1i115tg7EGlwqzEtiWvQ+kz
 bu0rlVuOYxP0s+zyfA1IL7MI6HzTWW49tNynTuHKBTZLlMDEctprjjKzaExsGK5SfwOD
 /NuUT9HX7q1PvMWUpsEcADBAglglPfpEwjj7+iBDDYpsesATaYqSYKku5XcyarAjsbcU
 3ULiY/Y2x/LYDXQGuPh9FKMbR1umhal9t7yv3NCFFEpvmKrdAHRd7zvZN/lwD6BWDp3S
 m6mQ==
X-Gm-Message-State: APjAAAWFooEPvZ43MyOTYfYqE1uGita2rE7dbT8tSDMwfv8odFDZimKP
 yZv7muB29+mbPRXxG4ng9kzlV86sS7Ngn8WILid/LA==
X-Google-Smtp-Source: APXvYqzZj5ieHKarWMQt56PXnjFhqLDHjx9ddz010jINsRAuf7orP5Yn4MJdvBFyS2qll6CEGkF4kO8CFI6jvaAAkys=
X-Received: by 2002:a92:b00f:: with SMTP id x15mr18893925ilh.248.1573571089387; 
 Tue, 12 Nov 2019 07:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20191015103900.313928-1-its@irrelevant.dk>
 <20191015103900.313928-7-its@irrelevant.dk>
In-Reply-To: <20191015103900.313928-7-its@irrelevant.dk>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 12 Nov 2019 15:04:38 +0000
Message-ID: <CADSWDzt2gjQ6pvzm2A29hqiNAf1RSD=qTwjELLB3fTD4Yjbryg@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] nvme: add support for the abort command
To: Klaus Jensen <its@irrelevant.dk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Javier Gonzalez <javier@javigon.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <keith.busch@intel.com>, Paul Durrant <Paul.Durrant@citrix.com>,
 Stephen Bates <sbates@raithlin.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus

On Tue, 15 Oct 2019 at 11:41, Klaus Jensen <its@irrelevant.dk> wrote:
>
> Required for compliance with NVMe revision 1.2.1. See NVM Express 1.2.1,
> Section 5.1 ("Abort command").
>
> The Abort command is a best effort command; for now, the device always
> fails to abort the given command.
>
> Signed-off-by: Klaus Jensen <klaus.jensen@cnexlabs.com>
> ---
>  hw/block/nvme.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index daa2367b0863..84e4f2ea7a15 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -741,6 +741,18 @@ static uint16_t nvme_identify(NvmeCtrl *n, NvmeCmd *cmd)
>      }
>  }
>
> +static uint16_t nvme_abort(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
> +{
> +    uint16_t sqid = le32_to_cpu(cmd->cdw10) & 0xffff;
> +
> +    req->cqe.result = 1;
> +    if (nvme_check_sqid(n, sqid)) {
> +        return NVME_INVALID_FIELD | NVME_DNR;
> +    }
> +
Shouldn't we validate the CID as well ?

> +    return NVME_SUCCESS;
> +}
> +
>  static inline void nvme_set_timestamp(NvmeCtrl *n, uint64_t ts)
>  {
>      trace_nvme_setfeat_timestamp(ts);
> @@ -859,6 +871,7 @@ static uint16_t nvme_set_feature(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          trace_nvme_err_invalid_setfeat(dw10);
>          return NVME_INVALID_FIELD | NVME_DNR;
>      }
> +
>      return NVME_SUCCESS;
>  }
>
> @@ -875,6 +888,8 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeCmd *cmd, NvmeRequest *req)
>          return nvme_create_cq(n, cmd);
>      case NVME_ADM_CMD_IDENTIFY:
>          return nvme_identify(n, cmd);
> +    case NVME_ADM_CMD_ABORT:
> +        return nvme_abort(n, cmd, req);
>      case NVME_ADM_CMD_SET_FEATURES:
>          return nvme_set_feature(n, cmd, req);
>      case NVME_ADM_CMD_GET_FEATURES:
> @@ -1388,6 +1403,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>      id->ieee[2] = 0xb3;
>      id->ver = cpu_to_le32(0x00010201);
>      id->oacs = cpu_to_le16(0);
> +    id->acl = 3;
So we are setting the max number of concurrent commands
but there is no logic to enforce that and wrap up with the
status suggested by specification.

BR


Beata
>      id->frmw = 7 << 1;
>      id->lpa = 1 << 0;
>      id->sqes = (0x6 << 4) | 0x6;
> --
> 2.23.0
>
>

