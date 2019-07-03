Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E5C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D7F2189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 10:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwnnnNB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D7F2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hicYg-0008Ue-0P
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53186)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hicXV-0007aX-Vj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hicXT-0002e9-T2
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:31:01 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hicXT-0002YW-Mp
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 06:30:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so1822980oti.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/DUW8309CoewVihIDarBLM2D/lOvhXOMkwnXA/Gh+uo=;
 b=uwnnnNB2vNzo0WygPiFnGccxD2RMwmIc2JUsnCfZXNem22glmynOswSG8DlorjuFYe
 3DWUxT+kIBNuKjwfGKP+8TZ9RumJSQc9O4Iz3hZ6M62Q9+/GPda4ofCE5XDdt/4gSHLz
 1OnvB026vlC8F0hhavBGxLiSZCzDgGF3YxbI6qoffTMqsag+vhbeQZS5D/49BBijfS0c
 g8IO0LcQ08Z51Q4VFnREUA2AG4l2mgiipE44mRcYm54YIdrN5oYtnReTSmG94KmdJIVH
 x/Qh89ocpXimtTLnX4m7y5cpR4aQymCVc4AW/PQU3s/igNFf67ymGQ8JdrRoH7WIJG/m
 gV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/DUW8309CoewVihIDarBLM2D/lOvhXOMkwnXA/Gh+uo=;
 b=jO+esLJGDbFhEKp/JeoplhTHjBUfPLDBTauSthwhuhN/uODRvcXxg0T8Dq/41NDmtZ
 Q2mtecpW26e0eVS/22E1kM7c4weW1DWTSItgQ7HRV0CU2mgn7nzvGSXCnUH9cJIIipmY
 g0docvNhJQ4U24xDp82GK0i6IR1t4PQEiuwPkcc8nwdcQWSz2z1nHiaq/yB/Kq26Scya
 W2oBXv9h1lgO8oIUV2YU8xD6/XOLf4tbBdOuOGyUk/n+Nc0ycnRGiiR5az0hSqO0D1+L
 VniDlV0bI6f/KWkQHe9VzxLK7InT2P0VAThiSc2KkRnli7Kr+Yn5/eKECZmS6PtnyoYE
 PVIg==
X-Gm-Message-State: APjAAAWj3DpUGjOmkRE37ZvRdTZXaTR1mOKEgDO/wQ5o3AwaWPJYu6ZY
 z/UCcHWei/7OyCzbxNmkRj8pzGffy5aeXOViZFfltg==
X-Google-Smtp-Source: APXvYqwaZweTJX8JQL2l61oovtGUqxR8IwKZnlC7W3dgCz/a2xzAPvVCbxcfTzy7n5C0b9Ow8mQYro+847Zt7Kanqvc=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr29499106otn.135.1562149856662; 
 Wed, 03 Jul 2019 03:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190703013805.2722-1-chen.zhang@intel.com>
In-Reply-To: <20190703013805.2722-1-chen.zhang@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jul 2019 11:30:45 +0100
Message-ID: <CAFEAcA-P9_2QfRrSLkPCiuzakhNWjJ+Rn56Rtq99_eKGyp7afw@mail.gmail.com>
To: Zhang Chen <chen.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] net/colo-compare.c: Fix memory leak and
 code style issue.
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-dev <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jul 2019 at 02:42, Zhang Chen <chen.zhang@intel.com> wrote:
>
> From: Zhang Chen <chen.zhang@intel.com>
>
> Address Peter's comments in patch "COLO-compare:Add colo-compare
> remote notify support".
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  net/colo-compare.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 909dd6c6eb..363b1edd11 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -1008,21 +1008,20 @@ static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>  {
>      CompareState *s = container_of(notify_rs, CompareState, notify_rs);
>
> -    /* Get Xen colo-frame's notify and handle the message */
> -    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> -    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    const char msg[] = "COLO_COMPARE_GET_XEN_INIT";
>      int ret;
>
> -    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +    if (!strcmp((char *)notify_rs->buf, "COLO_USERSPACE_PROXY_INIT")) {

This is (still) assuming that the buffer you're passed in has a NUL-terminated
string: if not, it could run off the end of it. What you want to check is:
(1) is the packet_len long enough for the string we're looking for
(including the terminating NUL) and
(2) if so, does a simple "compare these N bytes" check match?

Something like

static bool packet_matches_str(const char *str, uint8_t *buf, uint32_t
packet_len)
{
    if (packet_len <= strlen(str)) {
        return false;
    }
    return !memcmp(str, buf, strlen(str) + 1);
}

might be a useful utility function. (notice that we are including the NUL
byte in our comparison check).

In general this code doesn't seem to have been written with an eye
to the packet contents being possibly-malicious. For instance
colo_compare_packet_payload() doesn't seem to check that the packets
actually are both long enough for the length being compared. This
could perhaps do with some review/audit by somebody.

thanks
-- PMM

