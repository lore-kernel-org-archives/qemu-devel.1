Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CBEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F4229207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LY9IxHAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4229207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKd9-0005lV-Nf
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKc7-0005LD-9U
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:57:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTKc5-0007Jq-4E
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602835039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rre0h/oZdatXqGv0LE+vNBLoLrj5ufB710dQmpjd30E=;
 b=LY9IxHAdbuCIRTNhGhgdR7KV0lTQAbj+aXjrEw6XSgj/OGCJThk6U271g7xIuD9z/FuevF
 R3zLmhRbKbn2YJOIpGm+wEr7mmy66PkpW0cjqNxni70vO5kgK5o7T8pQkyM9wwFqVuTqs0
 SG9Zvnx1x8bG4u7aMgPBANUbhjZGe0Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-POJQ2xs9Nb--oux3t5CJ4Q-1; Fri, 16 Oct 2020 03:57:17 -0400
X-MC-Unique: POJQ2xs9Nb--oux3t5CJ4Q-1
Received: by mail-wr1-f69.google.com with SMTP id x16so943828wrg.7
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 00:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Rre0h/oZdatXqGv0LE+vNBLoLrj5ufB710dQmpjd30E=;
 b=AQu40dOEJL9fgeIdMN2yQDyBxprgNyGbJiqkTyFvI5yjNZWOYzCSetsG3UOWpRHDrC
 Hb+ieMllQOnJQ8LHrUS/UwYXJbpcZqoJBMfjZQJMlo7gSCE3EpVF+x0PGe4AAQ2L4i2m
 6JeHyADs/GB9nlmIy1heW1SZT6M5K6bev4eft0yIqkDy0iVgYb4hF9HXPg5zMQKBMS2C
 OUr13AHro7FqW/20MRv/hYNXUI6xaoQ8xK4uYc7fPF7GBKiaU3vJ9aRJtI0FRopMdmfR
 jYg+CCIQ2f1ZTfg6TafTlY+ooVqrVLW49tGstShDzPT7TuDvMfXNeraUGuJTXVJ3Kgv6
 pKog==
X-Gm-Message-State: AOAM530ooVnpbji6Q5zeuyuEwhJVf88KkXZ6JLCd+gIci67TiTbfpuS4
 /B+ITaKnm40UES53R+WL+vkzDofhRKN46eQMjbMTgbX0Y0Q8KniqTTTflBvw5M+oBSicZlkeGYq
 1TMZXOtDxfj+s3LM=
X-Received: by 2002:a1c:e045:: with SMTP id x66mr2471356wmg.104.1602835035972; 
 Fri, 16 Oct 2020 00:57:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCGgBwgWHNp6wg5aToY5nlne4nc+T/JbJ5/Wi8zwSHBEihtRoyG0gFYjSjKXE3obvXhmHCgQ==
X-Received: by 2002:a1c:e045:: with SMTP id x66mr2471339wmg.104.1602835035723; 
 Fri, 16 Oct 2020 00:57:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3?
 ([2001:b07:6468:f312:4e8a:ee8e:6ed5:4bc3])
 by smtp.gmail.com with ESMTPSA id u63sm1830294wmb.13.2020.10.16.00.57.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 00:57:15 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] meson: Move the detection logic for sphinx to meson
To: luoyonggang@gmail.com
References: <20201015220626.418-1-luoyonggang@gmail.com>
 <20201015220626.418-4-luoyonggang@gmail.com>
 <9bd01bce-7409-26f9-5401-8f5ddd4f924c@redhat.com>
 <CAE2XoE9EvboWrqMp_SD0BJ+=D3JjXUeL22qaZD=G5R+M0c4Npg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d0c598d-84c4-b760-790b-f2041bf3066e@redhat.com>
Date: Fri, 16 Oct 2020 09:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9EvboWrqMp_SD0BJ+=D3JjXUeL22qaZD=G5R+M0c4Npg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/10/20 09:52, 罗勇刚(Yonggang Luo) wrote:
> 
>> build_docs = false
>> if sphinx_build.found()
>>   # This is a bit awkward but works: create a trivial document and
>>   # try to run it with our configuration file (which enforces a
>>   # version requirement). This will fail if sphinx-build is too old.
>>   run_command('mkdir', ['-p', tmpdir / 'sphinx'])
>>   run_command('touch', [tmpdir / 'sphinx/index.rst'])
>>   sphinx_build_test_out = run_command(SPHINX_ARGS + [
>>     '-c', meson.current_source_dir() / 'docs',
>>     '-b', 'html', tmpdir / 'sphinx',
>>     tmpdir / 'sphinx/out'])
>>   build_docs = (sphinx_build_test_out.returncode() == 0)
>> endif
> There is subtle error here, when  sphinx_build not found, there is
> SPHINX_ARGS  should be [],
> otherwise, latter place using  SPHINX_ARGS  have not found sphinx_build
> will cause error by meson
> ..
> I'll add
> 
> else
>   SPHINX_ARGS  = []  
> endif

All uses of SPHINX_ARGS are protected by build_docs, and in turn
build_docs is false if "not sphinx_build.found()".  Am I missing something?

Paolo


