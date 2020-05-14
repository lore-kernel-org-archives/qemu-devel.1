Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CAEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE10E206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpD2sRFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE10E206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ78I-000364-3X
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ77N-0001ne-Hw
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:13:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ77L-00061t-SL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pdYM7Mc6D/jn82kFpKg4BL6IAeWb9hIpvE+qgVtjEt0=;
 b=bpD2sRFZA2A496w54v+MqfW0zHAfB7+MpgJrJ+PmYWA9LCxxIfq04XeTXOw5tiuSVhjbWc
 r3DDCAmg9jS2XY5M6IMSO2KCSUTzbBJ3C8ezSZxycjpqFyzpY7400qG9ETP9GUU/UDT/6R
 Gv+bH90pXd4qWKnPdJR8cWHYNyrQz6s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-_NQxYQeZPxmpJHW7wTkCJQ-1; Thu, 14 May 2020 02:13:11 -0400
X-MC-Unique: _NQxYQeZPxmpJHW7wTkCJQ-1
Received: by mail-wr1-f70.google.com with SMTP id z5so1006346wrt.17
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:13:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pdYM7Mc6D/jn82kFpKg4BL6IAeWb9hIpvE+qgVtjEt0=;
 b=HkyFfWiIszDxspjeFNW5ZkbqcWpbOC+BlTC17w0SKdqdkzWcPp3e1g2jPLdWcMq/bI
 Z6nMCq9b+4ggPY82wd8NRXHJRGlIbmalc6C30jhwVdm8+006cXMM+6xwc5CAnwba7QmL
 bXF3ro9nXZQ5AEQL65CHse2b8xpIl53HQC2c875yuEhSoysqj2Mn5ZbnyffsncdYRqfA
 TNgoBx11a5SNrM/Ej6orp7xM+XLaHqGbf6QObTeou800NdXEI5/ml9lAmeIXNAqcghq6
 sYJBEo8ZiLmXsX2kH5/Y+adn1XHubb7/UCAh+KEtElaxcmeLfPgQ4XvNsKbaSz3obLCN
 6eRw==
X-Gm-Message-State: AOAM532wd7FM1NW787YmDxHVRO66ipbbWXp75KHgbwPnrNDsrBlkWvUx
 qgapdZPVQo9SqJiPV08JlnIfoSoh9pI7V/o8VpuuKr4ECMYt03Og/6STX0j1pXVRNddl1Su2wbY
 rld41Zl/R1MVVMN8=
X-Received: by 2002:a5d:614b:: with SMTP id y11mr3641780wrt.77.1589436790556; 
 Wed, 13 May 2020 23:13:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqvfd24ZC2sJMfjuNavoonNmNxIm87ZoipHfs/KB1N0cFiZa79tDx3YTOHJ8f6s1y/83w/pQ==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr3641750wrt.77.1589436790310; 
 Wed, 13 May 2020 23:13:10 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h1sm39274904wme.42.2020.05.13.23.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:13:09 -0700 (PDT)
Subject: Re: [PATCH RFC 29/32] python//qtest.py: Check before accessing _qtest
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-30-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5fa2a9c-a4f3-798e-253d-b6a3bf121d33@redhat.com>
Date: Thu, 14 May 2020 08:13:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-30-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

On 5/14/20 7:54 AM, John Snow wrote:
> It can be None; so add assertions or exceptions where appropriate to
> guard the access accordingly.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/lib/qtest.py | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/python/qemu/lib/qtest.py b/python/qemu/lib/qtest.py
> index a8be0c782f..05c63a1d58 100644
> --- a/python/qemu/lib/qtest.py
> +++ b/python/qemu/lib/qtest.py
> @@ -126,7 +126,8 @@ def _pre_launch(self):
>           super()._pre_launch()
>           self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
>   
> -    def _post_launch(self):
> +    def _post_launch(self) -> None:
> +        assert self._qtest is not None
>           super()._post_launch()
>           self._qtest.accept()
>   
> @@ -134,6 +135,13 @@ def _post_shutdown(self):
>           super()._post_shutdown()
>           self._remove_if_exists(self._qtest_path)
>   
> -    def qtest(self, cmd):
> -        '''Send a qtest command to guest'''
> +    def qtest(self, cmd: str) -> str:
> +        """
> +        Send a qtest command to the guest.
> +
> +        :param cmd: qtest command to send
> +        :return: qtest server response
> +        """
> +        if self._qtest is None:
> +            raise RuntimeError("qtest socket not available")
>           return self._qtest.cmd(cmd)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


