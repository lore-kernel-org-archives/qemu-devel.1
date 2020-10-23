Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB6FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F076B223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbLN7aA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F076B223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0D4-00036p-PA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzdV-0002SU-QJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:09:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59499)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzdQ-0006uw-K1
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603469383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZUoFy06hlzlPuoLma7Rcfhg4rwKrywVZHlm7EIu+Vc=;
 b=QbLN7aA+lwZZUDkRUrUbjzcoRI6s8UFBom3iXa4BNTBVbsRvuTe8PMCPHgDxfSErJ9hDfx
 wJRaQ5JxE/jCZnOXrLiBVnrxFBGLO7Pek7yDhLaKjmFmdUIA6rjQonLKTV2jqIllRnCzym
 JYtsC0Wv6s/HMEauwMrSlVYY3CGi6JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-MlZEjnxGN4CrFV1oYZ3zXA-1; Fri, 23 Oct 2020 12:09:41 -0400
X-MC-Unique: MlZEjnxGN4CrFV1oYZ3zXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E0CD804B6E;
 Fri, 23 Oct 2020 16:09:40 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6629C5C1D0;
 Fri, 23 Oct 2020 16:09:35 +0000 (UTC)
Date: Fri, 23 Oct 2020 18:09:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peng Liang <liangpeng10@huawei.com>
Subject: Re: [PATCH] ACPI: Avoid infinite recursion when dump-vmstate
Message-ID: <20201023180933.2fe23875@redhat.com>
In-Reply-To: <20201019093156.2993284-1-liangpeng10@huawei.com>
References: <20201019093156.2993284-1-liangpeng10@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 17:31:56 +0800
Peng Liang <liangpeng10@huawei.com> wrote:

> There is a field with vmstate_ghes_state as vmsd in vmstate_ghes_state,
> which will lead to infinite recursion in dump_vmstate_vmsd.
> 
> Fixes: a08a64627b ("ACPI: Record the Generic Error Status Block address")
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Peng Liang <liangpeng10@huawei.com>
> ---
>  hw/acpi/generic_event_device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 6df400e1ee16..4b6867300a55 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -334,8 +334,7 @@ static const VMStateDescription vmstate_ghes_state = {
>      .minimum_version_id = 1,
>      .needed = ghes_needed,
>      .fields      = (VMStateField[]) {
> -        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> -                       vmstate_ghes_state, AcpiGhesState),
> +        VMSTATE_UINT64(ghes_state.ghes_addr_le, AcpiGedState),

not sure its' ok handle it this way,

see how it is done with another structure:

static const VMStateDescription vmstate_ged_state = {                            
    .name = "acpi-ged-state",                                                    
    .version_id = 1,                                                             
    .minimum_version_id = 1,                                                     
    .fields      = (VMStateField[]) {                                            
        VMSTATE_UINT32(sel, GEDState),                                           
        VMSTATE_END_OF_LIST()                                                    
    }                                                                            
}; 

...

VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),

i.e. it looks like we are missing structure definition for AcpiGhesState

CCing David,
 to help with migration magic in case I'm wrong or missed something

>          VMSTATE_END_OF_LIST()
>      }
>  };


