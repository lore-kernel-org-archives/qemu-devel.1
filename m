Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70E8C433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 18:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EEA208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 18:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqFmYkCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EEA208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdenI-0003cZ-LL
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 14:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdemA-0002ic-L9
 for qemu-devel@nongnu.org; Tue, 26 May 2020 14:58:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27352
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdem8-0003cm-WD
 for qemu-devel@nongnu.org; Tue, 26 May 2020 14:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590519487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xVsbWrtWkiGToreY+Bipp5bWxxLMWyyidr97Kg/vTo=;
 b=JqFmYkCLBsenMJWIBYNk60DCbP8g7cBK2vEneZB4ngE5AcwpnwhvYS0G9FUr5FkKOA+NBY
 I3ThAtSvqilRVyiepCd7amSe/xDnud+oVNcW5sltOg06Ev1peIuEiNMfUM1Xdda+LGbTY9
 XiXGfQVQXBiIXvDuVEUfUn78aXnDUh8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-k1z8H8uYNseiv6RZ4mCU0Q-1; Tue, 26 May 2020 14:58:03 -0400
X-MC-Unique: k1z8H8uYNseiv6RZ4mCU0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA742800688;
 Tue, 26 May 2020 18:58:01 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 109B619D7B;
 Tue, 26 May 2020 18:58:00 +0000 (UTC)
Subject: Re: [PATCH] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1590504866-679474-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <77e7c8ab-d412-a5ca-0b8a-b07e4862d143@redhat.com>
Date: Tue, 26 May 2020 13:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590504866-679474-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 10:22:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/26/20 9:54 AM, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script.
> The sample output:
> 
> Header extension (Bitmaps):

This change to the output is independently useful.  However, per 
patchew, it does cause 'make check' to fail:

https://patchew.org/logs/1590504866-679474-1-git-send-email-andrey.shinkevich@virtuozzo.com/testing.docker-quick@centos7/?type=message

...
--- /tmp/qemu-test/src/tests/qemu-iotests/031.out	2020-05-26 
14:44:51.000000000 +0000
+++ /tmp/qemu-test/build/tests/qemu-iotests/031.out.bad	2020-05-26 
18:07:11.753556518 +0000
@@ -24,7 +24,7 @@
  refcount_order            4
  header_length             72

-Header extension:
+Header extension (Unknown):
...
Failures: 031 036 061

I think it would be wise to split this into two patches, one that makes 
_just_ the following change:


> @@ -143,30 +267,39 @@ class QcowHeader:
>               print("%-25s" % f[2], value_str)
>           print("")
>   
> -    def dump_extensions(self):
> +    def dump_extensions(self, fd):
>           for ex in self.extensions:
>   
> +            print("Header extension (%s):" % self.extension_name(ex.magic))
> +            print("%-25s %#x" % ("magic", ex.magic))
> +            print("%-25s %d" % ("length", ex.length))

and whatever is needed to support that, plus the changes necessary to 
the iotests output to keep them passing (hopefully, the 3 tests 
identified by 'make check' covers all of the existing tests already 
using qcow2.py), then the second patch adding the rest of this that then 
gives details about the bitmap contents.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


