Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEDC11D07
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:44:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFE1206EF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVJgvneS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFE1206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4m7b-0000yd-U5
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4m6t-0008Tf-Fr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4m6r-00017S-SS
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:43:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4m6r-00016N-OK
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582206201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjau6JGSO0QGhqCAN+BhmqgUJTWy1BfBWHq4HdLQIkY=;
 b=VVJgvneSg4Nxpox4rq/R2XutdXfeDBXQmFfNDaCnPtlhthtkfm6QFTWcHMmlkIcddq7vaO
 piW9MdTaM3oy3W0+OcHQUza5XdAznLCCfvV5ASxJ6eVQ/pc+l+BHQXW8cdNiO0CqYythkF
 84ECtwifRQcwWUo010+djRG9t1iQpM0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-7aot_AVmM3mqHKZBpsqehA-1; Thu, 20 Feb 2020 08:43:17 -0500
Received: by mail-ed1-f69.google.com with SMTP id c24so2725165edy.9
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qD/X+uvdAqiN2J4VmO38lFHYqqOLuyZd9jk531i2vDc=;
 b=KfuEYQCRKVnRDxdIw4wIEab4dEIQaGa9yNYy0jpIpbKZ9UmsYKVkpfNLpafTt/bp99
 CMFFBjkXnIWr+Z1DiAbhcMwh+n9z/1Dd4gKOzXXaEOw0tabWwByDLN3CZfwiO4RGIVPC
 yBqyHoksRmO+bQTRPYoYBFgVDrN1Hy0yIW2TndJhXuw/KKcsO+Hj32OOLkCh6bWCcC0R
 eU7WRWHrHJjPc9xbeWzM+yUgYA8493WSuNeBJleOHEqcUzHDpxMveWnfqZdr/KqA/+41
 fNJDRfuaKKs2GR7XPTC4FB79LewJLAcdr94intwZ3SwQoHMOmZuYpZ1g5LJJk85KmM0G
 eZLw==
X-Gm-Message-State: APjAAAVjGHVKJQre8yIcXfibIwQ6F27o9+29lFrH9oon5ACwL1cURPyf
 rXxaznl1eOeoDMed1Pr+ujief1oHqIe/PTLRWoRb6KjoYo2dBE9SDzP6g4kG7Jj+/wXdiQaLyyo
 WmuOOX0HVLe7YA54=
X-Received: by 2002:a17:906:af66:: with SMTP id
 os6mr30252283ejb.87.1582206195553; 
 Thu, 20 Feb 2020 05:43:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqy55S2TatA0f5hb66822wtWUhbSwpaXzdFOBOyYbycw17FXpGy5g+OlIEm49yhVSCxJsxpX7A==
X-Received: by 2002:a17:906:af66:: with SMTP id
 os6mr30252228ejb.87.1582206195221; 
 Thu, 20 Feb 2020 05:43:15 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id ks2sm125224ejb.82.2020.02.20.05.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2020 05:43:14 -0800 (PST)
Subject: Re: [PATCH v3 02/20] hw: Remove unnecessary cast when calling
 dma_memory_read()
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20200220130548.29974-1-philmd@redhat.com>
 <20200220130548.29974-3-philmd@redhat.com>
 <68120807-6f6b-1602-8208-fd76d64e74bc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be623afd-0605-0bdf-daae-f38ba5562012@redhat.com>
Date: Thu, 20 Feb 2020 14:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <68120807-6f6b-1602-8208-fd76d64e74bc@redhat.com>
Content-Language: en-US
X-MC-Unique: 7aot_AVmM3mqHKZBpsqehA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org,
 qemu-block@nongnu.org, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/20/20 2:16 PM, Eric Blake wrote:
> On 2/20/20 7:05 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Since its introduction in commit d86a77f8abb, dma_memory_read()
>> always accepted void pointer argument. Remove the unnecessary
>> casts.
>>
>> This commit was produced with the included Coccinelle script
>> scripts/coccinelle/exec_rw_const.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> =C2=A0 scripts/coccinelle/exec_rw_const.cocci | 15 +++++++++++++++
>> =C2=A0 hw/arm/smmu-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +=
--
>> =C2=A0 hw/arm/smmuv3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 10 ++++------
>> =C2=A0 hw/sd/sdhci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++----------
>> =C2=A0 4 files changed, 25 insertions(+), 18 deletions(-)
>> =C2=A0 create mode 100644 scripts/coccinelle/exec_rw_const.cocci
>>
>> diff --git a/scripts/coccinelle/exec_rw_const.cocci=20
>> b/scripts/coccinelle/exec_rw_const.cocci
>> new file mode 100644
>> index 0000000000..a0054f009d
>> --- /dev/null
>> +++ b/scripts/coccinelle/exec_rw_const.cocci
>> @@ -0,0 +1,15 @@
>> +// Usage:
>> +//=C2=A0 spatch --sp-file scripts/coccinelle/exec_rw_const.cocci --dir =
.=20
>> --in-place
>=20
> This command line should also use '--macro-file=20
> scripts/cocci-macro-file.h' to cover more of the code base (Coccinelle=20
> skips portions of the code that uses macros it doesn't recognize).
>=20
>=20
>> @@ -726,13 +724,10 @@ static void get_adma_description(SDHCIState *s,=20
>> ADMADescr *dscr)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SDHC_CTRL_ADMA2_64:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_memory_read(s->dma_as, e=
ntry_addr,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint=
8_t *)(&dscr->attr), 1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_memory_read(s->dma_as, e=
ntry_addr + 2,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (uint=
8_t *)(&dscr->length), 2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_memory_read(s->dma_as, e=
ntry_addr, (&dscr->attr), 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_memory_read(s->dma_as, e=
ntry_addr + 2, (&dscr->length), 2);
>=20
> The () around &dscr->length are now pointless.

Thanks Eric, patch updated. Peter are you OK if I change the cocci=20
header using /* */ as:

-- >8 --
diff --git a/scripts/coccinelle/exec_rw_const.cocci=20
b/scripts/coccinelle/exec_rw_const.cocci
index a0054f009d..7e42682240 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -1,5 +1,13 @@
-// Usage:
-//  spatch --sp-file scripts/coccinelle/exec_rw_const.cocci --dir .=20
--in-place
+/*
+  Usage:
+
+    spatch \
+           --macro-file scripts/cocci-macro-file.h \
+           --sp-file scripts/coccinelle/exec_rw_const.cocci \
+           --keep-comments \
+           --in-place \
+           --dir .
+*/

  // Remove useless cast
  @@
@@ -7,9 +15,9 @@ expression E1, E2, E3, E4;
  type T;
  @@
  (
-- dma_memory_read(E1, E2, (T *)E3, E4)
+- dma_memory_read(E1, E2, (T *)(E3), E4)
  + dma_memory_read(E1, E2, E3, E4)
  |
-- dma_memory_write(E1, E2, (T *)E3, E4)
+- dma_memory_write(E1, E2, (T *)(E3), E4)
  + dma_memory_write(E1, E2, E3, E4)
  )
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d5abdaad41..de63ffb037 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -724,10 +724,10 @@ static void get_adma_description(SDHCIState *s,=20
ADMADescr *dscr)
          }
          break;
      case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr, (&dscr->attr), 1);
-        dma_memory_read(s->dma_as, entry_addr + 2, (&dscr->length), 2);
+        dma_memory_read(s->dma_as, entry_addr, &dscr->attr, 1);
+        dma_memory_read(s->dma_as, entry_addr + 2, &dscr->length, 2);
          dscr->length =3D le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4, (&dscr->addr), 8);
+        dma_memory_read(s->dma_as, entry_addr + 4, &dscr->addr, 8);
          dscr->addr =3D le64_to_cpu(dscr->addr);
          dscr->attr &=3D (uint8_t) ~0xC0;
          dscr->incr =3D 12;
---


