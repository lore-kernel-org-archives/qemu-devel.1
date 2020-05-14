Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E0CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B07206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB+d01/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B07206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7Eb-00023q-5A
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6zn-00043M-PR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:05:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36802
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ6zn-0003jt-4F
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nBn8uweOTimmlNufc4N5jzEMTUTFTEdBAb6MvjRVGrI=;
 b=fB+d01/Y8nyDlySLnEh8M8vEJjqv/FNNv1cs73WPZLH+YgVT/AAzgUSHgMYYwg0CBwX71N
 oL0j3jWTCpw9y9aF+rmvrEByfQlg0D/RTtXWXOt7JO2JHGuc4LAt1fMCHFYWTvUoCKyxj7
 BdgM0HAmzQkRk9kgRiiDqfoEMe9WZbo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-uir_FcDCMOqsQa5TbJn0jA-1; Thu, 14 May 2020 02:05:22 -0400
X-MC-Unique: uir_FcDCMOqsQa5TbJn0jA-1
Received: by mail-wr1-f69.google.com with SMTP id h12so998362wrr.19
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nBn8uweOTimmlNufc4N5jzEMTUTFTEdBAb6MvjRVGrI=;
 b=UJXrO9Qif2JX9rwAhiO3wWob8GerkLY1tYHYf+pywt6/asW614yV/5SDDsavLQ0zxU
 N2SCbGNhQDd8qMsjR0Ju6EdLEPVlBV7fTiPKvjeRzMZA0kmNc4h+oIh2DgXvYrPO4GvX
 WMZjBfyLON4zHhUJlsOp8oCYQwfwwXB/b4P5R2uLibV/6X9XA0RfJqifHe0Fo/APkq/L
 XjEylXHBoRoVJaah8y+6lT4Eyh8mL6YwPk/ueV8jLZIC4+cXdntHy7c1aB2EtnBxKW7U
 qSIpkUnY5dhwir2/tDq6bgQC5OsDvgWu1lGivqnLDVl8jyh8WGDGVBQZCJiGlSaYZC2u
 aRSA==
X-Gm-Message-State: AOAM532fK4U5hXbkvEZUqh+mqXJ1VSFJV0/DL2Wg+9xqNSpzPRuPIRBr
 QtY37LOsB1V5lF1BSyu3bTskGot/4xCDrvyxpCkmKC4uu1QGOC7eqKyFbn70uZWBFnsh2Mvhnj/
 7gVFpbkKvGllZBY0=
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr3115742wrq.33.1589436321824; 
 Wed, 13 May 2020 23:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoyDwJo/Ve37MHPFfNl91b+0Rg7DxiCTXi1dyxsyUpCPc7Ki2U1Jw207aUZBKZAHoIRYQppA==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10mr3115722wrq.33.1589436321652; 
 Wed, 13 May 2020 23:05:21 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 128sm33567403wme.39.2020.05.13.23.05.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:05:21 -0700 (PDT)
Subject: Re: [PATCH RFC 19/32] python//qmp.py: add QMPProtocolError
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-20-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <78f19125-5e6c-611f-3e6e-97a5dcfe62de@redhat.com>
Date: Thu, 14 May 2020 08:05:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-20-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
> In the case that we receive a reply but are unable to understand it, use
> this exception name to indicate that case.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/lib/qmp.py | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
> index e460234f2e..5fb16f4b42 100644
> --- a/python/qemu/lib/qmp.py
> +++ b/python/qemu/lib/qmp.py
> @@ -62,6 +62,12 @@ class QMPTimeoutError(QMPError):
>       """
>   
>   
> +class QMPProtocolError(QMPError):
> +    """
> +    QMP protocol error; unexpected response
> +    """
> +
> +
>   class QMPResponseError(QMPError):
>       """
>       Represents erroneous QMP monitor reply
> @@ -265,6 +271,10 @@ def command(self, cmd, **kwds):
>           ret = self.cmd(cmd, kwds)
>           if 'error' in ret:
>               raise QMPResponseError(ret)
> +        if 'return' not in ret:
> +            raise QMPProtocolError(
> +                "'return' key not found in QMP response '{}'".format(str(ret))
> +            )
>           return cast(QMPReturnValue, ret['return'])
>   
>       def pull_event(self, wait=False):
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


