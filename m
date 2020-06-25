Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A81C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820D120781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5jJ47JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820D120781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWcM-0002LW-Qg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joWay-0001Ma-Lu
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:27:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1joWaw-00025G-2n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593109648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tL7+apqhJ2cOboS/oviFvuZQbKPBT6XAoUaUC66TuLY=;
 b=T5jJ47JNLxRbGRaWufIeYfvP6GxoPKSDQJNuRogLyhnc5dggfu3bpzMX3rQQzvDGH6L4o2
 MmoMUZxnHyxlDjQm/VxGNcxfEhHpciADuFKQZDw4KyU7Jq3Eh1tNSW5tda1BtcwEiuIv3s
 xtBthzTDgJuQ1ka1fM3taJVIpi+V+jg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-EGu7K4UXOgaWr6g2InhPGQ-1; Thu, 25 Jun 2020 14:26:15 -0400
X-MC-Unique: EGu7K4UXOgaWr6g2InhPGQ-1
Received: by mail-wr1-f70.google.com with SMTP id i12so7582565wrx.11
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tL7+apqhJ2cOboS/oviFvuZQbKPBT6XAoUaUC66TuLY=;
 b=Oxfb0YamLBvJud5Djuf88oEYhgn5hA13ZEimvIrdIFNxwmZHEDK3T1BO6sAnxs9dPY
 UfXn/4Pq77gvEvQGcx3a40xqf6T9a2Ufrp9JPxNe5JEAhXp677r4NoV8eZqlTOZ/1kdF
 DNndowUXeDgnYBVldap2POUMhGeqJEz7uKBp9iiFo3lopnmbXXJdyQVP5QFxqSj85sGe
 qtbObWcOkWmgtkJzObqbUvTE92TdyUMVfYh6iOqCq/gi/j+/kpWgbTra6kScpyf1v1rS
 EvGAuWrQJJBKTjrhPz4LwLu3qFZqs0ZkabHeDCIaoIUpWj6RjbJ74lTZM4hhJncGCLgv
 DCgQ==
X-Gm-Message-State: AOAM533uG+fQkXVnKN4mriPcsagyxPG7iSk7jq7Yfk/bPqwuV8R59v9v
 RVqyqotOEs8rEziYsknPFWSSQya/kG/camMfpuJEx811yuJbMCh+amU2pGEiIMRGhcH+FjeYvWh
 MzoDU7CkZlyEYyW0=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr37489859wrv.162.1593109574438; 
 Thu, 25 Jun 2020 11:26:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3Asjyv3ZJw7yBIuXJUhun8CSRqE4xcXUbg7vD8yDTE1sIzxSupkILxpyZHrdWBabarEeYaA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr37489835wrv.162.1593109574215; 
 Thu, 25 Jun 2020 11:26:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80?
 ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
 by smtp.gmail.com with ESMTPSA id w17sm33554532wra.42.2020.06.25.11.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:26:13 -0700 (PDT)
Subject: Re: [PATCH 6/8] i386: hvf: Drop hvf_reset_vcpu()
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-7-r.bolshakov@yadro.com>
 <ac800efc-c51d-e44c-de5c-cdef81d24dec@redhat.com>
 <20200625123637.GG25104@SPB-NB-133.local>
 <34821aae-e8f5-adc6-eab5-0a6f6b2835e8@redhat.com>
 <20200625150223.GH25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0dd117e5-8b05-068e-bba6-e1888de246f8@redhat.com>
Date: Thu, 25 Jun 2020 20:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200625150223.GH25104@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 01:47:53
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
Cc: qemu-devel@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/20 17:02, Roman Bolshakov wrote:
> macvm_set_cr0() sets/clears LMA in entry controls only in case of
> transitions into/out of long mode in enter_long_mode() in
> exit_long_mode(), respectively. But macvm_set_cr0() doesn't load
> EFER.LMA from CPUX86State into VMCS entry controls during reset and
> that's where hvf_put_registers() might not behave properly.
> 
> As far as I understand you propose to drop explicit LMA reset in
> post-reset and rather impove synchronization between efer and entry
> controls in macvm_set_cr0(), right? In that case I don't see a
> regression in the series, and if possible I'd prefer a follow up patch
> for the issue.

Indeed it's not a regression.  Thanks!

Paolo


