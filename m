Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24885C33CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E39482072E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 20:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTUNG8Wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39482072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isBkx-0005pQ-3c
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 15:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1isBia-0001NZ-En
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1isBiV-000802-Tr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30731
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1isBiV-0007zX-Py
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 15:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579206371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0rqVGRILNo70f5s2riP8PdeGcTeWDi+5nsXAFTslb3w=;
 b=NTUNG8WjfN3zOvPJAm9WqHh2euboBXVzHBNQYP5W0pFMXlRh2AjLFJhxsSNIzbIbh5AxpH
 pygD0Y3ur9MrJkxC2vDiZrC+IaQd8zvA/fINdT3rVEDlOEw7hbC8Fyu/urIKs9LgtcWwxu
 /qsZrUC77cti7HKWiI3sSjcju1OYqR4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-AOt3LJ4fMHWtTGP2e86tqQ-1; Thu, 16 Jan 2020 15:26:09 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48A521005510;
 Thu, 16 Jan 2020 20:26:08 +0000 (UTC)
Received: from gondolin (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5EBC98177F;
 Thu, 16 Jan 2020 20:26:04 +0000 (UTC)
Date: Thu, 16 Jan 2020 21:26:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PATCH] target/s390x/kvm: Enable adapter interruption
 suppression again
Message-ID: <20200116212601.0fcd3be6.cohuck@redhat.com>
In-Reply-To: <ad421fc1-8241-3c73-e597-aebb3fc8a309@linux.ibm.com>
References: <20200116122026.5804-1-thuth@redhat.com>
 <ad421fc1-8241-3c73-e597-aebb3fc8a309@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: AOt3LJ4fMHWtTGP2e86tqQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 15:19:13 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 1/16/20 7:20 AM, Thomas Huth wrote:
> > The AIS feature has been disabled late in the v2.10 development
> > cycle since there were some issues with migration (see commit
> > 3f2d07b3b01ea61126b - "s390x/ais: for 2.10 stable: disable ais
> > facility"). We originally wanted to enable it again for newer
> > machine types, but apparently we forgot to do this so far. Let's
> > do it for the new s390-ccw-virtio-5.0 machine now.
> > 
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1756946
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   hw/s390x/s390-virtio-ccw.c         |  4 ++++
> >   include/hw/s390x/s390-virtio-ccw.h |  4 ++++
> >   target/s390x/kvm.c                 | 11 ++++++++---
> >   3 files changed, 16 insertions(+), 3 deletions(-)

(...)

> > diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> > index 15260aeb9a..4c1c8c0208 100644
> > --- a/target/s390x/kvm.c
> > +++ b/target/s390x/kvm.c
> > @@ -329,6 +329,8 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
> >   
> >   int kvm_arch_init(MachineState *ms, KVMState *s)
> >   {
> > +    S390CcwMachineClass *smc = S390_CCW_MACHINE_OBJ_GET_CLASS(ms);
> > +  
> 
> I still can't run a proper test due to unavailable hw but in the 
> meantime I tried to virsh define a libvirt guest pointed at qemu (master 
> + this patch).  Regardless of machine type (s390-ccw-virtio-5.0 or 
> s390-ccw-virtio-4.2) I get:
> 
> virsh define guest.xml
> error: Failed to define domain from /path/to/guest.xml
> error: invalid argument: could not find capabilities for arch=s390x 
> domaintype=kvm
> 
> Similarly:
> 
> virsh domcapabilities
> error: failed to get emulator capabilities
> error: invalid argument: unable to find any emulator to serve 's390x' 
> architecture
> 
> Rolling back to qemu master, the define and domcapabilities work (with 
> no ais of course).
> 
> So: there is some incompatibility between the way libvirt invokes qemu 
> to detect capabilities and this code.  The above line seems to be the 
> root problem - if I take your patch and remove 'smc' then libvirt works 
> as expected and I can see ais in the domcapabilities.
> 
> Looking at those wrappers David mentioned...  I suspect you need this 
> for the 'none' machine case.  I tried a quick hack with the following:
> 
> bool ais_allowed(void)
> {
>      /* for "none" machine this results in true */
>      return get_machine_class()->kvm_ais_allowed;
> }
> 
> and
> 
> if (ais_allowed() &&
>      kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
>      kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
> }
> 
> This works and doesn't break libvirt compatibility detection.

Oh, "none" machine fun again... I think you're on the right track, and
we really need a wrapper.


