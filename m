Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3158C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:24:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB3320EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hxZ2wpLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB3320EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0nL-0001sp-1j
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0Ph-0002Lg-IK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kW0Pf-0005GS-9I
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603472374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LscKBPJWNCYEYxMndciasWda8dumSJGIBNmJkm1fYwU=;
 b=hxZ2wpLJ+wyoOnjbMpA3ZcQ9LZimhhMkdFJ3vg0a4rtsBjDErHlQEX5MQfSEyqSgmnstFq
 ZRYy9zWn94oxEVOGQcZCm2jMESCQsDNAOAqjg3DcnTHTxO5iJAes/M3JLlTU8VxD60+cOy
 v75V4Kj8a4Fzh4LA9hVBONSgL7WjABg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-oliujPjiP62xkiekAGvbqQ-1; Fri, 23 Oct 2020 12:59:31 -0400
X-MC-Unique: oliujPjiP62xkiekAGvbqQ-1
Received: by mail-wr1-f70.google.com with SMTP id b11so814171wrm.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 09:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LscKBPJWNCYEYxMndciasWda8dumSJGIBNmJkm1fYwU=;
 b=AFF197aI00BvPELjg+O9U0PzEXsWJpPqB66HTHzWoNEShFqsWF7xAvrqTBEIX94Abh
 6KVodQya3iAqtOA3bpVHthIJtyg2TYeDV0O4TD9GZFMaXRHc5tEcQ5NZQ9AH4wNtyQOK
 /dJhdyopi+/QmUAr/KL4t9jxmfn0t6+8psD/SNQeMGe16pPIZeHA1Dy2lPa7Ww4106CM
 7n/QZlqhmxA/FZokTklaE949aK6iV7OojgxVVu9KTyxxhERSQKuu1cPi3xZYhAGCz5At
 Mdl4C1owYT1U1acz1OMjEItqlK8W9wRggQ869/2lVKnl/0WdmJD4XJNBYeyVnZpXg1fG
 RI2w==
X-Gm-Message-State: AOAM533FlPzTTByslukZWmtJ3mY0+t6GMX+b1B6RhSMXLU7bgldHn2Fa
 cmq2qoVKX8gXsOt5FanT+Gk/NPivRURLcwhnDXULQ01DT8BBKcePZ+DB4XjrteaR80/G8rCQUgG
 gup/dpNOWM1cPH08=
X-Received: by 2002:adf:ed45:: with SMTP id u5mr3490977wro.48.1603472370405;
 Fri, 23 Oct 2020 09:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsRqxw4famDvDllTblUWJoda+8aqodjsMyfibTSBRBR7w0SHkNRF8BXbHUqZ7279qvc/nfSQ==
X-Received: by 2002:adf:ed45:: with SMTP id u5mr3490933wro.48.1603472370092;
 Fri, 23 Oct 2020 09:59:30 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id m12sm3977222wrs.92.2020.10.23.09.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 09:59:29 -0700 (PDT)
Subject: Re: [PATCH v11 12/19] multi-process: Forward PCI config space acceses
 to the remote process
To: Jagannathan Raman <jag.raman@oracle.com>, qemu-devel@nongnu.org
References: <cover.1602784930.git.jag.raman@oracle.com>
 <1a1490ba03686fe29a0f627bec1556a0051fed18.1602784930.git.jag.raman@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47f25366-4cf3-7167-d199-1b82d7fd1ec2@redhat.com>
Date: Fri, 23 Oct 2020 18:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1a1490ba03686fe29a0f627bec1556a0051fed18.1602784930.git.jag.raman@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, quintela@redhat.com,
 mst@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 8:05 PM, Jagannathan Raman wrote:
> From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> 
> The Proxy Object sends the PCI config space accesses as messages
> to the remote process over the communication channel
> 
> TODO:
> Investigate if the local PCI config writes can be dropped.
> Without the proxy local PCI config space writes for the device,
> the driver in the guest times out on the probing.
> We have tried to only refer to the remote for the PCI config writes,
> but the driver timeout in the guest forced as to left this
> as it is (removing local PCI config only).

I expect this TODO to be lost in git history. Better to
commit it in the code and remove it once resolved IMHO.

> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/i386/remote-msg.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
>   hw/pci/proxy.c           | 50 ++++++++++++++++++++++++++++++++++++++
>   include/io/mpqemu-link.h |  9 +++++++
>   io/mpqemu-link.c         |  6 +++++
>   4 files changed, 127 insertions(+)

Please have a look at scripts/git.orderfile, it helps
reviewers to avoid scrolling down/up the patches.

> 
> diff --git a/hw/i386/remote-msg.c b/hw/i386/remote-msg.c
> index 6451b77..94937db 100644
> --- a/hw/i386/remote-msg.c
> +++ b/hw/i386/remote-msg.c
> @@ -15,6 +15,12 @@
>   #include "io/mpqemu-link.h"
>   #include "qapi/error.h"
>   #include "sysemu/runstate.h"
> +#include "hw/pci/pci.h"
> +
> +static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
> +                                 MPQemuMsg *msg);
> +static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
> +                                MPQemuMsg *msg);
>   
>   void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
>   {
> @@ -43,6 +49,12 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
>           }
>   
>           switch (msg.cmd) {
> +        case PCI_CONFIG_WRITE:
> +            process_config_write(com->ioc, pci_dev, &msg);
> +            break;
> +        case PCI_CONFIG_READ:
> +            process_config_read(com->ioc, pci_dev, &msg);
> +            break;
>           default:
>               error_setg(&local_err,
>                          "Unknown command (%d) received for device %s (pid=%d)",
> @@ -60,3 +72,53 @@ void coroutine_fn mpqemu_remote_msg_loop_co(void *data)
>   
>       return;
>   }
> +
> +static void process_config_write(QIOChannel *ioc, PCIDevice *dev,
> +                                 MPQemuMsg *msg)
> +{
> +    ConfDataMsg *conf = (ConfDataMsg *)&msg->data.conf_data;
> +    MPQemuMsg ret = { 0 };
> +    Error *local_err = NULL;
> +
> +    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
> +        error_report("Bad address received when writing PCI config, pid %d",
> +                     getpid());
> +        ret.data.u64 = UINT64_MAX;
> +    } else {
> +        pci_default_write_config(dev, conf->addr, conf->val, conf->l);
> +    }
> +
> +    ret.cmd = RET_MSG;
> +    ret.size = sizeof(ret.data.u64);
> +
> +    mpqemu_msg_send(&ret, ioc, &local_err);
> +    if (local_err) {
> +        error_report("Could not send message to proxy from pid %d",
> +                     getpid());
> +    }
> +}
> +
> +static void process_config_read(QIOChannel *ioc, PCIDevice *dev,
> +                                MPQemuMsg *msg)
> +{
> +    ConfDataMsg *conf = (ConfDataMsg *)&msg->data.conf_data;
> +    MPQemuMsg ret = { 0 };
> +    Error *local_err = NULL;
> +
> +    if ((conf->addr + sizeof(conf->val)) > pci_config_size(dev)) {
> +        error_report("Bad address received when reading PCI config, pid %d",
> +                     getpid());
> +        ret.data.u64 = UINT64_MAX;
> +    } else {
> +        ret.data.u64 = pci_default_read_config(dev, conf->addr, conf->l);

Isn't it endianess issue here? It might makes sense to
declare ConfDataMsg and PCI_CONFIG_READ/PCI_CONFIG_WRITE
packets in little endian.

> +    }
> +
> +    ret.cmd = RET_MSG;
> +    ret.size = sizeof(ret.data.u64);
> +
> +    mpqemu_msg_send(&ret, ioc, &local_err);
> +    if (local_err) {
> +        error_report("Could not send message to proxy from pid %d",
> +                     getpid());
> +    }
> +}
> diff --git a/hw/pci/proxy.c b/hw/pci/proxy.c
> index 7a12f23..27714fe 100644
> --- a/hw/pci/proxy.c
> +++ b/hw/pci/proxy.c
> @@ -16,6 +16,8 @@
>   #include "hw/qdev-properties.h"
>   #include "monitor/monitor.h"
>   #include "migration/blocker.h"
> +#include "io/mpqemu-link.h"
> +#include "qemu/error-report.h"
>   
>   static void proxy_set_socket(PCIProxyDev *pdev, int fd, Error **errp)
>   {
> @@ -69,6 +71,51 @@ static void pci_proxy_dev_exit(PCIDevice *pdev)
>       error_free(dev->migration_blocker);
>   }
>   
> +static int config_op_send(PCIProxyDev *pdev, uint32_t addr, uint32_t *val,
> +                          int l, unsigned int op)
> +{
> +    MPQemuMsg msg = { 0 };
> +    uint64_t ret = -EINVAL;
> +    Error *local_err = NULL;
> +
> +    msg.cmd = op;
> +    msg.data.conf_data.addr = addr;
> +    msg.data.conf_data.val = (op == PCI_CONFIG_WRITE) ? *val : 0;
> +    msg.data.conf_data.l = l;
> +    msg.size = sizeof(ConfDataMsg);
> +
> +    ret = mpqemu_msg_send_and_await_reply(&msg, pdev, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +    }
> +    if (op == PCI_CONFIG_READ) {
> +        *val = (uint32_t)ret;
> +    }
> +
> +    return ret;
> +}
> +
> +static uint32_t pci_proxy_read_config(PCIDevice *d, uint32_t addr, int len)
> +{
> +    uint32_t val;
> +
> +    (void)config_op_send(PCI_PROXY_DEV(d), addr, &val, len, PCI_CONFIG_READ);
> +
> +    return val;
> +}
> +
> +static void pci_proxy_write_config(PCIDevice *d, uint32_t addr, uint32_t val,
> +                                   int l)
> +{
> +    /*
> +     * Some of the functions access the copy of the remote device
> +     * PCI config space, therefore maintain it updated.
> +     */
> +    pci_default_write_config(d, addr, val, l);
> +
> +    (void)config_op_send(PCI_PROXY_DEV(d), addr, &val, l, PCI_CONFIG_WRITE);
> +}
> +
>   static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -76,6 +123,9 @@ static void pci_proxy_dev_class_init(ObjectClass *klass, void *data)
>   
>       k->realize = pci_proxy_dev_realize;
>       k->exit = pci_proxy_dev_exit;
> +    k->config_read = pci_proxy_read_config;
> +    k->config_write = pci_proxy_write_config;
> +
>       device_class_set_props(dc, proxy_properties);
>   }
>   
> diff --git a/include/io/mpqemu-link.h b/include/io/mpqemu-link.h
> index 4bea5da..459d345 100644
> --- a/include/io/mpqemu-link.h
> +++ b/include/io/mpqemu-link.h
> @@ -34,6 +34,8 @@ typedef enum {
>       MPQEMU_CMD_INIT,
>       SYNC_SYSMEM,
>       RET_MSG,
> +    PCI_CONFIG_WRITE,
> +    PCI_CONFIG_READ,
>       MPQEMU_CMD_MAX,
>   } MPQemuCmd;
>   
> @@ -43,6 +45,12 @@ typedef struct {
>       off_t offsets[REMOTE_MAX_FDS];
>   } SyncSysmemMsg;
>   
> +typedef struct {
> +    uint32_t addr;
> +    uint32_t val;
> +    int l;
> +} ConfDataMsg;

Maybe name this PciConfDataMsg?

> +
>   /**
>    * MPQemuMsg:
>    * @cmd: The remote command
> @@ -60,6 +68,7 @@ typedef struct {
>   
>       union {
>           uint64_t u64;
> +        ConfDataMsg conf_data;
>           SyncSysmemMsg sync_sysmem;
>       } data;
>   
> diff --git a/io/mpqemu-link.c b/io/mpqemu-link.c
> index 1339cc7..5ef82da 100644
> --- a/io/mpqemu-link.c
> +++ b/io/mpqemu-link.c
> @@ -278,6 +278,12 @@ bool mpqemu_msg_valid(MPQemuMsg *msg)
>               return false;
>           }
>           break;
> +    case PCI_CONFIG_WRITE:
> +    case PCI_CONFIG_READ:
> +        if (msg->size != sizeof(ConfDataMsg)) {
> +            return false;
> +        }
> +        break;
>       default:
>           break;
>       }
> 


