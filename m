Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86DC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675AF2395B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfy9H7Uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675AF2395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcsi-0000cQ-FG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKcrx-0008Fq-HK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKcrv-0000bl-Ak
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600760262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dlxYHmM1hsxLPduFgBVYwEXxpTu06ev0rN40wVYwLM0=;
 b=Yfy9H7Uk3NTAJnRZXben5npruqvFHtREwNo2BgVNrg+emmsyEXHVBfsXBVw9/msXuPYOW0
 Dho/5G/e8ZfKhdevMESBMHm73CS1HGrTnIjRSlSuZzAwN6Pvpdre9zkZEgyI5p+mVt9whs
 XMtmhQXITA4KSVmK/VW+upQ+aYKfvlA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-dxWY9i9fMpiGCBRkhQUxaA-1; Tue, 22 Sep 2020 03:37:40 -0400
X-MC-Unique: dxWY9i9fMpiGCBRkhQUxaA-1
Received: by mail-wr1-f71.google.com with SMTP id b2so883570wrs.7
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 00:37:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dlxYHmM1hsxLPduFgBVYwEXxpTu06ev0rN40wVYwLM0=;
 b=FX0pKWxdInn75LNyP3QcjxJA62hDbh4Lz6pyUXxrxrJCFz97EmI+DtKxAiesGkNxBA
 6cze88lUiljD44IKfpi9Fku0UD4nZACuiCVUbs4gQMxhLg2FxzW48BaoSDeFlg8ryNO+
 SNvsC9B1jL+TUmqt3H+ne1/kc4TfnGKvZq+wwmVneJltlqUhSImGPdgdqHC8/StAR3yl
 RbNlcuoxunxRuBKVUP/J/VX57f3bR5NB0CXhZTTQFWsdhIBLqb3difrgbbUuyFmSqMbe
 wfkC337YLqzAz1VNrRC9Z41bXiRD88BP2Q5P6BG2qLHLK6DCjt4mf/I3jS5TtiLJhjam
 R0uA==
X-Gm-Message-State: AOAM531mS1UQ8Pi1BZ3/l2xTdnLqB4wYKdLiwb/WSxubaMjaKMSSbM99
 RoJywbsgebpHpURgOPywrsyx8RiH4i20puucpOuSttQGGgHoLpLe6BmEsxNlKes8p93AYx9l1F6
 A02E42HA95OVKuCE=
X-Received: by 2002:adf:e74d:: with SMTP id c13mr3636259wrn.45.1600760259270; 
 Tue, 22 Sep 2020 00:37:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzI+vY1e9pyf7uYkSgp/0HWuyYWQYTqy7l+iJwB0fWYRQKLzB2I7y0ihlS+VpoLjojNiJ8dGw==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr3636233wrn.45.1600760259045; 
 Tue, 22 Sep 2020 00:37:39 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p3sm2940868wmm.40.2020.09.22.00.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2020 00:37:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] vhost-vdpa: add trace-events
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200921130406.941363-1-lvivier@redhat.com>
 <20200921130406.941363-3-lvivier@redhat.com>
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
Message-ID: <1d8b5e82-7dfc-c262-46a2-14512d726258@redhat.com>
Date: Tue, 22 Sep 2020 09:37:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921130406.941363-3-lvivier@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 3:04 PM, Laurent Vivier wrote:
> Add trace functionis in vhost-vdpa.c.

Typo "function"?

> 
> All traces from this file can be enabled with '-trace vhost_vdpa*'.
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/virtio/trace-events | 29 ++++++++++++++
>  hw/virtio/vhost-vdpa.c | 86 +++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 110 insertions(+), 5 deletions(-)


