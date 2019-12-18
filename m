Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC675C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB156206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 11:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5icDWTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB156206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihXth-0007RC-SL
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 06:53:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihXsy-00072n-Fe
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihXsw-0002RE-9o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:52:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37912
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihXsw-0002LB-1L
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 06:52:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576669977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAg+8tVPdsj7FCPPOqXhgam7WzTZUUQBbMEBaFocZmk=;
 b=K5icDWTS9yGVHqXstbPIVfgiQ4GPzYWuuMb7Efsrh0yanod/egQgxJsZ1DU3UB3/JOmavT
 BfybFG9Hkbd+ORF/vxXcDuTt8MrHn3K/jgEQ6LrhhBXd7ntRRiH81CS98/LjDiBMQxHVNq
 cOpxTsxV8lcSoQ96l3Q+oiTpCwKoNFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-_KRCfvZ4Ntih4BcYpYPjvg-1; Wed, 18 Dec 2019 06:52:56 -0500
Received: by mail-wm1-f72.google.com with SMTP id y125so1711879wmg.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 03:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dAg+8tVPdsj7FCPPOqXhgam7WzTZUUQBbMEBaFocZmk=;
 b=ltQlOapyprzq2qx3bcD5x02fMyd/BuNkyIAn1dTOQ/GYVBUmHi5/VWrZ+niqA3qFI+
 leL4qdH82nSU0T55HA2h3lopym2yp650IFre7744e7i6LLHaFrYatITlJi9+AeCzl+gR
 l5BWNGC9AJye7yA2CMvVSXfFq8XgA+jK5sdQP8g34gByrMqXjwzIdr0i7diCVMdNWoh1
 A9EBs4QMaMc02RRqwzmggweWNudmDmoWZQnepd7BX0+kF5EHuhE/JLQ+3b/pv3iIl4hy
 9ey1Aeg0dpWIwWINTIYwA/7fUrQhDS/RRGTwQceSsMUTWtozY2gil1NK5ISR8VRIhMcH
 OdFg==
X-Gm-Message-State: APjAAAUq53tQiPFXEcDiFtksrDwXV6NxgPqvTVIWu3POBiHkZNIzNbe3
 zQiFgCig/VaJC8oaLVJBvWel6+HbsXxmSJi7JkLixAzeWuiCJ20Iz1D9sFF0vSteJxwfSleBG/j
 JpB12urcVxRFUVv8=
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr2373774wrj.225.1576669974192; 
 Wed, 18 Dec 2019 03:52:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyb8HTUXUBI6AN8BsxVhbBbvgrJt1780aOMkhsMeOfR+5Pcl6Cn/QOu0rKYtHLG4vsWFx6nwA==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr2373749wrj.225.1576669973934; 
 Wed, 18 Dec 2019 03:52:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ac09:bce1:1c26:264c?
 ([2001:b07:6468:f312:ac09:bce1:1c26:264c])
 by smtp.gmail.com with ESMTPSA id h2sm2415840wrt.45.2019.12.18.03.52.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 03:52:53 -0800 (PST)
Subject: Re: [PULL 00/62] Misc patches for 2019-12-16
To: quintela@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_kFsxDKY-ktQ5E4gHxpkQq0Go38DPevKxgf3pTimRxeg@mail.gmail.com>
 <20191217112236.GA2826@work-vm> <877e2u6mjr.fsf@trasno.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <63ea9d45-cf98-661a-8788-fbe0c17e9566@redhat.com>
Date: Wed, 18 Dec 2019 12:53:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <877e2u6mjr.fsf@trasno.org>
Content-Language: en-US
X-MC-Unique: _KRCfvZ4Ntih4BcYpYPjvg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/19 09:54, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>>> (and others similar)
>>>
>>> and in the migration-test:
>>> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>>> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
>>> QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
>>> /dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
>>> PASS 1 migration-test /i386/migration/deprecated
>>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:689:15:
>>> runtime error: load of value 255, which is not a valid value for type
>>> 'bool'
>>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:690:16:
>>> runtime error: null pointer passed as argument 1, which is declared to
>>> never be null
>>> /usr/include/unistd.h:828:48: note: nonnull attribute specified here
>>
>> That's a use-after-free from Juan's 'migration-test: Use a struct for
>> test_migrate_start parameters';  it's calling migrate_start_destroy and
>> then checks args->use_shmem.
> 
> Hi
> 
> New series with the fix posted upstream.
> 
> Paolo, should I did the pull requset, or will you do it?

I can do it.

> PD.  Just curious, how should I launch clang to give me that error?

"make docker-test-debug@fedora".

Paolo


