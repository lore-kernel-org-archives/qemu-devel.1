Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87488C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A6F2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCoXHfn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A6F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3Gh-0001KZ-Jo
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo3A0-0005Rx-CR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:01:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57276
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jo39y-0005fF-En
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592996501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqlQzb/uEcHnBTtzd02eVzWV96pr+C0dJc6GQbPM9v4=;
 b=QCoXHfn9dJR7uC9CluWdSc4clQ+J73sbOX2ySWxGX+Bwo7ZgYVxHLY9CGkHBnqQq/vC437
 8VAYXgk+UbvcxKaMdwyEV/1zqVGgicr0x69vgIyKGWftxHDsLjcsx+OZu+PHur5rp9fGba
 q3CJLJ6CCc8A3JSyheeV1R3WFmXA6dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-q7EMX8LsN3G2uoE78kMyyg-1; Wed, 24 Jun 2020 07:01:36 -0400
X-MC-Unique: q7EMX8LsN3G2uoE78kMyyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01248804001;
 Wed, 24 Jun 2020 11:01:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-35.ams2.redhat.com [10.36.114.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 725197FD07;
 Wed, 24 Jun 2020 11:01:24 +0000 (UTC)
Subject: Re: [PATCH] hw/core/null-machine: Do not initialize unused chardev
 backends
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200624105611.1049-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bd458cb8-e005-0ea9-bbaf-bcb541bfdc89@redhat.com>
Date: Wed, 24 Jun 2020 13:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200624105611.1049-1-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/06/2020 12.56, Philippe Mathieu-Daudé wrote:
> The MachineClass uses an inverted logic (inherited from the
> PC machines [*]) to create the chardev backends for the default
> devices (see commits 998bbd74b9d..aa40fc9c964 and ac33f8fad14).
> 
> As the none-machine doesn't have any hardware device, it is
> pointless to initialize chardev backends. Fix by setting the
> 'no_defaults' bits in its MachineClass.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/core/null-machine.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index cb47d9d4f8..7e693523d7 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -50,6 +50,11 @@ static void machine_none_machine_init(MachineClass *mc)
>       mc->max_cpus = 1;
>       mc->default_ram_size = 0;
>       mc->default_ram_id = "ram";
> +    mc->no_serial = 1;
> +    mc->no_parallel = 1;
> +    mc->no_floppy = 1;
> +    mc->no_cdrom = 1;
> +    mc->no_sdcard = 1;
>   }
>   
>   DEFINE_MACHINE("none", machine_none_machine_init)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


