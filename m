Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D9C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8B3420A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QchP5oiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B3420A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMv11-0007H2-1E
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMv0O-0006ro-0F
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMv0M-0002ev-Nv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:51:39 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMv0M-0002cl-9a
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:51:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id g6so1061249pgs.9
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A2efwbep2WIqV8cdCCsODJVnI0w6TbMYw+rmItyVqM0=;
 b=QchP5oiAfJk57PH1YT+GW4ksUQaT664fYVNc6K02E6xatY7Enbt0YY92u/PKt7adET
 l7El/lC2NXrL1i9uTwz3fS6dcGlXr70QbKVcvZulTo0kt/ERK+OHVaKhFXu+fzBkxwkX
 /aVBFiA3JfJ36bS6BYmRkzWEPuv6hA7iDJP3LcBg+tUkEN2Q1e3Dzh+1Jumbw0vaXgfo
 knVHrtKhHbPC3k7jM6LTPhClxvO3rcaZdoKPazE5QPH1LN5u8kuc2WU1oM6F+JHlVXoJ
 xbICQMghI21szI9AGmtzc4iRBU7PKDX/p76ZqhwgfItNf0HbtDoVzw/lYhyBBwyKl+hu
 Haig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A2efwbep2WIqV8cdCCsODJVnI0w6TbMYw+rmItyVqM0=;
 b=RtrcR5TiPWwl/JRSajVaMjhFBubC9t70PIXEbAwIupJBBbO52sM1wVN0lF9BBrX2TY
 jP61OH2LeaCi53koCzzv7YoakGg1xK3Npoo5JsucBPB+B42zxqlEka4DhipF/5XxUnaa
 9byb7m/MPTmLSndb5V2u/nF/sGkKLAC7Ma9XtqDnu3MfqvF7c50Ci3Id8ggV+l6JnWeW
 o1Kki754Oca6uvd9dvkNbtj/bs5/yyAyCwHe0Huu4dYPNjFA/hBbGQ7CV2w/0F2wJfc8
 zZBzUc/5xXzTgJSv+ECnnas/4wBdqflGSYKD0TcXUZ3Cq9fG3liwtqNUB0j8FfPHjq4o
 33vg==
X-Gm-Message-State: AGi0PuYwWiYQwIYsycDe8mGDjkuSMKm18VNUvsrpiHh74vkbkPX1Z2Ij
 nMmoIlJorkd/+kPbPO4xzxWL8w==
X-Google-Smtp-Source: APiQypLuNY6+CncCfBmCE2e/LqRRZylPEgtLuZQ6Wcv6SxB/88ymUhySAIuqSfyPuHCeJ3959zF7/w==
X-Received: by 2002:a63:3002:: with SMTP id w2mr4865651pgw.290.1586530296686; 
 Fri, 10 Apr 2020 07:51:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id z15sm1980151pfg.152.2020.04.10.07.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:51:36 -0700 (PDT)
Subject: Re: [PATCH v1 10/11] linux-user: fix /proc/self/stat handling
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200409211529.5269-1-alex.bennee@linaro.org>
 <20200409211529.5269-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0871ff0f-28bc-728f-a5df-7980000a8f97@linaro.org>
Date: Fri, 10 Apr 2020 07:51:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409211529.5269-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe=5fMathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Brice Goglin <Brice.Goglin@inria.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 2:15 PM, Alex Bennée wrote:
> In the original bug report long files names in Guix caused
> /proc/self/stat be truncated without the trailing ") " as specified in
> proc manpage which says:
>     (2) comm  %s
>            The  filename of the executable, in parentheses.  This
>            is visible whether or not the  executable  is  swapped
>            out.
> 
> Additionally it should only be reporting the executable name rather
> than the full path. Fix both these failings while cleaning up the code
> to use GString to build up the reported values. As the whole function
> is cleaned up also adjust the white space to the current coding style.
> 
> Message-ID: <fb4c55fa-d539-67ee-c6c9-de8fb63c8488@inria.fr>
> Reported-by: Brice Goglin <Brice.Goglin@inria.fr>
> Cc: Philippe_Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/syscall.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


