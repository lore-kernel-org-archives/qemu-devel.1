Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:44:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA017207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 07:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKWVRp/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA017207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jivPG-0005kJ-4l
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 03:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivNU-0004Qc-QA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:42:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30036
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jivNT-0003aX-Nc
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 03:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591774947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w2T3yF0vT3/ShEEtaTthpUhFOfnlxJ6rVwy6CCi2hfs=;
 b=bKWVRp/5VR3zT9GsR1Qt7HXePD3eTOlsS7LfBG7W8TYuJjURRijuXZClo0UZ3iAn2EXUpb
 BOti0yX3Bfhn39+Ru+rceQzppP5JV3mJdnfcORSy5LWBVIagCfzlE+3apLjMVe7kkw+Wlg
 PGUZmIBL92kSVPEArO2OSVgqjYibiFg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-lH6CZ2JsN0GdhEOPmdydlw-1; Wed, 10 Jun 2020 03:42:23 -0400
X-MC-Unique: lH6CZ2JsN0GdhEOPmdydlw-1
Received: by mail-wm1-f69.google.com with SMTP id c4so214916wmd.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 00:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=w2T3yF0vT3/ShEEtaTthpUhFOfnlxJ6rVwy6CCi2hfs=;
 b=LOTC7yi6X229JirgZo4pVFLKbAMy9tC0vTVh0QE1m7MEA3C13St37uF5c9f96FgJKq
 iYG2Oj1Gy6AXryhpLJtOV7uiuFCqroAtyL4JOFg1RBBSy0xc7YRxUh8hlWEWsGTe5cnP
 BRABZ+zpmb/xdsW8UTCDkKND+BWmVOSDc/e5e8YSaxWHFvzLZXxa6CFojCPS1KQKyqG/
 OJeTd2DWTqkwbO5h6tKy3W8eOQV+agipsoNCRy+CJF4nNKsfe4mwE4p84Cxuv80mZ2g+
 kFR2Sp2QOPtjNcyZb0nuct+2n+2wufB8qBceilF3g83YKD6FfKCa+ShB0/VMam076poH
 jMDw==
X-Gm-Message-State: AOAM5310FrxW18WDVQ/WbXtAdKxoyf7NYT6ntmGkhIH+q+cUTOH/dfZ3
 5TBIYaNWwGBsQOGjFY1JV8FVsTK9vcD6wslwCQL00EpGxUq3zXMrCCXyWVCAhuq7Fkh7PVzu36G
 Re9gnhhgE2DU6MTU=
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr1985616wrw.379.1591774942653; 
 Wed, 10 Jun 2020 00:42:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvZEfFZZkyW2WMv/cdLey76DVkD9qd8pEFrDGZ3o8r/esVC7geYR254ei/NrylE2+tWlKl4g==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr1985601wrw.379.1591774942492; 
 Wed, 10 Jun 2020 00:42:22 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id g19sm5678572wmh.29.2020.06.10.00.42.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 00:42:21 -0700 (PDT)
Subject: Re: [PATCH] iotests: Add copyright line in qcow2.py
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200609205944.3549240-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <20830479-09da-3ea4-4148-12bac4c8bb64@redhat.com>
Date: Wed, 10 Jun 2020 09:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609205944.3549240-1-eblake@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 10:59 PM, Eric Blake wrote:
> The file qcow2.py was originally contributed in 2012 by Kevin Wolf,
> but was not given traditional boilerplate headers at the time.  The
> missing license was just rectified (commit 16306a7b39) using the
> project-default GPLv2+, but as Vladimir is not at Red Hat, he did not
> add a Copyright line.  All earlier contributions have come from CC'd
> authors, where all but Stefan used a Red Hat address at the time of
> the contribution, and that copyright carries over to the split to
> qcow2_format.py (d5262c7124).
> 
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@redhat.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Acked-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Commit ids above assume my bitmaps pull request does not have to be respun...
> Based-on: <20200609205245.3548257-1-eblake@redhat.com>
> ---
>  tests/qemu-iotests/qcow2.py        | 2 ++
>  tests/qemu-iotests/qcow2_format.py | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
> index 8c187e9a7292..0910e6ac0705 100755
> --- a/tests/qemu-iotests/qcow2.py
> +++ b/tests/qemu-iotests/qcow2.py
> @@ -2,6 +2,8 @@
>  #
>  # Manipulations with qcow2 image
>  #
> +# Copyright (C) 2012 Red Hat, Inc.
> +#
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
>  # the Free Software Foundation; either version 2 of the License, or
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 0f65fd161d5b..cc432e7ae06c 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -1,6 +1,7 @@
>  # Library for manipulations with qcow2 image
>  #
>  # Copyright (c) 2020 Virtuozzo International GmbH.
> +# Copyright (C) 2012 Red Hat, Inc.
>  #
>  # This program is free software; you can redistribute it and/or modify
>  # it under the terms of the GNU General Public License as published by
> 


