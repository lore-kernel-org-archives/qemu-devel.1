Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669C3C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384032065F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 18:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXJ5rUBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384032065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDBS1-0002Qv-8d
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 14:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDBCH-0004qQ-HM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:39:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32928
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDBCE-0000M3-TR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 14:39:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598985592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkSDBu6l+Ztxj669gfGIYzTYqrHGhUz76mCIJLj7uKk=;
 b=UXJ5rUBXjmmH206exwEeqQrs8NGXqDppCpRBQUn/x8l2is/dO5UROP+L/y8+DhRzeMxXq5
 mnyHOSSWPKAzB2Got60FLXpGuTtM9zj+BwAqKLvDLqajiKyncduGPlQFjvaBPNdTvsEiMM
 eS2COLGpNZEi7PYhXADgO45mqdu+/K0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-5GIBFAV-Moazb9rhoH3kVQ-1; Tue, 01 Sep 2020 14:39:51 -0400
X-MC-Unique: 5GIBFAV-Moazb9rhoH3kVQ-1
Received: by mail-wr1-f70.google.com with SMTP id j2so912986wrr.14
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 11:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DkSDBu6l+Ztxj669gfGIYzTYqrHGhUz76mCIJLj7uKk=;
 b=jFfN1r8tdA/orCVswYxyWs/wCdNPr+DoSdhCgQ3PYyflfsjPnpbZWKR0CP7KhIaOR9
 rNCdgV3ou0vuYB5R+Ad5wkVhsIXx26lA/3vctRAQml6Ti00RWzxe5Bf23oAg/jMHbkvf
 19TNR5RPlOvAEhbdH2/MT9XGOBdHjbaAbGjo9K6DhQTJ+kV40lKBIWYe0bdgA5iw1MTI
 xCuN5eLQA9ULpo+BV3706dVVaOzUEhj3uOPBTy7CXfd2h+vvGpMXdyERKPHhbPUq0sHr
 1kDzhyGa68VvwCbwWeiJUe/bLMUO2vCLO+tqFcEcYd8dlPm3jeKuNwnwWqiSG1f5h/tx
 x1Bw==
X-Gm-Message-State: AOAM532bo/Duv8RUGXQr5nbcQoe31+diTy9QncwxUA0vfBoq0b9TGZJE
 09DHLPe9EpOAFrx9iKM5JNBtUZpggP0TTTp49TR1ZLfB34iZQ+TersiLjHd8gPeWfun3ivLBFd7
 OWbmcpqX5dl8q8zw=
X-Received: by 2002:a5d:610d:: with SMTP id v13mr3095430wrt.23.1598985589950; 
 Tue, 01 Sep 2020 11:39:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwyR0BUQ3ZRoKpybDP4ABk4f4ym2P1JiMa4bO5mmw2swLf9I2nBD0wDoZV5Hw2/8SQpMs4kWg==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr3095416wrt.23.1598985589770; 
 Tue, 01 Sep 2020 11:39:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7fbd:8007:1fa7:ed17?
 ([2001:b07:6468:f312:7fbd:8007:1fa7:ed17])
 by smtp.gmail.com with ESMTPSA id u66sm3048352wmg.44.2020.09.01.11.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 11:39:49 -0700 (PDT)
Subject: Re: [PATCH] fuzz: Add support for custom fuzzing library
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <9dfe703d-5c78-36d0-bc15-17ff6f9179d7@redhat.com>
 <20200901181800.326382-1-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dde8a8f1-a4b0-11ec-6247-c35004863598@redhat.com>
Date: Tue, 1 Sep 2020 20:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200901181800.326382-1-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:16:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Bandan Das <bsd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/20 20:18, Alexander Bulekov wrote:
> Maybe if I can get the oss-fuzz LIB_FUZZING_ENGINE
> (/usr/lib/libFuzzingEngine.a) into the --start-group, that could also
> solve the issue... I'll take another look at exactly what the oss-fuzz
> build container does.

Yeah, that might do it.  You can try adding it to the fork_fuzz dependency.

Paolo


