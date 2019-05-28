Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE9FC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF5421721
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkkiXKgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF5421721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39593 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVfMS-0002Um-TB
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 12:54:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVfKi-0001Ql-12
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVfKh-0000vG-45
	for qemu-devel@nongnu.org; Tue, 28 May 2019 12:52:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hVfKb-0000oW-3i; Tue, 28 May 2019 12:52:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id z23so3662263wma.4;
	Tue, 28 May 2019 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=6ldlFtM5sj3Tfe3IA2K9x58hOsQNZQg0u7lahDZJ3kk=;
	b=HkkiXKgMrten6dkXkmSezBTz2TVwp3lhSpYXcbHtOJMOpOAPxKpcgikVzSej9kXXtA
	PjyZtWVNh0SBqnkfShdAmGwvJRAmgIZ+yB2g62XUEZcx15e8uLFS+IK0Tf+/3f44mMlN
	omOh4wGu2txL5slQWPKhLMHND+lgOfmt2eyjBMHBAJmUEkNH/oW2Gk//+nIJxhSWf7Wc
	2N0Cxw0htYeUOR4ZLdafZ41Gupnjyo3qRruUIxiXR9T8Ky67ZPV+3B7N2H0JkDwd+IXd
	QouBlOfQpU8Ds+q2NTMHtA8wJJEXbhjY8B9l2p6qH2aWbHujg+myaMjkE+L2+IWwr+Fz
	+3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=6ldlFtM5sj3Tfe3IA2K9x58hOsQNZQg0u7lahDZJ3kk=;
	b=fL7YT0+IM1Bds6Z3Rpq1HSwD5DUSHhq8pTPe9a6ABu9m8gbPlDyv6ftZIlI+3WlpKZ
	tqfibRWHnMtTgBA9yBJJpjYMhl9CylEEiSO+Phy6HxshDUW9wdED4wpMgAfqNXcgtlfj
	GPkU626dROFbSHC6stgZnX/x8E3zru2+WmJD4djTyUrOsF7yYYeAFxgJBDIo972BpZ3i
	rahlzomkqF7eL4kdH5bxtoZ4S2l0/34sC86J4IJ52BrpxjaKgOI/bmVxGJJUuDKJqfqh
	jX7drELOr8BC6i/uIhriwpk5kH+uvrfUDhobRNO6Sm8pF0RxCrZjeWVMnyEEpCfEOF3R
	k3Hw==
X-Gm-Message-State: APjAAAXBUtfuEhAPbLiSblG6b5rfIKIz5PkbZvjvcOVr66sP83Lllryq
	i/30uhszud9Fn1P8wvWHfoA=
X-Google-Smtp-Source: APXvYqx+tf6fjwZu9xbb99dYH25fjonD8ZcUQSiPdyJdWlO5GwFhun/f/iGn5Dx4gmS854hzrEuJMw==
X-Received: by 2002:a1c:5a43:: with SMTP id o64mr3798144wmb.31.1559062324983; 
	Tue, 28 May 2019 09:52:04 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	h188sm5292699wmf.48.2019.05.28.09.52.01
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 09:52:04 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20190528164020.32250-1-philmd@redhat.com>
	<20190528164020.32250-4-philmd@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <10e9f842-9909-41f3-00c7-5c88a930211b@gmail.com>
Date: Tue, 28 May 2019 19:52:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528164020.32250-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 03/10] hw/pci-bridge: Use the QOM BUS()
 macro to access BusState.qbus
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Markus Armbruster <armbru@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Michael Walle <michael@walle.cc>, Gerd Hoffmann <kraxel@redhat.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/28/19 7:40 PM, Philippe Mathieu-Daudé wrote:
> Rather than looking inside the definition of a BusState with "s->bus.qbus",
> use the QOM prefered style: "BUS(&s->bus)".
>
> This patch was generated using the following Coccinelle script:
>
>      // Use BUS() macros to access BusState.qbus
>      @use_bus_macro_to_access_qbus@
>      expression obj;
>      identifier bus;
>      @@
>      -&obj->bus.qbus
>      +BUS(&obj->bus)
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   hw/pci/pci_bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index c6d9ded320..8d954885c0 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -273,7 +273,7 @@ void pci_bridge_write_config(PCIDevice *d,
>       newctl = pci_get_word(d->config + PCI_BRIDGE_CONTROL);
>       if (~oldctl & newctl & PCI_BRIDGE_CTL_BUS_RESET) {
>           /* Trigger hot reset on 0->1 transition. */
> -        qbus_reset_all(&s->sec_bus.qbus);
> +        qbus_reset_all(BUS(&s->sec_bus));
>       }
>   }
>   

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel




