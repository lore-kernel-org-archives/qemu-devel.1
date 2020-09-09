Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3804C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582EB2166E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X3ttREAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582EB2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3AL-0007S3-Af
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 12:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG39o-0006xs-Np
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:41:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46591
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG39m-0002Pf-O3
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 12:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599669673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3WepAS3hEyYI2BjquUQqnIAXB9DY7BMMZAj/UHaCsps=;
 b=X3ttREAIo83SMSDeNlSKhSFC5J1MS0Ajgf+x6cI3MXGazj1AY96meKJmTbS4CBRKyZH/4P
 YegJeCzrcdY+t6PfYjNNWxifA0PuWcnhPDkWx2bbLWTdlZ0yqGC0gLqiBzBGcIocH2z4YG
 +/VWCI9auJqQ/rMh8sAzXGRxM8QiQVc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-J5U2FkzLMNygoIaEpUiDNA-1; Wed, 09 Sep 2020 12:41:11 -0400
X-MC-Unique: J5U2FkzLMNygoIaEpUiDNA-1
Received: by mail-wr1-f72.google.com with SMTP id l15so1170185wro.10
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 09:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3WepAS3hEyYI2BjquUQqnIAXB9DY7BMMZAj/UHaCsps=;
 b=pmQN4xktc22uuyja3Gx9q5oWtb/sdmFYRVVbabIJcOMkGc6L/IF1fQ1J8ata48qJZx
 XFOQWR5j+LKnSQTZi811zx4q1YLCVqb8szDXyGBgf+m4PwsCKP55f8/MeoLLs+WzyyvR
 FUeiSj4YVNnbOMXcL0qS0apt7Myys7EGLF/2mmsOE2w1WwtP4zYC6+wsjVMdvX/lmng1
 vY67DiT2RfOfw3hjdBDVpNRY4G3+KSCVTaq0iWBgnG+NUuS5scBewnbsQuXZtt+eZNnB
 CKi/FG2gojCz6xacR/gZBROJgzeHzQurxx0S9NVFV1S2W8gqHwDH9nPDBgGw9dx0MaJA
 VSAg==
X-Gm-Message-State: AOAM531WDlYxs8JmggaecNI+wZvp4HghoGAy8i/nttzv33b3HkcYe2qG
 sIlcepFAjqKwy7r0eJOvZ+RP8tXKYtWw6QhytSHKDgVVfeFD+79+uBAwziG+K/fL3u+Ct2cBW4T
 OhypUqRuyt6x6bR8=
X-Received: by 2002:adf:ed12:: with SMTP id a18mr5211105wro.178.1599669670845; 
 Wed, 09 Sep 2020 09:41:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/KNn9VR58Nl8yD43QoHPxpwmKGymFozXPh2cd82DApBF5jIDsvE+OaQF+anDa0G39AXDNZg==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr5211092wro.178.1599669670637; 
 Wed, 09 Sep 2020 09:41:10 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k8sm4944217wma.16.2020.09.09.09.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 09:41:10 -0700 (PDT)
Subject: Re: [PATCH] qcow2: Return the original error code in
 qcow2_co_pwrite_zeroes()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200909123739.719-1-berto@igalia.com>
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
Message-ID: <cc1bf283-8a42-6662-85da-7507eea483b6@redhat.com>
Date: Wed, 9 Sep 2020 18:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909123739.719-1-berto@igalia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:37 PM, Alberto Garcia wrote:
> This function checks the current status of a (sub)cluster in order to
> see if an unaligned 'write zeroes' request can be done efficiently by
> simply updating the L2 metadata and without having to write actual
> zeroes to disk.
> 
> If the situation does not allow using the fast path then the function
> returns -ENOTSUP and the caller falls back to writing zeroes.
> 
> If can happen however that the aforementioned check returns an actual
> error code so in this case we should pass it to the caller.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index da56b1a4df..ca46cbd795 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3916,7 +3916,7 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(BlockDriverState *bs,
>               type != QCOW2_SUBCLUSTER_ZERO_PLAIN &&
>               type != QCOW2_SUBCLUSTER_ZERO_ALLOC)) {
>              qemu_co_mutex_unlock(&s->lock);
> -            return -ENOTSUP;
> +            return ret < 0 ? ret : -ENOTSUP;
>          }
>      } else {
>          qemu_co_mutex_lock(&s->lock);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


