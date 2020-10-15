Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2902AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C60C21D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 16:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aW0I0jeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C60C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT5wE-0007eY-AI
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 12:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT5uk-0006px-Lu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kT5uh-00053F-Ob
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 12:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602778535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ChIloslXbwzx5SwJ9bus+C0aUz+/NJpBANblR8W7fg=;
 b=aW0I0jeKQS6HM0MHRPK32NGkkVolRKOBw2+xCti8LRBM/3aLocGTlkQymHO08Cyal0tG/B
 m3m/r+SyoPdODVYRoPiVxQx+bIOBb8XuvyAZuGxq2mR9GdNu4LBYK1ckSjW32J8ZEdpfFg
 nzpExf3/nM+xIKkya65fxI5+8WUpaSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-t4SPsqyeOeigr2XXlRbw_Q-1; Thu, 15 Oct 2020 12:15:31 -0400
X-MC-Unique: t4SPsqyeOeigr2XXlRbw_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1941412C6C1;
 Thu, 15 Oct 2020 16:15:30 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1533E100238E;
 Thu, 15 Oct 2020 16:15:18 +0000 (UTC)
Subject: Re: [RFC 0/5] NVMe passthrough: Support 64kB page host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 stefanha@redhat.com, fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <0a1ae4dd-064b-49c5-0669-04219646f616@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d3ba4c98-67b8-0d38-378a-805fb02b3d40@redhat.com>
Date: Thu, 15 Oct 2020 18:15:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0a1ae4dd-064b-49c5-0669-04219646f616@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On 10/15/20 3:49 PM, Philippe Mathieu-Daudé wrote:
> On 10/15/20 1:52 PM, Eric Auger wrote:
>> This series allows NVMe passthrough on aarch64 with 64kB page host.
>> Addresses and sizes of buffers which are VFIO DMA mapped are
>> aligned with the host page size.
>>
>> nvme_register_buf() path is taken care of in this series
>> but it does not seem to prevent the use case from working.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/qemu/tree/nvme_64k_rfc
>>
>> This was tested on ARM only.
>>
>> Eric Auger (5):
>>    block/nvme: use some NVME_CAP_* macros
>>    block/nvme: Change size and alignment of IDENTIFY response buffer
>>    block/nvme: Change size and alignment of queue
>>    block/nvme: Change size and alignment of prp_list_pages
>>    block/nvme: Align iov's va and size on host page size
> 
> Since it is easier for me to rebase on top of your series,
> I'm including it in my work (fixing the checkpatch errors)
> and will repost block/nvme/ patches altogether.

There should be one warning (line exceeding 80 chars) but no error. I
can easily rebase/respin if you prefer.

Thanks

Eric
> 
> Regards,
> 
> Phil.
> 
> 


