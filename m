Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F38AC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:02:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8071C206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 19:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4CC4Yok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8071C206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIGDP-0004Ho-DF
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 15:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIGBl-0003ZC-TL
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:00:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIGBi-000086-PO
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600196420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oe7XqQvm9qmYVxTAAJWtkRsABBOHSvu37ZYlDm5ijY=;
 b=W4CC4YokI32A058PuXssvoJnmpK7qwCXPGxdVcd3Z5+8/eOZFIzW/Qx1qDwe4Z/TwKwNQX
 DtdjUAJShwHWbUkB6ODtT70AIDHABShLlaqYiHUiF0KFE7JlAdFj10KqWWqEW4xHknPRkq
 8fq6iwfhh8cvooS8qxCuitY19GJLNnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-YwDUfKodPSOVBSilfMtYAg-1; Tue, 15 Sep 2020 15:00:16 -0400
X-MC-Unique: YwDUfKodPSOVBSilfMtYAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77B6B81CBE9;
 Tue, 15 Sep 2020 19:00:15 +0000 (UTC)
Received: from work-vm (ovpn-115-25.ams2.redhat.com [10.36.115.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A10D709BB;
 Tue, 15 Sep 2020 19:00:12 +0000 (UTC)
Date: Tue, 15 Sep 2020 20:00:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi.c: Fix wrong usage of gboolean types
 in PVSCSIState
Message-ID: <20200915190009.GF2922@work-vm>
References: <20200913234451.170022-1-ameynarkhede03@gmail.com>
 <bee146be-e867-6c6f-4007-b61751be1e6c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <bee146be-e867-6c6f-4007-b61751be1e6c@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, pbonzini@redhat.com,
 Amey Narkhede <ameynarkhede03@gmail.com>, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Hi Amey,
> 
> On 9/14/20 1:44 AM, Amey Narkhede wrote:
> > rings_info_valid, msg_ring_info_valid and use_msg fields of struct
> > PVSCSIState are using gboolean TRUE/FALSE values with the type uint8_t.
> > Change their type to bool along with the usage of initialization macro
> > VMSTATE_BOOL during initialization of vmstate_pvscsi and
> > pvscsi_properties.
> > 
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> > ---
> >  hw/scsi/vmw_pvscsi.c | 22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> > index c071e0c7aa..86f00e3d7e 100644
> > --- a/hw/scsi/vmw_pvscsi.c
> > +++ b/hw/scsi/vmw_pvscsi.c
> > @@ -123,9 +123,9 @@ typedef struct {
> >      /* Collector for current command data */
> >      uint32_t curr_cmd_data[PVSCSI_MAX_CMD_DATA_WORDS];
> > 
> > -    uint8_t rings_info_valid;            /* Whether data rings initialized   */
> > -    uint8_t msg_ring_info_valid;         /* Whether message ring initialized */
> > -    uint8_t use_msg;                     /* Whether to use message ring      */
> > +    bool rings_info_valid;            /* Whether data rings initialized   */
> > +    bool msg_ring_info_valid;         /* Whether message ring initialized */
> > +    bool use_msg;                     /* Whether to use message ring      */
> > 
> >      uint8_t msi_used;                    /* For migration compatibility      */
> >      PVSCSIRingInfo rings;                /* Data transfer rings manager      */
> > @@ -349,8 +349,8 @@ pvscsi_reset_state(PVSCSIState *s)
> >      s->reg_command_status = PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
> >      s->reg_interrupt_status = 0;
> >      pvscsi_ring_cleanup(&s->rings);
> > -    s->rings_info_valid = FALSE;
> > -    s->msg_ring_info_valid = FALSE;
> > +    s->rings_info_valid = false;
> > +    s->msg_ring_info_valid = false;
> >      QTAILQ_INIT(&s->pending_queue);
> >      QTAILQ_INIT(&s->completion_queue);
> >  }
> > @@ -792,7 +792,7 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
> >      pvscsi_dbg_dump_tx_rings_config(rc);
> >      pvscsi_ring_init_data(&s->rings, rc);
> > 
> > -    s->rings_info_valid = TRUE;
> > +    s->rings_info_valid = true;
> >      return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
> >  }
> > 
> > @@ -874,7 +874,7 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
> >          if (pvscsi_ring_init_msg(&s->rings, rc) < 0) {
> >              return PVSCSI_COMMAND_PROCESSING_FAILED;
> >          }
> > -        s->msg_ring_info_valid = TRUE;
> > +        s->msg_ring_info_valid = true;
> >      }
> >      return sizeof(PVSCSICmdDescSetupMsgRing) / sizeof(uint32_t);
> >  }
> > @@ -1232,9 +1232,9 @@ static const VMStateDescription vmstate_pvscsi = {
> >          VMSTATE_UINT32(curr_cmd_data_cntr, PVSCSIState),
> >          VMSTATE_UINT32_ARRAY(curr_cmd_data, PVSCSIState,
> >                               ARRAY_SIZE(((PVSCSIState *)NULL)->curr_cmd_data)),
> > -        VMSTATE_UINT8(rings_info_valid, PVSCSIState),
> > -        VMSTATE_UINT8(msg_ring_info_valid, PVSCSIState),
> > -        VMSTATE_UINT8(use_msg, PVSCSIState),
> > +        VMSTATE_BOOL(rings_info_valid, PVSCSIState),
> > +        VMSTATE_BOOL(msg_ring_info_valid, PVSCSIState),
> > +        VMSTATE_BOOL(use_msg, PVSCSIState),
> 
> I believe this change the migration data structure. This
> area is described in "Changing migration data structures"
> in docs/devel/migration.rst.
> 
> If this structure were not affected, your change would be
> a good cleanup. However changing migration can become a
> nightmare, so ... cleaning this is hard.
> 
> Cc'ing Dave (a migration maintainer) as I'm not sure there
> already is a document describing easily this problem.

Well; the migration structures are...very unstructured.
It turns out that VMSTATE_BOOL already reads/writes a raw
byte to the file - so it's the same size as the VMSTATE_UINT8 at least.
Disappointingly get_bool and put_bool in vmstate-types.c don't do any
sanitation either; so you get whatever the raw value is.

glib's FALSE/TRUE is:

#define FALSE   (0)
#define TRUE    (!FALSE)

so that's probably fine;  as long as no one does anything silly like
compare the value with TRUE or true.

Dave

> > 
> >          VMSTATE_UINT64(rings.rs_pa, PVSCSIState),
> >          VMSTATE_UINT32(rings.txr_len_mask, PVSCSIState),
> > @@ -1255,7 +1255,7 @@ static const VMStateDescription vmstate_pvscsi = {
> >  };
> > 
> >  static Property pvscsi_properties[] = {
> > -    DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
> > +    DEFINE_PROP_BOOL("use_msg", PVSCSIState, use_msg, true),
> >      DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
> >                      PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
> >      DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
> > --
> > 2.28.0
> > 
> > This is my first qemu patch. Let know if there are any mistakes
> > 
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


