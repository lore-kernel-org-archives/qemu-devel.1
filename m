Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62DEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 00:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8366520773
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 00:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BfmpV2Qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8366520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsxdr-0007KA-RD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 20:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1jsxdD-0006tG-Ac
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 20:08:11 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1jsxdA-0007wm-Eu
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 20:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1594166885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fa+a427fsvU7I7pS/TEtdIk01JFAC6MvR03eM1+KwuE=;
 b=BfmpV2QkrwUk6V/5oH1AWRLt0tjqRNDvVUAVVtqBRvzJg7i0t+4wakqilLeNhHKBZQMUk9
 qT6VqhFGNbbvtc0lXoUuMsRHCCnQCooD9XBMByPK49B/eVD8n0xZ6rI6CkLe3P99jctcR8
 /BJCSQ4fI/NU7D8omJ2IDRDvFHQ1n30=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-4F33BLaJMvesT2ORZ2lZ2Q-1;
 Wed, 08 Jul 2020 02:08:03 +0200
X-MC-Unique: 4F33BLaJMvesT2ORZ2lZ2Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbLHpJ8Wp6IC+m8oc1SZ10L+7t3Dy30VnIJMV6TlLEvN+cp5rSFqfaY1ZW7qhDuaTjxicrNqyRcT3LuE0WSpjzfcZNMDhABSfnLjLkjOR74aeCdRFXXhiVfkyJXN3o57J9utTIILpmiWrFv/RloUCN4sFRGC3Dz+gvKNk0U9EwvtpcA8q94ttv1xqNN85TcagEzwz0zdN6To4xNuGWinoa/oRtSxfRkCvB+rYFzy8CFzfgBXTrUuG1IJzlr0oFgTrEPKRIJZfy/Tn58dzVws4hHbJquzhyMuBqOkJM9kjTV7yVZChxAEDLQYEvOS2P9D2Ef5l/5IgVeItiE9iSeKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fa+a427fsvU7I7pS/TEtdIk01JFAC6MvR03eM1+KwuE=;
 b=g0a+G1IGmkEf6XKjlUZ4nPgLsLU50ykSNhddTutqL6nO8ybyM0Lo1t1vm3A1dulaVcNFiYa9KaeyN/edJ0Nne9lrk/ZAXBjBaNq4UEmczP2UFc0ldOjoxvPRWc46Q/kCxauZseOyWzKg22eEW6GEAGOrp2M3pPXkUXeBwqzbuNRoQ/YsE9+8rYuMaVQi9AQcU5R+VPxZ00eechpLIeJFVhw5QXZKSP4Pn8NeAHsziYL7lqCefgsqnMhzXii0pgX7rB/bQNhPQEHQXZXr/oEpW+XQ5GQoWNzNa0aT+d5J4jtnkhQ7oQQVgpCB0w8KhYo/Jnt3MPqeWc7m65mropNcGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21) by AM0PR04MB4129.eurprd04.prod.outlook.com
 (2603:10a6:208:61::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Wed, 8 Jul
 2020 00:08:01 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::7065:39d1:bcc:21d3]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::7065:39d1:bcc:21d3%2]) with mapi id 15.20.3153.029; Wed, 8 Jul 2020
 00:08:01 +0000
Message-ID: <6987a2f4cedcf680a47c8bc5ed87e76a9f6a5887.camel@suse.com>
Subject: Re: [PULL 40/41] vhost-vdpa: introduce vhost-vdpa backend
From: Bruce Rogers <brogers@suse.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Date: Tue, 07 Jul 2020 18:07:55 -0600
In-Reply-To: <20200703090252.368694-41-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
 <20200703090252.368694-41-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::37) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:54::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (63.248.145.198) by
 AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend
 Transport; Wed, 8 Jul 2020 00:07:59 +0000
X-Originating-IP: [63.248.145.198]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4715350e-494d-4d25-01e9-08d822d2fa41
X-MS-TrafficTypeDiagnostic: AM0PR04MB4129:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4129C4E71E62331A76A131E1D9670@AM0PR04MB4129.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaVBiwY8rybbe2tOWwWF/5LQ0/+TigTzZuI5SWucnk2qeNJIfdbIfQ0AU0b+AVlpoHTABSylYfJQLrEfjFJVcHKp8PLhkb1msbBbA9t1dbd5yavQrrNjG88Y9wRfHTXSpyx94CTGh2ok9FyYh1zXNbpRGSZvpZ2efPFA5gBsCJ3z0Tv+ilCYu1gkC5mPy3dqakmVRHEAiPKD/kw98M53ArIMPqixsEvjF2QIsnUeIow/sWN6CpYL85VGB4K4WoLdjwGC2Qd4V47Fgh48WxWzmBj0Xll1bBVvdOmF2Cr6ZA8DFR7Wt6X1btfNKpBqgsn+KSzvKiwvebMn5cCrCCLdLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR0401MB2354.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39830400003)(396003)(376002)(346002)(366004)(136003)(316002)(54906003)(86362001)(8676002)(5660300002)(83380400001)(956004)(2616005)(26005)(66476007)(2906002)(36756003)(6666004)(16526019)(66556008)(478600001)(30864003)(66946007)(6486002)(4326008)(8936002)(186003)(16576012)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: n3Bd56VPMLDGT3iKNQAsq6YoEqA5qiE3INCXeyv5r2D9Q//rLLNGe8vkd1x8+tAx/5zmglVBvPDiVmZnIoiacYz2a9fZhBsQ1wQ/MHrpzPcWdF40xA0F0R4o1pdo17k4365IzJduQN50rLTU1J7mnHLDj/tacYNSPf2s6SwYt/cbT7UNAqeQY7uA87tcto1vqSnrWSzK+AUe0qr+cLgi+LyjgKvFl6oOT4/iMiebxbX6nQyFqHFjH0d3wBgedcMDZm8UPA4Q571L8LX8/qfChyyMWL1xvTwChT+bMV3sFoxmDCww10xuFJv64BrZ7FqjSeV1krT+jze2S6CL5xpQXxRY2+5C6mva0kL0H7FV5nOL7zWlhJ1zChtmGIt6nMubIGco8+fVWZNrbjvca5u+cfGtc7QNKNYtvMbB2cxa9RlMlkX++fixnBDQ84taqk2dW/aseqikbCVyB4huAZYO92xhTQbG18XAAJTOAAO40BM=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4715350e-494d-4d25-01e9-08d822d2fa41
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2354.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 00:08:01.4434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r0uKJ6j84kwZylNXd6LWPhg56DXsbNYVQYqVHvOLvqK7cB/D2ea+SHBHX48+e8K2bmSeIulYentRsaCtUta5Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4129
Received-SPF: pass client-ip=62.140.7.102; envelope-from=brogers@suse.com;
 helo=de-smtp-delivery-102.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 20:08:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Lingshan zhu <lingshan.zhu@intel.com>,
 Tiwei Bie <tiwei.bie@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2020-07-03 at 05:05 -0400, Michael S. Tsirkin wrote:
> From: Cindy Lu <lulu@redhat.com>
> 
> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> vhost-user. The above patch provides a generic device for vDPA
> purpose,
> this vDPA device exposes to user space a non-vendor-specific
> configuration
> interface for setting up a vhost HW accelerator, this patch set
> introduces
> a third vhost backend called vhost-vdpa based on the vDPA interface.
> 
> Vhost-vdpa usage:
> 
> qemu-system-x86_64 -cpu host -enable-kvm \
>     ......
>     -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-
> vdpa0 \
>     -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
> 
> Signed-off-by: Lingshan zhu <lingshan.zhu@intel.com>
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Message-Id: <20200701145538.22333-14-lulu@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>  configure                         |  21 ++
>  include/hw/virtio/vhost-backend.h |   4 +-
>  include/hw/virtio/vhost-vdpa.h    |  26 ++
>  include/hw/virtio/vhost.h         |   7 +
>  hw/net/vhost_net.c                |  19 +-
>  hw/net/virtio-net.c               |  19 ++
>  hw/virtio/vhost-backend.c         |   6 +
>  hw/virtio/vhost-vdpa.c            | 475
> ++++++++++++++++++++++++++++++
>  docs/interop/index.rst            |   1 +
>  docs/interop/vhost-vdpa.rst       |  17 ++
>  hw/virtio/Makefile.objs           |   1 +
>  qemu-options.hx                   |  12 +
>  12 files changed, 601 insertions(+), 7 deletions(-)
>  create mode 100644 include/hw/virtio/vhost-vdpa.h
>  create mode 100644 hw/virtio/vhost-vdpa.c
>  create mode 100644 docs/interop/vhost-vdpa.rst
> 
> diff --git a/configure b/configure
> index 4a22dcd563..3db7f20185 100755
> --- a/configure
> +++ b/configure
> @@ -1575,6 +1575,10 @@ for opt do
>    ;;
>    --enable-vhost-user) vhost_user="yes"
>    ;;
> +  --disable-vhost-vdpa) vhost_vdpa="no"
> +  ;;
> +  --enable-vhost-vdpa) vhost_vdpa="yes"
> +  ;;
>    --disable-vhost-kernel) vhost_kernel="no"
>    ;;
>    --enable-vhost-kernel) vhost_kernel="yes"
> @@ -1883,6 +1887,7 @@ disabled with --disable-FEATURE, default is
> enabled if available:
>    vhost-crypto    vhost-user-crypto backend support
>    vhost-kernel    vhost kernel backend support
>    vhost-user      vhost-user backend support
> +  vhost-vdpa      vhost-vdpa kernel backend support
>    spice           spice
>    rbd             rados block device (rbd)
>    libiscsi        iscsi support
> @@ -2394,6 +2399,10 @@ test "$vhost_user" = "" && vhost_user=yes
>  if test "$vhost_user" = "yes" && test "$mingw32" = "yes"; then
>    error_exit "vhost-user isn't available on win32"
>  fi
> +test "$vhost_vdpa" = "" && vhost_vdpa=$linux
> +if test "$vhost_vdpa" = "yes" && test "$linux" != "yes"; then
> +  error_exit "vhost-vdpa is only available on Linux"
> +fi
>  test "$vhost_kernel" = "" && vhost_kernel=$linux
>  if test "$vhost_kernel" = "yes" && test "$linux" != "yes"; then
>    error_exit "vhost-kernel is only available on Linux"
> @@ -2422,6 +2431,11 @@ test "$vhost_user_fs" = "" &&
> vhost_user_fs=$vhost_user
>  if test "$vhost_user_fs" = "yes" && test "$vhost_user" = "no"; then
>    error_exit "--enable-vhost-user-fs requires --enable-vhost-user"
>  fi
> +#vhost-vdpa backends
> +test "$vhost_net_vdpa" = "" && vhost_net_vdpa=$vhost_vdpa
> +if test "$vhost_net_vdpa" = "yes" && test "$vhost_vdpa" = "no"; then
> +  error_exit "--enable-vhost-net-vdpa requires --enable-vhost-vdpa"
> +fi
>  
>  # OR the vhost-kernel and vhost-user values for simplicity
>  if test "$vhost_net" = ""; then
> @@ -6936,6 +6950,7 @@ echo "vhost-scsi support $vhost_scsi"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
>  echo "vhost-user-fs support $vhost_user_fs"
> +echo "vhost-vdpa support $vhost_vdpa"
>  echo "Trace backends    $trace_backends"
>  if have_backend "simple"; then
>  echo "Trace output file $trace_file-<pid>"
> @@ -7437,6 +7452,9 @@ fi
>  if test "$vhost_net_user" = "yes" ; then
>    echo "CONFIG_VHOST_NET_USER=y" >> $config_host_mak
>  fi
> +if test "$vhost_net_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_NET_VDPA=y" >> $config_host_mak
> +fi
>  if test "$vhost_crypto" = "yes" ; then
>    echo "CONFIG_VHOST_CRYPTO=y" >> $config_host_mak
>  fi
> @@ -7452,6 +7470,9 @@ fi
>  if test "$vhost_user" = "yes" ; then
>    echo "CONFIG_VHOST_USER=y" >> $config_host_mak
>  fi
> +if test "$vhost_vdpa" = "yes" ; then
> +  echo "CONFIG_VHOST_VDPA=y" >> $config_host_mak
> +fi
>  if test "$vhost_user_fs" = "yes" ; then
>    echo "CONFIG_VHOST_USER_FS=y" >> $config_host_mak
>  fi
> diff --git a/include/hw/virtio/vhost-backend.h
> b/include/hw/virtio/vhost-backend.h
> index e7cb8d028c..8825bd278f 100644
> --- a/include/hw/virtio/vhost-backend.h
> +++ b/include/hw/virtio/vhost-backend.h
> @@ -17,7 +17,8 @@ typedef enum VhostBackendType {
>      VHOST_BACKEND_TYPE_NONE = 0,
>      VHOST_BACKEND_TYPE_KERNEL = 1,
>      VHOST_BACKEND_TYPE_USER = 2,
> -    VHOST_BACKEND_TYPE_MAX = 3,
> +    VHOST_BACKEND_TYPE_VDPA = 3,
> +    VHOST_BACKEND_TYPE_MAX = 4,
>  } VhostBackendType;
>  
>  typedef enum VhostSetConfigType {
> @@ -170,6 +171,7 @@ typedef struct VhostOps {
>  } VhostOps;
>  
>  extern const VhostOps user_ops;
> +extern const VhostOps vdpa_ops;
>  
>  int vhost_set_backend_type(struct vhost_dev *dev,
>                             VhostBackendType backend_type);
> diff --git a/include/hw/virtio/vhost-vdpa.h
> b/include/hw/virtio/vhost-vdpa.h
> new file mode 100644
> index 0000000000..6455663388
> --- /dev/null
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -0,0 +1,26 @@
> +/*
> + * vhost-vdpa.h
> + *
> + * Copyright(c) 2017-2018 Intel Corporation.
> + * Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef HW_VIRTIO_VHOST_VDPA_H
> +#define HW_VIRTIO_VHOST_VDPA_H
> +
> +#include "hw/virtio/virtio.h"
> +
> +typedef struct vhost_vdpa {
> +    int device_fd;
> +    uint32_t msg_type;
> +    MemoryListener listener;
> +} VhostVDPA;
> +
> +extern AddressSpace address_space_memory;
> +extern int vhost_vdpa_get_device_id(struct vhost_dev *dev,
> +                                   uint32_t *device_id);
> +#endif
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 085450c6f8..767a95ec0b 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -92,6 +92,13 @@ struct vhost_dev {
>      const VhostDevConfigOps *config_ops;
>  };
>  
> +struct vhost_net {
> +    struct vhost_dev dev;
> +    struct vhost_virtqueue vqs[2];
> +    int backend;
> +    NetClientState *nc;
> +};
> +
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type,
>                     uint32_t busyloop_timeout);
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 4561665f6b..e165594cf3 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -17,8 +17,10 @@
>  #include "net/net.h"
>  #include "net/tap.h"
>  #include "net/vhost-user.h"
> +#include "net/vhost-vdpa.h"
>  
>  #include "standard-headers/linux/vhost_types.h"
> +#include "linux-headers/linux/vhost.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "net/vhost_net.h"
>  #include "qemu/error-report.h"
> @@ -33,12 +35,6 @@
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/virtio-bus.h"
>  
> -struct vhost_net {
> -    struct vhost_dev dev;
> -    struct vhost_virtqueue vqs[2];
> -    int backend;
> -    NetClientState *nc;
> -};
>  
>  /* Features supported by host kernel. */
>  static const int kernel_feature_bits[] = {
> @@ -96,6 +92,11 @@ static const int
> *vhost_net_get_feature_bits(struct vhost_net *net)
>      case NET_CLIENT_DRIVER_VHOST_USER:
>          feature_bits = user_feature_bits;
>          break;
> +#ifdef CONFIG_VHOST_NET_VDPA
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        feature_bits = vdpa_feature_bits;
> +        break;
> +#endif
>      default:
>          error_report("Feature bits not defined for this type: %d",
>                  net->nc->info->type);
> @@ -443,6 +444,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>          vhost_net = vhost_user_get_vhost_net(nc);
>          assert(vhost_net);
>          break;
> +#endif
> +#ifdef CONFIG_VHOST_NET_VDPA
> +    case NET_CLIENT_DRIVER_VHOST_VDPA:
> +        vhost_net = vhost_vdpa_get_vhost_net(nc);
> +        assert(vhost_net);
> +        break;
>  #endif
>      default:
>          break;
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index aff67a92df..0a54b1910a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -43,6 +43,7 @@
>  #include "monitor/qdev.h"
>  #include "hw/pci/pci.h"
>  #include "net_rx_pkt.h"
> +#include "hw/virtio/vhost.h"
>  
>  #define VIRTIO_NET_VM_VERSION    11
>  
> @@ -125,6 +126,8 @@ static void virtio_net_get_config(VirtIODevice
> *vdev, uint8_t *config)
>      VirtIONet *n = VIRTIO_NET(vdev);
>      struct virtio_net_config netcfg;
>  
> +    int ret = 0;
> +    memset(&netcfg, 0 , sizeof(struct virtio_net_config));
>      virtio_stw_p(vdev, &netcfg.status, n->status);
>      virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
>      virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> @@ -138,6 +141,15 @@ static void virtio_net_get_config(VirtIODevice
> *vdev, uint8_t *config)
>      virtio_stl_p(vdev, &netcfg.supported_hash_types,
>                   VIRTIO_NET_RSS_SUPPORTED_HASHES);
>      memcpy(config, &netcfg, n->config_size);
> +
> +    NetClientState *nc = qemu_get_queue(n->nic);
> +    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t
> *)&netcfg,
> +                             n->config_size);
> +    if (ret != -1) {
> +        memcpy(config, &netcfg, n->config_size);
> +    }
> +    }
>  }
>  
>  static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t
> *config)
> @@ -153,6 +165,13 @@ static void virtio_net_set_config(VirtIODevice
> *vdev, const uint8_t *config)
>          memcpy(n->mac, netcfg.mac, ETH_ALEN);
>          qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
>      }
> +
> +    NetClientState *nc = qemu_get_queue(n->nic);
> +    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> +        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t
> *)&netcfg,
> +                               0, n->config_size,
> +                        VHOST_SET_CONFIG_TYPE_MASTER);
> +      }
>  }
>  
>  static bool virtio_net_started(VirtIONet *n, uint8_t status)
> diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> index 48905383f8..782b1d67d9 100644
> --- a/hw/virtio/vhost-backend.c
> +++ b/hw/virtio/vhost-backend.c
> @@ -15,6 +15,7 @@
>  #include "qemu/main-loop.h"
>  #include "standard-headers/linux/vhost_types.h"
>  
> +#include "hw/virtio/vhost-vdpa.h"
>  #ifdef CONFIG_VHOST_KERNEL
>  #include <linux/vhost.h>
>  #include <sys/ioctl.h>
> @@ -285,6 +286,11 @@ int vhost_set_backend_type(struct vhost_dev
> *dev, VhostBackendType backend_type)
>      case VHOST_BACKEND_TYPE_USER:
>          dev->vhost_ops = &user_ops;
>          break;
> +#endif
> +#ifdef CONFIG_VHOST_VDPA
> +    case VHOST_BACKEND_TYPE_VDPA:
> +        dev->vhost_ops = &vdpa_ops;
> +        break;
>  #endif
>      default:
>          error_report("Unknown vhost backend type");
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> new file mode 100644
> index 0000000000..6f2b01c25e
> --- /dev/null
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -0,0 +1,475 @@
> +/*
> + * vhost-vdpa
> + *
> + *  Copyright(c) 2017-2018 Intel Corporation.
> + *  Copyright(c) 2020 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include <linux/vhost.h>
> +#include <linux/vfio.h>
> +#include <sys/eventfd.h>
> +#include <sys/ioctl.h>
> +#include "hw/virtio/vhost.h"
> +#include "hw/virtio/vhost-backend.h"
> +#include "hw/virtio/virtio-net.h"
> +#include "hw/virtio/vhost-vdpa.h"
> +#include "qemu/main-loop.h"
> +#include <linux/kvm.h>
> +#include "sysemu/kvm.h"
There is an issue here ^^^
Now that this patch is in mainline, I find that hw/virtio/vhost-vdpa.c
does not compile on a RISCV host (I'm using the openSUSE Build Service,
which provides a number of architectures, including RISCV64). This host
doesn't have KVM support.

The failure is as follows:
In file included from /home/abuild/rpmbuild/BUILD/qemu-
5.0.50/hw/virtio/vhost-vdpa.c:22:
/home/abuild/rpmbuild/BUILD/qemu-5.0.50/linux-
headers/linux/kvm.h:14:10: fatal error: asm/kvm.h: No such file or
directory
   14 | #include <asm/kvm.h>

As I wondered why we have a kvm reference in this file at all, I
removed the last two #include lines above and recompiled, I find that
TARGET_PAGE_MASK and TARGET_PAGE_ALIGN are not defined, so poking
around a bit it seemed that including "cpu.h" might be the solution
there, and it indeed compiles ok that way.

I'll leave it to the patch author or sub-maintainer to identify the
best solution.

Thanks,

Bruce


