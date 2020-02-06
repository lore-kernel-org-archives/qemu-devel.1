Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4CC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D16214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D16214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlN4-0005ga-3g
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izlMQ-0004rq-7d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izlMP-0004g1-2C
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:54:42 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:41057)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izlMO-0004bk-Ow; Thu, 06 Feb 2020 12:54:41 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N49Ul-1ji8eA2kc5-0104Mk; Thu, 06 Feb 2020 18:54:19 +0100
Subject: Re: [PATCH] nbd: Fix regression with multiple meta contexts
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200206173832.130004-1-eblake@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c28915e5-0387-16af-3154-451029cc8a3a@vivier.eu>
Date: Thu, 6 Feb 2020 18:54:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200206173832.130004-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FlCei6F072w0cDtdW7z8w/U7PGgpwgQugYUy4Tc9yL4XRCkJV2M
 fmvgqJNVOf00Ghz61Gj1GkXfW4NFecbXwcHcrkGyRKuc9l+tUsEyR36zHtfLVsB1at2K5Cb
 pjrv4imdFY7mREuIT1cNtYwAEiSUHktN69UpFyUT6vbOuChMo/id5Q77/qzKhXnFPFEoG2w
 Giydx4ftegN9YLg16xEcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zqTTsw+8uM8=:7qhgn4nEJiej3ZQLFhitNN
 c/TedTvFewdA7UK5EBsd+a4Z8tj1eD9VzLOruozt1F2jkGM/xh8ofqaiJ6+VdReJRaVH1OWIF
 HuRTpQMBriIR7GSqPtsVDK6cIxxJmT2W/Jki3SzWoAjI7JHLMMg4l3CH7Vbqr/37VKH4Z0+QK
 oDU08JhIKA8LJJ369VlkL6v01GDgajveg7gvGEIqVhIllA5tifQmk/b5H4Fh6xdxftyhT9/NQ
 OZiRNMgtnLBk41ZV+SvvYCpiPN5Na7dSYrNIGb9Lw4/YdO3Fd1jhQ97V5FSqH99yrU1t6Tyfv
 h95GCSsNGApG1SsVxloUwpbqBINTvE/GRZofkEgg8/v/hz0JgnLLnhv9tnDiTk2WWxhlKUDUh
 jpcTzY5XWGQsU+bkq1jTZwOJkyaH2QoU53BmGDZ/nzh253FpjlkEKQ4WFicAphTqX2dzAiFF/
 gR0XNBBQsCQP5VpBwfxurAI7HhBHHdjh4FSEVOL//LkVctwAolGW5eSIo2c1d0haoAXkKN6/K
 g6SYgubqk/6LZgM+PW7kHoivfGYW6HgaWIX8rI+qVZHycuHePRk75wCItNlu1JWZwvhoB+Wi6
 wJt7eP+8QYRbgfQDaLk+msCBh4WgqLXf1/YMwfUBMulstPAzRwKFcmwhhTfP+VLQVUKr1SznD
 B3OtPaxYdn0OOwooD0TwKmsX5d4Z9VOPXKsB97nqU5UgWgDAjOjz8XI8G93+PSMuRgIhIjKgo
 E/wqbo6LtsuufLdmOw13CVslhLZS4z5PmdBz4C6IU7VIXACXayIXuamvsr+goF/9xnTjDUrZa
 9+msIKTHJdAMaj641pvY+FnZfukFy80HC+jbvu4ZN2x6XhrieI5ums7UBpkJHpBxYel0ied
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: qemu-trivial@nongnu.org, pannengyuan@huawei.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/02/2020 à 18:38, Eric Blake a écrit :
> Detected by a hang in the libnbd testsuite.  If a client requests
> multiple meta contexts (both base:allocation and qemu:dirty-bitmap:x)
> at the same time, our attempt to silence a false-positive warning
> about a potential uninitialized variable introduced botched logic: we
> were short-circuiting the second context, and never sending the
> NBD_REPLY_FLAG_DONE.  Combining two 'if' into one 'if/else' in
> bdf200a55 was wrong (I'm a bit embarrassed that such a change was my
> initial suggestion after the v1 patch, then I did not review the v2
> patch that actually got committed). Revert that, and instead silence
> the false positive warning by replacing 'return ret' with 'return 0'
> (the value it always has at that point in the code, even though it
> eluded the deduction abilities of the robot that reported the false
> positive).
> 
> Fixes: bdf200a5535
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> It's never fun when a regression is caused by a patch taken through
> qemu-trivial, proving that the patch was not trivial after all.

trivial doesn't mean not reviewed...
The patch v1 was trivial, the v2 wasn't.

> 
>  nbd/server.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/nbd/server.c b/nbd/server.c
> index 87fcd2e7bfac..11a31094ff83 100644
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2384,15 +2384,23 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
>                                                 !client->export_meta.bitmap,
>                                                 NBD_META_ID_BASE_ALLOCATION,
>                                                 errp);
> -            } else {              /* client->export_meta.bitmap */
> +                if (ret < 0) {
> +                    return ret;
> +                }
> +            }
> +
> +            if (client->export_meta.bitmap) {
>                  ret = nbd_co_send_bitmap(client, request->handle,
>                                           client->exp->export_bitmap,
>                                           request->from, request->len,
>                                           dont_fragment,
>                                           true, NBD_META_ID_DIRTY_BITMAP, errp);
> +                if (ret < 0) {
> +                    return ret;
> +                }
>              }
> 
> -            return ret;
> +            return 0;
>          } else {
>              return nbd_send_generic_reply(client, request->handle, -EINVAL,
>                                            "CMD_BLOCK_STATUS not negotiated",
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

