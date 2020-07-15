Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B5EC433EA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A1D205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsK9UQsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A1D205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jviMp-0006of-KT
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jviM9-00069m-6G
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:25:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49091
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jviM6-000327-GE
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594823153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=HB52k9nwKW1t17J0llHJ5uwAoVoMOaUln2Iu/TFS4o8=;
 b=ZsK9UQsnIUMChG0Pi9beK+MX4TBAfVnCJu50l7e/B4KTgYrdMRnPpsa1xg7T5GSTcgDsXY
 KHK+GaBv6v9h5eMj6nLopXVxZgUw4DshEnIcLSempTxWyqcahuGDowIx6+F9H4ZGNI48dl
 a+AcPFhvKc+SWxvG0Ccrxr+0cYbw1aM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-EvUX2ZiBNlWvUkDTjcHBPw-1; Wed, 15 Jul 2020 10:25:50 -0400
X-MC-Unique: EvUX2ZiBNlWvUkDTjcHBPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB4871086;
 Wed, 15 Jul 2020 14:25:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-26.ams2.redhat.com [10.36.112.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6826479D04;
 Wed, 15 Jul 2020 14:25:44 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/2] msf2: Unbreak device-list-properties for
 "msf-soc"
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200715140440.3540942-1-armbru@redhat.com>
 <20200715140440.3540942-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7418ff99-37c7-4891-9c72-e1764cd59611@redhat.com>
Date: Wed, 15 Jul 2020 16:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200715140440.3540942-2-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: peter.maydell@linaro.org, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, alistair@alistair23.me,
 mark.cave-ayland@ilande.co.uk, sundeep.lkml@gmail.com, b.galvani@gmail.com,
 nieklinnenbank@gmail.com, qemu-arm@nongnu.org, palmer@dabbelt.com,
 edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/07/2020 16.04, Markus Armbruster wrote:
> Watch this:
> 
>     $ qemu-system-aarch64 -M ast2600-evb -S -display none -qmp stdio
>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 0, "major": 5}, "package": "v5.0.0-2464-g3a9163af4e"}, "capabilities": ["oob"]}}
>     {"execute": "qmp_capabilities"}
>     {"return": {}}
>     {"execute": "device-list-properties", "arguments": {"typename": "msf2-soc"}}
>     Unsupported NIC model: ftgmac100
>     armbru@dusky:~/work/images$ echo $?
>     1
> 
> This is what breaks "make check SPEED=slow".
> 
> Root cause is m2sxxx_soc_initfn()'s messing with nd_table[] via
> qemu_check_nic_model().  That's wrong.
> 
> We fixed the exact same bug for device "allwinner-a10" in commit
> 8aabc5437b "hw/arm/allwinner-a10: Do not use nd_table in instance_init
> function".  Fix this instance the same way: move the offending code to
> m2sxxx_soc_realize(), where it's less wrong, and add a FIXME comment.
> 
> Fixes: 05b7374a58cd18aa3516e33513808896d0ac9b7b
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/arm/msf2-soc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
> index 16bb7c9916..33ea7df342 100644
> --- a/hw/arm/msf2-soc.c
> +++ b/hw/arm/msf2-soc.c
> @@ -82,10 +82,6 @@ static void m2sxxx_soc_initfn(Object *obj)
>      }
>  
>      object_initialize_child(obj, "emac", &s->emac, TYPE_MSS_EMAC);
> -    if (nd_table[0].used) {
> -        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> -        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> -    }
>  }
>  
>  static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> @@ -187,6 +183,11 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
>          g_free(bus_name);
>      }
>  
> +    /* FIXME use qdev NIC properties instead of nd_table[] */
> +    if (nd_table[0].used) {
> +        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
> +        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
> +    }
>      dev = DEVICE(&s->emac);
>      object_property_set_link(OBJECT(&s->emac), "ahb-bus",
>                               OBJECT(get_system_memory()), &error_abort);

As long as nobody comes up with a proper clean up within the next days
that moves the nd_table[] access to msf2-som.c, I think this is an
acceptable work-around for 5.1.

Reviewed-by: Thomas Huth <thuth@redhat.com>


