Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C79C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6734B20814
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0Cj77v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6734B20814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeNQF-0002hv-L8
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 14:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNPM-0001Yz-UF
 for qemu-devel@nongnu.org; Thu, 28 May 2020 14:37:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28025
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jeNPM-0004t5-A7
 for qemu-devel@nongnu.org; Thu, 28 May 2020 14:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590691055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6QN/R04uDcf0bt0d1aVcTN9yKHu1W26n7q0T6qAU2U=;
 b=B0Cj77v3L1zxerX9ox7r008ATffDDFyGao2aaGYs1v6jEc0SUW2PsxWV9vqKHTFe+Zkbtq
 9RiIEsbe3Pn9YH32H757LMwGv4hcC8qdVDK9ptlY7HA74ESXBaoQBaaQHjKDJ5jDuipHuB
 /CD2bYeDtEqgeAIOb0bz5xTrQZ2WoPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-dmVZ0EaAOL2_wsKYnjQBDw-1; Thu, 28 May 2020 14:37:31 -0400
X-MC-Unique: dmVZ0EaAOL2_wsKYnjQBDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03EE684E27C;
 Thu, 28 May 2020 18:37:30 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 214C92E047;
 Thu, 28 May 2020 18:37:27 +0000 (UTC)
Subject: Re: [PATCH v6 03/12] hmp: Set cur_mon only in handle_hmp_command()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200528153742.274164-1-kwolf@redhat.com>
 <20200528153742.274164-4-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <e1f7f99c-c04e-cad6-cd19-7cd18e8bdae0@redhat.com>
Date: Thu, 28 May 2020 13:37:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528153742.274164-4-kwolf@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: marcandre.lureau@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/20 10:37 AM, Kevin Wolf wrote:
> cur_mon is updated relatively early in the command handling code even
> though only the command handler actually needs it. Move it to
> handle_hmp_command().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   monitor/hmp.c  | 23 ++++++++++++-----------
>   monitor/misc.c |  7 -------
>   2 files changed, 12 insertions(+), 18 deletions(-)
> 

> +++ b/monitor/misc.c

> @@ -258,7 +252,6 @@ static void monitor_init_qmp_commands(void)
>   /* Set the current CPU defined by the user. Callers must hold BQL. */
>   int monitor_set_cpu(Monitor *mon, int cpu_index)
>   {
> -    Monitor *cur_mon = monitor_cur();
>       CPUState *cpu;
>   
>       cpu = qemu_get_cpu(cpu_index);

Bogus churn, will disappear after you fix 2/12.  For the rest of the patch:
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


