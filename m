Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E1C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7136420786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxLcGLtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7136420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhOB-000183-KL
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhNX-0000hj-HN
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhNW-0002Lb-8f
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:05:51 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGhNV-0002KE-PU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:05:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id j16so16609604otl.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XwqWgdKPJDgU3ozU2N079p5j/O2TTB3pl60LapRC5kw=;
 b=WxLcGLtWDwQm6Ac9z7ecNkBxbpkrq33gvAFLEi/4Vro0sN/qtU/gXwY6I6LIuXOKJg
 2Q53C5yurz/cKKT2Gt9n3IDiVVXk5e7aNLvXzrV1qXpAPXe4z2s1fajiQwSiT4B+8xTP
 oP236/wpykm8iKHe02LGn1yNz6JGqok+Yi1ri8PheKTFGqXrpqurdOPSzvfuG3ElXT0h
 1VsC4JZfcTgY/wR5TxpBI+tdJvknWkkm3ePYkOFvln8hCwiFnjdkYIgH7VGPPT13uzJZ
 wR5HuXmVfL5Zv7NRT8+qsIPg4wzheEgK8/2sdXyTxccfchsu3Vj8Pm6n5OOXd50eiWRV
 hIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XwqWgdKPJDgU3ozU2N079p5j/O2TTB3pl60LapRC5kw=;
 b=QkU8rfHVIDT/ldIBP8TyOHoqYEuKIxArCJXcQmzG/YWFLNqRBN/oTBX62X9vtuKFpo
 GN8Pe+Z9Z81BAzw0jlXX4MAgyIjB3fOzTMAwiWt3Nl2eMSR+/euPNcKOi/qiY8P+ORy2
 4HDjrTBkhW7rxIa/plVkvKUzgZS5PLU4+ZfkJhlVZqCsP5xP4w+VNrwK+xAy3Na3be1k
 YPjgEbUBVFOhPyQ/NiPKVetD137hyIOS7yb4U4LaHGaqzAnGiaPzThaipgiIsb3s6H0b
 lS4eucDHeU9KyT1ZGrZV3bke6c+t2WpJOztusKJuWgIdaPazQ9k30dNuywm/VOPF59t0
 hDHQ==
X-Gm-Message-State: ANhLgQ1fyPUmAi2qbB0geaiG0+Mudze2inu8UctPrQWfYpO9zcopgeGs
 xyJlLcLxYT04PwWPfDulB0xysoGC6WZf2apUlhYrWA==
X-Google-Smtp-Source: ADFU+vvYjrCujrynlhBYmV4RfZjftZro8wJtK0EOWnlmbKdAbPZLbQSwBAnMjj7groF00irUuZVAvQU86Ofq3uYK5ew=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr6488099oth.135.1585047948390; 
 Tue, 24 Mar 2020 04:05:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
In-Reply-To: <20200324105356.7998-1-yuval.shaia.ml@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 11:05:37 +0000
Message-ID: <CAFEAcA_D3ykX2mJwtJhvdQg3psCX9NdcG0xq4qmP3CkqHtnY8Q@mail.gmail.com>
Subject: Re: [PATCH] hw/rdma: Lock before destroy
To: Yuval Shaia <yuval.shaia.ml@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 10:54, Yuval Shaia <yuval.shaia.ml@gmail.com> wrote:
>
> To protect from the case that users of the protected_qlist are still
> using the qlist let's lock before detsroying it.
>
> Reported-by: Coverity (CID 1421951)
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> ---
>  hw/rdma/rdma_utils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/rdma/rdma_utils.c b/hw/rdma/rdma_utils.c
> index 73f279104c..55779cbef6 100644
> --- a/hw/rdma/rdma_utils.c
> +++ b/hw/rdma/rdma_utils.c
> @@ -63,6 +63,7 @@ void rdma_protected_qlist_init(RdmaProtectedQList *list)
>  void rdma_protected_qlist_destroy(RdmaProtectedQList *list)
>  {
>      if (list->list) {
> +        qemu_mutex_lock(&list->lock);
>          qlist_destroy_obj(QOBJECT(list->list));
>          qemu_mutex_destroy(&list->lock);
>          list->list = NULL;

Looking at the code a bit more closely, I don't think that taking
the lock here helps. If there really could be another thread
that might be calling eg rdma_protected_qlist_append_int64()
at the same time that we're calling rdma_protected_qlist_destroy()
then it's just as likely that the code calling destroy could
finish just before the append starts: in that case the append
will crash because the list has been freed and the mutex destroyed.

So I think we require that the user of a protected-qlist
ensures that there are no more users of it before it is
destroyed (which is fairly normal semantics), and the code
as it stands is correct (ie coverity false-positive).

thanks
-- PMM

