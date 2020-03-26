Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39523C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:40:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 044F52076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 11:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipJLV/To"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044F52076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHQru-0001oQ-1G
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 07:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jHQrB-0001NM-0i
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jHQr8-00059W-Tt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:39:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jHQr8-00058z-Mr
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 07:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585222765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaj2NX7KW0/z4FE2j0GdCTQEutgcHqZv5oi3woDQNOc=;
 b=ipJLV/To2vq+KO5Hn8uwM8x0OFfkgrtv1kOTCdK2XamuesD+744/wyvJjDUmI09aIerxX2
 szJh3HBaBADuP5CqUiO/KEO8HvVcVk/S3Lx4ltVURUguR4JyfLg4n+FZmCh80khuIkV5i+
 Tk602rPPM1RO0uo/1EYPrCjnVFgnmp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-SXsHCx0qOuuCZYuF82QArg-1; Thu, 26 Mar 2020 07:39:24 -0400
X-MC-Unique: SXsHCx0qOuuCZYuF82QArg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 906B2149C4;
 Thu, 26 Mar 2020 11:39:22 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8701E790E0;
 Thu, 26 Mar 2020 11:39:20 +0000 (UTC)
Subject: Re: [PATCH for-5.0] arm:virt: fix broken IPA range with KVM enabled
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200326112829.19989-1-imammedo@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6b21c599-fe4f-76c8-e996-a9a71574eff8@redhat.com>
Date: Thu, 26 Mar 2020 12:39:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200326112829.19989-1-imammedo@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, gshan@redhat.com,
 shameerali.kolothum.thodi@huawei.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 3/26/20 12:28 PM, Igor Mammedov wrote:
> Commit a1b18df9a4848, broke virt_kvm_type() logic, which depends on
> maxram_size, ram_size, ram_slots being parsed/set on machine instance
> at the time accelerator (KVM) is initialized.
> 
> set_memory_options() part was already reverted by commit 2a7b18a3205b,
> so revert remaining initialization of above machine fields to make
> virt_kvm_type() work as it used to.
Oh I did not notice set_memory_options() change was already reverted.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reported-by: Auger Eric <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>


> ---
>  softmmu/vl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/softmmu/vl.c b/softmmu/vl.c
> index 814537bb42..132c6e73dc 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -4137,6 +4137,9 @@ void qemu_init(int argc, char **argv, char **envp)
>      machine_opts = qemu_get_machine_opts();
>      qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
>                       &error_fatal);
> +    current_machine->ram_size = ram_size;
> +    current_machine->maxram_size = maxram_size;
> +    current_machine->ram_slots = ram_slots;

Nit: Before configure_accelerators() call there is a comment stating
that configure_accelerators uses machine properties and must be called
after machine_set_property. Maybe we should add it also uses memory
properties and should be called after set_memory_options. This may avoid
other changes of the same style.

Thanks

Eric
>  
>      /*
>       * Note: uses machine properties such as kernel-irqchip, must run
> @@ -4315,10 +4318,6 @@ void qemu_init(int argc, char **argv, char **envp)
>          }
>      }
>  
> -    current_machine->ram_size = ram_size;
> -    current_machine->maxram_size = maxram_size;
> -    current_machine->ram_slots = ram_slots;
> -
>      parse_numa_opts(current_machine);
>  
>      if (machine_class->default_ram_id && current_machine->ram_size &&
> 


