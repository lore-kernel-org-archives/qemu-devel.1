Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17ECC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C2020774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xu7mCGFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C2020774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiUL-00046m-SU
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiiFq-0000iw-LD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:41:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jiiFo-0005Yx-AP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591724496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ihmIiostKvdpw1r9iZpPNAlh9WuRRNQ2zRGcXyc1pUY=;
 b=Xu7mCGFWafkoETULb/xly85hBfPeCKkqG4ob8iXXaNEE9F64e/JPpZjRiJl15x5PkL7QS2
 aGLXY8u/Y68CfZqU37yK4pdVroxopCdcSoQ7U4bzk26/QFWIfrqBpsBCD/B4VfEZs0xeQD
 7iDpk4VriEU/OWTyq7FaaOepABSmjqg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-yduFk-f6OfewPNpcOvoDTg-1; Tue, 09 Jun 2020 13:41:34 -0400
X-MC-Unique: yduFk-f6OfewPNpcOvoDTg-1
Received: by mail-wr1-f70.google.com with SMTP id a4so8882300wrp.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AJKtT4l2MFAMGi/3mhANHfLaqRqaP5VrhgmxxaiqQUc=;
 b=cSs8fuR54kP53G1xkaXepHCmaeZB8R50B5ja89xnVJvZbHLF8Nq8S5V75xU4D97WAC
 Ty6mA4RHCBkoyZ3MQR2x8YkzjHLSLQ1cU3nDQ9++BODSEj0vQNwUrd+qnNrCZJEX2Tmr
 7p20+MLsBLrKHSGVk9N1hZHEFeidDZ+1d6tHOWJrfoewbVUBTJpWBVJ2j3aeImtgwFwD
 i5wv5+bCg1Bjx3wRozgvgh/l1ccaUBvZWFqLWIIlvIgdkJ/dRPJ7BCC8P8opYxiF6LXP
 Rrl61S/hCLsHQQQ6CKP4dMBjUY8ahD2DH2cyovxpaWkkRibpfWzs6YHPd926J0AIVXPm
 Ad6A==
X-Gm-Message-State: AOAM533bqwXTANLBs3Jxi7i8RzeNQb0mzQmSs9vg13ptBdWZfBM3Kf1g
 AbJB4hTAz7wiTs+AY2dQE3/Q5+bh/NQ1HLJop3s1M8iRsMNbP+cXy/RJhELYHNjcAXYtTzmIBcL
 LbLlwXXECsYWAy7I=
X-Received: by 2002:a5d:4b85:: with SMTP id b5mr5633320wrt.8.1591724493372;
 Tue, 09 Jun 2020 10:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA56wFHTMub+p3FUiWNMRz2BM3jk3/EdANFyGcNswBCWfj2x4I/lpz0sI5Zl+JVnjqZtW77Q==
X-Received: by 2002:a5d:4b85:: with SMTP id b5mr5633298wrt.8.1591724493084;
 Tue, 09 Jun 2020 10:41:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id q128sm3660535wma.38.2020.06.09.10.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 10:41:32 -0700 (PDT)
Date: Tue, 9 Jun 2020 13:41:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/pci: Fix crash when running QEMU with "-nic
 model=rocker"
Message-ID: <20200609134118-mutt-send-email-mst@kernel.org>
References: <20200527153152.9211-1-thuth@redhat.com>
 <bead355e-de7f-e584-53a7-34b2f1664be4@vivier.eu>
 <7e862bc4-0d5d-298e-0d1b-b8249100da9c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7e862bc4-0d5d-298e-0d1b-b8249100da9c@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 07:24:24PM +0200, Paolo Bonzini wrote:
> On 09/06/20 19:21, Laurent Vivier wrote:
> > Le 27/05/2020 à 17:31, Thomas Huth a écrit :
> >> QEMU currently aborts when being started with "-nic model=rocker" or with
> >> "-net nic,model=rocker". This happens because the "rocker" device is not
> >> a normal NIC but a switch, which has different properties. Thus we should
> >> only consider real NIC devices for "-nic" and "-net". These devices can
> >> be identified by the "netdev" property, so check for this property before
> >> adding the device to the list.
> >>
> >> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> >> Fixes: 52310c3fa7dc854d ("net: allow using any PCI NICs in -net or -nic")
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>  hw/pci/pci.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index 70c66965f5..46214f8287 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -1887,7 +1887,18 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
> >>          if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
> >>              dc->user_creatable) {
> >>              const char *name = object_class_get_name(list->data);
> >> -            g_ptr_array_add(pci_nic_models, (gpointer)name);
> >> +            /*
> >> +             * A network device might also be something else than a NIC, see
> >> +             * e.g. the "rocker" device. Thus we have to look for the "netdev"
> >> +             * property, too. Unfortunately, some devices like virtio-net only
> >> +             * create this property during instance_init, so we have to create
> >> +             * a temporary instance here to be able to check it.
> >> +             */
> >> +            Object *obj = object_new_with_class(OBJECT_CLASS(dc));
> >> +            if (object_property_find(obj, "netdev", NULL)) {
> >> +                g_ptr_array_add(pci_nic_models, (gpointer)name);
> >> +            }
> >> +            object_unref(obj);
> >>          }
> >>          next = list->next;
> >>          g_slist_free_1(list);
> >>
> > 
> > Not really trivial, I will not pick up this patch via trivial-branch,
> > unless PCI maintainers request it.
> > 
> > Thanks,
> > Laurent
> > 
> 
> I'll pick it up then.
> 
> Paolo

I queued this already. Thanks!

-- 
MST


