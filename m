Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E210C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD0A207DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p+e8NOQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD0A207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZTJ-0000Qd-KN
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtZRh-0007zX-Ca
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:30:49 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtZRf-0005Qi-Qf
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:30:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id f18so3086852wrs.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 09:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TyOgMn7nXOkVkJtxESNBZ1HaZZ9Dky7bJ5erhJ9aDac=;
 b=p+e8NOQhj5SCMwJkDmjBtoHX8yPDLR5AyCOo3Qa14cihGUuQ5Pq4EJ0hx+kWhnFJCY
 KYHj5ljBxsclux1bJA6GcELX+1Ne0a2d3rhbnZQBYivu5XxFqRzjN7tcNk8eKexA0yby
 dhYs5YfLsyZluIzKKELwPjsFaYQvT5bLgiUX9i2KKZHB5X1P7pOeNIUSr2lll28Jf2y6
 zYEyz32Ctd6I5m0ibNCEI+FWBmhdDUQKEAX3GzKR+v+B1wUcQp1OYbw54s9x8gRO+L8R
 c8de1vGMyyR8jRacnTSrKvHwwo1O8tNUPxOyuUXleUhJR3axzpb4ePKa7WDgawsXpFct
 7/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TyOgMn7nXOkVkJtxESNBZ1HaZZ9Dky7bJ5erhJ9aDac=;
 b=DsI7o4f1kwGlw6HhJDA717Ie+GbFS6Ri44hS0muWMB4J3VIpZv67RYCd4CVIKf9yCh
 gUANuC9gspJw/F9zeOxSJzrihFukWn8ckppByVJQdBAS7xCogpVvdl99+v+7p5DUOzMf
 0OrP7bxjYJkImfV2nEkwwZXhDsxADNx1r4NNND70+izAV77+txYnxGIsonyceoaK9Md8
 n83ZVDrmOoUZAmkQ4k3o5wqdYRYiexM4mgm51OvUpOvRZ9ueqOzJ4Wb7QaQ0MRbe3tE6
 CmsGRcoSeL3dJ46GNR3mmfaQVZqoGLy36gjTy3u7odcLno8kgl4n+8eKEvoEjrD6omhJ
 iQ1g==
X-Gm-Message-State: AOAM532P4s9afVIfroaxnnWB032SjmS5gZe7bTF8MjuohjsJr6SrRg33
 +sgFWqtA6JvYPylyD6IqQGimTA==
X-Google-Smtp-Source: ABdhPJz3smUL+LeoNMAr5T9SCcAKLZoNEfwLSIaTP2+reQZeVvoHqT00RE68MD2PSE40Lr9oUqqBLQ==
X-Received: by 2002:adf:81c8:: with SMTP id 66mr64098257wra.348.1594312246128; 
 Thu, 09 Jul 2020 09:30:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d201sm4929085wmd.34.2020.07.09.09.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2020 09:30:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B65C81FF7E;
 Thu,  9 Jul 2020 17:30:43 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-7-alex.bennee@linaro.org>
 <727b74da-1af1-400c-f2e8-2434fb842478@amsat.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v1 06/13] plugins: add API to return a name for a IO device
In-reply-to: <727b74da-1af1-400c-f2e8-2434fb842478@amsat.org>
Date: Thu, 09 Jul 2020 17:30:43 +0100
Message-ID: <87v9iwlkgc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, "Daniel P .
 Berrange" <berrange@redhat.com>, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com, Clement Deschamps <clement.deschamps@greensocs.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/9/20 4:13 PM, Alex Benn=C3=A9e wrote:
>> This may well end up being anonymous but it should always be unique.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> [r-b provisional given change to g_intern_string]
>> Reviewed-by: Clement Deschamps <clement.deschamps@greensocs.com>
>> Reviewed-by: Emilio G. Cota <cota@braap.org>
>>=20
>> ---
>> v3
>>   - return a non-freeable const g_intern_string()
>>   - checkpatch cleanups
>> ---
>>  include/qemu/qemu-plugin.h |  6 ++++++
>>  plugins/api.c              | 20 ++++++++++++++++++++
>>  2 files changed, 26 insertions(+)
>>=20
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index bab8b0d4b3af..c98c18d6b052 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -335,6 +335,12 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(q=
emu_plugin_meminfo_t info,
>>  bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
>>  uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwad=
dr *haddr);
>>=20=20
>> +/*
>> + * Returns a string representing the device. The string is valid for
>> + * the lifetime of the plugin.
>> + */
>> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwa=
ddr *h);
>> +
>>  typedef void
>>  (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
>>                               qemu_plugin_meminfo_t info, uint64_t vaddr,
>> diff --git a/plugins/api.c b/plugins/api.c
>> index bbdc5a4eb46d..4304e63f0cf8 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -303,6 +303,26 @@ uint64_t qemu_plugin_hwaddr_device_offset(const str=
uct qemu_plugin_hwaddr *haddr
>>      return 0;
>>  }
>>=20=20
>> +const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwa=
ddr *h)
>> +{
>> +#ifdef CONFIG_SOFTMMU
>> +    if (h && h->is_io) {
>> +        MemoryRegionSection *mrs =3D h->v.io.section;
>> +        if (!mrs->mr->name) {
>> +            unsigned long maddr =3D 0xffffffff & (uintptr_t) mrs->mr;
>
> Why not use uint32_t & PRIx32?
>
>                uint32_t maddr =3D (uintptr_t) mrs->mr;
>
>> +            g_autofree char *temp =3D g_strdup_printf("anon%08lx", madd=
r);
>> +            return g_intern_string(temp);
>
> Isn't this illegal? temp is definitively not const...

We don't mess with it, we return a new string which is the canonical
form.

>
>> +        } else {
>> +            return g_intern_string(mrs->mr->name);
>> +        }
>> +    } else {
>> +        return g_intern_string("RAM");
>> +    }
>> +#else
>> +    return g_intern_string("Invalid");
>> +#endif
>> +}
>> +
>>  /*
>>   * Queries to the number and potential maximum number of vCPUs there
>>   * will be. This helps the plugin dimension per-vcpu arrays.
>>=20


--=20
Alex Benn=C3=A9e

