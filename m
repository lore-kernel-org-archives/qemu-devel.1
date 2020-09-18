Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E0BC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29772075E
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 10:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0IspoQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29772075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJDUm-00027U-R5
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 06:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJDUC-0001ib-3k
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:19:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kJDU9-0002yY-Rh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 06:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600424360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xEOvW7v2NehhQ6VtJbjhy9K3C1408Q2hmc7RFbP+nhI=;
 b=E0IspoQ8A34Mp4N3ztyl/OCSHuW1zYRe7FqsE8iHLasWxUnWTFd7ZzQWa27V1omIcar93L
 VaOl7wWSXZ7vbsvlLgRRrzZdh879NcJGlc18R1BXJ8vQcGElysU1KyXj4t9RWQDj+XC+mn
 xYjO2nCUKcYB+8+/BIBDzFijs1pD5VE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Jd2LJLXIPB6_CxOjTW0qHA-1; Fri, 18 Sep 2020 06:19:19 -0400
X-MC-Unique: Jd2LJLXIPB6_CxOjTW0qHA-1
Received: by mail-wm1-f70.google.com with SMTP id m25so1890230wmi.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 03:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xEOvW7v2NehhQ6VtJbjhy9K3C1408Q2hmc7RFbP+nhI=;
 b=C/hq7r6BE0077S9KhqEz/eS0NKKnh7MzvyuEx1Ra4qMSby4CSQ3i31S97mmTenEvzR
 kXkpEBykqm7rVpG6j4/4HV9aDe0bDMvLQAJtFC7M7pbTXBURjUTXyd76pOtNmuuSurHm
 nax+oYz4ebvJcNelIJA6JJBHKlX7HmWzApH8w5+1DsOsmrD1nB+qub53epKKw7BQxHcl
 3L4Rlluq/80xOomLd97BCf2co0E4aRnr5/WXhsQlRo+Qgft7fu5Tja6bF+OimqH1J0AD
 J3HJHgntzxTCEyoYaNnz/2/Cp6y917DaasozJZ2sbfQQM+JZYhinukreJ6/EWYWwrIXC
 QbNg==
X-Gm-Message-State: AOAM532hlYQMGSTOkwH+VItka0cXmngW9TESgzRefLyHcKYz8rYF9LRF
 ai8qKZja677zRv1s5ou9Pt+spFfWlvhkYpxPjdCwUw0rxObPyN52jhM/aLzyofNX8ghYMdbWU+R
 CIqZNcvh1uZ2X0cI=
X-Received: by 2002:adf:f44d:: with SMTP id f13mr36631092wrp.224.1600424358159; 
 Fri, 18 Sep 2020 03:19:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/MloDD5kXRRwTCfHAjizS3qJXgouk3JANTqFBsMG0xsUTCnzirX6nWpODN6myegMlCZGEIg==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr36631068wrp.224.1600424357928; 
 Fri, 18 Sep 2020 03:19:17 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l18sm4367493wrp.84.2020.09.18.03.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Sep 2020 03:19:17 -0700 (PDT)
Subject: Re: [PATCH] spice: remove obsolete callback
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20200918100737.91646-1-marcandre.lureau@redhat.com>
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
Message-ID: <68a6a805-fe82-05e2-fbb3-ab86a1117394@redhat.com>
Date: Fri, 18 Sep 2020 12:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918100737.91646-1-marcandre.lureau@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 01:32:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: kraxel@redhat.com, fziglio@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/20 12:07 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The "attach_worker" callbacks aren't doing anything in QEMU, but they
> were mandatory until Spice server commit
> 6aa1a17c69dc3cc02f338a78b3266e4c00ea1c1a ("spice-qxl: Remove QXLWorker
> definition").
> 
> Furthermore, the old spelling is deprecated since commit
> 974692bda1e77af92b71ed43b022439448492cb9 ("spice-qxl: Fix typo in
> callback name and remove obsolete parameter")
> 
> Compile that code out if Spice server version is recent enough.
> 
> Fix compiler deprecation warnings with Spice > 0.14.3 (not released
> yet). We may want to wait until newer version is actually released to
> apply the patch.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/qxl.c   | 4 ++++
>  ui/spice-display.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index 11871340e7..a02072dee0 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -518,12 +518,14 @@ static int qxl_track_command(PCIQXLDevice *qxl, struct QXLCommandExt *ext)
>  
>  /* spice display interface callbacks */
>  

What about adding in include/ui/spice-display.h:

#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
#define SPACE_ATTACH_WORKER_MANDATORY
#endif

Then use #ifdef SPACE_ATTACH_WORKER_MANDATORY in the source files?

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
>  {
>      PCIQXLDevice *qxl = container_of(sin, PCIQXLDevice, ssd.qxl);
>  
>      trace_qxl_interface_attach_worker(qxl->id);
>  }
> +#endif
>  
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> @@ -1156,7 +1158,9 @@ static const QXLInterface qxl_interface = {
>      .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
>  
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>      .attache_worker          = interface_attach_worker,
> +#endif
>      .set_compression_level   = interface_set_compression_level,
>  #if SPICE_NEEDS_SET_MM_TIME
>      .set_mm_time             = interface_set_mm_time,
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 19632fdf6c..811936ff7f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -500,10 +500,12 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *ssd)
>  
>  /* spice display interface callbacks */
>  
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>  static void interface_attach_worker(QXLInstance *sin, QXLWorker *qxl_worker)
>  {
>      /* nothing to do */
>  }
> +#endif
>  
>  static void interface_set_compression_level(QXLInstance *sin, int level)
>  {
> @@ -709,7 +711,9 @@ static const QXLInterface dpy_interface = {
>      .base.major_version      = SPICE_INTERFACE_QXL_MAJOR,
>      .base.minor_version      = SPICE_INTERFACE_QXL_MINOR,
>  
> +#if SPICE_SERVER_VERSION < 0x000e04 /* release 0.14.4 */
>      .attache_worker          = interface_attach_worker,
> +#endif
>      .set_compression_level   = interface_set_compression_level,
>  #if SPICE_NEEDS_SET_MM_TIME
>      .set_mm_time             = interface_set_mm_time,
> 


