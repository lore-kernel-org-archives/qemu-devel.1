Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019FBC38A30
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA1F2078C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 01:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qV+58n4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA1F2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQiAQ-000333-Vn
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 21:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1jQi8m-0001ae-5b
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <catherine.hecx@gmail.com>) id 1jQi8l-0001iP-8S
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:55:59 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <catherine.hecx@gmail.com>)
 id 1jQi8k-0001cu-RU
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 21:55:58 -0400
Received: by mail-ot1-x341.google.com with SMTP id i22so9954751otp.12
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=pbpDpzwuc37elqn6xpCX67LptLbqHSgw6Ba55yzQli4=;
 b=qV+58n4TXRQ/s2RUF202RWsMWCRPeV4jpn/TpWOfqlONsTv+wJ0y7YakrIYuVHg5/1
 d/li9w0TIkNTlo8xhmRzGU91zLdXwmz5FSVa04G0yyL0N3zLApRRHkTbAGMUVI+ontV8
 1/IrvICFvIBUtWVSqPW8oLfQ9+IX5UGie6bwvcdph/WYe99v0yuw7JP6AMG6H3WGijB1
 AoVZoWE9hwA9VBc+EgHyLpq+duJeyjpJNwAPkyiqOfmVG8d9FOUG6VrXHNm70aXlKNo/
 oiHbXsbGWuyr5cHxNLk6BcZOuWdTDk4O+QMKEiggyM8PHfqDTcrytjcys+lma+DGBdkY
 1IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=pbpDpzwuc37elqn6xpCX67LptLbqHSgw6Ba55yzQli4=;
 b=PUHw9NRPEMfbyyPf/vSm+0qFRPXmQu0flTcoj2KE04nIO9ncYFhl//QepPMkoq8Xtl
 3KeHr9QtkemQ9N4e8SI6+W/RR43L2CtUxQFA4uEpRw/QN7di9k7CBMXDpHNlx2uoKrD7
 XRywjCxsryVOiIMzOYBxz91OMtju85LOW2T25Dn4XTN7JF95OiT7RA53WPNLIz1n29lb
 G/S5GXwiC0bJNVj2lT7Q//s0wcfhL43xvcQcCnPGS0/ZMXG01vyb9WXyHXu9TZMUoVOT
 72wNGbMjAFn2JRZjkWgcM9aqzLjTRf+I/cuNut0yAdOj7LTleu2g1N3TRfkKwPSA9hLn
 /VqA==
X-Gm-Message-State: AGi0Pub+1IG0HQcioM4pcvG1eas2DRxlXiq1CDYRzmRqiMF5l9r+cwUO
 /OnyphMaU6W003ftGDpcSCsxu119PQdaGbUA8gM=
X-Google-Smtp-Source: APiQypKA/FyvL4+KX8TNRqGuBL7mbZHyZ0IN+E8FfunMrtkEWu4PF8Iqg7I3iPLqlHXLIhqaLEgT7vnDPGd331uBFaE=
X-Received: by 2002:a9d:620c:: with SMTP id g12mr12248054otj.158.1587434157368; 
 Mon, 20 Apr 2020 18:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <1586585997-24446-1-git-send-email-catherine.hecx@gmail.com>
 <1586594144-24605-1-git-send-email-catherine.hecx@gmail.com>
In-Reply-To: <1586594144-24605-1-git-send-email-catherine.hecx@gmail.com>
From: Catherine Ho <catherine.hecx@gmail.com>
Date: Tue, 21 Apr 2020 09:55:45 +0800
Message-ID: <CAEn6zmF5=cvqPz0UZsEs=a+GRm08Os-Vhnyun4PP73w54kUhXQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtiofsd/passthrough_ll: don't remove O_DIRECT when
 cache=none
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=catherine.hecx@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::341
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

Ping :)

---
B.R.
Catherine

On Sat, 11 Apr 2020 at 16:41, Catherine Ho <catherine.hecx@gmail.com> wrote:
>
> cache=none means to bypass host cache. So we can't remove O_DIRECT flag in
> unconditionally in update_open_flags();
>
> Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> ---
> v2: Fix to keep flags unchanged if cache=none, otherwise changed the file
>     without O_DIRECT incorrectly.
>  tools/virtiofsd/passthrough_ll.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 4c35c95..59e64dd 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -1677,7 +1677,8 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
>      fuse_reply_err(req, 0);
>  }
>
> -static void update_open_flags(int writeback, struct fuse_file_info *fi)
> +static void update_open_flags(int writeback, int cache_mode,
> +                              struct fuse_file_info *fi)
>  {
>      /*
>       * With writeback cache, kernel may send read requests even
> @@ -1702,10 +1703,11 @@ static void update_open_flags(int writeback, struct fuse_file_info *fi)
>
>      /*
>       * O_DIRECT in guest should not necessarily mean bypassing page
> -     * cache on host as well. If somebody needs that behavior, it
> -     * probably should be a configuration knob in daemon.
> +     * cache on host as well. If cache=none, keep the flag unchanged
>       */
> -    fi->flags &= ~O_DIRECT;
> +    if (cache_mode != CACHE_NONE) {
> +        fi->flags &= ~O_DIRECT;
> +    }
>  }
>
>  static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
> @@ -1737,7 +1739,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
>          goto out;
>      }
>
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->cache, fi);
>
>      fd = openat(parent_inode->fd, name, (fi->flags | O_CREAT) & ~O_NOFOLLOW,
>                  mode);
> @@ -1947,7 +1949,7 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi)
>      fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=%" PRIu64 ", flags=%d)\n", ino,
>               fi->flags);
>
> -    update_open_flags(lo->writeback, fi);
> +    update_open_flags(lo->writeback, lo->cache, fi);
>
>      sprintf(buf, "%i", lo_fd(req, ino));
>      fd = openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
> --
> 1.7.1
>

