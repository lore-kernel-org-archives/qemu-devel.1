Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D9AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC0B206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 08:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AoA4tFEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC0B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jffXh-0004OB-2Y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 04:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jffX5-0003zZ-2m
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 04:10:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34958
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jffX4-0007JJ-C9
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 04:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590999053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNimXhrWBVsr45hOZn+0cmV+dNcDMRZY/OcC54ieiKQ=;
 b=AoA4tFEViRGl3fFhVUKtapbzrGoW5FXmcoVjXB9hBod5Ey/DqBUCekC+4sa3fi6YqAF1VC
 6WycaNrhA/xOEh40OudLX2CELwrk8CcPgfCeVs6B43dDDYbgGzYDSS8ev5bMngaO7DZhdy
 +4Tpdk6jfGzv/dfAZnf2MuclooL8a7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-lzi8-hpYNMSbU0VIkgck2A-1; Mon, 01 Jun 2020 04:10:51 -0400
X-MC-Unique: lzi8-hpYNMSbU0VIkgck2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 884E3801503;
 Mon,  1 Jun 2020 08:10:48 +0000 (UTC)
Received: from [10.40.194.230] (unknown [10.40.194.230])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 669E670879;
 Mon,  1 Jun 2020 08:10:47 +0000 (UTC)
Subject: Re: [PATCH 3/3] numa: Initialize node initiator with respect to
 .has_cpu
To: Igor Mammedov <imammedo@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <d3039c47e4ce1118bc7c4d4f51da6412c6669339.1590753455.git.mprivozn@redhat.com>
 <20200529170948.5bdb3316@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <d6c8e7c5-62c5-5ac5-0941-d28867761014@redhat.com>
Date: Mon, 1 Jun 2020 10:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529170948.5bdb3316@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 02:19:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 5:09 PM, Igor Mammedov wrote:
> On Fri, 29 May 2020 15:33:48 +0200
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>> The initiator attribute of a NUMA node is documented as the 'NUMA
>> node that has best performance to given NUMA node'. If a NUMA
>> node has at least one CPU there can hardly be a different node
>> with better performace and thus all NUMA nodes which have a CPU
>> are initiators to themselves. Reflect this fact when initializing
>> the attribute.
> 
> It is not true in case of the node is memory-less

Are you saying that if there's a memory-less NUMA node, then it needs to 
have initiator set too? Asking mostly out of curiosity because we don't 
allow memory-less NUMA nodes in Libvirt just yet. Nor cpu-less, but my 
patches that I'm referring to in cover letter will allow at least 
cpu-less nodes. Should I allow both?

Also, can you shed more light into why machine_set_cpu_numa_node() did 
not override the .initiator?

Thanks,
Michal


