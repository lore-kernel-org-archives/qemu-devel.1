Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31388C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F20206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mzu+KERi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F20206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QVE-0001k1-Va
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1QUY-0001I7-21
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:01:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1QUW-0002ap-Ks
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:01:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44434
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1QUW-0002a3-Fh
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581408115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXwmEIH0JU6oEp1qpGVAbsLuPgglfIMze/eeH26ULcg=;
 b=Mzu+KERiV3AK/YcVNPgDShVmd6S2E5SYt11TplCgO2SmJ6kZKwoBs9+Eqh6UAbpEcLqshx
 tsVW7OPoeZmYG7w6q/TkSJf7a5b4yNu0upvXnhx5R2r/eltiD9kon9XcSg04MvD/lJuRGp
 G6LplL9zCCN3jUaoOCvz/zJFuxgKqC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-ivvdcjUkOP6cN0FaPs-NGw-1; Tue, 11 Feb 2020 03:01:51 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so577273wmg.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 00:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zXwmEIH0JU6oEp1qpGVAbsLuPgglfIMze/eeH26ULcg=;
 b=Y0+pWXqPhudFLg5Ifnoqbx2NAPSf7cbv8RCrC0X4LvBzRIx282j3kAjgFBnszU+j6a
 eWqkHiQDen17+NWsJvkKf3Mr9MO/O4IzpNW5wWibD+nkXL3cLP6uHsPqvdCtEbvoDT8X
 8sXhA7tzKRghdwVR98YFRk4Cxn/2broj9Swf6T7ljKlXFzRCeTttflqah4yUgeLLiOtG
 fM/7cW2Vv8XMp9M3qdqs0R+pLZ5IzYkLqFvg6U675hDHvOnFcNiNsimxvgHkgda1ecHG
 +b21N7oPlXVBTiGpCEBIOhA5bUlHAjbgrGnziQ6GpWnAXttQSlnukZQfZLzDqwwmJi65
 3m1A==
X-Gm-Message-State: APjAAAVy3IMs9837ekpJEpB238M+XjpEzYxzgoqH+0Ktu6nn3auv9+nN
 ItQkmVEY3s9Q5qtE7wCThANnl52J4jZC3x+0QgjGwEPxzcu0W/FwxEa9axliVrA9DBb9ts4nI67
 /z4udnv3nNsaLtBc=
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4204132wmc.137.1581408110479; 
 Tue, 11 Feb 2020 00:01:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqznOIKOAL8ZyRQzfjCH2NlLNJlByef9e+QlEcECXjMbDKjrzBjHJTpsZQAda2+GFVDlPXlVtA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr4204105wmc.137.1581408110125; 
 Tue, 11 Feb 2020 00:01:50 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id t9sm2584141wmj.28.2020.02.11.00.01.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 00:01:49 -0800 (PST)
Subject: Re: [RFC PATCH 24/66] Hexagon generator phase 2 -
 op_attribs_generated.h
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1581381644-13678-1-git-send-email-tsimpson@quicinc.com>
 <1581381644-13678-25-git-send-email-tsimpson@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b37b043d-3ca3-96f6-044a-e3d6ee7a00cf@redhat.com>
Date: Tue, 11 Feb 2020 09:01:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581381644-13678-25-git-send-email-tsimpson@quicinc.com>
Content-Language: en-US
X-MC-Unique: ivvdcjUkOP6cN0FaPs-NGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/11/20 1:40 AM, Taylor Simpson wrote:
> Lists all the attributes associated with each instruction
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---
>   target/hexagon/do_qemu.py | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/target/hexagon/do_qemu.py b/target/hexagon/do_qemu.py
> index 5439964..f297931 100755
> --- a/target/hexagon/do_qemu.py
> +++ b/target/hexagon/do_qemu.py
> @@ -797,3 +797,16 @@ realf.write(f.getvalue())
>   realf.close()
>   f.close()
>   
> +##
> +## Generate the op_attribs_generated.h file
> +##     Lists all the attributes associated with each instruction
> +##
> +f = StringIO()
> +for tag in tags:
> +    f.write('OP_ATTRIB(%s,ATTRIBS(%s))\n' % \
> +        (tag,string.join(sorted(attribdict[tag]),",")))
> +realf = open('op_attribs_generated.h', 'wt')
> +realf.write(f.getvalue())
> +realf.close()
> +f.close()
> +
> 

This fails with Python 3:

   GEN     Hexagon generated files
Traceback (most recent call last):
   File "target/hexagon/do_qemu.py", line 952, in <module>
     (tag,string.join(sorted(attribdict[tag]),",")))
AttributeError: module 'string' has no attribute 'join'


