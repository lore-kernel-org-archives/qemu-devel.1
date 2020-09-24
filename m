Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103D8C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C1322311B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyNSWKmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1322311B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPfs-0006mo-FU
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLPes-000693-OM
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLPeq-0007Am-EI
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600947805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nf1XGnTH8zd9xlXrFc5YcTifah6qYeAhP6WT3Q2vYDY=;
 b=gyNSWKmfcLKWDyltI3HH9NdGiIiSH1lU6gWMBsgyVCRUgpEVtPXFZ6tpG+2Bqyp6hDIc0n
 GCZB3ZXKYPrBwgbmUI4bmD+FNEeWmNgJKlyfKwqGFoXmiNDqnZKZlKEAKsBd+HkUuO0lNO
 avwz6PfQZot9ISiHgTD88MwYFFN9rQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-_yxj5hGiPo6rHudZjz_NVQ-1; Thu, 24 Sep 2020 07:43:21 -0400
X-MC-Unique: _yxj5hGiPo6rHudZjz_NVQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A84611074646;
 Thu, 24 Sep 2020 11:43:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-113.ams2.redhat.com [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E746E5C1C7;
 Thu, 24 Sep 2020 11:43:15 +0000 (UTC)
Subject: Re: [PATCH 1/3] pc-bios/s390-ccw: fix off-by-one error
To: Marc Hartmayer <mhartmay@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200924085926.21709-1-mhartmay@linux.ibm.com>
 <20200924085926.21709-2-mhartmay@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3f99b32c-3cc4-a82a-48dd-d08618edc443@redhat.com>
Date: Thu, 24 Sep 2020 13:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200924085926.21709-2-mhartmay@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, Janosch Frank <frankja@linux.ibm.com>,
 "Collin L. Walling" <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/09/2020 10.59, Marc Hartmayer wrote:
> This error takes effect when the magic value "zIPL" is located at the
> end of a block. For example if s2_cur_blk = 0x7fe18000 and the magic
> value "zIPL" is located at 0x7fe18ffc - 0x7fe18fff.
> 
> Fixes: ba831b25262a ("s390-ccw: read stage2 boot loader data to find menu")
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 97205674e59a..0d29dceaa3cc 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -163,7 +163,7 @@ static bool find_zipl_boot_menu_banner(int *offset)
>      int i;
>  
>      /* Menu banner starts with "zIPL" */
> -    for (i = 0; i < virtio_get_block_size() - 4; i++) {
> +    for (i = 0; i < virtio_get_block_size() - 3; i++) {
>          if (magic_match(s2_cur_blk + i, ZIPL_MAGIC_EBCDIC)) {
>              *offset = i;
>              return true;

I agree with Philippe, i <= virtio_get_block_size() - 4 would be a
little bit nicer. Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


