Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BC4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD7C206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ5NtuIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD7C206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ76B-0007IZ-PE
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ70y-0006SA-5N
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:06:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36862
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jZ70x-0003ux-Ck
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589436398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33ditrsyO39HI9CujDx1q5QCELt6a7U8fW17A+zaTeg=;
 b=WZ5NtuIWQM6h/pRmPVUWb7z8r32PUpiuRQ/INfZR1ePYBVLTKJ5wqHdN/jCKTL3wKWjLqG
 7h4zLO7RYT0EdLCoEfNjllw8dkIqkAP+mym318PiYYTNMz2hj8Ef04Dt1qOrBs4nUz7Nqa
 LIMriFZiA+tU+IknaYRKGQLsDWXQt68=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-BBxH2EaMMte2qq_2aOssmA-1; Thu, 14 May 2020 02:06:37 -0400
X-MC-Unique: BBxH2EaMMte2qq_2aOssmA-1
Received: by mail-wr1-f70.google.com with SMTP id z10so1023120wrs.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 23:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=33ditrsyO39HI9CujDx1q5QCELt6a7U8fW17A+zaTeg=;
 b=Oi9t8R4Jnbk7T/530LToHRLbu14ewfA2NfJbpEd2zjtgBfME5knEtuFvBVqYyGiz+4
 rKvSyZgHbWergYsqb5W4HcePCV+Gs9htviorcfl1cTduxKn90SQhOwZCn+SssBx8Vvxs
 fn0JWuCtirFknr0QRj5gLmFWasLqz1RYCGg2osfQP8Dvtq1SMRkGIKjOmqPHOAcS5UOZ
 Zst0HncpBVKBSm0vHauAuAmH4P62l2fLbdsw2vei2NLZ1MR+oI3njwm8Rjgn00eIjIuk
 p5kGJAkC4V5f8oHOWZnvFdEmXwYsXFN5hO/TuXLbCDt/Uub9wYF02W0QFQkqLGpwU/c7
 rrEg==
X-Gm-Message-State: AOAM530rQERIZcB4+fb+jaN5Pd1TefPe084BKFXyZmt+AeDgEtUhEQcm
 xVI6kY+ard9Tep5ymjlakrHyCUZmQXP1aPUBEYtnt8RAALjQlwZCyQSaSj2q0P4zXLixiXirFI5
 kvzuVYKMWlCcR6mc=
X-Received: by 2002:adf:de05:: with SMTP id b5mr3318232wrm.299.1589436396101; 
 Wed, 13 May 2020 23:06:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy6O1sWAsJzVVbFpUQaImjd4jp9TnGmIlf5uwiE5Fq5CCfGPXYRhoLRrUwvi8uxRKlfNxd/g==
X-Received: by 2002:adf:de05:: with SMTP id b5mr3318213wrm.299.1589436395868; 
 Wed, 13 May 2020 23:06:35 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v5sm2324179wrr.93.2020.05.13.23.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 23:06:35 -0700 (PDT)
Subject: Re: [PATCH RFC 21/32] python//machine.py: remove logging configuration
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200514055403.18902-1-jsnow@redhat.com>
 <20200514055403.18902-22-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <134b3341-4791-7a26-808a-36eddaf6a7d7@redhat.com>
Date: Thu, 14 May 2020 08:06:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200514055403.18902-22-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
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

On 5/14/20 7:53 AM, John Snow wrote:
> Python 3.5 and above do not print a warning when logging is not
> configured. As a library, it's best practice to leave logging
> configuration to the client executable.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/qemu/lib/machine.py | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
> index c31bf7cabb..e92afe8649 100644
> --- a/python/qemu/lib/machine.py
> +++ b/python/qemu/lib/machine.py
> @@ -110,9 +110,6 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
>           self._console_socket = None
>           self._remove_files = []
>   
> -        # just in case logging wasn't configured by the main script:
> -        logging.basicConfig()
> -
>       def __enter__(self):
>           return self
>   
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


