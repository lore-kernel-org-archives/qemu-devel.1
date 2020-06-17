Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0565BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66C520884
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 18:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMq5gqze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66C520884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcWw-0000Hz-PM
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 14:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlcWE-00080n-TV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:10:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45506
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlcWC-0003Gw-Ik
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 14:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592417435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pZwwbzyuPZXDqT7ylxfnpauSkWf5EOc82QusXSZDfw4=;
 b=fMq5gqzeZNRWdVC0/wBHBnC5dfn4JzZzBnfRkdkCx9IO4MPkIfbfntme9Mj1M0TXzj8FyN
 5egLue+JUDdhZnYjQJxgpYEt8+sXtX1m0QhB58ZwV3mAQB4f8UXHakcE24M+TYJvMnvq9C
 qYNLhkJHJvXGH99JPcV+db6b80bKJ+U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-iYCo48uvM8C6FMXrKoiMxA-1; Wed, 17 Jun 2020 14:10:33 -0400
X-MC-Unique: iYCo48uvM8C6FMXrKoiMxA-1
Received: by mail-ej1-f71.google.com with SMTP id hj12so1479795ejb.13
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 11:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=pZwwbzyuPZXDqT7ylxfnpauSkWf5EOc82QusXSZDfw4=;
 b=bY0tbI5LmIGqAr5ITcJO6fptO0O9+wK89HyAqlu+SA8qbb/6+pgfb00x9JcEX/Lt+I
 VmhOfzAgHrgiP74DfigSZubRZMc4bhdwKZVEM9MM+FTLBNbJlQoLs1pvmN9KmKxS3x7c
 cZpfzgJhMoGQpNablz+df6b4aaaoTtnqhH8liuiDG5D10Pvoe3cWRr3gIDxkG3BMSegR
 HuuYvL+HXOUo4WVfSWe34+fU8oUAYTxN9wwaIbR7pzhTZeCbavD/h9nrSCkjzXue3YbQ
 2QDWiZXJ9eeBAb79Ne9mAuVc5c2SG/lGGgZ0QnNJ5cE8JsF2piUvFpSQ7ZG1NwCJVdYD
 QGfA==
X-Gm-Message-State: AOAM532BACuGOSK2gzTIZXUzqmCciZQBi+8PRdJxYbuALV3/uXDE4qZP
 Qwfz1ETfKV52nMSXDV7W+zPNdhzWqXPPzgWt800uYj4yR+aqcA6LalQoKMQIDLK6/eOS0beQa6E
 YYlkcXJo/rVnEZQY=
X-Received: by 2002:a05:6402:1812:: with SMTP id
 g18mr423685edy.96.1592417432306; 
 Wed, 17 Jun 2020 11:10:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzd65oqa4x4tMmCtcKnroD03Wl2blnEpsyP7vALrzMh9Bgwb7q352VEo+/Z4WnYotglqZ9awA==
X-Received: by 2002:a05:6402:1812:: with SMTP id
 g18mr423659edy.96.1592417432102; 
 Wed, 17 Jun 2020 11:10:32 -0700 (PDT)
Received: from [192.168.1.38] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id o5sm468751eje.66.2020.06.17.11.10.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 11:10:31 -0700 (PDT)
Subject: Re: Is roms/vgabios/config.mak still needed?
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
References: <alpine.BSF.2.22.395.2006172005060.14527@zero.eik.bme.hu>
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
Message-ID: <7f64c36d-08f5-95a5-54f7-733578734c87@redhat.com>
Date: Wed, 17 Jun 2020 20:10:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2006172005060.14527@zero.eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/20 8:08 PM, BALATON Zoltan wrote:
> Hello,
> 
> I've noticed that configure creates roms/vgabios/config.mak but commit
> 91b8eba9ec3f5af7dd48927811eb7ff69fc4617f seems to have removed vgabios
> so should this be dropped from configure now as well? If it's still
> needed it should be added to .gitignore.

You are right, it is a left-over from 91b8eba9ec3f and should be dropped
from configure.

> 
> Regards,
> BALATON Zoltan
> 


