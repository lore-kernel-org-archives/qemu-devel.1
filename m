Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527FBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:23:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA2920781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZiJ9I5lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA2920781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhNv-0007CJ-EN
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqhNA-00063Y-MS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:22:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23109
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqhN8-0003ZA-Rz
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 14:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593627733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ke1rHIzL1Pt1iufsGeFTXuqybRMJ8MbA/Rv1Pn32Guo=;
 b=ZiJ9I5lPei7XWxbuDZQbd9meoLR5yu3GMr5IYd77IXMh+m+nlBB/BqqscNYpUdAOS+fzVQ
 TqJiT+YQhjoVbmiBfKs/t9/eEFFV2o/ikwzyUcqWwr2wi8l8hmdFxe0Vr+BQN2t6kgKo7G
 uThqYvA0V93lo+cKzPJ6RRcQt9MBSSM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-bcYt1liWPn6NDn-4Q9I4Uw-1; Wed, 01 Jul 2020 14:22:12 -0400
X-MC-Unique: bcYt1liWPn6NDn-4Q9I4Uw-1
Received: by mail-ed1-f72.google.com with SMTP id u59so22401867edc.16
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 11:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ke1rHIzL1Pt1iufsGeFTXuqybRMJ8MbA/Rv1Pn32Guo=;
 b=mb7q21buJ1lhFwW2IkT3CE//OrpryiN2PjijyzhQqWzM0oyjyaVGsfzN9d0t4JmJOz
 boepvL/cpQ7IVLUaWK3h6LG4OfPMMGo6M0Q7TztQtWUvGM9DY5gX1tgfAQa2DY76rvTX
 zB8nwSyWMBYfWNpxtjSCoVw8k4/EhPGo+58whgaVwHG8Ua12RiHiTM+8ZJSmURHZvxLB
 FNywqMTLv7OXjjN5jdgZYfTj/WwrwgcS5YcCRUrkntcjrz1LLmLRddt44VfSWYhbuCGz
 uHBYPcAKdoHx4Twc/CCcWLC28b5iWhx+/jEsOeLryfhCvcjuM6aAN2q0MmaSDYAzkDXe
 TEUw==
X-Gm-Message-State: AOAM530cJwKUfT4HqkOwwX0at66U617w6Ai+yTuEGoZ8NTOue6WzdgTO
 qxUaO0xn8J/VhlU5qO4uuwy8g+YkTDntRVZzYuy6TVSEzjiXImr5r9FFPbT49NPNrAAHBNOeuGm
 BBPT5mapnayAIJ7s=
X-Received: by 2002:aa7:c749:: with SMTP id c9mr28845824eds.107.1593627731197; 
 Wed, 01 Jul 2020 11:22:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxujd7IHEeJ2M0C3jAkPGjBmKSv7Gql6fIWvBEXjvf6QBdPY5Okk3Yh/hvzjTd7wb4fyxoBw==
X-Received: by 2002:aa7:c749:: with SMTP id c9mr28845811eds.107.1593627731044; 
 Wed, 01 Jul 2020 11:22:11 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d2sm7181758edk.4.2020.07.01.11.22.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 11:22:10 -0700 (PDT)
Subject: Re: [PATCH] util/drm: make portable
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 David Carlier <devnexen@gmail.com>
References: <20200701180302.14821-1-kraxel@redhat.com>
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
Message-ID: <4bc05de7-01eb-c695-bb68-8ef0d50bc1d1@redhat.com>
Date: Wed, 1 Jul 2020 20:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701180302.14821-1-kraxel@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:29:47
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 8:03 PM, Gerd Hoffmann wrote:
> Given this isn't perforance critical at all lets avoid the non-portable
> d_type and use fstat instead to check whenever the file is a chardev.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reported-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  util/drm.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/util/drm.c b/util/drm.c
> index a23ff2453826..6ba87f34f4ee 100644
> --- a/util/drm.c
> +++ b/util/drm.c
> @@ -24,7 +24,8 @@ int qemu_drm_rendernode_open(const char *rendernode)
>  {
>      DIR *dir;
>      struct dirent *e;
> -    int r, fd;
> +    struct stat st;
> +    int r, fd, ret;
>      char *p;
>  
>      if (rendernode) {
> @@ -38,10 +39,6 @@ int qemu_drm_rendernode_open(const char *rendernode)
>  
>      fd = -1;
>      while ((e = readdir(dir))) {
> -        if (e->d_type != DT_CHR) {
> -            continue;
> -        }
> -
>          if (strncmp(e->d_name, "renderD", 7)) {
>              continue;
>          }
> @@ -53,6 +50,16 @@ int qemu_drm_rendernode_open(const char *rendernode)
>              g_free(p);
>              continue;
>          }
> +
> +        /* prefer fstat() over checking e->d_type == DT_CHR for
> +         * portability reasons */
> +        ret = fstat(r, &st);
> +        if (ret < 0 || (st.st_mode & S_IFMT) != S_IFCHR) {
> +            close(r);
> +            g_free(p);
> +            continue;
> +        }
> +
>          fd = r;
>          g_free(p);
>          break;
> 


