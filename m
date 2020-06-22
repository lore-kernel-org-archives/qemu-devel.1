Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92C5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CE920738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXTD79lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CE920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQgJ-0006Mp-Pt
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnQfi-0005rH-BW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:55:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59581
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnQfg-0002Ly-Ln
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592848551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mnjwY2n0UUMuclsz5CPHpJzLhWT9RFjA4K/+DESNbLg=;
 b=QXTD79ljdlFX1DwM6B79HQjMLYud9X7AhVqc/GPf/CndCMLB3Sal4KW4QRD+dySY/IUN+a
 saXTuMU5Fk1FjjTKo7/QXSGcW/Ho8Z4Z9VSMpbApdTPB/E/tfOG26hjmhOYcl9gAUZ+JQH
 a/AD0deT2HOJXShXmO71yh8tQEhZNfs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-FeLV3HsWM_WSc3FXcBtEvA-1; Mon, 22 Jun 2020 13:55:49 -0400
X-MC-Unique: FeLV3HsWM_WSc3FXcBtEvA-1
Received: by mail-wr1-f71.google.com with SMTP id b14so11099723wrp.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mnjwY2n0UUMuclsz5CPHpJzLhWT9RFjA4K/+DESNbLg=;
 b=rkSBR7YyliWDeJSp9X9xAFLlFNdsB4RNS2M54m7sn+4gYXSI27e+RSdbXXbGoQi9a8
 8V17Gpm0wZtrjX8XyLjADn+CJuBfgIbkyexrjSH0rF41nKm5eAk0S4vSUxhbPXIv6RRh
 cxSy3qg4DQrqL9+94xP2SkYV1sw33J7j8c8iko+5ZEToOBStDsBEKGVbOGYKIdAxTw9a
 3FhYr715QfnzRzNd4azB64dpZoe5Q6RTit+C1Ortzw7WejznjQIYPh7fFDihjYa12XgM
 KaA1EmPvW4i0/TDh9z1MmjFirqY/RhIHiuEp9QIs+OXkl54w1TXi+RME6oPNENQb4y7T
 hw1g==
X-Gm-Message-State: AOAM5329gtOEi+xneQcKUnAOQo9xfItcymbWg4fVC5FUVl8ypTNvJMRE
 kuhkV1JvUp2Mo3JPn2Kk2JXEkFCgCrDM/sdnDxBAsRpg6077rI5gUWFxC9hzJNvYNgB+b8SGmw2
 fO+LU0QSdR7iZbTg=
X-Received: by 2002:a1c:2987:: with SMTP id p129mr19930010wmp.49.1592848548523; 
 Mon, 22 Jun 2020 10:55:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8H+ARXDIXwBwRXjY+npX2LybVNp0TV6PRxOQBZbEp6j6hqmYcdlplI88lgX3CWF99eSQ9xw==
X-Received: by 2002:a1c:2987:: with SMTP id p129mr19929986wmp.49.1592848548237; 
 Mon, 22 Jun 2020 10:55:48 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u74sm358568wmu.31.2020.06.22.10.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 10:55:47 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] python/machine.py: refactor shutdown
To: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20200604195252.20739-1-jsnow@redhat.com>
 <8bd27ec8-1bb6-45e2-a43a-7e0229065414@redhat.com>
 <4012de28-5837-889a-eda1-b9957cbbbad1@redhat.com>
 <5d20012b-923c-0bf4-232d-272977087fe3@redhat.com>
 <20200616214900.GA347659@localhost.localdomain>
 <fd9c8f22-77fe-9689-9445-416fad9ff0fa@redhat.com>
 <19227083-5e99-e08f-4a6d-8d2edcdeacf8@redhat.com>
 <536b1d29-f3e0-4c28-e294-3cd83885323e@redhat.com>
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
Message-ID: <7c989539-8b81-89db-5d29-0e66c83b1201@redhat.com>
Date: Mon, 22 Jun 2020 19:55:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <536b1d29-f3e0-4c28-e294-3cd83885323e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 7:51 PM, John Snow wrote:
> 
> 
> On 6/20/20 6:14 AM, Philippe Mathieu-Daudé wrote:
>> Still doesn't work...
>> https://travis-ci.org/github/philmd/qemu/jobs/700309163#L5445
> 
> I tried running from master with just these patches applied. So far, the
> only failures I am seeing on gitlab/travis are job timeouts.
> 
> Are you doing something special to avoid timeout failures?

Unfortunately no :S Cleber tried too and couldn't reproduce,
I'm the only one lucky enough to win the race condition...

Retrying the acceptance tests on Travis-CI is painful, yes,
I know...


