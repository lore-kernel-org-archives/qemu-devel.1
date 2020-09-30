Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59490C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B969320B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 23:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLrz/91B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B969320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNlfW-0006uj-Mw
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 19:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNlex-0006Tn-VW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 19:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNlev-0002y0-Oj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 19:37:19 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601509036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4+nsmi2lXoKFzMEw0jJpxApbbGvz2CBxefKBwgMdKE=;
 b=KLrz/91Bsj2BkKKE9Yhj0HCpD7InWmwPjaJHqDhFKyOghjBOvHRMtDEBC3SkDgNon6oYCg
 Cn4dX3wDz4eRjpKVEI7O9JJjZ7p1WWUYvrLNjm1/3nJ0KbsqfrlK7C8GDzooYY1p7PgG1w
 PEwMjZ/ob9nA5QhPYlZiU9+z4Opmqgc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Ig8wZ581PFWJsr5QDodhQQ-1; Wed, 30 Sep 2020 19:37:14 -0400
X-MC-Unique: Ig8wZ581PFWJsr5QDodhQQ-1
Received: by mail-wr1-f70.google.com with SMTP id h4so1276750wrb.4
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 16:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q4+nsmi2lXoKFzMEw0jJpxApbbGvz2CBxefKBwgMdKE=;
 b=tKRU1Frk6y9kRjZJhcMPwcY1Bqy5VzinBJ9qiq9vK5TYH7gU1NHVZP0YENyHqzzuo/
 X6GnswTeb6+POFtPYB0FqZHmXAtDZoVn/aJ4bjEvHelIbuq23GCK5seX0X5EVezEtcF1
 sA3mTD7JtnaQLI8s+126QrPV5EeNr2JpvkDYf1i7DazX+t9iLfbRRLhCnblwH2Op3v/c
 fPBIyaUWjysrVy7o4k+1/sx+6tCpyk4jfaDTmNtulE4U1/oaaQXNA14hNcDnlFUy4Giu
 iLspVvcUsyT85WBxY9Hrl1NsHxmgTMopiIujEKppd7MRfX6DWfHe7UQxWjh6vXR/YXrw
 TIew==
X-Gm-Message-State: AOAM530ee42d110JVhbyViml8zJEoCGHn0voOvVctrj6T6oi3fDSdhZY
 zEDnX+3ewd1kqyLktSmKXBiUcia8deHkBE1wKnDB70rzdZ5ETmvsYFAE13xT3epOcPDt9+I6+Bw
 vyiAP7NZpJosehgY=
X-Received: by 2002:a5d:6784:: with SMTP id v4mr5928236wru.132.1601509032736; 
 Wed, 30 Sep 2020 16:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyovlP78EtYnDog5/LJ9In3o8X2O0IegHZQUPZnOzpMAWCy+qRrvbTJnN2DYkyBWmR5LEa2oA==
X-Received: by 2002:a5d:6784:: with SMTP id v4mr5928224wru.132.1601509032489; 
 Wed, 30 Sep 2020 16:37:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id c16sm6126858wrx.31.2020.09.30.16.37.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 16:37:11 -0700 (PDT)
Subject: Re: [PATCH 01/10] qdev: add "check if address free" callback for buses
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-2-pbonzini@redhat.com>
 <0ce8035d631324768ff0f2914499740c8ba992c1.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <861b0950-b5c4-f53a-c9d8-e5b22c873188@redhat.com>
Date: Thu, 1 Oct 2020 01:37:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0ce8035d631324768ff0f2914499740c8ba992c1.camel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 18:09:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 16:27, Maxim Levitsky wrote:
> My patch that switches the direction in scsi_device_find, is supposed to be completely equavalent, 
> based on the following train of thought:
> 
> If scsi_device_find finds an exact match it returns only it, as before.
> 
> Otherwise scsi_device_find were to scan from end of the list to the start, and every time,
> it finds a device with same channel/id it would update the target_dev
> and return it when it reaches the end of the list. 
> 
> If I am not mistaken this means that it would return _first_ device in the 
> list that matches the channel/id.
> This is exactly what new version of scsi_device_find does.

Oh!  I missed that subtlety.  Thanks, that makes sense.

Paolo


