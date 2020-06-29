Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C47C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B63251E3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2ylx8DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B63251E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpvmL-0002mS-5d
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 11:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvkS-0001ET-4G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jpvkP-0002nR-W0
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 11:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593444665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdYt0x4CEugg+zGSd1bNAGxj3cHc7mxyey8WGHvbaN0=;
 b=R2ylx8DRx5SLV9UC4haOjnmwX+io5+QuBuwI1f0lksbqiAHOs8twHVjfYvLIDO3jWokCBC
 OjVIG4kBcmizXPCnNF7/qjbTMOhZCXva55RYxk6k7Fvo1+xsDi95J3gIQrrdVc2f92IXsR
 y/mAonNMG2hOuwZ26magMIxiVut4TTc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-_k3JQbNMNOSmTXeO-Xrowg-1; Mon, 29 Jun 2020 11:30:50 -0400
X-MC-Unique: _k3JQbNMNOSmTXeO-Xrowg-1
Received: by mail-wr1-f70.google.com with SMTP id 59so10074290wrp.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 08:30:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YdYt0x4CEugg+zGSd1bNAGxj3cHc7mxyey8WGHvbaN0=;
 b=poKX8Ki/dHnxKYVLffc55I0lnQshN8NeKBuSl3RicMb5a6b0fmV1Ic0WS7ozI6qQwz
 cjTGdK4JjWj/yT02irh0eVFxB1mtVr9TFqDUCrsT12hcsOlcwmtreW0Wbt9rS6GRgvOv
 gjXds68p/gGwOPBllT3Mb0+ZrQPP6fORWSuNlQboLQs5IDHlGi3jR2H0jsjw2D1Z3IhP
 HRAO6VkcjC0pOiM02actf0neEr9pHyrJFz4aWsiOPVTT0gTszidKUwnpeVzjgV3YcokS
 gabmYftmzolB1TgylHMoB7jnDzqhunW3BoGK+jTqE7gkOcRvmbT3XVEtw+GJdNd4DQ7C
 yZug==
X-Gm-Message-State: AOAM532JD7QnHYa18MHpGzV4yPhBAG+6vqsnHFtnrXUTeLAu0Nrn/Jj6
 OA433z6HQ242H/168Os1oD0FOZLHZmwjNI5+ilP7jJ/5huTugtV1kEiatNbHbRpADtjbrLD0p7E
 1EP37S+iIQnDvvM0=
X-Received: by 2002:a1c:6408:: with SMTP id y8mr16740289wmb.122.1593444649893; 
 Mon, 29 Jun 2020 08:30:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6WNLjYigtqX1ZR6SH8lkRn1wXe74H8UOoAXt4ErRlp/EZyQfUMOEPNtxAAs86ABx3YwftSA==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr16740267wmb.122.1593444649654; 
 Mon, 29 Jun 2020 08:30:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a?
 ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
 by smtp.gmail.com with ESMTPSA id a10sm104297wrm.21.2020.06.29.08.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 08:30:48 -0700 (PDT)
Subject: Re: [PATCH v4 0/3] Avoid abort on QMP attempt to add an object with
 duplicate id
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
References: <20200629112329.27611-1-eric.auger@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8bd5b010-1c58-1a38-f234-d7669cd72d35@redhat.com>
Date: Mon, 29 Jun 2020 17:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200629112329.27611-1-eric.auger@redhat.com>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/06/20 13:23, Eric Auger wrote:
> Attempting to add an object through QMP with an id that is
> already used leads to a qemu abort. This is a regression since
> d2623129a7de ("qom: Drop parameter @errp of object_property_add()
> & friends").
> 
> The first patch fixes the issue and the second patch adds a test
> to check the error is gracefully returned to the QMP client.
> 
> The last patch can be considered independently. It merges all the
> object-add tests into a single test function and cover new failure
> cases.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/qom-graceful-v4
> 
> History:
> - v3 -> v4:
>   - addressed style comment from Markus
>   - added patch 3
> 
> - v2 -> v3:
>   - don't take the object reference on failure in
>     object_property_try_add_child
>   - add g_assert_nonnull(resp) in 2/2 while keeping
>     Thomas A-b
> 
> - v1 -> v2:
>   - use the try terminology.
>   - turn object_property_try_add() into a non-static function
>   - add the test
> 
> 
> Eric Auger (3):
>   qom: Introduce object_property_try_add_child()
>   tests/qmp-cmd-test: Add qmp/object-add-duplicate-id
>   tests/qmp-cmd-test: Add qmp/object-add-failure-modes
> 
>  include/qom/object.h       | 26 +++++++++-
>  qom/object.c               | 21 ++++++--
>  qom/object_interfaces.c    |  7 ++-
>  tests/qtest/qmp-cmd-test.c | 99 ++++++++++++++++++++++++++++++++++++--
>  4 files changed, 140 insertions(+), 13 deletions(-)
> 

Very nice.  I see a failure reported by Patchew, I'll look into it as
well if you don't have time.

Paolo


