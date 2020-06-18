Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A5DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C47207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPAVxzMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C47207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltTO-0003GW-6F
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jltS5-0002Hw-BQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:15:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24246
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jltS3-0001Ze-7b
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:15:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592482526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySdz41fDNOdTrRzwx7//o0/hQD1seKre8zcPrqXjRDE=;
 b=XPAVxzMYenHXCDg93TDeYb4J80BfyMlaRfbuaoxjYNofrgxDlTsQEdv0TeEu/4LyzgyGh9
 bjZyHOtM7BrXl3Nd5IvmJiv2mUljNmUqJZk0fl3t/gxJGAuwSP4HlNoLzXUdMWbNd49sbg
 ZZtfNXs2N61L4uYt0wTsnhjdFw1M5Vo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-jPdY_KRQMwukF7pUcfhJAg-1; Thu, 18 Jun 2020 08:15:24 -0400
X-MC-Unique: jPdY_KRQMwukF7pUcfhJAg-1
Received: by mail-wm1-f70.google.com with SMTP id x6so2504751wmj.9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 05:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ySdz41fDNOdTrRzwx7//o0/hQD1seKre8zcPrqXjRDE=;
 b=H64qeWsMe3IvwwfYQ5KbSbkxHwfLADlwNAKdd4AQarC+crcb7OxegNMx+y+iqnlDPQ
 4Y3oe/YPsoDwbT+ZFoQB0TTzKdtPiBkLqieyZQVeahESicdwZFLuebazdyIf2MER0Hkf
 f9YwftFVyJQ7Cdf6LoCJSdjXio0Uy5v+jgwzREaNVgPovmjtUA1qjUDVZb17sTdzO6CY
 iUOnfiaaTwcDK9ag3uleLE1EkrWSbVbyxjx2SHA+14p09HL+LGYNDzwZMlIAkuLcWWYl
 CVGFYrGrXsrhyTyKHX3f1CzjxOAnWIbKVpQB/bicMPxQxkPXtD3Pn7bW4X+7Esjh1B2b
 1O5w==
X-Gm-Message-State: AOAM533AnByF2RXk/mJ6u/ajwajKd2mHVCl6gllc8v50Rml6/LKg0gwq
 QtQuHHSkfGv3XXmrlrpzCNSujPOsb/S49TDfkZ4N2ewbmVkNNKUsNg0E1jyeiQVVSZwHVRD2T0E
 3YkVMelLdup4dtmY=
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4243087wrw.63.1592482523110;
 Thu, 18 Jun 2020 05:15:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKoawyynYX8J8sn/FtrBkvn1wTqUpMgN4G3+Vt2mEo7Msk/He8zChANYkim7Oj1nHIrYtG+w==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr4243069wrw.63.1592482522908;
 Thu, 18 Jun 2020 05:15:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e1d2:138e:4eff:42cb?
 ([2001:b07:6468:f312:e1d2:138e:4eff:42cb])
 by smtp.gmail.com with ESMTPSA id g3sm3740742wrb.46.2020.06.18.05.15.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 05:15:22 -0700 (PDT)
Subject: Re: qemu-pr-helper -v suppresses errors, isn't that weird?
To: Markus Armbruster <armbru@redhat.com>
References: <87imfpszvr.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4a56a2cb-0025-cefc-68a0-37a14641b7b1@redhat.com>
Date: Thu, 18 Jun 2020 14:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87imfpszvr.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:47:12
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/06/20 07:32, Markus Armbruster wrote:
> prh_co_entry() reports reports errors reading requests / writing
> responses only when @verbose (command line -v); relevant code appended
> for you convenience.
> 
> Sure these are *errors*?  The program recovers and continues, and this
> is deemed normal enough to inform the user only when he specifically
> asks for it.  Yet when we inform, we format it as an error.  Should we
> tune it down to warnings?

They are errors, but they're errors in the client rather than in
qemu-pr-helper.c itself.

Paolo

> 
> static void coroutine_fn prh_co_entry(void *opaque)
> {
>     [...]
>     while (atomic_read(&state) == RUNNING) {
>         [...]
>         sz = prh_read_request(client, &req, &resp, &local_err);
>         if (sz < 0) {
>             break;
>         }
>         [...]
>         if (prh_write_response(client, &req, &resp, &local_err) < 0) {
>             break;
>         }
>     }
>     if (local_err) {
>         if (verbose == 0) {
>             error_free(local_err);
>         } else {
>             error_report_err(local_err);
>         }
>     }
> 
> out:
>     qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
>     object_unref(OBJECT(client->ioc));
>     g_free(client);
> }
> 


