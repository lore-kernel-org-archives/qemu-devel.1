Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173EB204EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6JLbOT+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173EB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvNk8-0004gt-D4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNhg-0000BZ-AD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38911
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvNhe-0002Qz-M1
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594743766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ggAZPwgFaHH0Tr8NNCwCfFm3IdIMlzKerCSBSjJytO8=;
 b=A6JLbOT+G/+TJA4xb0h1fi7VIDfQ7MtruW5ERFNrgx6InJyN0hA8XYwPiGdv1JNf/OIdCu
 fKMzO5UuKd1jLw8Jnmpns3i9wbp3RP20W21HNn8rXUyje1drgJfk3iZGlh1nGdNK0YZ4zE
 jrqmini7j/tOXMu/YzTsU59ZM+egjeg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-B2klAhkfO0u5gOuxU2rW3Q-1; Tue, 14 Jul 2020 12:22:44 -0400
X-MC-Unique: B2klAhkfO0u5gOuxU2rW3Q-1
Received: by mail-wm1-f71.google.com with SMTP id z11so4678905wmg.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 09:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ggAZPwgFaHH0Tr8NNCwCfFm3IdIMlzKerCSBSjJytO8=;
 b=AiaJgcXmQv1mPeUfvQN8WvVpFYLYerv6hfd/bVf5bvgLLUZYq2+p+nfW3xS/AHtP/I
 gNKRo6hu1cEw/qD19nmcLRLEBkbVUiO9RsesTX+6IVOFoGezVrpBBWawKPdEfj+dkUCD
 MW2w7g/zFwzaC0exNfAOrNpKvxL/1y37an79uLs9v2MfoakSBGLlH5tJLLM1CQJqMjnt
 C+SZZn63GpeM4JrTthusIIb0ONcRsL8xh4F8iVHjYjgDeUEPGy/cLneQm5c3UXRZKSom
 RcH2+fxJhEcyC2hkSUzitl0cwGIj+7xiUNJZjqYvJfjxMr5o7PEVlUyvLYu7utxkB9KB
 nN3g==
X-Gm-Message-State: AOAM533boBoB+sfMtV1LxLL0HUxfhae3LhmNk2rO5RTx+fITwspOc7aP
 /UlR7kInM4RLioMc4ykYyZLcq331P31syKjZrg7o7e4cqHQ/pBjH50Gs2PMmx4lkClZIinV1z5U
 KAFHCHxZcympdmc8=
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr6685854wrx.173.1594743763306; 
 Tue, 14 Jul 2020 09:22:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyi+FNASv89lhEDoQuarZSEdUz/fA9ZNMzorZ2H6o3IGk/z71Jt4tNVn3YtV+ofxL71tMtLFw==
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr6685828wrx.173.1594743763119; 
 Tue, 14 Jul 2020 09:22:43 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q7sm31004817wra.56.2020.07.14.09.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 09:22:42 -0700 (PDT)
Subject: Re: [PATCH for-5.1 1/5] qdev: Fix device_add DRIVER, help to print to
 monitor
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200714160202.3121879-1-armbru@redhat.com>
 <20200714160202.3121879-2-armbru@redhat.com>
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
Message-ID: <8b41b736-c987-bb9e-b2e1-9ece09e29932@redhat.com>
Date: Tue, 14 Jul 2020 18:22:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714160202.3121879-2-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: lvivier@redhat.com, thuth@redhat.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-stable@nongnu.org, pbonzini@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/14/20 6:01 PM, Markus Armbruster wrote:
> Help on device properties gets printed to stdout instead of the
> monitor.  If you have the monitor anywhere else, no help for you.
> Broken when commit e1043d674d "qdev: use object_property_help()"
> accidentally switched from qemu_printf() to printf().  Switch right
> back.
> 
> Fixes: e1043d674d792ff64aebae1a3eafc08b38a8a085
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 71ebce19df..e9b7228480 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c

#pragma GCC poison printf
#pragma GCC poison fprintf

;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> @@ -300,7 +300,7 @@ int qdev_device_help(QemuOpts *opts)
>      }
>      g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
>      for (i = 0; i < array->len; i++) {
> -        printf("%s\n", (char *)array->pdata[i]);
> +        qemu_printf("%s\n", (char *)array->pdata[i]);
>      }
>      g_ptr_array_set_free_func(array, g_free);
>      g_ptr_array_free(array, true);
> 


