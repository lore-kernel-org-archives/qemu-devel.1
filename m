Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F24C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABBE720772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 13:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBE720772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqcTJ-0002q4-02
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 09:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqcSl-0002Ps-1e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:07:43 -0400
Received: from relay68.bu.edu ([128.197.228.73]:53413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jqcSj-0006T7-A8
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:07:42 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 061D6KFY027687
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 1 Jul 2020 09:06:23 -0400
Date: Wed, 1 Jul 2020 09:06:20 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] pc: fix leak in pc_system_flash_cleanup_unused
Message-ID: <20200701130620.cldkfygyhz6oscev@mozz.bu.edu>
References: <20200701015859.29820-1-alxndr@bu.edu>
 <edb74f76-57a0-ef4b-17fa-f9f4b5dae8bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb74f76-57a0-ef4b-17fa-f9f4b5dae8bc@redhat.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 09:07:40
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200701 0749, Paolo Bonzini wrote:
> On 01/07/20 03:58, Alexander Bulekov wrote:
> > fix a leak detected when building with --enable-sanitizers:
> > ./i386-softmmu/qemu-system-i386
> > Upon exit:
> > ==13576==ERROR: LeakSanitizer: detected memory leaks
> > 
> > Direct leak of 1216 byte(s) in 1 object(s) allocated from:
> >     #0 0x7f9d2ed5c628 in malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5)
> >     #1 0x7f9d2e963500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.)
> >     #2 0x55fa646d25cc in object_new_with_type /tmp/qemu/qom/object.c:686
> >     #3 0x55fa63dbaa88 in qdev_new /tmp/qemu/hw/core/qdev.c:140
> >     #4 0x55fa638a533f in pc_pflash_create /tmp/qemu/hw/i386/pc_sysfw.c:88
> >     #5 0x55fa638a54c4 in pc_system_flash_create /tmp/qemu/hw/i386/pc_sysfw.c:106
> >     #6 0x55fa646caa1d in object_init_with_type /tmp/qemu/qom/object.c:369
> >     #7 0x55fa646d20b5 in object_initialize_with_type /tmp/qemu/qom/object.c:511
> >     #8 0x55fa646d2606 in object_new_with_type /tmp/qemu/qom/object.c:687
> >     #9 0x55fa639431e9 in qemu_init /tmp/qemu/softmmu/vl.c:3878
> >     #10 0x55fa6335c1b8 in main /tmp/qemu/softmmu/main.c:48
> >     #11 0x7f9d2cf06e0a in __libc_start_main ../csu/libc-start.c:308
> >     #12 0x55fa6335f8e9 in _start (/tmp/qemu/build/i386-softmmu/qemu-system-i386)
> > 
> > Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> > ---
> > 
> > I am not very familiar with the QOM, so maybe this isn't the right way
> > of going about this. With the call to object_property_add_child in
> > pc_sysfw.c:pc_pflash_create, object_ref is called on the pflash device.
> > In the pc_system_flash_cleanup_unused function, there are calls to
> > object_propery_del and object_unparent, but it seems neither of these
> > calls object_unref. So do we need to manually decrement the refcount?
> 
> Yes; you can also add it in pc_pflash_create, because
> 
>     /*
>      * Since object_property_add_child added a reference to the child object,
>      * we can drop the reference added by object_initialize(), so the child
>      * property will own the only reference to the object.
>      */
> 
> (from object_initialize_childv).

Isn't that reference used at pc_sysfw.c:104 ?
pcms->flash[0] = pc_pflash_create(pcms, "system.flash0", "pflash0");

In this case, shouldn't we unref when
pc_sysfw.c:126  pcms->flash[0] = NULL
?
-Alex

> Paolo
> 
> >  hw/i386/pc_sysfw.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> > index ec2a3b3e7e..f69a93671a 100644
> > --- a/hw/i386/pc_sysfw.c
> > +++ b/hw/i386/pc_sysfw.c
> > @@ -123,6 +123,7 @@ static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
> >              object_property_del(OBJECT(pcms), prop_name);
> >              g_free(prop_name);
> >              object_unparent(dev_obj);
> > +            object_unref(dev_obj);
> >              pcms->flash[i] = NULL;
> >          }
> >      }
> > 
> 

