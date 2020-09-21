Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25A1C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F6920719
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKoxXUlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F6920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKIAV-0005ag-34
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKI9P-0004iK-4R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKI9N-0001UB-BT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 05:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600680620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hP+MFuBtCPxwfWpKXsRrfFaRccO7bpM9xsNiAcJFImY=;
 b=DKoxXUlMPuRyE1krkdYZvsaEeslGnoE59n/u6ADfaJUmC7R3bhxjv+NtQiQqosjeIZHKRI
 TD7hqk6dIqeUSQRBR9+GO3DBA8GkFzmsoULkt2s5XgMw0qwNvky/bW65eCpYLlh7IXsYRu
 dgImK8tNYDEXUtoz6eVnixUHyuApt98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-pJuCu0HXNqGnmVzWo8HcAg-1; Mon, 21 Sep 2020 05:30:18 -0400
X-MC-Unique: pJuCu0HXNqGnmVzWo8HcAg-1
Received: by mail-wr1-f72.google.com with SMTP id j7so5638310wro.14
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 02:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hP+MFuBtCPxwfWpKXsRrfFaRccO7bpM9xsNiAcJFImY=;
 b=Uzb5GWnf5bNIfXfXLhqTgxnH508nBkOnhlvDjQd1cgn0Q9XqNQ/YVAOFFPin/S8HAA
 JINpwsToVaiUmhMUTlLbzpjuXirfkzImlVBLAcV9CMA6STiX+qB8ldpqHeeoFWw31GJg
 zD6MRRnr/9Fgk/ml9klzoObpworKfNu+KM7hbKa0poIz7lqcCf+Pu4P2rUBezXHAFHem
 4303yE5VLJ/PkCeUHUQlMyDJCohzy7pq3iF8tWySUWijXre8mnPNsIT4xPeZbjc5Zqsb
 ftOFzS40xRks7jWjaphfYQVchAWso9sceYHgY/7gfvXAtdwkUTIAB/COtTVmzMVqdIHH
 G5qQ==
X-Gm-Message-State: AOAM530kmPuueaeDSMd9tX119vc8DQetYuyd3wLiWi3TQSW0Swqz+RMD
 Y0FgyvzYdhwEhKmJ8eJklXW04u8cJ774+Hep7+UTn717ULs7dHX54j2ZMKggJ/75S1D02PAKPnW
 lr4JEnrE9vqNkcl4=
X-Received: by 2002:adf:e802:: with SMTP id o2mr50777214wrm.309.1600680617289; 
 Mon, 21 Sep 2020 02:30:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIKhrFoiAbpjrf/uyvvEnLCpRPjiW7zjhZ1VrrsKH4VAreWkRJmtTN0k0SbO1OLVDwmrpEtQ==
X-Received: by 2002:adf:e802:: with SMTP id o2mr50777196wrm.309.1600680617085; 
 Mon, 21 Sep 2020 02:30:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.gmail.com with ESMTPSA id y68sm11178151wmd.39.2020.09.21.02.30.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 02:30:16 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33bf618f-9c0d-b34f-cc55-35f4c35e8296@redhat.com>
Date: Mon, 21 Sep 2020 11:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87mu1j8p7p.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: jsnow@redhat.com, stefanha@gmail.com, berrange@redhat.com,
 qemu-devel@nongnu.org, slp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 11:16, Markus Armbruster wrote:
> QMP is an *external* interface.
> 
> It supports compatible evolution: we can make certain kinds of changes
> without affecting clients.  These include:
> 
> * Adding optional arguments
> 
> * Adding results
> 
> * Adding values to an enumeration type, branches to a union or
>   alternate
> 
> * Reordering members of enumerations, structs, unions
> 
> * Turning an argument type into an alternate with the old type as branch
> 
> We've made use of this extensively.  See also
> docs/devel/qapi-code-gen.txt section "Compatibility considerations."
> 
> How do such changes affect clients of the proposed D-Bus interface?

All this makes me think that Q{MP,OM,API} badly needs rationale
documentation.

Paolo


