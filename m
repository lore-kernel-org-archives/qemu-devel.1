Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9583C2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 10:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMw0bqF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9583C2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jng8H-0007I2-Rx
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 06:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jng7G-0005Jd-L3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:25:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44628
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jng7D-00008U-LQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 06:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592907918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cV1M9YGFTmXWt2Jf3bWzGbxZWgKMlsLVJlnZWCosqAc=;
 b=YMw0bqF6z/smsOxhz9o48uDhxxQNUkyk4EHPjjuVvzLOPBjkLhwcZ2yjqb4NoZqETa+jVJ
 ftzqVCbvpAAlGZpsvnWRuZvPy6Q5KtFtEfeRdLtN1wvACRMqe8P5CV1cJfKvgGIcolGl20
 pFMPDYZXiXlJL9m0R1MLbQtBuQaz6wE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-5CglXDk9M6S20PlJpSqkaQ-1; Tue, 23 Jun 2020 06:25:16 -0400
X-MC-Unique: 5CglXDk9M6S20PlJpSqkaQ-1
Received: by mail-wr1-f69.google.com with SMTP id g14so7902456wrp.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 03:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cV1M9YGFTmXWt2Jf3bWzGbxZWgKMlsLVJlnZWCosqAc=;
 b=AzyFi9dybXAx3w2cx1PEvFhPwLUEObka9hBFQykB4ZcTRcZzXJhOIJ1IBta5bWmUvs
 EoQuiE4bctilZ60QKfmF+uh5pFH+VSH5AWvWR08w0jKzPlpoaM6UpnbF4/Dh5iFIDhgp
 fEOksbkfKGZriHXzvdDmYnpGmdrRcfVP67DKigw09As2rxRG77m1etELhM/PGdDFakxH
 PgJFEXvUD/p+XJnDK01NmG9lKTEk6ACBpEzfKZQKF2wG68BzWvA2EFUTIpuK2AEfvIcA
 mGPAKIL0uzzFOxL2nKF4kaZxAXunebgXyBaEZm0gdbJ5TSu/HIp9lfLDcsS6jljVnDQU
 8knA==
X-Gm-Message-State: AOAM530cUqYBfzsd1ANPUReVYrrc1GlG6O88a4u9Q9P0IcwHfLQkv2Fl
 xY+AN4qJtDRrwnTBK8e9kyivDwpcBoCiLiYl1VhrHSLG61Sao9XH8hsWrqJYMPMh91xlBSgymFR
 hqjbAnHWv9O2Mglk=
X-Received: by 2002:a1c:44e:: with SMTP id 75mr4088464wme.139.1592907915568;
 Tue, 23 Jun 2020 03:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF9dgpTmtmGbvje17D+Fh3UxY/nQ2y5gX4wnPO4aVSyvm0F2JONXYCdVLAjZUfSuCVFb07pA==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr4088380wme.139.1592907914435;
 Tue, 23 Jun 2020 03:25:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879?
 ([2001:b07:6468:f312:24f5:23b:4085:b879])
 by smtp.gmail.com with ESMTPSA id i19sm15775721wrb.56.2020.06.23.03.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 03:25:13 -0700 (PDT)
Subject: Re: [PULL 027/115] hw/i386/vmport: Propagate IOPort read to vCPU EAX
 register
To: Liran Alon <liran.alon@oracle.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20200611194449.31468-1-pbonzini@redhat.com>
 <20200611194449.31468-28-pbonzini@redhat.com>
 <f6f506ab-99a9-0f64-3bc0-2090f58f80f0@redhat.com>
 <db41f0d2-386c-44c9-9b44-2e1e72648e2a@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a058b208-8b8f-49cd-982b-ce2c4db158f1@redhat.com>
Date: Tue, 23 Jun 2020 12:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <db41f0d2-386c-44c9-9b44-2e1e72648e2a@oracle.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
Cc: Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/20 11:34, Liran Alon wrote:
> Having said that, I believe the compatibility risk here is very small
> and therefore because QEMU 5.0 was
> released for a very short time-span before these patches were merged,
> I'm not sure it's really preferable
> to move these flags to hw_compat_5_0[]. But I will leave this for Paolo
> to decide.
> (Note that moving these flags will also risk in comparability people
> running with current patches and
> specifying explicitly machine-type 5.0...)

Since this has never made it into a release, I'll fix them up.

Paolo


