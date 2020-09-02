Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B242C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B7F208B3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 15:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSMiOCSU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B7F208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDUyW-0006tU-7T
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUx0-0006Fm-B0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:45:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43107
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDUwq-0004qD-W9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599061520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TY2uBOPtmih5cH8Roz13EYsJtQmR9aVZuU+zCAd1/I=;
 b=bSMiOCSUzAH/XgEJuonMugywa8I88m0JUOwlYpcak64IqLTcfrlvf6rYkr/gOpKBxfDegS
 5wOdnKwLiZsUCcK7Qt4k3HGPy5AnAfjbg0lC7t75dfIGYiRZC/nhHnURRsSq/GbCZ5K2fQ
 5jecWv8N+CDjN4jgaKgVQ3JYY4TAl3g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-1cLzDoZ7OCKvvuTQb5p1ig-1; Wed, 02 Sep 2020 11:45:19 -0400
X-MC-Unique: 1cLzDoZ7OCKvvuTQb5p1ig-1
Received: by mail-wr1-f71.google.com with SMTP id g6so2231736wrv.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+TY2uBOPtmih5cH8Roz13EYsJtQmR9aVZuU+zCAd1/I=;
 b=MzqtUJIgXbSUJ7GjxpAo+Ei3S46HTX8ht0BSsip+W8UX/CA96GK41Lb3+A5Lt0G45/
 bNZUdRn4oUqLCA93L/chJE1j4nHNBd1t34TjqfgW/7whZdEwmVQ8ogwuHIhHirI37LGX
 85EjFENLdrV28twEKjfKhfKcqoJjiWDszEirt3v7juSOcOZC01HYG8DnIk73B7jC1EM+
 nUSQ6tWiL/9owSfQ50diK/Hipb7Ek1S+7rWiy+2CQmbhpLEfWdqvy4eoNtR9Jfn8oZI4
 UU+4tsEXwyL0QcgAo6FevPC8sfXa+4XKFAGq4AQNcYz2iLutgC+oz7ElUfRn/P+9HKDL
 6CZw==
X-Gm-Message-State: AOAM532N0KBrlbxsOKQLj/fKXnqQDX25J52bxZgelqeovI1nXH6qBpxh
 bIME+7hM07B635BGFhjwa5jP35DtYbv33NyWPZhohaqjXXmXc4ITZXYss5NJJkA7u0d7p80mWbL
 +oQIYMb8upvgBIdQ=
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr1363146wmm.38.1599061517726; 
 Wed, 02 Sep 2020 08:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2M8FLvXMiOS8FchRIWx7r263j076l2jvd92y9D49c0k0j03r/UH6IsncHa2RnXsezzufoRw==
X-Received: by 2002:a05:600c:2246:: with SMTP id
 a6mr1363032wmm.38.1599061516230; 
 Wed, 02 Sep 2020 08:45:16 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.173.193])
 by smtp.gmail.com with ESMTPSA id k184sm133617wme.1.2020.09.02.08.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:45:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] meson: specify fuzz linker script as a project arg
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200902143800.124073-1-alxndr@bu.edu>
 <20200902143800.124073-2-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a629fc46-de76-50f0-f4b1-52031ee79267@redhat.com>
Date: Wed, 2 Sep 2020 17:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902143800.124073-2-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:33:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, darren.kenny@oracle.com,
 bsd@redhat.com, Thomas Huth <thuth@redhat.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/20 16:37, Alexander Bulekov wrote:
> With this change, the fuzzer-linker script should be specified outside
> any --start-group/--end-group pairs. We need this on oss-fuzz, where
> partially applying the linker-script results in a linker failure

Is this okay also for targets that don't link to the fuzzing static library?

Paolo


