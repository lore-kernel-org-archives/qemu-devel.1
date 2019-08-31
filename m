Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9AC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620F421874
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 19:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHktsqoL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620F421874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i49Cb-0003B8-FD
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 15:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49Bp-0002mD-77
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1i49Bo-0007jx-0d
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:37:37 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1i49Bn-0007jV-Kw
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 15:37:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id o184so10771659wme.3
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2019 12:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=W/LhrB2U1IXPsAPWcVJH5baUGsJHzQpzgniQpWh5DvI=;
 b=hHktsqoLlTfCLH5cBaQPJbRPy1msRYohobg2PAJvZ5XVXxbu8Epze4covMdmXYz5Sv
 Az9+2puzViTwmyLqAZyvOsoyBze8sCyaKuTGXkyy6C4Gnz0mqt0nplVF2BJPftoQ3PmV
 3ItRv3clRcs5hIlHDF4TlzBEWuuCDPqGNPT1X4bcKaXvnpSZQ7sbRLe7ha6w5P+SpjGS
 wCftdu4zcxeuJv5G67ctgOLqDJhVuip99KgZSeCNWO8VYdCSyIQKXnUe3BosYXia9q8T
 ePK/XfTLPqlx2mT3Hx93dNo2x7e9Py8ksRG/VzpwjwftRMsqgd8VH4R65ueFwyvlRhlw
 h3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=W/LhrB2U1IXPsAPWcVJH5baUGsJHzQpzgniQpWh5DvI=;
 b=AElaAm6RCvOWiwXjH2G3kd30+sZwM/5irlr6rJrjg4EJQ2cpJ766LZmbFblZCGA+ZF
 N2hpIovXNlyz56NS8IMfvOHxGOBbAqLHLA1X48ZHh62qTna6GjnjGO/khrHk399wkcoa
 JndtKabjnJif0ez6DdVenRhO1Op9HJp3L/SGcuce7W31V5HuMbqeFrBfwHaOcO8Gz6wC
 mZWP35uXIC33gOZ0IU5KoeMMW91fuaWuKE/eWuiIxgG4BkFjLkdm9Z0TbAlK5r7o+IJn
 pysLgymaNChZS5swdrYWFVqducZeNFqA/FdDltLv4SDC52IX9DLu+HzaoZqIT20coEbi
 IxYw==
X-Gm-Message-State: APjAAAURb22GyJLmmj6gceWDW/mGJ9TNcWJJOLADURQkPB8Mt78MtMeu
 eCBPM2JEp9nCD0+dIgwUqK4=
X-Google-Smtp-Source: APXvYqzVJ/IPFKY9fI3Jxa7IUyw1XFkyq+j4mEhsex2AMIfUyc86vak8pyDX7D7SaptG3Jsk0t/vFA==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr27362633wmc.67.1567280254189; 
 Sat, 31 Aug 2019 12:37:34 -0700 (PDT)
Received: from [192.168.86.99] ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id w8sm24075706wmc.1.2019.08.31.12.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Aug 2019 12:37:33 -0700 (PDT)
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>, qemu-devel@nongnu.org
References: <20190828142328.24561-1-skrtbhtngr@gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <6714c8f2-a139-94a1-4e9b-2e25e0c97b27@gmail.com>
Date: Sat, 31 Aug 2019 22:37:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828142328.24561-1-skrtbhtngr@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 0/2] Add live migration support in the
 PVRDMA device
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
Cc: Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sukrit,

On 8/28/19 5:23 PM, Sukrit Bhatnagar wrote:
> This series enables the migration of various GIDs used by the device.
> This is in addition to the successful migration of PCI and MSIX states
> as well as various DMA addresses and ring page information.
>      
> We have a setup having two hosts and two VMs running atop them.
> Migrations are performed over the local network.
>
> We also have performed various ping-pong tests (ibv_rc_pingpong) in the
> guest(s) after adding GID migration support and this is the current status:
> - ping-pong to localhost succeeds, when performed before starting the
>    migration and after the completion of migration.
> - ping-pong to a peer succeeds, both before and after migration as above,
>    provided that both VMs are running on/migrated to the same host.
>    So, if two VMs were started on two different hosts, and one of them
>    was migrated to the other host, the ping-pong was successful.
>    Similarly, if two VMs are migrated to the same host, then after migration,
>    the ping-pong was successful.
> - ping-pong to a peer on the remote host is not working as of now.
>      
> Our next goal is to achieve successful migration with live traffic.
>      

Nice work!
I am sorry for the GSOC program interruption and congrats
on your decision to continue the project!

Thanks,
Marcel

> This is the same as the RFC v3 series posted earlier:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04752.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04753.html
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg04754.html
>
>
> Sukrit Bhatnagar (2):
>    hw/pvrdma: make DSR mapping idempotent in load_dsr()
>    hw/pvrdma: add live migration support
>
>   hw/rdma/vmw/pvrdma_main.c | 94 +++++++++++++++++++++++++++++++++++----
>   1 file changed, 86 insertions(+), 8 deletions(-)
>


