Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47ABC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:01:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B043220772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKr+9TPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B043220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqyqA-0005FL-VX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqyob-0003un-0F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:59:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29794
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqyoY-00063G-Vf
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 08:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593694782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Js1umkaajnWJYovIlZB1lnvTgQy9SAH7PD5FrudKwY=;
 b=JKr+9TPTxcl7RWh6W19oq2i8nI+ETzOWQ90/Ix03eh5Q4dAQDHuOned0RDac4RKhen6QQw
 /lNRdq1C6Mss3m+7+m89r/6VPYaLXvng4f7wHbRt2cypvKNpMBwkHEtBbQYNObkEYN956w
 wlJNVL78vS4EKVSdDEINH8X9kcROPYA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-Jz5rOYuYP2qiRl-NutahPQ-1; Thu, 02 Jul 2020 08:59:37 -0400
X-MC-Unique: Jz5rOYuYP2qiRl-NutahPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A44B5185B3B0;
 Thu,  2 Jul 2020 12:59:35 +0000 (UTC)
Received: from localhost (ovpn-114-216.ams2.redhat.com [10.36.114.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B3FA79256;
 Thu,  2 Jul 2020 12:59:29 +0000 (UTC)
Date: Thu, 2 Jul 2020 13:59:28 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: elena.ufimtseva@oracle.com
Subject: Re: [PATCH v7 17/21] multi-process: Retrieve PCI info from remote
 process
Message-ID: <20200702125928.GB152912@stefanha-x1.localdomain>
References: <cover.1593273671.git.elena.ufimtseva@oracle.com>
 <a6b53187fa9f8ae1bf8470a8a6da36f66a87d53a.1593273671.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
In-Reply-To: <a6b53187fa9f8ae1bf8470a8a6da36f66a87d53a.1593273671.git.elena.ufimtseva@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 thanos.makatos@nutanix.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:09:39AM -0700, elena.ufimtseva@oracle.com wrote:
> @@ -267,3 +275,84 @@ const MemoryRegionOps proxy_mr_ops = {
>          .max_access_size = 1,
>      },
>  };
> +
> +static void probe_pci_info(PCIDevice *dev)
> +{
> +    PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(dev);
> +    DeviceClass *dc = DEVICE_CLASS(pc);
> +    PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
> +    MPQemuMsg msg = { 0 }, ret =  { 0 };
> +    uint32_t orig_val, new_val, class;
> +    uint8_t type;
> +    int i, size;
> +    char *name;
> +    Error *local_err = NULL;
> +
> +    msg.bytestream = 0;
> +    msg.size = 0;
> +    msg.cmd = GET_PCI_INFO;
> +
> +    ret.data1.u64  = mpqemu_msg_send_reply_co(&msg, pdev->dev, &local_err);
> +    if (local_err) {
> +        error_report("Error while sending GET_PCI_INFO message");
> +    }
> +
> +    pc->vendor_id = ret.data1.ret_pci_info.vendor_id;
> +    pc->device_id = ret.data1.ret_pci_info.device_id;
> +    pc->class_id = ret.data1.ret_pci_info.class_id;
> +    pc->subsystem_id = ret.data1.ret_pci_info.subsystem_id;

Why are the vendor/device/class/subsystem IDs read using a special
GET_PCI_INFO message when they are already accessible from the PCI
Configuration Space? All the other values are being read from the config
space so I wonder why a special message is needed.

> +
> +    config_op_send(pdev, PCI_CLASS_DEVICE, &class, 1, PCI_CONFIG_READ);
> +    switch (class) {
> +    case PCI_BASE_CLASS_BRIDGE:
> +        set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +        break;
> +    case PCI_BASE_CLASS_STORAGE:
> +        set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +        break;
> +    case PCI_BASE_CLASS_NETWORK:
> +        set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
> +        break;
> +    case PCI_BASE_CLASS_INPUT:
> +        set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> +        break;
> +    case PCI_BASE_CLASS_DISPLAY:
> +        set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +        break;
> +    case PCI_BASE_CLASS_PROCESSOR:
> +        set_bit(DEVICE_CATEGORY_CPU, dc->categories);
> +        break;
> +    default:
> +        set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> +        break;
> +    }
> +
> +    for (i = 0; i < 6; i++) {

s/6/G_N_ELEMENTS(pdev->region)/

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl792jAACgkQnKSrs4Gr
c8jeUggAwSc+ILjyGMuUOQECOgDk1xs0bTkXbjv337MjPeePZMamqDfaehmfeEjC
CWA3dSsUwNCB7olrcKRLMJtUE7i/Jccdwm0dyr6pGQmdopvoW97RoHhJiEGWJpK8
+UXejV7wPbyvU+6C1p/6P4jCxyUM9Xt7Hp1ZkPhaudUa7rygGRk0pBs6SyRPdOwv
ZZO49WPYYvtUmNfxvyarxCGJt+mejYlSROTvMw++zo4VbqrtW7sLtKPjWD44jO4F
SOaO8BvdVJS0pTdD8+8zC+Pgw7ixewcijXf3L0laIlzbqh8eHBXI0PhEh6aJVOZu
suoIVqsnwTm3j85KXCSxckCaHYtpyg==
=JGjY
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--


