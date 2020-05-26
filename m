Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3810C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FAA20776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xec/pZW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FAA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdULu-0005Fx-A9
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUL9-0004Ws-83
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:49:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33946
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUL6-0001WQ-LO
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K2GqGqVpzeDHn/buEUhNhGyPmaeHSgXXuUVAu37OXCI=;
 b=Xec/pZW4kGLhaQnbNDWG4iShMKLzKz5wgmTVxsSOSdgPal7Poc981WUuES8c9eq4vFCCC+
 bd+k2Xg5jt7hEB972gVtGnoiPA5m7SErfeDAg8zOD+Pb2lSXibC3fbiEfNXknEs3LzPtMS
 dletxGOHcUBU57LV03IV+4Nj2WOKkyk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-1rTRZ6cUMmiOFVWo9qRXKQ-1; Tue, 26 May 2020 03:49:27 -0400
X-MC-Unique: 1rTRZ6cUMmiOFVWo9qRXKQ-1
Received: by mail-ed1-f69.google.com with SMTP id s14so615170edr.7
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K2GqGqVpzeDHn/buEUhNhGyPmaeHSgXXuUVAu37OXCI=;
 b=KPk6vMfS5kBDNiGzps4oQXufkobOwEP43YH2hlgIem74+wM8Aca6j3tbWauAX2/0j8
 jREQo1ITesoN45OCXaqdk6odxunblS/rGZ6ZW6er6CsJ4pB2SIgL+OFKP3W0berAhPPP
 8dCPxtBmT3EKmRjJ/Xs9k6GZyeRyQpbHSoSP/dEd5j0PFg+AjM5CIpN6xtJ34De6Jz/w
 /z+Sjcf1bOLddE3FXJpLLPsvDPKHtFEKhxHcHWSYhFaq7AtD5u6ehOlqIuCFqBTBHx/C
 PtBD8y/m9q+LplEDFuyDjUvyZESD1AT/8AhPg0XsQ40RertV9RibRkny6tcrEfpoQo5s
 wlcQ==
X-Gm-Message-State: AOAM5315sv7/eXsK2PrUbb70+DonX66uXZMArotECN37cydz5WHSPUo9
 RfGuEz0ySVAf4uG8AEC6FyeQNmfZGvQNHW86PSX+5J1J83ewVnL4A5uyx9wmVNfDAfD4VIDvK7r
 WbPV+GgJsxVYti+o=
X-Received: by 2002:a17:906:5681:: with SMTP id
 am1mr42808ejc.376.1590479366351; 
 Tue, 26 May 2020 00:49:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaTaUdTvYjLJ7OZAOl6l7bFMeGXvSjTuhOmoiYwgcF3wFbI4O+2W5+wOOffpdzVRW+U5VS9A==
X-Received: by 2002:a17:906:5681:: with SMTP id
 am1mr42790ejc.376.1590479366148; 
 Tue, 26 May 2020 00:49:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id r13sm6357090edq.53.2020.05.26.00.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:49:25 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] megasas: avoid NULL pointer dereference
To: P J P <ppandit@redhat.com>
References: <20200513192540.1583887-1-ppandit@redhat.com>
 <20200513192540.1583887-3-ppandit@redhat.com>
 <defefce8-72f2-65c2-04cf-918f3697532a@redhat.com>
 <nycvar.YSQ.7.77.849.2005261138520.62159@xnncv>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ae2f3c7-da4a-a1ce-e2c6-08e195d08a16@redhat.com>
Date: Tue, 26 May 2020 09:49:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.77.849.2005261138520.62159@xnncv>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ding Ren <rding@gatech.edu>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 09:18, P J P wrote:
> Later when address_space_map() returns 'NULL' above, '*plen' is not set to 
> zero.
> 
> diff --git a/exec.c b/exec.c
> index 5162f0d12f..4eea84bf66 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -3538,6 +3538,7 @@ void *address_space_map(AddressSpace *as,
>  
>      if (!memory_access_is_direct(mr, is_write)) {
>          if (atomic_xchg(&bounce.in_use, true)) {
> +            *plen = 0;
>              return NULL;
>          }
> 
> I'll send a revised patch above.

Great, this looks good.

Paolo


