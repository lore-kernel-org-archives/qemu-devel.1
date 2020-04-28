Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906D3C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE7E20575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuvhHQ7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE7E20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTV2w-0004Pc-FG
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUzm-0002td-0Q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jTUxJ-0000rS-Jw
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:30:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jTUxJ-0000ml-4y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588098460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b1+Y/QW/NS6987IacXTQCVgzuLRHOl42TFav+KL10E4=;
 b=PuvhHQ7qKN4pVfFCrEoLpaKX4203n2E4ZFWpkO7g1eqKuG9rFNoaOXMp10SKMCpxkuc9xs
 If2ygUlzsBPppAsepmDiO90SLvmojWy0JubW069mWDFuwT8saNlmYcg8cDgFIFhhmNxFJn
 7sQB6bNCr8A/e8A/Zo8pwV17kMBFAhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-mgctR-CCMZSTsGqft0wSCw-1; Tue, 28 Apr 2020 14:27:38 -0400
X-MC-Unique: mgctR-CCMZSTsGqft0wSCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 977E7107ACCA
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 18:27:37 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA3CF60C84;
 Tue, 28 Apr 2020 18:27:36 +0000 (UTC)
Subject: Re: [PATCH 07/17] tests/check-qom-proplist: Improve iterator coverage
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <eb72bb7e-1181-ece8-1fc7-991e74361f7c@redhat.com>
Date: Tue, 28 Apr 2020 13:27:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-8-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 11:34 AM, Markus Armbruster wrote:
> The tests' "qemu-dummy" device has only class properties.  Turn one of
> them into an instance property.  test_dummy_class_iterator() expects
> one fewer property than test_dummy_iterator().  Rewrite
> test_dummy_prop_iterator() to take expected properties as argument.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qom-proplist.c | 51 +++++++++++++++++++-------------------
>   1 file changed, 26 insertions(+), 25 deletions(-)
> 

Nice way to enhance coverage.  (I wish we could get rid of instance 
properties, but as long as we still have them, testing them is good).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


