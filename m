Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C114FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:29:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B886207ED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ld+hk5kL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B886207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiVt8-0003Eb-Qe
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 00:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiVsM-0002mg-QE
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:28:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21835
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiVsL-0002xb-67
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591676914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LPElhX49VV3BV76W6MaqdEyY1VjWKaWxymyj/UGcFZ4=;
 b=Ld+hk5kLOKN8v6MIcJH5Mv0c3jqROUg001smnIIHIJy3KT/BuKzZgsxh985VgslzEvVR93
 QhveItOk79lviL/R1Ne42DVLGQnBpATIvE8uKYxUIRzi0F7Obkp8WEB/6kfyXpXlLIYZds
 tYzq8udbdsJ5eIrR0yyQZENK1lBYtV4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166--aPq2CPMO2S8kVsDnLLG-A-1; Tue, 09 Jun 2020 00:28:31 -0400
X-MC-Unique: -aPq2CPMO2S8kVsDnLLG-A-1
Received: by mail-wr1-f69.google.com with SMTP id h6so8113217wrx.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 21:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=LPElhX49VV3BV76W6MaqdEyY1VjWKaWxymyj/UGcFZ4=;
 b=eleT8ghi86WNX2V2GErWutI4ZRWrbICcP1hEbS9ND5hrxdH1dxsRvqTyaK2HxNelZS
 xPR0hNLj0oCY3wisHspA+U2C+pWkZlQFZkMQ1+Fq/WhfC6h8Kb9qWZNF/unGhkDppm/W
 OPYPe+Hgf5otYbn6VeEa1xhb63naokgOxi5dVxFrO6lBwRjHGYijoFdu4aM36EDfXBSm
 NwHARgJ9WTH86vfwkWVXdCOc4sgcCnDnOg67XA4ylLipga+e9r3mi6ExxHJpOa/UhMFJ
 E+r0J8pBO5/yHmfNx6sIXWtMTlLKIMJjqfhfKYhX29wrAqK0MzgSBcyuu0zcwhW5rYCa
 VnHg==
X-Gm-Message-State: AOAM530MfNJ6QL/06fkENB7FiQm+QXO4qepddAeqOgy7oXB8dVirYolA
 UCfVNmm9JVfJkli4KuHlbTjcsc07UwHFXch1RUzhCCpLlEeoUK4yp8emraNOyDbjbHGijmYz4b5
 jxHEGMAJmxjdXQIg=
X-Received: by 2002:a5d:6884:: with SMTP id h4mr2366800wru.198.1591676910063; 
 Mon, 08 Jun 2020 21:28:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL6yGlYLq5uVkf26nsZMVqRUocmhTXo8Iql5QWkouQ6r3gmy11UnKNx6hS1AV4IwB+9HEdNQ==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr2366776wru.198.1591676909711; 
 Mon, 08 Jun 2020 21:28:29 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d24sm1441410wmb.45.2020.06.08.21.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 21:28:29 -0700 (PDT)
Subject: Re: [PATCH] Makefile: Install qemu-[qmp/ga]-ref.* into the directory
 "interop"
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1591663670-47712-1-git-send-email-wang.yi59@zte.com.cn>
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
Message-ID: <94e456a8-0b4f-e1fd-7baa-8f81f36c6872@redhat.com>
Date: Tue, 9 Jun 2020 06:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1591663670-47712-1-git-send-email-wang.yi59@zte.com.cn>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 00:28:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: xue.zhihong@zte.com.cn, QEMU Trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 2:47 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> We need install qemu-[qmp/ga]-ref.* files into the subdirectory of qemu docs: interop.
> 
> If we visit the following address and click the link to qemu-qmp-ref.html:
> https://www.qemu.org/docs/master/interop/bitmaps.html#basic-qmp-usage
> 
> It will report following error:
> "
> Not Found
> The requested URL /docs/master/interop/qemu-qmp-ref.html was not found on this server.
> "
> 

Fixes: d59157ea058b5 ('docs: create interop/ subdirectory')
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  Makefile           | 10 ++++++----
>  docs/index.html.in |  4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 40e4f76..49dbe7a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -879,8 +879,9 @@ install-sphinxdocs: sphinxdocs
>  install-doc: $(DOCS) install-sphinxdocs
>  	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/index.html "$(DESTDIR)$(qemu_docdir)"
> -	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)"
> -	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)"
> +	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
> +	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
> +	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
>  ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu.1 "$(DESTDIR)$(mandir)/man1"
> @@ -898,8 +899,9 @@ ifdef CONFIG_TRACE_SYSTEMTAP
>  endif
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(mandir)/man8"
> -	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)"
> -	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)"
> +	$(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)/interop"
> +	$(INSTALL_DATA) docs/interop/qemu-ga-ref.html "$(DESTDIR)$(qemu_docdir)/interop"
> +	$(INSTALL_DATA) docs/interop/qemu-ga-ref.txt "$(DESTDIR)$(qemu_docdir)/interop"
>  	$(INSTALL_DATA) docs/interop/qemu-ga-ref.7 "$(DESTDIR)$(mandir)/man7"
>  endif
>  endif
> diff --git a/docs/index.html.in b/docs/index.html.in
> index e9a1603..6736fa4 100644
> --- a/docs/index.html.in
> +++ b/docs/index.html.in
> @@ -12,8 +12,8 @@
>              <li><a href="tools/index.html">Tools Guide</a></li>
>              <li><a href="interop/index.html">System Emulation Management and Interoperability Guide</a></li>
>              <li><a href="specs/index.html">System Emulation Guest Hardware Specifications</a></li>
> -            <li><a href="qemu-qmp-ref.html">QMP Reference Manual</a></li>
> -            <li><a href="qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
> +            <li><a href="interop/qemu-qmp-ref.html">QMP Reference Manual</a></li>
> +            <li><a href="interop/qemu-ga-ref.html">Guest Agent Protocol Reference</a></li>
>          </ul>
>      </body>
>  </html>
> 


