Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB06C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF72120848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8l35b+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF72120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTPrx-00017Q-J7
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTPqa-0008Aw-Aa
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:32:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTPqT-00012M-PL
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602855151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvyPWIiqZro37uYGDlUoGeIw51WxvgHdTPhuq2JzYMo=;
 b=L8l35b+t6t6Z2/0jwQedlUFa/9572l649Ra/DKLe6sLFkhWwomX1cwfnFjLXFHwkmhvWgW
 77ayOLvMRLllvtDh+3CwixEFEuYKkurxth2CF3dwqnT2kl3JjJCQXnYpA9jP4ZFxNKgTXg
 3QH3GSDH7uye6tj1OcWCRrk2Z5jX3oM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-pG9yEy84Pai68i--WtqvQQ-1; Fri, 16 Oct 2020 09:32:29 -0400
X-MC-Unique: pG9yEy84Pai68i--WtqvQQ-1
Received: by mail-wm1-f70.google.com with SMTP id m14so754959wmi.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fvyPWIiqZro37uYGDlUoGeIw51WxvgHdTPhuq2JzYMo=;
 b=eJUKhtRYcQBXg9pNgVmbdtj5KtNhTbGKX/91fehR8QnnRMfOM+lbNcOcOpv32r6wyb
 LZaoGeUscaS+KkvIJXEzFCAwtl+sadu2gmsYfQ3n2+6nNhIluHIAAOpsP35qaFRVgwiV
 vd0/uvZ7avTA9FcI0DwGmtpZL7bBh++2EP/yXJH3G9ZIrGcDc/qNzGB+KmtnHahtMQ94
 G2SvuqGEo3LfTBbPblCErY+lyhFtvL8+vjyq9YyZWaPfzu+TE9MMtgDwY1+Go3pQGn97
 07Id+x/xCtn8jL9ARALs2MEqN9I54B58B8MmyaHYrRFOCfIsessJ5Z3bJ+c3B1+jKHRu
 701g==
X-Gm-Message-State: AOAM533pnuwvvaId+89vOnD6bqMOjgIsy8QMnB9DW29IUm9n1hKT90LR
 hH7BMG9iSAWrW98nH1W1krj7jB20rx3LtWV7THunZpquCV2wE5XBo/oSgVOhKaSgP0jcIoZ0m6K
 2AqJeUbCScpcriqY=
X-Received: by 2002:adf:de91:: with SMTP id w17mr3947657wrl.84.1602855147936; 
 Fri, 16 Oct 2020 06:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiqVKnKabAOYvvjgS9TlPdm0oicETpo9z/HR/h5bTl8JbBA1iPq8bfB9P05Hd0aiHA92wMyg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr3947631wrl.84.1602855147708; 
 Fri, 16 Oct 2020 06:32:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id u202sm2887864wmu.23.2020.10.16.06.32.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:32:27 -0700 (PDT)
Subject: Re: [PATCH v4 14/16] fuzz: add general-fuzz configs for oss-fuzz
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201015134137.205958-1-alxndr@bu.edu>
 <20201015134137.205958-15-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <beac36ec-1e23-6118-ce9c-ce5b19ac2394@redhat.com>
Date: Fri, 16 Oct 2020 15:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201015134137.205958-15-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/20 15:41, Alexander Bulekov wrote:
> +typedef struct general_fuzz_config {
> +    const char *name, *args, *objects;
> +} general_fuzz_config;
> +
> +GArray *get_general_fuzz_configs(void);

Can't it be even a "const struct general_fuzz_config
general_fuzz_configs[] = ..." instead of a GArray?  Not a huge
difference, but still.

Paolo


