Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41263C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A342225F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxlnAdJM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A342225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbDs-0003DU-Gu
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVbCg-0002l2-Fj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVbCe-0000J5-Ps
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603375468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O8UGWeO2LtUTpNcx9wGmbK5YKM4S1gAsbghWAjTL4uA=;
 b=WxlnAdJM717LWjdaYjd6yhICYtWE2PGOVmXCnPMBLDRowBO/EWrSkAe8yltDPCRArfRRE5
 GyKXY9fwiU5O5Bw4SUyPhlQafShE3rIRriCJwOwRlluEfobrjKzklVebfpIZF9pSVbXwKy
 uMhQjCAnmXUb5TjRWniQHxJFQUJ81wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-9alfA3ctOUG6FoRBnnc2PQ-1; Thu, 22 Oct 2020 10:04:25 -0400
X-MC-Unique: 9alfA3ctOUG6FoRBnnc2PQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A3C835B4A
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 14:04:24 +0000 (UTC)
Received: from [10.10.119.13] (ovpn-119-13.rdu2.redhat.com [10.10.119.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C720A60C04;
 Thu, 22 Oct 2020 14:04:20 +0000 (UTC)
Subject: Re: [PATCH] os: deprecate the -enable-fips option and QEMU's FIPS
 enforcement
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20201020162211.401204-1-berrange@redhat.com>
 <f97dc04a-0cc4-3ba0-ea5e-b185cd0958a7@redhat.com>
 <20201021083803.GC412988@redhat.com>
 <aae2164f-0973-f7b3-3146-1ea659c00922@redhat.com>
 <20201021101743.GI412988@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d9d4e758-c660-9860-9fac-ecc43e52b80f@redhat.com>
Date: Thu, 22 Oct 2020 10:04:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201021101743.GI412988@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: libvir-list@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:17 AM, Daniel P. Berrangé wrote:
> Claiming QEMU is FIPS compliant without using libgcrypt is a
> bit of joke since we don't do any self-tests of ciphers, hence
> this deprecation notice is warning people that libgcrypt is
> going to be mandatory if you care about FIPS.
> 

FWIW this is my main problem with this flag: we read the value in procfs 
and then use this to change precisely one behavior for one of our 
components. It doesn't really ... do what the name might imply it does.

Leaving that business to the crypto libraries is indeed the correct 
thing to do.

So:

Reviewed-by: John Snow <jsnow@redhat.com>


