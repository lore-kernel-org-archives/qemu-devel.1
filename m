Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C462CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:50:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9178920B80
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHosE/fu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9178920B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsiA-0001fu-Qc
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdsgs-0000ma-UY
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:49:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26708
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdsgq-00063u-Mw
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590572974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eWYHChU5Dj0hwu+afnRhRY6vqKjsT+9iJJvKAjxmwzw=;
 b=MHosE/fuW8e/CuLu5Vr3rNWV7MDmxV3C2uPIy6HXGl44r//cV3HwVzU3ZwpfDJIUDtkeyx
 J7BOStK0tefGPkh5PC42+B9g5tzFAvdTJzSaQBqsDQya3J6gzN9urIcvEO31BjU1+GyT0U
 GMROIFHo7lSBYhofto5diBB8XNRgkHE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-LRRoCohLPz2S-kunof9wvw-1; Wed, 27 May 2020 05:49:32 -0400
X-MC-Unique: LRRoCohLPz2S-kunof9wvw-1
Received: by mail-wr1-f72.google.com with SMTP id f4so8336905wrp.21
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 02:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=eWYHChU5Dj0hwu+afnRhRY6vqKjsT+9iJJvKAjxmwzw=;
 b=QzdBlfHuslcNKe/8D+3Bf64lg9Ajj35OSiBZpbosVBcmD4bIsfkA9ivrA1scqbqTiP
 JrxuuBHlcJUylg2mfb76kCAvyKLE+jw+qMtsF7yeeoXNNwg2xWEjXsCKoZcYQPK9Ndhp
 l4FbrHxwhOacjr+7ef4PqGI+lWLvHgL4Pn7rLzlnMNt1wHwKTLCizBx9t1CK9reo9bKg
 G4SrM3M2o7bZ7JVvlhrfQ8BHlmigMIOv4fjGyrkbz2e7Dytd1jB9G+Dw7Un6nc21rk5l
 zRKbi969jJ8OOvStYyoNb6JiEyzdpPBOVLvWRT3sFsgySF7CqH1zQ/mree3Wh6Bvc7IZ
 PwYg==
X-Gm-Message-State: AOAM532iSGT1Uh+bdVcxC3CPGefd2taaiyHBkMvXuoRXXZimGFMLZD88
 oU1cMrGA2qzns6E3E+YKuw6TOnVf61vwgdUkb9LNJyo/nN2yIZ6WHP4CTrLa60M4lL88MQ08XUG
 VbnVgvBApx6S5jcI=
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr24357691wre.275.1590572971649; 
 Wed, 27 May 2020 02:49:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfr2lpi/bpXkrc4f/4qXngTDqFiT12n4/C0nZGb+MnNM1YUtY9LpMo4nxXj4sONXP4POx+3Q==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr24357673wre.275.1590572971404; 
 Wed, 27 May 2020 02:49:31 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id a124sm2427009wmh.4.2020.05.27.02.49.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2020 02:49:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] qom: Constify
 object_get_canonical_path{,_component}()'s parameter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-2-armbru@redhat.com>
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
Message-ID: <da793e4a-0d7b-f1d0-b735-3a1b5e83e11c@redhat.com>
Date: Wed, 27 May 2020 11:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200527084754.7531-2-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:46:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 10:47 AM, Markus Armbruster wrote:
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qom/object.h | 4 ++--
>  qom/object.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index fd453dc8d6..b3eb05d65d 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1406,7 +1406,7 @@ Object *object_get_internal_root(void);
>   * path is the path within the composition tree starting from the root.
>   * %NULL if the object doesn't have a parent (and thus a canonical path).
>   */
> -char *object_get_canonical_path_component(Object *obj);
> +char *object_get_canonical_path_component(const Object *obj);
>  
>  /**
>   * object_get_canonical_path:
> @@ -1414,7 +1414,7 @@ char *object_get_canonical_path_component(Object *obj);
>   * Returns: The canonical path for a object.  This is the path within the
>   * composition tree starting from the root.
>   */
> -char *object_get_canonical_path(Object *obj);
> +char *object_get_canonical_path(const Object *obj);
>  
>  /**
>   * object_resolve_path:
> diff --git a/qom/object.c b/qom/object.c
> index d0be42c8d6..c02487ec1a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1883,7 +1883,7 @@ object_property_add_const_link(Object *obj, const char *name,
>                                  NULL, OBJ_PROP_LINK_DIRECT);
>  }
>  
> -char *object_get_canonical_path_component(Object *obj)
> +char *object_get_canonical_path_component(const Object *obj)
>  {
>      ObjectProperty *prop = NULL;
>      GHashTableIter iter;
> @@ -1908,7 +1908,7 @@ char *object_get_canonical_path_component(Object *obj)
>      return NULL;
>  }
>  
> -char *object_get_canonical_path(Object *obj)
> +char *object_get_canonical_path(const Object *obj)
>  {
>      Object *root = object_get_root();
>      char *newpath, *path = NULL;
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


