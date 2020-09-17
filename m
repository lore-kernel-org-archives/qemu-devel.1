Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:02:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393A420838
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALQr0n59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393A420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqk6-0004rw-4A
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIqi9-0003Ux-Es
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:00:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIqi6-00022l-8f
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600336813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WwIxy4EkReBWYK9jYstrs0vt3Qndski37ELRnuCv0SI=;
 b=ALQr0n59PRm5IyWPmSOtxaDtreDLvFUuXq3fu/Y2At8oCNiG3dhxHHeIH02wyJWBFgh47R
 XsA1a5JNP2c9VeO7zT8Lw+QBQoU+dry+HzYZ+mbki4e+feeLEF4B+0I4c4iWkj7gk+Anwu
 s9iujnbv3qUPe+tgjxG2PnYHfFfnglo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-lINkpIXCN_K5CFPedC6EEw-1; Thu, 17 Sep 2020 06:00:11 -0400
X-MC-Unique: lINkpIXCN_K5CFPedC6EEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5547780EF9C;
 Thu, 17 Sep 2020 10:00:10 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CE07514E;
 Thu, 17 Sep 2020 10:00:03 +0000 (UTC)
Date: Thu, 17 Sep 2020 11:00:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] virtio: skip legacy support check on machine types
 less than 5.1
Message-ID: <20200917100000.GF2793@work-vm>
References: <20200915130514.80989-1-sgarzare@redhat.com>
 <20200916110848.47395807.cohuck@redhat.com>
 <20200917084828.p7j3fc6p4almxbxw@steredhat>
 <20200917112256.796f620d.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200917112256.796f620d.cohuck@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Cornelia Huck (cohuck@redhat.com) wrote:
> On Thu, 17 Sep 2020 10:48:28 +0200
> Stefano Garzarella <sgarzare@redhat.com> wrote:
> 
> > On Wed, Sep 16, 2020 at 11:08:48AM +0200, Cornelia Huck wrote:
> > > On Tue, 15 Sep 2020 15:05:14 +0200
> > > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >   
> > > > Commit 9b3a35ec82 ("virtio: verify that legacy support is not accidentally
> > > > on") added a check that returns an error if legacy support is on, but the
> > > > device is not legacy.
> > > > 
> > > > Unfortunately some devices were wrongly declared legacy even if they
> > > > were not (e.g vhost-vsock).
> > > > 
> > > > To avoid migration issues, we disable this error for machine types < 5.1,
> > > > but we print a warning.
> > > > 
> > > > Cc: qemu-stable@nongnu.org
> > > > Fixes: 9b3a35ec82 ("virtio: verify that legacy support is not accidentally on")
> > > > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > v2:
> > > >  - fixed Cornelia's e-mail address
> > > > ---
> > > >  include/hw/virtio/virtio.h |  1 +
> > > >  hw/core/machine.c          |  1 +
> > > >  hw/virtio/virtio.c         | 18 ++++++++++++++++--
> > > >  3 files changed, 18 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > > index 807280451b..ed7cee348b 100644
> > > > --- a/include/hw/virtio/virtio.h
> > > > +++ b/include/hw/virtio/virtio.h
> > > > @@ -103,6 +103,7 @@ struct VirtIODevice
> > > >      bool use_started;
> > > >      bool started;
> > > >      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
> > > > +    bool disable_legacy_check;
> > > >      VMChangeStateEntry *vmstate;
> > > >      char *bus_name;
> > > >      uint8_t device_endian;
> > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > index ea26d61237..b686eab798 100644
> > > > --- a/hw/core/machine.c
> > > > +++ b/hw/core/machine.c
> > > > @@ -44,6 +44,7 @@ GlobalProperty hw_compat_5_0[] = {
> > > >      { "vmport", "x-signal-unsupported-cmd", "off" },
> > > >      { "vmport", "x-report-vmx-type", "off" },
> > > >      { "vmport", "x-cmds-v2", "off" },
> > > > +    { "virtio-device", "x-disable-legacy-check", "true" },  
> > > 
> > > Hm... not sure if we actually should add a new device property for
> > > that. Maybe we can use a flag in the base machine type instead?  
> > 
> > I am not very experienced with machine types.
> > I used the device property to easily access it from virtio devices.
> > 
> > Please, can you give me some suggestions where to look for the flags?
> 
> I was thinking about adding a new virtio_legacy_check flag into
> MachineClass to get a machine-wide config and avoid introducing a new
> config knob. The drawback is that every machine type supporting compat
> machines would need to take care about disabling the check in their
> 5.1-or-older machines themselves.
> 
> Not sure what the preferable solution is; I'm not really opposed to
> your approach, though.

I think a device property is fine - they make it easy to add it to the
global compat list.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


