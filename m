Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D394EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4CD20787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1vEC1Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4CD20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctfh-0006He-Pg
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jctew-0005s6-L7
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:39:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24280
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcteu-0005iA-5p
 for qemu-devel@nongnu.org; Sun, 24 May 2020 12:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590338370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dWXx6c1eqDiBY/zo82yg3apcylvbtNbb5t6GRgotmmo=;
 b=K1vEC1ZzHtrVI3TakwpY44UcnCGBdhEHgKghT3pmNUyHl6KfyS/yc+Px4wzAOH/dpVeFsF
 psvwOb/j3MTwBV60uiQxsCcIkOheFCYFLbLhkxNPIwJoa/d2B5m4Tv4L0DsUS/3xCrevaW
 fCGSxh/0OrSjQFfBlPEblCimOhQ2Xi4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-TBj8fjB7O7-evMMikkaMzQ-1; Sun, 24 May 2020 12:39:28 -0400
X-MC-Unique: TBj8fjB7O7-evMMikkaMzQ-1
Received: by mail-wr1-f71.google.com with SMTP id f4so4352700wrp.21
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 09:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=dWXx6c1eqDiBY/zo82yg3apcylvbtNbb5t6GRgotmmo=;
 b=WB1/BqEXS3H+CErD55n0u+HBHA8PRM/1XQo/KL0xCYUhdsvBvMm0ZAr6V/4XB3fB92
 6HU6G+QMCP+tsk9tPuiQ3Ay1ZSZoz/C70cyL40OWWQlGyUyKg4zpoUE8pOW1zFnk9LkK
 g8xO0tgsvlMXZyqLFiJUzHz6v2+mB3rIiq4GLBQ8ayIvYMEu0G8diivufPSTwgrcn2Nl
 lGvty5V2oJhYu/KeseoJ4hgklnyVg8N6MSfqDfc2zP+1poF727AjsMPNKR5Bu1ed3rBb
 c3KrtJL36mlBQO/Xo1J3/n1OylH8ejPz8L3+1DAVJjAWFfCAQtsdhhIky3fcmM+ilSEn
 nwDA==
X-Gm-Message-State: AOAM531dJI1Cdx1QTJrORekZpA+VPu13ZO/JNUM++1uEg2fPqO3vsscr
 vT/Bg8MKgYIUtEUzPHwO5S1FuPyjKssX1H+QvrDQu/yzO7K2pKMfUR5MZDjml6wT8Hh02fWXifK
 HAx5kHJV9GwFEklw=
X-Received: by 2002:adf:ab09:: with SMTP id q9mr11342952wrc.79.1590338367191; 
 Sun, 24 May 2020 09:39:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDNqWI3vP9SSoFrhS6JmbA0zH/JaoiihUraZsZRMC1pfD0qTS8fGNK6+RaNm2cvVoMzN/r4g==
X-Received: by 2002:adf:ab09:: with SMTP id q9mr11342936wrc.79.1590338366919; 
 Sun, 24 May 2020 09:39:26 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id e21sm15180010wme.34.2020.05.24.09.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 09:39:26 -0700 (PDT)
Subject: Re: [PATCH RFC v3 03/11] KVM: Fixup kvm_log_clear_one_slot() ioctl
 return check
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20200523232035.1029349-1-peterx@redhat.com>
 <20200523232035.1029349-4-peterx@redhat.com>
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
Message-ID: <6c00fc1e-7a01-2957-fbf5-9b70cc017f1d@redhat.com>
Date: Sun, 24 May 2020 18:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200523232035.1029349-4-peterx@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 12:39:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 1:20 AM, Peter Xu wrote:
> kvm_vm_ioctl() handles the errno trick already for ioctl() on
> returning -1 for errors.  Fix this.
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  accel/kvm/kvm-all.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index d06cc04079..6e015aa2d4 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -699,14 +699,13 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
>      d.num_pages = bmap_npages;
>      d.slot = mem->slot | (as_id << 16);
>  
> -    if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
> -        ret = -errno;
> +    ret = kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d);
> +    if (ret) {
>          error_report("%s: KVM_CLEAR_DIRTY_LOG failed, slot=%d, "
>                       "start=0x%"PRIx64", size=0x%"PRIx32", errno=%d",
>                       __func__, d.slot, (uint64_t)d.first_page,
>                       (uint32_t)d.num_pages, ret);
>      } else {
> -        ret = 0;
>          trace_kvm_clear_dirty_log(d.slot, d.first_page, d.num_pages);
>      }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


