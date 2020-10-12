Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36EBE206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWKJORVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EBE206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1t2-0007dG-8s
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kS1s1-0006iI-2l
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kS1rx-0007BA-W7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602524659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6phHKRV6w+5S5/vv8kWvpb+c9p0sKinzHEcGuZMvro=;
 b=CWKJORVDf2Be4TVPkkA06LAIrgpqFxtsxJCalTBskSnSECGG2BR07iHAiSpJaE3SlLbZYW
 StZKNkobkZBwX9dJYl21YUXMQuITafCIw/7LYMCJJMhaLJH8MpdOJY0shgdMEeGrLcbX3P
 dGlkyvQvL8lD+mUe78udIyszL+Dx2tI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-c-g7QoBnOEWUMUAfCcyZSw-1; Mon, 12 Oct 2020 13:44:18 -0400
X-MC-Unique: c-g7QoBnOEWUMUAfCcyZSw-1
Received: by mail-wm1-f71.google.com with SMTP id 13so6011859wmf.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a6phHKRV6w+5S5/vv8kWvpb+c9p0sKinzHEcGuZMvro=;
 b=s5NdutWMPHia7W32wVQdqRJ8rhr9VeVtWIRknL4lS+HyhY2OY9+t6G3l7rpcLepsGp
 huqIOHEExg4Ha9Ej7VBJ+jtPVSSRIf6Bo96bENxTzMeJ9vvq9Rb11fVUU9kccpQG/z7B
 jMgeovwd9C5JVVywK3JFBUb4Im+OdllorZTAiZSq6nNLMbZihzWPZtUpeRVkxoNO816l
 uHg78FN2WcuWkNvhHmgBLSZ0H60ZMFg4BgAAasefmit4u/cW7fqVzJh2TRCeoZJzpugd
 6eziuF3L/HegKBStuoybWd4CG/QQZrYetowLq0Y7ndgVTsfDDhuagI4VoJTxbJJRNPDJ
 U26Q==
X-Gm-Message-State: AOAM533zBXCjlAnboiesBqCtpNrwtnvHUjSFDbYAymEbISK3niG2E5Id
 cig5x8fxjxSBGC0yDmMAnJxLUhm+OrkP8NwH+HPqrj3A0opa1VqggzJwRMWFasJb/9cg9taqdXk
 RsubcPeV+brp4BAA=
X-Received: by 2002:adf:f54c:: with SMTP id j12mr22082481wrp.413.1602524656819; 
 Mon, 12 Oct 2020 10:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys6yss+wb/H4n63LiHj60sJRGxnngH2HfB5BBooJF3tITQE5AQTBfuVCwgjTupMzZ+vSFuwA==
X-Received: by 2002:adf:f54c:: with SMTP id j12mr22082456wrp.413.1602524656443; 
 Mon, 12 Oct 2020 10:44:16 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id p9sm23271021wmm.4.2020.10.12.10.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2020 10:44:15 -0700 (PDT)
Subject: Re: [PATCH v4 4/5] spapr_numa: consider user input when defining
 associativity
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20201007172849.302240-1-danielhb413@gmail.com>
 <20201007172849.302240-5-danielhb413@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cf0a0fbf-5c4f-96d6-039d-780513a724e0@redhat.com>
Date: Mon, 12 Oct 2020 19:44:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007172849.302240-5-danielhb413@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 7:28 PM, Daniel Henrique Barboza wrote:
> A new function called spapr_numa_define_associativity_domains()
> is created to calculate the associativity domains and change
> the associativity arrays considering user input. This is how
> the associativity domain between two NUMA nodes A and B is
> calculated:
> 
> - get the distance D between them
> 
> - get the correspondent NUMA level 'n_level' for D. This is done
> via a helper called spapr_numa_get_numa_level()
> 
> - all associativity arrays were initialized with their own
> numa_ids, and we're calculating the distance in node_id ascending
> order, starting from node id 0 (the first node retrieved by
> numa_state). This will have a cascade effect in the algorithm because
> the associativity domains that node 0 defines will be carried over to
> other nodes, and node 1 associativities will be carried over after
> taking node 0 associativities into account, and so on. This
> happens because we'll assign assoc_src as the associativity domain
> of dst as well, for all NUMA levels beyond and including n_level.
> 
> The PPC kernel expects the associativity domains of the first node
> (node id 0) to be always 0 [1], and this algorithm will grant that
> by default.
> 
> Ultimately, all of this results in a best effort approximation for
> the actual NUMA distances the user input in the command line. Given
> the nature of how PAPR itself interprets NUMA distances versus the
> expectations risen by how ACPI SLIT works, there might be better
> algorithms but, in the end, it'll also result in another way to
> approximate what the user really wanted.
> 
> To keep this commit message no longer than it already is, the next
> patch will update the existing documentation in ppc-spapr-numa.rst
> with more in depth details and design considerations/drawbacks.
> 
> [1] https://lore.kernel.org/linuxppc-dev/5e8fbea3-8faf-0951-172a-b41a2138fbcf@gmail.com/
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>   capstone            |   2 +-
>   hw/ppc/spapr_numa.c | 110 +++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 110 insertions(+), 2 deletions(-)
> 
> diff --git a/capstone b/capstone
> index f8b1b83301..22ead3e0bf 160000
> --- a/capstone
> +++ b/capstone
> @@ -1 +1 @@
> -Subproject commit f8b1b833015a4ae47110ed068e0deb7106ced66d
> +Subproject commit 22ead3e0bfdb87516656453336160e0a37b066bf

Certainly unrelated to your patch.


