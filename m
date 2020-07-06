Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F2D206B6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK9bcQ3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F2D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXYz-0003j9-Pz
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXYG-0002z9-5g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:17:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXYD-0006iZ-Jm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594066636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5vjGw+8dh0ayyuHUtzrMLIbPfuT5o830J5TqavxFnQ=;
 b=YK9bcQ3wVuWXkvUSk4kCibcOwMwkxPe9Rr43Evz3XMvKY/oh56iD6FZmHWdacOsvAXnuzf
 C1/SBlWRl3f2HX15XYqSGjBGa9L/80TK6w8bCZlz6G9zxxQTWMbzln2dOEtE5xSIygTn5A
 vzNByv6BTyFZB1Hm0UWrAjPeCWyAA5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-a-HAY4xxOzeDMtPfHM2KaQ-1; Mon, 06 Jul 2020 16:17:10 -0400
X-MC-Unique: a-HAY4xxOzeDMtPfHM2KaQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE76107ACF3;
 Mon,  6 Jul 2020 20:17:09 +0000 (UTC)
Received: from [10.3.113.97] (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D8260BEC;
 Mon,  6 Jul 2020 20:17:05 +0000 (UTC)
Subject: Re: [PATCH 02/13] qcow2: introduce icount field for snapshots
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <159316678008.10508.6615172353109944370.stgit@pasha-ThinkPad-X280>
 <159316679154.10508.16814264064541947914.stgit@pasha-ThinkPad-X280>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6882cb05-8533-d6ac-d41b-95c3d19ca496@redhat.com>
Date: Mon, 6 Jul 2020 15:17:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159316679154.10508.16814264064541947914.stgit@pasha-ThinkPad-X280>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 15:29:35
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
Cc: kwolf@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 mtosatti@redhat.com, stefanha@redhat.com, armbru@redhat.com, mreitz@redhat.com,
 wrampazz@redhat.com, crosa@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, zhiwei_liu@c-sky.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 5:19 AM, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> This patch introduces the icount field for saving within the snapshot.
> It is required for navigation between the snapshots in record/replay mode.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Acked-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   0 files changed
> 

That's an odd diffstat; you may want to investigate why git isn't 
showing the usual diffstat that makes it easier to see which files are 
touched and the relative size of the changes.


> +++ b/docs/interop/qcow2.txt
> @@ -645,6 +645,11 @@ Snapshot table entry:
>   
>                       Byte 48 - 55:   Virtual disk size of the snapshot in bytes
>   
> +                    Byte 56 - 63:   icount value which corresponds to
> +                                    the record/replay instruction count
> +                                    when the snapshot was taken. Set to -1
> +                                    if icount was disabled
> +
>                       Version 3 images must include extra data at least up to
>                       byte 55.

Should we have additional text here, similar to what was added to the 
overall header in 3ae3fcfa, about how to properly add additional 
optional fields while maintaining back-compat considerations?  Maybe 
just a one sentence reference that the rules in that section apply here too?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


