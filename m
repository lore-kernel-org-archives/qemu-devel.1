Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72329C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EED920575
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev7Q7aMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EED920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7DQ-0000nY-Eq
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6xO-0007E9-HY
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:02:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50013
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6xN-0003Ht-2T
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1BP/0m0oDysA5YZwGphWf0xrDxS1QgfwYWsBAW1v+k=;
 b=ev7Q7aMXOlGy576mjSbg2acVpqyr1qm3kIQ/XV9+s0nJyw27dxTCY60potqi1Q0cPzEoia
 sq9mdwnj5/yF/+DuscSpdwpGlpmlw0BV4gqRP711FjqkTaOn73g1PPIrJXYPgt+4WQEsHe
 HzgZG8uatUQP4lnpbQb7lZShakRiMU4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-rt7oCF3tPC6MFq6ZiQJGwA-1; Thu, 14 May 2020 02:02:54 -0400
X-MC-Unique: rt7oCF3tPC6MFq6ZiQJGwA-1
Received: by mail-wr1-f70.google.com with SMTP id 37so1017445wrc.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i1BP/0m0oDysA5YZwGphWf0xrDxS1QgfwYWsBAW1v+k=;
 b=uUm8x+fK4J6HX5GqMwJJiMlSkRRStdG2wj4t/eNNeBTB++d8ixGwcuFBxShaLihYT7
 mqU+gHebELqI22cGimtKs+qi8jbkkxCIJnVWveOaMgZw8SIzdDInnBG9NN5ab1IO5oyK
 Ds6xnI3KGUWv24tpYNSQK8+jOsATvgzHwxR9PmzMjYzwEgtpljiPXWeK1/nY5favCNXI
 8mtuHWl83EPeT0t9DbRPTzUN5wzX9nzVZ8ZiFNqFS3TwQBDp6NuKhJE2PlZ7QekejKCM
 eCe3j1NQYovTADcAe4hRW/unaRG4E5RG5hUwSYP5OTzI0e1BWA2/nqguetEJiCS6obz6
 j1tw==
X-Gm-Message-State: AGi0PuYf49aXA2aUgkNqa09P9FeROnOktHWEM/jFVYCuvAHtvVMlvw/z
 YEpoOoKiidwjRzJ3x+2Av4qX4Jlm6rjrEY7fgOywf2CLUqZA6ehd20mhQh5nPbhHbvcggxsvot+
 +guzBwqZg8WlTPu8=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr33304983wml.117.1589436173648; 
 Wed, 13 May 2020 23:02:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypLsuKCBOVaF31as7Z9TjNgmESK+Q6aOoVGLw7dIJPisvYRygKbrKXazgBoBwFKSByI7OWFq2Q==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr33304949wml.117.1589436173389; 
 Wed, 13 May 2020 23:02:53 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m6sm2374094wrq.5.2020.05.13.23.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:02:52 -0700 (PDT)
Subject: Re: [PATCH RFC 14/32] python//qmp.py: use True/False for non/blocking
 modes
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-15-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7013f981-2ad1-bde4-487b-5bbedb6fbb49@redhat.com>
Date: Thu, 14 May 2020 08:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-15-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 7:53 AM, John Snow wrote:
> The type system doesn't want integers.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/lib/qmp.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index b91c9d5c1c..a634c4e26c 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -120,14 +120,14 @@ def __get_events(self, wait=False):
>           """
>   
>           # Check for new events regardless and pull them into the cache:
> -        self.__sock.setblocking(0)
> +        self.__sock.setblocking(False)
>           try:
>               self.__json_read()
>           except OSError as err:
>               if err.errno == errno.EAGAIN:
>                   # No data available
>                   pass
> -        self.__sock.setblocking(1)
> +        self.__sock.setblocking(True)
>   
>           # Wait for new events, if needed.
>           # if wait is 0.0, this means "no wait" and is also implicitly false.
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


