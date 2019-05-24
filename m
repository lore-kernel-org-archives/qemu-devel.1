Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E112DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F45E2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvvkGBle"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F45E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU2hq-0004NO-Pd
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:25:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hU2h4-0003zX-QN
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:24:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hU2h3-0007El-Lp
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:24:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:34403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hU2h3-0007DG-Bo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:24:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id e19so1045775wme.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 22:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=f7T9hADPZsFl0gjUcYnHkeMjhXGaRY4UbYVgjjoeT8w=;
	b=OvvkGBle4pOANr9FDXeVPEkwa48oti8BT9GkathPjSFcGUqFpZjabBEVYCM6AVtdTm
	EHyhfElrlR+vKE9z1J9hhyrhhzdxpE7tFfqC63heNI6rbBgqZ+XFHfS5Dx978ghiZe9p
	FGmSAYfluXtwkNI2K5DETbkBLBcKkJxRpWTDiS3Dr6Cs5Aq0boCngO1XM1ey2ydEJ6xp
	30W8U1wFdH7ZQK9gHQkTRw06jnaYuRgA5vCbBgIAtORvfEYmVTKus6FH1Ded51UsLAVr
	+4sZSCumTMAShrGUHloa+GrCc10AGjM2khwAj3ueAnAuBOF4DI5Dazw1OovHs0x4XQ48
	CE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=f7T9hADPZsFl0gjUcYnHkeMjhXGaRY4UbYVgjjoeT8w=;
	b=sMPUMxgbtGbS2Esb9I0gAfAJAT8uxfTWSI5eLyjLRwe11eq6Vj1GL1TAvm6NO+obJI
	wXB8CTw9qLBV5Tbbh4PdaKvN7KY813pjLMZSxegGfkLctrE0plLz+pNQEIKYQIaOtOBc
	xX+b3x4XgNXPVRWmqqJB7NAele0z5XIk3ZiRKPYL36Qttt4AxFv/b/dzRgzvd1KE+8B+
	Iyd/m2yB6ecsdeG699BHiz8oMzXoxcR+rHNj9P+VuoxIQTvxy+IVLA5ExUQ9c7U5NfpR
	3yOBDI3dlCFsEYDvX3BovK/nbJ8oQgb86gTrWAKCix3J+F6nknJHOPOXqjof8g9AJsRS
	hvRg==
X-Gm-Message-State: APjAAAV1bpToyaTjp9PgBPC8+msRJFDJSA3NxNwe3qKVzZ2x+2LhzdVG
	XhpPmifBA2AaxXC9torLW5Z/5oJs
X-Google-Smtp-Source: APXvYqynBYqagOjGhtz2Haww9SAM9k+Xdz5ujGF2xAqSOt6t4s/niZk6XpIr9/+TdjSVyzuXtKdMNA==
X-Received: by 2002:a1c:197:: with SMTP id 145mr14021736wmb.10.1558675475170; 
	Thu, 23 May 2019 22:24:35 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id
	k63sm1495751wmf.35.2019.05.23.22.24.33
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:24:34 -0700 (PDT)
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org
References: <20190505105518.22793-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <87a35658-a636-4598-c860-cc73288922e2@gmail.com>
Date: Fri, 24 May 2019 08:24:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505105518.22793-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Add support for GID state changes
 for non-qmp frameworks
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Yuval,

On 5/5/19 1:55 PM, Yuval Shaia wrote:
> Any GID change in guest must be propogate to host. This is already done
> by firing QMP event to managment system such as libvirt which in turn
> will update the host with the relevant change.

Agreed, *any* management software can do that.

>
> When qemu is executed on non-qmp framework (ex from command-line) we
> need to update the host instead.
> Fix it by adding support to update the RoCE device's Ethernet function
> IP list from qemu via netlink.

I am not sure this is the right approach. I don't think QEMU should 
actively change
the host network configuration.
As you pointed out yourself, the management software should make such 
changes.

I agree you cannot always assume the QEMU instance is managed by libvirt,
what about adding this functionality to rdma-multiplexer? The 
multiplexer may
register to the same QMP event.

Even if you think the multiplexer is not the right way to do it, even a 
simple bash script
disguised  as a systemd service can subscribe to the QMP event and make the
change on the host.

What do you think?

Thanks,
Marcel

>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> ---
>   configure              |  6 ++++
>   hw/rdma/rdma_backend.c | 74 +++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 79 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 5b183c2e39..1f707b1a62 100755
> --- a/configure
> +++ b/configure
> @@ -3132,6 +3132,8 @@ fi
>   
>   cat > $TMPC <<EOF &&
>   #include <sys/mman.h>
> +#include <libmnl/libmnl.h>
> +#include <linux/rtnetlink.h>
>   
>   int
>   main(void)
> @@ -3144,10 +3146,13 @@ main(void)
>   }
>   EOF
>   
> +pvrdma_libs="-lmnl"
> +
>   if test "$rdma" = "yes" ; then
>       case "$pvrdma" in
>       "")
>           if compile_prog "" ""; then
> +            libs_softmmu="$libs_softmmu $pvrdma_libs"
>               pvrdma="yes"
>           else
>               pvrdma="no"
> @@ -3156,6 +3161,7 @@ if test "$rdma" = "yes" ; then
>       "yes")
>           if ! compile_prog "" ""; then
>               error_exit "PVRDMA is not supported since mremap is not implemented"
> +                        " or libmnl-devel is not installed"
>           fi
>           pvrdma="yes"
>           ;;
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 05f6b03221..bc57b1a624 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -16,6 +16,11 @@
>   #include "qemu/osdep.h"
>   #include "qapi/qapi-events-rdma.h"
>   
> +#include "linux/if_addr.h"
> +#include "libmnl/libmnl.h"
> +#include "linux/rtnetlink.h"
> +#include "net/if.h"
> +
>   #include <infiniband/verbs.h>
>   
>   #include "contrib/rdmacm-mux/rdmacm-mux.h"
> @@ -47,6 +52,61 @@ static void dummy_comp_handler(void *ctx, struct ibv_wc *wc)
>       rdma_error_report("No completion handler is registered");
>   }
>   
> +static int netlink_route_update(const char *ifname, union ibv_gid *gid,
> +                                __u16 type)
> +{
> +    char buf[MNL_SOCKET_BUFFER_SIZE];
> +    struct nlmsghdr *nlh;
> +    struct ifaddrmsg *ifm;
> +    struct mnl_socket *nl;
> +    int ret;
> +    uint32_t ipv4;
> +
> +    nl = mnl_socket_open(NETLINK_ROUTE);
> +    if (!nl) {
> +        rdma_error_report("Fail to connect to netlink\n");
> +        return -EIO;
> +    }
> +
> +    ret = mnl_socket_bind(nl, 0, MNL_SOCKET_AUTOPID);
> +    if (ret < 0) {
> +        rdma_error_report("Fail to bind to netlink\n");
> +        goto out;
> +    }
> +
> +    nlh = mnl_nlmsg_put_header(buf);
> +    nlh->nlmsg_type = type;
> +    nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL;
> +    nlh->nlmsg_seq = 1;
> +
> +    ifm = mnl_nlmsg_put_extra_header(nlh, sizeof(*ifm));
> +    ifm->ifa_index = if_nametoindex(ifname);
> +    if (gid->global.subnet_prefix) {
> +        ifm->ifa_family = AF_INET6;
> +        ifm->ifa_prefixlen = 64;
> +        ifm->ifa_flags = IFA_F_PERMANENT;
> +        ifm->ifa_scope = RT_SCOPE_UNIVERSE;
> +        mnl_attr_put(nlh, IFA_ADDRESS, sizeof(*gid), gid);
> +    } else {
> +        ifm->ifa_family = AF_INET;
> +        ifm->ifa_prefixlen = 24;
> +        memcpy(&ipv4, (char *)&gid->global.interface_id + 4, sizeof(ipv4));
> +        mnl_attr_put(nlh, IFA_LOCAL, 4, &ipv4);
> +    }
> +
> +    ret = mnl_socket_sendto(nl, nlh, nlh->nlmsg_len);
> +    if (ret < 0) {
> +        rdma_error_report("Fail to send msg to to netlink\n");
> +        goto out;
> +    }
> +
> +    ret = 0;
> +
> +out:
> +    mnl_socket_close(nl);
> +    return ret;
> +}
> +
>   static inline void complete_work(enum ibv_wc_status status, uint32_t vendor_err,
>                                    void *ctx)
>   {
> @@ -1123,7 +1183,13 @@ int rdma_backend_add_gid(RdmaBackendDev *backend_dev, const char *ifname,
>                                               gid->global.subnet_prefix,
>                                               gid->global.interface_id);
>   
> -    return ret;
> +    /*
> +     * We ignore return value since operation might completed sucessfully
> +     * by the QMP consumer
> +     */
> +    netlink_route_update(ifname, gid, RTM_NEWADDR);
> +
> +    return 0;
>   }
>   
>   int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
> @@ -1149,6 +1215,12 @@ int rdma_backend_del_gid(RdmaBackendDev *backend_dev, const char *ifname,
>                                               gid->global.subnet_prefix,
>                                               gid->global.interface_id);
>   
> +    /*
> +     * We ignore return value since operation might completed sucessfully
> +     * by the QMP consumer
> +     */
> +    netlink_route_update(ifname, gid, RTM_DELADDR);
> +
>       return 0;
>   }
>   


