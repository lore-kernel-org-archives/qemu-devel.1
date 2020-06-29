Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EFAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811C420786
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 13:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvvKnttl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811C420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptxW-0006vq-Ps
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 09:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptwX-0006BG-Ob
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:35:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jptwW-0007sH-38
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 09:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593437727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2p77IRgMyjG+xJh291wTma35yjZdeeO/sI1NvEI2Xg=;
 b=JvvKnttlfzQ8HpydO5vHYf22iaAldiZ+Ai1xfj6lkeOx1/49dlIrz1uecDUP/wlod6G3EB
 uq4mF7jw1FsMj/3YEXV6DqgohiFI+nsheUL1PYQVGkuRZC2PA0KgPQOQmESXIHmp0Px+qz
 hTU6wie5ogVdGCZ6oK8RqRWttnkhGkg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-YzTG7zB7OhSiY4_FZodllA-1; Mon, 29 Jun 2020 09:35:19 -0400
X-MC-Unique: YzTG7zB7OhSiY4_FZodllA-1
Received: by mail-wr1-f72.google.com with SMTP id c18so9084451wrp.15
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 06:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l2p77IRgMyjG+xJh291wTma35yjZdeeO/sI1NvEI2Xg=;
 b=rIL8bM7L3GgIvnobP6U1BJur+22XmOf9iLNZycf/eYGLPGtYDBuDhJjLAR1md3uIpa
 uRa2BVljgxNI8yRJyzEMrIE/lRTed+OhxQnvxD9gzmIxSOIN6eoZs+7U1VAahqc91hVt
 vpCq9ePQiM1jqq3LjtwORPNWrdA8Yx9/uRqyMrCDoVF7IFLezNdM9FADzdjAwERpUZG/
 bTo1tISgrIBR7i1timlN4uWIyq4YyIRpQmUpQvzwctwVbK/myLtfTvPMnnSPp2Pb2FxT
 rBDC/x18PjJERXaYEGIunRUx0wt50IUUrJ84GixROIEwuGJI9IfUOz4BrC+MzDEW8hJX
 4iOQ==
X-Gm-Message-State: AOAM531njL5iJNsAaRXvrT0L49bgoY3/7n5mzTYmZIMEGg2OrmKCu/B2
 3DheIpYvZ8xIcM9EN+oaJ5XprHNugqpNzaFMpxQK9KllkKAEfWnIzkMWq9XvdhLyrGz4KnlTwrz
 OGRkDE577VAFkCiM=
X-Received: by 2002:adf:9307:: with SMTP id 7mr16693987wro.414.1593437718004; 
 Mon, 29 Jun 2020 06:35:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOGxMdIbFQTcYSaDHxugJpnYYLcH8PMaqmmWFzlmO64u5UVc/x8S4VlSpjqyVKC6CNZXPmfw==
X-Received: by 2002:adf:9307:: with SMTP id 7mr16693962wro.414.1593437717796; 
 Mon, 29 Jun 2020 06:35:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id l14sm33078935wrn.18.2020.06.29.06.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 06:35:17 -0700 (PDT)
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
 <20200625155712.GI25104@SPB-NB-133.local>
 <6508d40b-0142-1b42-2f48-fcd2da66ea4b@redhat.com>
 <20200629113107.GL25104@SPB-NB-133.local>
 <d1d7cf19-d56c-c095-a3b8-45e2be0752ea@redhat.com>
 <20200629132911.GN25104@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c8d14fa-e2cf-00e7-135f-d88fda38f31d@redhat.com>
Date: Mon, 29 Jun 2020 15:35:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629132911.GN25104@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:03:51
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
Cc: Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 15:29, Roman Bolshakov wrote:
>>> macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
>>> declaration for hv_vcpu_run_until(), that's not available 10.15 -
>>> HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
>>> VMX-preeemption counter). Perhaps the performance issue is addressed
>>> there.
>> Possibly.  I'm worried that the preemption-timer trick will fail to run
>> there, but we'll see.
>>
> Well, I've got new VM-exits (caused by zero preemption timer) on either
> of my laptops.

If you have already tried 11.0 that's great.  I was worried that it
would forcibly clear the preemption timer bit when passed
HV_DEADLINE_FOREVER.

Paolo


