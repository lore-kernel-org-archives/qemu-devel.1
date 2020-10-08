Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D7AC4742F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189F821924
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsPaWzCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189F821924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQXtf-0008I1-Rd
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQXrN-00073T-9V
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:29:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kQXrL-0007eU-P4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602170974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sMr+lxCYpXHnlrpMAaB2SmwIpbJiBKVuDUcTCOKceYI=;
 b=UsPaWzCmPSiJ/Gm0+PlZIyO9iFdwYxF4S/tvwtk/lm/3x/iGKvVBy4sOWuc3MbifDScAGS
 8NgKq0BYnmYET6/75Rg17c6zEoM14xBFsDjRjzt6tpIym0b71phNMR4J3YUrq7ek8Ol581
 Zx/vIEaON2wdXFE8sDTqRK+dabEE5zE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-bB4QDBBmMp2v-5JuFAt0nA-1; Thu, 08 Oct 2020 11:29:32 -0400
X-MC-Unique: bB4QDBBmMp2v-5JuFAt0nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A144118C5201;
 Thu,  8 Oct 2020 15:29:31 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF68510013C1;
 Thu,  8 Oct 2020 15:29:30 +0000 (UTC)
Subject: Re: [PATCH 08/20] python/machine.py: fix _popen access
To: Kevin Wolf <kwolf@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
 <20201006235817.3280413-9-jsnow@redhat.com>
 <20201007100705.GD7212@linux.fritz.box>
 <1c562773-6216-7cbe-eddf-fa18cdcc84f3@redhat.com>
 <20201008070447.GA4672@linux.fritz.box>
From: John Snow <jsnow@redhat.com>
Message-ID: <19f33d54-fd68-458e-cef5-69116da428c5@redhat.com>
Date: Thu, 8 Oct 2020 11:29:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008070447.GA4672@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 3:04 AM, Kevin Wolf wrote:
> The major downside that I saw while reviewing this patch (besides having
> extra code just for making the error message of what essentially a
> failed assertion nicer) is that we have two names for the same thing, we
> have both names in active use in the other methods, and I'll never be
> able to remember which of _subp and _popen is the real attribute and
> which is the property (or that they are related at all and changing one
> will actually change the other, too) without looking it up.
> 
> I mean, I guess tools will tell me after getting it wrong, but still...
> 
> Properties can make a nice external interface, but I feel using them
> internally while you don't avoid accessing the real attribute in methods
> other than the property implementation is more confusing than helpful.

Good point. I'll see if I can find a nicer cleanup soon. For now I will 
suggest relying on the type checker to spot if we get it wrong.

I do think the little property wrappers are kind of distracting, but 
seemed like the quickest means to an end at the time. With type checking 
fully in place, refactors can be a little more fearless going forward, I 
think.

--js


