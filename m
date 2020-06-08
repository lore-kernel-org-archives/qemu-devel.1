Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54916C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153442074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 06:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP0hqHNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153442074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiAvy-0005e6-AG
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 02:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAvI-00059v-RA
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:06:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45552
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiAvH-00038r-OI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 02:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591596375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bWxtEOCAPvFnV8Ze5pNUOpekF97QfQBOU2hX1/h6IMc=;
 b=HP0hqHNs6P4G3D3yUpJZxLVmYykb8cy2iZqr2rbZSn1KbOO6vapcJSETO6r+b6cTUiX6xM
 14l8loHil1mtViaRo5KO0eYZ49Nq1WftSQUJLArzx6mDH0m+li6qyO7zQ5tc6QoKZUoMAK
 lMi03w/Cdvaj87eXMc7dvLCDVMA9bls=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Cl5miRpkPbWnnOZzhSh5Yg-1; Mon, 08 Jun 2020 02:06:12 -0400
X-MC-Unique: Cl5miRpkPbWnnOZzhSh5Yg-1
Received: by mail-wr1-f70.google.com with SMTP id c14so6695856wrm.15
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 23:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=bWxtEOCAPvFnV8Ze5pNUOpekF97QfQBOU2hX1/h6IMc=;
 b=Lq5slIU591+/I1gnW8pGIalqA+S2fVNbvUB/yYt/8fXvcbTOU9GY946Q/FkWCdnnqq
 kTSOZ/nykebIz51UKVQsOOASQRGq2l5zRsR2l9e26K7eEtGGquhYfpmFM7HKPHMXiUxS
 /VPpJl5E2GMRgDzYwAZyvAZSvv9ZCXkU17Y9CLgokQycZBxw7+PIa4yjUhvr+l4mwBCx
 rMBF67aVb2kH+nZMtF0UV4ODemCYib+HY3G/MIUo8yN0q2Q8Auf2topONGu/Vzo4aN7h
 7CUMo6ISCq7JD62wAqJiugUDrHwP2X6V/YvKlIR6HwRCx6hqevqbouQTnhwqdc7sfojA
 rbLw==
X-Gm-Message-State: AOAM530tFl6q+29xkxqwzXYVPiu33DBA+8+WnhKOX57Ot8ruPxLj//UZ
 0jJLf7v6pCL4lPLeXiUC15H4t8waH8FxIAiOQ2mYL62KAwrGO8TKOgZUwh2bUKoiLudOkSsVBzG
 HdjSJj89tLWUeKGk=
X-Received: by 2002:a05:600c:c3:: with SMTP id
 u3mr14098170wmm.108.1591596371089; 
 Sun, 07 Jun 2020 23:06:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyztcdXxc4V2xymmEjeW2bjnK+GU5QWPgVazIWhIc1jQDD0+ZBaHbVCCVOPMpnUKeUuTKcWdg==
X-Received: by 2002:a05:600c:c3:: with SMTP id
 u3mr14098146wmm.108.1591596370820; 
 Sun, 07 Jun 2020 23:06:10 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id n23sm21016024wmc.21.2020.06.07.23.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2020 23:06:10 -0700 (PDT)
Subject: Re: [PATCH 10/16] qdev: Improve netdev property override error a bit
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200605145625.2920920-1-armbru@redhat.com>
 <20200605145625.2920920-11-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <c405aa63-d4b6-741e-90e4-c7df80146d42@redhat.com>
Date: Mon, 8 Jun 2020 08:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605145625.2920920-11-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 00:45:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, mreitz@redhat.com,
 pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 4:56 PM, Markus Armbruster wrote:
> qdev_prop_set_netdev() fails when the property already has a non-null
> value.  Seems to go back to commit 30c367ed44
> "qdev-properties-system.c: Allow vlan or netdev for -device, not
> both", v1.7.0.  Board code doesn't expect failure, and crashes:
> 
>     $ qemu-system-x86_64 --nodefaults -nic user -netdev user,id=nic0 -global e1000.netdev=nic0
>     Unexpected error in error_set_from_qdev_prop_error() at /work/armbru/qemu/hw/core/qdev-properties.c:1101:
>     qemu-system-x86_64: Property 'e1000.netdev' doesn't take value '__org.qemu.nic0
>     '
>     Aborted (core dumped)
> 
> -device and device_add handle the failure:
> 
>     $ qemu-system-x86_64 -nodefaults -netdev user,id=net0 -netdev user,id=net1 -device e1000,netdev=net0,netdev=net1
>     qemu-system-x86_64: -device e1000,netdev=net0,netdev=net1: Property 'e1000.netdev' doesn't take value 'net1'
>     $ qemu-system-x86_64 -nodefaults -S -display none -monitor stdio -netdev user,id=net0 -netdev user,id=net1 -global e1000.netdev=net0
>     QEMU 5.0.50 monitor - type 'help' for more information
>     (qemu) qemu-system-x86_64: warning: netdev net0 has no peer
>     qemu-system-x86_64: warning: netdev net1 has no peer
>     device_add e1000,netdev=net1
>     Error: Property 'e1000.netdev' doesn't take value 'net1'

If patch accepted as it, might be worth Cc'ing qemu-stable@.

> 
> Perhaps netdev property override could be made to work.  Perhaps it
> should.  I'm not the right guy to figure this out.  What I can do is
> improve the error message a bit:
> 
>     (qemu) device_add e1000,netdev=net1
>     Error: -global e1000.netdev=... conflicts with netdev=net1
> 
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/qdev-properties.h     |  2 ++
>  hw/core/qdev-properties-system.c | 30 +++++++++++++++++++++++++++---
>  hw/core/qdev-properties.c        | 17 +++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index f161604fb6..566419f379 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -248,6 +248,8 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
>  
>  void qdev_prop_register_global(GlobalProperty *prop);
> +const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
> +                                            const char *name);
>  int qdev_prop_check_globals(void);
>  void qdev_prop_set_globals(DeviceState *dev);
>  void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
> index 9aa80495ee..20fd58e8f9 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -25,6 +25,28 @@
>  #include "sysemu/iothread.h"
>  #include "sysemu/tpm_backend.h"
>  
> +static bool check_non_null(DeviceState *dev, const char *name,

I see this is a static qdev function, but can we have a name that
better match the content? Maybe qdev_global_prop_exists()?

> +                           const void *old_val, const char *new_val,
> +                           Error **errp)
> +{
> +    const GlobalProperty *prop = qdev_find_global_prop(dev, name);
> +
> +    if (!old_val) {
> +        return true;
> +    }
> +
> +    if (prop) {
> +        error_setg(errp, "-global %s.%s=... conflicts with %s=%s",
> +                   prop->driver, prop->property, name, new_val);
> +    } else {
> +        /* Error message is vague, but a better one would be hard */
> +        error_setg(errp, "%s=%s conflicts, and override is not implemented",
> +                   name, new_val);
> +    }
> +    return false;
> +}
> +
> +
>  /* --- drive --- */
>  
>  static void get_drive(Object *obj, Visitor *v, const char *name, void *opaque,
> @@ -299,14 +321,16 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
>      }
>  
>      for (i = 0; i < queues; i++) {
> -
>          if (peers[i]->peer) {
>              err = -EEXIST;
>              goto out;
>          }
>  
> -        if (ncs[i]) {
> -            err = -EINVAL;
> +        /*
> +         * TODO Should this really be an error?  If no, the old value
> +         * needs to be released before we store the new one.
> +         */
> +        if (!check_non_null(dev, name, ncs[i], str, errp)) {
>              goto out;
>          }
>  
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index cc924815da..8c8beb56b2 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1181,6 +1181,23 @@ void qdev_prop_register_global(GlobalProperty *prop)
>      g_ptr_array_add(global_props(), prop);
>  }
>  
> +const GlobalProperty *qdev_find_global_prop(DeviceState *dev,
> +                                            const char *name)

Do you mind splitting this patch in 2? Adding qdev_find_global_prop
first, then using it to avoid the crash.

> +{
> +    GPtrArray *props = global_props();
> +    const GlobalProperty *p;
> +    int i;
> +
> +    for (i = 0; i < props->len; i++) {
> +        p = g_ptr_array_index(props, i);
> +        if (object_dynamic_cast(OBJECT(dev), p->driver)
> +            && !strcmp(p->property, name)) {

Laszlo pointed out elsewhere this doesn't match our CODING_STYLE.rst:

Multiline Indent
----------------

For example:

.. code-block:: c

    if (a == 1 &&
        b == 2) {

    while (a == 1 &&
           b == 2) {

I prefer the style you used, it looks safer. Eric once explained why
it is safer but I can't find his rationals anymore. I'll keep
searching to suggest a CODING_STYLE update.

> +            return p;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  int qdev_prop_check_globals(void)
>  {
>      int i, ret = 0;
> 


